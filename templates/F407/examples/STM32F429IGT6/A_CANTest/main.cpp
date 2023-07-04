/*
    ChibiOS - Copyright (C) 2006..2018 Giovanni Di Sirio

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

#include "ch.h"
#include "hal.h"

#include "chprintf.h"
#include "shell.h"

#include "usbcfg.h"
#include "can_interface.h"

CANInterface can1(&CAND1);

/*
 * Red LED blinker thread, times are in milliseconds.
 */
static THD_WORKING_AREA(waThread1, 128);
static THD_FUNCTION(Thread1, arg) {

    (void)arg;
    chRegSetThreadName("blinker1");
    while (true) {
        palClearPad(GPIOG, 2U);
        chThdSleepMilliseconds(500);
        palSetPad(GPIOG, 2U);
        chThdSleepMilliseconds(500);
    }
}

/*
 * Green LED blinker thread, times are in milliseconds.
 */
#define SHELL_WA_SIZE   THD_WORKING_AREA_SIZE(2048)
static const ShellCommand commands[] = {
        {NULL, NULL}
};
char completion[40][128] = {{0}};
char histBuffer[64];
static const ShellConfig shell_cfg1 = {
        (BaseSequentialStream *)&SDU1,
        commands,
        histBuffer,
        64,
        (char **)completion
};
THD_WORKING_AREA(wa, 2048);
static THD_WORKING_AREA(waThread2, 128);
static THD_FUNCTION(Thread2, arg) {

    (void)arg;
    chRegSetThreadName("blinker2");
    while (true) {
        palClearPad(GPIOG, 1U);
        chThdSleepMilliseconds(250);
        palSetPad(GPIOG, 1U);
        chThdSleepMilliseconds(250);
    }
}

/*===========================================================================*/
/* Command line related.                                                     */
/*===========================================================================*/



/*===========================================================================*/
/* Initialization and main thread.                                           */
/*===========================================================================*/

static  CANConfig can_cfg = {
        CAN_MCR_ABOM | CAN_MCR_AWUM | CAN_MCR_TXFP,
        CAN_BTR_SJW(0) | CAN_BTR_TS2(3) |
        CAN_BTR_TS1(8) | CAN_BTR_BRP(2)
};
static  SerialConfig SHELL_SERIAL_CONFIG = {115200,
                                              0,
                                              USART_CR2_STOP1_BITS,
                                              0};
/*
 * Application entry point.
 */
static mutex_t printfMutex;
int main(void) {

    /*
     * System initializations.
     * - HAL initialization, this also initializes the configured device drivers
     *   and performs the board-specific initializations.
     * - Kernel initialization, the main() function becomes a thread and the
     *   RTOS is active.
     */
    static CANTxFrame txF;
    txF.SID = 0x1FF;
    txF.IDE = CAN_IDE_STD;
    txF.RTR = CAN_RTR_DATA;
    txF.DLC = 0x08;
    txF.data8[0] = 0x17;
    txF.data8[1] = 0xff;
    txF.data8[2] = 0x17;
    txF.data8[3] = 0x70;
    txF.data8[4] = 0x17;
    txF.data8[5] = 0x70;
    txF.data8[6] = 0x17;
    txF.data8[7] = 0x70;
    halInit();
    chSysInit();

    /*
     * Shell manager initialization.
     */

    /*
     * Initializes a serial-over-USB CDC driver.
     */
    sduObjectInit(&SDU1);
    sduStart(&SDU1, &serusbcfg);

    /*
     * Activates the USB driver and then the USB bus pull-up on D+.
     * Note, a delay is inserted in order to not have to disconnect the cable
     * after a reset.
     */
    usbDisconnectBus(serusbcfg.usbp);
    chThdSleepMilliseconds(1500);
    usbStart(serusbcfg.usbp, &usbcfg);
    usbConnectBus(serusbcfg.usbp);

    shellInit();
    /*
     * Creating the blinker threads.
     */

    chThdCreateStatic(waThread1, sizeof(waThread1),
                      NORMALPRIO + 10, Thread1, NULL);
    chThdCreateStatic(waThread2, sizeof(waThread2),
                      NORMALPRIO + 10, Thread2, NULL);

    can1.start(NORMALPRIO);

    sdStart(&SD1,&SHELL_SERIAL_CONFIG);
#if 1
    chThdCreateStatic(
            wa, sizeof(wa), NORMALPRIO + 1,
            shellThread, (void *) &shell_cfg1);
#else
    while (true) {
        if (SDU1.config->usbp->state == USB_ACTIVE) {
            thread_t *shelltp = chThdCreateFromHeap(NULL, SHELL_WA_SIZE,
                                                    "shell", NORMALPRIO + 1,
                                                    shellThread, (void *)&shell_cfg1);
            chThdWait(shelltp);               /* Waiting termination.             */
        }

        can1.send_msg(&txF);
        chThdSleepMilliseconds(10);

    }
#endif
    /*
     * Normal main() thread activity, spawning shells.
     */
    while (true) {
        can1.send_msg(&txF);
        chThdSleepMilliseconds(10);
    }
}

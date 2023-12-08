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



/*
 * Red LED blinker thread, times are in milliseconds.
 */
static THD_WORKING_AREA(waThread1, 128);
static THD_FUNCTION(Thread1, arg) {

    (void)arg;
    chRegSetThreadName("blinker1");
    while (true) {
        palClearPad(GPIOA, 2U);
        chThdSleepMilliseconds(500);
        palSetPad(GPIOA, 2U);
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
        (BaseSequentialStream *)&SD3,
        commands,
        histBuffer,
        64,
        (char **)completion
};
THD_WORKING_AREA(wa, 512);
static THD_WORKING_AREA(waThread2, 128);
static THD_FUNCTION(Thread2, arg) {

    (void)arg;
    chRegSetThreadName("blinker2");
    while (true) {
        palClearPad(GPIOA, 1U);
        chThdSleepMilliseconds(250);
        palSetPad(GPIOA, 1U);
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

    halInit();
    chSysInit();

    /*
     * Shell manager initialization.
     */



    shellInit();
    /*
     * Creating the blinker threads.
     */

    chThdCreateStatic(waThread1, sizeof(waThread1),
                      NORMALPRIO + 10, Thread1, NULL);
    chThdCreateStatic(waThread2, sizeof(waThread2),
                      NORMALPRIO + 10, Thread2, NULL);


    sdStart(&SD3,&SHELL_SERIAL_CONFIG);
    chprintf((BaseSequentialStream*)&SD3,"Hello\r\n");
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
        chThdSleepMilliseconds(10);
    }
}

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

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "ch.h"
#include "hal.h"
#include "ch.hpp"

#include "shell.h"
#include "chprintf.h"

#include "usbcfg.h"

/*===========================================================================*/
/* Command line related.                                                     */
/*===========================================================================*/

#define SHELL_WA_SIZE   THD_WORKING_AREA_SIZE(2048)


THD_WORKING_AREA(wa, 1024);

static void led_c(BaseSequentialStream* chp,int argc, char *argv[]){
    // l 1 0
    int led;
    int state;
    if(argc==2){
        led = atoi(argv[0]);
        state = atoi(argv[1]);
    }
    chprintf(chp,"Set LED[%d]=%d",led,state);
}
static void servo(BaseSequentialStream* chp,int argc, char *argv[]){
    // servo 0-180
    int angle;
    chprintf(chp,"Arg count:%d",argc);
    if(argc==1){
        angle = atoi(argv[0]);
        chprintf(chp,"Set servo to %d",angle);
        pwmEnableChannel(&PWMD3, 0, PWM_PERCENTAGE_TO_WIDTH(&PWMD3, 250+angle/180.f*1000.f));//250-1250
    }

}
static const ShellCommand commands[] = {
        {"l",led_c},
        {"servo",servo},
        {NULL, NULL}
};

static const ShellConfig shell_cfg1 = {
        (BaseSequentialStream *)&SD1,
        commands
};

/*===========================================================================*/
/* Generic code.                                                             */
/*===========================================================================*/

/*
 * Blinker thread, times are in milliseconds.
 */
static THD_WORKING_AREA(waThread1, 128);
static __attribute__((noreturn)) THD_FUNCTION(Thread1, arg) {
    (void)arg;
    chRegSetThreadName("blinker");
    while (true) {
        systime_t time = serusbcfg.usbp->state == USB_ACTIVE ? 250 : 500;
        palClearPad(GPIOB, GPIOB_LED);
        chThdSleepMilliseconds(time);
        palSetPad(GPIOB, GPIOB_LED);
        chThdSleepMilliseconds(time);
    }
}

/*
 * Application entry point.
 */
static  SerialConfig SHELL_SERIAL_CONFIG = {115200,
                                                     0,
                                                     USART_CR2_STOP1_BITS,
                                                     0};
static PWMConfig pwm_config = {
        10000,
        200, // Default playing_note: 100Hz
        nullptr,
        {
                {PWM_OUTPUT_ACTIVE_HIGH, nullptr},  // it's all CH1 for current support boards
                {PWM_OUTPUT_DISABLED, nullptr},
                {PWM_OUTPUT_DISABLED, nullptr},
                {PWM_OUTPUT_DISABLED, nullptr}
        },
        0,
        0
};
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
    sdStart(&SD1,&SHELL_SERIAL_CONFIG);

    pwmStart(&PWMD3, &pwm_config);
    pwmEnableChannel(&PWMD3, 0, PWM_PERCENTAGE_TO_WIDTH(&PWMD3, 750));
    /*
     * Shell manager initialization.
     */
    shellInit();

    /*
     * Creates the blinker thread.
     */
    chThdCreateStatic(waThread1, sizeof(waThread1), NORMALPRIO, Thread1, NULL);

    /*
     * Normal main() thread activity, spawning shells.
     */
#if 1
    chThdCreateStatic(
            wa, sizeof(wa), LOWPRIO + 1,
            shellThread, (void *) &shell_cfg1);
#else
    while (true) {
        if (SDU1.config->usbp->state == USB_ACTIVE) {
            thread_t *shelltp = chThdCreateFromHeap(NULL, SHELL_WA_SIZE,
                                                    "shell", NORMALPRIO + 1,
                                                    shellThread, (void *)&shell_cfg1);
            chThdWait(shelltp);               /* Waiting termination.             */
        }

        chThdSleepMilliseconds(1000);

    }
#endif
    chThdSetPriority(IDLEPRIO);
}

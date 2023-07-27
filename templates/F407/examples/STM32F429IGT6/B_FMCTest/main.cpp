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
#include "ch.hpp"
#include "fmc.h"
#include "lcd9341.h"
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



static mutex_t printfMutex;
int main(void) {


    halInit();
    chSysInit();

    sduObjectInit(&SDU1);
    sduStart(&SDU1, &serusbcfg);

    usbDisconnectBus(serusbcfg.usbp);
    chThdSleepMilliseconds(1500);
    usbStart(serusbcfg.usbp, &usbcfg);
    usbConnectBus(serusbcfg.usbp);

    shellInit();



    chThdCreateStatic(
            wa, sizeof(wa), NORMALPRIO + 1,
            shellThread, (void *) &shell_cfg1);
    fmcInit();
    lcdInit();
    /*
     * Normal main() thread activity, spawning shells.
     */
    while (true) {
        chThdSleepMilliseconds(10);
    }
}

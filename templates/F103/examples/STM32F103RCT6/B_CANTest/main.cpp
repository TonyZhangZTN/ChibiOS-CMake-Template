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

#include "can_interface.h"

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


static  SerialConfig SHELL_SERIAL_CONFIG = {115200,
                                                     0,
                                                     USART_CR2_STOP1_BITS,
                                                     0};
CANInterface can1(&CAND1);
int main(void) {

    halInit();
    chSysInit();
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
    sdStart(&SD1,&SHELL_SERIAL_CONFIG);
    can1.start(NORMALPRIO);
    shellInit();

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
    while(1){
        can1.send_msg(&txF);
        chThdSleepMilliseconds(10);
    }
    chThdSetPriority(IDLEPRIO);
}

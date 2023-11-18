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
/* Generic code.                                                             */
/*===========================================================================*/

/*
 * Blinker thread, times are in milliseconds.
 */


/*
 * Application entry point.
 */
static PWMConfig pwm_config = {
        10000,
        200, // Default playing_note: 50Hz
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


    pwmStart(&PWMD3, &pwm_config);
    while (true) {
        pwmEnableChannel(&PWMD3, 0, PWM_PERCENTAGE_TO_WIDTH(&PWMD3, 1250));
        chThdSleepMilliseconds(500);
        pwmEnableChannel(&PWMD3, 0, PWM_PERCENTAGE_TO_WIDTH(&PWMD3, 250));
        chThdSleepMilliseconds(500);
    }

}

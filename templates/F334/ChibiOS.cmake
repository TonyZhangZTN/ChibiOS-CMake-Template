set(CHIBIOS ${CMAKE_SOURCE_DIR}/../../ChibiOS)
set(CHIBIOS-Contrib ${CMAKE_SOURCE_DIR}/../../ChibiOS-Contrib)
# Licensing files.
include_directories(${CHIBIOS}/os/license)
# Startup files.
# include $(CHIBIOS)/os/common/startup/ARMCMx/compilers/GCC/mk/startup_stm32f3xx.mk
include_directories(
        ${CHIBIOS}/os/common/portability/GCC
        ${CHIBIOS}/os/common/startup/ARMCMx/compilers/GCC
        ${CHIBIOS}/os/common/startup/ARMCMx/devices/STM32F3xx
        ${CHIBIOS}/os/common/ext/ARM/CMSIS/Core/Include
        ${CHIBIOS}/os/common/ext/ST/STM32F3xx
)
set(
        CHIBIOS_SRC
        ${CHIBIOS_SRC}
        ${CHIBIOS}/os/common/startup/ARMCMx/compilers/GCC/crt1.c
        ${CHIBIOS}/os/common/startup/ARMCMx/compilers/GCC/crt0_v7m.S
        ${CHIBIOS}/os/common/startup/ARMCMx/compilers/GCC/vectors.S
)
# HAL-OSAL files (optional).
#include ${CHIBIOS}/os/hal/hal.mk
include_directories(
        ${CHIBIOS}/os/hal/include
)
set(
        CHIBIOS_SRC
        ${CHIBIOS_SRC}
        ${CHIBIOS}/os/hal/src/hal.c
        ${CHIBIOS}/os/hal/src/hal_st.c
        ${CHIBIOS}/os/hal/src/hal_buffered_serial.c
        ${CHIBIOS}/os/hal/src/hal_buffers.c
        ${CHIBIOS}/os/hal/src/hal_queues.c
        ${CHIBIOS}/os/hal/src/hal_flash.c
        ${CHIBIOS}/os/hal/src/hal_mmcsd.c

        #HAL_USE_ADC
        #${CHIBIOS}/os/hal/src/hal_adc.c
        #HAL_USE_CAN
        ${CHIBIOS}/os/hal/src/hal_can.c
        #HAL_USE_CRY
        #${CHIBIOS}/os/hal/src/hal_crypto.c
        #HAL_USE_DAC
        #${CHIBIOS}/os/hal/src/hal_dac.c
        #HAL_USE_EFL
        #${CHIBIOS}/os/hal/src/hal_efl.c
        #HAL_USE_GPT
        #${CHIBIOS}/os/hal/src/hal_gpt.c
        #HAL_USE_I2C
        #${CHIBIOS}/os/hal/src/hal_i2c.c
        #HAL_USE_I2S
        #${CHIBIOS}/os/hal/src/hal_i2s.c
        #HAL_USE_ICU
        #${CHIBIOS}/os/hal/src/hal_icu.c
        #HAL_USE_MAC
        #${CHIBIOS}/os/hal/src/hal_mac.c
        #HAL_USE_MMC_SPI
        #${CHIBIOS}/os/hal/src/hal_mmc_spi.c
        #HAL_USE_PAL
        ${CHIBIOS}/os/hal/src/hal_pal.c
        #HAL_USE_PWM
        #${CHIBIOS}/os/hal/src/hal_pwm.c
        #HAL_USE_RTC
        #${CHIBIOS}/os/hal/src/hal_rtc.c
        #HAL_USE_SDC
        #${CHIBIOS}/os/hal/src/hal_sdc.c
        #HAL_USE_SERIAL
        ${CHIBIOS}/os/hal/src/hal_serial.c
        #HAL_USE_SERIAL_USB
        #${CHIBIOS}/os/hal/src/hal_serial_usb.c
        #HAL_USE_SIO
        #${CHIBIOS}/os/hal/src/hal_sio.c
        #HAL_USE_SPI
        #${CHIBIOS}/os/hal/src/hal_spi.c
        #HAL_USE_TRNG
        #${CHIBIOS}/os/hal/src/hal_trng.c
        #HAL_USE_UART
        #${CHIBIOS}/os/hal/src/hal_uart.c
        #HAL_USE_USB
        #${CHIBIOS}/os/hal/src/hal_usb.c
        #HAL_USE_WDG
        #${CHIBIOS}/os/hal/src/hal_wdg.c
        #HAL_USE_WSPI
        #${CHIBIOS}/os/hal/src/hal_wspi.c
)


#include $(CHIBIOS)/os/hal/ports/STM32/STM32F3xx/platform.mk
#       include $(CHIBIOS)/os/hal/ports/STM32/LLD/ADCv3/driver.mk
#       include $(CHIBIOS)/os/hal/ports/STM32/LLD/CANv1/driver.mk
#       include $(CHIBIOS)/os/hal/ports/STM32/LLD/DACv1/driver.mk
#       include $(CHIBIOS)/os/hal/ports/STM32/LLD/DMAv1/driver.mk
#       include $(CHIBIOS)/os/hal/ports/STM32/LLD/EXTIv1/driver.mk
#       include $(CHIBIOS)/os/hal/ports/STM32/LLD/GPIOv2/driver.mk
#       include $(CHIBIOS)/os/hal/ports/STM32/LLD/I2Cv2/driver.mk
#       include $(CHIBIOS)/os/hal/ports/STM32/LLD/RTCv2/driver.mk
#       include $(CHIBIOS)/os/hal/ports/STM32/LLD/SPIv2/driver_v2.mk
#       include $(CHIBIOS)/os/hal/ports/STM32/LLD/SYSTICKv1/driver.mk
#       include $(CHIBIOS)/os/hal/ports/STM32/LLD/TIMv1/driver.mk
#       include $(CHIBIOS)/os/hal/ports/STM32/LLD/USARTv2/driver.mk
#       include $(CHIBIOS)/os/hal/ports/STM32/LLD/USBv1/driver.mk
#       include $(CHIBIOS)/os/hal/ports/STM32/LLD/xWDGv1/driver.mk
include_directories(
        #platform.mk
        ${CHIBIOS}/os/hal/ports/common/ARMCMx
        ${CHIBIOS}/os/hal/ports/STM32/STM32F3xx
        #ADCv3/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/ADCv3
        #CANv1/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/CANv1
        #DACv1/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/DACv1
        #DMAv2/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/DMAv1
        #EXTIv1/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/EXTIv1
        #GPIOv2/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/GPIOv2
        #I2Cv2/driver.mk
        #Don't use fallback, that is software fallback for I2C
        ${CHIBIOS}/os/hal/ports/STM32/LLD/I2Cv2
        #RTCv2/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/RTCv2
        #SPIv2/driver_v2.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/SPIv2
        #SYSTICKv1/driver.
        ${CHIBIOS}/os/hal/ports/STM32/LLD/SYSTICKv1
        #TIMv1/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/TIMv1
        #USARTv2/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/USART
        ${CHIBIOS}/os/hal/ports/STM32/LLD/USARTv2
        #USBv1/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/USBv1
        #xWDGv1/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/xWDGv1
)
set(
        CHIBIOS_SRC
        ${CHIBIOS_SRC}
        #platform.mk
        ${CHIBIOS}/os/hal/ports/common/ARMCMx/nvic.c
        ${CHIBIOS}/os/hal/ports/STM32/STM32F3xx/stm32_isr.c
        ${CHIBIOS}/os/hal/ports/STM32/STM32F3xx/hal_lld.c
        ${CHIBIOS}/os/hal/ports/STM32/STM32F3xx/hal_efl_lld.c
        #ADCv3/driver.mk
        #HAL_USE_ADC
        #${CHIBIOS}/os/hal/ports/STM32/LLD/ADCv3/hal_adc_lld.c
        #CANv1/driver.mk
        #HAL_USE_CAN
        ${CHIBIOS}/os/hal/ports/STM32/LLD/CANv1/hal_can_lld.c
        #DACv1/driver.mk
        #HAL_USE_DAC
        #${CHIBIOS}/os/hal/ports/STM32/LLD/DACv1/hal_dac_lld.c
        #DMAv1/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/DMAv1/stm32_dma.c
        #EXTIv1/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/EXTIv1/stm32_exti.c
        #GPIOv2/driver.mk
        #HAL_USE_PAL
        ${CHIBIOS}/os/hal/ports/STM32/LLD/GPIOv2/hal_pal_lld.c
        #I2Cv2/driver.mk
        #HAL_USE_I2C
        #${CHIBIOS}/os/hal/ports/STM32/LLD/I2Cv2/hal_i2c_lld.c
        #RTCv2/driver.mk
        #HAL_USE_RTC
        #${CHIBIOS}/os/hal/ports/STM32/LLD/RTCv2/hal_rtc_lld.c
        #SPIv2/driver_v2.mk
        #HAL_USE_I2S
        #${CHIBIOS}/os/hal/ports/STM32/LLD/SPIv2/hal_i2s_lld.c
        #HAL_USE_SPI
        #${CHIBIOS}/os/hal/ports/STM32/LLD/SPIv2/hal_spi_v2_lld.c

        #SYSTICKv1/driver.
        ${CHIBIOS}/os/hal/ports/STM32/LLD/SYSTICKv1/hal_st_lld.c
        #TIMv1/driver.mk
        #HAL_USE_GPT
        #${CHIBIOS}/os/hal/ports/STM32/LLD/TIMv1/hal_gpt_lld.c
        #HAL_USE_ICU
        #${CHIBIOS}/os/hal/ports/STM32/LLD/TIMv1/hal_icu_lld.c
        #HAL_USE_PWM
        #${CHIBIOS}/os/hal/ports/STM32/LLD/TIMv1/hal_pwm_lld.c
        #USARTv2/driver.mk
        #HAL_USE_SERIAL
        ${CHIBIOS}/os/hal/ports/STM32/LLD/USARTv2/hal_serial_lld.c
        #HAL_USE_SIO
        #${CHIBIOS}/os/hal/ports/STM32/LLD/USARTv2/hal_sio_lld.c
        #HAL_USE_UART
        #${CHIBIOS}/os/hal/ports/STM32/LLD/USARTv2/hal_uart_lld.c
        #USBv1/driver.mk
        #HAL_USE_USB
        #${CHIBIOS}/os/hal/ports/STM32/LLD/USBv1/hal_usb_lld.c
        #xWDGv1/driver.mk
        #HAL_USE_WDG
        #${CHIBIOS}/os/hal/ports/STM32/LLD/xWDGv1/hal_wdg_lld.c

)
#include $(CHIBIOS)/os/hal/boards/ST_STM32F334_DISCOVERY/board.mk
# Just copied that board.c to the examples dir

#include ${CHIBIOS}/os/hal/osal/rt-nil/osal.mk
include_directories(
        ${CHIBIOS}/os/hal/osal/rt-nil
)
set(
        CHIBIOS_SRC
        ${CHIBIOS_SRC}
        ${CHIBIOS}/os/hal/osal/rt-nil/osal.c
)

#include ${CHIBIOS}/os/rt/rt.mk
include_directories(
        ${CHIBIOS}/os/rt/include
)
set(
        CHIBIOS_SRC
        ${CHIBIOS_SRC}
        ${CHIBIOS}/os/rt/src/chsys.c
        ${CHIBIOS}/os/rt/src/chrfcu.c
        ${CHIBIOS}/os/rt/src/chdebug.c
        ${CHIBIOS}/os/rt/src/chtrace.c
        ${CHIBIOS}/os/rt/src/chvt.c
        ${CHIBIOS}/os/rt/src/chschd.c
        ${CHIBIOS}/os/rt/src/chinstances.c
        ${CHIBIOS}/os/rt/src/chthreads.c
        # CH_CFG_USE_TM
        ${CHIBIOS}/os/rt/src/chtm.c
        #CH_DBG_STATISTICS=FALSE
        #${CHIBIOS}/os/rt/src/chstats.c
        # CH_CFG_USE_REGISTRY
        ${CHIBIOS}/os/rt/src/chregistry.c
        # CH_CFG_USE_SEMAPHORES
        ${CHIBIOS}/os/rt/src/chsem.c
        # CH_CFG_USE_MUTEXES
        ${CHIBIOS}/os/rt/src/chmtx.c
        # CH_CFG_USE_CONDVARS
        ${CHIBIOS}/os/rt/src/chcond.c
        # CH_CFG_USE_EVENTS
        ${CHIBIOS}/os/rt/src/chevents.c
        # CH_CFG_USE_MESSAGES
        ${CHIBIOS}/os/rt/src/chmsg.c
        # CH_CFG_USE_DYNAMIC
        ${CHIBIOS}/os/rt/src/chdynamic.c
)
#   include ${CHIBIOS}/os/oslib/oslib.mk
include_directories(
        ${CHIBIOS}/os/oslib/include
)
set(
        CHIBIOS_SRC
        ${CHIBIOS_SRC}
        # CH_CFG_USE_MAILBOXES
        ${CHIBIOS}/os/oslib/src/chmboxes.c
        # CH_CFG_USE_MEMCORE
        ${CHIBIOS}/os/oslib/src/chmemcore.c
        # CH_CFG_USE_HEAP
        ${CHIBIOS}/os/oslib/src/chmemheaps.c
        # CH_CFG_USE_MEMPOOLS
        ${CHIBIOS}/os/oslib/src/chmempools.c
        # CH_CFG_USE_PIPES
        ${CHIBIOS}/os/oslib/src/chpipes.c
        # CH_CFG_USE_OBJ_CACHES
        ${CHIBIOS}/os/oslib/src/chobjcaches.c
        # CH_CFG_USE_DELEGATES
        ${CHIBIOS}/os/oslib/src/chdelegates.c
        # CH_CFG_USE_FACTORY
        ${CHIBIOS}/os/oslib/src/chfactory.c
)
#include ${CHIBIOS}/os/common/ports/ARMv7-M/compilers/GCC/mk/port.mk
include_directories(
        ${CHIBIOS}/os/common/portability/GCC
        ${CHIBIOS}/os/common/ports/ARM-common
        ${CHIBIOS}/os/common/ports/ARMv7-M
)
set(
        CHIBIOS_SRC
        ${CHIBIOS_SRC}
        ${CHIBIOS}/os/common/ports/ARMv7-M/chcore.c
        ${CHIBIOS}/os/common/ports/ARMv7-M/compilers/GCC/chcoreasm.S
)

#include ${CHIBIOS}/os/hal/lib/streams/streams.mk
include_directories(
        ${CHIBIOS}/os/hal/lib/streams
)
set(
        CHIBIOS_SRC
        ${CHIBIOS_SRC}
        ${CHIBIOS}/os/hal/lib/streams/chprintf.c
        ${CHIBIOS}/os/hal/lib/streams/chscanf.c
        ${CHIBIOS}/os/hal/lib/streams/memstreams.c
        ${CHIBIOS}/os/hal/lib/streams/nullstreams.c
        ${CHIBIOS}/os/hal/lib/streams/bufstreams.c
)

#include ${CHIBIOS}/os/various/shell/shell.mk
include_directories(
        ${CHIBIOS}/os/various/shell
)
set(
        CHIBIOS_SRC
        ${CHIBIOS_SRC}
        ${CHIBIOS}/os/various/shell/shell.c
        ${CHIBIOS}/os/various/shell/shell_cmd.c
)
#cpp wrapper
include_directories(
        ${CHIBIOS}/os/various/cpp_wrappers
)
set(
        CHIBIOS_SRC
        ${CHIBIOS_SRC}
        ${CHIBIOS}/os/various/syscalls.c
        ${CHIBIOS}/os/various/cpp_wrappers/ch.cpp
)
#below is ChibiOS-Contrib related
#include_directories(
#        ${CHIBIOS-Contrib}/os/various/cpp_wrappers
#)
#set(
#        CHIBIOS_SRC
#        ${CHIBIOS_SRC}
#        ${CHIBIOS}/os/various/syscalls.c
#        ${CHIBIOS}/os/various/cpp_wrappers/ch.cpp
#)
#include_directories(
#        ${CHIBIOS}/os/various/cpp_wrappers
#)
#set(
#        CHIBIOS_SRC
#        ${CHIBIOS_SRC}
#        ${CHIBIOS}/os/various/syscalls.c
#        ${CHIBIOS}/os/various/cpp_wrappers/ch.cpp
#)
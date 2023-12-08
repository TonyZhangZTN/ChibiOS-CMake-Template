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

        #${CHIBIOS}/os/hal/src/hal_adc.c
        ${CHIBIOS}/os/hal/src/hal_can.c
        #${CHIBIOS}/os/hal/src/hal_crypto.c
        #${CHIBIOS}/os/hal/src/hal_dac.c
        #${CHIBIOS}/os/hal/src/hal_efl.c
        #${CHIBIOS}/os/hal/src/hal_gpt.c
        #${CHIBIOS}/os/hal/src/hal_i2c.c
        #${CHIBIOS}/os/hal/src/hal_i2s.c
        #${CHIBIOS}/os/hal/src/hal_icu.c
        #${CHIBIOS}/os/hal/src/hal_mac.c
        #${CHIBIOS}/os/hal/src/hal_mmc_spi.c
        ${CHIBIOS}/os/hal/src/hal_pal.c
        ${CHIBIOS}/os/hal/src/hal_pwm.c
        #${CHIBIOS}/os/hal/src/hal_rtc.c
        #${CHIBIOS}/os/hal/src/hal_sdc.c
        ${CHIBIOS}/os/hal/src/hal_serial.c
        ${CHIBIOS}/os/hal/src/hal_serial_usb.c
        #${CHIBIOS}/os/hal/src/hal_sio.c
        #${CHIBIOS}/os/hal/src/hal_spi.c
        #${CHIBIOS}/os/hal/src/hal_trng.c
        ${CHIBIOS}/os/hal/src/hal_uart.c
        ${CHIBIOS}/os/hal/src/hal_usb.c
        #${CHIBIOS}/os/hal/src/hal_wdg.c
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
        ${CHIBIOS}/os/hal/ports/STM32/LLD/ADCv3/hal_adc_lld.c
        #CANv1/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/CANv1/hal_can_lld.c
        #DACv1/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/DACv1/hal_dac_lld.c
        #DMAv1/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/DMAv1/stm32_dma.c
        #EXTIv1/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/EXTIv1/stm32_exti.c
        #GPIOv2/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/GPIOv2/hal_pal_lld.c
        #I2Cv2/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/I2Cv2/hal_i2c_lld.c
        #RTCv2/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/RTCv2/hal_rtc_lld.c
        #SPIv2/driver_v2.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/SPIv2/hal_i2s_lld.c
        ${CHIBIOS}/os/hal/ports/STM32/LLD/SPIv2/hal_spi_v2_lld.c

        #SYSTICKv1/driver.
        ${CHIBIOS}/os/hal/ports/STM32/LLD/SYSTICKv1/hal_st_lld.c
        #TIMv1/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/TIMv1/hal_gpt_lld.c
        ${CHIBIOS}/os/hal/ports/STM32/LLD/TIMv1/hal_icu_lld.c
        ${CHIBIOS}/os/hal/ports/STM32/LLD/TIMv1/hal_pwm_lld.c
        #USARTv2/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/USARTv2/hal_serial_lld.c
        ${CHIBIOS}/os/hal/ports/STM32/LLD/USARTv2/hal_sio_lld.c
        ${CHIBIOS}/os/hal/ports/STM32/LLD/USARTv2/hal_uart_lld.c
        #USBv1/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/USBv1/hal_usb_lld.c
        #xWDGv1/driver.mk
        ${CHIBIOS}/os/hal/ports/STM32/LLD/xWDGv1/hal_wdg_lld.c

)

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
        ${CHIBIOS}/os/rt/src/chtm.c

        #define CH_DBG_STATISTICS                   FALSE
        #${CHIBIOS}/os/rt/src/chstats.c
        ${CHIBIOS}/os/rt/src/chregistry.c
        ${CHIBIOS}/os/rt/src/chsem.c
        ${CHIBIOS}/os/rt/src/chmtx.c
        ${CHIBIOS}/os/rt/src/chcond.c
        ${CHIBIOS}/os/rt/src/chevents.c
        ${CHIBIOS}/os/rt/src/chmsg.c
        ${CHIBIOS}/os/rt/src/chdynamic.c
)
#   include ${CHIBIOS}/os/oslib/oslib.mk
include_directories(
        ${CHIBIOS}/os/oslib/include
)
set(
        CHIBIOS_SRC
        ${CHIBIOS_SRC}
        ${CHIBIOS}/os/oslib/src/chmboxes.c
        ${CHIBIOS}/os/oslib/src/chmemcore.c
        ${CHIBIOS}/os/oslib/src/chmemheaps.c
        ${CHIBIOS}/os/oslib/src/chmempools.c
        ${CHIBIOS}/os/oslib/src/chpipes.c
        ${CHIBIOS}/os/oslib/src/chobjcaches.c
        ${CHIBIOS}/os/oslib/src/chdelegates.c
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
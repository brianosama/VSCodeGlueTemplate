cmake_minimum_required(VERSION 3.20)
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/gnu-arm-toolchain.cmake)
get_filename_component(PROJECT_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME)

###################### VARIABLES ######################################
#set (PROJECT_NAME   "TestCMAKE")
set (PROJECT_TYPE   "exe")
set (LINKER_SCRIPT  "${CMAKE_SOURCE_DIR}/DFP/Source/GCC/ADuCM3029.ld")
set (MCPU           "-mcpu=cortex-m3")
#set (MFPU           "-mfpu=fpv4-sp-d16")
set (MFPU           "")
set (MFLOAT_ABI     "")

set (RUNTIME_LIBRARY          "--specs=nano.specs")
set (RUNTIME_LIBRARY_SYSCALLS "--specs=nosys.specs")


set (PROJECT_SOURCES
	# LIST SOURCE FILES HERE
	main.c
    syscalls.c
    ${CMAKE_SOURCE_DIR}/DFP/Source/GCC/startup_ADuCM3029.c
    ${CMAKE_SOURCE_DIR}/DFP/Source/system_ADuCM3029.c
    ${CMAKE_SOURCE_DIR}/DFP/Source/common.c
    ${CMAKE_SOURCE_DIR}/DFP/Source/adi_cyclecount.c
    #${CMAKE_SOURCE_DIR}/DFP/Source/drivers/adc/adi_adc.c
    #${CMAKE_SOURCE_DIR}/DFP/Source/drivers/beep/adi_beep.c
    #${CMAKE_SOURCE_DIR}/DFP/Source/drivers/crc/adi_crc.c
    #${CMAKE_SOURCE_DIR}/DFP/Source/drivers/crypto/adi_crypto.c
    #${CMAKE_SOURCE_DIR}/DFP/Source/drivers/dma/adi_dma.c
    #${CMAKE_SOURCE_DIR}/DFP/Source/drivers/flash/adi_flash.c
    ${CMAKE_SOURCE_DIR}/DFP/Source/drivers/gpio/adi_gpio.c
    #${CMAKE_SOURCE_DIR}/DFP/Source/drivers/i2c/adi_i2c.c
    ${CMAKE_SOURCE_DIR}/DFP/Source/drivers/pwr/adi_pwr.c
    #${CMAKE_SOURCE_DIR}/DFP/Source/drivers/rng/adi_rng.c
    #${CMAKE_SOURCE_DIR}/DFP/Source/drivers/rtc/adi_rtc.c  
    #${CMAKE_SOURCE_DIR}/DFP/Source/drivers/spi/adi_spi.c
    #${CMAKE_SOURCE_DIR}/DFP/Source/drivers/sport/adi_sport.c
    #${CMAKE_SOURCE_DIR}/DFP/Source/drivers/tmr/adi_tmr.c    
    #${CMAKE_SOURCE_DIR}/DFP/Source/drivers/uart/adi_uart.c
    #${CMAKE_SOURCE_DIR}/DFP/Source/drivers/wdt/adi_wdt.c
    #${CMAKE_SOURCE_DIR}/DFP/Source/drivers/xint/adi_xint.c 

	)

set (PROJECT_DEFINES
	# LIST COMPILER DEFINITIONS HERE
    __ADUCM3029__ 
    __CORTEX_M3
    #_RTE_

    )

set (PROJECT_INCLUDES
	# LIST INCLUDE DIRECTORIES HERE
    ${CMAKE_SOURCE_DIR}/DFP/Include/
    ${CMAKE_SOURCE_DIR}/DFP/Include/config/
    ${CMAKE_SOURCE_DIR}/CMSIS/Include/
    ${CMAKE_SOURCE_DIR}/

    )

################## PROJECT SETUP ######################################

project(${PROJECT_NAME} C)
enable_language(ASM)

add_executable(${PROJECT_NAME} ${PROJECT_SOURCES})
add_custom_command(TARGET ${CMAKE_PROJECT_NAME} POST_BUILD 
        COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${CMAKE_PROJECT_NAME}>
        COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${CMAKE_PROJECT_NAME}> ${CMAKE_PROJECT_NAME}.hex

        )

add_compile_definitions (${PROJECT_DEFINES})
include_directories (${PROJECT_INCLUDES})

set (CMAKE_EXECUTABLE_SUFFIX ".elf")
set (CMAKE_STATIC_LIBRARY_SUFFIX ".a")
set (CMAKE_C_FLAGS "${MCPU} -std=gnu99 ${MFPU} ${MFLOAT_ABI} ${RUNTIME_LIBRARY} -mthumb -Os -Wall -Werror -fmessage-length=0 -fno-exceptions -fno-builtin -ffunction-sections -fdata-sections -funsigned-char -MMD -fno-delete-null-pointer-checks -fomit-frame-pointer")
set (CMAKE_EXE_LINKER_FLAGS "-T${LINKER_SCRIPT} ${RUNTIME_LIBRARY_SYSCALLS} -Wl,-Map=${CMAKE_PROJECT_NAME}.map -Wl,--gc-sections -static -Wl,--start-group -lc -lm -Wl,--end-group")
set (CMAKE_ASM_FLAGS "${CMAKE_C_FLAGS} -x assembler-with-cpp -mthumb -Os -Wall -Werror -fmessage-length=0 -fno-exceptions -fno-builtin -ffunction-sections -fdata-sections -funsigned-char -MMD -fno-delete-null-pointer-checks -fomit-frame-pointer")

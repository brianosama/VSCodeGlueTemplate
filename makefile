###############################################################################
# Boiler-plate

# cross-platform directory manipulation
ifeq ($(shell echo $$OS),$$OS)
    MAKEDIR = if not exist "$(1)" mkdir "$(1)"
    RM = rmdir /S /Q "$(1)"
else
    MAKEDIR = '$(SHELL)' -c "mkdir -p \"$(1)\""
    RM = '$(SHELL)' -c "rm -rf \"$(1)\""
endif

OBJDIR := BUILD
# Move to the build directory
ifeq (,$(filter $(OBJDIR),$(notdir $(CURDIR))))
.SUFFIXES:
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
MAKETARGET = '$(MAKE)' --no-print-directory -C $(OBJDIR) -f '$(mkfile_path)' \
		'SRCDIR=$(CURDIR)' $(MAKECMDGOALS)
.PHONY: $(OBJDIR) clean
all:
	+@$(call MAKEDIR,$(OBJDIR))
	+@$(MAKETARGET)
$(OBJDIR): all
Makefile : ;
% :: $(OBJDIR) ; :
clean :
	$(call RM,$(OBJDIR))

else

# trick rules into thinking we are in the root, when we are in the bulid dir
VPATH = ..

# Boiler-plate
###############################################################################
# Project settings

PROJECT := GlueTemplate
TOOLCHAIN_DIR := D:/ARM/gcc-arm-none-eabi-5_4-2016q3-20160926-win32/bin

# Project settings
###############################################################################
# Objects and Paths

SOURCEDIR := ..

SOURCES += $(SOURCEDIR)/main.c
SOURCES += $(SOURCEDIR)/BSP/Source/common.c
SOURCES += $(SOURCEDIR)/BSP/Source/system_ADuCM3029.c
SOURCES += $(SOURCEDIR)/BSP/Source/GCC/startup_ADuCM3029.c

#SOURCES += $(SOURCEDIR)/BSP/Source/GCC/reset_ADuCM3029.S

SOURCES += $(SOURCEDIR)/BSP/Source/drivers/adc/adi_adc.c
SOURCES += $(SOURCEDIR)/BSP/Source/drivers/beep/adi_beep.c
SOURCES += $(SOURCEDIR)/BSP/Source/drivers/crc/adi_crc.c
#SOURCES += $(SOURCEDIR)/BSP/Source/drivers/crypto/adi_crypto.c
SOURCES += $(SOURCEDIR)/BSP/Source/drivers/dma/adi_dma.c
SOURCES += $(SOURCEDIR)/BSP/Source/drivers/flash/adi_flash.c
SOURCES += $(SOURCEDIR)/BSP/Source/drivers/gpio/adi_gpio.c
SOURCES += $(SOURCEDIR)/BSP/Source/drivers/i2c/adi_i2c.c
SOURCES += $(SOURCEDIR)/BSP/Source/drivers/pwr/adi_pwr.c
SOURCES += $(SOURCEDIR)/BSP/Source/drivers/rng/adi_rng.c
SOURCES += $(SOURCEDIR)/BSP/Source/drivers/rtc/adi_rtc.c
SOURCES += $(SOURCEDIR)/BSP/Source/drivers/spi/adi_spi.c
SOURCES += $(SOURCEDIR)/BSP/Source/drivers/sport/adi_sport.c
SOURCES += $(SOURCEDIR)/BSP/Source/drivers/tmr/adi_tmr.c
SOURCES += $(SOURCEDIR)/BSP/Source/drivers/uart/adi_uart.c
SOURCES += $(SOURCEDIR)/BSP/Source/drivers/wdt/adi_wdt.c
SOURCES += $(SOURCEDIR)/BSP/Source/drivers/xint/adi_xint.c

_OBJS := $(SOURCES:.c=.o)
OBJECTS :=  $(subst ../,,$(_OBJS))

INCLUDE_PATHS += -I$(SOURCEDIR)/
INCLUDE_PATHS += -I$(SOURCEDIR)/.
INCLUDE_PATHS += -I$(SOURCEDIR)/CMSIS/Include
INCLUDE_PATHS += -I$(SOURCEDIR)/BSP/Include
INCLUDE_PATHS += -I$(SOURCEDIR)/BSP/Include/config

LIBRARY_PATHS :=
LIBRARIES :=
LINKER_SCRIPT ?= ./BSP/Source/GCC/ADuCM3029.ld

# Objects and Paths
###############################################################################
# Tools and Flags

AS      = '$(TOOLCHAIN_DIR)/arm-none-eabi-gcc' '-x' 'assembler-with-cpp' '-c' '-Wall' '-Wextra' '-Wno-unused-parameter' '-Wno-missing-field-initializers' '-fmessage-length=0' '-fno-exceptions' '-fno-builtin' '-ffunction-sections' '-fdata-sections' '-funsigned-char' '-MMD' '-fno-delete-null-pointer-checks' '-fomit-frame-pointer' '-Os' '-g1' '-mcpu=cortex-m3' '-mthumb'
CC      = '$(TOOLCHAIN_DIR)/arm-none-eabi-gcc' '-std=gnu99' '-c' '-Wall' '-Wextra' '-Wno-unused-parameter' '-Wno-missing-field-initializers' '-fmessage-length=0' '-fno-exceptions' '-fno-builtin' '-ffunction-sections' '-fdata-sections' '-funsigned-char' '-MMD' '-fno-delete-null-pointer-checks' '-fomit-frame-pointer' '-Os' '-g1' '-mcpu=cortex-m3' '-mthumb'
CPP     = '$(TOOLCHAIN_DIR)/arm-none-eabi-g++' '-std=gnu++98' '-fno-rtti' '-Wvla' '-c' '-Wall' '-Wextra' '-Wno-unused-parameter' '-Wno-missing-field-initializers' '-fmessage-length=0' '-fno-exceptions' '-fno-builtin' '-ffunction-sections' '-fdata-sections' '-funsigned-char' '-MMD' '-fno-delete-null-pointer-checks' '-fomit-frame-pointer' '-Os' '-g1' '-mcpu=cortex-m3' '-mthumb'
LD      = '$(TOOLCHAIN_DIR)/arm-none-eabi-gcc'
ELF2BIN = '$(TOOLCHAIN_DIR)/arm-none-eabi-objcopy'
PREPROC = '$(TOOLCHAIN_DIR)/arm-none-eabi-cpp' '-E' '-P' '-Wl,--gc-sections' '-Wl,--wrap,main' '-Wl,--wrap,_malloc_r' '-Wl,--wrap,_free_r' '-Wl,--wrap,_realloc_r' '-Wl,--wrap,_memalign_r' '-Wl,--wrap,_calloc_r' '-Wl,--wrap,exit' '-Wl,--wrap,atexit' '-Wl,-n' '-mcpu=cortex-m3' '-mthumb'

C_FLAGS = '-std=gnu99' '-D__ADUCM3029__' '-D__CORTEX_M3' '-D_RTE_'
CXX_FLAGS = '-std=gnu99' '-D__ADUCM3029__' '-D__CORTEX_M3' '-D_RTE_' 
ASM_FLAGS = '-D__ADUCM3029__' '-D_RTE_' 

#LD_FLAGS :=-Wl,--gc-sections -Wl,--wrap,main -Wl,--wrap,_malloc_r -Wl,--wrap,_free_r -Wl,--wrap,_realloc_r -Wl,--wrap,_memalign_r -Wl,--wrap,_calloc_r -Wl,--wrap,exit -Wl,--wrap,atexit -Wl,-n -mcpu=cortex-m3 -mthumb 
LD_FLAGS :=-Wl,--gc-sections -Wl,-n -mcpu=cortex-m3 -mthumb 
LD_SYS_LIBS :=-Wl,--start-group -lstdc++ -lsupc++ -lm -lc -lgcc -lnosys  -Wl,--end-group

# Tools and Flags
###############################################################################
# Rules

.PHONY: all lst size

all: $(PROJECT).bin $(PROJECT).hex size

.s.o:
	+@$(call MAKEDIR,$(dir $@))
	+@echo "Assemble: $(notdir $<)"
  
	@$(AS) -c $(ASM_FLAGS) -o $@ $<
  


.S.o:
	+@$(call MAKEDIR,$(dir $@))
	+@echo "Assemble: $(notdir $<)"
  
	@$(AS) -c $(ASM_FLAGS) -o $@ $<
  

.c.o:
	+@$(call MAKEDIR,$(dir $@))
	+@echo "Compile: $(notdir $<)"
	@$(CC) $(C_FLAGS) $(INCLUDE_PATHS) -o $@ $<

.cpp.o:
	+@$(call MAKEDIR,$(dir $@))
	+@echo "Compile: $(notdir $<)"
	@$(CPP) $(CXX_FLAGS) $(INCLUDE_PATHS) -o $@ $<


$(PROJECT).link_script.ld: $(LINKER_SCRIPT)
	@$(PREPROC) $< -o $@

$(PROJECT).elf: $(OBJECTS) $(SYS_OBJECTS) $(PROJECT).link_script.ld 
	+@echo "link: $(notdir $@)"
	@$(LD) $(LD_FLAGS) -T $(filter-out %.o, $^) $(LIBRARY_PATHS) --output $@ $(filter %.o, $^) $(LIBRARIES) $(LD_SYS_LIBS)

$(PROJECT).bin: $(PROJECT).elf
	$(ELF2BIN) -O binary $< $@
	+@echo "===== bin file ready to flash: $(OBJDIR)/$@ =====" 

$(PROJECT).hex: $(PROJECT).elf
	$(ELF2BIN) -O ihex $< $@


# Rules
###############################################################################
# Dependencies

DEPS = $(OBJECTS:.o=.d) $(SYS_OBJECTS:.o=.d)
-include $(DEPS)
endif

# Dependencies
###############################################################################

# Visual Studio Code Template for ADuCM302x/ADuCM4x50 development

Project template to start developing with ADuCM302x microcontrollers.
Included in this template is the board support package of ADuCM302x microcontroller from Analog Devices Inc. and other libraries such as CMSIS.

# Using the Template
    W.I.P

# Includes 
    DFP 3.2.1 (ADuCM302x)
    CMSIS 5.2
    VSCode file for Intellisense, build settings and debug settings.

# Requirements

    * cmake or make - via Winget
    * arm-none-eabi toolchain (14.1) - via Winget
    * vscode
    * Cortex-Debug plugin
    * openocd 0.12

# Release History

- 2025.07.07: 
  - DFP 3.2.1 
  - Updated vscode json files
  - Move debug tool from cppdebug to cortex-debug
  - added cmakelists.txt
  - added syscalls.c for mock implementation of sys functions

- 2018:
  - DFP 3.1.0 
  - CMSIS 5.2
  - VSCode file for Intellisense, build settings and debug settings.
  - makefile for compiling project


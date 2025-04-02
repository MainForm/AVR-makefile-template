This repo is for compiling and debugging 8bit avr mcu.

Package that need to be install
 - avr-toolchain
 - avrdude
 - avarice

Environment variables that need to be set in makefile
 - F_CPU : mcu frequency
 - MCU : mcu you are developing
 - AD_PART : mcu to upload hex file (you need to check the list of AD_PART by script 'avrdude -p ?')
 - AD_PROG : programmer that you are using for uploading hex file to mcu (you need to check the list of AD_PART by script 'avrdude -c ?')
 - AD_PORT : device that you connect programmer to pc

File tree
--- build : folder for output file
 |- src : folder for source files
 |- include : folder for header files

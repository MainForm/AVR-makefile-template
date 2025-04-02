MCU = atmega128a
F_CPU = 16000000UL

# Parts can be found by script avrdude -p ?
AD_PART = m128a
# Programmer can be found by script avrdude -c ?
AD_PROG = stk500v2
#AD_PROG = jtag1

# Port can be found by script ls /dev/tty.*
AD_PORT = /dev/tty.usbmodem00000000000011
#AD_PORT = /dev/tty.usbserial-110

CC := avr-gcc
CXX := avr-g++
AD := avrdude
GDB := avr-gdb
AVRICE := avarice
OBJCOPY := avr-objcopy

GDB_IP := localhost
GDB_PORT := 4242

TARGET = $(BUILD_DIR)/out

SRC_DIR := ./src
BUILD_DIR := ./build
INCLUDE_DIR = -I./include

CFLAGS = -Wall -Os -g -mmcu=$(MCU) -DF_CPU=$(F_CPU)

C_SRCS = $(shell find $(SRC_DIR) -name '*.c')
C_OBJS = $(C_SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)

CXX_SRCS = $(shell find $(SRC_DIR) -name '*.cpp')
CXX_OBJS = $(CXX_SRCS:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)

SECTIONS := -j .text -j .data

.PHONY: all clean upload debug avarice
all: $(TARGET).hex

$(TARGET).hex: $(TARGET).bin
	$(OBJCOPY) $(SECTIONS) -O ihex $< $@

$(TARGET).bin: $(C_OBJS) $(CXX_OBJS)
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CFLAGS) $^ -o $@

# compile .c files to .o files
$(C_OBJS): $(C_SRCS)
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CFLAGS) $(INCLUDE_DIR) -c $< -o $@

# compile .cpp files to .o files
$(CXX_OBJS): $(CXX_SRCS)
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CFLAGS) $(INCLUDE_DIR) -c $< -o $@

clean:
	rm -rf $(BUILD_DIR)

upload: $(TARGET).hex
	$(AD) -p $(AD_PART) -c $(AD_PROG) -P $(AD_PORT) -U flash:w:$<

debug: $(TARGET).bin
# run avarice in background for making gdb server
# avarice will be killed when connection of gdb is disconnected
	$(AVRICE) --jtag $(AD_PORT) :$(GDB_PORT)	&
	$(GDB) -ex 'target remote $(GDB_IP):$(GDB_PORT)' $(TARGET).bin

avarice:
	$(AVRICE) --jtag $(AD_PORT) :$(GDB_PORT)
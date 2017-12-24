EXT_MUSL = $(EXT_DIR)/musl

CC   = $(EXT_MUSL)/bin/musl-gcc
LD   ?= ld
AR   ?= ar
NASM ?= nasm

OS_NAME    = utero
BUILD_DIR  = build
BUILD_DIRS = $(dir $(OBJECTS) $(SOURCES) $(CRYSTAL_SOURCES))
EXT_DIR    = ext
LINKER     = linker.ld
ISO_DIR    = $(BUILD_DIR)/isofiles
KERNEL_DIR = $(ISO_DIR)/boot
GRUB_DIR   = $(KERNEL_DIR)/grub
KERNEL     = $(KERNEL_DIR)/kernel.bin
ISO        = $(BUILD_DIR)/$(OS_NAME).iso
LIB        = $(BUILD_DIR)/lib$(OS_NAME).a
CRYSTAL_OS = $(filter %main.o,$(CRYSTAL_SOURCES))

ARCH ?= x86_64
TARGET ?= $(ARCH)-unknown-linux-musl

OBJECTS := $(patsubst %.asm,build/%.o,$(shell find asm -name '*.asm'))
SOURCES := $(patsubst %.c,build/%.o,$(shell find src -name '*.c'))
CRYSTAL_SOURCES := $(patsubst %.cr,build/%.o,$(shell find src -name '*.cr'))

CFLAGS = -W -Wall -pedantic -std=c11 -O2 -ffreestanding -nostdinc \
				 -fno-builtin -fno-stack-protector \
				 -mno-red-zone \
				 -I src/include/ -I ext/

default: iso

kernel: $(KERNEL)
.PHONY: kernel

sources:
	@echo $(CRYSTAL_SOURCES)
	@echo $(CRYSTAL_OS)

$(KERNEL): musl build_dirs $(CRYSTAL_OS) $(OBJECTS) $(LIB)
	mkdir -p $(KERNEL_DIR)
	$(LD) --nmagic --output=$@ --script=$(LINKER) $(CRYSTAL_OS) $(OBJECTS) $(LIB) $(EXT_MUSL)/lib/libc.a

build/asm/%.o: asm/%.asm
	$(NASM) -f elf64 $< -o $@

build/src/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(CRYSTAL_OS): $(CRYSTAL_SOURCES)
	crystal build src/kernel/main.cr --cross-compile --target $(TARGET) --prelude=empty --verbose
	mv -f main.o $@

$(LIB): $(SOURCES)
	$(AR) rcs $@ $^

build_dirs:
	mkdir -p $(BUILD_DIRS)
.PHONY: build_dirs

musl:
	$(MAKE) -C $(EXT_DIR)
.PHONY: musl

iso: $(ISO)
.PHONY: iso

$(ISO): cleansrcs $(KERNEL)
	mkdir -p $(GRUB_DIR)
	cp -R grub/* $(GRUB_DIR)
	grub-mkrescue -o $@ $(ISO_DIR)

run: $(ISO)
	qemu-system-x86_64 -cdrom $<
.PHONY: run

debug: CFLAGS += -DENABLE_KERNEL_DEBUG
debug: cleaniso $(ISO)
	qemu-system-x86_64 -cdrom $(ISO) -serial file:/tmp/serial.log
.PHONY: debug

clean:
	rm -f $(OBJECTS) $(SOURCES) $(CRYSTAL_OS) $(KERNEL) $(ISO) $(LIB)
	rm -rf $(BUILD_DIR)
.PHONY: clean

cleansrcs:
	rm -f $(SOURCES)
.PHONY: cleansrcs

cleaniso:
	rm -f $(ISO)
.PHONY: cleaniso

cleanmusl:
	rm -rf $(EXT_MUSL)
	$(MAKE) -C $(EXT_DIR) clean
.PHONY: cleanmusl

# Copyright 2016 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.
#
# The part of this file was taken from:
# https://github.com/phil-opp/blog_os/blob/set_up_rust/Makefile

arch ?= x86_64
target ?= $(arch)-unknown-linux-gnu
kernel := build/kernel-$(arch).bin
iso := build/utero-$(arch).iso

libcr := src/lib_cr/libcr.a
libcr_source_files := $(wildcard src/lib_cr/*.c)
libcr_object_files := $(patsubst src/lib_cr/%.c, \
				build/lib_cr/%.o, $(libcr_source_files))

crystal_os := target/$(target)/debug/main.o

linker_script := src/arch/$(arch)/linker.ld
grub_cfg := src/arch/$(arch)/grub.cfg
assembly_source_files := $(wildcard src/arch/$(arch)/*.asm)
assembly_object_files := $(patsubst src/arch/$(arch)/%.asm, \
				build/arch/$(arch)/%.o, $(assembly_source_files))
crystal_files := $(shell find ./ -name *.cr)

test_libc_sources := $(wildcard test_libc/*.c)
test_libc_targets := $(patsubst test_libc/%.c, \
				build/test_libc/%, $(test_libc_sources))

.PHONY: all test clean run iso

all: $(kernel)

test:
				@crystal spec -v

libctest: $(test_libc_targets)
				@run-parts build/test_libc

build/test_libc/%: test_libc/%.c
				@mkdir -p $(shell dirname $@)
				@cc $< -o $@

clean:
				@rm -r build/ target/

run: $(iso)
				@qemu-system-x86_64 -cdrom $(iso)

iso: $(iso)

$(iso): $(kernel) $(grub_cfg)
				@mkdir -p build/isofiles/boot/grub
				@cp $(kernel) build/isofiles/boot/kernel.bin
				@cp $(grub_cfg) build/isofiles/boot/grub
				@grub-mkrescue -o $(iso) build/isofiles 2> /dev/null
				@rm -r build/isofiles

$(kernel): $(assembly_object_files) $(crystal_os) $(linker_script) $(crystal_files) $(libcr)
				@echo Creating $@...
				@ld -n -nostdlib -melf_x86_64 --gc-sections --build-id=none -T $(linker_script) -o $@ $(assembly_object_files) $(crystal_os) $(libcr)

$(crystal_os): $(crystal_files)
				@mkdir -p $(shell dirname $(crystal_os))
				@crystal build src/main.cr --target=$(target) --prelude=empty --emit=obj --verbose
				@rm main
				@mv -f main.o target/$(target)/debug/

build/arch/$(arch)/%.o: src/arch/$(arch)/%.asm
				@mkdir -p $(shell dirname $@)
				@nasm -felf64 $< -o $@

$(libcr): $(libcr_object_files)
				@ar r $(libcr) $(libcr_object_files)

build/lib_cr/%.o: src/lib_cr/%.c
				@mkdir -p $(shell dirname $@)
				@cc -o $@ -c $<

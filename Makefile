# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
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
target ?= $(arch)-unknown-linux-musl
kernel := build/kernel-$(arch).bin
iso := build/utero-$(arch).iso

libcr := src/musl/lib/libcr.a
libu := build/arch/$(arch)/c/libu.a
libu_fullpath := $(subst build/,$(shell pwd)/build/,$(libu))
c_source_files := $(wildcard src/arch/$(arch)/c/*.c)
c_object_files := $(patsubst src/arch/$(arch)/c/%.c, \
				build/arch/$(arch)/c/%.o, $(c_source_files))
c_object_files_fullpath := $(subst build/,$(shell pwd)/build/,$(c_object_files))

crystal_os := target/$(target)/debug/main.o

linker_script := src/arch/$(arch)/linker.ld
grub_cfg := src/arch/$(arch)/grub.cfg
assembly_source_files := $(wildcard src/arch/$(arch)/*.asm)
assembly_object_files := $(patsubst src/arch/$(arch)/%.asm, \
				build/arch/$(arch)/%.o, $(assembly_source_files))
crystal_files := $(shell find ./ -name *.cr)

.PHONY: all test clean run iso

all: $(kernel)

test:
				@crystal spec -v

clean:
				@rm -f $(kernel) $(iso) $(assembly_object_files) $(c_object_files) $(libu)
				@rm -rf target/
				$(MAKE) -C build/musl clean
cleanobjs:
				@rm -f $(assembly_object_files) $(c_object_files)
				@rm -rf target/

run: $(iso)
				@qemu-system-$(arch) -cdrom $(iso)

iso: $(iso)

$(iso): $(kernel) $(grub_cfg)
				@mkdir -p build/isofiles/boot/grub
				@cp $(kernel) build/isofiles/boot/kernel.bin
				@cp $(grub_cfg) build/isofiles/boot/grub
				@grub-mkrescue -o $(iso) build/isofiles 2> /dev/null
				@rm -r build/isofiles

$(kernel): $(linker_script) $(libcr) $(libu) $(crystal_os)
				@echo Creating $@...
				@ld -n -nostdlib -melf_$(arch) --gc-sections --build-id=none -T $(linker_script) -o $@ $(assembly_object_files) $(crystal_os) $(libu) $(libcr)

$(crystal_os): $(libu) $(crystal_files)
				@mkdir -p $(shell dirname $(crystal_os))
				@crystal build src/kernel/main.cr --target=$(target) --prelude=empty --emit=obj --verbose --link-flags $(libu_fullpath)
				@rm main
				@mv -f main.o target/$(target)/debug/

$(libcr):
				$(MAKE) -C build/musl

$(libu): $(assembly_object_files) $(c_object_files)
				@ar r $(libu) $(assembly_object_files) $(c_object_files)

build/arch/$(arch)/%.o: src/arch/$(arch)/%.asm
				@mkdir -p $(shell dirname $@)
				@nasm -felf64 $< -o $@

build/arch/$(arch)/c/%.o: src/arch/$(arch)/c/%.c
				@mkdir -p $(shell dirname $@)
				@cc -ffreestanding -nostdinc -Wno-implicit -o $@ -c $<

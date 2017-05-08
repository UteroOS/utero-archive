/*
Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
file at the top-level directory of this distribution.

Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
<LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
option. This file may not be copied, modified, or distributed
except according to those terms.

The part of this file was taken from:
https://github.com/phil-opp/blog_os/blob/set_up_rust/src/arch/x86_64/linker.ld
*/

ENTRY(start)

SECTIONS {
		. = 1M;
		kernel_start = .;

		.rodata :
		{
				/* ensure that the multiboot header is at the beginning */
				KEEP(*(.multiboot_header))
				*(.rodata .rodata.*)
				. = ALIGN(4K);
		}

		.text :
		{
				*(.text .text.*)
				. = ALIGN(4K);
		}

		.data :
		{
				*(.data .data.*)
				. = ALIGN(4K);
		}

		.bss :
		{
				bss_start = .;
				*(.bss .bss.*)
				. = ALIGN(4K);
				bss_end = .;
		}
		kernel_end = .;
}

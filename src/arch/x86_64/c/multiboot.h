// Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
// file at the top-level directory of this distribution.
//
// Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
// http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
// <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
// option. This file may not be copied, modified, or distributed
// except according to those terms.
//
// The part of this file was taken from:
// https : //github.com/RWTH-OS/eduOS/blob/master/arch/x86/include/asm/multiboot.h
// Utero OS is able to use Multiboot (http://www.gnu.org/software/grub/manual/multiboot/)

// TODO: This is almost copy, reviewing later is required

#ifndef __ARCH_MULTIBOOT_H__
#define __ARCH_MULTIBOOT_H__

#include "stddef.h"

/// Does the bootloader provide mem_* fields?
#define MULTIBOOT_INFO_MEM (1 << 0)
/// Does the bootloader provide the command-line?
#define MULTIBOOT_INFO_CMDLINE (1 << 2)
/// Does the bootloader provide a list of modules?
#define MULTIBOOT_INFO_MODS (1 << 3)
/// Does the bootloader provide a full memory map?
#define MULTIBOOT_INFO_MEM_MAP (1 << 6)

typedef uint16_t multiboot_uint16_t;
typedef uint32_t multiboot_uint32_t;
typedef uint64_t multiboot_uint64_t;

/* The symbol table for a.out. */
struct multiboot_aout_symbol_table
{
  multiboot_uint32_t tabsize;
  multiboot_uint32_t strsize;
  multiboot_uint32_t addr;
  multiboot_uint32_t reserved;
};
typedef struct multiboot_aout_symbol_table multiboot_aout_symbol_table_t;

/* The section header table for ELF. */
struct multiboot_elf_section_header_table
{
  multiboot_uint32_t num;
  multiboot_uint32_t size;
  multiboot_uint32_t addr;
  multiboot_uint32_t shndx;
};
typedef struct multiboot_elf_section_header_table multiboot_elf_section_header_table_t;

struct multiboot_info
{
  /** Multiboot info version number */
  multiboot_uint32_t flags;

  /** Available memory from BIOS */
  multiboot_uint32_t mem_lower;
  multiboot_uint32_t mem_upper;

  /** "root" partition */
  multiboot_uint32_t boot_device;

  /** Kernel command line */
  multiboot_uint32_t cmdline;

  /** Boot-Module list */
  multiboot_uint32_t mods_count;
  multiboot_uint32_t mods_addr;

  union {
    multiboot_aout_symbol_table_t aout_sym;
    multiboot_elf_section_header_table_t elf_sec;
  } u;

  /** Memory Mapping buffer */
  multiboot_uint32_t mmap_length;
  multiboot_uint32_t mmap_addr;

  /** Drive Info buffer */
  multiboot_uint32_t drives_length;
  multiboot_uint32_t drives_addr;

  /** ROM configuration table */
  multiboot_uint32_t config_table;

  /** Boot Loader Name */
  multiboot_uint32_t boot_loader_name;

  /** APM table */
  multiboot_uint32_t apm_table;

  /** Video */
  multiboot_uint32_t vbe_control_info;
  multiboot_uint32_t vbe_mode_info;
  multiboot_uint16_t vbe_mode;
  multiboot_uint16_t vbe_interface_seg;
  multiboot_uint16_t vbe_interface_off;
  multiboot_uint16_t vbe_interface_len;
};

typedef struct multiboot_info multiboot_info_t;

struct multiboot_mmap_entry
{
  multiboot_uint32_t size;
  multiboot_uint64_t addr;
  multiboot_uint64_t len;
#define MULTIBOOT_MEMORY_AVAILABLE 1
#define MULTIBOOT_MEMORY_RESERVED 2
  multiboot_uint32_t type;
} __attribute__((packed));
typedef struct multiboot_mmap_entry multiboot_memory_map_t;

struct multiboot_mod_list
{
  /** the memory used goes from bytes ’mod start’ to ’mod end-1’ inclusive */
  multiboot_uint32_t mod_start;
  multiboot_uint32_t mod_end;

  /** Module command line */
  multiboot_uint32_t cmdline;

  /** padding to take it to 16 bytes (must be zero) */
  multiboot_uint32_t pad;
};
typedef struct multiboot_mod_list multiboot_module_t;

/// Pointer to multiboot structure
/// This pointer is declared at set by boot.asm
extern multiboot_info_t *mb_info;

#endif

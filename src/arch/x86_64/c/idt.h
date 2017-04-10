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
// https://github.com/RWTH-OS/eduOS/blob/master/arch/x86/include/asm/idt.h

#ifndef IDT_H
#define IDT_H

#include "stddef.h"

typedef struct {
  // Handler function's lower 16 address bits
  uint16_t base_lo;
  // Handler function's segment selector.
  uint16_t sel;
  // These bits are reserved by Intel
  uint8_t always0;
  // These 8 bits contain flags. Exact use depends on the type of interrupt gate.
  uint8_t flags;
  // Higher 16 bits of handler function's base address
  uint16_t base_hi;
  // In 64 bit mode, the "highest" 32 bits of the handler function's base address
  uint32_t base_hi64;
  // reserved entries
  uint32_t reserved;
} __attribute__ ((packed)) idt_entry_t;

typedef struct {
  /// Size of the IDT in bytes (not the number of entries!)
  uint16_t limit;
  /// Base address of the IDT
  size_t base;
} __attribute__ ((packed)) idt_ptr_t;

void idt_install(void);

void idt_set_gate(unsigned char num, size_t base, unsigned short sel,
      unsigned char flags);

void configure_idt_entry(idt_entry_t *dest_entry, size_t base,
      unsigned short sel, unsigned char flags);

#endif /* end of include guard: IDT_H */

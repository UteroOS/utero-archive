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
// https://github.com/RWTH-OS/eduOS/blob/master/arch/x86/kernel/idt.c

#include <asm/idt.h>

static idt_entry_t idt[256] = {[0 ... 255] = {0, 0, 0, 0, 0, 0, 0}};
static idt_ptr_t idtp;

void configure_idt_entry(idt_entry_t *dest_entry, size_t base,
  unsigned short sel, unsigned char flags)
{
  /* The interrupt routine's base address */
  dest_entry->base_lo = (base & 0xFFFF);
  dest_entry->base_hi = (base >> 16) & 0xFFFF;

  /* The segment or 'selector' that this IDT entry will use
   *  is set here, along with any access flags */
  dest_entry->sel = sel;
  dest_entry->always0 = 0;
  dest_entry->flags = flags;
}

/*
 * Use this function to set an entry in the IDT. Alot simpler
 * than twiddling with the GDT ;)
 */
void idt_set_gate(unsigned char num, size_t base, unsigned short sel,
    unsigned char flags)
{
  configure_idt_entry(&idt[num], base, sel, flags);
}

/* Installs the IDT */
void idt_install(void)
{
  static int initialized = 0;

  if (!initialized) {
    initialized = 1;

    /* Sets the special IDT pointer up, just like in 'gdt.c' */
    idtp.limit = (sizeof(idt_entry_t) * 256) - 1;
    idtp.base = (size_t)&idt;
  }
  /* Points the processor's internal register to the new IDT */
  asm volatile("lidt %0" : : "m" (idtp));
}

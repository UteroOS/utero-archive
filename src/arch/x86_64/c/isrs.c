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
// https://github.com/RWTH-OS/eduOS/blob/master/arch/x86/kernel/isrs.c

#include <asm/idt.h>
#include <asm/isrs.h>
#include <asm/io.h>
#include "stdio.h"

/*
 * These are function prototypes for all of the exception
 * handlers: The first 32 entries in the IDT are reserved
 * by Intel and are designed to service exceptions!
 */
extern void isr0(void);
extern void isr1(void);
extern void isr2(void);
extern void isr3(void);
extern void isr4(void);
extern void isr5(void);
extern void isr6(void);
extern void isr7(void);
extern void isr8(void);
extern void isr9(void);
extern void isr10(void);
extern void isr11(void);
extern void isr12(void);
extern void isr13(void);
extern void isr14(void);
extern void isr15(void);
extern void isr16(void);
extern void isr17(void);
extern void isr18(void);
extern void isr19(void);
extern void isr20(void);
extern void isr21(void);
extern void isr22(void);
extern void isr23(void);
extern void isr24(void);
extern void isr25(void);
extern void isr26(void);
extern void isr27(void);
extern void isr28(void);
extern void isr29(void);
extern void isr30(void);
extern void isr31(void);
extern int eputs(const char *);
extern int eprint(const char *);

void fault_handler(struct state *s);
// static void fault_handler(struct state *s);
// fqu_handler

/*
 * This is a very repetitive function... it's not hard, it's
 * just annoying. As you can see, we set the first 32 entries
 * in the IDT to the first 32 ISRs. We can't use a for loop
 * for this, because there is no way to get the function names
 * that correspond to that given entry. We set the access
 * flags to 0x8E. This means that the entry is present, is
 * running in ring 0 (kernel level), and has the lower 5 bits
 * set to the required '14', which is represented by 'E' in
 * hex.
 */
void isrs_install(void)
{
  int i;

  idt_set_gate(0, (size_t)isr0, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(1, (size_t)isr1, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(2, (size_t)isr2, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(3, (size_t)isr3, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(4, (size_t)isr4, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(5, (size_t)isr5, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(6, (size_t)isr6, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(7, (size_t)isr7, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(8, (size_t)isr8, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(9, (size_t)isr9, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(10, (size_t)isr10, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(11, (size_t)isr11, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(12, (size_t)isr12, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(13, (size_t)isr13, KERNEL_CODE_SELECTOR,
   IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(14, (size_t)isr14, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(15, (size_t)isr15, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(16, (size_t)isr16, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(17, (size_t)isr17, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(18, (size_t)isr18, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(19, (size_t)isr19, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(20, (size_t)isr20, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(21, (size_t)isr21, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(22, (size_t)isr22, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(23, (size_t)isr23, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(24, (size_t)isr24, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(25, (size_t)isr25, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(26, (size_t)isr26, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(27, (size_t)isr27, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(28, (size_t)isr28, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(29, (size_t)isr29, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(30, (size_t)isr30, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);
  idt_set_gate(31, (size_t)isr31, KERNEL_CODE_SELECTOR,
  IDT_FLAG_PRESENT|IDT_FLAG_RING0|IDT_FLAG_32BIT|IDT_FLAG_INTTRAP);

  // install the default handler

  // set hanlder for fpu exceptions
}

/** @brief Exception messages
 *
 * This is a simple string array. It contains the message that
 * corresponds to each and every exception. We get the correct
 * message by accessing it like this:
 * exception_message[interrupt_number]
 */
static const char *exception_messages[] = {
  "Division By Zero", "Debug", "Non Maskable Interrupt",
  "Breakpoint", "Into Detected Overflow", "Out of Bounds", "Invalid Opcode",
  "No Coprocessor", "Double Fault", "Coprocessor Segment Overrun", "Bad TSS",
  "Segment Not Present", "Stack Fault", "General Protection Fault", "Page Fault",
  "Unknown Interrupt", "Coprocessor Fault", "Alignment Check", "Machine Check",
  "Reserved", "Reserved", "Reserved", "Reserved", "Reserved",
  "Reserved", "Reserved", "Reserved", "Reserved", "Reserved", "Reserved",
  "Reserved", "Reserved" };

  /*
   * All of our Exception handling Interrupt Service Routines will
   * point to this function. This will tell us what exception has
   * occured! Right now, we simply abort the current task.
   * All ISRs disable interrupts while they are being
   * serviced as a 'locking' mechanism to prevent an IRQ from
   * happening and messing up kernel data structures
   */
#define N 256
void fault_handler(struct state *s)
// static void fault_handler(struct state *s)
{
  char message[N] = {'\0'};
  if (s->int_no < 32) {
  sprintf(message, " Exception (%llu) at 0x%llx:0x%llx, error code 0x%llx, rflags 0x%llx\n",
    s->int_no, s->cs, s->rip, s->error, s->rflags);
  eputs(exception_messages[s->int_no]);
  eprint(message);

  outb(0x20, 0x20);

  // irq_enable();
  // abort();
    for (;;);
  }
}

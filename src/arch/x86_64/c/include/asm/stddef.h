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
// https://github.com/RWTH-OS/eduOS/blob/master/arch/x86/include/asm/stddef.h

#ifndef STDDEF_H
#define STDDEF_H

// Unsigned 64 bit integer
typedef unsigned long long uint64_t;
// Signed 64 bit integer
typedef long long int64_t;
// Unsigned 32 bit integer
typedef unsigned int uint32_t;
// Signed 32 bit integer
typedef int int32_t;
// Unsigned 16 bit integer
typedef unsigned short uint16_t;
// Signed 16 bit integer
typedef short int16_t;
// Unsigned 8 bit integer (/char)
typedef unsigned char uint8_t;
// Signed 8 bit integer (/char)
typedef char int8_t;

// A popular type for addresses
typedef unsigned long long size_t;

// This defines what the stack looks like after the task context is saved.
struct state {
  // R15 register
  uint64_t r15;
  // R14 register
  uint64_t r14;
  // R13 register
  uint64_t r13;
  // R12 register
  uint64_t r12;
  // R11 register
  uint64_t r11;
  // R10 register
  uint64_t r10;
  // R9 register
  uint64_t r9;
  // R8 register
  uint64_t r8;
  // RDI register
  uint64_t rdi;
  // RSI register
  uint64_t rsi;
  // RBP register
  uint64_t rbp;
  // (pseudo) RSP register
  uint64_t rsp;
  // RBX register
  uint64_t rbx;
  // RDX register
  uint64_t rdx;
  // RCX register
  uint64_t rcx;
  // RAX register
  uint64_t rax;

  // Interrupt number
  uint64_t int_no;

  // pushed by the processor automatically
  uint64_t error;
  uint64_t rip;
  uint64_t cs;
  uint64_t rflags;
  uint64_t userrsp;
  uint64_t ss;
};

#endif /* end of include guard: STDDEF_H */

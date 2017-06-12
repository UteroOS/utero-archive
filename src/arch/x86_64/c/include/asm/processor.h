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
// https://github.com/RWTH-OS/eduOS/blob/master/arch/x86/include/asm/processor.h

#ifndef ASM_PROCESSOR_H
#define ASM_PROCESSOR_H

#include <asm/stddef.h>

// rdtsc (Read-time stamp counter)
// return the 64-bit time stamp value
inline static uint64_t
rdtsc(void)
{
  uint64_t lo, hi;
  asm volatile("rdtsc" : "=a"(lo), "=d"(hi));
  return (hi << 32 | lo);
}

// wbinvd asm instruction(Write back and invalidate cache)
inline static void
flush_cache(void)
{
  asm volatile("wbinvd" ::: "memory");
}

// invd asm instruction (Invalidate internal caches - without writing back)
inline static void
invalid_cache(void)
{
  asm volatile("invd");
}

// NOTE: mb, rmb, wmb will be moved to arch/x86_64/c/processor.c
// and used via extern func_memory_barrier (mb|rmb|wmb)

// mb (Memory barrier)
// mfence asm instruction (Memory Fence - Serializes load and store operations)
inline static void
mb(void)
{
  asm volatile("mfence" ::: "memory");
}

// rmb (Read memory barrier)
// lfence asm instruction (Load Fence - Serializes load operations)
inline static void
rmb(void)
{
  asm volatile("lfence" ::: "memory");
}

// wmb (Write memory barrier)
// sfence asm instruction (Store Fence - Serializes store operations)
inline static void
wmb(void)
{
  asm volatile("sfence" ::: "memory");
}

// search the most significant bit
// bsr (Bit Scan Reverse) asm instruction
static inline size_t
msb(size_t i)
{
  size_t ret;

  if (!i) {
    return (sizeof(size_t) * 8);
  }
  asm volatile("bsr %1, %0" : "=r"(ret) : "r"(i) : "cc");

  return ret;
}

// search the least significant bit
// bsf (Bit Scan Forward) asm instruction
static inline size_t
lsb(size_t i)
{
  size_t ret;

  if (!i) {
    return (sizeof(size_t) * 8);
  }
  asm volatile("bsf %1, %0" : "=r"(ret) : "r"(i) : "cc");

  return ret;
}

// A one-instruction-do-nothing
#define NOP1 asm volatile("nop")
// A two-instruction-do-nothing
#define NOP2 asm volatile("nop;nop")
// A four-instruction-do-nothing
#define NOP4 asm volatile("nop;nop;nop;nop")
// A eight-instruction-do-nothing
#define NOP8 asm volatile("nop;nop;nop;nop;nop;nop;nop;nop")

#endif /* end of include guard: ASM_PROCESSOR_H */

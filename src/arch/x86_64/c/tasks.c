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
// https://github.com/RWTH-OS/eduOS/blob/master/arch/x86/kernel/tasks.c

#include <stdio.h>
#include <stdlib.h>
// #include <string.h>
#include <errno.h>
#include <tasks.h>
#include <processor.h>

size_t*
get_current_stack(void)
{
  task_t* curr_task = current_task;

  return curr_task->last_stack_pointer;
}

int
create_default_frame(task_t* task, entry_point_t ep, void* arg)
{
  size_t* stack;
  struct state* stptr;
  size_t state_size;

  if (BUILTIN_EXPECT(!task, 0)) {
    return -EINVAL;
  }

  if (BUILTIN_EXPECT(!task->stack, 0)) {
    return -EINVAL;
  }

  memset(task->stack, 0xcd, KERNEL_STACK_SIZE);
  // => stack is 16byte aligned
  stack = (size_t*)(task->stack + KERNEL_STACK_SIZE - 16);
  // Only marker for debugging purposes, ...
  *stack-- = 0xdeadbeef;
  // and the "caller" we shall return to
  // This procedure cleans the task after exit
  *stack = (size_t)leave_kernel_task;
  // Next bunch on the stack is the initial register state
  // The stack must look like the stack of a task
  // which was scheduled away previously
  state_size = sizeof(struct state);
  stack = (size_t*)((size_t)stack - state_size);
  stptr = (struct state*)stack;
  memset(stptr, 0x00, state_size);
  stptr->rsp = (size_t)stack + state_size;
  // The first-function-to-be-called's arguments, ...
  stptr->rdi = (size_t)arg;
  stptr->int_no = 0xb16b00b5;
  stptr->error = 0xc03db4b3;
  // The instruction pointer shall be set on the first function
  // to be called after IRETing
  stptr->rip = (size_t)ep;
  stptr->cs = 0x08;
  stptr->ss = 0x10;
  stptr->rflags = 0x1002;
  stptr->userrsp = stptr->rsp;
  // Set the task's stack pointer entry to the stack
  // we have crafted right now
  task->last_stack_pointer = (size_t*)stack;

  return 0;
}

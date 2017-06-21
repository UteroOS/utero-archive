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
// https://github.com/RWTH-OS/eduOS/blob/master/mm/memory.c

#include <stddef.h>
#include <stdlib.h>

static char stack[MAX_TASKS - 1][KERNEL_STACK_SIZE];

void*
create_stack(tid_t id)
{
  // Idle task uses stack
  if (BUILTIN_EXPECT(!id, 0)) {
    return NULL;
  }
  // Do we have a valid task id?
  if (BUILTIN_EXPECT(id >= MAX_TASKS, 0)) {
    return NULL;
  }

  return (void*)stack[id - 1];
}

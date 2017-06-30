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
// https://github.com/RWTH-OS/eduOS/blob/master/arch/x86/include/asm/tasks.h

#ifndef ASM_TASKS_H
#define ASM_TASKS_H

#include <stddef.h>

// Switch the current task
// stack: Pointer to the old stack pointer
void switch_context(size_t** stack);

// Setup a default frame for a new task
// task: Pointer to the task structure
// ep: The entry point for code execution
// arg: Arguments list pointer for the task's stack
// return
// - 0 on success
// - -EINVAL (-22) on failure
int create_default_frame(task_t* task, entry_point_t ep, void* arg);

#endif /* end of include guard: ASM_TASKS_H */
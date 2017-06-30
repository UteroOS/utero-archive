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
// https://github.com/RWTH-OS/eduOS/blob/master/include/eduos/tasks.h

#ifndef TASKS_H
#define TASKS_H

#include <stddef.h>
#include <tasks_types.h>
#include <asm/tasks.h>

int multitasking_init(void);

int create_kernel_task(tid_t* id, entry_point_t ep, void* args, uint8_t prio);

void reschedule(void);

void NORETURN leave_kernel_task(void);

#endif /* end of include guard: TASKS_H */
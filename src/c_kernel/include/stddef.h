// Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
// http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
// <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
// option. This file may not be copied, modified, or distributed
// except according to those terms.
//
// The part of this file was taken from:
// https://github.com/RWTH-OS/eduOS/blob/master/include/eduos/stddef.h

#ifndef STDDEF_H
#define STDDEF_H

#include <config.h>
#include <asm/stddef.h>

#define NULL ((void*) 0)

// represents a task identifier
typedef unsigned int tid_t;

struct task;

// pointer to the current (running) task
// NOTE: defined in tasks.c
extern struct task* current_task;

#endif /* end of include guard: STDDEF_H */
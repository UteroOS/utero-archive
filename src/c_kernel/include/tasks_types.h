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
// https://github.com/RWTH-OS/eduOS/blob/master/include/eduos/tasks_types.h

#ifndef TASKS_TYPES_H
#define TASKS_TYPES_H

#include <stddef.h>
// #include <asm/tasks_types.h>

#define TASK_INVALID 0
#define TASK_READY 1
#define TASK_RUNNING 2
#define TASK_BLOCKED 3
#define TASK_FINISHED 4
#define TASK_IDLE 5

#define MAX_PRIO 31
#define REALTIME_PRIO 31
#define HIGH_PRIO 16
#define NORMAL_PRIO 8
#define LOW_PRIO 1
#define IDLE_PRIO 0

typedef int (*entry_point_t)(void*);

// Represents the Process Control Block
typedef struct task
{
  // task id = position in the task table
  tid_t id __attribute__((aligned(CACHE_LINE)));
  // task status
  uint32_t status;
  // copy of the stack pointer before a context switch
  size_t* last_stack_pointer;
  // starting address of the stack
  void* stack;
  // task priority
  uint8_t prio;
  // next task in the queue
  struct task* next;
  // previous task in the queue
  struct task* prev;
} task_t;

typedef struct
{
  task_t* first;
  task_t* last;
} task_list_t;

// Represents a queue for all runnable tasks
typedef struct
{
  // idle task
  task_t* idle __attribute__((aligned(CACHE_LINE)));
  // previous task
  task_t* old_task;
  // total number of tasks in the queue
  uint32_t nr_tasks;
  // indicates the used priority queues
  uint32_t prio_bitmap;
  // a queue for each priority
  task_list_t queue[MAX_PRIO - 1];
} readyqueues_t;

#endif /* end of include guard: TASKS_TYPES_H */
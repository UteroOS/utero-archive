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
// https://github.com/RWTH-OS/eduOS/blob/master/kernel/tasks.c

#include <errno.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <tasks.h>
#include <tasks_types.h>
extern void* stack_top; // defined in boot.asm
extern int eputs(const char*);
extern int eprint(const char*);

// Array of task structures (PCB)
// A task's id will be its position in this array
static task_t task_table[MAX_TASKS] =
  {[0] = { 0, TASK_IDLE, NULL, NULL, 0, NULL, NULL },
   [1 ... MAX_TASKS - 1] = { 0, TASK_INVALID, NULL, NULL, 0, NULL, NULL } };
// readyqueues
// Task list is a queue for priority, total number is 30
static readyqueues_t readyqueues = { task_table+0, NULL, 0, 0, {[0 ... MAX_PRIO-2] = {NULL, NULL}}};

task_t* current_task = task_table+0;

// Return pointer to the task_t structure of current task
task_t *
get_current_task(void)
{
  return current_task;
}

int multitasking_init(void)
{
  // if the first task status isn't idle (it's unlikely)
  // puts message task 0 is not an idle task
  if (BUILTIN_EXPECT(task_table[0].status != TASK_IDLE, 0)) {
    // Equivalent to kputs("Task 0 is not an idle task\n");
    eputs("Task 0 is not an idle task");
    return -ENOMEM;
  }
  // At the first task_table
  // Set prio to zero
  task_table[0].prio = IDLE_PRIO;
  // Set stack_top - 8192 to stack
  task_table[0].stack = stack_top - 8192;
  return 0;
}

void
finish_task_switch(void)
{
  // pointer to old task and prio
  task_t* old;
  uint8_t prio;
  // Old(previous) task in the ready queue is NOT NULL
  if ((old = readyqueues.old_task) != NULL) {
    // If old task's status is TASK_INVALID
    if (old->status == TASK_INVALID) {
      // Set old task's stack to NULL
      old->stack = NULL;
      // Set old task's last_stack_pointer to NULL
      old->last_stack_pointer = NULL;
      // Set old task in the queue to NULL
      readyqueues.old_task = NULL;

    } else { // else if old task's status is valid
      // Set old task's prio to (current) prio
      prio = old->prio;
      if (!readyqueues.queue[prio - 1].first) { // if a queue for current prio is not the first
        // Set next and previous tasks against old task to NULL
        old->next = old->prev = NULL;
        // Set old task to the first and the last in task list
        readyqueues.queue[prio - 1].first = readyqueues.queue[prio - 1].last = old;

      } else { // else if a queue for prio is the first
        // Set next task against old to NULL
        old->next = NULL;
        // Set previous task against old to the last in task list
        old->prev = readyqueues.queue[prio - 1].last;
        // Set old to the next task of the last task in list
        readyqueues.queue[prio - 1].last->next = old;
        // Set old to the last task in list
        readyqueues.queue[prio - 1].last = old;
      }
      // The previous task in ready queues is NULL;
      readyqueues.old_task = NULL;
      // Using |= operator, if there's prio_bitmap, assign itself
      // but when no prio_bitmap, assign 1 << prio
      readyqueues.prio_bitmap |= (1 << prio);
    }
  }
}

#define N 256 // For message
// Procedures which are called by exiting tasks
static void NORETURN
do_exit(int arg)
{
  task_t* curr_task = current_task;
  // Equivalent to kprintf("Terminate task: %u, return value %d\n", curr_task->id, arg);
  char message[N] = { '\0' };
  sprintf(message, "Terminate task: %u, return value %d\n", curr_task->id, arg);
  eprint(message);

  curr_task->status = TASK_FINISHED;
  reschedule();
  // Equivalent to kprintf("Kernel panic: scheduler found no valid task\n");
  eputs("Kernel panic: scheduler found no valid task");
  while (1)
  {
    NOP8;
  }
}

// A procedure to be called by kernel tasks
void NORETURN
leave_kernel_task(void)
{
  int result;
  result = 0; // get_return_value();
  do_exit(result);
}

// Create a task with a specific entry point
// id: Pointer to a tid_t struct where the id shall be set
// ep: Pointer to the function the task shall start with
// arg: Arguments list
// prio: Desired priority of the new task
static int
create_task(tid_t* id, entry_point_t ep, void* arg, uint8_t prio)
{
  int ret = -ENOMEM;
  uint32_t i;

  // entry pointer is null
  if (BUILTIN_EXPECT(!ep, 0)) {
    return -EINVAL;
  }
  // the given prio equals IDLE_PRIO(0)
  if (BUILTIN_EXPECT(prio == IDLE_PRIO, 0)) {
    return -EINVAL;
  }
  // the given prio is higher than MAX_PRIO(31)
  if (BUILTIN_EXPECT(prio > MAX_PRIO, 0)) {
    return -EINVAL;
  }
  // Loop 0~15
  for(i=0; i < MAX_TASKS; i++) {
    // Turn invalid-status task into ready-status
    if (task_table[i].status == TASK_INVALID) {
      // set i to id
      task_table[i].id = i;
      // set status to TASK_READY;
      task_table[i].status == TASK_READY;
      // last_stack_pointer = NULL;
      task_table[i].last_stack_pointer = NULL;
      task_table[i].stack = create_stack(i);
      // Set the given prio to prio
      task_table[i].prio = prio;

      if (id) {
        // set i to id's pointer
        *id = i;
      }

      ret = create_default_frame(task_table+i, ep, arg);
      // Add task in the readyqueues
      readyqueues.prio_bitmap |= (1 << prio);
      readyqueues.nr_tasks++;
      // if there's no first one of queue
      if (!readyqueues.queue[prio-1].first) {
        // next and prev of task_table[i] = NULL;
        task_table[i].next = task_table[i].prev = NULL;
        // set task_table+i (address of task_table+i?) to first
        readyqueues.queue[prio - 1].first = task_table + i;
        // set task_table+i (address of task_table+i?) to last
        readyqueues.queue[prio - 1].last = task_table + i;
      } else { // else there's the first of queue
        // set queue[prio-1].last to previous task in task_table
        task_table[i].prev = readyqueues.queue[prio - 1].last;
        // set NULL to next task in task_table
        task_table[i].next = NULL;
        // set task_table+i to the last of the queue to next task
        readyqueues.queue[prio - 1].last->next = task_table + i;
        // set task_table+i to the last of the queue
        readyqueues.queue[prio - 1].last = task_table + i;
      }
      break;
    }
  }

  return ret;
}

int
create_kernel_task(tid_t* id, entry_point_t ep, void* args, uint8_t prio)
{
  // given prio is higher than MAX_PRIO(31)
  if (prio > MAX_PRIO) {
    // Set NORMAL_PRIO to prio
    prio = NORMAL_PRIO;
  }
  return create_task(id, ep, args, prio);
}

size_t**
scheduler(void)
{
  task_t* orig_task;
  uint32_t prio;

  orig_task = current_task;
  // signalizes that this task could be reused
  // current_task is task_table+0 when initialized
  if (current_task->status == TASK_FINISHED) {
    current_task->status = TASK_INVALID;
    readyqueues.old_task = current_task;
  } else { // current_task is NOT FINISHED
    // Reset old task
    readyqueues.old_task = NULL;
  }
  // Determines highest priority (at this point)
  prio = msb(readyqueues.prio_bitmap);
  // if current highest prio is higher than MAX_PRIO
  if (prio > MAX_PRIO) {
    // Get task out
    if ((current_task->status == TASK_RUNNING) ||
        (current_task->status == TASK_IDLE)) {
      goto get_task_out;
    }
    // set readyqueues.idle (idle task) to current_task
    current_task = readyqueues.idle;

  } else { // current highest prio is lower than MAX_PRIO
           // Does the current task have an higher priority? => no task switch
    // if current_task's prio is higher than current highest prio AND
    // current_task's status is TASK_RUNNING
    if ((current_task->prio > prio) && (current_task->status == TASK_RUNNING)) {
      goto get_task_out;
    }
    // if current_task's status is equals to TASK_RUNNING
    if (current_task->status == TASK_RUNNING) {
      // Set current_task's status to TASK_READY
      current_task->status = TASK_READY;
      // Set current_task to readyqueues.old_task
      readyqueues.old_task = current_task;
    }
    // Set readyqueues's queue[current prio].first to current_task
    current_task = readyqueues.queue[prio - 1].first;
    // if current_task's status equals to TASK_INVALID (unlikely)
    if (BUILTIN_EXPECT(current_task->status == TASK_INVALID, 0)) {
      // Equivalent to kprintf("Upps!!!!!! Got invalid task %d, orig task %d\n",
      // current_task->id, orig_task->id);
      char message[N] = { '\0' };
      sprintf(message, "Upps!!!!!! Got invalid task %d, orig task %d\n",
              current_task->id, orig_task->id);
      eprint(message);
    }
    // Set current_task's status to TASK_RUNNING
    current_task->status = TASK_RUNNING;
    // Remove new task from queue
    // By the way, priority 0 is only used by the idle task and doesn't need own
    // queue
    readyqueues.queue[prio - 1].first = current_task->next;
    // if there's no next task in the queue
    if (!current_task->next) {
      readyqueues.queue[prio - 1].last = NULL;
      // ~ is Binary Ones Complement Operator has the effect of 'flipping' bits
      // &= is bitwise AND operator which turns (1 AND 0) or (0 AND 0) into 0
      readyqueues.prio_bitmap &= ~(1 << prio);
    }
    // Set the next and the previous tasks against current_task to NULL
    current_task->next = current_task->prev = NULL;
  }

get_task_out:
  if (current_task != orig_task) { // current_task is not orig_task
    // Equivalent to kprintf("schedule from %u to %u with prio %u\n",
    // orig_task->id,
    // current_task->id, (uint32_t)current_task->prio);
    char message[N] = { '\0' };
    sprintf(message, "schedule from %u to %u with prio %u\n", orig_task->id,
            current_task->id, (uint32_t)current_task->prio);
    eprint(message);
    // Returns the address of last_stack_pointer in orig_task
    return (size_t**)&(orig_task->last_stack_pointer);
  }

  return NULL;
}

void
reschedule(void)
{
  // pointer to pointer of address of stack
  size_t** stack;
  if ((stack = scheduler())) {
    switch_context(stack);
  }
}

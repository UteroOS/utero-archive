#include "make_string.h"
#include <asm/multiboot.h>
#include <tasks.h>
#include <stdio.h>
#include <stddef.h>
#include <processor.h>
#define N 256

// Parameters passed from assembly or linker
extern const void * kernel_start;
extern const void * kernel_end;
extern const void * bss_start;
extern const void * bss_end;
extern int eputs(const char*);
extern int eprint(const char*);

// int early_info(unsigned int ks, unsigned int ke)
// {
  // kernel_start = ks;
  // kernel_end = ke;

  // return 0;
// }

char *make_kernel_info()
{
  static char *str[N];
  char *fmt = "\
Kernel starts  at: %p\n\
Kernel ends    at: %p\n\
Bss starts     at: %p\n\
Bss ends       at: %p\n\
multiboot info at: %p\n";

  *str = make_string(fmt,
                     &kernel_start,
                     &kernel_end,
                     &bss_start,
                     &bss_end,
                     &mb_info);
  return *str;
}

static int
foo(void* arg)
{
  int i = 0;


  for (i = 0; i < 5; i++) {
    char *message;
    sprintf(message, "hello from %s\n", (char*)arg);
    eprint(message);
    reschedule();
  }

  return 0;
}

int create_foo(void)
{
  tid_t id1;
  tid_t id2;
  create_kernel_task(&id1, foo, "foo1", NORMAL_PRIO);
  create_kernel_task(&id2, foo, "foo2", NORMAL_PRIO);
  reschedule();

  while (1) {
    NOP8;
  }
  return 0;
}

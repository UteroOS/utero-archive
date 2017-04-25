#include "make_string.h"
#include "multiboot.h"
// #include "stdint.h"
#define N 256

// Parameters passed from assembly or linker
unsigned int kernel_start;
unsigned int kernel_end;

int early_info(unsigned int ks, unsigned int ke)
{
  kernel_start = ks;
  kernel_end = ke;

  return 0;
}

char *make_kernel_info()
{
  static char *str[N];
  char *fmt = "Kernel starts at: %p\nKernel ends   at: %p\n";

  *str = make_string(fmt,
                     &kernel_start,
                     &kernel_end);
  return *str;
}

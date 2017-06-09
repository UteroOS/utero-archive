#include "make_string.h"
#include <asm/multiboot.h>
// #include "stdint.h"
#define N 256

// Parameters passed from assembly or linker
extern const void * kernel_start;
extern const void * kernel_end;
extern const void * bss_start;
extern const void * bss_end;

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

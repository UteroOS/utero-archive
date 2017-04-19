#include "make_string.h"
#include "multiboot.h"
// #include "stdint.h"
#define N 256

// Parameters passed from assembly or linker
unsigned int multiboot_info_address;
unsigned int kernel_start;
unsigned int kernel_end;
unsigned int kernel_size;
multiboot_uint32_t mmap_len;
unsigned int address_of_module;

int early_info(unsigned int ks, unsigned int ke, unsigned int ebx)
{
  multiboot_info_address = ebx;
  multiboot_info_t *mbinfo = (multiboot_info_t *) multiboot_info_address;
  address_of_module = mbinfo->mods_addr;
  kernel_start = ks;
  kernel_end = ke;
  kernel_size = kernel_end - kernel_start;

  return 0;
}

char *make_kernel_info()
{
  static char *str[N];
  char *fmt = "Multiboot info address: %p\n\
Kernel starts at: %p\n\
Kernel ends   at: %p\n\
Kernel size: 0x%llx\n\
Address of module: %p\n";
  *str = make_string(fmt,
                     &multiboot_info_address,
                     &kernel_start,
                     &kernel_end,
                     kernel_size,
                     &address_of_module);
  return *str;
}

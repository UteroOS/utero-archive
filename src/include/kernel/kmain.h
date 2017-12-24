#ifndef KMAIN_H
#define KMAIN_H

#include <core/boot.h>

#define KERNEL_ASCII    " _____ _____ _____ _____ _____ \n" \
                        "|  |  |_   _|   __| __  |     |\n" \
                        "|  |  | | | |   __|    -|  |  |\n" \
                        "|_____| |_| |_____|__|__|_____|"


#define KERNEL_NAME    "utero"

#ifdef ENABLE_KERNEL_DEBUG
#define KERNEL_VERSION "DEBUG MODE"
#else
#define KERNEL_VERSION "0.5.0"
#endif

#define KERNEL_DATE     __DATE__
#define KERNEL_TIME     __TIME__

void kmain(unsigned long magic, unsigned long addr) __asm__("kmain");

#endif

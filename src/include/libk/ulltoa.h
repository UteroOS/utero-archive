#ifndef ULLTOA_H
#define ULLTOA_H

#include <musl/include/stdint.h>

void ulltoa(uint64_t n, char* str, int base);

#endif

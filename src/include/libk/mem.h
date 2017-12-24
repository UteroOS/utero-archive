#ifndef MEM_H
#define MEM_H

#include <musl/include/stddef.h>
#include <musl/include/stdint.h>

void memcpyk(void *src, void *dest, size_t bytes);

#endif

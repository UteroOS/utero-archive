#ifndef STDIO_H
#define STDIO_H

#include <musl/include/stdarg.h>
#include <musl/include/stdint.h>

#define DEVICE_SCREEN 0

void printfk(const char* format, ...);
void vprintfk(int device, const char* format, va_list arg);

#endif

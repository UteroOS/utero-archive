/*
Copyright 2016 Utero OS Developers. See the COPYRIGHT
file at the top-level directory of this distribution.
#
Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
<LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
option. This file may not be copied, modified, or distributed
except according to those terms.
*/

#ifndef _STRING_H
#define _STRING_H 1

#include "stddef.h"

int memcmp(const void* aptr, const void* bptr, size_t size);
void* memset(void* bufptr, int value, size_t size);
// size_t strlen(const char*);
// char* strcat(char* d, const char* s);
// char* strcpy(char* d, const char* s);
// int strcmp(const char * s1, const char * s2);
// char *strncat(char *dest, const char *src, size_t n);
// char *strncpy(char *dest, const char *src, size_t n);
// char *strstr(char *s1, const char *s2);
// char *strchr(const char *s, int c);
// int strncmp(const char * s1, const char * s2, size_t n);
// char *ctos(char s[2], const char c);
#endif

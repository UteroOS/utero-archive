/*
Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
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

/* Implemented (without *strerror)
Uncommented are used in test_libc */
void * memchr( const void * s, int c, size_t n );
int memcmp(const void* aptr, const void* bptr, size_t size);
void* memset(void* bufptr, int value, size_t size);
// char *strchr(const char *s, int c);
// char *strchrnul(const char *s, int c)
// int strcmp(const char * s1, const char * s2);
// char *strerror(int e)
// size_t strlen(const char*);
// int strncmp(const char * s1, const char * s2, size_t n);
// char* strcat(char* d, const char* s);
// char *strstr(char *s1, const char *s2);

/* Not Implemented yet */
// char* strcpy(char* d, const char* s);
// char *strncat(char *dest, const char *src, size_t n);
// char *strncpy(char *dest, const char *src, size_t n);
#endif

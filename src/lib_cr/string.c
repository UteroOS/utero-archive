/*
The part of this file was taken from:
musl https://www.musl-libc.org/
Licensed under permissive MIT license
*/

#include "string.h"

int memcmp(const void *vl, const void *vr, size_t n)
{
	const unsigned char *l=vl, *r=vr;
	for (; n && *l == *r; n--, l++, r++);
	return n ? *l-*r : 0;
}

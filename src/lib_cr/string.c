/*
The part of this file was taken from:
musl https://www.musl-libc.org/
Licensed under permissive MIT license
*/

/*
memset( void *, int, size_t )

The part of the Public Domain C Library (PDCLib).
Permission is granted to use, modify, and / or redistribute at will.
*/

#include "string.h"

int memcmp(const void *vl, const void *vr, size_t n)
{
	const unsigned char *l=vl, *r=vr;
	for (; n && *l == *r; n--, l++, r++);
	return n ? *l-*r : 0;
}

void * memset( void * s, int c, size_t n )
{
	unsigned char * p = (unsigned char *) s;
	while ( n-- )
	{
		*p++ = (unsigned char) c;
	}
	return s;
}

int strcmp( const char * s1, const char * s2 )
{
	while ( ( *s1 ) && ( *s1 == *s2 ) )
	{
		++s1;
		++s2;
	}
	return ( *(unsigned char *)s1 - *(unsigned char *)s2 );
}

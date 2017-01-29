/*
The part of this file was taken from:
musl https://www.musl-libc.org/
Licensed under permissive MIT license
*/

/*
The part of this file was taken from:
cyanurus https://github.com/redcap97/cyanurus
Licensed under the Apache License, Version 2.0
*/

/*
The part of the Public Domain C Library (PDCLib).
Permission is granted to use, modify, and / or redistribute at will.
*/

#include "string.h"

void * memchr( const void * s, int c, size_t n )
{
	const unsigned char * p = (const unsigned char *) s;
	while ( n-- )
	{
		if ( *p == (unsigned char) c )
		{
			return (void *) p;
		}
		++p;
	}
	return NULL;
}

int memcmp(const void *vl, const void *vr, size_t n)
{
	const unsigned char *l=vl, *r=vr;
	for (; n && *l == *r; n--, l++, r++);
	return n ? *l-*r : 0;
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

void * memset( void * s, int c, size_t n )
{
	unsigned char * p = (unsigned char *) s;
	while ( n-- )
	{
		*p++ = (unsigned char) c;
	}
	return s;
}

size_t strlen( const char * s )
{
	size_t rc = 0;
	while ( s[rc] )
	{
		++rc;
	}
	return rc;
}

char * strstr( const char * s1, const char * s2 )
{
	const char * p1 = s1;
	const char * p2;
	while ( *s1 )
	{
		p2 = s2;
		while ( *p2 && ( *p1 == *p2 ) )
		{
			++p1;
			++p2;
		}
		if ( ! *p2 )
		{
			return (char *) s1;
		}
		++s1;
		p1 = s1;
	}
	return NULL;
}

// Implementation using strlen and memcmp
// char *strstr(char *s1, const char *s2)
// {
// 	size_t n = strlen(s2);
// 	while (*s1)
// 		if (!memcmp(s1++, s2, n))
// 			return s1 - 1;
// 	return 0;
// }

char * strchr( const char * s, int c )
{
	do
	{
		if ( *s == (char) c )
		{
			return (char *) s;
		}
	} while ( *s++ );
	return NULL;
}

int strncmp( const char * s1, const char * s2, size_t n )
{
	while ( *s1 && n && ( *s1 == *s2 ) )
	{
		++s1;
		++s2;
		--n;
	}
	if ( n == 0 )
	{
		return 0;
	}
	else
	{
		return ( *(unsigned char *)s1 - *(unsigned char *)s2 );
	}
}

char *strchrnul(const char *s, int c) {
	unsigned char *r = (unsigned char*)s, a = (unsigned char)c;

	while (*r) {
		if (*r == a) {
			break;
		}
		r++;
	}
	return (char*)r;
}

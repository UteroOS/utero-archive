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

#include "ctype.h"

int isalpha(int c)
{
	return ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z'));
}

int isalnum(int c)
{
	return isalpha(c) || isdigit(c);
}

int isblank(int c)
{
	return (c == ' ' || c == '\t');
}

int iscntrl(int c)
{
	return (unsigned)c < 0x20 || c == 0x7f;
}

int isdigit(int c)
{
	return (c >= '0' && c <= '9');
}

// Printable characters without a space (0x21 ~ 0x7e)
// 0x7e - 0x21 = 0x5e
// That's why c - 0x21 < 0x5e;
int isgraph(int c)
{
	return (unsigned)c-0x21 < 0x5e;
}

int islower(int c)
{
	return (c >= 'a' && c <= 'z');
}

// Similar to isgraph function, but including a space (0x20)
// Printable characters (0x20 ~ 0x7e)
// 0x7e - 0x20 = 0x5f
// That's why c - 0x20 < 0x5f;
int isprint(int c)
{
	return (unsigned)c-0x20 < 0x5f;
}

int isspace(int c)
{
	return (c == ' ' || c == '\t' || c == '\n' || c == '\12');
}

int isupper(int c)
{
	return (c >= 'A' && c <= 'Z');
}

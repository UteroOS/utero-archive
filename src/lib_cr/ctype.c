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

int isalpha(char c)
{
	return ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z'));
}

int isdigit(char c)
{
	return (c >= '0' && c <= '9');
}

int islower(char c)
{
	return (c >= 'a' && c <= 'z');
}

int isspace(char c)
{
	return (c == ' ' || c == '\t' || c == '\n' || c == '\12');
}

int isupper(char c)
{
	return (c >= 'A' && c <= 'Z');
}

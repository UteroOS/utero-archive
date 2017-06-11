// Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
// file at the top-level directory of this distribution.
//
// Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
// http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
// <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
// option. This file may not be copied, modified, or distributed
// except according to those terms.

#include <stdio.h>
#include "make_string.h"
#define N 256

char *make_string(char *fmt, ...)
{
  static char s[N] = {'\0'};
  va_list ap;

  va_start(ap, fmt);
  vsprintf(s, fmt, ap);
  va_end(ap);

  return s;
}

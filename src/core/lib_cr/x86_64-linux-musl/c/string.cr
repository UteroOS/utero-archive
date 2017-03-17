# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

require "./stddef"

lib LibCR
  fun memchr(x0 : Void*, c : Int, n : SizeT) : Void*
  fun memcmp(x0 : Void*, x1 : Void*, x2 : SizeT) : Int
  fun strcmp(x0 : Char*, x1 : Char*) : Int
  # fun strerror(x0 : Int) : Char*
  fun strlen(x0 : Char*) : SizeT

  # Additional functions
  fun memset(dest : Void*, src : Int, len : SizeT) : Void*
  fun strchr(x0 : Char*, x1 : Int) : Char*
  fun strchrnul(x0 : Char*, x1 : Int) : Char*
  fun strncmp(x0 : Char*, x1 : Char*, n : SizeT) : Int
  fun strstr(x0 : Char*, x1 : Char*) : Char*
end

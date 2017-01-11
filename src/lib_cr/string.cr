# Copyright 2016 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

require "./stddef"

lib LibCR
  fun memcmp(x0 : Void*, x1 : Void*, x2 : SizeT) : Int
  fun memset(dest : Void*, src : Int, len : SizeT) : Void*
end

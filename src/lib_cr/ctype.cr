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
  fun isalpha(c : Char) : Int
  fun isalnum(c : Char) : Int
  fun isblank(c : Char) : Int
  fun iscntrl(c : Char) : Int
  fun isdigit(c : Char) : Int
  fun islower(c : Char) : Int
  fun isspace(c : Char) : Int
  fun isupper(c : Char) : Int
end

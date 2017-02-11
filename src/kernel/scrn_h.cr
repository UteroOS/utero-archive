# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

enum VGAColor : UInt8
  BLACK         #=> 0
  BLUE          #=> 1
  GREEN         #=> 2
  CYAN          #=> 3
  RED           #=> 4
  MAGENTA       #=> 5
  BROWN         #=> 6
  LIGHT_GREY    #=> 7
  DARK_GREY     #=> 8
  LIGHT_BLUE    #=> 9
  LIGHT_GREEN   #=> 10
  LIGHT_CYAN    #=> 11
  LIGHT_RED     #=> 12
  LIGHT_MAGENTA #=> 13
  LIGHT_BROWN   #=> 14
  WHITE         #=> 15
end

alias VGAColor_T = UInt8

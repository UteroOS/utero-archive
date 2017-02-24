# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

struct Pointer(T)
  def self.null
    new 0_u64
  end

  def +(other : Int)
    self + other.to_i64
  end

  def [](offset : Int)
    (self + offset).value
  end

  def []=(offset : Int, value : T)
    (self + offset).value = value
  end
end

# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

struct Int
  def >>(count)
    self.unsafe_shr(count)
  end

  def <<(count)
    self.unsafe_shl(count)
  end

  # from line 226
  def abs
    self >= 0 ? self : -self
  end

  def -
    0 - self
  end

  def /(x : Int)
    if x == 0
      self # raise DivisionByZero.new
    end

    unsafe_div x
  end

  def %(other : Int)
    if other == 0
      self # raise DivisionByZero.new
    elsif (self ^ other) >= 0
      self.unsafe_mod(other)
    else
      me = self.unsafe_mod(other)
      me == 0 ? me : me + other
    end
  end

  def times
    x = 0
    while x < self
      yield x
      x += 1
    end
  end
end

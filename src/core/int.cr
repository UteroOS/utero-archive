# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

struct Int
  alias Signed = Int8 | Int16 | Int32 | Int64
  alias Unsigned = UInt8 | UInt16 | UInt32 | UInt64
  alias Primitive = Signed | Unsigned

  def /(other : Int)
    check_div_argument other

    div = unsafe_div other
    mod = unsafe_mod other
    div -= 1 if other > 0 ? mod < 0 : mod > 0
    div
  end

  private def check_div_argument(other)
    if other == 0
      self # raise DivisionByZero.new
    end

    {% begin %}
      if self < 0 && self == {{@type}}::MIN && other == -1
        self # raise ArgumentError.new "overflow: {{@type}}::MIN / -1"
      end
    {% end %}
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

  def >>(count : Int)
    if count < 0
      self << count.abs
    elsif count < sizeof(self) * 8
      self.unsafe_shr(count)
    else
      self.class.zero
    end
  end

  def <<(count : Int)
    if count < 0
      self >> count.abs
    elsif count < sizeof(self) * 8
      self.unsafe_shl(count)
    else
      self.class.zero
    end
  end

  def abs
    self >= 0 ? self : -self
  end

  def ===(char : Char)
    self === char.ord
  end

  def times(&block : self ->) : Nil
    i = self ^ self
    while i < self
      yield i
      i += 1
    end
  end
  # TODO: Implement this!
  # def times
  #   TimesIterator(typeof(self)).new(self)
  # end

  def upto(to, &block : self ->) : Nil
    x = self
    while x <= to
      yield x
      x += 1
    end
  end
  # TODO: Implement this!
  # def upto(to)
  #   UptoIterator(typeof(self), typeof(to)).new(self, to)
  # end

  def downto(to, &block : self ->) : Nil
    x = self
    while x >= to
      yield x
      x -= 1
    end
  end
  # TODO: Implement this!
  # def downto(to)
  #   DowntoIterator(typeof(self), typeof(to)).new(self, to)
  # end
end

struct Int8
  MIN = -128_i8
  MAX =  127_i8

  # Returns an `Int8` by invoking `to_i8` on *value*.
  def self.new(value)
    value.to_i8
  end

  def -
    0_i8 - self
  end

  # def popcount
  #   Intrinsics.popcount8(self)
  # end

  def clone
    self
  end
end

struct Int16
  MIN = -32768_i16
  MAX =  32767_i16

  # Returns an `Int16` by invoking `to_i16` on *value*.
  def self.new(value)
    value.to_i16
  end

  def -
    0_i16 - self
  end

  # def popcount
  #   Intrinsics.popcount16(self)
  # end

  def clone
    self
  end
end

struct Int32
  MIN = -2147483648_i32
  MAX =  2147483647_i32

  # Returns an `Int32` by invoking `to_i32` on *value*.
  def self.new(value)
    value.to_i32
  end

  def -
    0 - self
  end

  # def popcount
  #   Intrinsics.popcount32(self)
  # end

  def clone
    self
  end
end

struct Int64
  MIN = -9223372036854775808_i64
  MAX =  9223372036854775807_i64

  # Returns an `Int64` by invoking `to_i64` on *value*.
  def self.new(value)
    value.to_i64
  end

  def -
    0_i64 - self
  end

  # def popcount
  #   Intrinsics.popcount64(self)
  # end

  def clone
    self
  end
end

struct UInt8
  MIN =   0_u8
  MAX = 255_u8

  # Returns an `UInt8` by invoking `to_u8` on *value*.
  def self.new(value)
    value.to_u8
  end

  def abs
    self
  end

  # def popcount
  #   Intrinsics.popcount8(self)
  # end

  def clone
    self
  end
end

struct UInt16
  MIN =     0_u16
  MAX = 65535_u16

  # Returns an `UInt16` by invoking `to_u16` on *value*.
  def self.new(value)
    value.to_u16
  end

  def abs
    self
  end

  # def popcount
  #   Intrinsics.popcount16(self)
  # end

  def clone
    self
  end
end

struct UInt32
  MIN =          0_u32
  MAX = 4294967295_u32

  # Returns an `UInt32` by invoking `to_u32` on *value*.
  def self.new(value)
    value.to_u32
  end

  def abs
    self
  end

  # def popcount
  #   Intrinsics.popcount32(self)
  # end

  def clone
    self
  end
end

struct UInt64
  MIN =                    0_u64
  MAX = 18446744073709551615_u64

  # Returns an `UInt64` by invoking `to_u64` on *value*.
  def self.new(value)
    value.to_u64
  end

  def abs
    self
  end

  # def popcount
  #   Intrinsics.popcount64(self)
  # end

  def clone
    self
  end
end

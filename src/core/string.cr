# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

# The part of this file and line numbers are taken from:
# https://github.com/crystal-lang/crystal/blob/0.21.0/src/string.cr
class String
  # Returns the number of bytes in this string.
  #
  # ```
  # "hello".bytesize # => 5
  # "你好".bytesize    # => 6
  # ```
  # line: 280
  def bytesize
    @bytesize
  end

  def bytes
    # Array.new(bytesize) { |i| to_unsafe[i] }
    pointerof(@c)
  end

  def each_byte
    size.times do |i|
      yield bytes[i], i
    end
  end

  # line: 905
  def unsafe_byte_at(index)
    to_unsafe[index]
  end

  # line: 3065
  protected def char_bytesize_at(byte_index)
    first = unsafe_byte_at(byte_index)

    if first < 0x80
      return 1
    end

    if first < 0xc2
      return 1
    end

    second = unsafe_byte_at(byte_index + 1)
    if (second & 0xc0) != 0x80
      return 1
    end

    if first < 0xe0
      return 2
    end

    third = unsafe_byte_at(byte_index + 2)
    if (third & 0xc0) != 0x80
      return 2
    end

    if first < 0xf0
      return 3
    end

    if first == 0xf0 && second < 0x90
      return 3
    end

    if first == 0xf4 && second >= 0x90
      return 3
    end

    return 4
  end

  # Returns the number of unicode codepoints in this string.
  #
  # ```
  # "hello".size # => 5
  # "你好".size    # => 2
  # ```
  # line: 3911
  def size
    if @length > 0 || @bytesize == 0
      return @length
    end

    @length = each_byte_index_and_char_index { }
  end

  # line: 4009
  protected def each_byte_index_and_char_index
    byte_index = 0
    char_index = 0

    while byte_index < bytesize
      yield byte_index, char_index
      byte_index += char_bytesize_at(byte_index)
      char_index += 1
    end

    char_index
  end

  # Returns a pointer to the underlying bytes of this String.
  # line: 4046
  def to_unsafe : UInt8*
    pointerof(@c)
  end
end

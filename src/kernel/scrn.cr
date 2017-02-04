# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

struct Scrn
  def initialize
    @framebuffer = Pointer(UInt16).new(0xb8000u64)
    @col = 0
    @row = 0
    80.times do |col|
      16.times do |row|
        @framebuffer[row * 80 + col] = 0u16
      end
    end
  end

  private def put_byte(byte)
    if byte == '\n'.ord
      @col = 0
      @row += 1
      return
    end
    if byte == '\r'.ord
      @col = 0
      return
    end
    if byte == '\t'.ord
      @col = (@col + 8) / 8 * 8
      if @col >= 80
        @col = 0
        @row += 1
      end
      return
    end
    @framebuffer[@row * 80 + @col] = ((15u16 << 8) | (0u16 << 12) | byte).as UInt16
    @col += 1
    if @col == 80
      @col = 0
      @row += 1
    end
  end

  def print(str)
    str.each_byte { |byte| put_byte(byte) }
  end

  def puts(str)
    print(str)
    @col = 0
    @row += 1
  end
end

SCRN = Scrn.new

def print(str)
  SCRN.print(str)
end

def puts(str)
  SCRN.puts(str)
end

def puts
  print "\n"
end

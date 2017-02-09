# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

struct Scrn
  # Constants
  private TAB_SIZE = 8
  private VGA_WIDTH = 80
  private VGA_HEIGHT = 25
  # private VGA_SIZE = VGA_WIDTH * VGA_HEIGHT
  private VGA_MEMORY = Pointer(UInt16).new(0xb8000_u64)

  def initialize
    @vmem = VGA_MEMORY
    @col = 0
    @row = 0
    VGA_WIDTH.times do |col|
      VGA_HEIGHT.times do |row|
        @vmem[row * VGA_WIDTH + col] = 0_u16
      end
    end
  end

  private def scroll
    VGA_WIDTH.times do |col|
      VGA_HEIGHT.times do |row|
        @vmem[row * VGA_WIDTH + col] = @vmem[(row + 1) * VGA_WIDTH + col]
      end
    end
    @row = VGA_HEIGHT - 1
  end

  private def linebreak
    @col = 0
    @row += 1
    if @row == VGA_HEIGHT
      scroll
    end
  end

  private def put_byte(byte)
    if byte == '\n'.ord
      linebreak
      return
    end
    if byte == '\r'.ord
      @col = 0
      return
    end
    if byte == '\t'.ord
      # Handles a tab by incrementing the cursor's x, but only
      # to a point that will make it divisible by TAB_SIZE
      @col = (@col + TAB_SIZE) / TAB_SIZE * TAB_SIZE
      linebreak if @col >= VGA_WIDTH
      return
    end

    @vmem[@row * VGA_WIDTH + @col] = ((15_u16 << 8) | (0_u16 << 12) | byte).as(UInt16)
    @col += 1
    linebreak if @col == VGA_WIDTH
  end

  def print(str)
    str.each_byte { |byte| put_byte(byte) }
  end

  def puts(str)
    print(str)
    linebreak
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

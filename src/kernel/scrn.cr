# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.
require "../arch/x86_64/io"
require "./scrn_h"

struct Scrn
  # Constants
  private TAB_SIZE = 8
  private VGA_WIDTH = 80
  private VGA_HEIGHT = 25
  private VGA_SIZE = VGA_WIDTH * VGA_HEIGHT
  private VGA_MEMORY = Pointer(UInt16).new(0xb8000_u64)
  private VGA_FG_COLOR = VGAColor::LIGHT_GREEN.value
  private VGA_BG_COLOR = VGAColor::BLACK.value

  def initialize
    @vmem = VGA_MEMORY
    @cur_x = 0
    @cur_y = 0
    @vga_color = set_default_color.as(UInt8)

    VGA_WIDTH.times do |cur_x|
      VGA_HEIGHT.times do |cur_y|
        @vmem[cur_y * VGA_WIDTH + cur_x] = 0_u16
      end
    end
    clear
  end

  private def scroll
    # Move the current text chunk that makes up the screen
    # back in the buffer by a line
    VGA_WIDTH.times do |cur_x|
      VGA_HEIGHT.times do |cur_y|
        @vmem[cur_y * VGA_WIDTH + cur_x] = @vmem[(cur_y + 1) * VGA_WIDTH + cur_x]
      end
    end

    # Insert VGA_WIDTH blank character to the last line
    VGA_WIDTH.times do |cur_x|
      @vmem[VGA_SIZE - VGA_WIDTH + cur_x] = (@vga_color.to_u16 << 8 | ' '.ord).as(UInt16)
    end

    # The cursor should be on the last line
    @cur_y = VGA_HEIGHT - 1
  end

  # Comments are taken from http://www.osdever.net/bkerndev/Docs/printing.htm
  # Updates the hardware cursor: the little blinking line
  # on the screen under the last character pressed!
  private def move_csr
    # The equation for finding the index in a linear
    # chunk of memory can be represented by:
    # Index = [(y * width) + x]
    temp = @cur_y * VGA_WIDTH + @cur_x

    # This sends a command to indicies 14 and 15 in the
    # CRT Control Register of the VGA controller. These
    # are the high and low bytes of the index that show
    # where the hardware cursor is to be 'blinking'. To
    # learn more, you should look up some VGA specific
    # programming documents. A great start to graphics:
    # http://www.brackeen.com/home/vga
    outb(0x3d4_u16, 15_u8)
    outb(0x3d5_u16, temp.to_u8)
    outb(0x3d4_u16, 14_u8)
    outb(0x3d5_u16, (temp >> 8).to_u8)
  end

  def clear
    attr = 0x0f.to_u16 << 8 | ' '.ord
    VGA_SIZE.times { |i| @vmem[i] = attr }

    @cur_x = 0
    @cur_y = 0
    move_csr
  end

  private def linebreak
    @cur_x = 0
    @cur_y += 1
    scroll if @cur_y == VGA_HEIGHT
    move_csr
  end

  private def put_byte(byte)
    if byte == '\n'.ord
      linebreak
      return
    end
    if byte == '\r'.ord
      @cur_x = 0
      return
    end
    if byte == '\t'.ord
      # Handles a tab by incrementing the cursor's x, but only
      # to a point that will make it divisible by TAB_SIZE
      @cur_x = (@cur_x + TAB_SIZE) / TAB_SIZE * TAB_SIZE
      linebreak if @cur_x >= VGA_WIDTH
      return
    end
    # Backspace
    if byte == '\b'.ord
      if @cur_x == 0
        @cur_y = @cur_y > 0 ? @cur_y - 1 : 0
        @cur_x = VGA_WIDTH - 1
      else
        @cur_x -= 1
      end
      @vmem[@cur_y * VGA_WIDTH + @cur_x] = (@vga_color.to_u16 << 8 | ' '.ord).as(UInt16)
      return
    end

    @vmem[@cur_y * VGA_WIDTH + @cur_x] = (@vga_color.to_u16 << 8 | byte).as(UInt16)
    @cur_x += 1
    linebreak if @cur_x == VGA_WIDTH
    move_csr
  end

  def set_default_color
    @vga_color = VGA_BG_COLOR << 4 | VGA_FG_COLOR
  end

  def set_color(fc : VGAColor_T, bc : VGAColor_T) : VGAColor_T
    @vga_color = bc << 4 | fc
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

def clear
  SCRN.clear
end

def set_color(fc : VGAColor_T, bc : VGAColor_T)
  SCRN.set_color(fc, bc)
end

def reset_color
  SCRN.set_default_color
end

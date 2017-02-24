# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

require "../spec_helper"
require "../../src/lib_cr/ctype"

describe "LibCR" do
  describe "fun isalpha(c : Char) : Int" do
    context "Returns non-zero when an English character" do
      it { LibCR.isalpha('a'.ord).should_not eq 0 }
      it { LibCR.isalpha('z'.ord).should_not eq 0 }
    end

    context "Returns zero when a non-English character" do
      it { LibCR.isalpha(' '.ord).should eq 0 }
      it { LibCR.isalpha('1'.ord).should eq 0 }
      it { LibCR.isalpha('@'.ord).should eq 0 }
    end

    context "Returns non-zero when a Japanese character (Hiragana)" do
      it { LibCR.isalpha('あ'.ord).should_not eq 0 }
      it { LibCR.isalpha('っ'.ord).should_not eq 0 }
    end

    context "Returns zero when a Japanese character (without Hiragana)" do
      it { LibCR.isalpha('ア'.ord).should eq 0 }
      it { LibCR.isalpha('亜'.ord).should eq 0 }
    end

    context "Returns zero when a Japanese character (Historical kana orthography)" do
      # Historical kana orthography
      # https://en.wikipedia.org/wiki/Historical_kana_orthography
      # 'i'
      it { LibCR.isalpha('ゐ'.ord).should eq 0 }
      it { LibCR.isalpha('ヰ'.ord).should eq 0 }
      # 'e'
      it { LibCR.isalpha('ゑ'.ord).should eq 0 }
      it { LibCR.isalpha('ヱ'.ord).should eq 0 }
    end
  end

  describe "fun isalnum(c : Char) : Int" do
    context "Return non-zero when a character or a digit" do
      char_or_digits = ['a', 'z', 'A', 'Z', '0', '9']
      char_or_digits.each do |c|
        it { LibCR.isalnum(c.ord).should_not eq 0 }
      end
    end

    context "Return zero when a non-character or a non-digit" do
      it { LibCR.isalnum(' '.ord).should eq 0 }
      it { LibCR.isalnum('\n'.ord).should eq 0 }
      it { LibCR.isalnum('@'.ord).should eq 0 }
    end
  end

  describe "fun isblank(c : Char) : Int" do
    context "Returns non-zero when a white-space or a tab character" do
      it { LibCR.isblank(' '.ord).should_not eq 0 }
      it { LibCR.isblank('\t'.ord).should_not eq 0 }
    end

    context "Returns zero when not a white-space or a tab character" do
      it { LibCR.isblank('\v'.ord).should eq 0 }
      it { LibCR.isblank('\r'.ord).should eq 0 }
      it { LibCR.isblank('x'.ord).should eq 0 }
      it { LibCR.isblank('@'.ord).should eq 0 }
    end

    context "Returns zero when a Zenkaku white-space (due to unsupport locales?)" do
      it { LibCR.isblank('　'.ord).should eq 0 }
    end
  end

  describe "fun iscntrl(c : Char) : Int" do
    context "Returns non-zero when a control character" do
      # Crystal does not support '\a' ?
      # https://github.com/crystal-lang/crystal/issues/3078#issuecomment-238630121
      # it { LibCR.iscntrl('\a'.ord).should_not eq 0 } # Bell
      it { LibCR.iscntrl(0x07).should_not eq 0 }     # Bell

      control_chars = ['\0', '\b', '\t', '\n', '\v', '\f', '\r']
      control_chars.each do |c|
        it { LibCR.iscntrl(c.ord).should_not eq 0 }
      end
    end

    context "Returns zero when not a control character" do
      it { LibCR.iscntrl(' '.ord).should eq 0 }
    end
  end

  describe "fun isdigit(c : Char) : Int" do
    context "Returns non-zero when a digit" do
      it { LibCR.isdigit('0'.ord).should_not eq 0 }
      it { LibCR.isdigit('9'.ord).should_not eq 0 }
    end

    context "Returns zero when a non-digit" do
      it { LibCR.isdigit(' '.ord).should eq 0 }
      it { LibCR.isdigit('a'.ord).should eq 0 }
      it { LibCR.isdigit('@'.ord).should eq 0 }
    end
  end

  describe "fun isgraph(c : Char) : Int" do
    context "Returns non-zero when a printable character without a space" do
      (0x21..0x7e).each do |c|
        it { LibCR.isgraph(c).should_not eq 0}
      end
    end

    context "Returns zero when a control character" do
      (0x00..0x1f).each do |c|
        it { LibCR.isgraph(c).should eq 0 }
      end
    end

    context "Returns zero when a space" do
      it { LibCR.isgraph(0x20).should eq 0 }
    end

    context "Returns zero when a DELETE" do
      # 0x7f (DELETE)
      it { LibCR.isgraph(0x7f).should eq 0 }
    end
  end

  describe "fun islower(c : Char) : Int" do
    context "Returns non-zero when lowercase" do
      it { LibCR.islower('a'.ord).should_not eq 0 }
      it { LibCR.islower('z'.ord).should_not eq 0 }
    end

    context "Returns zero when non-lowercase" do
      non_lowercases = ['A', 'Z', ' ', '@']
      non_lowercases.each do |c|
        it { LibCR.islower(c.ord).should eq 0 }
      end
    end
  end

  describe "fun isprint(c : Char) : Int" do
    context "Returns non-zero when a printable character (including a space)" do
      (0x20..0x7e).each do |c|
        it { LibCR.isprint(c).should_not eq 0}
      end
    end

    context "Returns zero when a control character" do
      (0x00..0x1f).each do |c|
        it { LibCR.isprint(c).should eq 0 }
      end
    end

    context "Returns zero when a DELETE" do
      # 0x7f (DELETE)
      it { LibCR.isprint(0x7f).should eq 0 }
    end
  end

  describe "fun ispunct(c : Char) : Int" do
    context "Returns non-zero when a punctuation character" do
      (0x21..0x29).each do |c|
        it { LibCR.ispunct(c).should_not eq 0 }
      end

      (0x2a..0x2f).each do |c|
        it { LibCR.ispunct(c).should_not eq 0 }
      end

      (0x3a..0x3f).each do |c|
        it { LibCR.ispunct(c).should_not eq 0 }
      end

      it { LibCR.ispunct(0x40).should_not eq 0 }

      (0x5b..0x60).each do |c|
        it { LibCR.ispunct(c).should_not eq 0 }
      end

      (0x7b..0x7d).each do |c|
        it { LibCR.ispunct(c).should_not eq 0 }
      end
    end
  end

  # checks  for  white-space  characters.   In  the  "C" and "POSIX"
  # locales, these are: space,  form-feed  ('\f'),  newline  ('\n'),
  # carriage  return ('\r'), horizontal tab ('\t'), and vertical tab
  # ('\v').
  describe "fun isspace(c : Char) : Int" do
    context "Returns non-zero when a white-space character" do
      white_space_chars = [' ', '\f', '\n', '\r', '\t', '\v']
      white_space_chars.each do |c|
        it { LibCR.isspace(c.ord).should_not eq 0 }
      end
    end

    context "Returns zero when without a white-space character" do
      it { LibCR.isspace('a'.ord).should eq 0 }
    end
  end

  describe "fun isupper(c : Char) : Int" do
    context "Returns non-zero when uppercase" do
      it { LibCR.isupper('A'.ord).should_not eq 0 }
      it { LibCR.isupper('Z'.ord).should_not eq 0 }
    end

    context "Returns zero when non-uppercase" do
      non_uppercases = ['a', 'z', ' ', '@']
      non_uppercases.each do |c|
        it { LibCR.isupper(c.ord).should eq 0 }
      end
    end
  end

  describe "fun isxdigit(c : Char) : Int" do
    context "Returns non-zero when a hexadicimal digit" do
      hex_digits = ['0', '9', 'a', 'f', 'A', 'F']
      hex_digits.each do |c|
        it { LibCR.isxdigit(c.ord).should_not eq 0 }
      end
    end

    context "Returns zero when not a hexadicimal digit" do
      non_hex_digits = ['g', 'G', '@', ' ']
      non_hex_digits.each do |c|
        it { LibCR.isxdigit(c.ord).should eq 0 }
      end
    end
  end
end

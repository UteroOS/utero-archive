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
      assert { LibCR.isalpha('a'.ord).should_not eq 0 }
      assert { LibCR.isalpha('z'.ord).should_not eq 0 }
    end

    context "Returns zero when a non-English character" do
      assert { LibCR.isalpha(' '.ord).should eq 0 }
      assert { LibCR.isalpha('1'.ord).should eq 0 }
      assert { LibCR.isalpha('@'.ord).should eq 0 }
    end

    context "Returns non-zero when a Japanese character (Hiragana)" do
      assert { LibCR.isalpha('あ'.ord).should_not eq 0 }
      assert { LibCR.isalpha('っ'.ord).should_not eq 0 }
    end

    context "Returns zero when a Japanese character (without Hiragana)" do
      assert { LibCR.isalpha('ア'.ord).should eq 0 }
      assert { LibCR.isalpha('亜'.ord).should eq 0 }
    end

    context "Returns zero when a Japanese character (Historical kana orthography)" do
      # Historical kana orthography
      # https://en.wikipedia.org/wiki/Historical_kana_orthography
      # 'i'
      assert { LibCR.isalpha('ゐ'.ord).should eq 0 }
      assert { LibCR.isalpha('ヰ'.ord).should eq 0 }
      # 'e'
      assert { LibCR.isalpha('ゑ'.ord).should eq 0 }
      assert { LibCR.isalpha('ヱ'.ord).should eq 0 }
    end
  end

  describe "fun isalnum(c : Char) : Int" do
    context "Return non-zero when a character or a digit" do
      char_or_digits = ['a', 'z', 'A', 'Z', '0', '9']
      char_or_digits.each do |c|
        assert { LibCR.isalnum(c.ord).should_not eq 0 }
      end
    end

    context "Return zero when a non-character or a non-digit" do
      assert { LibCR.isalnum(' '.ord).should eq 0 }
      assert { LibCR.isalnum('\n'.ord).should eq 0 }
      assert { LibCR.isalnum('@'.ord).should eq 0 }
    end
  end

  describe "fun isblank(c : Char) : Int" do
    context "Returns non-zero when a white-space or a tab character" do
      assert { LibCR.isblank(' '.ord).should_not eq 0 }
      assert { LibCR.isblank('\t'.ord).should_not eq 0 }
    end

    context "Returns zero when not a white-space or a tab character" do
      assert { LibCR.isblank('\v'.ord).should eq 0 }
      assert { LibCR.isblank('\r'.ord).should eq 0 }
      assert { LibCR.isblank('x'.ord).should eq 0 }
      assert { LibCR.isblank('@'.ord).should eq 0 }
    end

    context "Returns zero when a Zenkaku white-space (due to unsupport locales?)" do
      assert { LibCR.isblank('　'.ord).should eq 0 }
    end
  end

  describe "fun iscntrl(c : Char) : Int" do
    context "Returns non-zero when a control character" do
      # Crystal does not support '\a' ?
      # https://github.com/crystal-lang/crystal/issues/3078#issuecomment-238630121
      # assert { LibCR.iscntrl('\a'.ord).should_not eq 0 } # Bell
      assert { LibCR.iscntrl(0x07).should_not eq 0 }     # Bell

      control_chars = ['\0', '\b', '\t', '\n', '\v', '\f', '\r']
      control_chars.each do |c|
        assert { LibCR.iscntrl(c.ord).should_not eq 0 }
      end
    end

    context "Returns zero when not a control character" do
      assert { LibCR.iscntrl(' '.ord).should eq 0 }
    end
  end

  describe "fun isdigit(c : Char) : Int" do
    context "Returns non-zero when a digit" do
      assert { LibCR.isdigit('0'.ord).should_not eq 0 }
      assert { LibCR.isdigit('9'.ord).should_not eq 0 }
    end

    context "Returns zero when a non-digit" do
      assert { LibCR.isdigit(' '.ord).should eq 0 }
      assert { LibCR.isdigit('a'.ord).should eq 0 }
      assert { LibCR.isdigit('@'.ord).should eq 0 }
    end
  end

  describe "fun isgraph(c : Char) : Int" do
    context "Returns non-zero when a printable character without a space" do
      (0x21..0x7e).each do |c|
        assert { LibCR.isgraph(c).should_not eq 0}
      end
    end

    context "Returns zero when a control character" do
      (0x00..0x1f).each do |c|
        assert { LibCR.isgraph(c).should eq 0 }
      end
    end

    context "Returns zero when a space" do
      assert { LibCR.isgraph(0x20).should eq 0 }
    end

    context "Returns zero when a DELETE" do
      # 0x7f (DELETE)
      assert { LibCR.isgraph(0x7f).should eq 0 }
    end
  end

  describe "fun islower(c : Char) : Int" do
    context "Returns non-zero when lowercase" do
      assert { LibCR.islower('a'.ord).should_not eq 0 }
      assert { LibCR.islower('z'.ord).should_not eq 0 }
    end

    context "Returns zero when non-lowercase" do
      non_lowercases = ['A', 'Z', ' ', '@']
      non_lowercases.each do |c|
        assert { LibCR.islower(c.ord).should eq 0 }
      end
    end
  end

  describe "fun isprint(c : Char) : Int" do
    context "Returns non-zero when a printable character (including a space)" do
      (0x20..0x7e).each do |c|
        assert { LibCR.isprint(c).should_not eq 0}
      end
    end

    context "Returns zero when a control character" do
      (0x00..0x1f).each do |c|
        assert { LibCR.isprint(c).should eq 0 }
      end
    end

    context "Returns zero when a DELETE" do
      # 0x7f (DELETE)
      assert { LibCR.isprint(0x7f).should eq 0 }
    end
  end

  describe "fun ispunct(c : Char) : Int" do
    context "Returns non-zero when a punctuation character" do
      (0x21..0x29).each do |c|
        assert { LibCR.ispunct(c).should_not eq 0 }
      end

      (0x2a..0x2f).each do |c|
        assert { LibCR.ispunct(c).should_not eq 0 }
      end

      (0x3a..0x3f).each do |c|
        assert { LibCR.ispunct(c).should_not eq 0 }
      end

      assert { LibCR.ispunct(0x40).should_not eq 0 }

      (0x5b..0x60).each do |c|
        assert { LibCR.ispunct(c).should_not eq 0 }
      end

      (0x7b..0x7d).each do |c|
        assert { LibCR.ispunct(c).should_not eq 0 }
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
        assert { LibCR.isspace(c.ord).should_not eq 0 }
      end
    end

    context "Returns zero when without a white-space character" do
      assert { LibCR.isspace('a'.ord).should eq 0 }
    end
  end

  describe "fun isupper(c : Char) : Int" do
    context "Returns non-zero when uppercase" do
      assert { LibCR.isupper('A'.ord).should_not eq 0 }
      assert { LibCR.isupper('Z'.ord).should_not eq 0 }
    end

    context "Returns zero when non-uppercase" do
      non_uppercases = ['a', 'z', ' ', '@']
      non_uppercases.each do |c|
        assert { LibCR.isupper(c.ord).should eq 0 }
      end
    end
  end

  describe "fun isxdigit(c : Char) : Int" do
    context "Returns non-zero when a hexadicimal digit" do
      hex_digits = ['0', '9', 'a', 'f', 'A', 'F']
      hex_digits.each do |c|
        assert { LibCR.isxdigit(c.ord).should_not eq 0 }
      end
    end

    context "Returns zero when not a hexadicimal digit" do
      non_hex_digits = ['g', 'G', '@', ' ']
      non_hex_digits.each do |c|
        assert { LibCR.isxdigit(c.ord).should eq 0 }
      end
    end
  end
end

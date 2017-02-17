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
  describe "fun isupper(c : Char) : Int" do
    context "Returns non-zero when uppercase" do
      assert { LibCR.isupper('A'.ord).should_not eq 0 }
      assert { LibCR.isupper('Z'.ord).should_not eq 0 }
    end

    context "Returns zero when non-uppercase" do
      assert { LibCR.isupper('a'.ord).should eq 0 }
      assert { LibCR.isupper('z'.ord).should eq 0 }
      assert { LibCR.isupper(' '.ord).should eq 0 }
      assert { LibCR.isupper('@'.ord).should eq 0 }
    end
  end

  describe "fun islower(c : Char) : Int" do
    context "Returns non-zero when lowercase" do
      assert { LibCR.islower('a'.ord).should_not eq 0 }
      assert { LibCR.islower('z'.ord).should_not eq 0 }
    end

    context "Returns zero when non-lowercase" do
      assert { LibCR.islower('A'.ord).should eq 0 }
      assert { LibCR.islower('Z'.ord).should eq 0 }
      assert { LibCR.islower(' '.ord).should eq 0 }
      assert { LibCR.islower('@'.ord).should eq 0 }
    end
  end

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

  # checks  for  white-space  characters.   In  the  "C" and "POSIX"
  # locales, these are: space,  form-feed  ('\f'),  newline  ('\n'),
  # carriage  return ('\r'), horizontal tab ('\t'), and vertical tab
  # ('\v').
  describe "fun isspace(c : Char) : Int" do
    context "Returns non-zero when a white-space character" do
      assert { LibCR.isspace(' '.ord).should_not eq 0 }
      assert { LibCR.isspace('\f'.ord).should_not eq 0 }
      assert { LibCR.isspace('\n'.ord).should_not eq 0 }
      assert { LibCR.isspace('\r'.ord).should_not eq 0 }
      assert { LibCR.isspace('\t'.ord).should_not eq 0 }
      assert { LibCR.isspace('\v'.ord).should_not eq 0 }
    end

    context "Returns zero when without a white-space character" do
      assert { LibCR.isspace('a'.ord).should eq 0 }
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

  describe "fun isalnum(c : Char) : Int" do
    context "Return non-zero when a character or a digit" do
      assert { LibCR.isalnum('a'.ord).should_not eq 0 }
      assert { LibCR.isalnum('z'.ord).should_not eq 0 }
      assert { LibCR.isalnum('A'.ord).should_not eq 0 }
      assert { LibCR.isalnum('Z'.ord).should_not eq 0 }
      assert { LibCR.isalnum('0'.ord).should_not eq 0 }
      assert { LibCR.isalnum('9'.ord).should_not eq 0 }
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
      assert { LibCR.iscntrl('\0'.ord).should_not eq 0 } # Null
      # Crystal does not support '\a' ?
      # https://github.com/crystal-lang/crystal/issues/3078#issuecomment-238630121
      # assert { LibCR.iscntrl('\a'.ord).should_not eq 0 } # Bell
      assert { LibCR.iscntrl(0x07).should_not eq 0 }     # Bell
      assert { LibCR.iscntrl('\b'.ord).should_not eq 0 } # Backspace
      assert { LibCR.iscntrl('\t'.ord).should_not eq 0 } # Horizontal Tabulation
      assert { LibCR.iscntrl('\n'.ord).should_not eq 0 } # Line Feed
      assert { LibCR.iscntrl('\v'.ord).should_not eq 0 } # Vertical Tabulation
      assert { LibCR.iscntrl('\f'.ord).should_not eq 0 } # Form Feed
      assert { LibCR.iscntrl('\r'.ord).should_not eq 0 } # Carriage Return
    end

    context "Returns zero when not a control character" do
      assert { LibCR.iscntrl(' '.ord).should eq 0 }
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

    assert { LibCR.isgraph('a'.ord).should_not eq 0 }
    assert { LibCR.isgraph('z'.ord).should_not eq 0 }
    assert { LibCR.isgraph('A'.ord).should_not eq 0 }
    assert { LibCR.isgraph('Z'.ord).should_not eq 0 }
    assert { LibCR.isgraph('@'.ord).should_not eq 0 }
    assert { LibCR.isgraph('\t'.ord).should eq 0 }
    assert { LibCR.isgraph('\0'.ord).should eq 0 }
    assert { LibCR.isgraph(' '.ord).should eq 0 }
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

    assert { LibCR.isprint('a'.ord).should_not eq 0 }
    assert { LibCR.isprint('z'.ord).should_not eq 0 }
    assert { LibCR.isprint('A'.ord).should_not eq 0 }
    assert { LibCR.isprint('Z'.ord).should_not eq 0 }
    assert { LibCR.isprint('@'.ord).should_not eq 0 }
    assert { LibCR.isprint('\t'.ord).should eq 0 }
    assert { LibCR.isprint('\0'.ord).should eq 0 }
    assert { LibCR.isprint(' '.ord).should_not eq 0 }
  end

  # TODO: sort describes by alphabetical order
end

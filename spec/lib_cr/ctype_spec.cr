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
end

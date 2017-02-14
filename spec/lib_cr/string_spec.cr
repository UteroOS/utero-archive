# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

require "../spec_helper"
require "../../src/lib_cr/string"
# FIXME: or KILLME
# require "../../src/lib_cr/no_bind/libstring"
# include NoBind

describe "LibCR" do
  context "memcmp" do
    ptr1 = Pointer.malloc(4) { |i| i + 1 }  # [1, 2, 3, 4]
    ptr2 = Pointer.malloc(4) { |i| i + 11 } # [11, 12, 13, 14]
    assert { LibCR.memcmp(ptr1, ptr2, 4).should be < 0 }
    assert { LibCR.memcmp(ptr2, ptr1, 4).should be > 0 }
    assert { LibCR.memcmp(ptr1, ptr1, 4).should eq 0 }
  end

  context "memcmp - given strings" do
    str1 = "abcx"
    str2 = "abcd"
    assert { LibCR.memcmp(str1, str2, 4).should be > 0 }
    assert { LibCR.memcmp(str2, str1, 4).should be < 0 }
    assert { LibCR.memcmp(str1, str1, 4).should eq 0 }
  end

  context "memcmp - given two strings with different sizes" do
    str1 = "abcdefghijk"
    str2 = "abcd"
    assert { LibCR.memcmp(str1, str2, 4).should eq 0 }
    assert { LibCR.memcmp(str2, str1, 4).should eq 0 }
  end

  describe "memset" do
    ptr = Pointer.malloc(4) { |i| i + 10 } # [10, 11, 12, 13]

    context "assign 0 to len" do
      it "does not change the value of pointer" do
        LibCR.memset(ptr, 0_i32, 0_u64)
        ptr.to_slice(4).should eq Slice[10, 11, 12, 13]
      end
    end

    context "assign 1 to size" do
      it "sets zero to the first value of pointer" do
        LibCR.memset(ptr, 0_i32, 1_u64)
        ptr.to_slice(4).should eq Slice[0, 11, 12, 13]
      end
    end
  end

  context "strlen" do
    str1 = "abcde"
    str2 = "あいうえお"
    assert { LibCR.strlen(str1).should eq 5 }
    assert { LibCR.strlen(str2).should eq 15 }
  end

  context "strcmp" do
    assert { LibCR.strcmp("abcde", "abcde").should eq 0 }
    assert { LibCR.strcmp("abcde", "abcdx").should be < 0 }
    assert { LibCR.strcmp("abcdx", "abcde").should be > 0 }
    assert { LibCR.strcmp("", "abcde").should be < 0 }
    assert { LibCR.strcmp("abcde", "").should be > 0 }
    assert { LibCR.strcmp("abcde", "abcd#{'\u{00fc}'}").should be < 0 } # "abcd#{'\u{00fc}'}" == abcdü"

    # Comparing two strings with different sizes
    assert { LibCR.strcmp("abcde", "abcdef").should be < 0 }
    assert { LibCR.strcmp("abcdef", "abcde").should be > 0 }

    # Comparing one byte characters and triple-byte characters
    assert { LibCR.strcmp("abcde", "あいうえお").should be < 0 }
    assert { LibCR.strcmp("あいうえお", "abcde").should be > 0 }
  end

  describe "strstr" do
    str = "abcabcabcdabcde"

    puts abcabcabcdabcde_ptr = LibCR.strstr(str, "abcabcabcdabcde") # equal to the pointer of s[0]

    assert { LibCR.strstr(str, "x").should eq Pointer(UInt8).null }
    assert { LibCR.strstr(str, "xyz").should eq Pointer(UInt8).null }
    assert { LibCR.strstr(str, "a").should eq abcabcabcdabcde_ptr }
    assert { LibCR.strstr(str, "abc").should eq abcabcabcdabcde_ptr }
    assert { LibCR.strstr(str, "abcd").should eq abcabcabcdabcde_ptr + 6 }
    assert { LibCR.strstr(str, "abcde").should eq abcabcabcdabcde_ptr + 10 }
  end

  describe "strchr" do
    abccd = "abccd"
    # pass the code point of 'a' to 2nd argument
    abccd_ptr = LibCR.strchr(abccd, 'a'.ord) # equal to the pointer of abccd[0]

    assert { LibCR.strchr(abccd, 'x'.ord).should eq Pointer(UInt8).null }
    assert { LibCR.strchr(abccd, 'a'.ord).should eq abccd_ptr }
    assert { LibCR.strchr(abccd, 'd'.ord).should eq abccd_ptr + 4 }
    assert { LibCR.strchr(abccd, '\0'.ord).should eq abccd_ptr + 5 }
    assert { LibCR.strchr(abccd, 'c'.ord).should eq abccd_ptr + 2 }
  end

  describe "strncmp" do
    abcde = "abcde"
    abcdx = "abcdx"
    cmpabcde = "abcde\u{0}f"
    cmpabcd_ = "abcde\u{fc}" # \u{fc} == ü
    empty = ""
    x = "x"

    assert { LibCR.strncmp(abcde, cmpabcde, 5).should eq 0 }
    assert { LibCR.strncmp(abcde, cmpabcde, 10).should eq 0 }
    assert { LibCR.strncmp(abcde, abcdx, 5).should be < 0 }
    assert { LibCR.strncmp(abcdx, abcde, 5).should be > 0 }
    assert { LibCR.strncmp(empty, abcde, 5).should be < 0 }
    assert { LibCR.strncmp(abcde, empty, 5).should be > 0 }
    assert { LibCR.strncmp(abcde, abcdx, 4).should eq 0 }
    assert { LibCR.strncmp(abcde, x, 0).should eq 0 }
    assert { LibCR.strncmp(abcde, x, 1).should be < 0 }
    assert { LibCR.strncmp(abcde, cmpabcd_, 6).should be < 0 }

    # Comparing one byte characters and triple-byte characters
    assert { LibCR.strncmp("abcde", "あいうえお", 15).should be < 0 }
    assert { LibCR.strncmp("あいうえお", "abcde", 15).should be > 0 }

    # Comparing the both of triple-byte characters
    assert { LibCR.strncmp("あいうえお", "あいうえか", 15).should be < 0 }
    assert { LibCR.strncmp("あいうえか", "あいうえお", 15).should be > 0 }
    assert { LibCR.strncmp("あいうえお", "あいうえか", 12).should eq 0 }
  end

  describe "strchrnul" do
    blank = ""
    blank_ptr = LibCR.strchrnul(blank, '\u{0}'.ord)
    str = "abcabc"
    str_ptr = LibCR.strchrnul(str, 'a'.ord)

    assert { LibCR.strchrnul(blank, 'A'.ord).should eq blank_ptr }
    assert { LibCR.strchrnul(blank, '\u{0}'.ord).should eq blank_ptr }

    assert { LibCR.strchrnul(str, 'A'.ord).should eq str_ptr + 6 }
    assert { LibCR.strchrnul(str, 'a'.ord).should eq str_ptr + 0 }
    assert { LibCR.strchrnul(str, 'c'.ord).should eq str_ptr + 2 }
    assert { LibCR.strchrnul(str, '\u{0}'.ord).should eq str_ptr + 6 }
  end

  describe "memchr" do
    abcde = "abcde"
    abcde_ptr = LibCR.memchr(abcde, 'a'.ord, 1) # equal to the pointer of abcde[0]

    assert { LibCR.memchr(abcde, 'c'.ord, 5).should eq abcde_ptr + 2 }
    assert { LibCR.memchr(abcde, 'a'.ord, 1).should eq abcde_ptr }
    assert { LibCR.memchr(abcde, 'a'.ord, 0).should eq Pointer(Void).null }
    assert { LibCR.memchr(abcde, '\0'.ord, 5).should eq Pointer(Void).null }
    assert { LibCR.memchr(abcde, '\0'.ord, 6).should eq abcde_ptr + 5 }
  end
end

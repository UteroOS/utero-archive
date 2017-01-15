# Copyright 2016 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

require "../spec_helper"
require "../../src/lib_cr/string"
require "../../src/lib_cr/no_bind/libstring"
include NoBind

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
    assert { LibString.strlen(str1.as(UInt8*)).should eq 5 }
    assert { LibString.strlen(str2.as(UInt8*)).should eq 15 }
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
end

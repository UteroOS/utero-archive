# Copyright 2016 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

require "./spec_helper"
require "../src/lib_cr/libcr"

describe "LibCR" do
  context "memcmp" do
    ptr1 = Pointer.malloc(4) { |i| i + 1 }  # [1, 2, 3, 4]
    ptr2 = Pointer.malloc(4) { |i| i + 11 } # [11, 12, 13, 14]
    assert { LibCR.memcmp(ptr1.as(Void*), ptr2.as(Void*), 4 * sizeof(Int32)).should be < 0 }
    assert { LibCR.memcmp(ptr2.as(Void*), ptr1.as(Void*), 4 * sizeof(Int32)).should be > 0 }
    assert { LibCR.memcmp(ptr1.as(Void*), ptr1.as(Void*), 4 * sizeof(Int32)).should eq 0 }
  end

  context "memcmp - given strings" do
    str1 = "abcx"
    str2 = "abcd"
    assert { LibCR.memcmp(str1.as(Void*), str2.as(Void*), 4 * sizeof(String)).should be > 0 }
    assert { LibCR.memcmp(str2.as(Void*), str1.as(Void*), 4 * sizeof(String)).should be < 0 }
    assert { LibCR.memcmp(str1.as(Void*), str1.as(Void*), 4 * sizeof(String)).should eq 0 }
  end
end

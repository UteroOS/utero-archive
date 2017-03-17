# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

# This was taken from crystal/src/lib_c.cr

lib LibCR
  alias Char = UInt8
  alias UChar = Char
  alias SChar = Int8
  alias Short = Int16
  alias UShort = UInt16
  alias Int = Int32
  alias UInt = UInt32

  {% if flag?(:x86_64) || flag?(:aarch64) %}
    alias Long = Int64
    alias ULong = UInt64
  {% elsif flag?(:i686) || flag?(:arm) %}
    alias Long = Int32
    alias ULong = UInt32
  {% end %}

  alias LongLong = Int64
  alias ULongLong = UInt64
  alias Float = Float32
  alias Double = Float64

  $environ : Char**
end

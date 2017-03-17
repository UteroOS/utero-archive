# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

# This was take from
# crystal/src/lib_c/x86_64-linux-musl/c/stddef.cr

# Lookup core/lib_cr.cr
require "../../../lib_cr"

lib LibCR
  alias SizeT = ULong
end

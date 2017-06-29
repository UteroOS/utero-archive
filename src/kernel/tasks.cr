# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.
require "./lib_u"

# tasks.c
lib LibU
  fun multitasking_init : LibU::Int
  fun reschedule : Void
  fun create_kernel_task(id : LibU::Tid_t*, ep : Void* -> LibU::Int, args : Void*, prio : LibU::UInt8_t) : Int
end

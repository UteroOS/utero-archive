# Copyright 2016 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

require "./arch/x86_64/scrn"
require "./core/libcr"

puts
puts "Hello World from Crystal!!!"
puts
puts "Welcome to Utero!!!"
puts

puts "---------memcmp------------"
puts "Comparing 'abcx' and 'abcv' returns 2"
ptr1 = "abcx"
ptr2 = "abcv"

result = LibCR.memcmp(ptr1.as(Void*), ptr2.as(Void*), 4 * sizeof(String))
puts "Displays 'memcmp' twice"
result.times do
  puts "memcmp"
end

# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

require "../core/prelude"
require "./scrn"
# require "./lib_cr/string"
# FIXME: or KILLME
# require "./lib_cr/no_bind/libstring"
# include NoBind

puts
puts "Hello World from Crystal!!!"
puts
puts "Welcome to Utero!!!"
puts
puts "\t\t\t\t\t\t\t\t\t\t\ttab * 11 = 80 cols + 8 cols(in the next line)"

# puts "---------strlen------------"
# ab = "abc"
# ab_len = LibString.strlen(ab.as(LibCR::Char*))
# ab_len.times do
#   print "3 bytes "
# end
#
# puts
#
# ai = "あい"
# ai_len1 = LibString.strlen(ai.as(LibCR::Char*))
# ai_len1.times do
#   print "6 bytes "
# end
# puts

# puts
# puts "---------memcmp------------"
# puts "Comparing 'abcx' and 'abcv' returns 2"
# ptr1 = "abcx"
# ptr2 = "abcv"
#
# result = LibCR.memcmp(ptr1.as(Void*), ptr2.as(Void*), 4 * sizeof(String))
# puts "Displays 'memcmp' twice"
# result.times do
#   puts "memcmp"
# end

# puts
# puts "---------strcmp------------"
# str1 = "abcde"
# str2 = "abcdf"
# puts "Comparing 'abcde' and 'abcde'"
# strcmp_result = LibString.strcmp(str1.as(LibCR::Char*), str1.as(LibCR::Char*))
# puts "returns 0" if strcmp_result == 0
#
# puts "Comparing 'abcde' and 'abcdf'"
# strcmp_result = LibString.strcmp(str1.as(LibCR::Char*), str2.as(LibCR::Char*))
# puts "returns -1" if strcmp_result == -1
#
# puts "Comparing 'abcdf' and 'abcde'"
# strcmp_result = LibString.strcmp(str2.as(LibCR::Char*), str1.as(LibCR::Char*))
# puts "returns 1" if strcmp_result == 1

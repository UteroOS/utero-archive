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

puts "1:"
puts "2:"
puts "3:"
puts "4:"
puts "5:"
puts "6:"
puts "7:"
puts "8:"
puts "9:"
puts "10:"
puts "11:"
puts "12:"
puts "13:"
puts "14:"
puts "15:"
puts "16:"
puts "17:"
puts "18:"
puts "19:"
puts "20:"
puts "21:"
puts "22:"
puts "23:"
print "24: This line uses print method + \\n\n"

set_color(VGAColor::WHITE.value, VGAColor::BLACK.value)
puts "25: "
puts "26: Hello World from Crystal!!!"
puts "27: "
puts "28: Welcome to Utero!!!"
puts "29: "
puts "30: \t\t\t\t\t\t\t\t\t\t\ttab * 11 = 80 cols + 8 cols(in the next line)"
reset_color
puts "31: Reset Color"
# print 80 characters and insert a blank into the end of line
print "32: 5678901234567890123456789012345678901234567890123456789012345678901234567890"
print "\b"; puts
puts "33: Current directory is #{__DIR__}"
print "34: "; Hello.hello_from_c
# clear

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

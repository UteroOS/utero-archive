# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

require "../core/prelude"
require "./prelude"
require "./utero_init"

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
print "34: "; cprint(LibU.hello_from_c)
cprint(LibU.dummy_exception)
# For testing: Division By Zero
# 42 / 0
# clear
# This would fail...
# LibU.create_foo

# Testing for String
# #bytesize
# "hello".bytesize # => 5
"你好".bytesize    # => 6
"你好".bytesize.times do
  print "你好" # It's garbled, but print 6 times
end
puts

# #unsafe_byte_at
"hello".unsafe_byte_at(0) #=> 104

# #empty?
puts "Not empty" unless "hello".empty?

# #byte_index
"hello".byte_index('l'.ord) #=> 3
"foo bar booz".byte_index('o'.ord, 3) #=> 9

# #each_byte
"ab".each_byte do |byte| #=> 'a' is 97, 'b' is 98
  (byte - 96).times do
    print "each_byte" #=> So, print "each_byte" 3 times
  end
end
puts

# "你好".size    #=> 2
"你好".size.times do
  print "你好" # It's garbled, but print 2 times
end
puts

# #dup
dup = "foo".dup
puts dup #=> puts "foo"

# #clone
clone = "foo".clone
puts clone #=> puts "foo"

# Testing for Int
# #upto
sum = 0
1.upto(3) do |n|
  sum += n
end
sum.times do
  print "upto" #=> print "upto" 6 times
end
puts

# #downto
sum = 0
3.downto(1) do |n|
  sum += n
end
sum.times do
  print "downto" #=> print "downto" 6 times
end
puts

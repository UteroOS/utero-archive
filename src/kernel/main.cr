# Copyright (c) 2016-2017 Utero OS Developers. See the COPYRIGHT
# file at the top-level directory of this distribution.
#
# Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
# http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
# <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
# option. This file may not be copied, modified, or distributed
# except according to those terms.

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

# Calling core test method
# Uncomment these lines when you test
# clear
# core_test

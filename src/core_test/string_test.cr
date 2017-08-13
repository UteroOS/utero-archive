def string_test
  puts "---------------"
  puts "Test for String"
  puts "---------------"

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

end

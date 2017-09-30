private class ComparableTestClass
  include Comparable(Int)

  def initialize(@value : Int32)
  end

  def <=>(other : Int)
    @value <=> other
  end
end

# TODO: include Comparable in Number
# def comparable_test
#   obj = ComparableTestClass.new(4)
#   puts "It can compare against Int" unless obj == 3
#   puts "It can compare against Int" unless obj < 3
#   puts "It can compare against Int" if obj > 3
# end

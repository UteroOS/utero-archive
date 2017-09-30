# The top-level number type.
struct Number
  # TODO: Implement this!
  # include Comparable(Number)
  # TODO: Implement this!
  # alias Primitive = Int::Primitive | Float::Primitive
  alias Primitive = Int::Primitive

  def self.zero : self
    new(0)
  end
end

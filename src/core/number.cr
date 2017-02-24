# The top-level number type.
struct Number
  # include Comparable(Number)

  # alias Primitive = Int::Primitive | Float::Primitive
  alias Primitive = Int::Primitive

  def self.zero : self
    new(0)
  end
end

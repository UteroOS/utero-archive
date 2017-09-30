def pointer_test
  puts "----------------"
  puts "Test for Pointer"
  puts "----------------"

  # #null?
  a = 1
  puts "pointerof(1) returns false" unless pointerof(a).null?

  b = Pointer(Int32).new(0)
  puts "Pointer(Int32).new(0) returns true" if b.null?

  # #+
  ptr1 = Pointer(Int32).new(1234)
  puts "ptr1:  address is 1234" if ptr1.address == 1234

  # An Int32 occupies four bytes
  puts "ptr1 + 1 (Int32, 4 bytes)"
  ptr2 = ptr1 + 1
  puts "ptr2: address is 1238" if ptr2.address == 1238


  puts "ptr2 - 1 (Int32, 4 bytes)"
  ptr3 = ptr2 - 1
  puts "ptr3: address is 1234" if ptr3.address == 1234

  # self.null
  ptr = Pointer(Int32).null
  puts "address of self.null returns 0" if ptr.address == 0

  # #clone
  ptr = Pointer(Int32).new(123)
  puts "pointer can be cloned" if ptr.clone.address == 123
end

private def reset(p1, p2)
  p1.value = 10
  p2.value = 20
end

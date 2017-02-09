def outb(port : UInt16, val : UInt8)
  # __asm__ volatile ("outb %0,%1" : : "a" (__val), "dN" (__port));
  asm("outb $1, $0" :: "{dx}"(port), "{al}"(val) :: "volatile")
end

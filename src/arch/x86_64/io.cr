@[AlwaysInline]
def outb(port : UInt16, val : UInt8)
  asm("outb $1, $0" :: "{dx}"(port), "{al}"(val) :: "volatile")
end

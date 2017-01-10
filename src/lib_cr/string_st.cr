struct StringST
  def self.strlen(str : UInt8*) : UInt64
    str[4].to_u64 # Byte size of str is in it
  end

  # Alternative
  # def self.strlen(str : UInt8*) : UInt64
  #   ret = 0_u64
  #   # str[12] seems to be the starting point of string
  #   while str[12 + ret] != 0
  #     ret += 1_u64
  #   end
  #   ret
  # end
end

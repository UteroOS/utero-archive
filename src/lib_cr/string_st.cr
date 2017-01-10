struct StringST
  def self.strlen(str : UInt8*) : UInt64
    str[4].to_u64 # Byte size of str is in it
  end
end

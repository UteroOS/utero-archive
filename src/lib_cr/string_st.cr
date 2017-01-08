struct StringST
  def self.strlen(str : UInt8*) : UInt8
    str[4] # Byte size of str is in it
  end
end

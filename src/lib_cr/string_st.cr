module NoBind
  struct LibString
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

    # fun strcmp(x0 : Char*, x1 : Char*) : Int
    def self.strcmp(x0 : UInt8*, x1 : UInt8*) : Int32
      # What a shit this is
      ret = x0 - x1

      case ret
      when .> 0
        ret = 1_i32
      when .< 0
        ret = -1_i32
      else
        ret = 0_i32
      end

      return ret.as(Int32)
    end
  end
end

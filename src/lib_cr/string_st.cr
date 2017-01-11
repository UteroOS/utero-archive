require "./stddef"

module NoBind
  struct LibString
    def self.strlen(str : LibCR::Char*) : LibCR::SizeT
      str[4].to_u64 # Byte size of str is in it
    end

    # Alternative
    # def self.strlen(str : LibCR::Char*) : LibCR::SizeT
    #   ret = 0_u64
    #   # str[12] seems to be the starting point of string
    #   while str[12 + ret] != 0
    #     ret += 1_u64
    #   end
    #   ret
    # end

    def self.strcmp(x0 : LibCR::Char*, x1 : LibCR::Char*) : LibCR::Int
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

      return ret.as(LibCR::Int)
    end
  end
end

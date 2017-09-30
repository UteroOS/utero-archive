require "./prelude"
require "./scrn"
require "../core_test/test"

lib LibU
  fun make_kernel_info : LibU::Char*
  fun create_foo : LibU::Int
end

# A same named function in C, and call that from assembly before call main
# fun early_info(info : LibBootstrap::EarlyInfo)
#   puts "Call early_info"
#   puts "Info here" if info
#   cprint(LibU.make_string("kernel_start: %p\nkernel_end:   %p\n", info.kernel_start, info.kernel_end))
#   cprint(LibU.make_string("Dummy Exception (%d) at 0x%llx:0x%llx, error code 0x%llx, rflags 0x%llx\n",
#   7, 0x8000000000000000, 0x8000000000000000, 0x8000000000000000, 0x8000000000000000))
# end

# On C code, it makes string to display addresses of kernel_start, kernel_end, etc...
# and print it on Crystal (it's so complecated, you know...)
cprint LibU.make_kernel_info
LibU.idt_install
LibU.isrs_install
LibU.multitasking_init

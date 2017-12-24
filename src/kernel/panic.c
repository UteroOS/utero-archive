#include <kernel/panic.h>
#include <core/isr.h>
#include <libk/printfk.h>
#include <drivers/screen.h>

void kernel_panic(const char* format, ...)
{
    va_list arg;
    va_start(arg, format);
    vprintfk(DEVICE_SCREEN, format, arg);
    va_end(arg);

    printfk("\nSystem halted!\n");

    // completely stop
    irq_disable();
    while (1) ;
}

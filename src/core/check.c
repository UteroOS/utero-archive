#include <core/check.h>
#include <libk/printfk.h>
#include <core/timer.h>
#include <drivers/screen.h>

void check_interrupts()
{
    printfk("- checking interrupts... ");

    uint32_t tick = timer_tick();
    while (tick == timer_tick()) ;

    printfk("OK\n");
}

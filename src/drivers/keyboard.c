#include <drivers/keyboard.h>
#include <core/isr.h>
#include <core/ports.h>
#include <libk/printfk.h>
#include <unused.h>
#include <drivers/screen.h>

#define SCANCODE_MAX 57

static void keyboard_callback(stack_t *stack)
{
    uint8_t scancode = port_byte_in(KEYBOARD_DATA_PORT);

    if (scancode > SCANCODE_MAX) {
        return;
    }

    printfk("Received scancode: %d\n", scancode);

    UNUSED(*stack);
}

void keyboard_init()
{
    register_interrupt_handler(IRQ1, keyboard_callback);
}

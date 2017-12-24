#include <libk/strrev.h>
#include <musl/include/string.h>

void strrev(char* s)
{
    char c;
    for (size_t i = 0, j = strlen(s) - 1; i < j; i++, j--) {
        c = s[i];
        s[i] = s[j];
        s[j] = c;
    }
}

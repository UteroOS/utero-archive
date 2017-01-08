#include <assert.h>
#include "string.h"

int main(int argc, char const *argv[]) {
  char ptr1[] = { 1, 2, 3, 4 };
  char ptr2[] = { 11, 12, 13, 14 };

  assert(memcmp(ptr1, ptr2, 4) < 0);
  assert(memcmp(ptr2, ptr1, 4) > 0);
  assert(memcmp(ptr1, ptr1, 4) == 0);

  return 0;
}

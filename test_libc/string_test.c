#include <assert.h>
#include <stdio.h>
#include "string.h"

int main(int argc, char const *argv[]) {
	char ptr1[] = { 1, 2, 3, 4 };
	char ptr2[] = { 11, 12, 13, 14 };

	assert(memcmp(ptr1, ptr2, 4) < 0);
	assert(memcmp(ptr2, ptr1, 4) > 0);
	assert(memcmp(ptr1, ptr1, 4) == 0);

	char s[] = "xxxxxxxxx";
	memset(s, 'o', 10);		// len is over
	assert(s[9] == 'o');	// the last char (and the whole) has been changed
	memset(s, '_', 0);		// len == zero
	assert(s[0] == 'o');	// so, string didn't be changed
	memset(s, '_', 1);
	assert(s[0] == '_');

	char s1[] = "xxxxxxxxx";
	memset(s1+1, '1', 3);
	assert(s1[0] != '1');
	assert(s1[1] == '1');
	assert(s1[2] == '1');
	assert(s1[3] == '1');
	assert(s1[4] != '1');

	return 0;
}

#define N 256

char * dummy_exception() {
  static char s[N] = {'\0'};
  int error_num = 7;
  long long int a = (long long int)1 << 63;
  long long int b = (long long int)1 << 63;
  long long int c = (long long int)1 << 63;
  long long int d = (long long int)1 << 63;

  sprintf(s, "Dummy Exception (%d) at 0x%llx:0x%llx, error code 0x%llx, rflags 0x%llx\n",
    error_num, a, b, c, d);

  return s;
}

char * hello_from_c(void) {
  static char s[N] = {'\0'};
  sprintf(s, "%s\n", "Hello from C");
  return s;
}

#define N 256

char * hello_from_c(void) {
  static char s[N] = {'\0'};
  sprintf(s, "%s\n", "Hello from C");
  return s;
}

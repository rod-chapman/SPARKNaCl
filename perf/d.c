#include <stdio.h>
void dh (const char *s, const unsigned char *d, const int n)
{
  int i;
  printf ("%s\n", s);
  for (i = 0; i < n; i++)
    {
      printf ("16#%02X# ",(unsigned int) d[i]);
      if (i % 8 == 7) printf("\n");
    }
  printf("\n");
}


void dgf (const char *s, const long long *d)
{
  int i;
  printf ("%s\n", s);
  for (i = 0; i < 16; i++)
    {
      printf (" %lld", d[i]);
    }
  printf("\n");
}

void dgs (const char *s, const long long *d)
{
  int i;
  printf ("%s\n", s);
  for (i = 0; i < 64; i++)
    {
      printf (" %lld", d[i]);
    }
  printf("\n");
}

void dll (const char *s, const long long d)
{
  printf ("%s\n", s);
  printf ("%lld\n", d);
}

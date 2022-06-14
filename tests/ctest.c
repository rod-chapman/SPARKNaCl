#include <stdio.h>

#define FOR(i,n) for (i = 0;i < n;++i)
#define sv static void
typedef long long i64;
typedef i64 gf[16];

sv car25519(gf o)
{
    // Faster version owing to WireGuard, and also unroll the final
    // iteration
    int i;
    for (i = 0; i < 15; ++i) {
        o[(i + 1)] += (o[i] >> 16);
        o[i] &= 0xffff;
    }
    o[0] += 38 * (o[15] >> 16);
    o[15] &= 0xffff;
}

sv M(gf o,const gf a,const gf b)
{
  i64 lt,i,t[31];

  FOR(i,31) t[i]=0;

  FOR(i,16)
  {
    // Inner loop unrolled and refactored as per SPARKNaCl
    lt = a[i];
    t[i]  +=lt*b[0];
    t[i+1]+=lt*b[1];
    t[i+2]+=lt*b[2];
    t[i+3]+=lt*b[3];
    t[i+4]+=lt*b[4];
    t[i+5]+=lt*b[5];
    t[i+6]+=lt*b[6];
    t[i+7]+=lt*b[7];
    t[i+8]+=lt*b[8];
    t[i+9]+=lt*b[9];
    t[i+10]+=lt*b[10];
    t[i+11]+=lt*b[11];
    t[i+12]+=lt*b[12];
    t[i+13]+=lt*b[13];
    t[i+14]+=lt*b[14];
    t[i+15]+=lt*b[15];
  }

  printf ("T is\n");
  FOR(i,31) printf("%016llx\n", t[i]);

  FOR(i,15) t[i]+=38*t[i+16];
  FOR(i,16) o[i]=t[i];

  printf ("O1 is\n");
  FOR(i,16) printf("%016llx\n", o[i]);


  car25519(o);

  printf ("O2 is\n");
  FOR(i,16) printf("%016llx\n", o[i]);

  car25519(o);

  printf ("O3 is\n");
  FOR(i,16) printf("%016llx\n", o[i]);
}


int main() {
    const gf l = { 0x9EDF,
                   0x7DDB,
                   0x7D7B,
                   0xB4C1,
                   0x5BD3,
                   0xC261,
                   0xE4EC,
                   0x3735,
                   0x833F,
                   0xC843,
                   0x785B,
                   0x4D67,
                   0xFCAD,
                   0x147E,
                   0x886F,
                   0x4F2B };
    gf m;


    M(m, l, l);

    return 0;
}

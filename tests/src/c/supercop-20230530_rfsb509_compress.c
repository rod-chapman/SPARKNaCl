#include "supercop-20230530_rfsb509_compress.h"
#include "supercop-20230530_rfsb509_matrix.h"

#include <stdint.h>

typedef uint64_t uint64;

static uint64 load_littleendian(const unsigned char *x)
{
  return
      (uint64) (x[0]) \
  | (((uint64) (x[1])) << 8) \
  | (((uint64) (x[2])) << 16) \
  | (((uint64) (x[3])) << 24) \
  | (((uint64) (x[4])) << 32) \
  | (((uint64) (x[5])) << 40) \
  | (((uint64) (x[6])) << 48) \
  | (((uint64) (x[7])) << 56)
  ;
}

static void store_littleendian(unsigned char *x,uint64 u)
{
  x[0] = u; u >>= 8;
  x[1] = u; u >>= 8;
  x[2] = u; u >>= 8;
  x[3] = u; u >>= 8;
  x[4] = u; u >>= 8;
  x[5] = u; u >>= 8;
  x[6] = u; u >>= 8;
  x[7] = u;
}

typedef struct{
  uint64 x[10];
} column;

static void column_load(column *c, unsigned char pos)
{
  unsigned int p = (unsigned int)pos << 6;
  c->x[0] = load_littleendian(rfsb509_matrix + p +  0);
  c->x[1] = load_littleendian(rfsb509_matrix + p +  8);
  c->x[2] = load_littleendian(rfsb509_matrix + p + 16);
  c->x[3] = load_littleendian(rfsb509_matrix + p + 24);
  c->x[4] = load_littleendian(rfsb509_matrix + p + 32);
  c->x[5] = load_littleendian(rfsb509_matrix + p + 40);
  c->x[6] = load_littleendian(rfsb509_matrix + p + 48);
  c->x[7] = load_littleendian(rfsb509_matrix + p + 56);
  c->x[8] = 0;
  c->x[9] = 0;
}

static void column_mulx128(column *c)
{
  int i;
  for(i=9;i>1;i--) 
    c->x[i] = c->x[i-2];
  c->x[0] = 0;
  c->x[1] = 0;
}

static void column_modx509(column *c)
{
  uint64 t;
  t = c->x[7] >> 61;
  c->x[0] ^= t;

  t = c->x[8] << 3;
  c->x[0] ^= t;

  t = c->x[8] >> 61;
  c->x[1] ^= t;

  t = c->x[9] << 3;
  c->x[1] ^= t;

  t = c->x[9] >> 61;
  c->x[2] ^= t;

  c->x[7] &= 0x1fffffffffffffffUL;
  c->x[8] = 0;
  c->x[9] = 0;
}

static void column_add(column *r, column *x)
{
  int i;
  for(i=0;i<10;i++)
    r->x[i] ^= x->x[i];
}

int rfsb509_crypto_hashblocks(
  unsigned char *r,
  const unsigned char *b,
  unsigned long long blen
  )
{
  unsigned char state[64];
  unsigned char positions[128];
  int i;
  column v,t;

  for (i = 0;i < 64;++i) state[i] = r[i];

  while (blen >= 48) {
    for(i=0;i<64;i++) positions[i] = state[i];
    for(i=64;i<112;i++) positions[i] = b[i-64];
    
    column_load(&v, positions[0]);
    for(i=1;i<112;i++)
    {
      column_mulx128(&v);
      column_load(&t, positions[i]);
      column_add(&v, &t);
      column_modx509(&v);
    }
    for(i=0;i<8;i++)
      store_littleendian(state + 8*i,v.x[i]);
    b += 48;
    blen -= 48;
  }

  for (i = 0;i < 64;++i) r[i] = state[i];
  return blen;
}

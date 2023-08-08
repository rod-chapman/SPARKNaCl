#include "supercop-20230530_rfsb509_hash.h"

#include "supercop-20230530_rfsb509_compress.h"
#include "supercop-20230530_sha256_blocks.h"

static const char sha256_iv[32] = {
  0x6a,0x09,0xe6,0x67,
  0xbb,0x67,0xae,0x85,
  0x3c,0x6e,0xf3,0x72,
  0xa5,0x4f,0xf5,0x3a,
  0x51,0x0e,0x52,0x7f,
  0x9b,0x05,0x68,0x8c,
  0x1f,0x83,0xd9,0xab,
  0x5b,0xe0,0xcd,0x19,
} ;

int _rfsb509_crypto_hash(
  unsigned char *out,
  const unsigned char *in,
  unsigned long long inlen
  )
{
  int i;
  unsigned char t[128] = {0};
  unsigned char pad[96];
  int padlen;
  int remaining = rfsb509_crypto_hashblocks(t,in,inlen);

  if(remaining <= 40)
    padlen = 48;
  else
    padlen = 96;

  for(i=0;i<remaining;i++)
    pad[i] = in[inlen-remaining+i];
  for(; i<padlen-8;i++)
    pad[i] = 0;
  for(; i<padlen;i++)
    pad[i] = (inlen >> 8*(i-padlen+8)) & 0xff;

  rfsb509_crypto_hashblocks(t,pad,padlen);

  for (i = 0;i < 32;++i) out[i] = sha256_iv[i];
  t[64] = 0x80;
  t[64+62] = 2;
  sha256_crypto_hashblocks(out,t,128);
  return 0;
}

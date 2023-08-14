#ifndef H_SUPERCOP_20230530_SHA512_BLOCKS_H
#define H_SUPERCOP_20230530_SHA512_BLOCKS_H

int sha256_crypto_hashblocks(
 unsigned char *statebytes,
 const unsigned char *in,
 unsigned long long inlen
 );
#endif // H_SUPERCOP_20230530_SHA512_BLOCKS_H

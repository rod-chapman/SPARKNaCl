#ifndef SPARKNACL_H
#define SPARKNACL_H

#define crypto_sign_PRIMITIVE "ed25519"
#define crypto_sign crypto_sign_ed25519
#define crypto_sign_open crypto_sign_ed25519_open
#define crypto_sign_keypair crypto_sign_ed25519_keypair
#define crypto_sign_BYTES crypto_sign_ed25519_BYTES
#define crypto_sign_PUBLICKEYBYTES crypto_sign_ed25519_PUBLICKEYBYTES
#define crypto_sign_SECRETKEYBYTES crypto_sign_ed25519_SECRETKEYBYTES
#define crypto_sign_IMPLEMENTATION crypto_sign_ed25519_IMPLEMENTATION
#define crypto_sign_VERSION crypto_sign_ed25519_VERSION
#define crypto_sign_ed25519_spark_BYTES 64
#define crypto_sign_ed25519_spark_PUBLICKEYBYTES 32
#define crypto_sign_ed25519_spark_SECRETKEYBYTES 64
extern int crypto_sign_ed25519_spark(unsigned char *,unsigned long long *,const unsigned char *,unsigned long long,const unsigned char *);
extern int crypto_sign_ed25519_spark_open(unsigned char *,unsigned long long *,const unsigned char *,unsigned long long,const unsigned char *);
extern int crypto_sign_ed25519_spark_keypair(unsigned char *,unsigned char *);
#define crypto_sign_ed25519_spark_VERSION "-"
#define crypto_sign_ed25519 crypto_sign_ed25519_spark
#define crypto_sign_ed25519_open crypto_sign_ed25519_spark_open
#define crypto_sign_ed25519_keypair crypto_sign_ed25519_spark_keypair
#define crypto_sign_ed25519_BYTES crypto_sign_ed25519_spark_BYTES
#define crypto_sign_ed25519_PUBLICKEYBYTES crypto_sign_ed25519_spark_PUBLICKEYBYTES
#define crypto_sign_ed25519_SECRETKEYBYTES crypto_sign_ed25519_spark_SECRETKEYBYTES
#define crypto_sign_ed25519_VERSION crypto_sign_ed25519_spark_VERSION
#define crypto_sign_ed25519_IMPLEMENTATION "crypto_sign/ed25519/spark"

#endif

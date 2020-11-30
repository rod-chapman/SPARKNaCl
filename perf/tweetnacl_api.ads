with SPARKNaCl;           use SPARKNaCl;
with SPARKNaCl.Sign;      use SPARKNaCl.Sign;
with SPARKNaCl.Cryptobox; use SPARKNaCl.Cryptobox;
with SPARKNaCl.Hashing;   use SPARKNaCl.Hashing;
with SPARKNaCl.Stream;    use SPARKNaCl.Stream;
with SPARKNaCl.Core;      use SPARKNaCl.Core;
with Interfaces;          use Interfaces;
package TweetNaCl_API
is
   GF_Add : Unsigned_64
     with Import, Convention => C, Link_Name => "tweet_gf_add";
   GF_Sub : Unsigned_64
     with Import, Convention => C, Link_Name => "tweet_gf_sub";
   GF_Mul : Unsigned_64
     with Import, Convention => C, Link_Name => "tweet_gf_mul";
   GF_Car : Unsigned_64
     with Import, Convention => C, Link_Name => "tweet_gf_car";

   procedure Crypto_Sign
     (SM    :    out Byte_Seq;
      SMLen :    out Unsigned_64;
      M     : in     Byte_Seq;
      N     : in     Unsigned_64;
      SK    : in     Signing_SK)
     with Import,
          Convention => C,
          Link_Name  => "crypto_sign_ed25519_tweet";

   procedure Crypto_Sign2
     (SM    :    out Byte_Seq;
      SMLen :    out Unsigned_64;
      M     : in     Byte_Seq;
      N     : in     Unsigned_64;
      SK    : in     Signing_SK;
      Hash_SK         :  out Unsigned_64;
      Hash_Reduce_SM1 :  out Unsigned_64;
      Scalarbase_R    :  out Unsigned_64;
      Pack_P          :  out Unsigned_64;
      Hash_Reduce_SM2 :  out Unsigned_64;
      Initialize_X    :  out Unsigned_64;
      Assign_X        :  out Unsigned_64;
      ModL_X          :  out Unsigned_64)
     with Import,
          Convention => C,
          Link_Name  => "crypto_sign2_ed25519_tweet";

   procedure Crypto_Hash
     (SM    :    out Digest;
      M     : in     Byte_Seq;
      N     : in     Unsigned_64)
     with Import,
          Convention => C,
          Link_Name  => "crypto_hash_sha512_tweet";

   procedure Crypto_Box
     (C            :    out Byte_Seq;
      M            : in     Byte_Seq;
      MLen         : in     Unsigned_64;
      N            : in     Stream.HSalsa20_Nonce;
      Recipient_PK : in     Public_Key;
      Sender_SK    : in     Secret_Key)
     with Import,
          Convention => C,
          Link_Name  => "crypto_box_curve25519xsalsa20poly1305_tweet";

   procedure Reset
     with Import,
          Convention => C,
          Link_Name  => "tweet_reset";

   procedure Crypto_Scalarmult (Q :    out Bytes_32;
                                N : in     Bytes_32;
                                P : in     Bytes_32)
     with Import,
          Convention => C,
          Link_Name  => "crypto_scalarmult_curve25519_tweet";


   procedure HSalsa20 (C    :    out Byte_Seq;       --  Output stream
                       CLen : in     Unsigned_64;
                       N    : in     HSalsa20_Nonce; --  Nonce
                       K    : in     Salsa20_Key)   --  Key
     with Import,
          Convention => C,
          Link_Name  => "crypto_stream_xsalsa20_tweet";

end TweetNaCl_API;

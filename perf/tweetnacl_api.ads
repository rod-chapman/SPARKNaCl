with SPARKNaCl;      use SPARKNaCl;
with SPARKNaCl.Sign; use SPARKNaCl.Sign;
with Interfaces;     use Interfaces;
package TweetNaCl_API
is
   procedure Crypto_Sign
     (SM    :    out Byte_Seq;
      SMLen :    out Unsigned_64;
      M     : in     Byte_Seq;
      N     : in     Unsigned_64;
      SK    : in     Signing_SK)
     with Import,
          Convention => C,
          Link_Name  => "crypto_sign_ed25519_tweet";

end TweetNaCl_API;

with Interfaces; use Interfaces;
--  with Interfaces.C;

with SPARKNaCl;  use SPARKNaCl;
with SPARKNaCl.Sign;
package SPARKNaCl_C
  with Pure,
       SPARK_Mode => Off
is
   pragma Warnings (Off, "type of argument * is unconstrained array");
   pragma Warnings (Off, "foreign caller must pass bounds explicitly");
   procedure Sign (SM    :    out Byte_Seq;
                   SMLen :    out Unsigned_64;
                   M     : in     Byte_Seq;
                   MLen  : in     Unsigned_64;
                   SK    : in     SPARKNaCl.Sign.Signing_SK)
     with Global => null,
          Export,
          Convention => C,
          Link_Name => "_crypto_sign_ed25519_spark";


--   subtype Sign_Result is Int range -1 .. 0;

--   function Sign_Open
--     (M     :    out Byte_Seq;
--      MLen  :    out Unsigned_64;
--      SM    : in     Byte_Seq;
--      SMLen : in     Unsigned_64;
--      PK    : in     SPARKNaCl.Sign.Signing_PK) return Sign_Result
--     with Global => null,
--          Export,
--          Convention => C,
--          Link_Name => "_crypto_sign_ed25519_spark_open";


end SPARKNaCl_C;

package body SPARKNaCl_C
is
   procedure Sign (SM    :    out Byte_Seq;
                   SMLen :    out Unsigned_64;
                   M     : in     Byte_Seq;
                   MLen  : in     Unsigned_64;
                   SK    : in     SPARKNaCl.Sign.Signing_SK)
   is
      ML : constant N32 := N32 (MLen);
      subtype MI is N32 range 0 .. ML - 1;
      subtype MB is Byte_Seq (MI);
      subtype SMI is N32 range 0 .. ML + 63;
      subtype SMB is Byte_Seq (SMI);
   begin
      SPARKNaCl.Sign.Sign (SMB (SM), MB (M), SK);
      SMLen := MLen + 64;
   end Sign;

--   procedure Sign_Open (M     :    out Byte_Seq;
--                        MLen  :    out Unsigned_64;
--                        SM    : in     Byte_Seq;
--                        SMLen : in     Unsigned_64;
--                        PK    : in     SPARKNaCl.Sign.Signing_PK)
--   is
--      SML : constant N32 := N32 (SMLen);
--      R   : Boolean;
--   begin
--
--   end Sign_Open;

end SPARKNaCl_C;

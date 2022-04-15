with SPARKNaCl;           use SPARKNaCl;
with SPARKNaCl.Core;      use SPARKNaCl.Core;
with SPARKNaCl.Debug;     use SPARKNaCl.Debug;
with SPARKNaCl.Secretbox; use SPARKNaCl.Secretbox;
with SPARKNaCl.Stream;
with Ada.Text_IO;         use Ada.Text_IO;

procedure Secretbox10
is
   --------------------------------------------------------
   --  Test Cases from RFC 8439
   --------------------------------------------------------

   Key_1 : constant Core.ChaCha20_Key := Construct ((
      16#80#, 16#81#, 16#82#, 16#83#, 16#84#, 16#85#, 16#86#, 16#87#,
      16#88#, 16#89#, 16#8a#, 16#8b#, 16#8c#, 16#8d#, 16#8e#, 16#8f#,
      16#90#, 16#91#, 16#92#, 16#93#, 16#94#, 16#95#, 16#96#, 16#97#,
      16#98#, 16#99#, 16#9a#, 16#9b#, 16#9c#, 16#9d#, 16#9e#, 16#9f#
   ));

   --  In AEAD, nonce := constant & iv
   --  constant: 07 00 00 00
   --  IV: 40 41 42 43 44 45 46 47
   Nonce_1 : constant Core.ChaCha20_IETF_Nonce := (
      16#07#, 16#00#, 16#00#, 16#00#, 16#40#, 16#41#, 16#42#, 16#43#,
      16#44#, 16#45#, 16#46#, 16#47#);

   M_1 : constant Byte_Seq (0 .. 113) := SPARKNaCl.To_Byte_Seq (
      "Ladies and Gentlemen of the class of '99: If I could offer you only" &
      " one tip for the future, sunscreen would be it.");

   AAD_1 : Byte_Seq := (
      16#50#, 16#51#, 16#52#, 16#53#, 16#C0#, 16#C1#, 16#C2#, 16#C3#,
      16#C4#, 16#C5#, 16#C6#, 16#C7#);

   C_1   : Byte_Seq (0 .. 113);
   T_1   : Bytes_16;
begin
   -- S := False;
   Create (C_1, T_1, M_1, Nonce_1, Key_1, AAD_1);
   DH ("C_1 is", C_1);
   DH ("T_1 is", T_1);
end Secretbox10;

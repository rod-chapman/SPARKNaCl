with SPARKNaCl.MAC;
package body SPARKNaCl.Secretbox
  with SPARK_Mode => On
is
   --------------------------------------------------------
   --  Secret Key Authenticated Encryption - "SecretBox" --
   --------------------------------------------------------

   procedure Create (C      :    out Byte_Seq;
                     Status :    out Boolean;
                     M      : in     Byte_Seq;
                     N      : in     Stream.HSalsa20_Nonce;
                     K      : in     Core.Salsa20_Key)
   is
      K2 : MAC.Poly_1305_Key;
      R  : Bytes_16;
   begin
      --  Defensive - re-check precondition
      if (M'First = 0 and then
            C'First = 0 and then
            C'Last  = M'Last and then
            M'Length >= 32 and then
            Equal (M (0 .. 31), Zero_Bytes_32))
      then

         --  All OK
         Stream.HSalsa20_Xor (C, M, N, K);

         MAC.Construct (K2, C (0 .. 31));

         declare
            subtype M_Array is Byte_Seq (0 .. (C'Last - 32));
         begin
            MAC.Onetimeauth (R,
                             --  Slice and slide to make the index value
                             --  meet the precondition
                             M_Array (C (32 .. C'Last)),
                             K2);
         end;

         C  (0 .. 15) := Zero_Bytes_16;
         C (16 .. 31) := R;
         Status := True;
      else
         --  Precondition violated
         C := (others => 0);
         Status := False;
      end if;
   end Create;

   procedure Open
     (M      :    out Byte_Seq; --  Output plaintext
      Status :    out Boolean;
      C      : in     Byte_Seq; --  Input ciphertext
      N      : in     Stream.HSalsa20_Nonce;
      K      : in     Core.Salsa20_Key)
   is
      X : Bytes_32;
   begin
      --  Defensive - re-check precondition
      if (M'First = 0 and then
            C'First = 0 and then
            M'Last  = C'Last and then
            C'Length >= 32 and then
            Equal (C (0 .. 15), Zero_Bytes_16))
      then
         --  All OK
         Stream.HSalsa20 (X, N, K);

         declare
            subtype M_Array is Byte_Seq (0 .. (C'Last - 32));
            MAC_Key : constant MAC.Poly_1305_Key := MAC.Construct (X);
         begin
            if MAC.Onetimeauth_Verify
              (H => C (16 .. 31),
               --  Slice and slide so that M'First = 0
               M => M_Array (C (32 .. C'Last)),
               K => MAC_Key)
            then
               --  MAC verifies OK, so decrypt payload
               Stream.HSalsa20_Xor (C => M, M => C, N => N, K => K);
               M (0 .. 31) := Zero_Bytes_32;
               Status := True;
            else
               --  MAC verification failed
               M := (others => 0);
               Status := False;
            end if;
         end;

      else
         --  Precondition violated
         M := (others => 0);
         Status := False;
      end if;
   end Open;

   --------------------------------------------------------
   --  TLS 1.3 AEAD using ChaCha20 and Poly1305 (RFC 8439)
   --------------------------------------------------------

   --  Poly_1305 message authentication is performed on a
   --  combination of the ciphertext and additional data
   --  (AAD). This creates that combination.
   function Gen_Auth_Msg (C   : in Byte_Seq;
                          AAD : in Byte_Seq) return Byte_Seq
     with Global => null,
          Pre    => AAD'First  = 0 and
                    AAD'Length <= U32 (N32'Last) and
                    C'First    = 0 and
                    C'Length   <= U32 (N32'Last) and
                    C'Length + AAD'Length <= U32 (N32'Last - 192),
          Post   => Gen_Auth_Msg'Result'First = 0;

   function Gen_Auth_Msg (C   : in Byte_Seq;
                          AAD : in Byte_Seq) return Byte_Seq
   is
      function LE64 (U : in U64) return Bytes_8
        with Global => null;

      function Pad16 (Len : N32) return Byte_Seq
        with Global => null,
             Post   => Pad16'Result'Length < 16 and
                       (if Pad16'Result'Length > 0
                        then Pad16'Result'First = 0);

      --  Convert number to 8 LE bytes
      function LE64 (U : in U64) return Bytes_8
      is
         X : Bytes_8;
         T : U64 := U;
      begin
         for I in X'Range loop
            pragma Loop_Optimize (No_Unroll);
            X (I) := Byte (T mod 256);
            T := Shift_Right (T, 8);
         end loop;
         return X;
      end LE64;

      --  Given a message length, return padding to multiple of 16 bytes.
      function Pad16 (Len : N32) return Byte_Seq is
         R             : constant N32 := Len mod 16;
         Null_Byte_Seq : constant Byte_Seq (1 .. 0) := (others => 0);
      begin
         if R = 0 then
            return Null_Byte_Seq;
         else
            declare
               Padding : constant Byte_Seq (0 .. 16 - R - 1) :=
                  (others => 0);
            begin
               return Padding;
            end;
         end if;
      end Pad16;

      AAD_Len   : constant Bytes_8 := LE64 (U64 (AAD'Length));
      C_Len     : constant Bytes_8 := LE64 (U64 (C'Length));

      AAD_Pad   : constant Byte_Seq := Pad16 (AAD'Length);
      C_Pad     : constant Byte_Seq := Pad16 (C'Length);

   begin
      return AAD & AAD_Pad & C & C_Pad & AAD_Len & C_Len;
   end Gen_Auth_Msg;

   --  AEAD Encryption
   procedure Create (C       :    out Byte_Seq;
                     Tag     :    out Bytes_16;
                     M       : in     Byte_Seq;
                     N       : in     Core.ChaCha20_IETF_Nonce;
                     K       : in     Core.ChaCha20_Key;
                     AAD     : in     Byte_Seq)
   is
      --  one-time key
      OTK_Bytes : Bytes_32;
      OTK : MAC.Poly_1305_Key;
   begin
      --  Generate Poly1305 one-time key from 256-bit key and nonce
      --  See RFC 8439 section 2.6
      Stream.ChaCha20_IETF (OTK_Bytes, N, K, 0);
      MAC.Construct (OTK, OTK_Bytes);

      Stream.ChaCha20_IETF_Xor (C       => C,
                                M       => M,
                                N       => N,
                                K       => K,
                                Counter => 1);

      MAC.Onetimeauth (Output => Tag,
                       M      => Gen_Auth_Msg (C, AAD),
                       K      => OTK);
   end Create;

   --  AEAD Decryption
   procedure Open (M        :    out Byte_Seq;
                   Status   :    out Boolean;
                   Tag      : in     Bytes_16;
                   C        : in     Byte_Seq;
                   N        : in     Core.ChaCha20_IETF_Nonce;
                   K        : in     Core.ChaCha20_Key;
                   AAD      : in     Byte_Seq)
   is
      --  One-Time Key
      OTK_Bytes : Bytes_32;
      OTK       : MAC.Poly_1305_Key;
   begin
      --  Generate Poly1305 one-time key from 256-bit key and nonce
      --  See RFC 8439 section 2.6
      Stream.ChaCha20_IETF (OTK_Bytes, N, K, 0);
      MAC.Construct (OTK, OTK_Bytes);

      if MAC.Onetimeauth_Verify (Tag, Gen_Auth_Msg (C, AAD), OTK) then
         Stream.ChaCha20_IETF_Xor (C       => M,
                                   M       => C,
                                   N       => N,
                                   K       => K,
                                   Counter => 1);
         Status := True;
      else
         M := (others => 0);
         Status := False;
      end if;
   end Open;
end SPARKNaCl.Secretbox;

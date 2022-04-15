with SPARKNaCl.MAC;
--  with SPARKNaCl.Debug;
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

   procedure Create (C      :    out Byte_Seq;
                     Tag    :    out Bytes_16;
                     M      : in     Byte_Seq;
                     N      : in     Core.ChaCha20_IETF_Nonce;
                     K      : in     Core.ChaCha20_Key;
                     AAD    : in     Byte_Seq)
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

      OTK_Bytes : Bytes_32;
      OTK : MAC.Poly_1305_Key;

      AAD_Len   : constant Bytes_8 := LE64 (U64 (AAD'Length));
      C_Len     : constant Bytes_8 := LE64 (U64 (C'Length));

      AAD_Pad   : constant Byte_Seq := Pad16 (AAD'Length);
      C_Pad     : constant Byte_Seq := Pad16 (C'Length);

   begin
      --  Generate Poly1305 one-time key from 256-bit key and nonce
      Stream.ChaCha20_IETF (OTK_Bytes, N, K, 0);

      MAC.Construct (OTK, OTK_Bytes);

      --  Next, ChaCha20 is called to encrypt plaintext, using the same key
      --  and nonce, and with initial counter set to 1.
      Stream.ChaCha20_IETF_Xor (C => C,
                                M => M,
                                N => N,
                                K => K,
                                Counter => 1);

      --  Finally, Poly1305 function is called with the Poly1305 key
      --  calculated above, and a message constructed as a concatenation
      --  of the following:
      --   1. AAD
      --   2. padding1 (up to 15 zero bytes, brings
      --    total length so far to an integral multiple of 16.) If the length
      --    of the AAD was already a multiple of 16 bytes, padding is zero.
      --   3. ciphertext
      --   4. padding2
      --   5. length of additional data in octets (64-bit LE)
      --   6. length of ciphertext in octets (64-bit LE)

      MAC.Onetimeauth (Output => Tag,
                       M      => AAD & AAD_Pad & C & C_Pad & AAD_Len & C_Len,
                       K      => OTK);
   end Create;

end SPARKNaCl.Secretbox;

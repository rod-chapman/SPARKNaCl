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
               --  Slide and slide so that M'First = 0
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

end SPARKNaCl.Secretbox;

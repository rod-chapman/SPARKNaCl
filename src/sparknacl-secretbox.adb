with SPARKNaCl.Stream;
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
                     N      : in     Bytes_24;
                     K      : in     Bytes_32)
   is
      D : I32;
      K2 : Bytes_32;
      R  : Bytes_16;
   begin
      D := M'Length; --  PRange?
      if D < 32 then
         Status := False;
         C := (others => 0);
         return;
      end if;

      pragma Assert (D >= 32);

      Stream.HSalsa20_Xor (C, M, N, K);

      K2 := C (0 .. 31);

      declare
         subtype M_Array is Byte_Seq (0 .. (C'Last - 32));
      begin
         MAC.Onetimeauth (R,
                          --  Slice and slide to make the index value
                          --  meet the precondition
                          M_Array (C (32 .. C'Last)),
                          K2);
      end;

      C (16 .. 31) := R;
      C (0 .. 15) := Zero_Bytes_16;
      Status := True;
   end Create;

   --  POK
   procedure Open
     (M      :    out Byte_Seq; --  Output plaintext
      Status :    out Boolean;
      C      : in     Byte_Seq; --  Input ciphertext
      N      : in     Bytes_24; --  Nonce
      K      : in     Bytes_32) --  Key)
   is
      X : Bytes_32;
   begin
      Status := True;
      if C'Length < 32 then
         Status := False;
         M := (others => 0);
         return;
      end if;

      pragma Assert (C'Length >= 32);

      Stream.HSalsa20 (X, N, K);

      declare
         subtype M_Array is Byte_Seq (0 .. (C'Last - 32));
      begin
         if not MAC.Onetimeauth_Verify
           (H => C (16 .. 31),
            --  Slide and slide so that M'First = 0
            M => M_Array (C (32 .. C'Last)),
            K => X)
         then
            Status := False;
            M := (others => 0);
            return;
         end if;
      end;

      Stream.HSalsa20_Xor (C => M, M => C, N => N, K => K);
      M (0 .. 31) := Zero_Bytes_32;
   end Open;

end SPARKNaCl.Secretbox;

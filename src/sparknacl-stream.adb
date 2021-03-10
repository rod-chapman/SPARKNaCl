package body SPARKNaCl.Stream
  with SPARK_Mode => On
is
   pragma Warnings (GNATProve, Off, "pragma * ignored (not yet supported)");

   --------------------------------------------------------
   --  Local subprogram declarations
   --------------------------------------------------------

   procedure Salsa20_Xor_Local
     (C     :    out Byte_Seq;
      M     : in     Byte_Seq;
      Xor_M : in     Boolean; --  If True then xor M against Stream
                              --  If False then return Stream unmodified
      N     : in     Salsa20_Nonce; --  Nonce
      K     : in     Salsa20_Key)   --  Key
     with Global => null,
          Pre    => M'First = 0 and then
                    C'First = 0 and then
                    (if Xor_M then (C'Last  = M'Last)) and then
                    (if not Xor_M then M'Last = 0);

   --------------------------------------------------------
   --  Local subprogram bodies
   --------------------------------------------------------

   procedure Salsa20_Xor_Local
     (C     :    out Byte_Seq;
      M     : in     Byte_Seq;
      Xor_M : in     Boolean; --  If True then xor M against Stream
                              --  If False then return Stream unmodified
      N     : in     Salsa20_Nonce; --  Nonce
      K     : in     Salsa20_Key)   --  Key
   is
      Full_Block_Count : constant I32 := C'Last / 64;
      subtype Offset_Range is I32 range 0 .. (Full_Block_Count * 64);
      subtype Natural_64   is I64 range 0 .. I64'Last;

      Offset       : Offset_Range;
      Final_Offset : I32;

      Z : Bytes_16;
      X : Bytes_64;
      U : U32;
      B : Natural_64;
   begin
      B := C'Length;
      C := (others => 0);
      if B = 0 then
         return;
      end if;

      Offset := 0;
      Z := (others => 0);
      Z (0 .. 7) := Bytes_8 (N);

      if B >= 64 then
         loop
            pragma Loop_Optimize (No_Unroll);

            pragma Loop_Invariant
              ((B + I64 (Offset) = C'Length) and then
               (I64 (Offset) <= (C'Length - B)) and then
               ((C'Length - B) <= I64 (C'Last) - 63));

            Core.Salsa20 (X, Z, K, Sigma);

            for I in Index_64 loop
               pragma Loop_Optimize (No_Unroll);

               pragma Loop_Invariant
                 ((Offset + I) in C'Range and
                    (if Xor_M then (Offset + I) in M'Range));

               C (Offset + I) :=
                 (if Xor_M then M (Offset + I) else 0) xor
                   X (I);
            end loop;

            U := 1;
            for I in I32 range 8 .. 15 loop
               pragma Loop_Optimize (No_Unroll);
               U := U + U32 (Z (I));
               Z (I) := Byte (U mod 256);
               U := Shift_Right (U, 8);
            end loop;

            B := B - 64;

            --  Exit here to prevent subsequent overflow of Offset + 64
            --  on the final iteration
            exit when B < 64;

            Offset := Offset + 64;
         end loop;

         if B > 0 then
            --  Final block is non-empty but incomplete. It starts
            --  at Offset C'Length - B
            Final_Offset := I32 (C'Length - B);
         else
            --  B = 0 so final block is empty, so nothing more to do.
            --  Set Final_Offset here to avoid a data-flow error.
            Final_Offset := 0;
         end if;
      else
         --  Only a single, incomplete block to process, so it must
         --  start at Offset 0
         Final_Offset := 0;
      end if;

      if B > 0 then
         Core.Salsa20 (X, Z, K, Sigma);

         for I in I32 range 0 .. I32 (B - 1) loop
            pragma Loop_Optimize (No_Unroll);
            pragma Loop_Invariant
              ((Final_Offset + I) in C'Range and
                 (if Xor_M then (Final_Offset + I) in M'Range));

            C (Final_Offset + I) :=
              (if Xor_M then
              M (Final_Offset + I) else 0) xor
                X (I);
         end loop;
      end if;

      pragma Warnings (GNATProve, Off, "statement has no effect");
      Sanitize (X);
      Sanitize (Z);
      pragma Unreferenced (X, Z);
   end Salsa20_Xor_Local;

   --------------------------------------------------------
   --  Exported subprogram bodies
   --------------------------------------------------------

   procedure Salsa20 (C :    out Byte_Seq; --  Output stream
                      N : in     Salsa20_Nonce; --  Nonce
                      K : in     Salsa20_Key)    --  Key
   is
      Null_M : Byte_Seq (0 .. 0);
   begin
      Null_M := (others => 0);
      Salsa20_Xor_Local (C, Null_M, False, N, K);
   end Salsa20;

   procedure Salsa20_Xor (C :    out Byte_Seq; --  Output stream
                          M : in     Byte_Seq; --  Input message
                          N : in     Salsa20_Nonce; --  Nonce
                          K : in     Salsa20_Key)    --  Key
   is
   begin
      Salsa20_Xor_Local (C, M, True, N, K);
   end Salsa20_Xor;

   procedure HSalsa20 (C :    out Byte_Seq;       --  Output stream
                       N : in     HSalsa20_Nonce; --  Nonce
                       K : in     Salsa20_Key)    --  Key
   is
      S : Bytes_32;
   begin
      Core.HSalsa20 (S, Bytes_16 (N (0 .. 15)), K, Sigma);
      Salsa20 (C, Salsa20_Nonce (N (16 .. 23)), Core.Construct (S));

      Sanitize (S);
      pragma Unreferenced (S);
   end HSalsa20;

   procedure HSalsa20_Xor (C :    out Byte_Seq; --  Output ciphertext
                           M : in     Byte_Seq; --  Input message
                           N : in     HSalsa20_Nonce; --  Nonce
                           K : in     Salsa20_Key)    --  Key
   is
      S : Bytes_32;
   begin
      Core.HSalsa20 (S, Bytes_16 (N (0 .. 15)), K, Sigma);
      Salsa20_Xor_Local (C     => C,
                         M     => M,
                         Xor_M => True,
                         N     => Salsa20_Nonce (N (16 .. 23)),
                         K     => Core.Construct (S));

      Sanitize (S);
      pragma Unreferenced (S);
   end HSalsa20_Xor;

end SPARKNaCl.Stream;

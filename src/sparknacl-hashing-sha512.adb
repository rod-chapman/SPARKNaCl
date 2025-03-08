package body SPARKNaCl.Hashing.SHA512
  with SPARK_Mode => On
is
   pragma Warnings (GNATProve, Off, "pragma * ignored (not yet supported)");

   IV_512 : constant Bytes_64 :=
     (16#6a#, 16#09#, 16#e6#, 16#67#, 16#f3#, 16#bc#, 16#c9#, 16#08#,
      16#bb#, 16#67#, 16#ae#, 16#85#, 16#84#, 16#ca#, 16#a7#, 16#3b#,
      16#3c#, 16#6e#, 16#f3#, 16#72#, 16#fe#, 16#94#, 16#f8#, 16#2b#,
      16#a5#, 16#4f#, 16#f5#, 16#3a#, 16#5f#, 16#1d#, 16#36#, 16#f1#,
      16#51#, 16#0e#, 16#52#, 16#7f#, 16#ad#, 16#e6#, 16#82#, 16#d1#,
      16#9b#, 16#05#, 16#68#, 16#8c#, 16#2b#, 16#3e#, 16#6c#, 16#1f#,
      16#1f#, 16#83#, 16#d9#, 16#ab#, 16#fb#, 16#41#, 16#bd#, 16#6b#,
      16#5b#, 16#e0#, 16#cd#, 16#19#, 16#13#, 16#7e#, 16#21#, 16#79#);

   --------------------------------------------------------
   --  Local subprogram declarations
   --------------------------------------------------------

   procedure Hashblocks_512
     (X : in out Digest;
      M : in     Byte_Seq)
     with Global => null,
          Always_Terminates;

   procedure Hash_512 (Output :    out Digest;
                       M      : in     Byte_Seq)
     with Global => null,
          Always_Terminates;

   --------------------------------------------------------
   --  Local subprogram bodies
   --------------------------------------------------------

<<<<<<< HEAD
=======
   function DL64 (X : in Byte_Seq;
                  I : in N32) return U64
   is
      LSW, MSW : U32;
   begin
      --  Doing this in two 32-bit groups avoids the need
      --  for 64-bit shifts on 32-bit machines.
      MSW := Shift_Left (U32 (X (I)),     24) or
             Shift_Left (U32 (X (I + 1)), 16) or
             Shift_Left (U32 (X (I + 2)), 8) or
                         U32 (X (I + 3));
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
             Shift_Left (U32 (X (I + 5)), 16) or
             Shift_Left (U32 (X (I + 6)), 8) or
                         U32 (X (I + 7));
      return Shift_Left (U64 (MSW), 32) or U64 (LSW);
   end DL64;

   procedure Hashblocks_512
     (X : in out Digest;
      M : in     Byte_Seq)
   is
      Z, B, A : U64_Seq_8;
      W       : U64_Seq_16;
      T       : U64;
      LN      : I64;
      CB      : I32;

      function RR64 (X : in U64;
                     C : in Natural) return U64
        renames Rotate_Right;

      function Ch (X, Y, Z : in U64) return U64
      is ((X and Y) xor ((not X) and Z))
        with Global => null;

      function Maj (X, Y, Z : in U64) return U64
      is ((X and Y) xor (X and Z) xor (Y and Z))
        with Global => null;

      --  Sigma0 with an upper-case S!
      function UC_Sigma0 (X : in U64) return U64
      is (RR64 (X, 28) xor RR64 (X, 34) xor RR64 (X, 39))
        with Global => null;

      --  Sigma1 with an upper-case S!
      function UC_Sigma1 (X : in U64) return U64
      is (RR64 (X, 14) xor RR64 (X, 18) xor RR64 (X, 41))
        with Global => null;

      --  sigma0 with a lower-case s!
      function LC_Sigma0 (X : in U64) return U64
      is (RR64 (X, 1) xor RR64 (X, 8) xor Shift_Right (X, 7))
        with Global => null;

      --  sigma1 with a lower-case s!
      function LC_Sigma1 (X : in U64) return U64
      is (RR64 (X, 19) xor RR64 (X, 61) xor Shift_Right (X, 6))
        with Global => null;

   begin
      A := (0 => DL64 (X, 0),
            1 => DL64 (X, 8),
            2 => DL64 (X, 16),
            3 => DL64 (X, 24),
            4 => DL64 (X, 32),
            5 => DL64 (X, 40),
            6 => DL64 (X, 48),
            7 => DL64 (X, 56));
      Z := A;

      LN := I64 (M'Length);
      CB := M'First; -- Current block base offset

      while (LN >= 128) loop
         pragma Loop_Optimize (No_Unroll);

         pragma Warnings (Off, "lower bound test*");
         pragma Loop_Variant (Decreases => LN);
         pragma Loop_Invariant
           ((LN + I64 (CB) = I64 (M'Last) + 1) and
              (LN in 128 .. M'Length) and
              (CB in M'First .. (M'Last - 127)));

         W := (0  => DL64 (M, CB),
               1  => DL64 (M, CB + 8),
               2  => DL64 (M, CB + 16),
               3  => DL64 (M, CB + 24),
               4  => DL64 (M, CB + 32),
               5  => DL64 (M, CB + 40),
               6  => DL64 (M, CB + 48),
               7  => DL64 (M, CB + 56),
               8  => DL64 (M, CB + 64),
               9  => DL64 (M, CB + 72),
               10 => DL64 (M, CB + 80),
               11 => DL64 (M, CB + 88),
               12 => DL64 (M, CB + 96),
               13 => DL64 (M, CB + 104),
               14 => DL64 (M, CB + 112),
               15 => DL64 (M, CB + 120));

         for I in Index_80 loop
            pragma Loop_Optimize (No_Unroll);

            pragma Loop_Invariant ((LN + I64 (CB) = I64 (M'Last) + 1) and
                                     (LN in 128 .. M'Length) and
                                     (CB in M'First .. (M'Last - 127)));
            B := A;

            T := A (7) + UC_Sigma1 (A (4)) + Ch (A (4), A (5), A (6)) +
                 K_512 (I) + W (I mod 16);

            B (7) := T + UC_Sigma0 (A (0)) + Maj (A (0), A (1), A (2));
            B (3) := B (3) + T;

            A := (0 => B (7),
                  1 => B (0),
                  2 => B (1),
                  3 => B (2),
                  4 => B (3),
                  5 => B (4),
                  6 => B (5),
                  7 => B (6));

            if (I mod 16 = 15) then
               for J in Index_16 loop
                  pragma Loop_Optimize (No_Unroll);
                  W (J) := W (J) + W ((J + 9) mod 16) +
                    LC_Sigma0 (W ((J + 1) mod 16)) +
                    LC_Sigma1 (W ((J + 14) mod 16));
               end loop;
            end if;

         end loop;

         for I in Index_8 loop
            pragma Loop_Optimize (No_Unroll);
            A (I) := A (I) + Z (I);
            Z (I) := A (I);
         end loop;

         exit when LN < 256;
         pragma Assert (LN >= 128);
         CB := CB + 128;
         LN := LN - 128;
      end loop;


      for I in Index_8 loop
         pragma Loop_Optimize (No_Unroll);
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
      end loop;

   end Hashblocks_512;

>>>>>>> d17ff7730e6699a213c2654a2f96015561ca6b33
   procedure Hash_512 (Output :    out Digest;
                       M      : in     Byte_Seq)
   is
      H : Bytes_64;
   begin
      Hash_512_Core (H, IV_512, M);
      Output := H;
   end Hash_512;

   procedure Hash (Output :    out Digest;
                   M      : in     Byte_Seq)
   is
   begin
      Hash_512 (Output, M);
   end Hash;

   function Hash (M : in Byte_Seq) return Digest
   is
      R : Digest;
   begin
      Hash_512 (R, M);
      return R;
   end Hash;

end SPARKNaCl.Hashing.SHA512;

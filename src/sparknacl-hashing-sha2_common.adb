package body SPARKNaCl.Hashing.SHA2_Common
  with SPARK_Mode => On
is
   pragma Warnings (GNATProve, Off, "pragma * ignored (not yet supported)");

   pragma Warnings (GNATprove, Off, "Loop_Optimize");

   subtype Index_80 is I32 range 0 .. 79;

   type K_Table_512 is array (Index_80) of U64;
   K_512 : constant K_Table_512 :=
     (16#428a2f98d728ae22#, 16#7137449123ef65cd#,
      16#b5c0fbcfec4d3b2f#, 16#e9b5dba58189dbbc#,
      16#3956c25bf348b538#, 16#59f111f1b605d019#,
      16#923f82a4af194f9b#, 16#ab1c5ed5da6d8118#,
      16#d807aa98a3030242#, 16#12835b0145706fbe#,
      16#243185be4ee4b28c#, 16#550c7dc3d5ffb4e2#,
      16#72be5d74f27b896f#, 16#80deb1fe3b1696b1#,
      16#9bdc06a725c71235#, 16#c19bf174cf692694#,
      16#e49b69c19ef14ad2#, 16#efbe4786384f25e3#,
      16#0fc19dc68b8cd5b5#, 16#240ca1cc77ac9c65#,
      16#2de92c6f592b0275#, 16#4a7484aa6ea6e483#,
      16#5cb0a9dcbd41fbd4#, 16#76f988da831153b5#,
      16#983e5152ee66dfab#, 16#a831c66d2db43210#,
      16#b00327c898fb213f#, 16#bf597fc7beef0ee4#,
      16#c6e00bf33da88fc2#, 16#d5a79147930aa725#,
      16#06ca6351e003826f#, 16#142929670a0e6e70#,
      16#27b70a8546d22ffc#, 16#2e1b21385c26c926#,
      16#4d2c6dfc5ac42aed#, 16#53380d139d95b3df#,
      16#650a73548baf63de#, 16#766a0abb3c77b2a8#,
      16#81c2c92e47edaee6#, 16#92722c851482353b#,
      16#a2bfe8a14cf10364#, 16#a81a664bbc423001#,
      16#c24b8b70d0f89791#, 16#c76c51a30654be30#,
      16#d192e819d6ef5218#, 16#d69906245565a910#,
      16#f40e35855771202a#, 16#106aa07032bbd1b8#,
      16#19a4c116b8d2d0c8#, 16#1e376c085141ab53#,
      16#2748774cdf8eeb99#, 16#34b0bcb5e19b48a8#,
      16#391c0cb3c5c95a63#, 16#4ed8aa4ae3418acb#,
      16#5b9cca4f7763e373#, 16#682e6ff3d6b2b8a3#,
      16#748f82ee5defb2fc#, 16#78a5636f43172f60#,
      16#84c87814a1f0ab72#, 16#8cc702081a6439ec#,
      16#90befffa23631e28#, 16#a4506cebde82bde9#,
      16#bef9a3f7b2c67915#, 16#c67178f2e372532b#,
      16#ca273eceea26619c#, 16#d186b8c721c0c207#,
      16#eada7dd6cde0eb1e#, 16#f57d4f7fee6ed178#,
      16#06f067aa72176fba#, 16#0a637dc5a2c898a6#,
      16#113f9804bef90dae#, 16#1b710b35131c471b#,
      16#28db77f523047d84#, 16#32caab7b40c72493#,
      16#3c9ebe0a15c9bebc#, 16#431d67c49c100d4c#,
      16#4cc5d4becb3e42b6#, 16#597f299cfc657e2a#,
      16#5fcb6fab3ad6faec#, 16#6c44198c4a475817#);

   --------------------------------------------------------
   --  Local Subprogram Declarations
   --------------------------------------------------------

   procedure Hashblocks_512
     (X : in out Bytes_64;
      M : in     Byte_Seq)
     with Global => null,
          Always_Terminates;

   --------------------------------------------------------
   --  Local Subprogram Bodies
   --------------------------------------------------------

   function Big_Endian_Unpack (Input : in U64) return Bytes_8
   is
      Output : Bytes_8 with Relaxed_Initialization;
      X      : U64 := Input;
   begin
      Output (Output'Last) := Byte (X mod 256);

      pragma Assert (Output'Last = Index_8'Last);
      pragma Assert (Output (Output'Last)'Initialized);
      pragma Assert (Output (Output'Last) =
        Big_Endian_Get_Byte (Input, Index_8'Last));

      for I in reverse Index_8'First .. (Index_8'Last - 1) loop
         X := Shift_Right (X, 8);
         Output (I) := Byte (X mod 256);

         pragma Loop_Invariant (
           (X = Shift_Right (Input, Integer (Index_8'Last - I) * 8)) and then
           (Output (I .. Index_8'Last)'Initialized) and then
           (for all J in I .. Index_8'Last => Output (J) =
             Big_Endian_Get_Byte (Input, J)));
      end loop;

      return Output;
   end Big_Endian_Unpack;

   function Big_Endian_Get_Byte (Input : in U64;
                                 Index : in Index_8) return Byte
   is
      Shift_Amount  : constant Integer := Integer (Index_8'Last - Index) * 8;
      Shifted_Input : constant U64     := Shift_Right (Input, Shift_Amount);

      Result : constant Byte := Byte (Shifted_Input mod 256);
   begin
      return Result;
   end Big_Endian_Get_Byte;

   procedure Hashblocks_512
     (X : in out Bytes_64;
      M : in     Byte_Seq)
   is
      Z, B, A : U64_Seq_8;
      W       : U64_Seq_16;
      T       : U64;
      LN      : I64;
      CB      : I32;

      function DL64 (X : in Byte_Seq;
                     I : in N32) return U64
         with Global => null,
              Pre => X'Length >= 8 and then
                     I >= X'First and then
                     I <= X'Last - 7;

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

      function Ch (X, Y, Z : in U64) return U64
      is ((X and Y) xor ((not X) and Z))
        with Global => null;

      function Maj (X, Y, Z : in U64) return U64
      is ((X and Y) xor (X and Z) xor (Y and Z))
        with Global => null;

      --  Sigma0 with an upper-case S!
      function UC_Sigma0 (X : in U64) return U64
      is (Rotate_Right (X, 28) xor
          Rotate_Right (X, 34) xor
          Rotate_Right (X, 39))
        with Global => null;

      --  Sigma1 with an upper-case S!
      function UC_Sigma1 (X : in U64) return U64
      is (Rotate_Right (X, 14) xor
          Rotate_Right (X, 18) xor
          Rotate_Right (X, 41))
        with Global => null;

      --  sigma0 with a lower-case s!
      function LC_Sigma0 (X : in U64) return U64
      is (Rotate_Right (X, 1) xor
          Rotate_Right (X, 8) xor
          Shift_Right (X, 7))
        with Global => null;

      --  sigma1 with a lower-case s!
      function LC_Sigma1 (X : in U64) return U64
      is (Rotate_Right (X, 19) xor
          Rotate_Right (X, 61) xor
          Shift_Right (X, 6))
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
         X (8 * I .. 8 * I + 7) := Big_Endian_Unpack (Z (I));
      end loop;

   end Hashblocks_512;

   procedure Hash_512_Core (Output :    out Bytes_64;
                            IV     : in     Bytes_64;
                            M      : in     Byte_Seq)
   is
      subtype Final_Block_Length is I32 range 0 .. 127;
      H     : Bytes_64 := IV;
      X     : Bytes_256;
      B     : Final_Block_Length;
      Final_Block_First : I32;
      ML_MSB  : Byte;
      ML_LSBs : U64;
   begin
      X := (others => 0);

      Hashblocks_512 (H, M);

      B := Final_Block_Length (I64 (M'Length) mod 128);

      if B > 0 then
         Final_Block_First := (M'Last - B) + 1;
         X (0 .. B - 1) := M (Final_Block_First .. M'Last);
      end if;
      X (B) := 128;

      --  Final 9 bytes are the length of M in bits
      ML_MSB  := Byte (Shift_Right (U64'(M'Length), 61));
      ML_LSBs := U64 (M'Length) * 8;
      if B < 112 then
         X (119) := ML_MSB;
         X (120 .. 127) := Big_Endian_Unpack (ML_LSBs);
         Hashblocks_512 (H, X (0 .. 127));
      else
         X (247) := ML_MSB;
         X (248 .. 255) := Big_Endian_Unpack (ML_LSBs);
         Hashblocks_512 (H, X);
      end if;

      Output := H;
   end Hash_512_Core;

end SPARKNaCl.Hashing.SHA2_Common;

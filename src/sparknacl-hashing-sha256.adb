package body SPARKNaCl.Hashing.SHA256
  with SPARK_Mode => On
is
   pragma Warnings (GNATProve, Off, "pragma * ignored (not yet supported)");

   IV_256 : constant Digest :=
     (16#6a#, 16#09#, 16#e6#, 16#67#,
      16#bb#, 16#67#, 16#ae#, 16#85#,
      16#3c#, 16#6e#, 16#f3#, 16#72#,
      16#a5#, 16#4f#, 16#f5#, 16#3a#,
      16#51#, 16#0e#, 16#52#, 16#7f#,
      16#9b#, 16#05#, 16#68#, 16#8c#,
      16#1f#, 16#83#, 16#d9#, 16#ab#,
      16#5b#, 16#e0#, 16#cd#, 16#19#);

   subtype Index_64 is I32 range 0 .. 63;
   type K_Table_256 is array (Index_64) of U32;
   K_256 : constant K_Table_256 :=
     (16#428a2f98#, 16#71374491#,
      16#b5c0fbcf#, 16#e9b5dba5#,
      16#3956c25b#, 16#59f111f1#,
      16#923f82a4#, 16#ab1c5ed5#,
      16#d807aa98#, 16#12835b01#,
      16#243185be#, 16#550c7dc3#,
      16#72be5d74#, 16#80deb1fe#,
      16#9bdc06a7#, 16#c19bf174#,
      16#e49b69c1#, 16#efbe4786#,
      16#0fc19dc6#, 16#240ca1cc#,
      16#2de92c6f#, 16#4a7484aa#,
      16#5cb0a9dc#, 16#76f988da#,
      16#983e5152#, 16#a831c66d#,
      16#b00327c8#, 16#bf597fc7#,
      16#c6e00bf3#, 16#d5a79147#,
      16#06ca6351#, 16#14292967#,
      16#27b70a85#, 16#2e1b2138#,
      16#4d2c6dfc#, 16#53380d13#,
      16#650a7354#, 16#766a0abb#,
      16#81c2c92e#, 16#92722c85#,
      16#a2bfe8a1#, 16#a81a664b#,
      16#c24b8b70#, 16#c76c51a3#,
      16#d192e819#, 16#d6990624#,
      16#f40e3585#, 16#106aa070#,
      16#19a4c116#, 16#1e376c08#,
      16#2748774c#, 16#34b0bcb5#,
      16#391c0cb3#, 16#4ed8aa4a#,
      16#5b9cca4f#, 16#682e6ff3#,
      16#748f82ee#, 16#78a5636f#,
      16#84c87814#, 16#8cc70208#,
      16#90befffa#, 16#a4506ceb#,
      16#bef9a3f7#, 16#c67178f2#);

   function TS32 (U : in U32) return Bytes_4
     with Global => null;

   --  Big-Endian 4 bytes to U32. The input bytes are in
   --  X (I) through X (I + 4)
   function DL32 (X : in Byte_Seq;
                  I : in N32) return U32
     with Global => null,
          Pre => X'Length >= 4 and then
                 I >= X'First and then
                 I <= X'Last - 3;

   procedure Hashblocks_256
     (X : in out Digest;
      M : in     Byte_Seq)
     with Global => null,
          Always_Terminates;

   function TS32 (U : in U32) return Bytes_4
   is
      X : Bytes_4;
      T : U32 := U;
   begin
      for I in reverse Index_4 loop
         pragma Loop_Optimize (No_Unroll);
         X (I) := Byte (T mod 256);
         T := Shift_Right (T, 8);
      end loop;
      return X;
   end TS32;

   function DL32 (X : in Byte_Seq;
                  I : in N32) return U32
   is
      W : U32;
   begin
      W := Shift_Left (U32 (X (I)),     24) or
           Shift_Left (U32 (X (I + 1)), 16) or
           Shift_Left (U32 (X (I + 2)), 8) or
                       U32 (X (I + 3));
      return W;
   end DL32;

   --------------------------------------------------------
   --  SHA-256
   --------------------------------------------------------

   procedure Hashblocks_256
     (X : in out Digest;
      M : in     Byte_Seq)
   is
      A  : U32_Seq_8;    -- internal temporary state (a,b, .. h in reference)
      B  : U32_Seq_8;    -- working vars for internal temporary state
      Z  : U32_Seq_8;    -- previous intermediate hashes
      W  : U32_Seq_16;   -- message schedule
      T  : U32;
      LN : I64;
      CB : I32;

      function Ch (X, Y, Z : in U32) return U32
      is ((X and Y) xor ((not X) and Z))
        with Global => null;

      function Maj (X, Y, Z : in U32) return U32
      is ((X and Y) xor (X and Z) xor (Y and Z))
        with Global => null;

      --  Sigma0 with an upper-case S!
      function UC_Sigma0 (X : in U32) return U32
      is (Rotate_Right (X,  2) xor
          Rotate_Right (X, 13) xor
          Rotate_Right (X, 22))
        with Global => null;

      --  Sigma1 with an upper-case S!
      function UC_Sigma1 (X : in U32) return U32
      is (Rotate_Right (X,  6) xor
          Rotate_Right (X, 11) xor
          Rotate_Right (X, 25))
        with Global => null;

      --  sigma0 with a lower-case s!
      function LC_Sigma0 (X : in U32) return U32
      is (Rotate_Right (X,  7) xor
          Rotate_Right (X, 18) xor
          Shift_Right (X, 3))
        with Global => null;

      --  sigma1 with a lower-case s!
      function LC_Sigma1 (X : in U32) return U32
      is (Rotate_Right (X, 17) xor
          Rotate_Right (X, 19) xor
          Shift_Right (X, 10))
        with Global => null;

   begin
      --  2. Initialize 8 working variables with (i-1)st hash value (IV here)
      A := (0 => DL32 (X, 0),
            1 => DL32 (X, 4),
            2 => DL32 (X, 8),
            3 => DL32 (X, 12),
            4 => DL32 (X, 16),
            5 => DL32 (X, 20),
            6 => DL32 (X, 24),
            7 => DL32 (X, 28));
      Z := A;

      LN := I64 (M'Length);  --  Remaining bytes
      CB := M'First;         --  Current block base offset

      while (LN >= 64) loop
         pragma Loop_Optimize (No_Unroll);

         pragma Warnings (Off, "lower bound test*");
         pragma Loop_Variant (Decreases => LN);
         pragma Loop_Invariant
           ((LN + I64 (CB) = I64 (M'Last) + 1) and
              (LN in 64 .. M'Length) and
              (CB in M'First .. (M'Last - 63)));

         --  1. start preparing message schedule, Wt = Mt for 0 <= t <= 15
         W := (0  => DL32 (M, CB),
               1  => DL32 (M, CB + 4),
               2  => DL32 (M, CB + 8),
               3  => DL32 (M, CB + 12),
               4  => DL32 (M, CB + 16),
               5  => DL32 (M, CB + 20),
               6  => DL32 (M, CB + 24),
               7  => DL32 (M, CB + 28),
               8  => DL32 (M, CB + 32),
               9  => DL32 (M, CB + 36),
               10 => DL32 (M, CB + 40),
               11 => DL32 (M, CB + 44),
               12 => DL32 (M, CB + 48),
               13 => DL32 (M, CB + 52),
               14 => DL32 (M, CB + 56),
               15 => DL32 (M, CB + 60));

         for I in Index_64 loop
            pragma Loop_Optimize (No_Unroll);

            pragma Loop_Invariant ((LN + I64 (CB) = I64 (M'Last) + 1) and
                                     (LN in 64 .. M'Length) and
                                     (CB in M'First .. (M'Last - 63)));
            --  2. Initialize working variables
            B := A;

            --  T1 := h + UC_Sigma1(e) + Ch (e, f, g) + K(t) + Wt
            T := A (7) + UC_Sigma1 (A (4)) + Ch (A (4), A (5), A (6)) +
                 K_256 (I) + W (I mod 16);

            --  T2 := UC_Sigma0 (a) + Maj (a, b, c);
            --  temp: T1 + T2
            B (7) := T + UC_Sigma0 (A (0)) + Maj (A (0), A (1), A (2));

            --  temp: d + T1
            B (3) := B (3) + T;

            A := (0 => B (7),    --  a := T1 + T2
                  1 => B (0),    --  b := a
                  2 => B (1),    --  c := b
                  3 => B (2),    --  d := c
                  4 => B (3),    --  e := d + T1
                  5 => B (4),    --  f := e
                  6 => B (5),    --  g := f
                  7 => B (6));   --  h := g

            --  finish preparing message schedule for next round
            --  Wt := LC_Sigma0 (W (t-2)) + W (t-7) +
            --        LC_Sigma0 (W (t-15)) + W (t-16)
            if (I mod 16 = 15) then
               for J in Index_16 loop
                  pragma Loop_Optimize (No_Unroll);
                  W (J) := W (J) + W ((J + 9) mod 16) +
                    LC_Sigma0 (W ((J + 1) mod 16)) +
                    LC_Sigma1 (W ((J + 14) mod 16));
               end loop;
            end if;

         end loop;

         --  Compute Ith intermediate hash value H(i)
         --  H0(i) := H0(i-1) + a
         --  H1(i) := H1(i-1) + b
         for I in Index_8 loop
            pragma Loop_Optimize (No_Unroll);
            A (I) := A (I) + Z (I);
            Z (I) := A (I);
         end loop;

         exit when LN < 128;
         pragma Assert (LN >= 64);
         CB := CB + 64;
         LN := LN - 64;
      end loop;

      --  Concatenate intermediate hash values into final digest
      for I in Index_8 loop
         pragma Loop_Optimize (No_Unroll);
         X (4 * I .. (4 * I + 3)) := TS32 (Z (I));
      end loop;

   end Hashblocks_256;

   procedure Hash (Output :    out Digest;
                   M      : in     Byte_Seq)
   is
      subtype Final_Block_Length is N32 range 0 .. 63;
      H     : Bytes_32;
      X     : Bytes_128; --  padding block(s).
      B     : Final_Block_Length;
      Final_Block_First : I32;
   begin
      H := IV_256;
      X := (others => 0);

      Hashblocks_256 (H, M);

      B := Final_Block_Length (M'Length mod 64);

      --  If message doesn't end on block boundary, then copy message
      --  bytes into the padding block. If it _did_ end on block boundary,
      --  those bytes have already been accounted for in the message digest
      --  so far, and we'll hash the entire padding block.
      if B > 0 then
         Final_Block_First := (M'Last - B) + 1;
         X (0 .. B - 1) := M (Final_Block_First .. M'Last);
      end if;
      X (B) := 128;     --  set leading bit at end of message

      --  Final 8 bytes are the length of M in bits
      if B < 56 then
         --  fill end of message's final 512-bit block, and hash only that.
         X (56 .. 63) := Big_Endian_Unpack (U64 (M'Length * 8));
         Hashblocks_256 (H, X (0 .. 63));
      else
         --  add an additional 512-bit block and hash both it and the end of
         --  the message's final block.
         X (120 .. 127) := Big_Endian_Unpack (U64 (M'Length * 8));
         Hashblocks_256 (H, X);
      end if;

      Output := H;
   end Hash;

   function Hash (M : in Byte_Seq) return Digest
   is
      R : Digest;
   begin
      Hash (R, M);
      return R;
   end Hash;

end SPARKNaCl.Hashing.SHA256;

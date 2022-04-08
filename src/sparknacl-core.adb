package body SPARKNaCl.Core
  with Pure,
       SPARK_Mode => On
is
   pragma Warnings (GNATProve, Off, "pragma * ignored (not yet supported)");

   --===============================
   --  Local subprogram declarations
   --  and renamings
   --===============================

   --  Derives intermediate values X and Y from Input, K and C.
   --  Common to both Salsa20 and HSalsa20
   procedure Core_Common
     (Input  : in     Bytes_16;
      K      : in     Salsa20_Key;
      C      : in     Bytes_16;
      X      :    out U32_Seq_16;
      Y      :    out U32_Seq_16)
     with Global => null;

   --  Little-endian conversion, so least-significant 8 bits
   --  of U go into X (0)
   procedure ST32 (X :    out Bytes_4;
                   U : in     U32)
     with Global => null;

   --  Little-endian conversion, so least-significant 8 bits
   --  of U go into X (0)
   procedure ST64 (X :    out Bytes_8;
                   U : in     U64)
     with Global => null;

   --  Little-endian conversion, so X (0) becomes
   --  the least-significant 8 bits of the returned value
   function LD32 (X : in Bytes_4) return U32
     with Global => null;

   function RL32 (X : in U32;
                  C : in Natural) return U32
     renames Rotate_Left;

   --===============================
   --  Local subprogram bodies
   --===============================

   procedure ST32 (X :    out Bytes_4;
                   U : in     U32)
   is
      T : U32 := U;
   begin
      for I in X'Range loop
         pragma Loop_Optimize (No_Unroll);
         X (I) := Byte (T mod 256);
         T := Shift_Right (T, 8);
      end loop;
   end ST32;

   procedure ST64 (X :    out Bytes_8;
                   U : in     U64)
   is
      T : U64 := U;
   begin
      for I in X'Range loop
         pragma Loop_Optimize (No_Unroll);
         X (I) := Byte (T mod 256);
         T := Shift_Right (T, 8);
      end loop;
   end ST64;

   function LD32 (X : in Bytes_4) return U32
   is
      U : U32;
   begin
      U := U32 (X (3));
      U := Shift_Left (U, 8) or U32 (X (2));
      U := Shift_Left (U, 8) or U32 (X (1));
      return Shift_Left (U, 8) or U32 (X (0));
   end LD32;

   procedure Core_Common
     (Input  : in     Bytes_16;
      K      : in     Salsa20_Key;
      C      : in     Bytes_16;
      X      :    out U32_Seq_16;
      Y      :    out U32_Seq_16)
   is
      W : U32_Seq_16;
      T : U32_Seq_4;

      --  Common to all iterations of the inner loop,
      --  so factored out here.
      procedure Adjust_T
        with Global => (In_Out => T);

      procedure Adjust_T
      is
      begin
         T (1) := T (1) xor RL32 (T (0) + T (3), 7);
         T (2) := T (2) xor RL32 (T (1) + T (0), 9);
         T (3) := T (3) xor RL32 (T (2) + T (1), 13);
         T (0) := T (0) xor RL32 (T (3) + T (2), 18);
      end Adjust_T;
   begin
      W := (others => 0);
      --  In C this is a loop, but we unroll and make single
      --  aggregate assignment to initialize the whole of X.
      X := (0  => LD32 (C (0 .. 3)),
            1  => LD32 (Bytes_4 (K.F (0 .. 3))),
            6  => LD32 (Input (0 .. 3)),
            11 => LD32 (Bytes_4 (K.F (16 .. 19))),

            5  => LD32 (C (4 .. 7)),
            2  => LD32 (Bytes_4 (K.F (4 .. 7))),
            7  => LD32 (Input (4 .. 7)),
            12 => LD32 (Bytes_4 (K.F (20 .. 23))),

            10 => LD32 (C (8 .. 11)),
            3  => LD32 (Bytes_4 (K.F (8 .. 11))),
            8  => LD32 (Input (8 .. 11)),
            13 => LD32 (Bytes_4 (K.F (24 .. 27))),

            15 => LD32 (C (12 .. 15)),
            4  => LD32 (Bytes_4 (K.F (12 .. 15))),
            9  => LD32 (Input (12 .. 15)),
            14 => LD32 (Bytes_4 (K.F (28 .. 31))));

      Y := X;

      for I in Index_20 loop
         pragma Loop_Optimize (No_Unroll);
         --  This inner loop has been unrolled manually and
         --  simplified in SPARKNaCl.
         --
         --  ORIGINAL CODE:
         --  for J in Index_4 loop
         --     T := (0 => X ((5 * J) mod 16),
         --           1 => X ((5 * J + 4) mod 16),
         --           2 => X ((5 * J + 8) mod 16),
         --           3 => X ((5 * J + 12) mod 16));

         --     T (1) := T (1) xor RL32 (T (0) + T (3), 7);
         --     T (2) := T (2) xor RL32 (T (1) + T (0), 9);
         --     T (3) := T (3) xor RL32 (T (2) + T (1), 13);
         --     T (0) := T (0) xor RL32 (T (3) + T (2), 18);

         --     W (4 * J + ((J + 0) mod 4)) := T (0);
         --     W (4 * J + ((J + 1) mod 4)) := T (1);
         --     W (4 * J + ((J + 2) mod 4)) := T (2);
         --     W (4 * J + ((J + 3) mod 4)) := T (3);
         --  end loop;

         --  Begin loop unrolling --
         --  Iteration with J = 0 --
         T := (0 => X (0),
               1 => X (4),
               2 => X (8),
               3 => X (12));

         Adjust_T;

         W (0) := T (0);
         W (1) := T (1);
         W (2) := T (2);
         W (3) := T (3);

         --  Iteration with J = 1 --
         T := (0 => X (5),
               1 => X (9),
               2 => X (13),
               3 => X (1));

         Adjust_T;

         W (5) := T (0);
         W (6) := T (1);
         W (7) := T (2);
         W (4) := T (3);

         --  Iteration with J = 2 --
         T := (0 => X (10),
               1 => X (14),
               2 => X (2),
               3 => X (6));

         Adjust_T;

         W (10) := T (0);
         W (11) := T (1);
         W (8)  := T (2);
         W (9)  := T (3);

         --  Iteration with J = 3 --
         T := (0 => X (15),
               1 => X (3),
               2 => X (7),
               3 => X (11));

         Adjust_T;

         W (15) := T (0);
         W (12) := T (1);
         W (13) := T (2);
         W (14) := T (3);
         --  End loop unrolling  --

         X := W;
      end loop;
   end Core_Common;

   --------------------------------------------------------
   --  Exported subprogram bodies
   --------------------------------------------------------

   function Construct (K : in Bytes_32) return Salsa20_Key
   is
   begin
      return Salsa20_Key'(F => K);
   end Construct;

   procedure Construct (K :    out Salsa20_Key;
                        X : in     Bytes_32)
   is
   begin
      K.F := X;
   end Construct;

   function Serialize (K : in Salsa20_Key) return Bytes_32
   is
   begin
      return K.F;
   end Serialize;

   procedure Sanitize (K : out Salsa20_Key)
   is
   begin
      Sanitize (K.F);
   end Sanitize;

   function Construct (K : in Bytes_32) return ChaCha20_Key
   is
   begin
      return ChaCha20_Key'(F => K);
   end Construct;

   procedure Construct (K :    out ChaCha20_Key;
                        X : in     Bytes_32)
   is
   begin
      K.F := X;
   end Construct;

   function Serialize (K : in ChaCha20_Key) return Bytes_32
   is
   begin
      return K.F;
   end Serialize;

   procedure Sanitize (K : out ChaCha20_Key)
   is
   begin
      Sanitize (K.F);
   end Sanitize;

   procedure Sanitize (S : out ChaCha20_Context)
   is
   begin
      Sanitize_U32_Seq (S.F);
   end Sanitize;

   --------------------------------------------------------
   --  Salsa20 Core subprograms
   --------------------------------------------------------

   procedure Salsa20 (Output :    out Bytes_64;
                      Input  : in     Bytes_16;
                      K      : in     Salsa20_Key;
                      C      : in     Bytes_16)
   is
      X, Y : U32_Seq_16;
   begin
      Core_Common (Input, K, C, X, Y);

      --  Salsa20 Output stage
      --  derives Output from X, Y
      Output := (others => 0);
      for I in Index_16 loop
         pragma Loop_Optimize (No_Unroll);
         ST32 (Output (4 * I .. 4 * I + 3), X (I) + Y (I));
      end loop;
   end Salsa20;

   procedure HSalsa20 (Output :    out Bytes_32;
                       Input  : in     Bytes_16;
                       K      : in     Salsa20_Key;
                       C      : in     Bytes_16)
   is
      X, Y : U32_Seq_16;
   begin
      Core_Common (Input, K, C, X, Y);

      --  HSalsa20 output stage
      --  derives Output from X, Y, C, Input
      for I in Index_16 loop
         pragma Loop_Optimize (No_Unroll);
         X (I) := X (I) + Y (I);
      end loop;

      for I in Index_4 loop
         pragma Loop_Optimize (No_Unroll);
         X (5 * I) := X (5 * I) - LD32 (C (4 * I .. 4 * I + 3));
         X (6 + I) := X (6 + I) - LD32 (Input (4 * I .. 4 * I + 3));
      end loop;

      Output := (others => 0);
      for I in Index_4 loop
         pragma Loop_Optimize (No_Unroll);
         ST32 (Output (4 * I .. 4 * I + 3), X (5 * I));
         ST32 (Output (4 * I + 16 .. 4 * I + 19), X (6 + I));
      end loop;
   end HSalsa20;

   --------------------------------------------------------
   --  ChaCha20 Core functions
   --------------------------------------------------------
   procedure ChaCha20_Key_IV_Setup (Context :    out ChaCha20_Context;
                                    K       : in     ChaCha20_Key;
                                    N       : in     ChaCha20_Nonce;
                                    Counter : in     U64)
   is
      Counter_Bytes : Bytes_8;
   begin
      ST64 (Counter_Bytes, Counter);

      Context.F :=
         (0  => LD32 (Sigma (0 .. 3)),
          1  => LD32 (Sigma (4 .. 7)),
          2  => LD32 (Sigma (8 .. 11)),
          3  => LD32 (Sigma (12 .. 15)),
          4  => LD32 (K.F (0 .. 3)),
          5  => LD32 (K.F (4 .. 7)),
          6  => LD32 (K.F (8 .. 11)),
          7  => LD32 (K.F (12 .. 15)),
          8  => LD32 (K.F (16 .. 19)),
          9  => LD32 (K.F (20 .. 23)),
          10 => LD32 (K.F (24 .. 27)),
          11 => LD32 (K.F (28 .. 31)),

          --  chacha_ivsetup in reference. reference imp has counter baked
          --  into the IV, broken out separately here
          12 => LD32 (Counter_Bytes (0 .. 3)),
          13 => LD32 (Counter_Bytes (4 .. 7)),
          14 => LD32 (N (0 .. 3)),
          15 => LD32 (N (4 .. 7)));

      pragma Unreferenced (Counter_Bytes);
   end ChaCha20_Key_IV_Setup;

   procedure ChaCha20_Key_IV_IETF_Setup (Context :    out ChaCha20_Context;
                                         K       : in     ChaCha20_Key;
                                         N       : in     ChaCha20_IETF_Nonce;
                                         Counter : in     U32)
   is
      Counter_Bytes : Bytes_4;
   begin
      ST32 (Counter_Bytes, Counter);

      Context.F :=
         (0  => LD32 (Sigma (0 .. 3)),
          1  => LD32 (Sigma (4 .. 7)),
          2  => LD32 (Sigma (8 .. 11)),
          3  => LD32 (Sigma (12 .. 15)),
          4  => LD32 (K.F (0 .. 3)),
          5  => LD32 (K.F (4 .. 7)),
          6  => LD32 (K.F (8 .. 11)),
          7  => LD32 (K.F (12 .. 15)),
          8  => LD32 (K.F (16 .. 19)),
          9  => LD32 (K.F (20 .. 23)),
          10 => LD32 (K.F (24 .. 27)),
          11 => LD32 (K.F (28 .. 31)),
          12 => LD32 (Counter_Bytes (0 .. 3)),
          13 => LD32 (N (0 .. 3)),
          14 => LD32 (N (4 .. 7)),
          15 => LD32 (N (8 .. 11)));

      pragma Unreferenced (Counter_Bytes);
   end ChaCha20_Key_IV_IETF_Setup;

   procedure ChaCha20_Encrypt_Bytes (Context : in     ChaCha20_Context;
                                     C       :    out Byte_Seq;
                                     M       : in     Byte_Seq;
                                     Xor_M   : in     Boolean)
   is
      --  Fwd declare
      procedure Quarter_Round (a, b, c, d : in out U32) with Global => null;

      procedure Quarter_Round (a, b, c, d : in out U32) is
      begin
         a := a + b;
         d := RL32 (d xor a, 16);
         c := c + d;
         b := RL32 (b xor c, 12);
         a := a + b;
         d := RL32 (d xor a, 8);
         c := c + d;
         b := RL32 (b xor c, 7);
      end Quarter_Round;

      --  state after each round
      x0, x1, x2, x3, x4, x5, x6, x7,
      x8, x9, x10, x11, x12, x13, x14, x15 : U32;

      --  initial state
      j0, j1, j2, j3, j4, j5, j6, j7,
      j8, j9, j10, j11, j12, j13, j14, j15 : U32;

      B : N32 := C'Length;

      --  Used for the last block if < 64 bytes
      Tmp : Bytes_64 := (others => 0);

      CI : N32 := C'First;
      MI : N32 := M'First;

   begin
      j0  := Context.F (0);
      j1  := Context.F (1);
      j2  := Context.F (2);
      j3  := Context.F (3);
      j4  := Context.F (4);
      j5  := Context.F (5);
      j6  := Context.F (6);
      j7  := Context.F (7);
      j8  := Context.F (8);
      j9  := Context.F (9);
      j10 := Context.F (10);
      j11 := Context.F (11);
      j12 := Context.F (12);
      j13 := Context.F (13);
      j14 := Context.F (14);
      j15 := Context.F (15);

      loop
         pragma Loop_Optimize (No_Unroll);

         if B < 64 then
            Tmp (0 .. B - 1) := M (MI .. MI + B - 1);
         end if;

         x0  := j0;
         x1  := j1;
         x2  := j2;
         x3  := j3;
         x4  := j4;
         x5  := j5;
         x6  := j6;
         x7  := j7;
         x8  := j8;
         x9  := j9;
         x10 := j10;
         x11 := j11;
         x12 := j12;
         x13 := j13;
         x14 := j14;
         x15 := j15;

         for R in 1 .. 10 loop
            Quarter_Round (x0, x4,  x8, x12);
            Quarter_Round (x1, x5,  x9, x13);
            Quarter_Round (x2, x6, x10, x14);
            Quarter_Round (x3, x7, x11, x15);
            Quarter_Round (x0, x5, x10, x15);
            Quarter_Round (x1, x6, x11, x12);
            Quarter_Round (x2, x7,  x8, x13);
            Quarter_Round (x3, x4,  x9, x14);
         end loop;

         x0  := x0  + j0;
         x1  := x1  + j1;
         x2  := x2  + j2;
         x3  := x3  + j3;
         x4  := x4  + j4;
         x5  := x5  + j5;
         x6  := x6  + j6;
         x7  := x7  + j7;
         x8  := x8  + j8;
         x9  := x9  + j9;
         x10 := x10 + j10;
         x11 := x11 + j11;
         x12 := x12 + j12;
         x13 := x13 + j13;
         x14 := x14 + j14;
         x15 := x15 + j15;

         if B >= 64 then
            x0  := x0  xor LD32 (M (MI + 0  .. MI + 3));
            x1  := x1  xor LD32 (M (MI + 4  .. MI + 7));
            x2  := x2  xor LD32 (M (MI + 8  .. MI + 11));
            x3  := x3  xor LD32 (M (MI + 12 .. MI + 15));
            x4  := x4  xor LD32 (M (MI + 16 .. MI + 19));
            x5  := x5  xor LD32 (M (MI + 20 .. MI + 23));
            x6  := x6  xor LD32 (M (MI + 24 .. MI + 27));
            x7  := x7  xor LD32 (M (MI + 28 .. MI + 31));
            x8  := x8  xor LD32 (M (MI + 32 .. MI + 35));
            x9  := x9  xor LD32 (M (MI + 36 .. MI + 39));
            x10 := x10 xor LD32 (M (MI + 40 .. MI + 43));
            x11 := x11 xor LD32 (M (MI + 44 .. MI + 47));
            x12 := x12 xor LD32 (M (MI + 48 .. MI + 51));
            x13 := x13 xor LD32 (M (MI + 52 .. MI + 55));
            x14 := x14 xor LD32 (M (MI + 56 .. MI + 59));
            x15 := x15 xor LD32 (M (MI + 60 .. MI + 63));
         else
            x0  := x0  xor LD32 (Tmp (0  .. 3));
            x1  := x1  xor LD32 (Tmp (4  .. 7));
            x2  := x2  xor LD32 (Tmp (8  .. 11));
            x3  := x3  xor LD32 (Tmp (12 .. 15));
            x4  := x4  xor LD32 (Tmp (16 .. 19));
            x5  := x5  xor LD32 (Tmp (20 .. 23));
            x6  := x6  xor LD32 (Tmp (24 .. 27));
            x7  := x7  xor LD32 (Tmp (28 .. 31));
            x8  := x8  xor LD32 (Tmp (32 .. 35));
            x9  := x9  xor LD32 (Tmp (36 .. 39));
            x10 := x10 xor LD32 (Tmp (40 .. 43));
            x11 := x11 xor LD32 (Tmp (44 .. 47));
            x12 := x12 xor LD32 (Tmp (48 .. 51));
            x13 := x13 xor LD32 (Tmp (52 .. 55));
            x14 := x14 xor LD32 (Tmp (56 .. 59));
            x15 := x15 xor LD32 (Tmp (60 .. 63));
         end if;

         --  increment counter - note that for IETF usage this will clobber
         --  the nonce if counter overflows.
         j12 := j12 + 1;
         if j12 = 0 then
            j13 := j13 + 1;
         end if;

         if B = 64 then
            --  Final block of exactly 64 bytes
            ST32 (C (CI + 0  .. CI + 3),  x0);
            ST32 (C (CI + 4  .. CI + 7),  x1);
            ST32 (C (CI + 8  .. CI + 11), x2);
            ST32 (C (CI + 12 .. CI + 15), x3);
            ST32 (C (CI + 16 .. CI + 19), x4);
            ST32 (C (CI + 20 .. CI + 23), x5);
            ST32 (C (CI + 24 .. CI + 27), x6);
            ST32 (C (CI + 28 .. CI + 31), x7);
            ST32 (C (CI + 32 .. CI + 35), x8);
            ST32 (C (CI + 36 .. CI + 39), x9);
            ST32 (C (CI + 40 .. CI + 43), x10);
            ST32 (C (CI + 44 .. CI + 47), x11);
            ST32 (C (CI + 48 .. CI + 51), x12);
            ST32 (C (CI + 52 .. CI + 55), x13);
            ST32 (C (CI + 56 .. CI + 59), x14);
            ST32 (C (CI + 60 .. CI + 63), x15);

            --  On exit, we should have initialized the whole of C
            pragma Assert (CI + 63 = C'Last and then
                           C (C'First .. C'Last)'Initialized);

            exit;
         elsif B < 64 then
            --  Final block, less than 64 bytes
            ST32 (Tmp (0  .. 3),  x0);
            ST32 (Tmp (4  .. 7),  x1);
            ST32 (Tmp (8  .. 11), x2);
            ST32 (Tmp (12 .. 15), x3);
            ST32 (Tmp (16 .. 19), x4);
            ST32 (Tmp (20 .. 23), x5);
            ST32 (Tmp (24 .. 27), x6);
            ST32 (Tmp (28 .. 31), x7);
            ST32 (Tmp (32 .. 35), x8);
            ST32 (Tmp (36 .. 39), x9);
            ST32 (Tmp (40 .. 43), x10);
            ST32 (Tmp (44 .. 47), x11);
            ST32 (Tmp (48 .. 51), x12);
            ST32 (Tmp (52 .. 55), x13);
            ST32 (Tmp (56 .. 59), x14);
            ST32 (Tmp (60 .. 63), x15);

            C (CI .. CI + B - 1) := Tmp (0 .. B - 1);

            --  On exit, we should have initialized the whole of C
            pragma Assert (C (C'First .. C'Last)'Initialized);

            --  ref impl has these lines but other implementations treat the
            --  context/initial state as purely read-only, leaving it to the
            --  application to keep track of updating the counter between
            --  invocations of the chacha20 function.
            --  Context (12) := j12;
            --  Context (13) := j13;
            exit;
         else
            pragma Assert (B > 64);
            ST32 (C (CI + 0  .. CI + 3),  x0);
            ST32 (C (CI + 4  .. CI + 7),  x1);
            ST32 (C (CI + 8  .. CI + 11), x2);
            ST32 (C (CI + 12 .. CI + 15), x3);
            ST32 (C (CI + 16 .. CI + 19), x4);
            ST32 (C (CI + 20 .. CI + 23), x5);
            ST32 (C (CI + 24 .. CI + 27), x6);
            ST32 (C (CI + 28 .. CI + 31), x7);
            ST32 (C (CI + 32 .. CI + 35), x8);
            ST32 (C (CI + 36 .. CI + 39), x9);
            ST32 (C (CI + 40 .. CI + 43), x10);
            ST32 (C (CI + 44 .. CI + 47), x11);
            ST32 (C (CI + 48 .. CI + 51), x12);
            ST32 (C (CI + 52 .. CI + 55), x13);
            ST32 (C (CI + 56 .. CI + 59), x14);
            ST32 (C (CI + 60 .. CI + 63), x15);

            pragma Assert (CI + B - 1 = C'Last and then
                           C (CI + 0 .. CI + 63)'Initialized);

            B  := B - 64;
            CI := CI + 64;

            --  If we are just generating the cipher stream, then expect M
            --  to be a 64-byte array of just zeroes. We'll always start it
            --  from 0.
            if Xor_M then
               MI := MI + 64;
            end if;
         end if;

         pragma Loop_Invariant
           (B + CI = C'Length);
         pragma Loop_Invariant
           (CI <= C'Length - B);
         pragma Loop_Invariant
           (C'First + CI - 1 = C'Last - B);

         --  C is partly initialized, with B bytes still to go
         pragma Loop_Invariant
           (C (C'First .. C'Last - B)'Initialized);
         pragma Loop_Invariant
           (if not Xor_M then MI = M'First);
         pragma Loop_Invariant
           (if Xor_M then M'Length = C'Length);
         pragma Loop_Invariant
           (if Xor_M then B + MI = M'Length);

      end loop;
      pragma Assert (C (C'First .. C'Last)'Initialized);
      pragma Assert (C'Initialized);
   end ChaCha20_Encrypt_Bytes;

end SPARKNaCl.Core;

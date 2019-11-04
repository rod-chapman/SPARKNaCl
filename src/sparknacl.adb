with SPARKNaCl.Hashing;
with SPARKNaCl.Core;
with SPARKNaCl.Stream;

package body SPARKNaCl
  with SPARK_Mode => On
is
   --===================
   --  Local constants
   --===================

   Zero : constant Bytes_16 := (others => 0);
   Nine : constant Bytes_32 := (9, others => 0);

   GF_0      : constant GF := (others => 0);
   GF_1      : constant GF := (1, others => 0);
   GF_121665 : constant GF := (16#DB41#, 1, others => 0);

   GF_D  : constant GF := (16#78a3#, 16#1359#, 16#4dca#, 16#75eb#,
                           16#d8ab#, 16#4141#, 16#0a4d#, 16#0070#,
                           16#e898#, 16#7779#, 16#4079#, 16#8cc7#,
                           16#fe73#, 16#2b6f#, 16#6cee#, 16#5203#);

   GF_D2 : constant GF := (16#f159#, 16#26b2#, 16#9b94#, 16#ebd6#,
                           16#b156#, 16#8283#, 16#149a#, 16#00e0#,
                           16#d130#, 16#eef3#, 16#80f2#, 16#198e#,
                           16#fce7#, 16#56df#, 16#d9dc#, 16#2406#);

   GF_X  : constant GF := (16#d51a#, 16#8f25#, 16#2d60#, 16#c956#,
                           16#a7b2#, 16#9525#, 16#c760#, 16#692c#,
                           16#dc5c#, 16#fdd6#, 16#e231#, 16#c0a4#,
                           16#53fe#, 16#cd6e#, 16#36d3#, 16#2169#);

   GF_Y  : constant GF := (16#6658#, 16#6666#, 16#6666#, 16#6666#,
                           16#6666#, 16#6666#, 16#6666#, 16#6666#,
                           16#6666#, 16#6666#, 16#6666#, 16#6666#,
                           16#6666#, 16#6666#, 16#6666#, 16#6666#);

   GF_I  : constant GF := (16#a0b0#, 16#4a0e#, 16#1b27#, 16#c4ee#,
                           16#e478#, 16#ad2f#, 16#1806#, 16#2f43#,
                           16#d7a7#, 16#3dfb#, 16#0099#, 16#2b4d#,
                           16#df0b#, 16#4fc1#, 16#2480#, 16#2b83#);

   --===============================
   --  Local subprogram declarations
   --===============================

   function Random_Bytes_32 return Bytes_32
     with Global => Random.Entropy,
          Volatile_Function;

   --  Constant time conditional swap of P and Q.
   --  If B = 0 then don't swap
   --  If B = 1 then swap
   procedure Sel_25519 (P : in out GF;
                        Q : in out GF;
                        B : in     Bit)
     with Global => null;

   procedure Pack_25519 (O :    out Bytes_32;
                         N : in    GF)
     with Global => null;

   procedure Unpack_25519 (O :    out GF;
                           N : in     Bytes_32)
     with Global => null;

   function Par_25519 (A : in GF) return Bit
     with Global => null;

   --  Carry reduction of all elements of O
   procedure Car_25519 (O : in out GF)
     with Global => null;

   procedure Inv_25519 (O : out    GF;
                        I :     in GF)
     with Global => null;

   procedure Pack (R :    out Bytes_32;
                   P : in     GF_Vector_4)
     with Global => null;

   --  Multiply
   procedure M (O    :    out GF;
                A, B : in     GF)
     with Global => null;

   --  Add
   procedure A (O    :    out GF;
                A, B : in     GF)
     with Global => null;

   --  Subtract
   procedure Z (O    :    out GF;
                A, B : in     GF)
     with Global => null;

   --  Square
   procedure S (O :    out GF;
                A : in     GF)
     with Global => null;

   procedure Add (P : in out GF_Vector_4;
                  Q : in     GF_Vector_4)
     with Global => null;


   procedure Unpackneg (R  :    out GF_Vector_4;
                        OK :    out Boolean;
                        P  : in     Bytes_32)
     with Global => null;

   procedure ModL (R : in out Bytes_64; -- this is odd!
                   X : in out I64_Seq_64)
     with Global => null;

   procedure Reduce (R : in out Bytes_64)
     with Global => null;

   procedure Scalarmult (P :    out GF_Vector_4;
                         Q : in out GF_Vector_4;
                         S : in     Bytes_32)
     with Global => null;

   procedure Scalarbase (P :    out GF_Vector_4;
                         S : in     Bytes_32)
     with Global => null;

   --===============================
   --  Local subprogram bodies
   --===============================

   --  POK
   function Random_Bytes_32 return Bytes_32
   is
      Result : Bytes_32;
   begin
      for I in Result'Range loop
         Result (I) := Random.Random_Byte;
      end loop;
      return Result;
   end Random_Bytes_32;

   --  POK
   procedure Sel_25519 (P : in out GF;
                        Q : in out GF;
                        B : in     Bit)
   is
      type Bit_To_Swapmask_Table is array (Bit) of U64;
      Bit_To_Swapmask : constant Bit_To_Swapmask_Table :=
        (0 => 16#0000_0000_0000_0000#,
         1 => 16#FFFF_FFFF_FFFF_FFFF#);

      T : U64;
      C : constant U64 := Bit_To_Swapmask (B);
   begin
      for I in Index_16 loop
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
         P (I) := To_I64 (To_U64 (P (I)) xor T);
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
      end loop;
   end Sel_25519;


   procedure Car_25519 (O : in out GF)
   is
      C : I64;
   begin
      --  In SPARK, we unroll the final (I = 15)'th iteration
      --  of this loop below. This removes the need for
      --  a conditional statement or expression inside the loop
      --  body.
      for I in Index_16 range 0 .. 14 loop
         O (I) := O (I) + 2#1_0000_0000_0000_0000#; --  POV
         C := ASR_16 (O (I));
         O (I + 1) := O (I + 1) + C - 1; --  POV on second + and -

         --  The C code here uses (c << 16) which is UNDEFINED
         --  for negative c according to C standard 6.5.7 (4).
         --  TweetNaCl appears to depend on this being equivalent
         --  to sign-preserving multiplication by 65536.
         pragma Assert (C >= -2**47);
         pragma Assert (C <= (2**47) - 1);

         O (I) := O (I) - (C * 65536); --  POV on - and *
      end loop;

      --  Final iteration, as would be when I = 15
      O (15) := O (15) + 2#1_0000_0000_0000_0000#; --  POV
      C := ASR_16 (O (15));
      O (0) := O (0) + C - 1 + 37 * (C - 1); --  POV on 5 binary ops!
      O (15) := O (15) - (C * 65536); --  POV on - and *
   end Car_25519;

   --  P?
   procedure Pack_25519 (O :    out Bytes_32;
                         N : in    GF)
   is
      B : Bit;
      M, T : GF;
   begin
      M := (others => 0);
      T := N;

      Car_25519 (T);
      Car_25519 (T);
      Car_25519 (T);

      for J in I32 range 0 .. 1 loop
         M (0) := T (0) - 16#FFED#; --  POV
         for I in I32 range 1 .. 14 loop

            M (I) := T (I) -
                     16#FFFF# -
                     (ASR_16 (M (I - 1)) mod 2); --  POV * 2

            M (I - 1) := M (I - 1) mod 65536;
         end loop;
         M (15) := T (15) - 16#7FFF# - (ASR_16 (M (14)) mod 2); --  POV * 2

         B := Bit (ASR_16 (M (15)) mod 2);

         M (14) := M (14) mod 65536;
         Sel_25519 (T, M, 1 - B);
      end loop;

      O := (others => 0);
      for I in Index_16 loop
         pragma Assert (T (I) >= 0); --  PAssert? Depends on post of above loop
         pragma Assert (T (I) <= 65535); --  PAssert?

         O (2 * I) := Byte (T (I) mod 256);
         O (2 * I + 1) := Byte ((T (I) / 256) mod 256);
      end loop;
   end Pack_25519;


   --  POK
   procedure Unpack_25519 (O :    out GF;
                           N : in     Bytes_32)
   is

   begin
      for I in Index_16 loop
         O (I) := I64 (N (2 * I)) + (I64 (N (2 * I + 1)) * 256);
      end loop;
      O (15) := O (15) mod 32768;
   end Unpack_25519;


   --  POK
   function Par_25519 (A : in GF) return Bit
   is
      D : Bytes_32;
   begin
      Pack_25519 (D, A);
      return (D (0) mod 2);
   end Par_25519;


   procedure M (O    :    out GF;
                A, B : in     GF)
   is
      subtype TA is I64_Seq (Index_31);
      T : TA;
   begin
      T := (others => 0);

      for I in Index_16 loop
         for J in Index_16 loop
            T (I + J) := T (I + J) + (A (I) * B (J)); --  POV * 2
         end loop;
      end loop;

      --  Assuming both A and B are normalized on entry (so all
      --  limbs in 0 .. 65535), then
      --  here T(I) >= 0 and T(I) <= N*(65535**2), where N ranges
      --  from 1 (for I = 0 and I = 30) up to 16 (for I = 15)

      for I in Index_15 loop
         T (I) := T (I) + 38 * T (I + 16); --  POV * 2
      end loop;

      O := T (0 .. 15);

      Car_25519 (O);
      Car_25519 (O);
   end M;

   procedure A (O    :    out GF;
                A, B : in     GF)
   is
   begin
      for I in Index_16 loop
         O (I) := A (I) + B (I); --  POV
      end loop;
   end A;

   procedure Z (O    :    out GF;
                A, B : in     GF)
   is
   begin
      for I in Index_16 loop
         O (I) := A (I) - B (I); --  POV
      end loop;
   end Z;

   --  POK
   procedure S (O :    out GF;
                A : in     GF)
   is
   begin
      M (O, A, A);
   end S;

   --  POK
   procedure TS64 (X :    out Bytes_8;
                   U : in     U64)

   is
      T : U64 := U;
   begin
      for I in reverse Index_8 loop
         X (I) := Byte (T mod 256);
         T := Shift_Right (T, 8);
      end loop;
   end TS64;

   --  POK
   procedure Inv_25519 (O : out    GF;
                        I :     in GF)
   is
      C, C2 : GF;
   begin
      C := I;

      for A in reverse 0 .. 253 loop
         --  Need C2 here to avoid aliasing C with C via pass by reference
         S (C2, C);
         if (A /= 2 and A /= 4) then
            M (C, C2, I);
         else
            C := C2;
         end if;
      end loop;

      O := C;
   end Inv_25519;

   --  POK
   procedure Pack (R :    out Bytes_32;
                   P : in     GF_Vector_4)
   is
      TX, TY, ZI : GF;
   begin
      Inv_25519 (ZI, P (2));
      M (TX, P (0), ZI);
      M (TY, P (1), ZI);
      Pack_25519 (R, TY);
      R (31) := R (31) xor (Byte (Par_25519 (TX)) * 128);
   end Pack;


   --  POK
   procedure Add (P : in out GF_Vector_4;
                  Q : in     GF_Vector_4)
   is
      A1, A2, B1, B2, C1, C2, D1, D2, T, E, F, G, H : GF;
   begin
      Z (A1, P (1), P (0));
      Z (T, Q (1), Q (0));
      M (A2, A1, T);

      A (B1, P (0), P (1));
      A (T, Q (0), Q (1));
      M (B2, B1, T);

      M (C1, P (3), Q (3));
      M (C2, C1, GF_D2);
      M (D1, P (2), Q (2));

      A (D2, D1, D1);
      Z (E, B2, A2);
      Z (F, D2, C2);
      A (G, D2, C2);
      A (H, B2, A2);

      M (P (0), E, F);
      M (P (1), H, G);
      M (P (2), G, F);
      M (P (3), E, H);

   end Add;

   --  POK
   procedure Unpackneg (R  :    out GF_Vector_4;
                        OK :    out Boolean;
                        P  : in     Bytes_32)
   is
      T1, T2, T3, T4, T5, T6, T7, Chk, Chk1, Num,
      R_1_Squared, Den0, Den1, Den2, Den4, Den6 : GF;

      --  RCC - remove formals and access globals
      --        Chk1 and Num directly?
      function Eq_25519 (A, B : in GF) return Boolean
        with Global => null;

      --  RCC - remove formals and access globals
      --        T2 and T3 directly? Or make a function?
      procedure Pow_2523 (O :    out GF;
                          I : in     GF)
        with Global => null;

      --  POK
      function Eq_25519 (A, B : in GF) return Boolean
      is
         C, D : Bytes_32;
      begin
         Pack_25519 (C, A);
         Pack_25519 (D, B);
         return Equal (C, D);
      end Eq_25519;

      --  POK
      procedure Pow_2523 (O :    out GF;
                          I : in     GF)
      is
         C, C2 : GF;
      begin
         C := I;
         --  Note that 2**252 - 3 = 16#1111_1111 .. 1101#
         --  with only "bit 1" set to 0
         for A in reverse 0 .. 250 loop
            S (C2, C);
            if A = 1 then
               C := C2;
            else
               M (C, C2, I);
            end if;
         end loop;
         O := C;
      end Pow_2523;

   begin
      R := (others => GF_0);

      --  Call to Set_25519 replaced with assignment here
      R (2) := GF_1;
      Unpack_25519 (R (1), P);
      S (R_1_Squared, R (1));
      M (Den0, R_1_Squared, GF_D);
      Z (Num, R_1_Squared, R (2));
      A (Den1, R (2), Den0);

      S (Den2, Den1);
      S (Den4, Den2);
      M (Den6, Den4, Den2);
      M (T1, Den6, Num);
      M (T2, T1, Den1);

      Pow_2523 (T3, T2);

      M (T4, T3, Num);
      M (T5, T4, Den1);
      M (T6, T5, Den1);
      M (R (0), T6, Den1);

      S (Chk, R (0));
      M (Chk1, Chk, Den1);
      if (not Eq_25519 (Chk1, Num)) then
         M (T7, R (0), GF_I);
         R (0) := T7;
      end if;

      S (Chk, R (0));
      M (Chk1, Chk, Den1);

      if (not Eq_25519 (Chk1, Num)) then
         OK := False;
         return;
      end if;

      if Par_25519 (R (0)) = (P (31) / 128) then
         Z (T7, GF_0, R (0));
         R (0) := T7;
      end if;

      M (R (3), R (0), R (1));
      OK := True;
   end Unpackneg;


   procedure ModL (R : in out Bytes_64;
                   X : in out I64_Seq_64)
   is
      L : constant I64_Seq_32 := (16#ed#, 16#d3#, 16#f5#, 16#5c#,
                                  16#1a#, 16#63#, 16#12#, 16#58#,
                                  16#d6#, 16#9c#, 16#f7#, 16#a2#,
                                  16#de#, 16#f9#, 16#de#, 16#14#,
                                  16#00#, 16#00#, 16#00#, 16#00#,
                                  16#00#, 16#00#, 16#00#, 16#00#,
                                  16#00#, 16#00#, 16#00#, 16#00#,
                                  16#00#, 16#00#, 16#00#, 16#10#);
      Carry : I64;
   begin
      for I in reverse I32 range 32 .. 63 loop
         Carry := 0;
         for J in I32 range (I - 32) .. (I - 13) loop
            X (J) := X (J) + Carry - 16 * X (I) * L (J - (I - 32)); --  POV * 4
            Carry := ASR_8 (X (J) + 128); --  POV
            X (J) := X (J) - (Carry * 256); --  POV * 2
         end loop;
         X (I - 12) := X (I - 12) + Carry; --  POV
         X (I) := 0;
      end loop;
      Carry := 0;

      for J in Index_32 loop
         X (J) := X (J) + (Carry - ASR_4 (X (31)) * L (J)); -- POV * 3
         Carry := ASR_8 (X (J));
         X (J) := X (J) mod 256;
      end loop;

      for J in Index_32 loop
         X (J) := X (J) - Carry * L (J); --  POV * 2
      end loop;

      --  R is 64 bytes, this this only sets
      --  the first 32...
      for I in Index_32 loop
         X (I + 1) := X (I + 1) + ASR_8 (X (I)); --  POV
         R (I) := Byte (X (I) mod 256);
      end loop;

   end ModL;

   --  POV
   procedure Reduce (R : in out Bytes_64)
   is
      X : I64_Seq_64;
   begin
      for I in Index_64 loop
         X (I) := I64 (R (I));
      end loop;
      R := (others => 0);
      --  Ineffective assignment to X here expected
      ModL (R, X);
      pragma Unreferenced (X);
   end Reduce;


   --  POK
   procedure Scalarmult (P :    out GF_Vector_4;
                         Q : in out GF_Vector_4;
                         S : in     Bytes_32)
   is
      CB : Byte;
      B  : Bit;
      P2 : GF_Vector_4;

      --  RCC Remove formals for globals?
      procedure CSwap (P, Q : in out GF_Vector_4;
                       B    : in     Bit)
        with Global => null;

      --  POK
      procedure CSwap (P, Q : in out GF_Vector_4;
                       B    : in     Bit)
      is
      begin
         for I in Index_4 loop
            Sel_25519 (P (I), Q (I), B);
         end loop;
      end CSwap;

   begin
      P := (0 => GF_0,
            1 => GF_1,
            2 => GF_1,
            3 => GF_0);

      for I in reverse U32 range 0 .. 255 loop
         CB := S (I32 (Shift_Right (I, 3)));
         B  := Bit (Shift_Right (CB, Natural (I and 7)) and 1);

         CSwap (P, Q, B);
         Add (P => Q, Q => P);
         P2 := P;
         Add (P, P2);
         CSwap (P, Q, B);
      end loop;

   end Scalarmult;

   --  POK
   procedure Scalarbase (P :    out GF_Vector_4;
                         S : in     Bytes_32)
   is
      Q : GF_Vector_4;
   begin
      Q := (0 => GF_X,
            1 => GF_Y,
            2 => GF_1,
            3 => GF_0); -- just to complete aggregate

      --  RCC? Why recompute X * Y here each time - surely it's constant?
      M (Q (3), GF_X, GF_Y);

      Scalarmult (P, Q, S);

      pragma Unreferenced (Q);
   end Scalarbase;

   --===============================
   --  Exported subprogram bodies
   --===============================

   --------------------------------------------------------
   --  Constant time equality tests
   --------------------------------------------------------

   --  POK
   function Equal (X, Y : in Byte_Seq) return Boolean
   is
      D : Byte := 0;
   begin
      for I in X'Range loop
         D := D or (X (I) xor Y (I));
      end loop;
      --  D = 0         iff X and Y are equal
      --  D in 1 .. 255 iff X and Y are not equal

      return (D = 0);
   end Equal;

   --------------------------------------------------------
   --  Scalar multiplication
   --------------------------------------------------------

   --  POK
   procedure Crypto_Scalarmult (Q :    out Bytes_32;
                                N : in     Bytes_32;
                                P : in     Bytes_32)
   is
      Z2 : Bytes_32;
      X : GF;
      R : Bit;

      A2, A3, B, B2, C, C2, D, E, F, T1, T2 : GF;
      CB    : Byte;
      Shift : Natural;
   begin
      Z2 := N;
      Z2 (31) := (N (31) and 127) or 64;
      Z2 (0) := Z2 (0) and 248;

      Unpack_25519 (X, P);

      B  := X;
      C  := GF_0;
      A2 := GF_0;
      D  := GF_0;

      A2 (0) := 1;
      D  (0) := 1;

      for I in reverse U32 range 0 .. 254 loop
         CB := Z2 (I32 (Shift_Right (I, 3)));
         Shift := Natural (I and 7);
         R := Bit (Shift_Right (CB, Shift) and 1);

         Sel_25519 (A2, B, R);
         Sel_25519 (C, D, R);

         A (E, A2, C);

         Z (A3, A2, C);

         A (C, B, D);

         Z (B2, B, D);

         S (D, E);
         S (F, A3);

         M (A2, C, A3);
         M (C, B2, E);
         A (E, A2, C);

         Z (A3, A2, C);
         S (B, A3);
         Z (C, D, F);

         M (A2, C, GF_121665);
         A (A3, A2, D);

         C2 := C;
         M (C, C2, A3);

         M (A2, D, F);
         M (D, B, X);
         S (B, E);

         Sel_25519 (A2, B, R);
         Sel_25519 (C, D, R);
      end loop;

      Inv_25519 (T1, C);
      M (T2, A2, T1);
      Pack_25519 (Q, T2);

   end Crypto_Scalarmult;

   --  POK
   procedure Crypto_Scalarmult_Base (Q :    out Bytes_32;
                                     N : in     Bytes_32)
   is
   begin
      Crypto_Scalarmult (Q, N, Nine);
   end Crypto_Scalarmult_Base;

   --------------------------------------------------------
   --  Public key signatures
   --------------------------------------------------------

   --  POK
   procedure Crypto_Sign_Keypair (PK : out Bytes_32;
                                  SK : out Bytes_64)
   is
      D : Bytes_64;
      P : GF_Vector_4;
   begin
      SK := (others => 0);
      SK (0 .. 31) := Random_Bytes_32;

      Hashing.Hash (D, SK (0 .. 31));
      D (0)  := D (0) and 248;
      D (31) := D (31) and 127;
      D (31) := D (31) or 64;

      Scalarbase (P, D (0 .. 31));
      Pack (PK, P);

      SK (32 .. 63) := PK;
   end Crypto_Sign_Keypair;

   procedure Crypto_Sign (SM : out Byte_Seq;
                          M  : in Byte_Seq;
                          SK : in Bytes_64)
   is
      D, H, R : Bytes_64;
      X       : I64_Seq_64;
      P       : GF_Vector_4;
   begin
      Hashing.Hash (D, SK (0 .. 31));
      D (0) := D (0) and 248;
      D (31) := D (31) and 127;
      D (31) := D (31) or 64;

      SM := (others => 0);
      SM (64 .. SM'Last) := M;
      SM (32 .. 63) := D (32 .. 63);

      Hashing.Hash (R, SM (32 .. SM'Last));

      Reduce (R);

      Scalarbase (P, R (0 .. 31));
      Pack (SM (0 .. 31), P);

      SM (32 .. 63) := SK (32 .. 63);
      Hashing.Hash (H, SM);
      Reduce (H);

      X := (others => 0);
      for I in Index_32 loop
         X (I) := I64 (R (I));
      end loop;

      for I in Index_32 loop
         for J in Index_32 loop
            X (I + J) := X (I + J) +
              I64 (U64 (H (I)) * U64 (D (J))); --  POV on +
         end loop;
      end loop;

      ModL (Bytes_64 (SM (32 .. 95)), X); --  PRange? Need pre on range of SM?
      pragma Unreferenced (X);
   end Crypto_Sign;

   --  POK
   procedure Crypto_Sign_Open (M      :    out Byte_Seq;
                               Status :    out Boolean;
                               MLen   :    out I32;
                               SM     : in     Byte_Seq;
                               PK     : in     Bytes_32)
   is
      T : Bytes_32;
      H : Bytes_64;
      P, Q : GF_Vector_4;
      LN   : I32;
   begin
      MLen := -1;
      if SM'Length < 64 then
         M := (others => 0);
         Status := False;
         return;
      end if;

      Unpackneg (Q, Status, PK);
      if not Status then
         M := (others => 0);
         return;
      end if;

      M := SM; -- precondition ensures lengths match
      M (32 .. 63) := PK;

      Hashing.Hash (H, M);
      Reduce (H);

      pragma Warnings (Off, "unused assignment to ""Q""");
      Scalarmult (P, Q, H (0 .. 31));

      Scalarbase (Q, SM (32 .. 63));
      Add (P, Q);
      Pack (T, P);

      LN := I32 (I64 (SM'Length) - 64);

      if not Equal (SM (0 .. 31), T) then
         M := (others => 0);
         Status := False;
         return;
      end if;

      M (0 .. LN - 1) := SM (64 .. LN + 63);
      MLen := LN;
      Status := True;
      return;
   end Crypto_Sign_Open;


   --------------------------------------------------------
   --  One-time authentication
   --------------------------------------------------------

   procedure Crypto_Onetimeauth (Output :    out Bytes_16;
                                 M      : in     Byte_Seq;
                                 K      : in     Bytes_32)
   is
      MinusP : constant Poly_1305_F :=
        (5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 252);

      S, U : U32;
      X, R, H, C, G : Poly_1305_F;
      J, N : I32;
      M_Offset : I32;

      --  RCC Replace formals with globals?
      procedure Add_1305 (H : in out Poly_1305_F;
                          C : in     Poly_1305_F)
        with Global => null;

      --  POK
      procedure Add_1305 (H : in out Poly_1305_F;
                          C : in     Poly_1305_F)
      is
         U : U32 := 0;
      begin
         for J in Index_17 loop
            U := U + H (J) + C (J);
            H (J) := U and 255;
            U := Shift_Right (U, 8);
         end loop;
      end Add_1305;

   begin
      H := (others => 0);
      X := (others => 0);
      R := (others => 0);

      for I in Index_16 loop
         R (I) := U32 (K (I));
      end loop;

      R (3) := R (3) and 15;
      R (4) := R (4) and 252;
      R (7) := R (7) and 15;
      R (8) := R (8) and 252;
      R (11) := R (11) and 15;
      R (12) := R (12) and 252;
      R (15) := R (15) and 15;

      N := M'Length; --  PRange?
      M_Offset := 0;

      while (N > 0) loop

         C := (others => 0);

         J := 0;
         while  ((J < 16) and (J < N)) loop
            C (J) := U32 (M (M_Offset + J)); --  PIndex * 2, POV on +
            J := J + 1;
         end loop;

         C (J) := 1;
         M_Offset := M_Offset + J;
         N := N - J;
         Add_1305 (H, C);

         for I in Index_17 loop
            X (I) := 0;
            for P in Index_17 loop
               X (I) := X (I) + H (P) *
                        (if P <= I then R (I - P) else 320 * R (I + 17 - P));
            end loop;
         end loop;

         H := X;
         U := 0;

         for P in Index_16 loop
            U := U + H (P);
            H (P) := U and 255;
            U := Shift_Right (U, 8);
         end loop;

         U := U + H (16);
         H (16) := U and 3;
         U := 5 * Shift_Right (U, 2);

         for P in Index_16 loop
            U := U + H (P);
            H (P) := U and 255;
            U := Shift_Right (U, 8);
         end loop;

         U := U + H (16);
         H (16) := U;
      end loop;

      G := H;

      Add_1305 (H, MinusP);

      S := -Shift_Right (H (16), 7);

      for P in Index_17 loop
         H (P) := H (P) xor (S and (G (P) xor H (P)));
      end loop;

      C := (U32 (K (16)), U32 (K (17)), U32 (K (18)), U32 (K (19)),
            U32 (K (20)), U32 (K (21)), U32 (K (22)), U32 (K (23)),
            U32 (K (24)), U32 (K (25)), U32 (K (26)), U32 (K (27)),
            U32 (K (28)), U32 (K (29)), U32 (K (30)), U32 (K (31)), 0);

      Add_1305 (H, C);

      for P in Index_16 loop
         Output (P) := Byte (H (P) mod 256);
      end loop;
   end Crypto_Onetimeauth;


   --  POK
   function Crypto_Onetimeauth_Verify (H : in Bytes_16;
                                       M : in Byte_Seq;
                                       K : in Bytes_32) return Boolean
   is
      X : Bytes_16;
   begin
      Crypto_Onetimeauth (X, M, K);
      return Equal (H, X);
   end Crypto_Onetimeauth_Verify;


   --------------------------------------------------------
   --  Secret Key Authenticated Encryption - "SecretBox" --
   --------------------------------------------------------

   procedure Crypto_Secretbox (C      :    out Byte_Seq;
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
         Crypto_Onetimeauth (R,
                             --  Slice and slide to make the index value
                             --  meet the precondition
                             M_Array (C (32 .. C'Last)),
                             K2);
      end;

      C (16 .. 31) := R;
      C (0 .. 15) := Zero_Bytes_16;
      Status := True;
   end Crypto_Secretbox;

   --  POK
   procedure Crypto_Secretbox_Open
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
         if not Crypto_Onetimeauth_Verify
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
   end Crypto_Secretbox_Open;


   --------------------------------------------------------
   --  Public Key Authenticated Encryption - "Crypto Box" --
   --------------------------------------------------------

   --  POK
   procedure Crypto_Box_BeforeNM (K    :    out Bytes_32;
                                  Y, X : in     Bytes_32)
   is
      S : Bytes_32;
   begin
      Crypto_Scalarmult (S, X, Y);
      Core.HSalsa20 (K, Zero, S, Sigma);
   end Crypto_Box_BeforeNM;

   --  POK
   procedure Crypto_Box_AfterNM (C      :    out Byte_Seq;
                                 Status :    out Boolean;
                                 M      : in     Byte_Seq;
                                 N      : in     Bytes_24;
                                 K      : in     Bytes_32)
   is
   begin
      Crypto_Secretbox (C, Status, M, N, K);
   end Crypto_Box_AfterNM;

   --  POK
   procedure Crypto_Box_Open_AfterNM
     (M      :    out Byte_Seq; --  Output plaintext
      Status :    out Boolean;
      C      : in     Byte_Seq; --  Input ciphertext
      N      : in     Bytes_24; --  Nonce
      K      : in     Bytes_32) --  Key)
   is
   begin
      Crypto_Secretbox_Open (M, Status, C, N, K);
   end Crypto_Box_Open_AfterNM;

   --  POK
   procedure Crypto_Box (C      :    out Byte_Seq;
                         Status :    out Boolean;
                         M      : in     Byte_Seq;
                         N      : in     Bytes_24;
                         Y, X   : in     Bytes_32)
   is
      K : Bytes_32;
   begin
      Crypto_Box_BeforeNM (K, Y, X);
      Crypto_Box_AfterNM (C, Status, M, N, K);
   end Crypto_Box;

   --  POK
   procedure Crypto_Box_Open (M      :    out Byte_Seq;
                              Status :    out Boolean;
                              C      : in     Byte_Seq;
                              N      : in     Bytes_24;
                              Y, X   : in     Bytes_32)
   is
      K : Bytes_32;
   begin
      Crypto_Box_BeforeNM (K, Y, X);
      Crypto_Box_Open_AfterNM (M, Status, C, N, K);
   end Crypto_Box_Open;

   --  POK
   procedure Crypto_Box_Keypair (Y, X : out Bytes_32)
   is
   begin
      X := Random_Bytes_32;
      Crypto_Scalarmult_Base (Y, X);
   end Crypto_Box_Keypair;


   --------------------------------------------------------
   --  Hashing
   --------------------------------------------------------




   --  POK
   procedure Random_Bytes (R : out Byte_Seq)
   is
   begin
      for I in R'Range loop
         R (I) := Random.Random_Byte;
      end loop;
   end Random_Bytes;

end SPARKNaCl;

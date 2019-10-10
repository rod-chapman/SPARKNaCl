with Ada.Unchecked_Conversion;

--  with SPARKNaCl.Debug; use SPARKNaCl.Debug;

package body SPARKNaCl
  with SPARK_Mode => On
is
   --===============
   --  Local types
   --===============

   subtype Bit  is Byte range 0 .. 1;
   subtype Index_4  is I32 range 0 .. 3;
   subtype Index_15 is I32 range 0 .. 14;
   subtype Index_17 is I32 range 0 .. 16;
   subtype Index_20 is I32 range 0 .. 19;
   subtype Index_31 is I32 range 0 .. 30;

   subtype Bytes_4  is Byte_Seq (Index_4);

   subtype U32_Seq_4   is U32_Seq (Index_4);
   subtype U32_Seq_16  is U32_Seq (Index_16);
   subtype Poly_1305_F is U32_Seq (Index_17);

   subtype I64_Seq_32 is I64_Seq (Index_32);

   subtype U64_Seq_16 is U64_Seq (Index_16);
   subtype U64_Seq_8  is U64_Seq (Index_8);

   type GF_Vector_4 is array (Index_4) of GF;

   --  Local types for expressing a "Normalized" GF with
   --  all limbs in the range 0 .. 65535
   --
   --   subtype GF_Limb is I64 range 0 .. 65535;
   --   type GF_Normalized is new GF
   --     with Dynamic_Predicate => (for all I in Index_16 =>
   --                                  GF_Normalized (I) in GF_Limb);

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

   function To_U64 is new Ada.Unchecked_Conversion (I64, U64);
   function To_I64 is new Ada.Unchecked_Conversion (U64, I64);

   function Random_Bytes_32 return Bytes_32
     with Global => SPARKNaCl_Random.Entropy,
          Volatile_Function;

   --  returns equivalent of X >> 16 in C, doing an arithmetic
   --  shift right when X is negative
   function SShift_16 (X : in I64) return I64;

   --  returns equivalent of X >> 8 in C, doing an arithmetic
   --  shift right when X is negative
   function SShift_8 (X : in I64) return I64;

   --  returns equivalent of X >> 4 in C, doing an arithmetic
   --  shift right when X is negative
   function SShift_4 (X : in I64) return I64;

   --  Assignment
   procedure Set_25519 (R :    out GF;
                        A : in     GF)
     with Global => null;

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

   function Neq_25519 (A, B : in GF) return Verify_Result
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

   --  Rotate Left 32
   function RL32 (X : in U32;
                  C : in Natural) return U32
     with Global => null;

   --  Rotate right 64
   function RR64 (X : in U64;
                  C : in Natural) return U64
     with Global => null;

   function LD32 (X : in Bytes_4) return U32
     with Global => null;

   procedure ST32 (X :    out Bytes_4;
                   U : in     U32)
     with Global => null;

   function DL64 (X : in Bytes_8) return U64
     with Global => null;

   procedure TS64 (X :    out Bytes_8;
                   U : in     U64)
     with Global => null;

   function Ch (X, Y, Z : in U64) return U64
     with Global => null;

   function Maj (X, Y, Z : in U64) return U64
     with Global => null;

   --  Sigma0 with an upper-case S!
   function UC_Sigma0 (X : in U64) return U64
     with Global => null;

   --  Sigma1 with an upper-case S!
   function UC_Sigma1 (X : in U64) return U64
     with Global => null;

   --  sigma0 with a lower-case s!
   function LC_Sigma0 (X : in U64) return U64
     with Global => null;

   --  sigma1 with a lower-case s!
   function LC_Sigma1 (X : in U64) return U64
     with Global => null;

   procedure Add (P : in out GF_Vector_4;
                  Q : in     GF_Vector_4)
     with Global => null;


   procedure CSwap (P, Q : in out GF_Vector_4;
                    B    : in     Bit)
     with Global => null;

   procedure Add_1305 (H : in out Poly_1305_F;
                       C : in     Poly_1305_F)
     with Global => null;

   procedure Pow_2523 (O :    out GF;
                       I : in     GF)
     with Global => null;

   procedure Unpackneg (R  :    out GF_Vector_4;
                        OK :    out Verify_Result;
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

   procedure Crypto_Stream_Salsa20_Xor_Local
     (C     :    out Byte_Seq;
      M     : in     Byte_Seq;
      Xor_M : in     Boolean; --  If True then xor M against Stream
                              --  If False then return Stream unmodified
      N     : in     Bytes_8;
      K     : in     Bytes_32)
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
         Result (I) := SPARKNaCl_Random.Random_Byte;
      end loop;
      return Result;
   end Random_Bytes_32;

   --  POK, 1 FA
   procedure Random_Bytes (R : out Byte_Seq)
   is
   begin
      for I in R'Range loop
         R (I) := SPARKNaCl_Random.Random_Byte;
      end loop;
   end Random_Bytes;

   --  POK
   function SShift_16 (X : in I64) return I64
   is
   begin
      return To_I64 (Shift_Right_Arithmetic (To_U64 (X), 16));
   end SShift_16;

   --  POK
   function SShift_8 (X : in I64) return I64
   is
   begin
      return To_I64 (Shift_Right_Arithmetic (To_U64 (X), 8));
   end SShift_8;

   --  POK
   function SShift_4 (X : in I64) return I64
   is
   begin
      return To_I64 (Shift_Right_Arithmetic (To_U64 (X), 4));
   end SShift_4;

   --  POK
   procedure Set_25519 (R :    out GF;
                        A : in     GF)
   is
   begin
      R := A;
   end Set_25519;

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
      J          : Index_16;
      C, I_Is_15 : I64;
   begin
      for I in Index_16 loop
         --    o[i]+=(1LL<<16);
         O (I) := O (I) + 2#1_0000_0000_0000_0000#; --  POV

         --  RCC this is implementaion-defined in C for signed integers.
         --  a bug???
         --    c=o[i]>>16;
         C := SShift_16 (O (I));

         --    o[(i+1)*(i<15)]+=c-1+37*(c-1)*(i==15);
         --  case I is
         --     when 0 .. 14 =>
         --        O (I + 1) := O (I + 1) + C - 1;
         --     when 15 =>
         --        O (0) := O (0) + C - 1 + 37 * (C - 1);
         --  end case;

         I_Is_15 := Boolean'Pos (I = 15); -- 0 for False, 1 for True
         J := (I + 1) mod 16;
         O (J) := O (J) + C - 1 + (37 * (C - 1) * I_Is_15); --  POV * 5

         --    o[i]-=c<<16;
         --  RCC << undefined for C negative???
         O (I) := O (I) - (C * 65536); --  POV * 2
      end loop;
   end Car_25519;



   procedure Pack_25519 (O :    out Bytes_32;
                         N : in    GF)
   is
      --  int i,j,b;
      B : Bit;
      --  gf m,t;
      M, T : GF;
   begin
      M := (others => 0);
      --  FOR(i,16) t[i]=n[i];
      T := N;

      --  car25519(t);
      --  car25519(t);
      --  car25519(t);
      Car_25519 (T);
      Car_25519 (T);
      Car_25519 (T);

      --  FOR(j,2) {
      for J in I32 range 0 .. 1 loop
         --  m[0]=t[0]-0xffed;
         M (0) := T (0) - 16#FFED#; --  POV
         --  for(i=1;i<15;i++) {
         for I in I32 range 1 .. 14 loop

            --  m[i]=t[i]-0xffff-((m[i-1]>>16)&1);
            M (I) := T (I) -
                     16#FFFF# -
                     (SShift_16 (M (I - 1)) mod 2); --  POV * 2

            --  m[i-1]&=0xffff;
            M (I - 1) := M (I - 1) mod 65536;
         end loop;
         --  m[15]=t[15]-0x7fff-((m[14]>>16)&1);
         M (15) := T (15) - 16#7FFF# - (SShift_16 (M (14)) mod 2); --  POV * 2

         --  b=(m[15]>>16)&1;
         B := Bit (SShift_16 (M (15)) mod 2);

         --  m[14]&=0xffff;
         M (14) := M (14) mod 65536;
         --  sel25519(t,m,1-b);
         Sel_25519 (T, M, 1 - B);
      end loop;

      O := (others => 0);
      --  FOR(i,16) {
      for I in Index_16 loop
         pragma Assert (T (I) >= 0); --  P?
         pragma Assert (T (I) <= 65535); --  P?

         --  o[2*i]=t[i]&0xff;
         O (2 * I) := Byte (T (I) mod 256);
         --  o[2*i+1]=t[i]>>8;
         O (2 * I + 1) := Byte ((T (I) / 256) mod 256);
      end loop;
   end Pack_25519;


   --  POK
   procedure Unpack_25519 (O :    out GF;
                           N : in     Bytes_32)
   is

   begin
      --  FOR(i,16) o[i]=n[2*i]+((i64)n[2*i+1]<<8);
      for I in Index_16 loop
         O (I) := I64 (N (2 * I)) + (I64 (N (2 * I + 1)) * 256);
      end loop;
      --  o[15]&=0x7fff;
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
      --  i64 i,j,t[31];
      subtype TA is I64_Seq (Index_31);
      T : TA;
   begin
      --  FOR(i,31) t[i]=0;
      T := (others => 0);

      --  FOR(i,16) FOR(j,16) t[i+j]+=a[i]*b[j];
      for I in Index_16 loop
         for J in Index_16 loop
            T (I + J) := T (I + J) + (A (I) * B (J)); --  POV * 2
         end loop;
      end loop;

      --  Assuming both A and B are normalized on entry (so all
      --  limbs in 0 .. 65535), then
      --  here T(I) >= 0 and T(I) <= N*(65535**2), where N ranges
      --  from 1 (for I = 0 and I = 30) up to 16 (for I = 15)

      --  FOR(i,15) t[i]+=38*t[i+16];
      for I in Index_15 loop
         T (I) := T (I) + 38 * T (I + 16); --  POV * 2
      end loop;

      --  FOR(i,16) o[i]=t[i];
      O := T (0 .. 15);

      --  car25519(o);
      --  car25519(o);
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
   function RL32 (X : in U32;
                 C : in Natural) return U32
   is
   begin
      return Rotate_Left (X, C);
   end RL32;

   --  POK
   function RR64 (X : in U64;
                  C : in Natural) return U64
   is
   begin
      return Rotate_Right (X, C);
   end RR64;

   --  POK
   function LD32 (X : in Bytes_4) return U32
   is
      U : U32;
   begin
      --  u32 u = x[3];
      U := U32 (X (3));

      --  u = (u<<8)|x[2];
      U := Shift_Left (U, 8) or U32 (X (2));

      --  u = (u<<8)|x[1];
      U := Shift_Left (U, 8) or U32 (X (1));

      --  return (u<<8)|x[0];
      return Shift_Left (U, 8) or U32 (X (0));
   end LD32;

   --  POK
   procedure ST32 (X :    out Bytes_4;
                   U : in     U32)
   is
      T : U32 := U;
   begin
      --  FOR(i,4) { x[i] = u; u >>= 8; }
      for I in X'Range loop
         X (I) := Byte (T mod 256);
         T := Shift_Right (T, 8);
      end loop;
   end ST32;

   --  POK
   function DL64 (X : in Bytes_8) return U64
   is
      --  u64 i,u=0;
      U : U64 := 0;
   begin
      --  FOR(i,8) u=(u<<8)|x[i];
      for I in X'Range loop
         U := Shift_Left (U, 8) or U64 (X (I));
      end loop;
      --  return u;
      return U;
   end DL64;

   --  POK
   procedure TS64 (X :    out Bytes_8;
                   U : in     U64)

   is
      T : U64 := U;
   begin
      --  for (i = 7;i >= 0;--i) { x[i] = u; u >>= 8; }
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
      --  FOR(a,16) c[a]=i[a];
      C := I;

      --  for(a=253;a>=0;a--) {
      --    S(c,c);
      --    if(a!=2&&a!=4) M(c,c,i);
      --  }
      for A in reverse 0 .. 253 loop
         --  Need C2 here to avoid aliasing C with C via pass by reference
         S (C2, C);
         if (A /= 2 and A /= 4) then
            M (C, C2, I);
         else
            C := C2;
         end if;
      end loop;

      --  FOR(a,16) o[a]=c[a];
      O := C;
   end Inv_25519;

   --  POK
   function Neq_25519 (A, B : in GF) return Verify_Result
   is
      C, D : Bytes_32;
   begin
      Pack_25519 (C, A);
      Pack_25519 (D, B);
      return Crypto_Verify_32 (C, D);
   end Neq_25519;

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
   function Ch (X, Y, Z : in U64) return U64
   is
   begin
      return (X and Y) xor ((not X) and Z);
   end Ch;

   --  POK
   function Maj (X, Y, Z : in U64) return U64
   is
   begin
      return (X and Y) xor (X and Z) xor (Y and Z);
   end Maj;

   --  POK
   function UC_Sigma0 (X : in U64) return U64
   is
   begin
      return RR64 (X, 28) xor RR64 (X, 34) xor RR64 (X, 39);
   end UC_Sigma0;

   --  POK
   function UC_Sigma1 (X : in U64) return U64
   is
   begin
      return RR64 (X, 14) xor RR64 (X, 18) xor RR64 (X, 41);
   end UC_Sigma1;

   --  POK
   function LC_Sigma0 (X : in U64) return U64
   is
   begin
      return RR64 (X, 1) xor RR64 (X, 8) xor Shift_Right (X, 7);
   end LC_Sigma0;

   --  POK
   function LC_Sigma1 (X : in U64) return U64
   is
   begin
      return RR64 (X, 19) xor RR64 (X, 61) xor Shift_Right (X, 6);
   end LC_Sigma1;



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
   procedure CSwap (P, Q : in out GF_Vector_4;
                    B    : in     Bit)
   is
   begin
      for I in Index_4 loop
         Sel_25519 (P (I), Q (I), B);
      end loop;
   end CSwap;

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

   --  POK
   procedure Unpackneg (R  :    out GF_Vector_4;
                        OK :    out Verify_Result;
                        P  : in     Bytes_32)
   is
      --  gf t, chk, num, den, den2, den4, den6;
      T1, T2, T3, T4, T5, T6, T7, Chk, Chk1, Num,
      R_1_Squared, Den0, Den1, Den2, Den4, Den6 : GF;
   begin
      R := (others => GF_0);

      Set_25519 (R (2), GF_1);
      Unpack_25519 (R (1), P);
      S (R_1_Squared, R (1));
      M (Den0, R_1_Squared, GF_D);
      Z (Num, R_1_Squared, R (2));
      A (Den1, R (2), Den0); --  OK

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
      if (Neq_25519 (Chk1, Num) = -1) then
         M (T7, R (0), GF_I);
         R (0) := T7;
      end if;

      S (Chk, R (0));
      M (Chk1, Chk, Den1);

      if (Neq_25519 (Chk1, Num) = -1) then
         OK := -1;
         return;
      end if;

      if Par_25519 (R (0)) = (P (31) / 128) then
         Z (T7, GF_0, R (0));
         R (0) := T7;
      end if;

      M (R (3), R (0), R (1));
      OK := 0;

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
            Carry := SShift_8 (X (J) + 128); --  POV
            X (J) := X (J) - (Carry * 256);
         end loop;
         X (I - 12) := X (I - 12) + Carry; --  POV
         X (I) := 0;
      end loop;
      Carry := 0;

      for J in Index_32 loop
         X (J) := X (J) + (Carry - SShift_4 (X (31)) * L (J)); -- POV * 3
         Carry := SShift_8 (X (J));
         X (J) := X (J) mod 256;
      end loop;

      for J in Index_32 loop
         X (J) := X (J) - Carry * L (J); --  POV
      end loop;

      --  R is 64 bytes, this this only sets
      --  the first 32...
      for I in Index_32 loop
         X (I + 1) := X (I + 1) + SShift_8 (X (I)); --  POV
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
      --  Ineffective assignment to X here
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
   begin
      P := (0 => GF_0,
            1 => GF_1,
            2 => GF_1,
            3 => GF_0);

      for I in reverse U32 range 0 .. 255 loop
         --  u8 b = (s[i/8]>>(i&7))&1;
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

      --  RCC - Why recompute X * Y here each time - surely it's constant?
      M (Q (3), GF_X, GF_Y);

      Scalarmult (P, Q, S);

      pragma Unreferenced (Q);
   end Scalarbase;

   --===============================
   --  Exported subprogram bodies
   --===============================

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
         --  r=(z[i>>3]>>(i&7))&1;
         CB := Z2 (I32 (Shift_Right (I, 3)));
         Shift := Natural (I and 7);
         R := Bit (Shift_Right (CB, Shift) and 1);

         --  sel25519(a,b,r);
         --  sel25519(c,d,r);
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

      Crypto_Hash (D, SK (0 .. 31));
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
      Crypto_Hash (D, SK (0 .. 31));
      D (0) := D (0) and 248;
      D (31) := D (31) and 127;
      D (31) := D (31) or 64;

      SM := (others => 0);
      SM (64 .. SM'Last) := M;
      SM (32 .. 63) := D (32 .. 63);

      Crypto_Hash (R, SM (32 .. SM'Last));

      Reduce (R);

      Scalarbase (P, R (0 .. 31));
      Pack (SM (0 .. 31), P);

      SM (32 .. 63) := SK (32 .. 63);
      Crypto_Hash (H, SM);
      Reduce (H);

      X := (others => 0);
      for I in Index_32 loop
         X (I) := I64 (R (I));
      end loop;

      for I in Index_32 loop
         for J in Index_32 loop
            X (I + J) := X (I + J) + I64 (U64 (H (I)) * U64 (D (J))); --  POV
         end loop;
      end loop;

      ModL (Bytes_64 (SM (32 .. 95)), X); --  PRange?
      pragma Unreferenced (X);
   end Crypto_Sign;

   --  POK
   procedure Crypto_Sign_Open (M      :    out Byte_Seq;
                               Status :    out Verify_Result;
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
         Status := -1;
         return;
      end if;

      Unpackneg (Q, Status, PK);
      if Status = -1 then
         M := (others => 0);
         return;
      end if;

      M := SM; -- precondition ensures lengths match
      M (32 .. 63) := PK;

      Crypto_Hash (H, M);
      Reduce (H);

      pragma Warnings (Off, "unused assignment to ""Q""");
      Scalarmult (P, Q, H (0 .. 31));

      Scalarbase (Q, SM (32 .. 63));
      Add (P, Q);
      Pack (T, P);

      LN := I32 (I64 (SM'Length) - 64);

      if Crypto_Verify_32 (SM (0 .. 31), T) = -1 then
         M := (others => 0);
         Status := -1;
         return;
      end if;

      M (0 .. LN - 1) := SM (64 .. LN + 63);
      MLen := LN;
      Status := 0;
      return;
   end Crypto_Sign_Open;


   --------------------------------------------------------
   --  Salsa20 Core functions
   --------------------------------------------------------

   --  POK
   procedure Crypto_Core_Salsa20 (Output :    out Bytes_64;
                                  Input  : in     Bytes_16;
                                  K      : in     Bytes_32;
                                  C      : in     Bytes_16)
   is
      W, X, Y : U32_Seq_16;
      T       : U32_Seq_4;
   begin
      W := (others => 0);
      --  In C this is a loop, but we unroll and make single
      --  aggregate assignment to initialize the whole of X.
      X := (0  => LD32 (C (0 .. 3)),
            1  => LD32 (K (0 .. 3)),
            6  => LD32 (Input (0 .. 3)),
            11 => LD32 (K (16 .. 19)),

            5  => LD32 (C (4 .. 7)),
            2  => LD32 (K (4 .. 7)),
            7  => LD32 (Input (4 .. 7)),
            12 => LD32 (K (20 .. 23)),

            10 => LD32 (C (8 .. 11)),
            3  => LD32 (K (8 .. 11)),
            8  => LD32 (Input (8 .. 11)),
            13 => LD32 (K (24 .. 27)),

            15 => LD32 (C (12 .. 15)),
            4  => LD32 (K (12 .. 15)),
            9  => LD32 (Input (12 .. 15)),
            14 => LD32 (K (28 .. 31)));

      Y := X;

      for I in Index_20 loop
         for J in Index_4 loop
            T := (0 => X ((5 * J) mod 16),
                  1 => X ((5 * J + 4) mod 16),
                  2 => X ((5 * J + 8) mod 16),
                  3 => X ((5 * J + 12) mod 16));

            T (1) := T (1) xor RL32 (T (0) + T (3), 7);
            T (2) := T (2) xor RL32 (T (1) + T (0), 9);
            T (3) := T (3) xor RL32 (T (2) + T (1), 13);
            T (0) := T (0) xor RL32 (T (3) + T (2), 18);

            W (4 * J + ((J + 0) mod 4)) := T (0);
            W (4 * J + ((J + 1) mod 4)) := T (1);
            W (4 * J + ((J + 2) mod 4)) := T (2);
            W (4 * J + ((J + 3) mod 4)) := T (3);
         end loop;
         X := W;
      end loop;

      --  Salsa20 Output stage
      --  derives Output from X, Y
      Output := (others => 0);
      for I in Index_16 loop
         ST32 (Output (4 * I .. 4 * I + 3), X (I) + Y (I));
      end loop;
   end Crypto_Core_Salsa20;

   --  POK
   procedure Crypto_Core_HSalsa20 (Output :    out Bytes_32;
                                   Input  : in     Bytes_16;
                                   K      : in     Bytes_32;
                                   C      : in     Bytes_16)
   is
      W, X, Y : U32_Seq_16;
      T       : U32_Seq_4;
   begin
      W := (others => 0);
      --  In C this is a loop, but we unroll and make single
      --  aggregate assignment to initialize the whole of X.
      X := (0  => LD32 (C (0 .. 3)),
            1  => LD32 (K (0 .. 3)),
            6  => LD32 (Input (0 .. 3)),
            11 => LD32 (K (16 .. 19)),

            5  => LD32 (C (4 .. 7)),
            2  => LD32 (K (4 .. 7)),
            7  => LD32 (Input (4 .. 7)),
            12 => LD32 (K (20 .. 23)),

            10 => LD32 (C (8 .. 11)),
            3  => LD32 (K (8 .. 11)),
            8  => LD32 (Input (8 .. 11)),
            13 => LD32 (K (24 .. 27)),

            15 => LD32 (C (12 .. 15)),
            4  => LD32 (K (12 .. 15)),
            9  => LD32 (Input (12 .. 15)),
            14 => LD32 (K (28 .. 31)));

      Y := X;

      for I in Index_20 loop
         for J in Index_4 loop
            T := (0 => X ((5 * J) mod 16),
                  1 => X ((5 * J + 4) mod 16),
                  2 => X ((5 * J + 8) mod 16),
                  3 => X ((5 * J + 12) mod 16));

            T (1) := T (1) xor RL32 (T (0) + T (3), 7);
            T (2) := T (2) xor RL32 (T (1) + T (0), 9);
            T (3) := T (3) xor RL32 (T (2) + T (1), 13);
            T (0) := T (0) xor RL32 (T (3) + T (2), 18);

            W (4 * J + ((J + 0) mod 4)) := T (0);
            W (4 * J + ((J + 1) mod 4)) := T (1);
            W (4 * J + ((J + 2) mod 4)) := T (2);
            W (4 * J + ((J + 3) mod 4)) := T (3);
         end loop;
         X := W;
      end loop;

      --  HSalsa20 output stage
      --  derives Output from X, Y, C, Input
      for I in Index_16 loop
         X (I) := X (I) + Y (I);
      end loop;

      for I in Index_4 loop
         X (5 * I) := X (5 * I) - LD32 (C (4 * I .. 4 * I + 3));
         X (6 + I) := X (6 + I) - LD32 (Input (4 * I .. 4 * I + 3));
      end loop;

      Output := (others => 0);
      for I in Index_4 loop
         ST32 (Output (4 * I .. 4 * I + 3), X (5 * I));
         ST32 (Output (4 * I + 16 .. 4 * I + 19), X (6 + I));
      end loop;

   end Crypto_Core_HSalsa20;

   --------------------------------------------------------
   --  Secret key encryption (not authenticated)
   --------------------------------------------------------

   Sigma : constant Bytes_16 :=
     (0  => Character'Pos ('e'),
      1  => Character'Pos ('x'),
      2  => Character'Pos ('p'),
      3  => Character'Pos ('a'),
      4  => Character'Pos ('n'),
      5  => Character'Pos ('d'),
      6  => Character'Pos (' '),
      7  => Character'Pos ('3'),
      8  => Character'Pos ('2'),
      9  => Character'Pos ('-'),
      10 => Character'Pos ('b'),
      11 => Character'Pos ('y'),
      12 => Character'Pos ('t'),
      13 => Character'Pos ('e'),
      14 => Character'Pos (' '),
      15 => Character'Pos ('k'));


   --  ???
   procedure Crypto_Stream_Salsa20_Xor_Local
     (C     :    out Byte_Seq;
      M     : in     Byte_Seq;
      Xor_M : in     Boolean; --  If True then xor M against Stream
                              --  If False then return Stream unmodified
      N     : in     Bytes_8;
      K     : in     Bytes_32)
   is
      Z : Bytes_16;
      X : Bytes_64;
      U : U32;
      B : I32;
      C_Offset : I32;
      M_Offset : I32;
   begin
      B := C'Length; --  PRange?
      C := (others => 0);
      if B = 0 then
         return;
      end if;

      C_Offset := 0;
      M_Offset := 0;
      Z := (others => 0);
      Z (0 .. 7) := N;

      while (B >= 64) loop

         Crypto_Core_Salsa20 (X, Z, K, Sigma);

         for I in Index_64 loop
            C (C_Offset + I) :=
              (if Xor_M then M (M_Offset + I) else 0) xor X (I);
         end loop;

         U := 1;
         for I in I32 range 8 .. 15 loop
            U := U + U32 (Z (I));
            Z (I) := Byte (U mod 256);
            U := Shift_Right (U, 8);
         end loop;

         B := B - 64;
         C_Offset := C_Offset + 64;
         M_Offset := M_Offset + 64;

      end loop;

      if B > 0 then
         Crypto_Core_Salsa20 (X, Z, K, Sigma);

         for I in I32 range 0 .. (B - 1) loop
            C (C_Offset + I) :=
              (if Xor_M then M (M_Offset + I) else 0) xor X (I);
         end loop;
      end if;
   end Crypto_Stream_Salsa20_Xor_Local;


   --  ???
   procedure Crypto_Stream_Salsa20_Xor (C :    out Byte_Seq; --  Output stream
                                        M : in     Byte_Seq; --  Input message
                                        N : in     Bytes_8;  --  Nonce
                                        K : in     Bytes_32) --  Key
   is
   begin
      Crypto_Stream_Salsa20_Xor_Local (C, M, True, N, K);
   end Crypto_Stream_Salsa20_Xor;

   --  ???
   procedure Crypto_Stream_Xor (C :    out Byte_Seq; --  Output ciphertext
                                M : in     Byte_Seq; --  Input message
                                N : in     Bytes_24; --  Nonce
                                K : in     Bytes_32) --  Key
   is
      S : Bytes_32;
   begin
      Crypto_Core_HSalsa20 (S, N (0 .. 15), K, Sigma);
      Crypto_Stream_Salsa20_Xor_Local (C, M, True, N (16 .. 23), S);
   end Crypto_Stream_Xor;

   --  ???
   procedure Crypto_Stream_Salsa20 (C :    out Byte_Seq; --  Output stream
                                    N : in     Bytes_8;  --  Nonce
                                    K : in     Bytes_32) --  Key
   is
      Null_M : Byte_Seq (0 .. 0);
   begin
      Null_M := (others => 0);
      Crypto_Stream_Salsa20_Xor_Local (C, Null_M, False, N, K);
   end Crypto_Stream_Salsa20;

   --  POK
   procedure Crypto_Stream (C :    out Byte_Seq; --  Output stream
                            N : in     Bytes_24; --  Nonce
                            K : in     Bytes_32) --  Key
   is
      S : Bytes_32;
   begin
      Crypto_Core_HSalsa20 (S, N (0 .. 15), K, Sigma);
      Crypto_Stream_Salsa20 (C, N (16 .. 23), S);
   end Crypto_Stream;

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
            C (J) := U32 (M (M_Offset + J)); --  PIndex * 2, POV
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

      --  FOR(j,16) c[j] = k[j + 16];
      --  c[16] = 0;
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
                                       K : in Bytes_32) return Verify_Result
   is
      X : Bytes_16;
   begin
      Crypto_Onetimeauth (X, M, K);
      return Crypto_Verify_16 (H, X);
   end Crypto_Onetimeauth_Verify;


   --------------------------------------------------------
   --  Secret Key Authenticated Encryption - "SecretBox" --
   --------------------------------------------------------

   procedure Crypto_Secretbox (C      :    out Byte_Seq;
                               Status :    out Verify_Result;
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
         Status := -1;
         C := (others => 0);
         return;
      end if;

      pragma Assert (D >= 32);

      Crypto_Stream_Xor (C, M, N, K);

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
      Status := 0;
   end Crypto_Secretbox;

   --  POK
   procedure Crypto_Secretbox_Open
     (M      :    out Byte_Seq; --  Output plaintext
      Status :    out Verify_Result;
      C      : in     Byte_Seq; --  Input ciphertext
      N      : in     Bytes_24; --  Nonce
      K      : in     Bytes_32) --  Key)
   is
      X : Bytes_32;
   begin
      Status := 0;
      if C'Length < 32 then
         Status := -1;
         M := (others => 0);
         return;
      end if;

      pragma Assert (C'Length >= 32);

      Crypto_Stream (X, N, K);

      --  if (crypto_onetimeauth_verify(c + 16,c + 32,d - 32,x) != 0)
      --     return -1;
      declare
         subtype M_Array is Byte_Seq (0 .. (C'Last - 32));
      begin
         if Crypto_Onetimeauth_Verify (H => C (16 .. 31),
                                       --  Slide and slide so that M'First = 0
                                       M => M_Array (C (32 .. C'Last)),
                                       K => X) /= 0
         then
            Status := -1;
            M := (others => 0);
            return;
         end if;
      end;

      Crypto_Stream_Xor (C => M, M => C, N => N, K => K);
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
      Crypto_Core_HSalsa20 (K, Zero, S, Sigma);
   end Crypto_Box_BeforeNM;

   --  POK
   procedure Crypto_Box_AfterNM (C      :    out Byte_Seq;
                                 Status :    out Verify_Result;
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
      Status :    out Verify_Result;
      C      : in     Byte_Seq; --  Input ciphertext
      N      : in     Bytes_24; --  Nonce
      K      : in     Bytes_32) --  Key)
   is
   begin
      Crypto_Secretbox_Open (M, Status, C, N, K);
   end Crypto_Box_Open_AfterNM;

   --  POK
   procedure Crypto_Box (C      :    out Byte_Seq;
                         Status :    out Verify_Result;
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
                              Status :    out Verify_Result;
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


   subtype Index_80 is I32 range 0 .. 79;
   type K_Table is array (Index_80) of U64;
   K : constant K_Table :=
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


   --  POK
   procedure Crypto_Hashblocks
     (X : in out Bytes_64; -- 512 bits
      M : in     Byte_Seq)
   is
      Z, B, A : U64_Seq_8;
      W       : U64_Seq_16;
      T       : U64;
      LN      : I64;
      CB      : I32;
   begin
      A := (0 => DL64 (Bytes_8 (X (0 .. 7))),
            1 => DL64 (Bytes_8 (X (8 .. 15))),
            2 => DL64 (Bytes_8 (X (16 .. 23))),
            3 => DL64 (Bytes_8 (X (24 .. 31))),
            4 => DL64 (Bytes_8 (X (32 .. 39))),
            5 => DL64 (Bytes_8 (X (40 .. 47))),
            6 => DL64 (Bytes_8 (X (48 .. 55))),
            7 => DL64 (Bytes_8 (X (56 .. 63))));
      Z := A;

      LN := I64 (M'Length);
      CB := M'First; -- Current block base offset

      while (LN >= 128) loop
         pragma Warnings (Off, "lower bound test*");
         pragma Loop_Invariant
           ((LN + I64 (CB) = I64 (M'Last) + 1) and --  PInvMaint?
              (LN in 128 .. M'Length) and
              (CB in M'First .. (M'Last - 127)));

         W := (0  => DL64 (Bytes_8 (M (CB + 0 .. CB + 7))),
               1  => DL64 (Bytes_8 (M (CB + 8 .. CB + 15))),
               2  => DL64 (Bytes_8 (M (CB + 16 .. CB + 23))),
               3  => DL64 (Bytes_8 (M (CB + 24 .. CB + 31))),
               4  => DL64 (Bytes_8 (M (CB + 32 .. CB + 39))),
               5  => DL64 (Bytes_8 (M (CB + 40 .. CB + 47))),
               6  => DL64 (Bytes_8 (M (CB + 48 .. CB + 55))),
               7  => DL64 (Bytes_8 (M (CB + 56 .. CB + 63))),
               8  => DL64 (Bytes_8 (M (CB + 64 .. CB + 71))),
               9  => DL64 (Bytes_8 (M (CB + 72 .. CB + 79))),
               10 => DL64 (Bytes_8 (M (CB + 80 .. CB + 87))),
               11 => DL64 (Bytes_8 (M (CB + 88 .. CB + 95))),
               12 => DL64 (Bytes_8 (M (CB + 96 .. CB + 103))),
               13 => DL64 (Bytes_8 (M (CB + 104 .. CB + 111))),
               14 => DL64 (Bytes_8 (M (CB + 112 .. CB + 119))),
               15 => DL64 (Bytes_8 (M (CB + 120 .. CB + 127))));

         for I in Index_80 loop

            pragma Loop_Invariant ((LN + I64 (CB) = I64 (M'Last) + 1) and
                                     (LN in 128 .. M'Length) and
                                     (CB in M'First .. (M'Last - 127)));
            B := A;

            T := A (7) + UC_Sigma1 (A (4)) + Ch (A (4), A (5), A (6)) +
                 K (I) + W (I mod 16);

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
                  W (J) := W (J) + W ((J + 9) mod 16) +
                    LC_Sigma0 (W ((J + 1) mod 16)) +
                    LC_Sigma1 (W ((J + 14) mod 16));
               end loop;
            end if;

         end loop;

         for I in Index_8 loop
            A (I) := A (I) + Z (I);
            Z (I) := A (I);
         end loop;

         exit when LN < 256;
         pragma Assert (LN >= 128);
         CB := CB + 128; --  POV and UB here on final iteration?
         LN := LN - 128;
      end loop;


      for I in Index_8 loop
         TS64 (X (8 * I .. (8 * I + 7)), Z (I));
      end loop;

   end Crypto_Hashblocks;


   IV : constant Bytes_64 :=
     (16#6a#, 16#09#, 16#e6#, 16#67#, 16#f3#, 16#bc#, 16#c9#, 16#08#,
      16#bb#, 16#67#, 16#ae#, 16#85#, 16#84#, 16#ca#, 16#a7#, 16#3b#,
      16#3c#, 16#6e#, 16#f3#, 16#72#, 16#fe#, 16#94#, 16#f8#, 16#2b#,
      16#a5#, 16#4f#, 16#f5#, 16#3a#, 16#5f#, 16#1d#, 16#36#, 16#f1#,
      16#51#, 16#0e#, 16#52#, 16#7f#, 16#ad#, 16#e6#, 16#82#, 16#d1#,
      16#9b#, 16#05#, 16#68#, 16#8c#, 16#2b#, 16#3e#, 16#6c#, 16#1f#,
      16#1f#, 16#83#, 16#d9#, 16#ab#, 16#fb#, 16#41#, 16#bd#, 16#6b#,
      16#5b#, 16#e0#, 16#cd#, 16#19#, 16#13#, 16#7e#, 16#21#, 16#79#);

   --  POK
   procedure Crypto_Hash (Output :    out Bytes_64;
                          M      : in     Byte_Seq)
   is
      subtype Final_Block_Length is I32 range 0 .. 127;
      H     : Bytes_64;
      X     : Bytes_256;
      B     : Final_Block_Length;
      Final_Block_First : I32;
      ML_MSB  : Byte;
      ML_LSBs : U64;
   begin
      H := IV;
      X := (others => 0);

      Crypto_Hashblocks (H, M);

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
         TS64 (X (120 .. 127), ML_LSBs);
         Crypto_Hashblocks (H, X (0 .. 127));
      else
         X (247) := ML_MSB;
         TS64 (X (248 .. 255), ML_LSBs);
         Crypto_Hashblocks (H, X);
      end if;

      Output := H;
   end Crypto_Hash;


   --------------------------------------------------------
   --  Constant time equality tests
   --------------------------------------------------------

   type Boolean_To_Verify_Result_Table is array (Boolean) of Verify_Result;
   Boolean_To_Verify_Result : constant Boolean_To_Verify_Result_Table :=
     (False => -1,
      True  => 0);

   --  POK
   function Crypto_Verify_16 (X, Y : in Bytes_16) return Verify_Result
   is
      D : Byte := 0;
   begin
      --  FOR(i,n) d |= x[i]^y[i];
      for I in X'Range loop
         D := D or (X (I) xor Y (I));
      end loop;
      --  D = 0         iff X and Y are equal
      --  D in 1 .. 255 iff X and Y are not equal

      --  return (1 & ((d - 1) >> 8)) - 1;
      return Boolean_To_Verify_Result (D = 0);

   end Crypto_Verify_16;

   --  POK
   function Crypto_Verify_32 (X, Y : in Bytes_32) return Verify_Result
   is
      D : Byte := 0;
   begin
      --  FOR(i,n) d |= x[i]^y[i];
      for I in X'Range loop
         D := D or (X (I) xor Y (I));
      end loop;
      --  D = 0         iff X and Y are equal
      --  D in 1 .. 255 iff X and Y are not equal

      --  return (1 & ((d - 1) >> 8)) - 1;
      return Boolean_To_Verify_Result (D = 0);
   end Crypto_Verify_32;


end SPARKNaCl;

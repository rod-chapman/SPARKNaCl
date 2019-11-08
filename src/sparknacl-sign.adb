with SPARKNaCl.Hashing;

package body SPARKNaCl.Sign
  with SPARK_Mode => On
is

   --===================
   --  Local constants
   --===================

   GF_D  : constant GF := (16#78a3#, 16#1359#, 16#4dca#, 16#75eb#,
                           16#d8ab#, 16#4141#, 16#0a4d#, 16#0070#,
                           16#e898#, 16#7779#, 16#4079#, 16#8cc7#,
                           16#fe73#, 16#2b6f#, 16#6cee#, 16#5203#);

   GF_I  : constant GF := (16#a0b0#, 16#4a0e#, 16#1b27#, 16#c4ee#,
                           16#e478#, 16#ad2f#, 16#1806#, 16#2f43#,
                           16#d7a7#, 16#3dfb#, 16#0099#, 16#2b4d#,
                           16#df0b#, 16#4fc1#, 16#2480#, 16#2b83#);

   GF_X  : constant GF := (16#d51a#, 16#8f25#, 16#2d60#, 16#c956#,
                           16#a7b2#, 16#9525#, 16#c760#, 16#692c#,
                           16#dc5c#, 16#fdd6#, 16#e231#, 16#c0a4#,
                           16#53fe#, 16#cd6e#, 16#36d3#, 16#2169#);

   GF_Y  : constant GF := (16#6658#, 16#6666#, 16#6666#, 16#6666#,
                           16#6666#, 16#6666#, 16#6666#, 16#6666#,
                           16#6666#, 16#6666#, 16#6666#, 16#6666#,
                           16#6666#, 16#6666#, 16#6666#, 16#6666#);

   GF_D2 : constant GF := (16#f159#, 16#26b2#, 16#9b94#, 16#ebd6#,
                           16#b156#, 16#8283#, 16#149a#, 16#00e0#,
                           16#d130#, 16#eef3#, 16#80f2#, 16#198e#,
                           16#fce7#, 16#56df#, 16#d9dc#, 16#2406#);



   procedure Scalarmult (P :    out GF_Vector_4;
                         Q : in out GF_Vector_4;
                         S : in     Bytes_32)
     with Global => null;

   procedure Scalarbase (P :    out GF_Vector_4;
                         S : in     Bytes_32)
     with Global => null;

   procedure Add (P : in out GF_Vector_4;
                  Q : in     GF_Vector_4)
     with Global => null;


   procedure Pack (R :    out Bytes_32;
                   P : in     GF_Vector_4)
     with Global => null;

   function Par_25519 (A : in GF) return Bit
     with Global => null;

   procedure ModL (R : in out Bytes_64; -- this is odd!
                   X : in out I64_Seq_64)
     with Global => null;

   procedure Reduce (R : in out Bytes_64)
     with Global => null;

   procedure Unpackneg (R  :    out GF_Vector_4;
                        OK :    out Boolean;
                        P  : in     Bytes_32)
     with Global => null;

   --==================================================

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
   function Par_25519 (A : in GF) return Bit
   is
      D : Bytes_32;
   begin
      Pack_25519 (D, A);
      return (D (0) mod 2);
   end Par_25519;


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



   --============================================

   --  POK
   procedure Keypair (PK : out Signing_PK;
                      SK : out Signing_SK)
   is
      D   : Bytes_64;
      P   : GF_Vector_4;
      LSK : Bytes_64;
      LPK : Bytes_32;
   begin
      LSK := (others => 0);
      LSK (0 .. 31) := Random_Bytes_32;

      Hashing.Hash (D, LSK (0 .. 31));
      D (0)  := D (0) and 248;
      D (31) := D (31) and 127;
      D (31) := D (31) or 64;

      Scalarbase (P, D (0 .. 31));
      Pack (LPK, P);

      LSK (32 .. 63) := LPK;

      PK := Signing_PK (LPK);
      SK := Signing_SK (LSK);
      --  RCC - Sanitize all local vars here?
   end Keypair;

   procedure Sign (SM :    out Byte_Seq;
                   M  : in     Byte_Seq;
                   SK : in     Signing_SK)
   is
      D, H, R : Bytes_64;
      X       : I64_Seq_64;
      P       : GF_Vector_4;
   begin
      Hashing.Hash (D, Bytes_32 (SK (0 .. 31)));
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

      SM (32 .. 63) := Bytes_32 (SK (32 .. 63));
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
   end Sign;

   --  POK
   procedure Open (M      :    out Byte_Seq;
                   Status :    out Boolean;
                   MLen   :    out I32;
                   SM     : in     Byte_Seq;
                   PK     : in     Signing_PK)
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

      Unpackneg (Q, Status, Bytes_32 (PK));
      if not Status then
         M := (others => 0);
         return;
      end if;

      M := SM; -- precondition ensures lengths match
      M (32 .. 63) := Bytes_32 (PK);

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
   end Open;




end SPARKNaCl.Sign;

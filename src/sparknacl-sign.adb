with SPARKNaCl.Utils;
with SPARKNaCl.Hashing;
--  with SPARKNaCl.Debug;
package body SPARKNaCl.Sign
  with SPARK_Mode => On
is
   --============================================
   --  Local constants and types
   --============================================

   GF_D  : constant Normal_GF := (16#78a3#, 16#1359#, 16#4dca#, 16#75eb#,
                                  16#d8ab#, 16#4141#, 16#0a4d#, 16#0070#,
                                  16#e898#, 16#7779#, 16#4079#, 16#8cc7#,
                                  16#fe73#, 16#2b6f#, 16#6cee#, 16#5203#);

   GF_I  : constant Normal_GF := (16#a0b0#, 16#4a0e#, 16#1b27#, 16#c4ee#,
                                  16#e478#, 16#ad2f#, 16#1806#, 16#2f43#,
                                  16#d7a7#, 16#3dfb#, 16#0099#, 16#2b4d#,
                                  16#df0b#, 16#4fc1#, 16#2480#, 16#2b83#);

   GF_X  : constant Normal_GF := (16#d51a#, 16#8f25#, 16#2d60#, 16#c956#,
                                  16#a7b2#, 16#9525#, 16#c760#, 16#692c#,
                                  16#dc5c#, 16#fdd6#, 16#e231#, 16#c0a4#,
                                  16#53fe#, 16#cd6e#, 16#36d3#, 16#2169#);

   GF_Y  : constant Normal_GF := (16#6658#, 16#6666#, 16#6666#, 16#6666#,
                                  16#6666#, 16#6666#, 16#6666#, 16#6666#,
                                  16#6666#, 16#6666#, 16#6666#, 16#6666#,
                                  16#6666#, 16#6666#, 16#6666#, 16#6666#);

   --  Original TweetNaCl code computes Q(3) by multiplying GF_X by GF_Y,
   --  but this is a constant (now called GF_XY), thus:
   GF_XY : constant Normal_GF := (16#DD90#, 16#A5B7#, 16#8AB3#, 16#6DDE#,
                                  16#52F5#, 16#7751#, 16#9F80#, 16#20F0#,
                                  16#E37D#, 16#64AB#, 16#4E8E#, 16#66EA#,
                                  16#7665#, 16#D78B#, 16#5F0F#, 16#E787#);

   GF_D2 : constant Normal_GF := (16#f159#, 16#26b2#, 16#9b94#, 16#ebd6#,
                                  16#b156#, 16#8283#, 16#149a#, 16#00e0#,
                                  16#d130#, 16#eef3#, 16#80f2#, 16#198e#,
                                  16#fce7#, 16#56df#, 16#d9dc#, 16#2406#);

   type GF_Vector_4 is array (Index_4) of Normal_GF;

   --  We make this constant library-level to ensure that its declaration
   --  is only elaborated exactly once.
   Scalarbase_Q : constant GF_Vector_4 := (0 => GF_X,
                                           1 => GF_Y,
                                           2 => GF_1,
                                           3 => GF_XY);

   --============================================
   --  Local subprogram declarations
   --============================================

   procedure Sanitize_GF_Vector_4 (R : out GF_Vector_4)
     with Global => null;

   --  Replaces function "add" in the TweetNaCl sources
   function "+" (Left  : in GF_Vector_4;
                 Right : in GF_Vector_4) return GF_Vector_4
     with Global => null;

   function Scalarmult (Q : in GF_Vector_4;
                        S : in Bytes_32) return GF_Vector_4
     with Global => null;

   function Scalarbase (S : in Bytes_32) return GF_Vector_4
     with Global => null;

   function Pack (P : in GF_Vector_4) return Bytes_32
     with Global => null;

   subtype Bit is Byte range 0 .. 1;

   function Par_25519 (A : in Normal_GF) return Bit
     with Global => null;

   --  SPARKNaCl introduces this function to combine Hash and Reduce into
   --  a single call. Former procedure Reduce removed.
   function Hash_Reduce (M : in Byte_Seq) return Bytes_32
     with Global => null;

   procedure Unpackneg (R  :    out GF_Vector_4;
                        OK :    out Boolean;
                        P  : in     Bytes_32)
     with Global => null;


   --============================================
   --  Local subprogram bodies
   --============================================

   procedure Sanitize_GF_Vector_4 (R : out GF_Vector_4)
   is
   begin
      for I in R'Range loop
         Sanitize_GF (R (I));
      end loop;
   end Sanitize_GF_Vector_4;

   function "+" (Left  : in GF_Vector_4;
                 Right : in GF_Vector_4) return GF_Vector_4
   is
      A, B, C, D, E, F, G, H, T : GF;
   begin
      A := (Left (1) - Left (0)) * (Right (1) - Right (0));

      B := (Left (0) + Left (1)) * (Right (0) + Right (1));

      C := (Left (3) * Right (3)) * GF_D2;

      T := Left (2) * Right (2);
      D := T + T;

      E  := B - A;
      F  := D - C;
      G  := D + C;
      H  := B + A;

      return GF_Vector_4'(0 => E * F,
                          1 => H * G,
                          2 => G * F,
                          3 => E * H);
   end "+";

   function Scalarmult (Q : in GF_Vector_4;
                        S : in Bytes_32) return GF_Vector_4
   is
      CB     : Byte;
      Swap   : Boolean;
      LP, LQ : GF_Vector_4;

      procedure CSwap (P, Q : in out GF_Vector_4;
                       Swap : in     Boolean)
        with Global => null;

      procedure CSwap (P, Q : in out GF_Vector_4;
                       Swap : in     Boolean)
      is
      begin
         for I in Index_4 loop
            Utils.CSwap (P (I), Q (I), Swap);
         end loop;
      end CSwap;

   begin
      LP := (0 => GF_0,
             1 => GF_1,
             2 => GF_1,
             3 => GF_0);
      LQ := Q;

      for I in reverse U32 range 0 .. 255 loop
         CB   := S (I32 (Shift_Right (I, 3)));
         Swap := Boolean'Val (Shift_Right (CB, Natural (I and 7)) mod 2);

         CSwap (LP, LQ, Swap);

         --  Note user-defined "+" for GF_Vector_4 called here
         LQ := LQ + LP;
         LP := LP + LP;
         CSwap (LP, LQ, Swap);
      end loop;

      return LP;
   end Scalarmult;

   function Scalarbase (S : in Bytes_32) return GF_Vector_4
   is
   begin
      return Scalarmult (Scalarbase_Q, S);
   end Scalarbase;

   function Par_25519 (A : in Normal_GF) return Bit
   is
      D : Bytes_32;
   begin
      D := Utils.Pack_25519 (A);
      return (D (0) mod 2);
   end Par_25519;

   function Pack (P : in GF_Vector_4) return Bytes_32
   is
      TX, TY, ZI : Normal_GF;
      R : Bytes_32;
   begin
      ZI := Utils.Inv_25519 (P (2));
      TX := P (0) * ZI;
      TY := P (1) * ZI;
      R := Utils.Pack_25519 (TY);
      R (31) := R (31) xor (Par_25519 (TX) * 128);
      return R;
   end Pack;

   --  RFC 7748 says the "order" of Curve25519 is
   --  2^252 + 0x14def9dea2f79cd65812631a5cf5d3ed
   --
   --  In little-endian radix 2**8 format, this is 256 bits, thus:
   Max_L : constant := 16#f9#;
   L0    : constant := 16#ed#;
   subtype L_Limb is I64_Byte range 0 .. Max_L;
   type L_Table  is array (Index_32) of L_Limb;
   L : constant L_Table := (L0,     16#d3#, 16#f5#, 16#5c#,
                            16#1a#, 16#63#, 16#12#, 16#58#,
                            16#d6#, 16#9c#, 16#f7#, 16#a2#,
                            16#de#, 16#f9#, 16#de#, 16#14#,
                            16#00#, 16#00#, 16#00#, 16#00#,
                            16#00#, 16#00#, 16#00#, 16#00#,
                            16#00#, 16#00#, 16#00#, 16#00#,
                            16#00#, 16#00#, 16#00#, 16#10#);

   function ModL (X : in I64_Seq_64) return Bytes_32
   is

      Max_Carry : constant := 2**14;
      Min_Carry : constant := -2**25;
      subtype Carry_T is I64 range Min_Carry .. Max_Carry;

      Min_Adjustment : constant := (Min_Carry * 16 * Max_L);
      Max_Adjustment : constant := ((Max_X_Limb + Max_Carry) * 16 * Max_L);
      subtype Adjustment_T is I64
        range Min_Adjustment .. Max_Adjustment;

      subtype XL_Limb is I64
        range -((Max_X_Limb + Max_Carry + Max_Adjustment) * 16 * Max_L) ..
               ((Max_X_Limb + Max_Carry + Max_Adjustment) * 16 * Max_L);

      type XL_Table is array (Index_64) of XL_Limb;
      XL : XL_Table;

      --  "PRL" = "Partially Reduced Limb"
      subtype PRL is I64 range -129 .. 128;

      --  "FRL" = "Fully Reduced Limb"
      subtype FRL is PRL range -128 .. 127;

      R     : Bytes_32;

      --  The largest value of Carry is achieved when XL (63) = 0,
      --  so that
      --   Max_L63_Carry = ASR_8 (Max_X_Limb + Max_L63_Carry + 128)
      --  Knowing that all the terms are positive means we can expand
      --  ASR_8 and simplify.
      --  This is declared here it can be used to derive subtype
      --  XL51_T and used in the post-condition of Eliminate_Limb_63 below
      Max_L63_Carry : constant := (Max_X_Limb + 128) / 255;

      subtype XL51_T is I64 range 0 .. (Max_X_Limb + Max_L63_Carry);

      procedure Initialize_XL
        with Global => (Input  => X,
                        Output => XL),
             Pre  => (for all K in Index_64 => X (K) in 0 .. Max_X_Limb),
             Post => (for all K in Index_64 => XL (K) >= 0) and
                     (for all K in Index_64 => XL (K) <= Max_X_Limb) and
                     (for all K in Index_64 => XL (K) = XL_Limb (X (K)));

      procedure Eliminate_Limb_63
        with Global => (Proof_In => X,
                        In_Out   => XL),
             Pre  => (for all K in Index_64 =>
                        X (K) in 0 .. Max_X_Limb) and then
                     (for all K in Index_64 => XL (K) >= 0) and then
                     (for all K in Index_64 => XL (K) <= Max_X_Limb) and then
                     (for all K in Index_64 => XL (K) = XL_Limb (X (K))),
             Post => (for all K in Index_64 range 0 .. 30 =>
                       XL (K) = X (K)) and
                     (for all K in Index_64 range 31 .. 50 =>
                       XL (K) in FRL) and
                     (XL (51) in XL51_T) and
                     (for all K in Index_64 range 52 .. 62 =>
                       XL (K) = X (K)) and
                     (XL (63) = 0);

      procedure Eliminate_Limbs_62_To_32
        with Global => (Proof_In => X,
                        In_Out   => XL),
             Pre  => ((for all K in Index_64 range 0 .. 30 =>
                         XL (K) = X (K) and
                         XL (K) in 0 .. Max_X_Limb) and
                      (for all K in Index_64 range 31 .. 50 =>
                         XL (K) in FRL) and
                      (XL (51) in XL51_T) and
                      (for all K in Index_64 range 52 .. 62 =>
                         XL (K) = X (K) and
                         XL (K) in 0 .. Max_X_Limb) and
                      (XL (63) = 0)),
             Post => ((for all K in Index_64 range  0 .. 19 =>
                         XL (K) in FRL) and
                      (for all K in Index_64 range 20 .. 31 =>
                         XL (K) in PRL) and
                      (for all K in Index_64 range 32 .. 63 => XL (K) = 0));

      procedure Finalize
        with Global => (In_Out => XL,
                        Output => R),
             Pre  => ((for all K in Index_64 range  0 .. 19 =>
                         XL (K) in FRL) and
                      (for all K in Index_64 range 20 .. 31 =>
                         XL (K) in PRL) and
                      (for all K in Index_64 range 32 .. 63 => XL (K) = 0));

      procedure Initialize_XL
      is
      begin
         XL := (others => 0);
         for K in Index_64 loop
            XL (K) := XL_Limb (X (K));
            pragma Loop_Invariant
              (for all A in Index_64 range 0 .. K => XL (A) = XL_Limb (X (A)));
         end loop;
      end Initialize_XL;

      procedure Eliminate_Limb_63
      is
         Max_L63_Adjustment : constant := 16 * Max_L * Max_X_Limb;
         subtype L63_Adjustment_T is I64 range 0 .. Max_L63_Adjustment;

         --  The most negative value of Carry is when XL (63) = Max_X_Limb and
         --  L (J - 31) = Max_L and XL (J) = 0
         --  so that
         --   Min_L63_Carry =
         --     ASR_8 (0 + Min_L63_Carry - Max_L63_Adjustment + 128)
         Min_L63_Carry : constant := ((128 - Max_L63_Adjustment) / 255) - 1;
         subtype L63_Carry_T is I64 range Min_L63_Carry .. Max_L63_Carry;

         Carry      : L63_Carry_T;
         Adjustment : L63_Adjustment_T;
      begin
         Carry := 0;

         --  In the TweetNaCl sources, this loop interates 20 times
         --  covering elements of L from L (0) to L (19).
         --  In this implementation, though, we choose to loop over the
         --  first 16 elements of L first, since these are all non-zero,
         --  and manually unroll the final 4 iterations where L (16)
         --  through L (19) are all zero.
         for J in I32 range 31 .. 46 loop
            Adjustment := (16 * L (J - 31)) * XL (63);
            XL (J) := XL (J) + Carry - Adjustment;
            Carry := ASR_8 (XL (J) + 128);
            XL (J) := XL (J) - (Carry * 256);

            pragma Loop_Invariant
              ((for all K in Index_64 range 0 .. 30 =>
                  XL (K) = XL'Loop_Entry (K)) and
               (for all K in Index_64 range 31 .. J =>
                  XL (K) in FRL) and
               (for all K in Index_64 range J + 1 .. 63 =>
                  XL (K) = XL'Loop_Entry (K)));
         end loop;

         pragma Assert
           ((for all K in Index_64 range 0 .. 30 =>
               XL (K) = X (K)) and
            (for all K in Index_64 range 31 .. 46 =>
               XL (K) in FRL) and
            (for all K in Index_64 range 47 .. 63 =>
               XL (K) = X (K)));

         --  Final 4 limbs of XL (47) through XL (50)
         --  For these limbs, we know that L (16) through L (19)
         --  is zero, so the calculation of Adjustment can be eliminated.
         --
         --  As these final four limbs are processed, the upper bound
         --  on Carry stays the same at Max_L63_Carry, but the lower bound
         --  converges towards 0.
         declare
            --  Expand the definition of ASR_8 for values gives...
            Min_XL47_Carry : constant :=
              ((Min_L63_Carry + 128 + 1) / 2**8) - 1;
            pragma Assert (Min_XL47_Carry = -127006);
            Min_XL48_Carry : constant :=
              ((Min_XL47_Carry + 128 + 1) / 2**8) - 1;
            pragma Assert (Min_XL48_Carry = -496);
            Min_XL49_Carry : constant :=
              ((Min_XL48_Carry + 128 + 1) / 2**8) - 1;
            pragma Assert (Min_XL49_Carry = -2);
            Min_XL50_Carry : constant := ((Min_XL49_Carry + 128) / 2**8);
            pragma Assert (Min_XL50_Carry = 0);
         begin
            XL (47) := XL (47) + Carry;
            Carry := ASR_8 (XL (47) + 128);
            XL (47) := XL (47) - (Carry * 256);

            pragma Assert (Carry >= Min_XL47_Carry);

            XL (48) := XL (48) + Carry;
            Carry := ASR_8 (XL (48) + 128);
            XL (48) := XL (48) - (Carry * 256);

            pragma Assert (Carry >= Min_XL48_Carry);

            XL (49) := XL (49) + Carry;
            Carry := ASR_8 (XL (49) + 128);
            XL (49) := XL (49) - (Carry * 256);

            pragma Assert (Carry >= Min_XL49_Carry);

            XL (50) := XL (50) + Carry;
            Carry := ASR_8 (XL (50) + 128);
            XL (50) := XL (50) - (Carry * 256);

            --  Lower bound on Carry should have converged to 0
            pragma Assert (Min_XL50_Carry = 0);
            pragma Assert (Carry >= Min_XL50_Carry);
         end;

         pragma Assert
           ((for all K in Index_64 range  0 .. 30 => XL (K) = X (K)) and
            (for all K in Index_64 range 31 .. 50 => XL (K) in FRL) and
            (for all K in Index_64 range 51 .. 63 => XL (K) = X (K)));

         --  Note XL (51) is adjusted here but is NOT normalized
         --  to be in FRL... hence it's a special case in the post-
         --  condition above.
         XL (51) := XL (51) + Carry;
         pragma Assert (XL (51) in XL51_T);
         XL (63) := 0;
      end Eliminate_Limb_63;

      procedure Eliminate_Limbs_62_To_32
      is
         Carry      : Carry_T;
         Adjustment : Adjustment_T;
      begin
         for I in reverse I32 range 32 .. 62 loop
            Carry := 0;
            --  As above, this loop iterates over limbs 0 .. 15 of L
            --  leaving the final four (zero) limbs unrolled below.
            for J in I32 range (I - 32) .. (I - 17) loop
               Adjustment := (16 * L (J - (I - 32))) * XL (I);
               XL (J) := XL (J) + Carry - Adjustment;
               Carry := ASR_8 (XL (J) + 128);
               XL (J) := XL (J) - (Carry * 256);

               pragma Loop_Invariant
                 (for all K in Index_64 range 0 .. I - 33 =>
                    XL (K) = XL'Loop_Entry (K));
               pragma Loop_Invariant
                 (for all K in Index_64 range I - 32 .. J =>
                    XL (K) in FRL);
               pragma Loop_Invariant
                 (for all K in Index_64 range J + 1 .. I32'Min (50, I - 1) =>
                    XL (K) = XL'Loop_Entry (K));
               pragma Loop_Invariant
                 (for all K in Index_64 range J + 1 .. I32'Min (50, I - 1) =>
                    XL (K) in PRL);
               pragma Loop_Invariant
                 (for all K in Index_64 range I32'Max (I - 11, 52) .. I - 1 =>
                    XL (K) = XL'Loop_Entry (K));
               pragma Loop_Invariant
                 (for all K in Index_64 range I + 1 .. 63 => XL (K) = 0);
               pragma Loop_Invariant
                 (for all K in Index_64 => XL (K) in PRL'First .. XL51_T'Last);

            end loop;

            --  16 elements of XL(I-32) .. XL(I-17) are in now FRL
            pragma Assert
              (for all K in Index_64 range I - 32 .. I - 17 =>
                 XL (K) in FRL);

            pragma Assert (XL (I - 16) in FRL);
            --  Carry is in Carry_T here
            XL (I - 16) := XL (I - 16) + Carry;
            Carry := ASR_8 (XL (I - 16) + 128);
            XL (I - 16) := XL (I - 16) - (Carry * 256);

            --  17 elements of XL are in FRL
            pragma Assert
              (for all K in Index_64 range I - 32 .. I - 16 =>
                 XL (K) in FRL);

            pragma Assert (XL (I - 15) in FRL);
            --  Now we can start to prove that Carry is converging.
            --  Each further reduction reduces the lower and upper bound
            --  of Carry by about 2**8, except that the addition of 128 and
            --  ASR_8 actually mean that Carry converges on the range -1 .. 1
            pragma Assert (Carry in -2**17 .. 64);
            XL (I - 15) := XL (I - 15) + Carry;
            Carry := ASR_8 (XL (I - 15) + 128);
            XL (I - 15) := XL (I - 15) - (Carry * 256);

            --  18 elements of XL are in FRL
            pragma Assert
              (for all K in Index_64 range I - 32 .. I - 15 =>
                 XL (K) in FRL);

            pragma Assert (XL (I - 14) in FRL);
            pragma Assert (Carry in -512 .. 1);
            XL (I - 14) := XL (I - 14) + Carry;
            Carry := ASR_8 (XL (I - 14) + 128);
            XL (I - 14) := XL (I - 14) - (Carry * 256);

            --  19 elements of XL are in FRL
            pragma Assert
              (for all K in Index_64 range I - 32 .. I - 14 =>
                 XL (K) in FRL);

            pragma Assert (XL (I - 13) in FRL);
            pragma Assert (Carry in -2 .. 1);
            XL (I - 13) := XL (I - 13) + Carry;
            Carry := ASR_8 (XL (I - 13) + 128);
            XL (I - 13) := XL (I - 13) - (Carry * 256);

            --  20 elements of XL are in FRL
            pragma Assert
              (for all K in Index_64 range I - 32 .. I - 13 =>
                 XL (K) in FRL);

            pragma Assert (XL (I - 12) in FRL);
            pragma Assert (Carry in -1 .. 1);

            --  If Carry in -1 .. 1, then the final adjustment of
            --  XL (I - 12) means that this limb can end up being
            --  -129 or +128, so in PRL but not in FRL
            XL (I - 12) := XL (I - 12) + Carry;
            pragma Assert (XL (I - 12) in PRL);

            --  XL (I) is now eliminated, so it gets zeroed out now.
            XL (I) := 0;

            pragma Loop_Invariant
              (for all K in Index_64 range 0 .. I - 33 =>
                 XL (K) = XL'Loop_Entry (K));

            pragma Loop_Invariant
              (for all K in Index_64 range I - 32 .. I - 13 =>
                 XL (K) in FRL);
            pragma Loop_Invariant
              (XL (I - 12) in PRL);
            pragma Loop_Invariant
              (for all K in Index_64 range I - 11 .. I32'Min (50, I - 1) =>
                 XL (K) in PRL);

            --  This is XL (51) for I in 52 .. 63
            pragma Loop_Invariant
              (if I >= 52 then
              XL (51) >= XL'Loop_Entry (51) + Min_Carry);
            pragma Loop_Invariant
              (if I >= 52 then
              XL (51) <= XL'Loop_Entry (51) + Max_Carry);

            pragma Loop_Invariant
              (for all K in Index_64 range I32'Max (I - 11, 52) .. I - 1 =>
                 XL (K) = XL'Loop_Entry (K));
            pragma Loop_Invariant
              (for all K in Index_64 range I .. 63 => XL (K) = 0);
            pragma Loop_Invariant
              (for all K in Index_64 => XL (K) in PRL'First .. XL51_T'Last);
         end loop;
      end Eliminate_Limbs_62_To_32;

      procedure Finalize
      is
         Final_Carry_Min : constant := -9;
         Final_Carry_Max : constant := 9;

         subtype Final_Carry_T is I64 range Final_Carry_Min .. Final_Carry_Max;
         subtype Step1_XL_Limb is I64 range
           (Final_Carry_Min * 256) ..
           ((Final_Carry_Max + 1) * 256) - 1;

         subtype Step2_XL_Limb is I64 range
           I64_Byte'First - (Final_Carry_Max * Max_L) ..
           I64_Byte'Last  - (Final_Carry_Min * Max_L);

         Carry : Final_Carry_T;
      begin
         --  Step 1
         Carry := 0;
         for J in Index_32 loop
            pragma Assert (XL (31) in PRL);
            XL (J) := XL (J) + (Carry - ASR_4 (XL (31)) * L (J));

            pragma Assert (XL (J) >= Step1_XL_Limb'First);
            pragma Assert (XL (J) <= Step1_XL_Limb'Last);

            Carry := ASR_8 (XL (J));
            XL (J) := XL (J) mod 256;

            --  Modified limbs 0 .. J are all in I64_Byte
            pragma Loop_Invariant
              (for all K in Index_64 range 0 .. J => XL (K) in I64_Byte);
            --  Limbs J + 1 .. 31 are unmodified and in PRL
            pragma Loop_Invariant
              (for all K in Index_64 range J + 1 .. 31 =>
                 XL (K) = XL'Loop_Entry (K));
            pragma Loop_Invariant
              (for all K in Index_64 range J + 1 .. 31 =>
                 XL (K) in PRL);
            --  Trailing 32 limbs are all 0
            pragma Loop_Invariant
              (for all K in Index_64 range 32 .. 63 => XL (K) = 0);
         end loop;

         --  Check first 32 limbs in I64_Byte
         pragma Assert
           (for all K in Index_64 range 0 .. 31 => XL (K) in I64_Byte);
         --  Check later 32 limbs all 0
         pragma Assert
           (for all K in Index_64 range 32 .. 63 => XL (K) = 0);

         --  Step 2
         for J in Index_32 loop
            XL (J) := XL (J) - Carry * L (J);
            pragma Loop_Invariant
              (for all K in Index_32 range 0 .. J =>
                 XL (K) in Step2_XL_Limb);
            pragma Loop_Invariant
              (for all K in Index_64 range 32 .. 63 => XL (K) = 0);
         end loop;

         pragma Assert
           (for all K in Index_64 => XL (K) in Step2_XL_Limb);
         pragma Assert
           (for all K in Index_64 range 32 .. 63 => XL (K) = 0);

         --  Step 3 - final carry chain from X (0) to X (32) and reduce
         --  each limb mod 256
         declare
            --  In Step 3, XL(I+1) is added to ASR_8(XL(I)), so we need to know
            --  the range of the ASR_8(XL(I)). A precise characterisation
            --  of the bounds on XL (I+1) would be non-linear, so we fall
            --  back on a linear over-approximation here, which suffices.

            --  Max XL Carry - max magnitude of carry from XL(I) to XL(I+1)
            MXLC : constant := 10;
            --  Step 3 Carry
            subtype S3CT is I64 range -MXLC .. MXLC;
            S3C : S3CT;
         begin
            for I in Index_32 loop

               pragma Assert (XL (I) >=
                                Step2_XL_Limb'First - MXLC * I64 (I));
               S3C := ASR_8 (XL (I));
               XL (I + 1) := XL (I + 1) + S3C;
               R (I) := Byte (XL (I) mod 256);

               pragma Loop_Invariant (XL (0) = XL'Loop_Entry (0));
               pragma Loop_Invariant
                 (for all K in Index_32 range 0 .. I =>
                    XL (K + 1) >=
                    Step2_XL_Limb'First - (MXLC * (I64 (K) + 1)));
               pragma Loop_Invariant
                 (for all K in Index_32 range 0 .. I =>
                    XL (K + 1) <=
                    Step2_XL_Limb'Last + (MXLC * (I64 (K) + 1)));
               pragma Loop_Invariant
                 (for all K in Index_32 range I + 1 .. 31 =>
                    XL (K + 1) in Step2_XL_Limb);
            end loop;
         end;
      end Finalize;

   begin
      Initialize_XL;
      Eliminate_Limb_63;
      Eliminate_Limbs_62_To_32;

      pragma Warnings (GNATProve, Off, "unused assignment");
      --  Unused assignment to XL here expected
      Finalize;
      return R;
   end ModL;

   function Hash_Reduce (M : in Byte_Seq) return Bytes_32
   is
      R : Hashing.Digest;
      X : I64_Seq_64;
   begin
      Hashing.Hash (R, M);
      X := (others => 0);
      for I in Index_64 loop
         X (I) := I64 (R (I));
         pragma Loop_Invariant
           (for all K in Index_64 range 0 .. I => X (K) in I64_Byte);
      end loop;

      pragma Assert
        (for all K in Index_64 => X (K) in I64_Byte);

      return ModL (X);
   end Hash_Reduce;

   procedure Unpackneg (R  :    out GF_Vector_4;
                        OK :    out Boolean;
                        P  : in     Bytes_32)
   is
      --  Local, time-constant equality test for GF
      --  In the original TweetNaCl sources, this is called eq25519
      function "=" (Left, Right : in Normal_GF) return Boolean
        with Global => null;

      function Pow_2523 (I : in Normal_GF) return Normal_GF
        with Global => null;

      function "=" (Left, Right : in Normal_GF) return Boolean
      is
      begin
         return Equal (Bytes_32'(Utils.Pack_25519 (Left)),
                       Bytes_32'(Utils.Pack_25519 (Right)));
      end "=";

      function Pow_2523 (I : in Normal_GF) return Normal_GF
      is
         C, C2 : Normal_GF;
      begin
         C := I;
         --  Note that 2**252 - 3 = 16#1111_1111 .. 1101#
         --  with only "bit 1" set to 0
         for A in reverse 0 .. 250 loop
            C2 := Square (C);
            if A = 1 then
               C := C2;
            else
               C := C2 * I;
            end if;
         end loop;
         return C;
      end Pow_2523;


      --  Note: refactoring here to functional/SSA form reduces the
      --  number of calls to "*" from 8 in the original TweetNaCl code
      --  to 5 from here until the initialization of R0, but only if
      --  "*" on GF is commutative.
      R1          : constant Normal_GF := Utils.Unpack_25519 (P);
      R2          :          Normal_GF renames GF_1;
      R1_Squared  : constant Normal_GF := Square (R1);
      Num         : constant Normal_GF := R1_Squared - R2;
      Den         : constant Normal_GF := R2 + (R1_Squared * GF_D);
      Den_Power_2 : constant Normal_GF := Square (Den);
      Den_Power_4 : constant Normal_GF := Square (Den_Power_2);
      Num_Den2    : constant Normal_GF := (Num * Den) * Den_Power_2;

      R0    : Normal_GF := Pow_2523 ((Den_Power_4 * Num_Den2)) * Num_Den2;
      Check : Normal_GF;
   begin
      Check := Square (R0) * Den;

      if Check /= Num then
         R0 := R0 * GF_I;
      end if;

      Check := Square (R0) * Den;

      if Check /= Num then
         R  := (others => GF_0);
         OK := False;
         return;
      end if;

      if Par_25519 (R0) = (P (31) / 128) then
         R0 := GF_0 - R0;
      end if;

      R := (0 => R0,
            1 => R1,
            2 => R2,
            3 => R0 * R1);
      OK := True;
   end Unpackneg;



   --============================================
   --  Exported subprogram bodies
   --============================================

   function Serialize (K : in Signing_SK) return Bytes_64
   is
   begin
      return K.F;
   end Serialize;

   function Serialize (K : in Signing_PK) return Bytes_32
   is
   begin
      return K.F;
   end Serialize;

   procedure Sanitize (K : out Signing_PK)
   is
   begin
      SPARKNaCl.Sanitize (K.F);
   end Sanitize;

   procedure Sanitize (K : out Signing_SK)
   is
   begin
      SPARKNaCl.Sanitize (K.F);
   end Sanitize;

   procedure Keypair (PK : out Signing_PK;
                      SK : out Signing_SK)
   is
      D   : Bytes_64;
      LPK : Bytes_32;
      RB  : Bytes_32;
   begin
      RB  := Utils.Random_Bytes_32;

      Hashing.Hash (D, RB);
      D (0)  := D (0) and 248;
      D (31) := (D (31) and 127) or 64;

      LPK := Pack (Scalarbase (D (0 .. 31)));

      PK.F := LPK;
      SK.F := RB & LPK;

      --  Sanitize intermediate values used in key generation
      pragma Warnings (GNATProve, Off, "statement has no effect");
      Sanitize (RB);
      Sanitize (D);
      Sanitize (LPK);
      pragma Unreferenced (RB);
      pragma Unreferenced (D);
      pragma Unreferenced (LPK);
   end Keypair;

   procedure Sign (SM :    out Byte_Seq;
                   M  : in     Byte_Seq;
                   SK : in     Signing_SK)
   is
      subtype Byte_Product is I64 range 0 .. MBP;

      D    : Bytes_64;
      H, R : Bytes_32;
      X    : I64_Seq_64;
      T    : Byte_Product;
   begin
      Hashing.Hash (D, Serialize (SK) (0 .. 31));
      D (0)  := D (0) and 248;
      D (31) := (D (31) and 127) or 64;

      --  Precondition guarantees that SM is 64 bytes longer than M, so
      SM := Zero_Bytes_32 & D (32 .. 63) & M;

      R := Hash_Reduce (SM (32 .. SM'Last));

      SM (0 .. 31) := Pack (Scalarbase (R));

      SM (32 .. 63) := Serialize (SK) (32 .. 63);

      H := Hash_Reduce (SM);

      X := (others => 0);
      for I in Index_32 loop
         X (I) := I64 (R (I));
         pragma Loop_Invariant
           ((for all K in N32 range     0 .. I  => X (K) in I64_Byte) and
            (for all K in N32 range I + 1 .. 63 => X (K) = 0));
      end loop;

      pragma Assert
        ((for all K in N32 range  0 .. 31 => X (K) in I64_Byte) and
         (for all K in N32 range 32 .. 63 => X (K) = 0) and
         (for all K in Index_64 => X (K) in I64_Byte)
        );

      pragma Warnings (Off, "explicit membership test may be optimized");

      for I in Index_32 loop
         for J in Index_32 loop
            T := Byte_Product (H (I)) * Byte_Product (D (J));
            X (I + J) := X (I + J) + T;

            --  This loop invariant follows the same pattern
            --  as that in SPARKNaCl."*"
            pragma Loop_Invariant
              (
               T in Byte_Product and

               --  Lower bound
               (for all K in Index_64 => X (K) >= 0) and

               --  rising from 1 to I
               (for all K in Index_64 range 0 .. (I - 1)   =>
                  X (K) <= (I64 (K + 1) * MBP + 255)) and

               --  flat at I + 1, just written
               (for all K in Index_64 range I .. I32'Min (31, I + J) =>
                  X (K) <= (I64 (I + 1) * MBP + 255)) and

               --  flat at I, not written yet
               (for all K in Index_64 range I + J + 1 .. 31 =>
                  X (K) <= (I64 (I) * MBP + 255)) and

               --  falling from I to 1, just written
               (for all K in Index_64 range 32 .. (I + J) =>
                  X (K) <= (I64 (32 + I) - I64 (K)) * MBP + 255) and

               --  falling, from I to 1, but not written yet
               (for all K in Index_64 range
                  I32'Max (32, I + J + 1) .. (I + 31) =>
                  X (K) <= (I64 (31 + I) - I64 (K)) * MBP + 255) and

               --  Zeroes - never written
               (for all K in Index_64 range I + 32 .. 63   =>
                  X (K) = 0)
              );
         end loop;

         --  Substitute J = 31 into the above yields
         pragma Loop_Invariant
           (
            T in Byte_Product and

            --  Lower bound
            (for all K in Index_64 => X (K) >= 0) and

            --  rising from 1 to I
            (for all K in Index_64 range 0 .. (I - 1)   =>
               X (K) <= (I64 (K + 1) * MBP + 255)) and

            --  flat at I + 1, just written
            (for all K in Index_64 range I .. 31 =>
               X (K) <= (I64 (I + 1) * MBP + 255)) and

            --  falling from I to 1, just written
            (for all K in Index_64 range 32 .. (I + 31) =>
               X (K) <= (I64 (32 + I) - I64 (K)) * MBP + 255) and

            --  Zeroes - never written
            (for all K in Index_64 range I + 32 .. 63   =>
               X (K) = 0)
           );
      end loop;


      --  Substitute I = 31
      pragma Assert
        (
         --  Lower bound
         (for all K in Index_64 => X (K) >= 0) and

         --  Upper bounds
         (for all K in Index_64 range 0 .. 30   =>
            X (K) <= (I64 (K + 1) * MBP + 255)) and
         X (31) <= (32 * MBP + 255) and
         (for all K in Index_64 range 32 .. 62 =>
            X (K) <= (63 - I64 (K)) * MBP + 255) and
         X (63) = 0
        );

      --  Simplify - this assert is equivalent to the precondition of ModL
      pragma Assert
        (for all K in Index_64 => X (K) in 0 .. (32 * MBP + 255));

      SM (32 .. 63) := ModL (X);

      Sanitize (D);
      Sanitize (H);
      Sanitize (R);
      Sanitize_I64_Seq (X);
      pragma Unreferenced (D, H, R, X);
   end Sign;

   procedure Open (M      :    out Byte_Seq;
                   Status :    out Boolean;
                   MLen   :    out I32;
                   SM     : in     Byte_Seq;
                   PK     : in     Signing_PK)
   is
      T    : Bytes_32;
      P, Q : GF_Vector_4;
      LN   : I32;
   begin
      MLen := -1;
      if SM'Length < 64 then
         M := (others => 0);
         Status := False;
         --  No sanitization required before this return
         return;
      end if;

      Unpackneg (Q, Status, Serialize (PK));
      if not Status then
         M := (others => 0);
         Sanitize_GF_Vector_4 (Q);
         return;
      end if;

      M := SM; -- precondition ensures lengths match
      M (32 .. 63) := Serialize (PK);
      P := Scalarmult (Q, Hash_Reduce (M));
      Q := Scalarbase (SM (32 .. 63));

      --  Call to user-defined "+" for GF_Vector_4
      T := Pack (P + Q);

      if not Equal (SM (0 .. 31), T) then
         M := (others => 0);
         Status := False;
         Sanitize (T);
         Sanitize_GF_Vector_4 (P);
         Sanitize_GF_Vector_4 (Q);
         return;
      end if;

      LN := I32 (I64 (SM'Length) - 64);

      M (0 .. LN - 1) := SM (64 .. LN + 63);
      MLen := LN;
      Status := True;

      Sanitize (T);
      Sanitize_GF_Vector_4 (P);
      Sanitize_GF_Vector_4 (Q);
      pragma Unreferenced (T, P, Q);
   end Open;

end SPARKNaCl.Sign;

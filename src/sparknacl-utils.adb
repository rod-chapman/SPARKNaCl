with Ada.Unchecked_Conversion;
package body SPARKNaCl.Utils
  with SPARK_Mode => On
is
   pragma Warnings (GNATProve, Off, "pragma * ignored (not yet supported)");

   procedure Little_Endian_Unpack (Output :    out Bytes_8;
                                   Input  : in     U64)
   is
      X : U64 := Input;
   begin
      for I in Output'Range loop
         pragma Loop_Optimize (No_Unroll);

         Output (I) := Byte (X and 16#ff#);
         X          := Shift_Right (X, Byte'Size);
      end loop;
   end Little_Endian_Unpack;

   procedure Big_Endian_Unpack (Output :    out Bytes_4;
                                Input  : in     U32)
   is
      X : U32 := Input;
   begin
      Output (Output'Last) := Byte (X and 16#ff#);
      pragma Assert (Output (Output'Last)'Initialized);

      for I in reverse Output'First .. Output'Last - 1 loop
         pragma Loop_Optimize (No_Unroll);

         X          := Shift_Right (X, Byte'Size);
         Output (I) := Byte (X and 16#ff#);

         pragma Loop_Invariant (Output (I .. Output'Last)'Initialized);
      end loop;
   end Big_Endian_Unpack;

   function Big_Endian_Pack (Input : in Bytes_4) return U32
   is
      Output : U32 := U32 (Input (Input'First));
   begin
      for I in Input'First + 1 .. Input'Last loop
         pragma Loop_Optimize (No_Unroll);

         Output := Shift_Left (Output, Byte'Size);
         Output := Output or U32 (Input (I));
      end loop;

      return Output;
   end Big_Endian_Pack;

   function Broadcast_Bit_To_Byte (Input : in U32;
                                   Index : in Index_8) return U32
   is
      --  Least Significant Bit in Byte Mask
      LSBB_Mask : constant U32 := 16#01_01_01_01#;

      P, Q, Output : U32;
   begin
      P := Shift_Right (Input, Integer (Index)) and LSBB_Mask;
      Q := Shift_Left (P, Byte'Size - 1);

      Output := Q or (Q - P);

      return Output;
   end Broadcast_Bit_To_Byte;

   function To_U32 is new Ada.Unchecked_Conversion (I32, U32);
   function To_I32 is new Ada.Unchecked_Conversion (U32, I32);

   procedure CSwapI32 (P    : in out I32;
                       Q    : in out I32;
                       Mask : in     U32)
     with Inline,
          Global => null,
          Pre    => (Mask = 0 or Mask = 16#FFFF_FFFF#),
          Post   =>
            ((if (Mask = 16#FFFF_FFFF#) then (P = Q'Old and Q = P'Old)) and
             (if (Mask = 0)             then (P = P'Old and Q = Q'Old)));

   --  Constant-time conditional swap for a GF32 (32-bit limbs)
   procedure CSwap32 (P    : in out GF32;
                      Q    : in out GF32;
                      Swap : in     Boolean)
     with Global => null,
          Contract_Cases =>
            (Swap => (P = Q'Old and Q = P'Old and
                     ((P'Old in Normal_GF32) = (Q in Normal_GF32)) and
                     ((Q'Old in Normal_GF32) = (P in Normal_GF32))),
             not Swap => (P = P'Old and Q = Q'Old) and
                         ((P'Old in Normal_GF32) = (P in Normal_GF32)) and
                         ((Q'Old in Normal_GF32) = (Q in Normal_GF32)));


   --  Constant-time conditional swap for a Normal_GF (16-bit limbs)
   procedure CSwap16 (P    : in out Normal_GF;
                      Q    : in out Normal_GF;
                      Swap : in     Boolean)
   is
      T : U16;
      C : U16 := 16#FFFF# * Boolean'Pos (Swap);
   begin
      for I in Index_16 loop
         pragma Loop_Optimize (No_Unroll);
         T := C and (P (I) xor Q (I));

         --  Case 1 - "Swap"
         --   Swap -> C = 16#FFFF....# -> T = P(I) xor Q (I) ->
         --   P (I) xor T = Q (I) and
         --   Q (I) xor T = P (I)
         --
         --  Case 2 - "Don't Swap"
         --   not Swap -> C = 0 -> T = 0 ->
         --   P (I) xor T = P (I) and
         --   Q (I) xor T = Q (I)
         pragma Assert
           ((if Swap then
              (T = (P (I) xor Q (I)) and then
               (P (I) xor T) = Q (I) and then
               (Q (I) xor T) = P (I))
             else
              (T = 0 and then
               (P (I) xor T) = P (I) and then
               (Q (I) xor T) = Q (I)))
           );

         P (I) := P (I) xor T;
         Q (I) := Q (I) xor T;

         pragma Loop_Invariant
           (if Swap then
              (for all J in Index_16 range 0 .. I =>
                   (P (J) = Q'Loop_Entry (J) and
                    Q (J) = P'Loop_Entry (J)))
            else
              (for all J in Index_16 range 0 .. I =>
                   (P (J) = P'Loop_Entry (J) and
                    Q (J) = Q'Loop_Entry (J)))
           );
      end loop;

      --  Sanitize local variables as per the implementation in WireGuard.
      --  Note that Swap cannot be sanitized here since it is
      --  an "in" parameter
      pragma Warnings (GNATProve, Off, "statement has no effect");
      Sanitize_U16 (T);
      Sanitize_U16 (C);
      pragma Unreferenced (T);
      pragma Unreferenced (C);
   end CSwap16;

   procedure CSwapI32 (P    : in out I32;
                       Q    : in out I32;
                       Mask : in     U32)
   is
      T : U32;
      pragma Assertion_Policy (Assume => Ignore);
   begin
      --  We need these axioms
      pragma Assume (To_I32 (To_U32 (P)) = P);
      pragma Assume (To_I32 (To_U32 (Q)) = Q);

      T := Mask and (To_U32 (P) xor To_U32 (Q));

      pragma Assert
        ((if (Mask = 16#FFFF_FFFF#) then (T = (To_U32 (P) xor To_U32 (Q)))) and
         (if (Mask = 0)             then (T = 0)));

      pragma Assume
        ((To_U32 (P) xor (To_U32 (P) xor To_U32 (Q))) = To_U32 (Q));
      pragma Assume
        ((To_U32 (Q) xor (To_U32 (P) xor To_U32 (Q))) = To_U32 (P));
      pragma Assume
        ((To_U32 (P) xor 0) = To_U32 (P));
      pragma Assume
        ((To_U32 (Q) xor 0) = To_U32 (Q));

      pragma Assume
        (To_I32 (To_U32 (P) xor (To_U32 (P) xor To_U32 (Q))) = Q);
      pragma Assume
        (To_I32 (To_U32 (Q) xor (To_U32 (P) xor To_U32 (Q))) = P);
      pragma Assume
        (To_I32 (To_U32 (P) xor 0) = P);
      pragma Assume
        (To_I32 (To_U32 (Q) xor 0) = Q);

      P := To_I32 (To_U32 (P) xor T);
      Q := To_I32 (To_U32 (Q) xor T);

      --  Sanitize local variables as per the implementation in WireGuard.
      --  Note that Swap cannot be sanitized here since it is
      --  an "in" parameter
      pragma Warnings (GNATProve, Off, "statement has no effect");
      Sanitize_U32 (T);
      pragma Unreferenced (T);
   end CSwapI32;

   procedure CSwap32 (P    : in out GF32;
                      Q    : in out GF32;
                      Swap : in     Boolean)
   is
      C : U32 := 16#FFFF_FFFF# * Boolean'Pos (Swap);
   begin
      for I in Index_16 loop
         CSwapI32 (P (I), Q (I), C);

         pragma Loop_Invariant
           (if Swap then
               P (0 .. I) = Q'Loop_Entry (0 .. I) and
               Q (0 .. I) = P'Loop_Entry (0 .. I)
            else
               P (0 .. I) = P'Loop_Entry (0 .. I) and
               Q (0 .. I) = Q'Loop_Entry (0 .. I));
      end loop;

      --  Sanitize local variables as per the implementation in WireGuard.
      --  Note that Swap cannot be sanitized here since it is
      --  an "in" parameter
      pragma Warnings (GNATProve, Off, "statement has no effect");
      Sanitize_U32 (C);
      pragma Unreferenced (C);
   end CSwap32;




   function Pack_25519 (N : in Normal_GF) return Bytes_32
   is
      --  Subtracting P twice from a Normal_GF might result
      --  in a GF where limb 15 can be negative with lower bound -65536
      subtype Temp_GF_MSL is I32 range -LM .. LMM1;
      subtype Temp_GF is GF32
        with Dynamic_Predicate =>
          (Temp_GF (15) in Temp_GF_MSL and
            (for all K in Index_16 range 0 .. 14 =>
               Temp_GF (K) in GF32_Normal_Limb));

      function To_Normal_GF32 (X : in Normal_GF) return Normal_GF32
        is (Normal_GF32'(0  => GF32_Normal_Limb (X (0)),
                         1  => GF32_Normal_Limb (X (1)),
                         2  => GF32_Normal_Limb (X (2)),
                         3  => GF32_Normal_Limb (X (3)),
                         4  => GF32_Normal_Limb (X (4)),
                         5  => GF32_Normal_Limb (X (5)),
                         6  => GF32_Normal_Limb (X (6)),
                         7  => GF32_Normal_Limb (X (7)),
                         8  => GF32_Normal_Limb (X (8)),
                         9  => GF32_Normal_Limb (X (9)),
                        10 => GF32_Normal_Limb (X (10)),
                        11 => GF32_Normal_Limb (X (11)),
                        12 => GF32_Normal_Limb (X (12)),
                        13 => GF32_Normal_Limb (X (13)),
                        14 => GF32_Normal_Limb (X (14)),
                        15 => GF32_Normal_Limb (X (15))))
        with Global => null,
             Pure_Function;

      --  Result := T - P;
      --  if     Underflow, then Result is not a Normal_GF
      --  if not Underflow, then Result is     a Normal_GF
      procedure Subtract_P (T         : in     Temp_GF;
                            Result    :    out Temp_GF;
                            Underflow :    out Boolean)
        with Global => null,
             Pre    => T (15) >= -16#8000#,
             Post   => (Result (15) >= T (15) - 16#8000#) and then
                       (if not Underflow then (Result in Normal_GF32));

      function To_Bytes_32 (X : in Normal_GF32) return Bytes_32
        with Global => null;

      procedure Subtract_P (T         : in     Temp_GF;
                            Result    :    out Temp_GF;
                            Underflow :    out Boolean)
      is
         Carry  : I32_Bit;
         R      : GF32;
         Normal : Boolean;
      begin
         R := GF32_0;

         --  Limb 0 - subtract LSL of P, which is 16#FFED#
         R (0) := T (0) - 16#FFED#;

         --  Limbs 1 .. 14 - subtract FFFF with carry
         for I in Index_16 range 1 .. 14 loop
            pragma Loop_Optimize (No_Unroll);
            Carry     := ASR32_16 (R (I - 1)) mod 2;
            R (I)     := T (I) - 16#FFFF# - Carry;
            R (I - 1) := R (I - 1) mod LM;

            pragma Loop_Invariant
              (for all J in Index_16 range 0 .. I - 1 =>
                 R (J) in GF32_Normal_Limb);
         end loop;

         --  Substitute I=14 into loop invariant to get
         pragma Assert
           (for all J in Index_16 range 0 .. 13 =>
              R (J) in GF32_Normal_Limb);

         --  Limb 15 - Subtract MSL (Most Significant Limb)
         --  of P (16#7FFF#) with carry.
         --  Note that Limb 15 might become negative on underflow
         Carry  := ASR32_16 (R (14)) mod 2;
         R (15) := (T (15) - 16#7FFF#) - Carry;

         --  Historical note: the original version of TweetNaCl had a bug
         --  here, with the following line written as
         --   R (15) := R (15) mod LM;
         --  If this bug is re-introduced here, then SPARK _does_ report
         --  this as a type-safety error, since if R (15) is normalized
         --  but R (14) is not, then the prover is unable to show that
         --  R is a Temp_GF subtype in the assignment to Result below.
         --  R (15) := R (15) mod LM;
         R (14) := R (14) mod LM;

         pragma Assert
           (for all J in Index_16 range 0 .. 14 =>
              R (J) in GF32_Normal_Limb);
         --  Carry can only be 0 or 1, so...
         pragma Assert (R (15) >= T (15) - 16#8000#);
         pragma Assert (R (15) in Temp_GF_MSL);


         --  Note that R (15) is not normalized here, so that the
         --  result of the first subtraction is numerically correct
         --  as the input to the second.
         Normal := R (15) >= 0;

         pragma Assert (if Normal then (R in Normal_GF32));

         Underflow := not Normal;
         Result    := R;
         Sanitize_GF32 (R);
         pragma Unreferenced (R);
      end Subtract_P;

      function To_Bytes_32 (X : in Normal_GF32) return Bytes_32
      is
         Result : Bytes_32 := Zero_Bytes_32;
      begin
         for I in Index_16 loop
            pragma Loop_Optimize (No_Unroll);
            Result (2 * I)     := Byte (X (I) mod 256);
            Result (2 * I + 1) := Byte (X (I) / 256);
         end loop;
         return Result;
      end To_Bytes_32;

      L      : Temp_GF;
      R1, R2 : Temp_GF;

      First_Underflow  : Boolean;
      Second_Underflow : Boolean;
   begin
      --  Make a variable copy of N so can be passed to
      --  calls to CSwap below
      L := Temp_GF (To_Normal_GF32 (N));

      --  SPARKNaCl differs from TweetNaCl here, in that Pack_25519
      --  takes a Normal_GF parameter N, so no further normalization
      --  by Car_25519 is required here.

      --  Readable, but variable-time version of this algorithm:
      --     Subtract_P (L,  R1, First_Underflow);
      --     if First_Underflow then
      --        return L;
      --     else
      --        Subtract_P (R1, R2, Second_Underflow);
      --        if Second_Underflow then
      --           return R1;
      --        else
      --           return R2;
      --        end if;
      --     end if;

      --  Constant-time version: always do both subtractions, then
      --  use CSwap to swap the right answer into R2
      Subtract_P (L,  R1, First_Underflow);
      Subtract_P (R1, R2, Second_Underflow);
      CSwap32 (R1, R2, Second_Underflow);
      CSwap32 (L,  R2, First_Underflow);

      --  Sanitize local data as per the WireGuard sources
      Sanitize_GF32 (L);
      Sanitize_GF32 (R1);
      Sanitize_Boolean (First_Underflow);
      Sanitize_Boolean (Second_Underflow);

      --  R2 needs to be a Normal_GF here. The post-conditions
      --  of Subtract_P and CSwap conspire to make this so.
      return To_Bytes_32 (R2);

      pragma Unreferenced (R1);
      pragma Unreferenced (L);
      pragma Unreferenced (First_Underflow);
      pragma Unreferenced (Second_Underflow);
   end Pack_25519;

   function Unpack_25519 (N : in Bytes_32) return Normal_GF
   is
      O : Normal_GF with Relaxed_Initialization;
   begin
      begin
         for I in Index_16 loop
            pragma Loop_Optimize (No_Unroll);
            O (I) := U16 (N (2 * I)) + (U16 (N (2 * I + 1)) * 256);
            pragma Loop_Invariant
              (for all J in Index_16 range 0 .. I =>
                 O (J)'Initialized);
         end loop;
         O (15) := O (15) mod 32768;
      end;
      return O;
   end Unpack_25519;

   function Inv_25519 (I : in Normal_GF) return Normal_GF
   is
      C : Normal_GF;
   begin
      C := I;

      --  Unroll final 5 loop iterations and simplify to remove branch
      --  from inside this loop.
      for A in reverse 5 .. 253 loop
         C := Square (C) * I;
      end loop;

      C := Square (C);      --  A = 4
      C := Square (C) * I;  --  A = 3
      C := Square (C);      --  A = 2
      C := Square (C) * I;  --  A = 1
      C := Square (C) * I;  --  A = 0

      return C;
   end Inv_25519;

end SPARKNaCl.Utils;

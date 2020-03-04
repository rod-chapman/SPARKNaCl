package body SPARKNaCl.Utils
  with SPARK_Mode => On
is

   type Bit_To_Swapmask_Table is array (Boolean) of U64;
   Bit_To_Swapmask : constant Bit_To_Swapmask_Table :=
     (False => 16#0000_0000_0000_0000#,
      True  => 16#FFFF_FFFF_FFFF_FFFF#);

   procedure CSwap (P    : in out GF;
                    Q    : in out GF;
                    Swap : in     Boolean)
   is
      T : U64;
      C : U64 := Bit_To_Swapmask (Swap);

      --  Do NOT try to evaluate the assumption below at run-time
      pragma Assertion_Policy (Assume => Ignore);
   begin
      --  We need this axiom
      pragma Assume
        (for all K in I64 => To_I64 (To_U64 (K)) = K);

      for I in Index_16 loop
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));

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
              (T = (To_U64 (P (I)) xor To_U64 (Q (I))) and then
               To_I64 (To_U64 (P (I)) xor T) = Q (I) and then
               To_I64 (To_U64 (Q (I)) xor T) = P (I))
             else
              (T = 0 and then
               To_I64 (To_U64 (P (I)) xor T) = P (I) and then
               To_I64 (To_U64 (Q (I)) xor T) = Q (I)))
           );

         P (I) := To_I64 (To_U64 (P (I)) xor T);
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);

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
      Sanitize_U64 (T);
      Sanitize_U64 (C);
      pragma Unreferenced (T);
      pragma Unreferenced (C);
   end CSwap;

   function Pack_25519 (N : in Normal_GF) return Bytes_32
   is
      --  Subtracting P twice from a Normal_GF might result
      --  in a GF where limb 15 can be negative with lower bound -65536
      subtype Temp_GF_MSL is I64 range -LM .. LMM1;
      subtype Temp_GF is GF
        with Dynamic_Predicate =>
          (Temp_GF (15) in Temp_GF_MSL and
            (for all K in Index_16 range 0 .. 14 =>
               Temp_GF (K) in GF_Normal_Limb));

      --  Result := T - P;
      --  if     Underflow, then Result is not a Normal_GF
      --  if not Underflow, then Result is     a Normal_GF
      procedure Subtract_P (T         : in     Temp_GF;
                            Result    :    out Temp_GF;
                            Underflow :    out Boolean)
        with Global => null,
             Post   => Underflow /= (Result in Normal_GF);

      function To_Bytes_32 (X : in Normal_GF) return Bytes_32
        with Global => null;

      procedure Subtract_P (T         : in     Temp_GF;
                            Result    :    out Temp_GF;
                            Underflow :    out Boolean)
      is
         Carry : I64_Bit;
         R     : GF;
      begin
         R := GF_0;

         --  Limb 0 - subtract LSL of P, which is 16#FFED#
         R (0) := T (0) - 16#FFED#;

         --  Limbs 1 .. 14 - subtract FFFF with carry
         for I in Index_16 range 1 .. 14 loop
            Carry     := ASR_16 (R (I - 1)) mod 2;
            R (I)     := T (I) - 16#FFFF# - Carry;
            R (I - 1) := R (I - 1) mod LM;

            pragma Loop_Invariant
              (for all J in Index_16 range 0 .. I - 1 =>
                 R (J) in GF_Normal_Limb);
            pragma Loop_Invariant
              (R (I) = T (I) - 16#FFFF# - Carry);
            pragma Loop_Invariant
              (for all J in Index_16 range I + 1 .. Index_16'Last =>
                 R (J) = 0);
            pragma Loop_Invariant (T in Temp_GF);
         end loop;

         --  Limb 15 - Subtract MSL (Most Significant Limb)
         --  of P (16#7FFF#) with carry.
         --  Note that Limb 15 might become negative on underflow
         Carry  := ASR_16 (R (14)) mod 2;
         R (15) := (T (15) - 16#7FFF#) - Carry;

         --  Historical note: the original version of TweetNaCl had a bug
         --  here, with the following line written as
         --   R (15) := R (15) mod LM;
         --  If this bug is re-introduced here, then SPARK _does_ report
         --  this as a type-safety error, since if R (15) is normalized
         --  but R (14) is not, then the prover is unable to show that
         --  R is a Temp_GF subtype in the assignment to Result below.
         R (14) := R (14) mod LM;

         --  Note that R (15) is not normalized here, so that the
         --  result of the first subtraction is numerically correct
         --  as the input to the second.
         Underflow := R (15) < 0;
         Result    := R;
         Sanitize_GF (R);
         pragma Unreferenced (R);
      end Subtract_P;

      function To_Bytes_32 (X : in Normal_GF) return Bytes_32
      is
         Result : Bytes_32 := Zero_Bytes_32;
      begin
         for I in Index_16 loop
            Result (2 * I)     := Byte (X (I) mod 256);
            Result (2 * I + 1) := Byte (X (I) / 256);
         end loop;
         return Result;
      end To_Bytes_32;

      L      : GF;
      R1, R2 : Temp_GF;

      First_Underflow  : Boolean;
      Second_Underflow : Boolean;
   begin
      --  Make a variable copy of N so can be passed to
      --  calls to CSwap below
      L := N;

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
      CSwap (R1, R2, Second_Underflow);
      CSwap (L,  R2, First_Underflow);

      --  Sanitize local data as per the WireGuard sources
      Sanitize_GF (L);
      Sanitize_GF (R1);
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
      O : Normal_GF := GF_0;
   begin
      for I in Index_16 loop
         O (I) := I64 (N (2 * I)) + (I64 (N (2 * I + 1)) * 256);
      end loop;
      O (15) := O (15) mod 32768;
      return O;
   end Unpack_25519;

   function Inv_25519 (I : in Normal_GF) return Normal_GF
   is
      C : Normal_GF;
   begin
      C := I;

      for A in reverse 0 .. 253 loop
         C := Square (C);
         if (A /= 2 and A /= 4) then
            C := C * I;
         end if;
      end loop;

      return C;
   end Inv_25519;

   function Random_Bytes_32 return Bytes_32
   is
      Result : Bytes_32;
   begin
      for I in Result'Range loop
         Result (I) := Random.Random_Byte;
      end loop;
      return Result;
   end Random_Bytes_32;

end SPARKNaCl.Utils;

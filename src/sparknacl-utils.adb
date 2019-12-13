--  with SPARKNaCl.PDebug;
package body SPARKNaCl.Utils
  with SPARK_Mode => On
is

   type Bit_To_Swapmask_Table is array (Boolean) of U64;
   Bit_To_Swapmask : constant Bit_To_Swapmask_Table :=
     (False => 16#0000_0000_0000_0000#,
      True  => 16#FFFF_FFFF_FFFF_FFFF#);

   --  POK
   procedure Sel_25519 (P    : in out GF;
                        Q    : in out GF;
                        Swap : in     Boolean)
   is
      T : U64;
      C : constant U64 := Bit_To_Swapmask (Swap);
   begin
      for I in Index_16 loop
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));


         --  Case 1:
         --   Swap -> C = 16#FFFF....# -> T = P(I) xor Q (I) ->
         --   P (I) xor T = Q (I) and
         --   Q (I) xor T = P (I)
         --
         --  Case 2:
         --   not Swap -> C = 0 -> T = 0 ->
         --   P (I) xor T = P (I) and
         --   Q (I) xor T = Q (I)
         pragma Assert
           ((if Swap then
              (T = (To_U64 (P (I)) xor To_U64 (Q (I))) and then
               (To_U64 (P (I)) xor T) = To_U64 (Q (I)) and then
               (To_U64 (Q (I)) xor T) = To_U64 (P (I)))
             else
              (T = 0 and then
               (To_U64 (P (I)) xor T) = To_U64 (P (I)) and then
               (To_U64 (Q (I)) xor T) = To_U64 (Q (I))))
           );

         --  This Assume seems to make no differnce...
         pragma Assume
           (To_I64 (To_U64 (P (I)) xor T)'Valid and
            To_I64 (To_U64 (Q (I)) xor T)'Valid);

         --  "range Check might fail here" - why?
         P (I) := To_I64 (To_U64 (P (I)) xor T);
         --  Ditto
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

   end Sel_25519;

   procedure Car_25519 (O : in out GF)
   is
      subtype LSB_Adjustment is I64 range -1 .. (2**20 + 20);
      subtype Carry_Adjustment is I64 range -1 .. (38 * 2**20);
      LSBA : LSB_Adjustment;
      Carry : Carry_Adjustment;
   begin
      --  In SPARK, we unroll the final (I = 15)'th iteration
      --  of this loop below. This removes the need for
      --  a conditional statement or expression inside the loop
      --  body. This implementation differs from that in the
      --  TweetNaCl sources, as suggested by Jason Donenfeld,
      --  and further simplified by Benoit Viguier as a result
      --  of formal verification of this algorithm with Coq.
      --
      --  This implementation also avoids the use of the <<
      --  operator on a signed integer which is undefined
      --  behaviour in C.

--      Debug.DH ("Into Car, O is ", O);

      for I in Index_16 range 0 .. 14 loop
         Carry := ASR_16 (O (I));
--         Debug.DH ("Carry is ", Carry);
--         Debug.DHH ("O (I + 1) is ", O (I + 1));
--         Debug.DHH ("Carry is ", Carry);

         --  O (15) in 0 .. (16*MGFLP + Carry'Last)
         O (I + 1) := O (I + 1) + Carry; --  POV on RHS 2nd +

         O (I) := O (I) mod 65536;
      end loop;

--      Debug.DH ("O (15) is ", O (15));
--      Debug.DHH ("O (15) is ", O (15));

      LSBA := ASR_16 (O (15));

--      Debug.DH ("LSBA is ", LSBA);
--      Debug.DHH ("LSBA is ", LSBA);

--      Debug.DH ("O (0) is ", O (0));
--      Debug.DHH ("O (0) is ", O (0));

      O (0) := O (0) + 38 * LSBA; --  0 .. 39_846_648

--      Debug.DH ("Final O (0) is ", O (0));
--      Debug.DHH ("Final O (0) is ", O (0));

      O (15) := O (15) mod 65536;
   end Car_25519;

   function Car_Any_To_Seminormal (X : in Unnormalized_GF_Product)
                                  return Seminormal_GF
   is
      R : GF;
   begin
      R := X;
      Car_25519 (R);
      return Seminormal_GF (R);
   end Car_Any_To_Seminormal;

   function Car_Summation_To_Seminormal (X : in Summation_GF)
                                        return Seminormal_GF
   is
      R : GF;
   begin
      R := X;
      Car_25519 (R);
      return Seminormal_GF (R);
   end Car_Summation_To_Seminormal;

   function Car_Difference_To_Seminormal (X : in Difference_GF)
                                        return Seminormal_GF
   is
      R : GF;
   begin
      R := X;
      Car_25519 (R);
      return Seminormal_GF (R);
   end Car_Difference_To_Seminormal;

   function Car_Seminormal_To_Normal (X : in Seminormal_GF)
                                  return Normal_GF
   is
      R : GF;
   begin
      R := X;
      Car_25519 (R);
      return Normal_GF (R);
   end Car_Seminormal_To_Normal;

   function Pack_25519 (N : in GF) return Bytes_32
   is
--      subtype Reduced_Limb is I64 range -65536 .. 65535;

      procedure Subtract_P (T         : in     GF;
                            Result    :    out GF;
                            Underflow :    out Boolean)
        with Global => null;

      function To_Bytes_32 (X : in Normal_GF) return Bytes_32
        with Global => null;

      procedure Subtract_P (T         : in     GF;
                            Result    :    out GF;
                            Underflow :    out Boolean)
      is
         subtype CBit is I64 range 0 .. 1;
         Carry     : CBit;
      begin
         Result := GF_0;

         --  Limb 0 - subtract FFED
         Result (0) := T (0) - 16#FFED#; --  POV

         --  Limbs 1 .. 14 - subtract FFFF with carry
         for I in I32 range 1 .. 14 loop
            Carry := ASR_16 (Result (I - 1)) mod 2;
            Result (I) := T (I) - 16#FFFF# - Carry;
            Result (I - 1) := Result (I - 1) mod 65536;
         end loop;

         --  Limb 15 - Subtract 7FFF with carry
         Carry := ASR_16 (Result (14)) mod 2;
         Result (15) := T (15) - 16#7FFF# - Carry;
         --  Note that Limb 15 might be negative now
         Result (14) := Result (14) mod 65536;

         Underflow := Boolean'Val (ASR_16 (Result (15)) mod 2);
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

      L, R1, R2 : GF;

      First_Reduction_Underflowed  : Boolean;
      Second_Reduction_Underflowed : Boolean;
   begin
      L := N;

      --  Fully normalize T first so all limbs in 0 .. 65535
      Car_25519 (L);
      Car_25519 (L);
      Car_25519 (L);

      Subtract_P (L,  R1, First_Reduction_Underflowed);
      Subtract_P (R1, R2, Second_Reduction_Underflowed);

      Sel_25519 (R1, R2, Second_Reduction_Underflowed);
      Sel_25519 (L,  R2, First_Reduction_Underflowed);

      pragma Unreferenced (R1);
      pragma Unreferenced (L);

      pragma Assert (R2 in Normal_GF);

      --  The right answer is now in R2
      return To_Bytes_32 (R2);
   end Pack_25519;

   --  POK
   function Unpack_25519 (N : in Bytes_32) return GF
   is
      O : GF;
   begin
      for I in Index_16 loop
         O (I) := I64 (N (2 * I)) + (I64 (N (2 * I + 1)) * 256);
      end loop;
      O (15) := O (15) mod 32768;
      return O;
   end Unpack_25519;


   --  Proof - is I a Normal_GF?
   function Inv_25519 (I : in GF) return GF
   is
      C, C2 : GF;
   begin
      C := I;

      for A in reverse 0 .. 253 loop
         --  Need C2 here to avoid aliasing C with C via pass by reference
         C2 := Square (C);  -- C in Normal_GF?
         if (A /= 2 and A /= 4) then
            C := C2 * I;
         else
            C := C2;
         end if;
      end loop;

      return C;
   end Inv_25519;


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

end SPARKNaCl.Utils;

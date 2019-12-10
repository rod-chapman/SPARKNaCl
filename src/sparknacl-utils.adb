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
         P (I) := To_I64 (To_U64 (P (I)) xor T);
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
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

   --  P?
   function Pack_25519 (N : in GF) return Bytes_32
   is
      subtype CBit is I64 range 0 .. 1;
      Underflow : Boolean;
      Carry     : CBit;
      M, T      : GF;
      O         : Bytes_32;
   begin
      --  Reduces N to be sure it's in the range 0 .. p - 1
      --  where p = (2**255 - 19) and then converts to
      --  32 8-bit bytes.

      --  Values of N representing >= p are reduced by subtracting p
      --  The maximum value representible in a raw GF is 2**256 - 1,
      --  a maximum of 2 subtractions is required.

      M := (others => 0);
      T := N;

      --  Fully normalize T first so all limbs in 0 .. 65535
      Car_25519 (T);
      Car_25519 (T);
      Car_25519 (T);

      --  Check that T is normalized now
      pragma Assert (T in Normal_GF);

      --  Subtract p = 7FFF_FFFF_FFFF_...._FFED either zero times, once or
      --  twice to reduce T to represent 0 .. p-1, BUT this is coded to be
      --  constant-time. See below
      for J in I32 range 0 .. 1 loop
         M (0) := T (0) - 16#FFED#; --  POV
         for I in I32 range 1 .. 14 loop

            Carry := ASR_16 (M (I - 1)) mod 2;
            M (I) := T (I) - 16#FFFF# - Carry;

            M (I - 1) := M (I - 1) mod 65536;
         end loop;
         Carry := ASR_16 (M (14)) mod 2;
         M (15) := T (15) - 16#7FFF# - Carry;
         M (14) := M (14) mod 65536;

         --  This takes a bit of explaining...
         --  Consider the first time we encounter the following code,
         --  in the FIRST loop iteration:
         --
         --  Case 1:
         --    If the subtraction DID underflow, then T must have been smaller
         --    than p all along (so doesn't really need to be adjusted at all).
         --    In this case, DON'T swap T and M, go round the loop again and
         --    produce exactly the same result. The required result is in the
         --    (completely unmodified) value of T.
         --
         --  Now consider when we get here the SECOND time:
         --
         --  Case 2a:
         --    If the first subtraction DID underflow, then so will the second
         --    and the (unmodified) result is in T.
         --  Case 2b:
         --    If the first subtraction DIDN'T underflow, then M and T will
         --    have been swapped, so we've just subtracted p _again_. If the
         --    second subtraction DID underflow, then the result we want is
         --    in T, so DON'T swap M and T.
         --  Case 2b:
         --    If the first subtraction DIDN'T underflow, then M and T will
         --    have been swapped, so we've just subtracted p _again_. If the
         --    second subtraction DIDN'T underflow, then the result we want
         --    is in M, so DO swap M and T to get the result in T.
         Underflow := Boolean'Val (ASR_16 (M (15)) mod 2);
         Sel_25519 (T, M, not Underflow);
      end loop;

      pragma Assert (T in Normal_GF);

      O := (others => 0);
      for I in Index_16 loop
         pragma Assert (T in Normal_GF);

         O (2 * I)     := Byte (T (I) mod 256);
         O (2 * I + 1) := Byte ((T (I) / 256) mod 256);
      end loop;
      return O;
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


   --  POK
   function Inv_25519 (I : in GF) return GF
   is
      C, C2 : GF;
   begin
      C := I;

      for A in reverse 0 .. 253 loop
         --  Need C2 here to avoid aliasing C with C via pass by reference
         C2 := Square (C);
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

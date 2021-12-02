with Ada.Unchecked_Conversion;
package body Car32
  with SPARK_Mode => On
is
   function To_U32 is new Ada.Unchecked_Conversion (I32, U32);
   function To_I32 is new Ada.Unchecked_Conversion (U32, I32);

   --  returns equivalent of X >> 16 in C, doing an arithmetic
   --  shift right when X is negative, assuming 2's complement
   --  representation
   function ASR_16 (X : in I32) return I32
   is (To_I32 (Shift_Right_Arithmetic (To_U32 (X), 16)))
     with Post => (if X >= 0 then ASR_16'Result = X / 65536 else
                                  ASR_16'Result = ((X + 1) / 65536) - 1);
   pragma Annotate (GNATprove,
                    False_Positive,
                    "postcondition might fail",
                    "From definition of arithmetic shift right");


   function C (X : in GF) return GF
   is
      Carry : I32;
      R     : GF with Relaxed_Initialization;
   begin
      Carry := ASR_16 (X (0));
      R (0) := X (0) mod 65536;
      R (1) := X (1) + Carry;

      for I in Index_16 range 1 .. 14 loop
         Carry := ASR_16 (R (I));
         R (I) := R (I) mod 65536;
         R (I + 1) := X (I + 1) + Carry;
      end loop;

      Carry := ASR_16 (R (15));
      R (0) := R (0) + 38 * Carry;
      R (15) := R (15) mod 65536;

      return R;
   end C;

end Car32;

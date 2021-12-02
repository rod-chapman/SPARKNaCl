with Interfaces; use Interfaces;
with Ada.Unchecked_Conversion;
package S2
  with SPARK_Mode => On
is
   subtype U64 is Unsigned_64;
   subtype I64 is Integer_64;

   function To_U64 is new Ada.Unchecked_Conversion (I64, U64);
   function To_I64 is new Ada.Unchecked_Conversion (U64, I64);

   function ASR_4 (X : in I64) return I64
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 4)))
     with Post => (if X >= 0 then ASR_4'Result = X / 16 else
                                  ASR_4'Result = ((X + 1) / 16) - 1);

   pragma Annotate (GNATprove,
                    False_Positive,
                    "postcondition might fail",
                    "From definition of arithmetic shift right");

end S2;

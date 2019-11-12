with Ada.Numerics.Discrete_Random;
package body Random
  with SPARK_Mode => Off
is
   pragma Compile_Time_Warning
     (True, "This PRNG is not cryptographically secure.");

   package PRNG is new Ada.Numerics.Discrete_Random (Interfaces.Unsigned_8);

   Gen : PRNG.Generator;

   function Random_Byte return Interfaces.Unsigned_8
   is
   begin
      return PRNG.Random (Gen);
   end Random_Byte;

begin
   PRNG.Reset (Gen); -- time dependent
end Random;

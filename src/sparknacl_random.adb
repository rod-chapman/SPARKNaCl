with Ada.Numerics.Discrete_Random;
package body SPARKNaCl_Random
  with SPARK_Mode => Off
is

   package PRNG is new Ada.Numerics.Discrete_Random (Interfaces.Unsigned_8);

   Gen : PRNG.Generator;

   -----------------
   -- Random_Byte --
   -----------------

   function Random_Byte return Interfaces.Unsigned_8 is
   begin
      return PRNG.Random (Gen);
   end Random_Byte;

begin
   PRNG.Reset (Gen); -- time dependent
end SPARKNaCl_Random;

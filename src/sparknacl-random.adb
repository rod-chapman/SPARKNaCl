with Ada.Numerics.Discrete_Random;
package body SPARKNaCl.Random
  with SPARK_Mode => Off
is
   package PRNG is new Ada.Numerics.Discrete_Random (Interfaces.Unsigned_8);

   Gen : PRNG.Generator;

   function Random_Byte return Interfaces.Unsigned_8
   is
   begin
      return PRNG.Random (Gen);
   end Random_Byte;

   procedure Random_Bytes (R : out Byte_Seq)
   is
   begin
      for I in R'Range loop
         R (I) := Random_Byte;
      end loop;
   end Random_Bytes;

begin
   PRNG.Reset (Gen); -- time dependent
end SPARKNaCl.Random;

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

   procedure Random_Bytes (R : out SPARKNaCl.Byte_Seq)
   is
   begin
      for I in R'Range loop
         pragma Loop_Optimize (No_Unroll);
         R (I) := Random_Byte;
      end loop;
   end Random_Bytes;

begin
   PRNG.Reset (Gen); -- time dependent
end Random;

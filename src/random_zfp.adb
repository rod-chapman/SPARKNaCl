package body Random
  with SPARK_Mode => Off
is
   --  This is a STUB version of this package body, intended only to
   --  check compatibility with the ZFP runtime library.
   --
   --  In particular, this stub does NOT depend on
   --  Ada.Numerics.Discrete_Random, which isn not permitted in the
   --  ZFP runtime.
   pragma Compile_Time_Warning
     (True, "This PRNG is not cryptographically secure.");

   Gen : Interfaces.Unsigned_8 := 0;

   function Random_Byte return Interfaces.Unsigned_8
   is
      use type Interfaces.Unsigned_8;
   begin
      --  Definitely NOT random!
      Gen := Gen + 1;
      return Gen;
   end Random_Byte;

end Random;

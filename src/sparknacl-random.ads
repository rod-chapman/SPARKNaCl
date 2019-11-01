with Interfaces;
package SPARKNaCl.Random
  with SPARK_Mode => On,
       Abstract_State => (Entropy with External => Async_Writers)
is
   --===========================
   --  Exported subprograms
   --===========================

   function Random_Byte return Interfaces.Unsigned_8
     with Global => Entropy,
          Volatile_Function;

   procedure Random_Bytes (R : out Byte_Seq)
     with Global => Entropy;

end SPARKNaCl.Random;

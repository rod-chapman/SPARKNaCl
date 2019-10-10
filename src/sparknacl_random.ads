with Interfaces;
package SPARKNaCl_Random
  with SPARK_Mode => On,
       Abstract_State => (Entropy with External => Async_Writers)
is

   function Random_Byte return Interfaces.Unsigned_8
     with Global => Entropy,
          Volatile_Function;
end SPARKNaCl_Random;

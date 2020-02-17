private package SPARKNaCl.Car2
  with SPARK_Mode => On
is
   --=================================================
   --  Further implementations of the main "Carry"
   --  function, based on Donenfeld's implementation
   --  in WireGuard.
   --
   --  These are for reference, and experimentation
   --  with additional proof techniques.
   --=================================================

   --  Simple translation of Donenfeld's original C code from
   --  WireGuard.  Here for reference as an oracle for testing
   procedure Carry (R : in out GF);

   --  Supporting "*"
   function Product_To_Seminormal
    (X : in Product_GF)
       return Seminormal_GF
     with Global => null;

end SPARKNaCl.Car2;

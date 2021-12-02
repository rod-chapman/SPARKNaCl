package Q
is
   subtype I is Integer range 0 .. 15;
   type GF is array (I) of Integer;

   procedure Op (X : in out GF)
     with Pre => X'Initialized,
          Post => X'Initialized;
end Q;

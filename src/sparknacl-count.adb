package body SPARKNaCl.Count
is
   procedure Reset
   is
   begin
      GF_Add := 0;
      GF_Sub := 0;
      GF_Mul := 0;
      GF_Car := 0;
   end Reset;

end SPARKNaCl.Count;

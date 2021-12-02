package body Q
is

   procedure Op (X : in out GF)
   is
   begin
      -- This is rejected even if -gnata is NOT active
      pragma Assert (X'Initialized);

      X (1) := X (1) + 1;
   end Op;

end Q;

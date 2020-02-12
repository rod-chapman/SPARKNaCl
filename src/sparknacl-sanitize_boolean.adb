separate (SPARKNaCl)
procedure Sanitize_Boolean (R : out Boolean) is
begin
   R := False; --  Boolean'Pos (0)

   --  It seems an inspection point is not possible on R here, since
   --  it is passed by copy in a register
   --  pragma Inspection_Point (R); --  See RM H3.2 (9)

   --  Add target-dependent code here to
   --  1. flush and invalidate data cache,
   --  2. wait until writes have committed (e.g. a memory-fence instruction)
   --  3. whatever else is required.
end Sanitize_Boolean;

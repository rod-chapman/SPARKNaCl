package body SPARKNaCl.Hashing
  with SPARK_Mode => On
is
   pragma Warnings (GNATProve, Off, "pragma * ignored (not yet supported)");

   function Big_Endian_Unpack (Input : in U64) return Bytes_8
   is
      Output : Bytes_8 with Relaxed_Initialization;
      X      : U64 := Input;
   begin
      Output (Output'Last) := Byte (X mod 256);

      pragma Assert (Output'Last = Index_8'Last);
      pragma Assert (Output (Output'Last)'Initialized);
      pragma Assert (Output (Output'Last) =
        Big_Endian_Get_Byte (Input, Index_8'Last));

      for I in reverse Index_8'First .. (Index_8'Last - 1) loop
         X := Shift_Right (X, 8);
         Output (I) := Byte (X mod 256);

         pragma Loop_Invariant (
           (X = Shift_Right (Input, Integer (Index_8'Last - I) * 8)) and then
           (Output (I .. Index_8'Last)'Initialized) and then
           (for all J in I .. Index_8'Last => Output (J) =
             Big_Endian_Get_Byte (Input, J)));
      end loop;

      return Output;
   end Big_Endian_Unpack;

   function Big_Endian_Get_Byte (Input : in U64;
                                 Index : in Index_8) return Byte
   is
      Shift_Amount  : constant Integer := Integer (Index_8'Last - Index) * 8;
      Shifted_Input : constant U64     := Shift_Right (Input, Shift_Amount);

      Result : constant Byte := Byte (Shifted_Input mod 256);
   begin
      return Result;
   end Big_Endian_Get_Byte;

end SPARKNaCl.Hashing;

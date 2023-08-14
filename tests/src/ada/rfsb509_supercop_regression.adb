with SPARKNaCl;                 use SPARKNaCl;
with SPARKNaCl.Hashing.RFSB509; use SPARKNaCl.Hashing.RFSB509;
with SPARKNaCl.AES;             use SPARKNaCl.AES;

with SUPERCOP_RFSB509_API; use SUPERCOP_RFSB509_API;

with Ada.Text_IO; use Ada.Text_IO;
with Random;

with Interfaces;   use Interfaces;
with Interfaces.C; use Interfaces.C;

procedure RFSB509_SUPERCOP_Regression
is
   Iteration_Count : constant I32 := 513;
   Start_Size      : constant I32 := 0;
   End_Size        : constant I32 := Start_Size + Iteration_Count - 1;

   Raw_Key : constant Bytes_16 := (others => 0);
   Key     : constant AES128_Key := Construct (Raw_Key); 

   SPARKNaCl_Output : Digest;
   SUPERCOP_Output  : Digest;

   SUPERCOP_Return_Value : Interfaces.C.Int; 
begin
   Put_Line ("Regression testing RFSB509 with random inputs of size");
   Put (Start_Size'Img & " to "  & End_Size'Img & " in bytes: ");

   for I in 1 .. Iteration_Count loop
      declare
         Input_Length : constant I32 := Start_Size + I - 1;
      
         subtype Input_Index is N32 range 1 .. Input_Length;
         Input : Byte_Seq (Input_Index);
      begin
         Random.Random_Bytes (Input);
         
         Hash (SPARKNaCl_Output, Input, Key);
         SUPERCOP_Return_Value := SUPERCOP_RFSB509_Hash (
           SUPERCOP_Output, Input, Unsigned_64 (Input_Length));

         pragma Assert (SUPERCOP_Return_Value = 0);

         if not Equal (SPARKNaCl_Output, SUPERCOP_Output) then
            Put_Line ("Regression test " & I'Img & " failed.");
            exit;
         end if; 
      end;
   end loop;

   Put_Line ("Done");
end RFSB509_SUPERCOP_Regression;

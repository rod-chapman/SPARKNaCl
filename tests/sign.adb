with SPARKNaCl;       use SPARKNaCl;
with SPARKNaCl.Debug; use SPARKNaCl.Debug;
with SPARKNaCl.Sign;  use SPARKNaCl.Sign;
with Ada.Text_IO;     use Ada.Text_IO;
with Interfaces;      use Interfaces;
with Random;
procedure Sign
is
   Raw_SK : Bytes_32;
   PK     : Signing_PK;
   SK     : Signing_SK;

   M : constant Byte_Seq (0 .. 255) := (0 => 16#55#, others => 16#aa#);

   SM : Byte_Seq (0 .. 319) := (others => 0);
   M2 : Byte_Seq (0 .. 319) := (others => 0);
   M3 : Byte_Seq (0 .. 255);

   ML : I32;
   S  : Boolean;
--   I  : I64 := 1;
begin
--   loop
--      Put_Line ("Iteration " & I'Img);
      Random.Random_Bytes (Raw_SK);
      Keypair (Raw_SK, PK, SK);

      begin
         Sign (SM, M, SK);
      exception
         when Constraint_Error =>
            Debug.DH ("In Sign, SK was ", Serialize (SK));
            raise;
      end;

      begin
         Open (M2, S, ML, SM, PK);
      exception
         when Constraint_Error =>
            Debug.DH ("In Open, PK was ", Serialize (PK));
            Debug.DH ("In Open, SM was ", SM);
            raise;
      end;

      M3 := M2 (0 .. 255);

--      I := I + 1;
      DH ("M3 is ", M3);
      Put_Line ("Status is " & Img (S));
      Put_Line ("ML is " & ML'Img);
--   end loop;
end Sign;

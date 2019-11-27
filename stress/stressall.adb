with GF_Stress;
with Car_Stress;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with GNAT.Traceback.Symbolic; use GNAT.Traceback.Symbolic;

procedure Stressall
is
begin
--   Put_Line ("Car Stress");
--   Car_Stress;
   Put_Line ("GF Stress");
   GF_Stress;
exception
   when E : others =>
      Put_Line (Exception_Message (E));
      Put_Line (Exception_Information (E));
      Put_Line (Symbolic_Traceback (E));
end Stressall;

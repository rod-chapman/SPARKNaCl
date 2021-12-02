with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
procedure GenM
is
   S    : Integer;
   ESums : Integer;
   ASums : Integer;
begin
   for L in Integer range 0 .. 15 loop
      Put ("L");
      Put (L, Width => 0);
      Put (" : GF_Normal_Limb renames Left (");
      Put (L, Width => 0);
      Put_Line (");");
      Put ("R");
      Put (L, Width => 0);
      Put (" : GF_Normal_Limb renames Right (");
      Put (L, Width => 0);
      Put_Line (");");
   end loop;
   Put_Line ("begin");

   for K in Integer range 0 .. 30 loop
      if K <= 15 then
         ESums := K;
      else
         ESums := 30 - K;
      end if;

      Put ("T (");
      Put (K, Width => 0);
      Put (") := ");
      ASums := 0;
      for I in Integer range 0 .. 15 loop
         for J in Integer range 0 .. 15 loop
            S := I + J;
            if S = K then
               Put ("L");
               Put (I, Width => 0);
               Put (" * R");
               Put (J, Width => 0);
               if ASums = ESums then
                  Put (";");
               else
                  Put (" + ");
                  ASums := ASums + 1;
               end if;
            end if;

         end loop;
      end loop;
      New_Line;
      Put ("pragma Assert (T (");
      Put (K, Width => 0);
      Put (")'Initialized and then T (");
      Put (K, Width => 0);
      Put (") in 0 .. MGFLP * ");
      Put (ESums + 1, Width => 0);
      Put (")");
      New_Line;
   end loop;


end GenM;

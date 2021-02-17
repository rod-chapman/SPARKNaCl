with Ada.Text_IO; use Ada.Text_IO;
package body SPARKNaCl.PDebug
is
   On : constant Boolean := True;

   package I64IO is new Ada.Text_IO.Integer_IO (Integer_64);

   procedure DH16 (S : in String; D : in Normal_GF)
   is
   begin
      if On then
         Put_Line (S);
         for I in D'Range loop
            I64IO.Put (I64 (D (I)), Width => 0);
            Put (' ');
            I64IO.Put (I64 (D (I)), Width => 0, Base => 16);
            New_Line;
         end loop;
      end if;
   end DH16;

   procedure DH32 (S : in String; D : in GF32)
   is
   begin
      if On then
         Put_Line (S);
         for I in D'Range loop
            I64IO.Put (I64 (D (I)), Width => 0);
            Put (' ');
            I64IO.Put (I64 (D (I)), Width => 0, Base => 16);
            New_Line;
         end loop;
      end if;
   end DH32;

   procedure DH64 (S : in String; D : in GF64)
   is
   begin
      if On then
         Put_Line (S);
         for I in D'Range loop
            I64IO.Put (D (I), Width => 0);
            Put (' ');
            I64IO.Put (D (I), Width => 0, Base => 16);
            New_Line;
         end loop;
      end if;
   end DH64;


end SPARKNaCl.PDebug;

with HAL;        use HAL;
with SPARKNaCl;  use SPARKNaCl;
with Interfaces; use Interfaces;
package IO is

   procedure Put (X : Integer);
   --  Output integer to specified file, or to current output file, same
   --  output as if Ada.Text_IO.Integer_IO had been instantiated for Integer.

   procedure Put (X : UInt64);

   procedure Put (C : Character);
   --  Output character to specified file, or to current output file

   procedure Put (S : String);
   --  Output string to specified file, or to current output file

   procedure Put_Line (S : String);
   --  Output string followed by new line to stdout

   procedure Put_Line (S : String; X : Unsigned_64);
   --  Output string followed by X, then new line to stdout

   procedure New_Line (Spacing : Positive := 1);
   --  Output new line character to specified file, or to current output file

   procedure Put (B : in Byte);

   procedure Put (S : in String; D : in Byte_Seq);

end IO;

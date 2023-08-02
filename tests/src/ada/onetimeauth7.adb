with SPARKNaCl;       use SPARKNaCl;
with SPARKNaCl.Debug; use SPARKNaCl.Debug;
with SPARKNaCl.MAC;   use SPARKNaCl.MAC;

with Random;
with Interfaces;      use Interfaces;
with Ada.Numerics.Discrete_Random;
procedure Onetimeauth7
is
   package RB is new Ada.Numerics.Discrete_Random (Byte);
   package RBI16 is new Ada.Numerics.Discrete_Random (Index_16);
   RBG    : RB.Generator;
   RBI16G : RBI16.Generator;
   Raw_K  : Bytes_32;
   K      : Poly_1305_Key;
   A      : Bytes_16;
begin
   RB.Reset (RBG);
   RBI16.Reset (RBI16G);
--   for I in N32 range 0 .. 9999 loop
   for I in N32 range 0 .. 99 loop
      declare
         subtype C_Index is N32 range 0 .. I;
         subtype CT is Byte_Seq (C_Index);
         package RCI is new Ada.Numerics.Discrete_Random (C_Index);
         RCIG : RCI.Generator;
         C : CT;
         R1 : C_Index;
         R2 : Byte;
         R3 : Index_16;
      begin
         RCI.Reset (RCIG);
         Random.Random_Bytes (C);
         Random.Random_Bytes (Raw_K);
         Construct (K, Raw_K);
         Onetimeauth (A, C, K);
         if not Onetimeauth_Verify (A, C, K) then
            DH ("Fail ", I64 (I));
            return;
         end if;
         R1 := RCI.Random (RCIG);
         R2 := RB.Random (RBG) mod 255;
         C (R1) := C (R1) + 1 + R2;
         if Onetimeauth_Verify (A, C, K) then
            DH ("Forgery", I64 (I));
            return;
         end if;

         R2 := RB.Random (RBG) mod 255;
         R3 := RBI16.Random (RBI16G);
         A (R3) := A (R3) + 1 + R2;
         if Onetimeauth_Verify (A, C, K) then
            DH ("Forgery", I64 (I));
            return;
         end if;
      end;
   end loop;
end Onetimeauth7;

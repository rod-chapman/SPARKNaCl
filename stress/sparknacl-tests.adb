with SPARKNaCl.Debug;
with SPARKNaCl.Utils;
with Ada.Text_IO; use Ada.Text_IO;
package body SPARKNaCl.Tests
is
   procedure GF_Stress
   is
      A, B, C : GF;
   begin
      Put_Line ("GF_Stress case 1 - 0 * 0");
      A := (others => 0);
      B := (others => 0);
      C := A * B;
      Debug.DH ("Result is", C);

      Put_Line ("GF_Stress case 2 - FFFF * FFFF");
      A := (others => 16#FFFF#);
      B := (others => 16#FFFF#);
      C := A * B;
      Debug.DH ("Result is", C);

   end GF_Stress;

   procedure Car_Stress
   is
      A, B : GF;
      X : constant SPARKNaCl.I64 := -65535;
   begin
      Debug.DH ("ASR_16(-65535) is ", ASR_16 (X));
      Debug.DH ("ASR_16(-65536) is ", ASR_16 (X - 1));
      Debug.DH ("ASR_16(131070) is ", ASR_16 (131070));
      Debug.DH ("-65535 mod 65536 is ", X mod 65536);
      Debug.DH ("-65536 mod 65536 is ", (X - 1) mod 65536);

      A := (others => 131070);
      Debug.DH ("A is", A);
      Utils.Car_25519 (A);
      Debug.DH ("A1 is", A);
      Utils.Car_25519 (A);
      Debug.DH ("A2 is", A);

--      B := (others => -65535);
--      Debug.DH ("B is", B);
--      Utils.Car_25519 (B);
--      Debug.DH ("B1 is", B);
--      Utils.Car_25519 (B);
--      Debug.DH ("B2 is", B);
   end Car_Stress;
end SPARKNaCl.Tests;

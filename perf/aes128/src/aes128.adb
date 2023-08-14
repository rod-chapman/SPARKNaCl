with HAL; use HAL;

with FE310;
with FE310.CLINT;
with FE310.Time;                use FE310.Time;
with FE310.Performance_Monitor; use FE310.Performance_Monitor;

with RISCV.CSR; use RISCV.CSR;

with SPARKNaCl;     use SPARKNaCl;
with SPARKNaCl.AES; use SPARKNaCl.AES;

with IO;

procedure AES128 is
   T1, T2     : UInt64;
   Total_Time : UInt64;

   CPU_Hz1, CPU_Hz2 : UInt32;

   --  ECB GFSbox 128 Count 0
   Plaintext : constant Bytes_16 := (
     16#f3#, 16#44#, 16#81#, 16#ec#, 16#3c#, 16#c6#, 16#27#, 16#ba#,
     16#cd#, 16#5d#, 16#c3#, 16#fb#, 16#08#, 16#f2#, 16#73#, 16#e6#);

   Result : Bytes_16;

   Key_Raw    : constant Bytes_16 := (others => 0);
   Key        : constant AES128_Key := Construct (Key_Raw);
   Round_Keys : constant AES128_Round_Keys := Key_Expansion (Key);

   procedure Report;

   procedure Report
   is
   begin
      IO.Put      ("Total:           ");
      IO.Put      (Total_Time);
      IO.Put_Line (" cycles");
   end Report;
begin
   CPU_Hz1 := FE310.CPU_Frequency;

   --  The SPI flash clock divider should be as small as possible to increase
   --  the execution speed of instructions that are not yet in the instruction
   --  cache.
   FE310.Set_SPI_Flash_Clock_Divider (2);

   --  Load the internal oscillator factory calibration to be sure it
   --  oscillates at a known frequency.
   FE310.Load_Internal_Oscilator_Calibration;

   --  Use the HiFive1 16 MHz crystal oscillator which is more acurate than the
   --  internal oscillator.
   FE310.Use_Crystal_Oscillator;

   CPU_Hz2 := FE310.CPU_Frequency;

   IO.Put_Line ("CPU Frequency reset was: ", U64 (CPU_Hz1));
   IO.Put_Line ("CPU Frequency now is:    ", U64 (CPU_Hz2));

   FE310.Performance_Monitor.Set_Commit_Events (3, No_Commit_Events);
   FE310.Performance_Monitor.Set_Commit_Events (4, No_Commit_Events);

   T1 := FE310.CLINT.Machine_Time;
   T2 := FE310.CLINT.Machine_Time;
   IO.Put_Line ("Null timing test:", U64 (T2 - T1));

   T1 := Mcycle.Read;
   Delay_S (1);
   T2 := Mcycle.Read;
   IO.Put_Line ("One second test (CYCLE):  ", U64 (T2 - T1));

   T1 := Minstret.Read;
   Delay_S (1);
   T2 := Minstret.Read;
   IO.Put_Line ("One second test (INSTRET):", U64 (T2 - T1));

   T1 := FE310.CLINT.Machine_Time;
   Delay_S (1);
   T2 := FE310.CLINT.Machine_Time;
   IO.Put_Line ("One second test (CLINT):  ", U64 (T2 - T1));

   IO.New_Line;
   IO.Put_Line ("SPARKNaCl.AES128 Cipher test");

   T1 := Mcycle.Read;
   SPARKNaCl.AES.Cipher (Result, Plaintext, Round_Keys);
   T2 := Mcycle.Read;
   Total_Time := T2 - T1;
   Report;

end AES128;

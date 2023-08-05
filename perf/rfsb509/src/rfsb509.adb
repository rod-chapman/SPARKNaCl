with HAL; use HAL;

with FE310;
with FE310.CLINT;
with FE310.Time;                use FE310.Time;
with FE310.Performance_Monitor; use FE310.Performance_Monitor;

with RISCV.CSR; use RISCV.CSR;

with SPARKNaCl;                 use SPARKNaCl;
with SPARKNaCl.Hashing.RFSB509; use SPARKNaCl.Hashing.RFSB509;
with SPARKNaCl.AES;             use SPARKNaCl.AES;

with IO;

procedure RFSB509 is
   T1, T2     : UInt64;
   Total_Time : UInt64;

   CPU_Hz1, CPU_Hz2 : UInt32;

   Output : Digest;
   Input  : constant Byte_Seq (0 .. 1023) := (others => 77);

   Key_Raw : constant Bytes_16 := (others => 0);
   Key     : constant AES128_Key := AES.Construct (Key_Raw);

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
   IO.Put_Line ("SPARKNaCl.Hashing.RFSB509 test");

   T1 := Mcycle.Read;
   Hashing.RFSB509.Hash (Output, Input, Key);
   T2 := Mcycle.Read;
   Total_Time := T2 - T1;
   Report;

end RFSB509;

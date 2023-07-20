package body SPARKNaCl.AES256
  with Pure,
       SPARK_Mode => On
is
   --------------------------------------------------------
   --  Local constant definitions
   --------------------------------------------------------

   Number_Of_Rounds : constant I32 := 14;
   Words_Per_Key    : constant I32 := 8;

   pragma Assert (AES256_Key_Array'Length = Words_Per_Key);

   SBox : constant Bytes_256 := (
     16#63#, 16#7c#, 16#77#, 16#7b#, 16#f2#, 16#6b#, 16#6f#, 16#c5#,
     16#30#, 16#01#, 16#67#, 16#2b#, 16#fe#, 16#d7#, 16#ab#, 16#76#, -- 0x0Y
     16#ca#, 16#82#, 16#c9#, 16#7d#, 16#fa#, 16#59#, 16#47#, 16#f0#,
     16#ad#, 16#d4#, 16#a2#, 16#af#, 16#9c#, 16#a4#, 16#72#, 16#c0#, -- 0x1Y
     16#b7#, 16#fd#, 16#93#, 16#26#, 16#36#, 16#3f#, 16#f7#, 16#cc#,
     16#34#, 16#a5#, 16#e5#, 16#f1#, 16#71#, 16#d8#, 16#31#, 16#15#, -- 0x2Y
     16#04#, 16#c7#, 16#23#, 16#c3#, 16#18#, 16#96#, 16#05#, 16#9a#,
     16#07#, 16#12#, 16#80#, 16#e2#, 16#eb#, 16#27#, 16#b2#, 16#75#, -- 0x3Y
     16#09#, 16#83#, 16#2c#, 16#1a#, 16#1b#, 16#6e#, 16#5a#, 16#a0#,
     16#52#, 16#3b#, 16#d6#, 16#b3#, 16#29#, 16#e3#, 16#2f#, 16#84#, -- 0x4Y
     16#53#, 16#d1#, 16#00#, 16#ed#, 16#20#, 16#fc#, 16#b1#, 16#5b#,
     16#6a#, 16#cb#, 16#be#, 16#39#, 16#4a#, 16#4c#, 16#58#, 16#cf#, -- 0x5Y
     16#d0#, 16#ef#, 16#aa#, 16#fb#, 16#43#, 16#4d#, 16#33#, 16#85#,
     16#45#, 16#f9#, 16#02#, 16#7f#, 16#50#, 16#3c#, 16#9f#, 16#a8#, -- 0x6Y
     16#51#, 16#a3#, 16#40#, 16#8f#, 16#92#, 16#9d#, 16#38#, 16#f5#,
     16#bc#, 16#b6#, 16#da#, 16#21#, 16#10#, 16#ff#, 16#f3#, 16#d2#, -- 0x7Y
     16#cd#, 16#0c#, 16#13#, 16#ec#, 16#5f#, 16#97#, 16#44#, 16#17#,
     16#c4#, 16#a7#, 16#7e#, 16#3d#, 16#64#, 16#5d#, 16#19#, 16#73#, -- 0x8Y
     16#60#, 16#81#, 16#4f#, 16#dc#, 16#22#, 16#2a#, 16#90#, 16#88#,
     16#46#, 16#ee#, 16#b8#, 16#14#, 16#de#, 16#5e#, 16#0b#, 16#db#, -- 0x9Y
     16#e0#, 16#32#, 16#3a#, 16#0a#, 16#49#, 16#06#, 16#24#, 16#5c#,
     16#c2#, 16#d3#, 16#ac#, 16#62#, 16#91#, 16#95#, 16#e4#, 16#79#, -- 0xaY
     16#e7#, 16#c8#, 16#37#, 16#6d#, 16#8d#, 16#d5#, 16#4e#, 16#a9#,
     16#6c#, 16#56#, 16#f4#, 16#ea#, 16#65#, 16#7a#, 16#ae#, 16#08#, -- 0xbY
     16#ba#, 16#78#, 16#25#, 16#2e#, 16#1c#, 16#a6#, 16#b4#, 16#c6#,
     16#e8#, 16#dd#, 16#74#, 16#1f#, 16#4b#, 16#bd#, 16#8b#, 16#8a#, -- 0xcY
     16#70#, 16#3e#, 16#b5#, 16#66#, 16#48#, 16#03#, 16#f6#, 16#0e#,
     16#61#, 16#35#, 16#57#, 16#b9#, 16#86#, 16#c1#, 16#1d#, 16#9e#, -- 0xdY
     16#e1#, 16#f8#, 16#98#, 16#11#, 16#69#, 16#d9#, 16#8e#, 16#94#,
     16#9b#, 16#1e#, 16#87#, 16#e9#, 16#ce#, 16#55#, 16#28#, 16#df#, -- 0xeY
     16#8c#, 16#a1#, 16#89#, 16#0d#, 16#bf#, 16#e6#, 16#42#, 16#68#,
     16#41#, 16#99#, 16#2d#, 16#0f#, 16#b0#, 16#54#, 16#bb#, 16#16#); -- 0xfY

   Inv_SBox : constant Bytes_256 := (
     16#52#, 16#09#, 16#6a#, 16#d5#, 16#30#, 16#36#, 16#a5#, 16#38#,
     16#bf#, 16#40#, 16#a3#, 16#9e#, 16#81#, 16#f3#, 16#d7#, 16#fb#, -- 0x0Y
     16#7c#, 16#e3#, 16#39#, 16#82#, 16#9b#, 16#2f#, 16#ff#, 16#87#,
     16#34#, 16#8e#, 16#43#, 16#44#, 16#c4#, 16#de#, 16#e9#, 16#cb#, -- 0x1Y
     16#54#, 16#7b#, 16#94#, 16#32#, 16#a6#, 16#c2#, 16#23#, 16#3d#,
     16#ee#, 16#4c#, 16#95#, 16#0b#, 16#42#, 16#fa#, 16#c3#, 16#4e#, -- 0x2Y
     16#08#, 16#2e#, 16#a1#, 16#66#, 16#28#, 16#d9#, 16#24#, 16#b2#,
     16#76#, 16#5b#, 16#a2#, 16#49#, 16#6d#, 16#8b#, 16#d1#, 16#25#, -- 0x3Y
     16#72#, 16#f8#, 16#f6#, 16#64#, 16#86#, 16#68#, 16#98#, 16#16#,
     16#d4#, 16#a4#, 16#5c#, 16#cc#, 16#5d#, 16#65#, 16#b6#, 16#92#, -- 0x4Y
     16#6c#, 16#70#, 16#48#, 16#50#, 16#fd#, 16#ed#, 16#b9#, 16#da#,
     16#5e#, 16#15#, 16#46#, 16#57#, 16#a7#, 16#8d#, 16#9d#, 16#84#, -- 0x5Y
     16#90#, 16#d8#, 16#ab#, 16#00#, 16#8c#, 16#bc#, 16#d3#, 16#0a#,
     16#f7#, 16#e4#, 16#58#, 16#05#, 16#b8#, 16#b3#, 16#45#, 16#06#, -- 0x6Y
     16#d0#, 16#2c#, 16#1e#, 16#8f#, 16#ca#, 16#3f#, 16#0f#, 16#02#,
     16#c1#, 16#af#, 16#bd#, 16#03#, 16#01#, 16#13#, 16#8a#, 16#6b#, -- 0x7Y
     16#3a#, 16#91#, 16#11#, 16#41#, 16#4f#, 16#67#, 16#dc#, 16#ea#,
     16#97#, 16#f2#, 16#cf#, 16#ce#, 16#f0#, 16#b4#, 16#e6#, 16#73#, -- 0x8Y
     16#96#, 16#ac#, 16#74#, 16#22#, 16#e7#, 16#ad#, 16#35#, 16#85#,
     16#e2#, 16#f9#, 16#37#, 16#e8#, 16#1c#, 16#75#, 16#df#, 16#6e#, -- 0x9Y
     16#47#, 16#f1#, 16#1a#, 16#71#, 16#1d#, 16#29#, 16#c5#, 16#89#,
     16#6f#, 16#b7#, 16#62#, 16#0e#, 16#aa#, 16#18#, 16#be#, 16#1b#, -- 0xaY
     16#fc#, 16#56#, 16#3e#, 16#4b#, 16#c6#, 16#d2#, 16#79#, 16#20#,
     16#9a#, 16#db#, 16#c0#, 16#fe#, 16#78#, 16#cd#, 16#5a#, 16#f4#, -- 0xbY
     16#1f#, 16#dd#, 16#a8#, 16#33#, 16#88#, 16#07#, 16#c7#, 16#31#,
     16#b1#, 16#12#, 16#10#, 16#59#, 16#27#, 16#80#, 16#ec#, 16#5f#, -- 0xcY
     16#60#, 16#51#, 16#7f#, 16#a9#, 16#19#, 16#b5#, 16#4a#, 16#0d#,
     16#2d#, 16#e5#, 16#7a#, 16#9f#, 16#93#, 16#c9#, 16#9c#, 16#ef#, -- 0xdY
     16#a0#, 16#e0#, 16#3b#, 16#4d#, 16#ae#, 16#2a#, 16#f5#, 16#b0#,
     16#c8#, 16#eb#, 16#bb#, 16#3c#, 16#83#, 16#53#, 16#99#, 16#61#, -- 0xeY
     16#17#, 16#2b#, 16#04#, 16#7e#, 16#ba#, 16#77#, 16#d6#, 16#26#,
     16#e1#, 16#69#, 16#14#, 16#63#, 16#55#, 16#21#, 16#0c#, 16#7d#); -- 0xfY

   --------------------------------------------------------
   --  Local type definitions
   --------------------------------------------------------

   subtype State_Column       is U32;
   subtype State_Column_Index is Index_4;
   type State_Array           is array (State_Column_Index) of State_Column;

   subtype Round_Key       is U32_Seq (Index_4);
   subtype Round_Key_Index is I32 range 0 .. Number_Of_Rounds;
   type Round_Key_Array    is array (Round_Key_Index) of Round_Key;

   --------------------------------------------------------
   --  Local subprogram declarations
   --------------------------------------------------------

   procedure Big_Endian_Unpack (Output :    out Bytes_4;
                                Input  : in     U32)
     with Global => null,
          Pre    => (Output'First = 0) and (Output'Last = 3);

   function Big_Endian_Pack (Input : in Bytes_4) return U32
     with Global => null,
          Pre    => (Input'First = 0) and (Input'Last = 3);

   function Key_Expansion (Key : in AES256_Key) return Round_Key_Array
     with Global => null;

   function Construct_State (Input : in Bytes_16) return State_Array
     with Global => null;

   function Serialize_State (State : in State_Array) return Bytes_16
     with Global => null;

   procedure Add_Round_Key (State : in out State_Array;
                            Key   : in     Round_Key)
     with Global => null;

   procedure Sub_Bytes (State : in out State_Array)
     with Global => null;

   procedure Inv_Sub_Bytes (State : in out State_Array)
     with Global => null;

   procedure Shift_Rows (State : in out State_Array)
     with Global => null;

   procedure Inv_Shift_Rows (State : in out State_Array)
     with Global => null;

   function Multiply (X : in Byte;
                      Y : in Byte) return Byte
     with Global => null;

   procedure Mix_Columns (State : in out State_Array)
     with Global => null;

   procedure Inv_Mix_Columns (State : in out State_Array)
     with Global => null;

   procedure Cipher (Output :    out Bytes_16;
                     Input  : in     Bytes_16;
                     Key    : in     AES256_Key)
     with Global => null;

   procedure Inv_Cipher (Output :    out Bytes_16;
                         Input  : in     Bytes_16;
                         Key    : in     AES256_Key)
     with Global => null;

   --------------------------------------------------------
   --  Local subprogram bodies
   --------------------------------------------------------

   procedure Big_Endian_Unpack (Output :    out Bytes_4;
                                Input  : in     U32)
   is
      LSByte_Mask : constant U32 := 16#00_00_00_ff#;

      Result : Bytes_4 with Relaxed_Initialization;

      Shift_Amount  : Integer;
      Shifted_Input : U32;
   begin
      for I in Result'Range loop
         Shift_Amount  := Integer ((Output'Last - I) * Byte'Size);
         Shifted_Input := Shift_Right (Input, Shift_Amount);
         Result (I)    := Byte (Shifted_Input and LSByte_Mask);

         pragma Loop_Invariant (Result (Result'First .. I)'Initialized);
      end loop;

      Output := Result;
   end Big_Endian_Unpack;

   function Big_Endian_Pack (Input : in Bytes_4) return U32
   is
      A, B, C, D : U32;
      Result     : U32;
   begin
      A := Shift_Left (U32 (Input (0)), 3 * Byte'Size);
      B := Shift_Left (U32 (Input (1)), 2 * Byte'Size);
      C := Shift_Left (U32 (Input (2)), 1 * Byte'Size);
      D := Shift_Left (U32 (Input (3)), 0 * Byte'Size);

      A := A or B;
      C := C or D;

      Result := A or C;
      return Result;
   end Big_Endian_Pack;

   function Key_Expansion (Key : in AES256_Key) return Round_Key_Array
   is
      Round_Keys : Round_Key_Array with Relaxed_Initialization;
      Key_Index  : Round_Key_Index := Round_Key_Index'First;

      Rcon : U32 := 16#01_00_00_00#;

      A : Round_Key :=
        Key.F (Key.F'First .. Key.F'First + Round_Key'Length - 1);
      B : Round_Key :=
        Key.F (Key.F'Last - (Round_Key'Length - 1) .. Key.F'Last);

      function Sub_Word (Word : in U32) return U32
        with Global => null;

      procedure Round_Key_CumSum (X : in out Round_Key)
        with Global => null;

      function Sub_Word (Word : in U32) return U32
      is
         Result : U32;
         Bytes  : Bytes_4;
      begin
         Big_Endian_Unpack (Bytes, Word);

         for I in Bytes'Range loop
            Bytes (I) := SBox (Index_256 (Bytes (I)));
         end loop;

         Result := Big_Endian_Pack (Bytes);
         return Result;
      end Sub_Word;

      procedure Round_Key_CumSum (X : in out Round_Key)
      is
      begin
         X (X'First + 1) := X (X'First + 1) xor X (X'First);
         X (X'First + 2) := X (X'First + 2) xor X (X'First + 1);
         X (X'First + 3) := X (X'First + 3) xor X (X'First + 2);
      end Round_Key_CumSum;
   begin
      Round_Keys (Key_Index) := A;

      Key_Index              := Round_Key_Index'Succ (Key_Index);
      Round_Keys (Key_Index) := B;

      loop
         pragma Loop_Variant (Increases => Key_Index);
         pragma Loop_Invariant (
           (Key_Index < Round_Key_Index'Last) and
           (((Round_Key_Index'Last - Key_Index) mod 2) = 1) and
           (Round_Keys (Round_Key_Index'First .. Key_Index)'Initialized));

         A (A'First) := A (A'First) xor
           Sub_Word (Rotate_Left (B (B'Last), Byte'Size)) xor Rcon;
         Round_Key_CumSum (A);

         Rcon := Shift_Left (Rcon, 1);

         Key_Index              := Round_Key_Index'Succ (Key_Index);
         Round_Keys (Key_Index) := A;
         exit when Key_Index = Round_Key_Index'Last;

         B (B'First) := B (B'First) xor Sub_Word (A (A'Last));
         Round_Key_CumSum (B);

         Key_Index              := Round_Key_Index'Succ (Key_Index);
         Round_Keys (Key_Index) := B;
      end loop;

      pragma Assert (Key_Index = Round_Key_Index'Last);

      return Round_Keys;
   end Key_Expansion;

   function Construct_State (Input : in Bytes_16) return State_Array
   is
      State : State_Array;
   begin
      for I in State_Array'Range loop
         State (I) := Big_Endian_Pack (Input (4 * I .. 4 * I + 3));
      end loop;

      return State;
   end Construct_State;

   function Serialize_State (State : in State_Array) return Bytes_16
   is
      Result : Bytes_16 with Relaxed_Initialization;
   begin
      pragma Assert (Result'First = State'First);
      pragma Assert (Result'First = 0);

      for I in State_Array'Range loop
         Big_Endian_Unpack (Result (4 * I .. 4 * I + 3), State (I));

         pragma Loop_Invariant (
           Result (Result'First .. Result'First + 4 * I + 3)'Initialized);
      end loop;

      return Result;
   end Serialize_State;

   procedure Add_Round_Key (State : in out State_Array;
                            Key   : in     Round_Key)
   is
   begin
      for I in State'Range loop
         State (I) := State (I) xor Key (I);
      end loop;
   end Add_Round_Key;

   procedure Sub_Bytes (State : in out State_Array)
   is
      Column : Bytes_4;
   begin
      for I in State'Range loop
         Big_Endian_Unpack (Column, State (I));

         for J in Column'Range loop
            Column (J) := SBox (Index_256 (Column (J)));
         end loop;

         State (I) := Big_Endian_Pack (Column);
      end loop;
   end Sub_Bytes;

   procedure Inv_Sub_Bytes (State : in out State_Array)
   is
      Column : Bytes_4;
   begin
      for I in State'Range loop
         Big_Endian_Unpack (Column, State (I));

         for J in Column'Range loop
            Column (J) := Inv_SBox (Index_256 (Column (J)));
         end loop;

         State (I) := Big_Endian_Pack (Column);
      end loop;
   end Inv_Sub_Bytes;

   procedure Shift_Rows (State : in out State_Array)
   is
      Column_Old : Bytes_4;

      Column_0, Column_1 : Bytes_4 with Relaxed_Initialization;
      Column_2, Column_3 : Bytes_4 with Relaxed_Initialization;
   begin
      Big_Endian_Unpack (Column_Old, State (State'First + 0));
      Column_0 (0) := Column_Old (0);
      Column_3 (1) := Column_Old (1);
      Column_2 (2) := Column_Old (2);
      Column_1 (3) := Column_Old (3);

      Big_Endian_Unpack (Column_Old, State (State'First + 1));
      Column_1 (0) := Column_Old (0);
      Column_0 (1) := Column_Old (1);
      Column_3 (2) := Column_Old (2);
      Column_2 (3) := Column_Old (3);

      Big_Endian_Unpack (Column_Old, State (State'First + 2));
      Column_2 (0) := Column_Old (0);
      Column_1 (1) := Column_Old (1);
      Column_0 (2) := Column_Old (2);
      Column_3 (3) := Column_Old (3);

      Big_Endian_Unpack (Column_Old, State (State'First + 3));
      Column_3 (0) := Column_Old (0);
      Column_2 (1) := Column_Old (1);
      Column_1 (2) := Column_Old (2);
      Column_0 (3) := Column_Old (3);

      State (State'First + 0) := Big_Endian_Pack (Column_0);
      State (State'First + 1) := Big_Endian_Pack (Column_1);
      State (State'First + 2) := Big_Endian_Pack (Column_2);
      State (State'First + 3) := Big_Endian_Pack (Column_3);
   end Shift_Rows;

   procedure Inv_Shift_Rows (State : in out State_Array)
   is
      Column_Old : Bytes_4;

      Column_0, Column_1 : Bytes_4 with Relaxed_Initialization;
      Column_2, Column_3 : Bytes_4 with Relaxed_Initialization;
   begin
      Big_Endian_Unpack (Column_Old, State (State'First + 0));
      Column_0 (0) := Column_Old (0);
      Column_1 (1) := Column_Old (1);
      Column_2 (2) := Column_Old (2);
      Column_3 (3) := Column_Old (3);

      Big_Endian_Unpack (Column_Old, State (State'First + 1));
      Column_1 (0) := Column_Old (0);
      Column_2 (1) := Column_Old (1);
      Column_3 (2) := Column_Old (2);
      Column_0 (3) := Column_Old (3);

      Big_Endian_Unpack (Column_Old, State (State'First + 2));
      Column_2 (0) := Column_Old (0);
      Column_3 (1) := Column_Old (1);
      Column_0 (2) := Column_Old (2);
      Column_1 (3) := Column_Old (3);

      Big_Endian_Unpack (Column_Old, State (State'First + 3));
      Column_3 (0) := Column_Old (0);
      Column_0 (1) := Column_Old (1);
      Column_1 (2) := Column_Old (2);
      Column_2 (3) := Column_Old (3);

      State (State'First + 0) := Big_Endian_Pack (Column_0);
      State (State'First + 1) := Big_Endian_Pack (Column_1);
      State (State'First + 2) := Big_Endian_Pack (Column_2);
      State (State'First + 3) := Big_Endian_Pack (Column_3);
   end Inv_Shift_Rows;

   function Multiply (X : in Byte;
                      Y : in Byte) return Byte
   is
      LSB_Mask : constant Byte := 2#0000_0001#;
      Product  : Byte := 0;
      A        : Byte := X;
      B        : Byte := Y;

      procedure X_Times (Input : in out Byte);

      procedure X_Times (Input : in out Byte)
      is
         Flag    : constant Byte := Shift_Right (Input, Byte'Size - 1);
         Summand : constant Byte := 2#0001_1011#;
      begin
         pragma Assert ((Flag = 0) or (Flag = 1));

         Input := Shift_Left (Input, 1);
         Input := Input xor (Summand * Flag);
      end X_Times;
   begin
      for I in 1 .. Byte'Size loop
         Product := Product xor (A * (B and LSB_Mask));

         X_Times (A);
         B := Shift_Right (B, 1);
      end loop;

      return Product;
   end Multiply;

   procedure Mix_Columns (State : in out State_Array)
   is
      procedure Matrix_Multiplication (Column : in out State_Column);

      procedure Matrix_Multiplication (Column : in out State_Column)
      is
         Old_Column_Bytes : Bytes_4;
         New_Column_Bytes : Bytes_4 with Relaxed_Initialization;

         Sum : Byte;
      begin
         Big_Endian_Unpack (Old_Column_Bytes, Column);

         Sum := Multiply (Old_Column_Bytes (0), 16#02#);
         Sum := Sum xor Multiply (Old_Column_Bytes (1), 16#03#);
         Sum := Sum xor Multiply (Old_Column_Bytes (2), 16#01#);
         Sum := Sum xor Multiply (Old_Column_Bytes (3), 16#01#);
         New_Column_Bytes (0) := Sum;

         Sum := Multiply (Old_Column_Bytes (0), 16#01#);
         Sum := Sum xor Multiply (Old_Column_Bytes (1), 16#02#);
         Sum := Sum xor Multiply (Old_Column_Bytes (2), 16#03#);
         Sum := Sum xor Multiply (Old_Column_Bytes (3), 16#01#);
         New_Column_Bytes (1) := Sum;

         Sum := Multiply (Old_Column_Bytes (0), 16#01#);
         Sum := Sum xor Multiply (Old_Column_Bytes (1), 16#01#);
         Sum := Sum xor Multiply (Old_Column_Bytes (2), 16#02#);
         Sum := Sum xor Multiply (Old_Column_Bytes (3), 16#03#);
         New_Column_Bytes (2) := Sum;

         Sum := Multiply (Old_Column_Bytes (0), 16#03#);
         Sum := Sum xor Multiply (Old_Column_Bytes (1), 16#01#);
         Sum := Sum xor Multiply (Old_Column_Bytes (2), 16#01#);
         Sum := Sum xor Multiply (Old_Column_Bytes (3), 16#02#);
         New_Column_Bytes (3) := Sum;

         Column := Big_Endian_Pack (New_Column_Bytes);
      end Matrix_Multiplication;
   begin
      for I in State'Range loop
         Matrix_Multiplication (State (I));
      end loop;
   end Mix_Columns;

   procedure Inv_Mix_Columns (State : in out State_Array)
   is
      procedure Matrix_Multiplication (Column : in out State_Column);

      procedure Matrix_Multiplication (Column : in out State_Column)
      is
         Old_Column_Bytes : Bytes_4;
         New_Column_Bytes : Bytes_4 with Relaxed_Initialization;
         Sum : Byte;
      begin
         Big_Endian_Unpack (Old_Column_Bytes, Column);

         Sum := Multiply (Old_Column_Bytes (0), 16#0e#);
         Sum := Sum xor Multiply (Old_Column_Bytes (1), 16#0b#);
         Sum := Sum xor Multiply (Old_Column_Bytes (2), 16#0d#);
         Sum := Sum xor Multiply (Old_Column_Bytes (3), 16#09#);
         New_Column_Bytes (0) := Sum;

         Sum := Multiply (Old_Column_Bytes (0), 16#09#);
         Sum := Sum xor Multiply (Old_Column_Bytes (1), 16#0e#);
         Sum := Sum xor Multiply (Old_Column_Bytes (2), 16#0b#);
         Sum := Sum xor Multiply (Old_Column_Bytes (3), 16#0d#);
         New_Column_Bytes (1) := Sum;

         Sum := Multiply (Old_Column_Bytes (0), 16#0d#);
         Sum := Sum xor Multiply (Old_Column_Bytes (1), 16#09#);
         Sum := Sum xor Multiply (Old_Column_Bytes (2), 16#0e#);
         Sum := Sum xor Multiply (Old_Column_Bytes (3), 16#0b#);
         New_Column_Bytes (2) := Sum;

         Sum := Multiply (Old_Column_Bytes (0), 16#0b#);
         Sum := Sum xor Multiply (Old_Column_Bytes (1), 16#0d#);
         Sum := Sum xor Multiply (Old_Column_Bytes (2), 16#09#);
         Sum := Sum xor Multiply (Old_Column_Bytes (3), 16#0e#);
         New_Column_Bytes (3) := Sum;

         Column := Big_Endian_Pack (New_Column_Bytes);
      end Matrix_Multiplication;
   begin
      for I in State'Range loop
         Matrix_Multiplication (State (I));
      end loop;
   end Inv_Mix_Columns;

   procedure Cipher (Output :    out Bytes_16;
                     Input  : in     Bytes_16;
                     Key    : in     AES256_Key)
   is
      Round_Keys : constant Round_Key_Array := Key_Expansion (Key);
      Key_Index  : Round_Key_Index := Round_Key_Index'First;

      State : State_Array := Construct_State (Input);
   begin
      Add_Round_Key (State, Round_Keys (Key_Index));
      Key_Index := Round_Key_Index'Succ (Key_Index);

      while Key_Index < Round_Key_Index'Last loop
         pragma Loop_Variant (Increases => Key_Index);

         Sub_Bytes (State);
         Shift_Rows (State);
         Mix_Columns (State);

         Add_Round_Key (State, Round_Keys (Key_Index));
         Key_Index := Round_Key_Index'Succ (Key_Index);
      end loop;

      Sub_Bytes (State);
      Shift_Rows (State);

      pragma Assert (Key_Index = Round_Key_Index'Last);
      Add_Round_Key (State, Round_Keys (Key_Index));

      Output := Serialize_State (State);
   end Cipher;

   procedure Inv_Cipher (Output :    out Bytes_16;
                     Input  : in     Bytes_16;
                     Key    : in     AES256_Key)
   is
      Round_Keys : constant Round_Key_Array := Key_Expansion (Key);
      Key_Index  : Round_Key_Index := Round_Key_Index'Last;

      State : State_Array := Construct_State (Input);
   begin
      Add_Round_Key (State, Round_Keys (Key_Index));
      Key_Index := Round_Key_Index'Pred (Key_Index);

      while Key_Index > Round_Key_Index'First loop
         pragma Loop_Variant (Decreases => Key_Index);

         Inv_Shift_Rows (State);
         Inv_Sub_Bytes (State);

         Add_Round_Key (State, Round_Keys (Key_Index));
         Key_Index := Round_Key_Index'Pred (Key_Index);

         Inv_Mix_Columns (State);
      end loop;

      Inv_Shift_Rows (State);
      Inv_Sub_Bytes (State);

      pragma Assert (Key_Index = Round_Key_Index'First);
      Add_Round_Key (State, Round_Keys (Key_Index));

      Output := Serialize_State (State);
   end Inv_Cipher;

   --------------------------------------------------------
   --  Global subprogram bodies
   --------------------------------------------------------

   function Construct (Raw_Key : in Bytes_32) return AES256_Key
   is
      Key : U32_Seq (Index_8);
   begin
      for I in Key'Range loop
         Key (I) := Big_Endian_Pack (Raw_Key (4 * I .. 4 * I + 3));
      end loop;

      return AES256_Key'(F => Key);
   end Construct;

   procedure Construct (Key     :    out AES256_Key;
                        Raw_Key : in     Bytes_32)
   is
   begin
      for I in Key.F'Range loop
         Key.F (I) := Big_Endian_Pack (Raw_Key (4 * I .. 4 * I + 3));
      end loop;
   end Construct;

   function Serialize (Key : in AES256_Key) return Bytes_32
   is
      Result : Bytes_32 with Relaxed_Initialization;
   begin
      pragma Assert (Result'First = Key.F'First);
      pragma Assert (Result'First = 0);

      for I in Key.F'Range loop
         Big_Endian_Unpack (Result (4 * I .. 4 * I + 3), Key.F (I));

         pragma Loop_Invariant (
           Result (Result'First .. Result'First + 4 * I + 3)'Initialized);
      end loop;

      return Result;
   end Serialize;

   procedure Sanitize (Key : out AES256_Key)
   is
   begin
      Sanitize_U32_Seq (Key.F);
   end Sanitize;

   procedure ECB_Encrypt (Output :    out Bytes_16;
                          Input  : in     Bytes_16;
                          Key    : in     AES256_Key)
   is
   begin
      Cipher (Output, Input, Key);
   end ECB_Encrypt;

   procedure ECB_Decrypt (Output :    out Bytes_16;
                          Input  : in     Bytes_16;
                          Key    : in     AES256_Key)
   is
   begin
      Inv_Cipher (Output, Input, Key);
   end ECB_Decrypt;

end SPARKNaCl.AES256;

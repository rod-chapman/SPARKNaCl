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

   function GF2p2p2p2_Inverse (X : in U32) return U32
     with Pure_Function,
          Global => null;

   --  Do the following for every Byte in X. Set all bits to the value
   --  of the bit at position "Index".
   function Broadcast_Bit_To_Byte (X     : in U32;
                                   Index : in Index_8) return U32
     with Pure_Function,
          Global => null;

   function Sbox (Input : in U32) return U32
     with Pure_Function,
          Global => null;

   function Inv_Sbox (Input : in U32) return U32
     with Pure_Function,
          Global => null;

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

      procedure Round_Key_CumSum (X : in out Round_Key)
        with Global => null;

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
           Sbox (Rotate_Left (B (B'Last), Byte'Size)) xor Rcon;
         Round_Key_CumSum (A);

         Rcon := Shift_Left (Rcon, 1);

         Key_Index              := Round_Key_Index'Succ (Key_Index);
         Round_Keys (Key_Index) := A;
         exit when Key_Index = Round_Key_Index'Last;

         B (B'First) := B (B'First) xor Sbox (A (A'Last));
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

   function GF2p2p2p2_Inverse (X : in U32) return U32
   is
      Half_Byte_Shift   : constant Integer := 4;
      Half_Nybble_Shift : constant Integer := 2;
      Half_Nyp_Shift    : constant Integer := 1;

      Lower_Nybble_Mask      : constant U32 := 16#0f_0f_0f_0f#;
      Lower_Nybble_Half_Mask : constant U32 := 16#33_33_33_33#;
      Lower_Nyp_Half_Mask    : constant U32 := 16#55_55_55_55#;
      Upper_Nyp_Half_Mask    : constant U32 := 16#aa_aa_aa_aa#;

      Lambda : constant U32 := 16#c1_c1_c1_c1#;
      Phi    : constant U32 := 16#99_99_99_99#;

      A, B, Result : U32;

      function GF2p2_Multiply (U : in U32;
                               V : in U32) return U32
        with Pure_Function,
             Global => null;

      function GF2p2_Inverse (U : in U32) return U32
        with Pure_Function,
             Global => null;

      function GF2p2p2_Multiply (U : in U32;
                                 V : in U32) return U32
        with Pure_Function,
             Global => null;

      function GF2p2p2_Inverse (U : in U32) return U32
        with Pure_Function,
             Global => null;

      function GF2p2_Multiply (U : in U32;
                               V : in U32) return U32
      is
         P, Q, Return_Value : U32;
      begin
         P := U and V;
         P := Shift_Right (P and Upper_Nyp_Half_Mask, Half_Nyp_Shift) xor P;

         Q := Shift_Right (U and Upper_Nyp_Half_Mask, Half_Nyp_Shift) or
           Shift_Left (U and Lower_Nyp_Half_Mask, Half_Nyp_Shift);
         Q := Q and V;
         Q := (Shift_Left (Q, Half_Nyp_Shift) xor Q) and Upper_Nyp_Half_Mask;

         Return_Value := P xor Q;

         return Return_Value;
      end GF2p2_Multiply;

      function GF2p2_Inverse (U : in U32) return U32
      is
         P, Q, Return_Value : U32;
      begin
         P := U and Upper_Nyp_Half_Mask;

         Q := Shift_Right (U, Half_Nyp_Shift) xor U;
         Q := Q and Lower_Nyp_Half_Mask;

         Return_Value := P or Q;

         return Return_Value;
      end GF2p2_Inverse;

      function GF2p2p2_Multiply (U : in U32;
                                 V : in U32) return U32
      is
         R : constant U32 := U xor Shift_Right (U, Half_Nybble_Shift);
         S : constant U32 := V xor Shift_Right (V, Half_Nybble_Shift);

         P, Q, Return_Value : U32;
      begin
         P := GF2p2_Multiply (U, V);

         Q := GF2p2_Multiply (R, S);
         P := GF2p2_Multiply (P, Phi);

         Q := P xor Q;
         P := Shift_Right (P, Half_Nybble_Shift) xor P;

         P := P and Lower_Nybble_Half_Mask;
         Q := Shift_Left (Q and Lower_Nybble_Half_Mask, Half_Nybble_Shift);

         Return_Value := P or Q;

         return Return_Value;
      end GF2p2p2_Multiply;

      function GF2p2p2_Inverse (U : in U32) return U32
      is
         P, Q, Return_Value : U32;
      begin
         P := Shift_Right (U, Half_Nybble_Shift) and Lower_Nybble_Half_Mask;
         P := P xor U;

         Q := GF2p2_Multiply (P, U);
         Q := GF2p2_Multiply (Q, Phi);

         Q := Q xor Shift_Right (Q, Half_Nybble_Shift);
         Q := GF2p2_Inverse (Q);

         Q := Q and Lower_Nybble_Half_Mask;
         Q := Q or Shift_Left (Q, Half_Nybble_Shift);

         Return_Value := GF2p2_Multiply (P, Q);

         return Return_Value;
      end GF2p2p2_Inverse;
   begin
      A := X xor (Shift_Right (X, Half_Byte_Shift) and Lower_Nybble_Mask);

      B := GF2p2p2_Multiply (A, X);
      B := GF2p2p2_Multiply (B, Lambda);

      B := B xor (Shift_Right (B, Half_Byte_Shift) and Lower_Nybble_Mask);
      B := GF2p2p2_Inverse (B);

      B := B and Lower_Nybble_Mask;
      B := B or Shift_Left (B, Half_Byte_Shift);

      Result := GF2p2p2_Multiply (A, B);

      return Result;
   end GF2p2p2p2_Inverse;

   function Broadcast_Bit_To_Byte (X     : in U32;
                                   Index : in Index_8) return U32
   is
      --  Least Significant Bit in Byte Mask
      LSBB_Mask : constant U32 := 16#01_01_01_01#;

      P, Q, Return_Value : U32;
   begin
      P := Shift_Right (X, Integer (Index)) and LSBB_Mask;
      Q := Shift_Left (P, Byte'Size - 1);

      Return_Value := Q or (Q - P);

      return Return_Value;
   end Broadcast_Bit_To_Byte;

   function Sbox (Input : in U32) return U32
   is
      function Forward_Map (X : in U32) return U32;

      function Backward_Map (X : in U32) return U32;

      function Forward_Map (X : in U32) return U32
      is
         Factor : constant U32 := 16#01_01_01_01#;

         Column : constant U32_Seq (Index_8) := (
           Factor * 16#01#, Factor * 16#5f#, Factor * 16#7c#, Factor * 16#74#,
           Factor * 16#46#, Factor * 16#b0#, Factor * 16#4b#, Factor * 16#fc#);

         R : U32 := X and Column (Column'First);
      begin
         R := R xor (Broadcast_Bit_To_Byte (X, 1) and Column (1));
         R := R xor (Broadcast_Bit_To_Byte (X, 2) and Column (2));
         R := R xor (Broadcast_Bit_To_Byte (X, 3) and Column (3));
         R := R xor (Broadcast_Bit_To_Byte (X, 4) and Column (4));
         R := R xor (Broadcast_Bit_To_Byte (X, 5) and Column (5));
         R := R xor (Broadcast_Bit_To_Byte (X, 6) and Column (6));
         R := R xor (Broadcast_Bit_To_Byte (X, 7) and Column (7));

         return R;
      end Forward_Map;

      function Backward_Map (X : in U32) return U32
      is
         Factor : constant U32 := 16#01_01_01_01#;

         Column : constant U32_Seq (Index_8) := (
           Factor * 16#1f#, Factor * 16#19#, Factor * 16#ad#, Factor * 16#84#,
           Factor * 16#54#, Factor * 16#44#, Factor * 16#45#, Factor * 16#f3#);

         R : U32 := Factor * 16#63#;
      begin
         R := R xor (Broadcast_Bit_To_Byte (X, 0) and Column (0));
         R := R xor (Broadcast_Bit_To_Byte (X, 1) and Column (1));
         R := R xor (Broadcast_Bit_To_Byte (X, 2) and Column (2));
         R := R xor (Broadcast_Bit_To_Byte (X, 3) and Column (3));
         R := R xor (Broadcast_Bit_To_Byte (X, 4) and Column (4));
         R := R xor (Broadcast_Bit_To_Byte (X, 5) and Column (5));
         R := R xor (Broadcast_Bit_To_Byte (X, 6) and Column (6));
         R := R xor (Broadcast_Bit_To_Byte (X, 7) and Column (7));

         return R;
      end Backward_Map;

      Result : constant U32 :=
        Backward_Map (GF2p2p2p2_Inverse (Forward_Map (Input)));
   begin
      return Result;
   end Sbox;

   function Inv_Sbox (Input : in U32) return U32
   is
      function Forward_Map (X : in U32) return U32;

      function Backward_Map (X : in U32) return U32;

      function Forward_Map (X : in U32) return U32
      is
         Factor : constant U32 := 16#01_01_01_01#;

         Column : constant U32_Seq (Index_8) := (
           Factor * 16#60#, Factor * 16#c6#, Factor * 16#c5#, Factor * 16#52#,
           Factor * 16#30#, Factor * 16#3e#, Factor * 16#e5#, Factor * 16#cd#);

         R : U32 := Factor * 16#7d#;
      begin
         R := R xor (Broadcast_Bit_To_Byte (X, 0) and Column (0));
         R := R xor (Broadcast_Bit_To_Byte (X, 1) and Column (1));
         R := R xor (Broadcast_Bit_To_Byte (X, 2) and Column (2));
         R := R xor (Broadcast_Bit_To_Byte (X, 3) and Column (3));
         R := R xor (Broadcast_Bit_To_Byte (X, 4) and Column (4));
         R := R xor (Broadcast_Bit_To_Byte (X, 5) and Column (5));
         R := R xor (Broadcast_Bit_To_Byte (X, 6) and Column (6));
         R := R xor (Broadcast_Bit_To_Byte (X, 7) and Column (7));

         return R;
      end Forward_Map;

      function Backward_Map (X : in U32) return U32
      is
         Factor : constant U32 := 16#01_01_01_01#;

         Column : constant U32_Seq (Index_8) := (
           Factor * 16#01#, Factor * 16#bc#, Factor * 16#5d#, Factor * 16#0c#,
           Factor * 16#1f#, Factor * 16#bb#, Factor * 16#f1#, Factor * 16#84#);

         R : U32 := X and Column (Column'First);
      begin
         R := R xor (Broadcast_Bit_To_Byte (X, 1) and Column (1));
         R := R xor (Broadcast_Bit_To_Byte (X, 2) and Column (2));
         R := R xor (Broadcast_Bit_To_Byte (X, 3) and Column (3));
         R := R xor (Broadcast_Bit_To_Byte (X, 4) and Column (4));
         R := R xor (Broadcast_Bit_To_Byte (X, 5) and Column (5));
         R := R xor (Broadcast_Bit_To_Byte (X, 6) and Column (6));
         R := R xor (Broadcast_Bit_To_Byte (X, 7) and Column (7));

         return R;
      end Backward_Map;

      Result : constant U32 :=
        Backward_Map (GF2p2p2p2_Inverse (Forward_Map (Input)));
   begin
      return Result;
   end Inv_Sbox;

   procedure Sub_Bytes (State : in out State_Array)
   is
   begin
      for I in State'Range loop
         State (I) := Sbox (State (I));
      end loop;
   end Sub_Bytes;

   procedure Inv_Sub_Bytes (State : in out State_Array)
   is
   begin
      for I in State'Range loop
         State (I) := Inv_Sbox (State (I));
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

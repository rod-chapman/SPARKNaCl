package body SPARKNaCl.AES256
  with Pure,
       SPARK_Mode => On
is
   pragma Warnings (GNATProve, Off, "pragma * ignored (not yet supported)");

   --------------------------------------------------------
   --  Local type definition(s)
   --------------------------------------------------------

   subtype Cipher_State    is U32_Seq (Index_4);

   --------------------------------------------------------
   --  Local subprogram declaration(s)
   --------------------------------------------------------

   procedure Big_Endian_Unpack (Output :    out Bytes_4;
                                Input  : in     U32)
     with Global => null,
          Pre    => (Output'First = 0) and (Output'Last = 3);

   function Big_Endian_Pack (Input : in Bytes_4) return U32
     with Global => null,
          Pre    => (Input'First = 0) and (Input'Last = 3);

   function Construct_State (Input : in Bytes_16) return Cipher_State
     with Global => null;

   function Serialize_State (State : in Cipher_State) return Bytes_16
     with Global => null;

   procedure Add_Round_Key (State : in out Cipher_State;
                            Key   : in     Round_Key)
     with Global => null;

   function Broadcast (Input : in Byte) return U32
     with Pure_Function,
          Global => null,
          Post   => (for all I in 0 .. 3 => (Input =
            Byte (Shift_Right (Broadcast'Result, I * Byte'Size) and 16#ff#)));

   function GF2p2p2p2_Inverse (X : in U32) return U32
     with Pure_Function,
          Global => null;

   --  Do the following for every Byte in X. Set all bits of the byte to the
   --  value of the bit at position "Index" in the given byte.
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

   procedure Sub_Bytes (State : in out Cipher_State)
     with Global => null;

   procedure Inv_Sub_Bytes (State : in out Cipher_State)
     with Global => null;

   procedure Shift_Rows (State : in out Cipher_State)
     with Global => null;

   procedure Inv_Shift_Rows (State : in out Cipher_State)
     with Global => null;

   function X_Times (Input : in U32) return U32
     with Pure_Function,
          Global => null;

   function Mix_Columns_Matrix_Multiplication (Input : in U32) return U32
     with Pure_Function,
          Global => null;

   procedure Mix_Columns (State : in out Cipher_State)
     with Global => null;

   procedure Inv_Mix_Columns (State : in out Cipher_State)
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
      Shift_Amount : Integer;
      Result       : U32 := 0;
   begin
      for I in Input'Range loop
         Shift_Amount := Integer ((Input'Last - I) * Byte'Size);
         Result := Result or Shift_Left (U32 (Input (I)), Shift_Amount);
      end loop;

      return Result;
   end Big_Endian_Pack;

   function Construct_State (Input : in Bytes_16) return Cipher_State
   is
      State : Cipher_State;
   begin
      for I in Cipher_State'Range loop
         State (I) := Big_Endian_Pack (Input (4 * I .. 4 * I + 3));
      end loop;

      return State;
   end Construct_State;

   function Serialize_State (State : in Cipher_State) return Bytes_16
   is
      Result : Bytes_16 with Relaxed_Initialization;
   begin
      pragma Assert (Result'First = State'First);
      pragma Assert (Result'First = 0);

      for I in Cipher_State'Range loop
         Big_Endian_Unpack (Result (4 * I .. 4 * I + 3), State (I));

         pragma Loop_Invariant (
           Result (Result'First .. Result'First + 4 * I + 3)'Initialized);
      end loop;

      return Result;
   end Serialize_State;

   procedure Add_Round_Key (State : in out Cipher_State;
                            Key   : in     Round_Key)
   is
   begin
      for I in State'Range loop
         State (I) := State (I) xor Key (I);
      end loop;
   end Add_Round_Key;

   function Broadcast (Input : in Byte) return U32
   is
      X : U32 := U32 (Input);
      Result : U32;
   begin
      X      := X or Shift_Left (X, Byte'Size);
      Result := X or Shift_Left (X, 2 * Byte'Size);

      return Result;
   end Broadcast;

   function GF2p2p2p2_Inverse (X : in U32) return U32
   is
      Half_Byte_Shift   : constant Integer := 4;
      Half_Nybble_Shift : constant Integer := 2;
      Half_Nyp_Shift    : constant Integer := 1;

      Lower_Nybble_Mask      : constant U32 := Broadcast (16#0f#);
      Lower_Nybble_Half_Mask : constant U32 := Broadcast (16#33#);
      Lower_Nyp_Half_Mask    : constant U32 := Broadcast (16#55#);
      Upper_Nyp_Half_Mask    : constant U32 := Broadcast (16#aa#);

      Lambda : constant U32 := Broadcast (16#c1#);
      Phi    : constant U32 := Broadcast (16#99#);

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
         P, Return_Value : U32;
      begin
         P := Shift_Right (U and Upper_Nyp_Half_Mask, Half_Nyp_Shift);

         Return_Value := P xor U;
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
      LSBB_Mask : constant U32 := Broadcast (16#01#);

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
         Column : constant U32_Seq (Index_8) := (
           Broadcast (16#01#), Broadcast (16#5f#), Broadcast (16#7c#),
           Broadcast (16#74#), Broadcast (16#46#), Broadcast (16#b0#),
           Broadcast (16#4b#), Broadcast (16#fc#));

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
         Column : constant U32_Seq (Index_8) := (
           Broadcast (16#1f#), Broadcast (16#19#), Broadcast (16#ad#),
           Broadcast (16#84#), Broadcast (16#54#), Broadcast (16#44#),
           Broadcast (16#45#), Broadcast (16#f3#));

         R : U32 := Broadcast (16#63#);
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
         Column : constant U32_Seq (Index_8) := (
           Broadcast (16#60#), Broadcast (16#c6#), Broadcast (16#c5#),
           Broadcast (16#52#), Broadcast (16#30#), Broadcast (16#3e#),
           Broadcast (16#e5#), Broadcast (16#cd#));

         R : U32 := Broadcast (16#7d#);
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
         Column : constant U32_Seq (Index_8) := (
           Broadcast (16#01#), Broadcast (16#bc#), Broadcast (16#5d#),
           Broadcast (16#0c#), Broadcast (16#1f#), Broadcast (16#bb#),
           Broadcast (16#f1#), Broadcast (16#84#));

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

   procedure Sub_Bytes (State : in out Cipher_State)
   is
   begin
      for I in State'Range loop
         pragma Loop_Optimize (No_Unroll);
         State (I) := Sbox (State (I));
      end loop;
   end Sub_Bytes;

   procedure Inv_Sub_Bytes (State : in out Cipher_State)
   is
   begin
      for I in State'Range loop
         pragma Loop_Optimize (No_Unroll);
         State (I) := Inv_Sbox (State (I));
      end loop;
   end Inv_Sub_Bytes;

   procedure Shift_Rows (State : in out Cipher_State)
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

   procedure Inv_Shift_Rows (State : in out Cipher_State)
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

   function X_Times (Input : U32) return U32
   is
      --  Most Significant Bit in Byte Mask
      MSBB_Mask            : constant U32 := Broadcast (16#80#);
      Polynomial_Remainder : constant U32 := Broadcast (16#1b#);

      P, Q, Result : U32;
   begin
      P := Input and MSBB_Mask;
      Q := P xor Input;

      P := P - Shift_Right (P, Byte'Size - 1);
      P := P and Polynomial_Remainder;

      Result := P xor Shift_Left (Q, 1);

      return Result;
   end X_Times;

   function Mix_Columns_Matrix_Multiplication (Input : in U32) return U32
   is
      Upper_Wyde_Half_Mask : constant U32 := 16#ff_00_ff_00#;

      P, Q, X, Result : U32;
   begin
      X := Input xor Rotate_Left (Input, Byte'Size);

      P := Shift_Right (Input and Upper_Wyde_Half_Mask, Byte'Size);
      P := P or (Shift_Left (Input, Byte'Size) and Upper_Wyde_Half_Mask);

      Q := X and Upper_Wyde_Half_Mask;
      Q := Rotate_Left (Q, Byte'Size) or Rotate_Left (Q, 2 * Byte'Size);

      Result := X_Times (X) xor P xor Q;

      return Result;
   end Mix_Columns_Matrix_Multiplication;

   procedure Mix_Columns (State : in out Cipher_State)
   is
   begin
      for I in State'Range loop
         pragma Loop_Optimize (No_Unroll);
         State (I) := Mix_Columns_Matrix_Multiplication (State (I));
      end loop;
   end Mix_Columns;

   procedure Inv_Mix_Columns (State : in out Cipher_State)
   is
      function Matrix_Multiplication (Column : in U32) return U32
        with Pure_Function,
             Global => null;

      function Matrix_Multiplication (Column : in U32) return U32
      is
         P, Q, Result : U32;
      begin
         P := Rotate_Right (Column, 2 * Byte'Size) xor Column;
         P := X_Times (X_Times (P));

         Q := Rotate_Right (P, Byte'Size) xor P;
         Q := X_Times (Q);

         Result := Mix_Columns_Matrix_Multiplication (Column) xor P xor Q;

         return Result;
      end Matrix_Multiplication;
   begin
      for I in State'Range loop
         pragma Loop_Optimize (No_Unroll);
         State (I) := Matrix_Multiplication (State (I));
      end loop;
   end Inv_Mix_Columns;

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

   procedure Sanitize (Round_Keys : out AES256_Round_Keys)
   is
   begin
      for I in Round_Key_Array'Range loop
         Sanitize_U32_Seq (Round_Keys.F (I));
      end loop;
   end Sanitize;

   function Key_Expansion (Key : in AES256_Key) return AES256_Round_Keys
   is
      Round_Keys : Round_Key_Array with Relaxed_Initialization;
      Key_Index  : Round_Key_Index := Round_Keys'First;

      Rcon : U32 := 16#01_00_00_00#;

      A : Round_Key :=
        Key.F (Key.F'First .. Key.F'First + Round_Key'Length - 1);
      B : Round_Key :=
        Key.F (Key.F'Last - (Round_Key'Length - 1) .. Key.F'Last);

      procedure Round_Key_CumSum (X : in out Round_Key)
        with Global => null;

      procedure Round_Key_CumSum (X : in out Round_Key)
      is
         subtype Index is I32 range 1 .. 3;
      begin
         for I in Index loop
            X (X'First + I) := X (X'First + I) xor X (X'First + (I - 1));
         end loop;
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

      return AES256_Round_Keys'(F => Round_Keys);
   end Key_Expansion;

   procedure Cipher (Output     :    out Bytes_16;
                     Input      : in     Bytes_16;
                     Round_Keys : in     AES256_Round_Keys)
   is
      Key_Index : Round_Key_Index := Round_Keys.F'First;
      State     : Cipher_State := Construct_State (Input);
   begin
      Add_Round_Key (State, Round_Keys.F (Key_Index));
      Key_Index := Round_Key_Index'Succ (Key_Index);

      while Key_Index < Round_Keys.F'Last loop
         Sub_Bytes (State);
         Shift_Rows (State);
         Mix_Columns (State);

         Add_Round_Key (State, Round_Keys.F (Key_Index));
         Key_Index := Round_Key_Index'Succ (Key_Index);
      end loop;

      Sub_Bytes (State);
      Shift_Rows (State);

      pragma Assert (Key_Index = Round_Keys.F'Last);
      Add_Round_Key (State, Round_Keys.F (Key_Index));

      Output := Serialize_State (State);
   end Cipher;

   procedure Inv_Cipher (Output     :    out Bytes_16;
                         Input      : in     Bytes_16;
                         Round_Keys : in     AES256_Round_Keys)
   is
      Key_Index : Round_Key_Index := Round_Keys.F'Last;
      State     : Cipher_State := Construct_State (Input);
   begin
      Add_Round_Key (State, Round_Keys.F (Key_Index));
      Key_Index := Round_Key_Index'Pred (Key_Index);

      while Key_Index > Round_Keys.F'First loop
         Inv_Shift_Rows (State);
         Inv_Sub_Bytes (State);

         Add_Round_Key (State, Round_Keys.F (Key_Index));
         Key_Index := Round_Key_Index'Pred (Key_Index);

         Inv_Mix_Columns (State);
      end loop;

      Inv_Shift_Rows (State);
      Inv_Sub_Bytes (State);

      pragma Assert (Key_Index = Round_Keys.F'First);
      Add_Round_Key (State, Round_Keys.F (Key_Index));

      Output := Serialize_State (State);
   end Inv_Cipher;

end SPARKNaCl.AES256;

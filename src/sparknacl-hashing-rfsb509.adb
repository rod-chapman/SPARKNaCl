with SPARKNaCl.Hashing.SHA512;
package body SPARKNaCl.Hashing.RFSB509
  with SPARK_Mode => On
is
   --  Three most significant bits
   Three_MSB_Mask : constant Byte := 2#1110_0000#;

   --  The RFSB-509 compression function is defined by three numbers:
   --    w: number of input chunks i.e weight of the sum (positive integer)
   --    b: length of the input chunks in bits (positive integer)
   --    r: length of the output in bits (odd prime number)
   --  Dervied from those parameters is:
   --    s: length of the input in bits (w * b)
   --  In order for RFSB-509 to be a "compression" function s > r.
   RFSB509_W : constant I32 := 112;
   RFSB509_B : constant I32 := 8;
   RFSB509_R : constant I32 := 509;
   RFSB509_S : constant I32 := RFSB509_W * RFSB509_B;

   pragma Assert (RFSB509_S > RFSB509_R);

   subtype Matrix_Column is Bytes_64;
   subtype Data_Block    is Bytes_48;

   --------------------------------------------------------
   --  Local subprogram declarations
   --------------------------------------------------------

   procedure Calculate_Column (Column     :    out Matrix_Column;
                               Word       : in     Byte;
                               Round_Keys : in     AES256_Round_Keys)
     with Global => null,
          Pre    => Column'First = 0,
          Post   => (Column (Column'Last) and Three_MSB_Mask) = 0;

   procedure Mul128 (A : in out Matrix_Column)
     with Global => null,
          Pre    => (A (A'Last) and Three_MSB_Mask) = 0,
          Post   => (A (A'Last) and Three_MSB_Mask) = 0;

   procedure Add (Sum     : in out Matrix_Column;
                  Summand : in     Matrix_Column)
     with Global => null,
          Pre    => (Sum (Sum'Last) and Three_MSB_Mask) = 0 and
                    (Summand (Summand'Last) and Three_MSB_Mask) = 0,
          Post   => (Sum (Sum'Last) and Three_MSB_Mask) = 0;

   procedure Compress (Chain_Value  : in out Digest;
                       Block        : in     Data_Block;
                       Round_Keys   : in     AES256_Round_Keys)
     with Global => null,
          Pre    => (Chain_Value (Chain_Value'Last) and Three_MSB_Mask) = 0,
          Post   => (Chain_Value (Chain_Value'Last) and Three_MSB_Mask) = 0;

   procedure Hash_Local (Output :    out Digest;
                         Input  : in     Byte_Seq;
                         Key    : in     AES256_Key)
     with Global => null;

   --------------------------------------------------------
   --  Local subprogram bodies
   --------------------------------------------------------

   procedure Calculate_Column (Column     :    out Matrix_Column;
                               Word       : in     Byte;
                               Round_Keys : in     AES256_Round_Keys)
   is
      Input_String : Bytes_16 := (others => 0);
      Result       : Bytes_64 with Relaxed_Initialization;

      First_Byte, Last_Byte  : Byte;
   begin
      Input_String (Input_String'Last - 1) := Word;

      for I in Index_4 loop
         Input_String (Input_String'Last) := Byte (I);
         Cipher (Result (I * 16 ..  I * 16 + 15), Input_String, Round_Keys);

         pragma Loop_Invariant (
           (Result (Result'First .. I * 16 + 15)'Initialized));
      end loop;

      First_Byte := Result (Result'First);
      Last_Byte  := Result (Result'Last);

      Result (Result'First) := First_Byte xor Shift_Right (Last_Byte, 5);
      Result (Result'Last)  := Last_Byte and (not Three_MSB_Mask);

      Column := Result;

      pragma Assert ((Column (Column'Last) and Three_MSB_Mask) = 0);
   end Calculate_Column;

   procedure Mul128 (A : in out Matrix_Column)
   is
      Product : Matrix_Column with Relaxed_Initialization;

      Exponent     : constant Index_64 := (128 / Byte'Size);
      Shift_Amount : constant Integer := 5;

      Factor_Pivot  : constant Index_64 := A'Last - Exponent;
      Product_Pivot : constant Index_64 := Product'First + Exponent;

      Factor_Index  : Index_64 := Factor_Pivot;
      Product_Index : Index_64 := Product'First;

      Current_Byte : Byte := A (Factor_Index);
      Lower_Part   : Byte := Shift_Right (Current_Byte, Shift_Amount);
      Upper_Part   : Byte;
   begin
      Product (Product_Index) := Lower_Part;

      Factor_Index  := Index_64'Succ (Factor_Index);

      while (Product_Index < Product_Pivot) loop
         pragma Loop_Variant
           (Increases => Factor_Index, Increases => Product_Index);
         pragma Loop_Invariant
           ((Factor_Index - Product_Index = A'Last - Product_Pivot + 1) and
             (Product (Product'First .. Product_Index)'Initialized) and
             ((Product (Product_Index) and
               (not Shift_Right (Three_MSB_Mask, Shift_Amount))) = 0));

         Current_Byte := A (Factor_Index);

         Lower_Part := Shift_Right (Current_Byte, Shift_Amount);
         Upper_Part := Shift_Left (Current_Byte, Byte'Size - Shift_Amount);

         Product (Product_Index) := Product (Product_Index) or Upper_Part;
         Product_Index           := Index_64'Succ (Product_Index);
         Product (Product_Index) := Lower_Part;

         exit when Product_Index = Product_Pivot;
         Factor_Index := Index_64'Succ (Factor_Index);
      end loop;

      pragma Assert (Product_Index = Product_Pivot);
      pragma Assert (Factor_Index = A'Last);

      Product (Product_Index) := Product (Product_Index) xor A (A'First);
      Product_Index           := Index_64'Succ (Product_Index);

      Product (Product_Index .. Product'Last) :=
        A (A'First + 1 .. Factor_Pivot);

      Product (Product'Last) :=
        Product (Product'Last) and (not Three_MSB_Mask);

      A := Product;
   end Mul128;

   procedure Add (Sum     : in out Matrix_Column;
                  Summand : in     Matrix_Column)
   is
   begin
      for I in Sum'Range loop
         Sum (I) := Sum (I) xor Summand (I);
      end loop;
   end Add;

   procedure Compress (Chain_Value  : in out Digest;
                       Block        : in     Data_Block;
                       Round_Keys   : in     AES256_Round_Keys)
   is
      Sum    : Matrix_Column;
      Column : Matrix_Column;
   begin
      Calculate_Column (Sum, Chain_Value (Digest'First), Round_Keys);

      for I in Digest'First + 1 .. Digest'Last loop
         pragma Loop_Invariant ((Sum (Sum'Last) and Three_MSB_Mask) = 0);

         Calculate_Column (Column, Chain_Value (I), Round_Keys);
         Mul128 (Sum);
         Add (Sum, Column);
      end loop;

      for I in Block'Range loop
         pragma Loop_Invariant ((Sum (Sum'Last) and Three_MSB_Mask) = 0);

         Calculate_Column (Column, Block (I), Round_Keys);
         Mul128 (Sum);
         Add (Sum, Column);
      end loop;

      Chain_Value := Sum;
   end Compress;

   procedure Hash_Local (Output :    out Digest;
                         Input  : in     Byte_Seq;
                         Key    : in     AES256_Key)
   is
      Round_Keys     : constant AES256_Round_Keys := Key_Expansion (Key);
      IV             : constant Digest := (others => 0);
      Padding_Marker : constant Byte := 2#1000_0000#;

      Input_Length : I64 := Input'Length;
      Current_Byte : I32 := Input'First;

      Hash  : Digest := IV;
      Block : Data_Block with Relaxed_Initialization;

      Final_Block_Index : Index_48;
   begin
      pragma Assert (Block'Length = (RFSB509_S - RFSB509_R) / RFSB509_B);

      while (Input_Length >= Block'Length) loop
         pragma Loop_Variant
           (Increases => Current_Byte, Decreases => Input_Length);
         pragma Loop_Invariant
           (((Hash (Hash'Last) and Three_MSB_Mask) = 0) and
             (Input_Length + I64 (Current_Byte) = I64 (Input'Last) + 1) and
             (Input_Length in Block'Length .. Input'Length) and
             (Current_Byte in Input'First .. (Input'Last - Block'Length + 1)));

         Block := Input (Current_Byte .. Current_Byte + (Block'Length - 1));
         Compress (Hash, Block, Round_Keys);

         pragma Assert (Input_Length >= Block'Length);
         Input_Length := Input_Length - Block'Length;

         exit when Input_Length < Block'Length;
         Current_Byte := Current_Byte + Block'Length;
      end loop;

      if Input_Length > 0 then
         Final_Block_Index := Index_48 (Input_Length) - 1;

         Block (Block'First .. Block'First + Final_Block_Index) :=
           Input (Input'Last - I32 (Final_Block_Index) .. Input'Last);

         Final_Block_Index := Index_48'Succ (Final_Block_Index);
      else
         Final_Block_Index := Index_48'First;
      end if;

      Block (Final_Block_Index) := Padding_Marker;

      if I32 (Final_Block_Index) > (Block'Last - 8) then
         Block (I32 (Final_Block_Index) .. Block'Last) :=
           (others => 0);

         Compress (Hash, Block, Round_Keys);
         Final_Block_Index := Index_48'First;
      else
         Final_Block_Index := Index_48'Succ (Final_Block_Index);
      end if;

      Block (Final_Block_Index .. Block'Last - 8) := (others => 0);
      Block (Block'Last - 7 .. Block'Last) := TS64 (U64 (Input'Length));

      Compress (Hash, Block, Round_Keys);
      Hashing.SHA512.Hash (Output, Hash);
   end Hash_Local;

   --------------------------------------------------------
   --  Global subprogram bodies
   --------------------------------------------------------

   procedure Hash (Output :    out Digest;
                   Input  : in     Byte_Seq;
                   Key    : in     AES256_Key)
   is
   begin
      Hash_Local (Output, Input, Key);
   end Hash;

   function Hash (Input : in Byte_Seq;
                  Key   : in AES256_Key) return Digest
   is
      Output : Digest;
   begin
      Hash_Local (Output, Input, Key);
      return Output;
   end Hash;

end SPARKNaCl.Hashing.RFSB509;

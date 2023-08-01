with SPARKNaCl.Hashing.SHA256;
package body SPARKNaCl.Hashing.RFSB509
  with SPARK_Mode => On
is
   --------------------------------------------------------
   --  Local constant definition(s)
   --------------------------------------------------------

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

   --------------------------------------------------------
   --  Local type definition(s)
   --------------------------------------------------------

   subtype Matrix_Column is Bytes_64
     with Dynamic_Predicate =>
       (Matrix_Column (Matrix_Column'Last) and 2#1110_0000#) = 0;
   subtype Data_Block    is Bytes_48;

   --------------------------------------------------------
   --  Local subprogram declaration(s)
   --------------------------------------------------------

   procedure Calculate_Column (Column     :    out Matrix_Column;
                               Word       : in     Byte;
                               Round_Keys : in     AES256_Round_Keys)
     with Global => null,
          Pre    => Column'First = 0;

   procedure Mul128 (A : in out Matrix_Column)
     with Global => null;

   procedure Add (Sum     : in out Matrix_Column;
                  Summand : in     Matrix_Column)
     with Global => null;

   procedure Compress (Chain_Value  : in out Matrix_Column;
                       Block        : in     Data_Block;
                       Round_Keys   : in     AES256_Round_Keys)
     with Global => null;

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
      Five_LSB_Mask : constant Byte := 2#0001_1111#;

      Cipher_Input : Bytes_16 := (others => 0);
      Vector       : Bytes_64 with Relaxed_Initialization;

      First_Byte, Last_Byte  : Byte;
   begin
      Cipher_Input (Cipher_Input'Last - 1) := Word;

      for I in Index_4 loop
         Cipher_Input (Cipher_Input'Last) := Byte (I);
         Cipher (Vector (I * 16 ..  I * 16 + 15), Cipher_Input, Round_Keys);

         pragma Loop_Invariant (
           (Vector (Vector'First .. I * 16 + 15)'Initialized));
      end loop;

      First_Byte := Vector (Vector'First);
      Last_Byte  := Vector (Vector'Last);

      Vector (Vector'First) := First_Byte xor Shift_Right (Last_Byte, 5);
      Vector (Vector'Last)  := Last_Byte and Five_LSB_Mask;

      Column := Vector;
   end Calculate_Column;

   procedure Mul128 (A : in out Matrix_Column)
   is
      Three_MSB_Mask : constant Byte := 2#1110_0000#;

      Exponent     : constant Index_64 := (128 / Byte'Size);
      Shift_Amount : constant Integer := 5;

      Product : Bytes_64 with Relaxed_Initialization;

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

   procedure Compress (Chain_Value  : in out Matrix_Column;
                       Block        : in     Data_Block;
                       Round_Keys   : in     AES256_Round_Keys)
   is
      Sum    : Matrix_Column;
      Column : Matrix_Column;
   begin
      Calculate_Column (Sum, Chain_Value (Digest'First), Round_Keys);

      for I in Digest'First + 1 .. Digest'Last loop
         Calculate_Column (Column, Chain_Value (I), Round_Keys);
         Mul128 (Sum);
         Add (Sum, Column);
      end loop;

      for I in Block'Range loop
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
      IV             : constant Matrix_Column := (others => 0);
      Padding_Marker : constant Byte := 2#1000_0000#;

      Input_Length : I64 := Input'Length;
      Current_Byte : I32 := Input'First;

      Hash  : Matrix_Column := IV;
      Block : Data_Block with Relaxed_Initialization;

      Final_Block_Index : Index_48;
   begin
      pragma Assert (Block'Length = (RFSB509_S - RFSB509_R) / RFSB509_B);

      while (Input_Length >= Block'Length) loop
         pragma Loop_Variant
           (Increases => Current_Byte, Decreases => Input_Length);
         pragma Loop_Invariant
           ((Input_Length + I64 (Current_Byte) = I64 (Input'Last) + 1) and
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
      Hashing.SHA256.Hash (Output, Hash);
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

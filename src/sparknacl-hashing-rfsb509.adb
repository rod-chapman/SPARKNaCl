with SPARKNaCl.Utils;          use SPARKNaCl.Utils;
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

   procedure Calculate_Column (Column     :    out Bytes_64;
                               Word       : in     Byte;
                               Round_Keys : in     AES128_Round_Keys)
     with Relaxed_Initialization => Column,
          Global => null,
          Pre    => Column'First = 0,
          Post   => Column'Initialized and
            ((Column (Column'Last) and 2#1110_00_00#) = 0);

   procedure Mul128 (A : in out Matrix_Column)
     with Global => null;

   procedure Add (Sum     : in out Matrix_Column;
                  Summand : in     Matrix_Column)
     with Global => null;

   procedure Compress (Chain_Value  : in out Matrix_Column;
                       Block        : in     Data_Block;
                       Round_Keys   : in     AES128_Round_Keys)
     with Global => null;

   procedure Hash_Blocks (Output          : in out Matrix_Column;
                          Bytes_Remaining :    out Index_48;
                          Input           : in     Byte_Seq;
                          Round_Keys      : in     AES128_Round_Keys)
     with Global => null,
          Post   => I64 (Bytes_Remaining) <= Input'Length;

   procedure Hash_Local (Output :    out Digest;
                         Input  : in     Byte_Seq;
                         Key    : in     AES128_Key)
     with Global => null;

   --------------------------------------------------------
   --  Local subprogram bodies
   --------------------------------------------------------

   procedure Calculate_Column (Column     :    out Bytes_64;
                               Word       : in     Byte;
                               Round_Keys : in     AES128_Round_Keys)
   is
      Five_LSB_Mask : constant Byte := 2#0001_1111#;

      First_Byte, Last_Byte : Byte;
      Cipher_Input          : Bytes_16 := (others => 0);
   begin
      Cipher_Input (Cipher_Input'First + 1) := Word;

      for I in Index_4 loop
         Cipher_Input (Cipher_Input'First) := Byte (I);
         Cipher (Column (I * 16 ..  I * 16 + 15), Cipher_Input, Round_Keys);

         pragma Loop_Invariant (
           (Column (Column'First .. I * 16 + 15)'Initialized));
      end loop;

      First_Byte := Column (Column'First);
      Last_Byte  := Column (Column'Last);

      Column (Column'First) := First_Byte xor Shift_Right (Last_Byte, 5);
      Column (Column'Last)  := Last_Byte and Five_LSB_Mask;
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
                       Round_Keys   : in     AES128_Round_Keys)
   is
      Sum    : Matrix_Column;
      Column : Matrix_Column;
   begin
      Calculate_Column (Sum, Chain_Value (Digest'First), Round_Keys);

      for I in Chain_Value'First + 1 .. Chain_Value'Last loop
         Mul128 (Sum);
         Calculate_Column (Column, Chain_Value (I), Round_Keys);
         Add (Sum, Column);
      end loop;

      for I in Block'Range loop
         Mul128 (Sum);
         Calculate_Column (Column, Block (I), Round_Keys);
         Add (Sum, Column);
      end loop;

      Chain_Value := Sum;
   end Compress;

   procedure Hash_Blocks (Output          : in out Matrix_Column;
                          Bytes_Remaining :    out Index_48;
                          Input           : in     Byte_Seq;
                          Round_Keys      : in     AES128_Round_Keys)
   is
      Remainder    : I64 := Input'Length;
      Current_Byte : I32 := Input'First;

      Block : Data_Block;
   begin
      pragma Assert (Block'Length = (RFSB509_S - RFSB509_R) / RFSB509_B);

      while Remainder >= Block'Length loop
         pragma Loop_Variant
           (Increases => Current_Byte, Decreases => Remainder);
         pragma Loop_Invariant
           ((Remainder + I64 (Current_Byte) = I64 (Input'Last) + 1) and
             (Remainder in Block'Length .. Input'Length) and
             (Current_Byte in Input'First .. (Input'Last - Block'Length + 1)));

         Block := Input (Current_Byte .. Current_Byte + (Block'Length - 1));
         Compress (Output, Block, Round_Keys);

         pragma Assert (Remainder >= Block'Length);
         Remainder := Remainder - Block'Length;

         exit when Remainder < Block'Length;
         Current_Byte := Current_Byte + Block'Length;
      end loop;

      Bytes_Remaining := Index_48 (Remainder);
   end Hash_Blocks;

   procedure Hash_Local (Output :    out Digest;
                         Input  : in     Byte_Seq;
                         Key    : in     AES128_Key)
   is
      Round_Keys     : constant AES128_Round_Keys := Key_Expansion (Key);

      Hash  : Matrix_Column := (others => 0);
      Block : Data_Block with Relaxed_Initialization;

      Bytes_Remaining, Block_Index : Index_48;
   begin
      pragma Assert (Block'Length = (RFSB509_S - RFSB509_R) / RFSB509_B);

      Hash_Blocks (Hash, Bytes_Remaining, Input, Round_Keys);
      Block_Index := Block'First + Bytes_Remaining;

      if Bytes_Remaining > 0 then
         Block (Block'First .. Block_Index - 1) :=
           Input (Input'Last - I32 (Bytes_Remaining) + 1 .. Input'Last);

         if Block_Index > (Block'Last - 7) then
            Block (Block_Index .. Block'Last) := (others => 0);
            Compress (Hash, Block, Round_Keys);

            Block_Index := Block'First;
         end if;
      end if;

      Block (Block_Index .. Block'Last - 8) := (others => 0);
      Little_Endian_Unpack (
        Block (Block'Last - 7 .. Block'Last), U64 (Input'Length));

      Compress (Hash, Block, Round_Keys);
      Hashing.SHA256.Hash (Output, Hash);
   end Hash_Local;

   --------------------------------------------------------
   --  Global subprogram bodies
   --------------------------------------------------------

   procedure Hash (Output :    out Digest;
                   Input  : in     Byte_Seq;
                   Key    : in     AES128_Key)
   is
   begin
      Hash_Local (Output, Input, Key);
   end Hash;

   function Hash (Input : in Byte_Seq;
                  Key   : in AES128_Key) return Digest
   is
      Output : Digest;
   begin
      Hash_Local (Output, Input, Key);
      return Output;
   end Hash;

end SPARKNaCl.Hashing.RFSB509;

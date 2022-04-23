with Ada.Exceptions;
with Ada.Numerics.Discrete_Random;
with Ada.Streams;                use Ada.Streams;
with Ada.Text_IO;                use Ada.Text_IO;
with Ada.Unchecked_Conversion;
with Interfaces;                 use Interfaces;
with System;

with SPARKNaCl;                  use SPARKNaCl;
with SPARKNaCl.Core;             use SPARKNaCl.Core;
with SPARKNaCl.Debug;            use SPARKNaCl.Debug;
with SPARKNaCl.Hashing;          use SPARKNaCl.Hashing;
with SPARKNaCl.Stream;
with SPARKNaCl.Cryptobox;        use SPARKNaCl.Cryptobox;
with SPARKNaCl.Secretbox;
with SPARKNaCl.Scalar;           use SPARKNaCl.Scalar;
with SPARKNaCl.MAC;
with SPARKNaCl.HKDF;             use SPARKNaCl.HKDF;

with GNAT.Sockets;               use GNAT.Sockets;
with GNAT.Traceback.Symbolic;

procedure TLS
is
   subtype Bytes_2 is Byte_Seq (0 .. 1);

   --  Not CSPRNG, just for demonstration purposes.
   package Random_Byte is new
      Ada.Numerics.Discrete_Random (SPARKNaCl.Byte);

    function Random_Bytes_32 return Bytes_32 is
      G      : Random_Byte.Generator;
      Output : Bytes_32;
    begin
      for b in Output'Range loop
         Output (b) := Random_Byte.Random (G);
      end loop;

      return Output;
    end Random_Bytes_32;

   --  Raw_SK : SPARKNaCl.Bytes_32 := Random_Bytes_32;
   Raw_SK : SPARKNaCl.Bytes_32 := (
      16#20#, 16#21#, 16#22#, 16#23#, 16#24#, 16#25#, 16#26#, 16#27#,
      16#28#, 16#29#, 16#2a#, 16#2b#, 16#2c#, 16#2d#, 16#2e#, 16#2f#,
      16#30#, 16#31#, 16#32#, 16#33#, 16#34#, 16#35#, 16#36#, 16#37#,
      16#38#, 16#39#, 16#3a#, 16#3b#, 16#3c#, 16#3d#, 16#3e#, 16#3f#
   );

   SK : SPARKNaCl.Cryptobox.Secret_Key;
   PK : SPARKNaCl.Cryptobox.Public_Key;

   Client_Random    : Bytes_32 := Random_Bytes_32;

   --  For shared key calculations

   Server_Raw_PK    : Bytes_32;
   Shared_Secret    : Bytes_32;

   Hello_Hash       : Digest_256;
   Empty_Hash       : Digest_256;

   All_Zeroes       : Bytes_32 := (others => 0);
   One_Zero         : Byte_Seq (0 .. 0) := (others => 0);
   Empty            : Byte_Seq (1 .. 0) := (others => 0);
   Early_Secret     : Digest_256;
   Derived_Secret   : OKM_256 (0 .. 31);
   Handshake_Secret : Digest_256;

   Client_Handshake_Traffic_Secret : OKM_256 (0 .. 31);
   Server_Handshake_Traffic_Secret : OKM_256 (0 .. 31);
   
   Client_Handshake_Key : OKM_256 (0 .. 31);
   Server_Handshake_Key : OKM_256 (0 .. 31);
   Client_Handshake_IV  : OKM_256 (0 .. 11);
   Server_Handshake_IV  : OKM_256 (0 .. 11);

   Client_IV_Counter    : U64;
   Server_IV_Counter    : U64;

   --------------------------------------------------------
   --  Conversion of TLS 1.3 2-byte size fields
   --------------------------------------------------------
   function TS16 (U : in U16) return Bytes_2
   is
      X : Bytes_2;
   begin
      X (0) := Byte (U / 256);
      X (1) := Byte (U mod 256);
      return X;
   end TS16;

   function DL16 (I : Bytes_2) return U16
   is
   begin
      return U16 (I (0)) * 256 + U16 (I (1));
   end DL16;

   --------------------------------------------------------
   --  HKDF-Expand-Label as defined in RFC 8446
   --------------------------------------------------------
   procedure Expand_Label (OKM     : out OKM_256;
                           PRK     : in Digest_256;
                           Label   : in String;
                           Context : in Byte_Seq)
   is
      HKDF_Label : Byte_Seq := 
         TS16 (U16 (OKM'Length)) & 
         Byte (Label'Length + 6) &
         To_Byte_Seq ("tls13 " & Label) &
         Byte (Context'Length) &
         Context;
   begin
      DH ("HKDF_Label: ", HKDF_Label);
      Expand (OKM, PRK, HKDF_Label);
   end Expand_Label;

   --------------------------------------------------------
   --  Generate extension header w/ type and size
   --------------------------------------------------------
   function Extension (ID : U16; Contents : Byte_Seq) return Byte_Seq is
   begin
      return TS16 (ID) & TS16 (U16 (Contents'Length)) & Contents;
   end Extension;

   --------------------------------------------------------
   --  Generate SNI extension
   --------------------------------------------------------
   function Server_Name (Host : String) return Byte_Seq is
   begin
      return TS16 (U16 (Host'Length + 3)) &  -- 2 bytes for hostname len + 1
                                             -- byte for type of name
             (16#00#) &                      -- DNS record
             TS16 (U16 (Host'Length)) &      -- length of hostname
             To_Byte_Seq (Host);             -- hostname itself
   end Server_Name;

   --------------------------------------------------------
   --  Generate Key_Share extension
   --------------------------------------------------------
   function Key_Share (PK : Byte_Seq) return Byte_Seq is
   begin
      return TS16 (U16 (PK'Length + 4)) &    -- 2 bytes for key size + 2
                                             --  bytes for key type
             (16#00#, 16#1D#) &              -- x25519 always
             TS16 (U16 (PK'Length)) &        -- length of key
             PK;
   end Key_Share;

   --------------------------------------------------------
   --  Generate Client Hello TLS Record
   --------------------------------------------------------
   function Client_Hello (Host : String; PK : Public_Key) return Byte_Seq is
      Extensions : Byte_Seq :=
         --  00 00 = server name
         Extension (16#00_00#, Server_Name (Host)) &
         
         --  00 0A = supported groups
         Extension (16#00_0A#, (16#00#, 16#02#,    -- 2 bytes of curves
                                16#00#, 16#1d#)) & -- x25519 only.

         --  00 0D = signature algorithms
         Extension (16#00_0D#, (16#00#, 16#02#,    -- 2 bytes of sig algos
                                16#08#, 16#07#)) & -- ed25519 only

         --  00 33 = key share
         Extension (16#00_33#, Key_Share (Serialize (PK))) &
         
         --  00 2D = pre-shared keys (not used)
         Extension (16#00_2D#, (16#01#, 16#01#)) &

         --  00 2B = supported versions (TLS 1.3 only)
         Extension (16#00_2B#, (16#02#, 16#03#, 16#04#));

      Handshake : Byte_Seq :=
         16#03# & 16#03# &      -- TLS 1.2 (lie for backwards compatibility)
         Client_Random &        -- Client Random
         16#00# &               -- No Session ID
         16#00# & 16#02# &      -- 2 bytes of cipher suite data
         16#13# & 16#03# &      -- cipher suite (CHACHA20_POLY1305_SHA256)
         16#01# & 16#00# &      -- compression methods (null)
         TS16 (U16 (Extensions'Length)) &
         Extensions;

      TLS_Record : Byte_Seq :=
         (16#16#,                -- record type = handshake
          16#03#,                -- version = TLS 1.0
          16#01#) &              -- size of message
          TS16 (U16 (Handshake'Length + 4)) & -- 1 byte for handshake type +
                                              -- 3 more bytes for it's size
          16#01# &               -- handshake type (Client Hello)
          16#00# &
          TS16 (U16 (Handshake'Length)) &
          Handshake;
   begin
      return TLS_Record;
   end Client_Hello;

   --------------------------------------------------------
   --  Take a byte_seq from the server and parse it's
   --  parameters.
   --------------------------------------------------------
   procedure Parse_Server_Hello (SH : Byte_Seq) is
      Record_Type     : Byte     := SH (0);
      Legacy_Protocol : Bytes_2  := SH (1 .. 2);
      Handshake_Size  : U16      := DL16 (SH (3 .. 4));
      Handshake_Type  : Byte     := SH (5);
      --  ignore SH (6)
      SH_Size         : U16      := DL16 (SH (7 .. 8));
      Server_Version  : Bytes_2  := SH (9 .. 10);
      Server_Random   : Bytes_32 := SH (11 .. 42);
      Session_Size    : N32      := N32 (SH (43));
      Session_ID_End  : N32      := 44 + Session_Size - 1;
      Session_ID      : Byte_Seq (0 .. Session_Size - 1) := 
         SH (44 .. Session_ID_End);
      Cipher_Suite    : Bytes_2  :=
         SH (Session_ID_End + 1 .. Session_ID_End + 2);
      Compression     : Byte     := SH (Session_ID_End + 3);
      Extensions_Len  : U16      := 
         DL16 (SH (Session_ID_End + 4 .. Session_ID_End + 5));

      Extension_Start : N32     := Session_ID_End + 6;
      Extension_Len   : U16;
      Extension_Type  : Bytes_2;

      --  Expect a key share
      Key_Type        : Bytes_2;
      Key_Len         : U16;
      Key_Bytes       : Bytes_32;

      --  Expect supported versions
      Supported_Len      : U16;
      Supported_Versions : Bytes_32;
   begin
      --  Record Header
      Put_Line ("Record Type:            " & Record_Type'Image);
      Put_Line ("Legacy protocol version:" &
         Legacy_Protocol(0)'Image &
         Legacy_Protocol(1)'Image);
      Put_Line ("Handshake Size:         " & Handshake_Size'Image);

      --  Handshake Header
      Put_Line ("Handshake Type:         " & Handshake_Type'Image);
      Put_Line ("Server Hello Size:      " & SH_Size'Image);
      Put_Line ("Server_Version:         " &
         Server_Version(0)'Image &
         Server_Version(1)'Image);

      DH ("Server Random:", Server_Random);
      Put_Line ("Session ID Size:        " & Session_Size'Image);
      DH ("Session ID:", Session_ID);

      DH ("Cipher Suite:", Cipher_Suite);

      Put_Line ("Extensions Size:        " & Extensions_Len'Image);

      loop
         exit when Extension_Start >= SH'Last - 1;

         Extension_Type := SH (Extension_Start .. Extension_Start + 1);

         if Extension_Type = (16#00#, 16#33#) then
            Put_Line ("Extension - Key Share");
            Put_Line ("---------------------");

            Extension_Len :=
               DL16 (SH (Extension_Start + 2 .. Extension_Start + 3));
            Key_Type  := SH (Extension_Start + 4 .. Extension_Start + 5);
            Key_Len   := DL16 (SH (Extension_Start + 6 .. Extension_Start + 7));

            -- should make Key_Bytes size according to len, but this is just
            -- a proof of concept.
            Key_Bytes :=
               SH (Extension_Start + 8 ..
                   Extension_Start + 8 + N32 (Key_Len) - 1);
            Server_Raw_PK := Key_Bytes;

            Put_Line ("Extension Length: " & Extension_Len'Image);
            DH ("Key Type:", Key_Type);
            Put_Line ("Key Length: " & Key_Len'Image);
            DH ("Server Key:", Key_Bytes);

         elsif Extension_Type = (16#00#, 16#2b#) then
            --  Supported Versions
            Put_Line ("Extension - Supported Versions");
            Put_Line ("------------------------------");

            Extension_Len :=
               DL16 (SH (Extension_Start + 2 .. Extension_Start + 3));

            Supported_Len := Extension_Len;
            Put_Line ("Supported Versions Size: " & Supported_Len'Image);
            DH ("Supported Versions: ",
               SH (Extension_Start + 4 ..
                   Extension_Start + 4 + N32 (Supported_Len) - 1));
         else
            Put_Line ("Extension - Unknown");
            Extension_Len :=
               DL16 (SH (Extension_Start + 2 .. Extension_Start + 3));
            
         end if;

         Extension_Start := Extension_Start + N32 (Extension_Len) + 4;
      end loop;
   end Parse_Server_Hello;

   Client_Sock : GNAT.Sockets.Socket_Type;
   Channel     : Stream_Access;
   Read_Len    : U16;

   Server_Hello_Buffer : Byte_Seq (0 .. 1023);
   Server_Change_Cipher_Buffer : Byte_Seq (0 .. 5);
   Server_Wrapper_Header : Byte_Seq (0 .. 4);

   Test_Handshake_Secret : Digest_256;
   Test_CSecret : OKM_256 (0 .. 31);
   Test_Hello_Hash : Digest_256;
begin

   Test_Handshake_Secret := (
      16#fb#, 16#9f#, 16#c8#, 16#06#, 16#89#, 16#b3#, 16#a5#, 16#d0#, 
      16#2c#, 16#33#, 16#24#, 16#3b#, 16#f6#, 16#9a#, 16#1b#, 16#1b#, 
      16#20#, 16#70#, 16#55#, 16#88#, 16#a7#, 16#94#, 16#30#, 16#4a#, 
      16#6e#, 16#71#, 16#20#, 16#15#, 16#5e#, 16#df#, 16#14#, 16#9a#
   );

   Test_Hello_Hash := (
      16#da#, 16#75#, 16#ce#, 16#11#, 16#39#, 16#ac#, 16#80#, 16#da#, 
      16#e4#, 16#04#, 16#4d#, 16#a9#, 16#32#, 16#35#, 16#0c#, 16#f6#, 
      16#5c#, 16#97#, 16#cc#, 16#c9#, 16#e3#, 16#3f#, 16#1e#, 16#6f#, 
      16#7d#, 16#2d#, 16#4b#, 16#18#, 16#b7#, 16#36#, 16#ff#, 16#d5#
   );

   Expand_Label (OKM     => Test_CSecret,
                 PRK     => Test_Handshake_Secret,
                 Label   => "c hs traffic",
                 Context => Test_Hello_Hash);

   DH ("CSecret", Byte_Seq (Test_CSecret));

   return;

   SPARKNaCl.Cryptobox.Keypair (Raw_SK, PK, SK);

   declare
      --  Create Client Hello message
      CH : Byte_Seq := Client_Hello ("tlscipher.lan", PK);
   begin
      DH ("Client Random (for matching records in s_server keylog):", Client_Random);
      DH ("Client Hello:", CH);

      Put_Line ("Connecting to 127.0.0.1:8443");

      GNAT.Sockets.Initialize;
      GNAT.Sockets.Create_Socket (Socket => Client_Sock);
      GNAT.Sockets.Set_Socket_Option (Socket => Client_Sock,
                                      Level  => GNAT.Sockets.Socket_Level,
                                      Option => (Name    => Reuse_Address,
                                                 Enabled => True));
      GNAT.Sockets.Set_Socket_Option (Socket => Client_Sock,
                                      Level  => GNAT.Sockets.Socket_Level,
                                      Option => (Name    => GNAT.Sockets.Receive_Timeout,
                                                 Timeout => 1.0));
      GNAT.Sockets.Connect_Socket (Socket => Client_Sock,
                                   Server => (Family => GNAT.Sockets.Family_Inet,
                                              Addr   => GNAT.Sockets.Inet_Addr ("127.0.0.1"),
                                              Port   => 8443));
      Channel := GNAT.Sockets.Stream (Client_Sock);

      Put_Line ("A");
      Byte_Seq'Write (Channel, CH);
      Put_Line ("B");

      --  Read record header
      Byte_Seq'Read (Channel, Server_Hello_Buffer (0 .. 4));

      DH ("Server Hello Record Header:", Server_Hello_Buffer (0 .. 4));
      Put_Line ("Record Type: " & Server_Hello_Buffer (0)'Image);
      Put_Line ("Version:     " & 
         Server_Hello_Buffer (1)'Image & Server_Hello_Buffer (2)'Image);

      Read_Len := DL16 (Server_Hello_Buffer (3 .. 4));
      Put_Line ("Size:        " & Read_Len'Image);

      --  Read rest of message
      Byte_Seq'Read (Channel,
         Server_Hello_Buffer (5 .. 5 + Integer_32 (Read_Len) - 1));

      DH ("Handshake Message:",
         Server_Hello_Buffer (0 .. 5 + Integer_32 (Read_Len) - 1));

      Parse_Server_Hello (
         Server_Hello_Buffer (0 .. 5 + Integer_32 (Read_Len) - 1));

      --  Calculate shared secret
      --  Use server public key and client private key
      Shared_Secret := SPARKNaCl.Scalar.Mult (Raw_SK, Server_Raw_PK);

      --  Determine hash of ClientHello and ServerHello (not including
      --  5-byte record headers)
      Hash_256 (Hello_Hash, CH (5 .. CH'Last) &
                Server_Hello_Buffer (5 .. 5 + Integer_32 (Read_Len) - 1));
   
      DH ("Shared Secret:", Shared_Secret);
      Hash_256 (Empty_Hash, Empty);
      DH ("Hello Hash", Hello_Hash);

      --  Calculate early secrets and IVs
      --  If PSK is used, it would feed into this Early_Secret
      HKDF.Extract (PRK  => Early_Secret,
                    IKM  => All_Zeroes,
                    Salt => One_Zero);

      DH ("Early_Secret:", Early_Secret);

      Expand_Label (OKM     => Derived_Secret,
                    PRK     => Early_Secret,
                    Label   => "derived",
                    Context => Empty_Hash);

      DH ("Derived Secret:", Byte_Seq (Derived_Secret));

      HKDF.Extract (PRK  => Handshake_Secret,
                    IKM  => Shared_Secret,
                    Salt => Byte_Seq (Derived_Secret));

      DH ("Handshake secret: ", Handshake_Secret);

      Expand_Label (OKM     => Client_Handshake_Traffic_Secret,
                    PRK     => Handshake_Secret,
                    Label   => "c hs traffic",
                    Context => Hello_Hash);

      Expand_Label (OKM     => Server_Handshake_Traffic_Secret,
                    PRK     => Handshake_Secret,
                    Label   => "s hs traffic",
                    Context => Hello_Hash);

      Expand_Label (OKM     => Client_Handshake_Key,
                    PRK     => Byte_Seq (Client_Handshake_Traffic_Secret),
                    Label   => "key",
                    Context => Empty);

      Expand_Label (OKM     => Server_Handshake_Key,
                    PRK     => Byte_Seq (Server_Handshake_Traffic_Secret),
                    Label   => "key",
                    Context => Empty);

      Expand_Label (OKM     => Client_Handshake_IV,
                    PRK     => Byte_Seq (Client_Handshake_Traffic_Secret),
                    Label   => "iv",
                    Context => Empty);

      Expand_Label (OKM     => Server_Handshake_IV,
                    PRK     => Byte_Seq (Server_Handshake_Traffic_Secret),
                    Label   => "iv",
                    Context => Empty);

      DH ("Client handshake traffic secret: ", Byte_Seq (Client_Handshake_Traffic_Secret));
      DH ("Server handshake traffic secret: ", Byte_Seq (Server_Handshake_Traffic_Secret));
      DH ("Client handshake key:", Byte_Seq (Client_Handshake_Key));
      DH ("Server handshake key:", Byte_Seq (Server_Handshake_Key));
      DH ("Client handshake IV:", Byte_Seq (Client_Handshake_IV));
      DH ("Server handshake IV:", Byte_Seq (Server_Handshake_IV));

      --  Read Server Change Cipher Spec record (not used)
      Byte_Seq'Read (Channel, Server_Change_Cipher_Buffer);
      DH ("Read Server Change Cipher Spec:", Server_Change_Cipher_Buffer);

      --  Read encrypted wrapper
      Byte_Seq'Read (Channel, Server_Wrapper_Header);
      DH ("Read Server Wrapper Header:", Server_Wrapper_Header);
      Put_Line (" Encrypted Message Size:" & DL16 (Server_Wrapper_Header (3 .. 4))'Image);

      declare
         Encrypted_Size  : N32 := N32 (DL16 (Server_Wrapper_Header (3 .. 4)));

         --  Subtract 16 bytes from message size for the tag.
         Encrypted_Msg   : Byte_Seq (0 .. Encrypted_Size - 16 - 1);
         Decrypted_Msg   : Byte_Seq (0 .. Encrypted_Size - 16 - 1);
         Tag             : Bytes_16;
         Valid           : Boolean;

         Handshake_Key   : ChaCha20_Key
            := Construct (Byte_Seq (Server_Handshake_Key));
         
         Handshake_Nonce : ChaCha20_IETF_Nonce
            := ChaCha20_IETF_Nonce (Server_Handshake_IV);

      begin
         Byte_Seq'Read (Channel, Encrypted_Msg);
         Byte_Seq'Read (Channel, Tag);

         DH (" Encrypted Msg:", Encrypted_Msg);
         DH (" Tag:", Tag);

         --  Decrypt with Server Handshake Key and IV
         Secretbox.Open (M       => Decrypted_Msg,
                         Status  => Valid,
                         Tag     => Tag,
                         C       => Encrypted_Msg,
                         N       => Handshake_Nonce,
                         K       => Handshake_Key,
                         AAD     => Server_Wrapper_Header,
                         Counter => 0);

         Put_Line ("Valid? " & Valid'Image);
         DH (" Decrypted Msg:", Decrypted_Msg);
      end;
   end;

exception
    when E : others =>
        Ada.Text_IO.Put_Line ("Fatal error:");
        Ada.Text_IO.Put_Line (Ada.Exceptions.Exception_Message (E));
        Ada.Text_IO.Put_Line (Ada.Exceptions.Exception_Name (E));
        Ada.Text_IO.Put_Line (GNAT.Traceback.Symbolic.Symbolic_Traceback (E));
end TLS;
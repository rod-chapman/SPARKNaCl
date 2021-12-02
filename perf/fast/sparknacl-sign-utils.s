
sparknacl-sign-utils.o:     file format elf32-littleriscv


Disassembly of section .text.sparknacl__sign__utils__construct:

00000000 <sparknacl__sign__utils__construct>:
package body SPARKNaCl.Sign.Utils
is
   procedure Construct (X : in     Bytes_64;
   0:	87ae                	mv	a5,a1
   2:	1141                	addi	sp,sp,-16
                        Y :    out Signing_SK)
   is
   begin
      Y.F := X;
   4:	85aa                	mv	a1,a0

00000006 <.LVL1>:
   6:	04000613          	li	a2,64
   a:	853e                	mv	a0,a5

0000000c <.LVL2>:
   procedure Construct (X : in     Bytes_64;
   c:	c606                	sw	ra,12(sp)
      Y.F := X;
   e:	00000097          	auipc	ra,0x0
  12:	000080e7          	jalr	ra # e <.LVL2+0x2>

00000016 <.LVL3>:
   end Construct;
  16:	40b2                	lw	ra,12(sp)
  18:	0141                	addi	sp,sp,16
  1a:	8082                	ret

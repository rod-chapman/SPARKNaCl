
sparknacl-sign-utils.o:     file format elf32-littleriscv


Disassembly of section .text.sparknacl__sign__utils__construct:

00000000 <sparknacl__sign__utils__construct>:
   0:	87ae                	mv	a5,a1
   2:	1141                	addi	sp,sp,-16
   4:	85aa                	mv	a1,a0
   6:	04000613          	li	a2,64
   a:	853e                	mv	a0,a5
   c:	c606                	sw	ra,12(sp)
   e:	00000097          	auipc	ra,0x0
  12:	000080e7          	jalr	ra # e <sparknacl__sign__utils__construct+0xe>
  16:	40b2                	lw	ra,12(sp)
  18:	0141                	addi	sp,sp,16
  1a:	8082                	ret

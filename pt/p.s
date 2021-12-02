	.file	"p.adb"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.section	.text.p__f,"ax",@progbits
	.align	1
	.align	2
	.globl	p__f
	.type	p__f, @function
p__f:
.LFB2:
	.file 1 "p.adb"
	.loc 1 3 4
	.cfi_startproc
.LVL0:
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	ra,12(sp)
	.cfi_offset 1, -4
	.loc 1 7 9
	call	__gnat_mulv64
.LVL1:
	.loc 1 9 8
	lw	ra,12(sp)
	.cfi_restore 1
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE2:
	.size	p__f, .-p__f
	.section	.text.p__f2,"ax",@progbits
	.align	1
	.align	2
	.globl	p__f2
	.type	p__f2, @function
p__f2:
.LFB3:
	.loc 1 11 4
	.cfi_startproc
.LVL2:
	.loc 1 17 8
	mul	a0,a0,a1
.LVL3:
	li	a1,0
.LVL4:
	ret
	.cfi_endproc
.LFE3:
	.size	p__f2, .-p__f2
	.globl	p_E
	.section	.sdata.p_E,"aw"
	.align	1
	.type	p_E, @object
	.size	p_E, 2
p_E:
	.zero	2
	.text
.Letext0:
	.file 2 "p.ads"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x130
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.byte	0x1
	.4byte	.LASF7
	.byte	0xd
	.4byte	.LASF8
	.4byte	.LASF9
	.4byte	.Ldebug_ranges0+0
	.4byte	0
	.4byte	.Ldebug_line0
	.byte	0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF0
	.byte	0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF1
	.byte	0x3
	.byte	0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x7f
	.byte	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0
	.4byte	.LASF3
	.4byte	0x55
	.byte	0x4
	.4byte	0x33
	.byte	0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF2
	.byte	0x3
	.byte	0
	.byte	0x81,0x80,0xf8,0xff,0xf
	.4byte	.LASF4
	.4byte	0x55
	.byte	0x5
	.byte	0x2
	.byte	0x7
	.4byte	.LASF10
	.byte	0x4
	.4byte	0x6b
	.byte	0x6
	.4byte	.LASF5
	.byte	0x1
	.byte	0xb
	.byte	0x4
	.4byte	0x5c
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.byte	0x1
	.byte	0x9c
	.4byte	0xbc
	.byte	0x7
	.string	"x"
	.byte	0x2
	.byte	0xc
	.byte	0x11
	.4byte	0x72
	.4byte	.LLST2
	.byte	0x7
	.string	"y"
	.byte	0x2
	.byte	0xc
	.byte	0x14
	.4byte	0x72
	.4byte	.LLST3
	.byte	0x8
	.string	"t"
	.byte	0x1
	.byte	0xd
	.byte	0x7
	.4byte	0x5c
	.4byte	.LLST4
	.byte	0
	.byte	0x6
	.4byte	.LASF6
	.byte	0x1
	.byte	0x3
	.byte	0x4
	.4byte	0x33
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.byte	0x1
	.byte	0x9c
	.4byte	0x12a
	.byte	0x7
	.string	"x"
	.byte	0x2
	.byte	0x9
	.byte	0x10
	.4byte	0x50
	.4byte	.LLST0
	.byte	0x7
	.string	"y"
	.byte	0x2
	.byte	0x9
	.byte	0x13
	.4byte	0x50
	.4byte	.LLST1
	.byte	0x9
	.string	"t"
	.byte	0x1
	.byte	0x5
	.byte	0x7
	.4byte	0x33
	.byte	0x6
	.byte	0x5a
	.byte	0x93
	.byte	0x4
	.byte	0x5b
	.byte	0x93
	.byte	0x4
	.byte	0xa
	.4byte	.LVL1
	.4byte	0x12a
	.byte	0xb
	.byte	0x6
	.byte	0x5a
	.byte	0x93
	.byte	0x4
	.byte	0x5b
	.byte	0x93
	.byte	0x4
	.byte	0x5
	.byte	0xf3
	.byte	0x3
	.byte	0xf5
	.byte	0xa
	.byte	0x25
	.byte	0xb
	.byte	0x6
	.byte	0x5c
	.byte	0x93
	.byte	0x4
	.byte	0x5d
	.byte	0x93
	.byte	0x4
	.byte	0x5
	.byte	0xf3
	.byte	0x3
	.byte	0xf5
	.byte	0xc
	.byte	0x25
	.byte	0
	.byte	0
	.byte	0xc
	.4byte	.LASF11
	.4byte	.LASF11
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x25
	.byte	0xe
	.byte	0x13
	.byte	0xb
	.byte	0x3
	.byte	0xe
	.byte	0x1b
	.byte	0xe
	.byte	0x55
	.byte	0x17
	.byte	0x11
	.byte	0x1
	.byte	0x10
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x2
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0xe
	.byte	0x34
	.byte	0x19
	.byte	0
	.byte	0
	.byte	0x3
	.byte	0x21
	.byte	0
	.byte	0x22
	.byte	0xd
	.byte	0x2f
	.byte	0xd
	.byte	0x3
	.byte	0xe
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x4
	.byte	0x26
	.byte	0
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x5
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0xe
	.byte	0
	.byte	0
	.byte	0x6
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x97,0x42
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x7
	.byte	0x5
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x8
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x9
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0xa
	.byte	0x89,0x82,0x1
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xb
	.byte	0x8a,0x82,0x1
	.byte	0
	.byte	0x2
	.byte	0x18
	.byte	0x91,0x42
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0xc
	.byte	0x2e
	.byte	0
	.byte	0x3f
	.byte	0x19
	.byte	0x3c
	.byte	0x19
	.byte	0x6e
	.byte	0xe
	.byte	0x3
	.byte	0xe
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST2:
	.4byte	.LVL2
	.4byte	.LVL3
	.2byte	0x1
	.byte	0x5a
	.4byte	.LVL3
	.4byte	.LFE3
	.2byte	0x4
	.byte	0xf3
	.byte	0x1
	.byte	0x5a
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST3:
	.4byte	.LVL2
	.4byte	.LVL4
	.2byte	0x1
	.byte	0x5b
	.4byte	.LVL4
	.4byte	.LFE3
	.2byte	0x4
	.byte	0xf3
	.byte	0x1
	.byte	0x5b
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST4:
	.4byte	.LVL2
	.4byte	.LVL3
	.2byte	0xe
	.byte	0x7a
	.byte	0
	.byte	0xf7
	.byte	0x2c
	.byte	0xf7
	.byte	0x25
	.byte	0x7b
	.byte	0
	.byte	0xf7
	.byte	0x2c
	.byte	0xf7
	.byte	0x25
	.byte	0x1e
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST0:
	.4byte	.LVL0
	.4byte	.LVL1-1
	.2byte	0x6
	.byte	0x5a
	.byte	0x93
	.byte	0x4
	.byte	0x5b
	.byte	0x93
	.byte	0x4
	.4byte	.LVL1-1
	.4byte	.LFE2
	.2byte	0x6
	.byte	0xf3
	.byte	0x3
	.byte	0xf5
	.byte	0xa
	.byte	0x25
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST1:
	.4byte	.LVL0
	.4byte	.LVL1-1
	.2byte	0x6
	.byte	0x5c
	.byte	0x93
	.byte	0x4
	.byte	0x5d
	.byte	0x93
	.byte	0x4
	.4byte	.LVL1-1
	.4byte	.LFE2
	.2byte	0x6
	.byte	0xf3
	.byte	0x3
	.byte	0xf5
	.byte	0xc
	.byte	0x25
	.byte	0x9f
	.4byte	0
	.4byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x24
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.4byte	0
	.4byte	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.4byte	.LFB2
	.4byte	.LFE2
	.4byte	.LFB3
	.4byte	.LFE3
	.4byte	0
	.4byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF2:
	.string	"interfaces__Tinteger_64B"
.LASF5:
	.string	"p__f2"
.LASF8:
	.string	"p.adb"
.LASF7:
	.ascii	"GNU Ada 9.3.1 20200430 (for GNAT Community 2020 20200429) -O"
	.ascii	"1 -O1 -gnatA -fRTS=/home/rchapman/gnat/2020-r"
	.string	"iscv32-elf/riscv32-elf/lib/gnat/zfp-rv32imc/ -march=rv32imc -mabi=ilp32 -gnatwa -gnatwe -fcallgraph-info=su,da -g -march=rv32imc -falign-functions=4 -falign-jumps=4 -falign-loops=4 -falign-labels=4 -gnaty -ffunction-sections -fdata-sections -gnatw.X -gnatQ"
.LASF6:
	.string	"p__f"
.LASF9:
	.string	"/media/psf/Home/Desktop/prog/SPARKNaCl/pt"
.LASF0:
	.string	"UNSIGNED_64"
.LASF4:
	.string	"p__s3___XDLU_0__4294836225"
.LASF3:
	.string	"p__s"
.LASF11:
	.string	"__gnat_mulv64"
.LASF10:
	.string	"interfaces__unsigned_16"
.LASF1:
	.string	"UNSIGNED_32"
	.ident	"GCC: (GNU) 9.3.1 20200430 (for GNAT Community 2020 20200429)"

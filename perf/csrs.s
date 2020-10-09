        /********************/
        /* _rv32_read_cycle */
        /********************/

        .section .text
	
        .globl _rv32_read_cycle
_rv32_read_cycle:
	/* Note that we loop here to check the msb doesn't change   */
	/* while reading the lsb. See RISC-V ISA Specification 10.1 */
        rdcycleh t0
        rdcycle  t1
        rdcycleh t2
        bne t0, t2, _rv32_read_cycle
	mv a0, t1
	mv a1, t2
	ret
	
        /*******************/
        /* _rv32_read_time */
        /*******************/
	
        .globl _rv32_read_time
_rv32_read_time:
	/* Note that we loop here to check the msb doesn't change   */
	/* while reading the lsb. See RISC-V ISA Specification 10.1 */
        rdtimeh t0
        rdtime  t1
        rdtimeh t2
        bne t0, t2, _rv32_read_time
	mv a0, t1
	mv a1, t2
	ret
	
        /**********************/
        /* _rv32_read_instret */
        /**********************/
	
        .globl _rv32_read_instret
_rv32_read_instret:
	/* Note that we loop here to check the msb doesn't change   */
	/* while reading the lsb. See RISC-V ISA Specification 10.1 */
        rdinstreth t0
        rdinstret  t1
        rdinstreth t2
        bne t0, t2, _rv32_read_instret
	mv a0, t1
	mv a1, t2
	ret
	
        .globl _rv32_read_mhpmcounter3	
_rv32_read_mhpmcounter3:
	/* Note that we loop here to check the msb doesn't change   */
	/* while reading the lsb. See RISC-V ISA Specification 10.1 */
        csrrs	t0, mhpmcounter3h, x0
        csrrs	t1, mhpmcounter3, x0
        csrrs	t2, mhpmcounter3h, x0
/*         bne	t0, t2, _rv32_read_mhpmcounter3 */
/*	mv a0, t1 */
/* 	mv a1, t2 */
	mv a0, t1
	mv a1, x0
	ret
	
        .globl _rv32_read_mhpmcounter4	
_rv32_read_mhpmcounter4:
	/* Note that we loop here to check the msb doesn't change   */
	/* while reading the lsb. See RISC-V ISA Specification 10.1 */
        csrrs	t0, mhpmcounter4h, x0
        csrrs	t1, mhpmcounter4, x0
        csrrs	t2, mhpmcounter4h, x0
        bne	t0, t2, _rv32_read_mhpmcounter4
	mv a0, t1
	mv a1, t2
	ret
	
        .globl _write_mhpmevent3
_write_mhpmevent3:
	csrw	mhpmevent3, a0
	ret
	
        .globl _write_mhpmevent4
_write_mhpmevent4:
	csrw	mhpmevent4, a0
	ret

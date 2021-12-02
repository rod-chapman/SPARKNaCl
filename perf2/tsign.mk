all: tsign.hex tsign.asm

tsign: tsign.adb io.adb io.ads q.adb p.adb
	gprbuild -Ptsign -v -XSPARKNACL_RUNTIME_MODE=zfp -XSPARKNACL_RUNTIME_CHECKS=disabled -XSPARKNACL_CONTRACTS=disabled
	@mv main.map tsign.map
	@grep "^.data" tsign.map
	@grep "^.bss" tsign.map
	@grep "__stack_start =" tsign.map
	@grep "__stack_end =" tsign.map
	@grep "__bss_start =" tsign.map
	@grep "__bss_end =" tsign.map

tsign.hex: tsign
	riscv32-elf-objcopy -O ihex tsign tsign.hex

tsign.asm: tsign
	riscv32-elf-objdump -S tsign >tsign.asm

stack: tsign
	gnatstack -Ptsign

run: tsign.hex
	cp tsign.hex /media/rchapman/HiFive

q.s: q.adb
	gprbuild -Ptsign -v -XSPARKNACL_RUNTIME_MODE=zfp -XSPARKNACL_RUNTIME_CHECKS=disabled -XSPARKNACL_CONTRACTS=disabled q.adb
	riscv32-elf-objdump -S q.o >q.s

clean:
	rm -f tsign.hex
	rm -f tsign.map
	rm -f d.ci
	rm -f devurandom.ci
	rm -f graph.vcg
	rm -f tweetnacl.ci
	rm -f undefined.ciu
	gprclean -Ptsign

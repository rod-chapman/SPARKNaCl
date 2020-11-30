all: tbox.hex tbox.asm

tbox: tbox.adb io.adb io.ads tweetnacl_api.ads tweetnacl.c
	gprbuild -Ptbox -v -XSPARKNACL_RUNTIME_MODE=zfp -XSPARKNACL_RUNTIME_CHECKS=disabled -XSPARKNACL_CONTRACTS=disabled
	@mv main.map tbox.map
	@grep "^.data" tbox.map
	@grep "^.bss" tbox.map
	@grep "__stack_start =" tbox.map
	@grep "__stack_end =" tbox.map
	@grep "__bss_start =" tbox.map
	@grep "__bss_end =" tbox.map

tbox.hex: tbox
	riscv32-elf-objcopy -O ihex tbox tbox.hex

tbox.asm: tbox
	riscv32-elf-objdump -S tbox >tbox.asm

stack: tbox
	gnatstack -Ptbox

run: tbox.hex
	cp tbox.hex /media/rchapman/HiFive

clean:
	rm -f tbox.hex
	rm -f tbox.map
	rm -f d.ci
	rm -f devurandom.ci
	rm -f graph.vcg
	rm -f tweetnacl.ci
	rm -f undefined.ciu
	gprclean -Ptbox

all: sizes.txt

SIZE_OBJS := sparknacl.o sparknacl-car.o sparknacl-core.o sparknacl-cryptobox.o sparknacl-hashing.o sparknacl-mac.o sparknacl-scalar.o sparknacl-secretbox.o sparknacl-sign.o sparknacl-sign-utils.o sparknacl-stream.o sparknacl-utils.o

sizes.txt: tsize.adb io.adb io.ads tweetnacl_api.ads tweetnacl.c
	gprbuild -Ptsize -v
	riscv32-elf-strip $(SIZE_OBJS)
	riscv32-elf-strip tweetnacl.o
	@echo "Results for SPARKNaCl"
	@echo "Results for SPARKNaCl" >sizes.txt
	riscv32-elf-size -t $(SIZE_OBJS)
	@riscv32-elf-size -t $(SIZE_OBJS) >>sizes.txt
	@echo "Results for TweetNaCl"
	@echo "Results for TweetNaCl" >>sizes.txt
	riscv32-elf-size -t tweetnacl.o
	@riscv32-elf-size -t tweetnacl.o >>sizes.txt
	riscv32-elf-objdump -h $(SIZE_OBJS) | fgrep ".text." >st.txt
	riscv32-elf-objdump -h $(SIZE_OBJS) | fgrep ".rodata." >sd.txt
	riscv32-elf-objdump -h tweetnacl.o | fgrep ".text." >tt.txt
	riscv32-elf-objdump -h tweetnacl.o | fgrep ".rodata." >td.txt

clean:
	rm -f sizes.txt
	rm -f st.txt
	rm -f sd.txt
	rm -f tt.txt
	rm -f td.txt
	rm -f tsize.map
	rm -f d.ci
	rm -f devurandom.ci
	rm -f graph.vcg
	rm -f tweetnacl.ci
	rm -f undefined.ciu
	gprclean -Ptsize -r

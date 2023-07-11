NAME:=rfsb509

FGNAT:=-v -XSPARKNACL_RUNTIME_MODE=zfp -XSPARKNACL_RUNTIME_CHECKS=disabled
FGNAT+= -XSPARKNACL_CONTRACTS=disabled -XSPARKNACL_BUILD_MODE=O2

SRCS:=$(shell find src -type f -name ".ad[s|b]")
CONF:=$(NAME).gpr $(NAME).ld 

all: $(NAME).hex $(NAME).asm

obj/$(NAME): $(CONF) $(SRCS)
	gprbuild -j4 -P$(NAME) $(FGNAT) -XSPARKNACL_TARGET_ARCH=rv32imc_a4 

$(NAME).hex: obj/$(NAME)
	riscv64-elf-objcopy -O ihex $^ $@

$(NAME).asm: obj/$(NAME)
	riscv64-elf-objdump -S $^ > $@

.PHONY: all clean
clean:
	rm -f $(NAME).hex
	rm -f $(NAME).asm
	gprclean -P$(NAME) -r

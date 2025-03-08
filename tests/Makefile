GPR_WORKERS:=-j0
SOURCES:= src/ada/*.adb src/c/*.c src/c/*.h ../src/*.adb ../src/*.ads testall.gpr
HOSTOS := $(shell uname -s)

all: fntr sntr ftestdiff stestdiff

ftestdiff: expected_test_results fntr
	diff $^

stestdiff: expected_test_results sntr
	diff $^

fntr: ftestall
	./ftestall > $@

sntr: stestall
	./stestall > $@

ftestall: $(SOURCES)
	$(MAKE) clean_build
	$(MAKE) clean_ftest
	gprbuild -Ptestall \
	$(GPR_WORKERS) \
	-XSPARKNACL_RUNTIME_CHECKS=disabled \
	-XSPARKNACL_CONTRACTS=disabled \
	-XSPARKNACL_HOSTOS=$(HOSTOS) \
	-XSPARKNACL_BUILD_MODE=O3
	mv obj/testall $@

stestall: $(SOURCES)
	$(MAKE) clean_build
	$(MAKE) clean_stest
	gprbuild -Ptestall \
	$(GPR_WORKERS) \
	-XSPARKNACL_RUNTIME_CHECKS=enabled \
	-XSPARKNACL_CONTRACTS=enabled \
	-XSPARKNACL_HOSTOS=$(HOSTOS) \
	-XSPARKNACL_BUILD_MODE=debug
	mv obj/testall $@

scalarspeed: src/ada/scalarspeed.adb ../src/*.adb ../src/*.ads
	$(MAKE) clean_build
	$(MAKE) clean_scalar_build
	gprbuild -Pscalarspeed \
	$(GPR_WORKERS) \
	-XSPARKNACL_RUNTIME_CHECKS=disabled \
	-XSPARKNACL_CONTRACTS=disabled \
	-XSPARKNACL_HOSTOS=$(HOSTOS) \
	-XSPARKNACL_BUILD_MODE=O3
	mv obj/$@ $@

.PHONY: all clean_build clean_stest clean_ftest clean_scalarspeed clean
clean_build:
	gprclean -r -Ptestall
	gprclean -r -Pscalarspeed
clean_stest:
	rm -f sntr stestall
clean_ftest:
	rm -f fntr ftestall
clean_scalarspeed:
	rm -f scalarspeed
clean:
	$(MAKE) clean_build
	$(MAKE) clean_stest
	$(MAKE) clean_ftest
	$(MAKE) clean_scalarspeed

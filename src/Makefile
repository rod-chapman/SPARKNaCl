SPARK_Bodies := sparknacl.adb sparknacl-core.adb sparknacl-stream.adb sparknacl-hashing.adb sparknacl-scalar.adb sparknacl-mac.adb sparknacl-secretbox.adb sparknacl-cryptobox.adb sparknacl-sign.adb sparknacl-utils.adb

Non_SPARK_Bodies := sparknacl-debug.adb

all: build

build: $(SPARK_Bodies) $(Non_SPARK_Bodies) *.ads
	gprbuild

flow: $(SPARK_Bodies)
	gnatprove -Psparknacl --mode=flow --report=fail -u $(SPARK_Bodies)

flowall: $(SPARK_Bodies)
	gnatprove -Psparknacl --mode=flow --report=all -u $(SPARK_Bodies)

proof: $(SPARK_Bodies)
	gnatprove -Psparknacl --report=fail -u $(SPARK_Bodies)

proofall: $(SPARK_Bodies)
	gnatprove -Psparknacl --report=all -u $(SPARK_Bodies)

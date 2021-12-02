all: sign

sign: sign.o d.o ../lib/libSparknacl.a
	gcc -o sign sign.o d.o ../lib/libSparknacl.a

sign.o: sign.c
	gcc -c -Wall sign.c

d.o: ../perf/d.c
	gcc -c -Wall ../perf/d.c

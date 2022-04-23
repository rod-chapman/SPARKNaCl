all: fntr sntr ftestdiff stestdiff tls

fall: fntr ftestdiff

ftestdiff: fntr
	diff expected_test_results fntr

stestdiff: sntr
	diff expected_test_results sntr

fntr: ftestall
	./ftestall >fntr

sntr: stestall
	./stestall >sntr

ftestall: *.adb ../src/*.adb ../src/*.ads
	gprclean -r -Ptestall
	rm -f fntr
	rm -f ftestall
	gprbuild -Ptestall -XSPARKNACL_RUNTIME_CHECKS=disabled -XSPARKNACL_CONTRACTS=disabled -XSPARKNACL_BUILD_MODE=O3
	mv testall ftestall

stestall: *.adb ../src/*.adb ../src/*.ads
	gprclean -r -Ptestall
	rm -f sntr
	rm -f stestall
	gprbuild -Ptestall -XSPARKNACL_RUNTIME_CHECKS=enabled -XSPARKNACL_CONTRACTS=enabled -XSPARKNACL_BUILD_MODE=debug
	mv testall stestall

tls: tls.adb ../src/*.adb ../src/*.ads
	gprclean -r -Ptestall
	gprclean -r -Ptls
	rm -f tls
	gprbuild -Ptls -XSPARKNACL_RUNTIME_CHECKS=enabled -XSPARKNACL_CONTRACTS=enabled -XSPARKNACL_BUILD_MODE=debug

@PHONY: tlscert
tlscert: openssl-25519.cnf
	@echo
	@echo -----------------------------------------
	@echo Generating Private ED25519 key
	@echo -----------------------------------------
	openssl genpkey -algorithm ED25519 > tlscipher.lan.key

	@echo
	@echo -----------------------------------------
	@echo Creating certificate signing request
	@echo -----------------------------------------
	openssl req -new -out tlscipher.lan.csr -key tlscipher.lan.key -config openssl-25519.cnf
	openssl req -in tlscipher.lan.csr -text -noout

	@echo
	@echo -----------------------------------------
	@echo Self-signing certificate
	@echo -----------------------------------------
	openssl x509 -req -days 700 -in tlscipher.lan.csr -signkey tlscipher.lan.key -out tlscipher.lan.crt
	openssl x509 -in tlscipher.lan.crt -text -noout

	@echo -----------------------------------------
	@echo Run server with:
	@echo openssl s_server -tls1_3 -key tlscipher.lan.key -cert tlscipher.lan.crt -sigalgs "ed25519" -ciphersuites "TLS_CHACHA20_POLY1305_SHA256" -debug

clean:
	gprclean -r -Ptestall
	rm -f ftestall
	rm -f stestall
	rm -f fntr
	rm -f sntr

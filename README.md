# SPARKNaCl
SPARK 2014 re-implementation of the TweetNaCl crypto library

## TO DO

An incomplete list of ideas:

1. Complete type safety proofs. Requires detailed understanding of the invariant properties of each "limb" of a GF object. (50 marks)

2. Strengthen types in sparknacl.ads - for example use different named types for each distinct flavour of key and nonce to prevent them being confused. (Done 12/11/19)

3. Use limited-private, volatile types for keys and nonces, and provide an explicit "Sanitize" procedure for them.

4. Split into one child package for each major functional area, so SPARKNaCl.Secret_Box.Open instead of SPARKNaCl.Crypto_Secretbox_Open for example. (Done 6/11/2019)

5. Re-implement body using more Ada idioms, including:
  - Redeclare the arithmetic operators on GF, so we can use functional infix "C := A * B" style rather than "M (C, A, B)". (Done 12/11/19)

  - Ditto for procedures that return a single "out" parameter of a composite type. Make it a function! (Done 12/11/2019)

  - Introduce nesting of local subprograms, particularly those with only one calling subprogram. (Done 12/11/19)

6. Full performance test against tweetnacl.c

7. Structural coverage analysis based on tests/testall.adb run.

# SPARKNaCl
SPARK 2014 re-implementation of the TweetNaCl crypto library

## TO DO

An incomplete list of ideas:

1. Complete type safety proofs
2. Strengthen types in sparknacl.ads - for example use different named types for each distinct flavour of key and nonce to prevent them being confused.
3. Re-implement body using more Ada idioms, including:
  - Redeclare the arithmetic operators on GF, so we can use functional infix "A * B" style rather than "M (A, B)".
  - Ditto for procedures that return a single "out" parameter of a composite type. Make it a function!
  - Introduce nesting of local subprograms, particularly those with only one calling subprogram.
4. Full performance test against tweetnacl.c
5. Structural coverage analysis based on tests/testall.adb run.

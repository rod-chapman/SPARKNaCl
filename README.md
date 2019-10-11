# SPARKNaCl
SPARK 2014 re-implementation of the TweetNaCl crypto library

##TO DO##

An incomplete list of ideas:

1. Complete type safety proofs
2. Strengthen types in sparknacl.ads - for example
   use different named types for each distinct flavour of
   key and nonce to prevent them being confused.
3. Re-implement body using more Ada idioms, such as
   redeclaring the arithmetic operators on GF, so we can
   use functional infix "A * B" style rather
   than "M (A, B)" for example.
4. Full performance test against tweetnacl.c

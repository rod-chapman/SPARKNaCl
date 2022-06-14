with SPARKNaCl; use SPARKNaCl;
with SPARKNaCl.Car; use SPARKNaCl.Car;
procedure MTest
is
   L : constant Normal_GF := (16#9EDF#,
                              16#7DDB#,
                              16#7D7B#,
                              16#B4C1#,
                              16#5BD3#,
                              16#C261#,
                              16#E4EC#,
                              16#3735#,
                              16#833F#,
                              16#C843#,
                              16#785B#,
                              16#4D67#,
                              16#FCAD#,
                              16#147E#,
                              16#886F#,
                              16#4F2B#);
   R : constant Normal_GF := (16#9EDF#,
                              16#7DDB#,
                              16#7D7B#,
                              16#B4C1#,
                              16#5BD3#,
                              16#C261#,
                              16#E4EC#,
                              16#3735#,
                              16#833F#,
                              16#C843#,
                              16#785B#,
                              16#4D67#,
                              16#FCAD#,
                              16#147E#,
                              16#886F#,
                              16#4F2B#);


   M : Normal_GF;
begin
   M := L * L;
end MTest;

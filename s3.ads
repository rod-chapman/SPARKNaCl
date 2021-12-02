with Interfaces; use Interfaces;
package S3
  with SPARK_Mode => On
is
   subtype I64 is Integer_64;

   function Shift_Right_Arithmetic (Value  : I64;
                                    Amount : Natural) return I64
     with Import,
          Convention => Intrinsic;

   function ASR_4 (X : in I64) return I64
   is (Shift_Right_Arithmetic (X, 4))
     with Post => (if X >= 0 then ASR_4'Result = X / 16 else
                                  ASR_4'Result = ((X + 1) / 16) - 1);

end S3;

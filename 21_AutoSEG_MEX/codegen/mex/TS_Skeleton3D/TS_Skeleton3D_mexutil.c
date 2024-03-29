/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * TS_Skeleton3D_mexutil.c
 *
 * Code generation for function 'TS_Skeleton3D_mexutil'
 *
 */

/* Include files */
#include "TS_Skeleton3D_mexutil.h"
#include "TS_Skeleton3D.h"
#include "rt_nonfinite.h"

/* Function Definitions */
int32_T div_s32(const emlrtStack *sp, int32_T numerator, int32_T denominator)
{
  int32_T quotient;
  uint32_T b_numerator;
  uint32_T b_denominator;
  if (denominator == 0) {
    emlrtDivisionByZeroErrorR2012b(NULL, sp);
  } else {
    if (numerator < 0) {
      b_numerator = ~(uint32_T)numerator + 1U;
    } else {
      b_numerator = (uint32_T)numerator;
    }

    if (denominator < 0) {
      b_denominator = ~(uint32_T)denominator + 1U;
    } else {
      b_denominator = (uint32_T)denominator;
    }

    b_numerator /= b_denominator;
    if ((numerator < 0) != (denominator < 0)) {
      quotient = -(int32_T)b_numerator;
    } else {
      quotient = (int32_T)b_numerator;
    }
  }

  return quotient;
}

/* End of code generation (TS_Skeleton3D_mexutil.c) */

/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * repmat.c
 *
 * Code generation for function 'repmat'
 *
 */

/* Include files */
#include "repmat.h"
#include "TS_Skeleton3D.h"
#include "TS_Skeleton3D_data.h"
#include "TS_Skeleton3D_emxutil.h"
#include "assertValidSizeArg.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRTEInfo cc_emlrtRTEI = { 53,/* lineNo */
  9,                                   /* colNo */
  "repmat",                            /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/repmat.m"/* pName */
};

/* Function Definitions */
void repmat(const emlrtStack *sp, const real_T varargin_1[3], emxArray_boolean_T
            *b)
{
  int32_T i;
  int32_T loop_ub;
  int32_T i1;
  int32_T i2;
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &o_emlrtRSI;
  assertValidSizeArg(&st, varargin_1);
  i = (int32_T)varargin_1[0];
  loop_ub = b->size[0] * b->size[1] * b->size[2];
  b->size[0] = i;
  i1 = (int32_T)varargin_1[1];
  b->size[1] = i1;
  i2 = (int32_T)varargin_1[2];
  b->size[2] = i2;
  emxEnsureCapacity_boolean_T(sp, b, loop_ub, &cc_emlrtRTEI);
  loop_ub = i * i1 * i2;
  for (i = 0; i < loop_ub; i++) {
    b->data[i] = false;
  }
}

/* End of code generation (repmat.c) */

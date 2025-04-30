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
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "assertValidSizeArg.h"
#include "eml_int_forloop_overflow_check.h"
#include "mwmathutil.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo yf_emlrtRSI = { 64, /* lineNo */
  "repmat",                            /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/repmat.m"/* pathName */
};

static emlrtRTEInfo be_emlrtRTEI = { 53,/* lineNo */
  9,                                   /* colNo */
  "repmat",                            /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/repmat.m"/* pName */
};

static emlrtRTEInfo lf_emlrtRTEI = { 1,/* lineNo */
  14,                                  /* colNo */
  "repmat",                            /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/repmat.m"/* pName */
};

/* Function Definitions */
void b_repmat(const emlrtStack *sp, const real_T a[3], const real_T varargin_1[2],
              emxArray_real_T *b)
{
  int32_T k;
  boolean_T exitg1;
  real_T b_varargin_1;
  int32_T i;
  boolean_T overflow;
  int32_T ibmat;
  int32_T itilerow;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &uc_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  k = 0;
  exitg1 = false;
  while ((!exitg1) && (k < 2)) {
    if ((varargin_1[k] != varargin_1[k]) || muDoubleScalarIsInf(varargin_1[k]))
    {
      emlrtErrorWithMessageIdR2018a(&st, &i_emlrtRTEI,
        "Coder:toolbox:eml_assert_valid_size_arg_invalidSizeVector",
        "Coder:toolbox:eml_assert_valid_size_arg_invalidSizeVector", 4, 12,
        MIN_int32_T, 12, MAX_int32_T);
    } else {
      k++;
    }
  }

  if (varargin_1[0] <= 0.0) {
    b_varargin_1 = 0.0;
  } else {
    b_varargin_1 = varargin_1[0];
  }

  if (varargin_1[1] <= 0.0) {
    b_varargin_1 = 0.0;
  } else {
    b_varargin_1 *= varargin_1[1];
  }

  if (!(b_varargin_1 <= 2.147483647E+9)) {
    emlrtErrorWithMessageIdR2018a(&st, &j_emlrtRTEI, "Coder:MATLAB:pmaxsize",
      "Coder:MATLAB:pmaxsize", 0);
  }

  i = (int32_T)varargin_1[0];
  k = b->size[0] * b->size[1];
  b->size[0] = i;
  b->size[1] = 3;
  emxEnsureCapacity_real_T(sp, b, k, &lf_emlrtRTEI);
  st.site = &yf_emlrtRSI;
  overflow = ((1 <= i) && (i > 2147483646));
  for (k = 0; k < 3; k++) {
    ibmat = k * i;
    st.site = &xf_emlrtRSI;
    if (overflow) {
      b_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&b_st);
    }

    for (itilerow = 0; itilerow < i; itilerow++) {
      b->data[ibmat + itilerow] = a[k];
    }
  }
}

void c_repmat(const real_T a[3], real_T b[6141])
{
  int32_T jcol;
  int32_T ibmat;
  int32_T itilerow;
  for (jcol = 0; jcol < 3; jcol++) {
    ibmat = jcol * 2047;
    for (itilerow = 0; itilerow < 2047; itilerow++) {
      b[ibmat + itilerow] = a[jcol];
    }
  }
}

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
  st.site = &uc_emlrtRSI;
  assertValidSizeArg(&st, varargin_1);
  i = (int32_T)varargin_1[0];
  loop_ub = b->size[0] * b->size[1] * b->size[2];
  b->size[0] = i;
  i1 = (int32_T)varargin_1[1];
  b->size[1] = i1;
  i2 = (int32_T)varargin_1[2];
  b->size[2] = i2;
  emxEnsureCapacity_boolean_T(sp, b, loop_ub, &be_emlrtRTEI);
  loop_ub = i * i1 * i2;
  for (i = 0; i < loop_ub; i++) {
    b->data[i] = false;
  }
}

/* End of code generation (repmat.c) */

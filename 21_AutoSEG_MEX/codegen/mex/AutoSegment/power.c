/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * power.c
 *
 * Code generation for function 'power'
 *
 */

/* Include files */
#include "power.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo nf_emlrtRSI = { 55, /* lineNo */
  "power",                             /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/ops/power.m"/* pathName */
};

static emlrtRSInfo of_emlrtRSI = { 64, /* lineNo */
  "fltpower",                          /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/ops/power.m"/* pathName */
};

static emlrtRTEInfo if_emlrtRTEI = { 64,/* lineNo */
  5,                                   /* colNo */
  "power",                             /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/ops/power.m"/* pName */
};

/* Function Definitions */
void b_power(const real_T a[6141], real_T y[6141])
{
  int32_T k;
  for (k = 0; k < 6141; k++) {
    y[k] = a[k] * a[k];
  }
}

void c_power(const real_T a[3], real_T y[3])
{
  y[0] = a[0] * a[0];
  y[1] = a[1] * a[1];
  y[2] = a[2] * a[2];
}

void power(const emlrtStack *sp, const emxArray_real_T *a, emxArray_real_T *y)
{
  int32_T nx;
  int32_T k;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &nf_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  b_st.site = &of_emlrtRSI;
  nx = y->size[0] * y->size[1];
  y->size[0] = a->size[0];
  y->size[1] = 3;
  emxEnsureCapacity_real_T(&b_st, y, nx, &if_emlrtRTEI);
  c_st.site = &lf_emlrtRSI;
  nx = a->size[0] * 3;
  d_st.site = &mf_emlrtRSI;
  if ((1 <= nx) && (nx > 2147483646)) {
    e_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&e_st);
  }

  for (k = 0; k < nx; k++) {
    y->data[k] = a->data[k] * a->data[k];
  }
}

/* End of code generation (power.c) */

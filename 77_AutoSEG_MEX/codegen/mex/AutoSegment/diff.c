/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * diff.c
 *
 * Code generation for function 'diff'
 *
 */

/* Include files */
#include "diff.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo xh_emlrtRSI = { 108,/* lineNo */
  "diff",                              /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/diff.m"/* pathName */
};

static emlrtRTEInfo bh_emlrtRTEI = { 1,/* lineNo */
  14,                                  /* colNo */
  "diff",                              /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/diff.m"/* pName */
};

/* Function Definitions */
void b_diff(const emlrtStack *sp, const emxArray_real32_T *x, emxArray_real32_T *
            y)
{
  int32_T dimSize;
  int32_T ixLead;
  int32_T iyLead;
  real32_T work_data_idx_0;
  int32_T m;
  real32_T tmp1;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  dimSize = x->size[0];
  ixLead = y->size[0];
  y->size[0] = x->size[0] - 1;
  emxEnsureCapacity_real32_T(sp, y, ixLead, &bh_emlrtRTEI);
  ixLead = 1;
  iyLead = 0;
  work_data_idx_0 = x->data[0];
  st.site = &yh_emlrtRSI;
  if ((2 <= x->size[0]) && (x->size[0] > 2147483646)) {
    b_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  for (m = 2; m <= dimSize; m++) {
    st.site = &xh_emlrtRSI;
    tmp1 = x->data[ixLead] - work_data_idx_0;
    work_data_idx_0 = x->data[ixLead];
    ixLead++;
    y->data[iyLead] = tmp1;
    iyLead++;
  }
}

void diff(const real_T x[6144], real_T y[6141])
{
  int32_T ixStart;
  int32_T iyStart;
  int32_T r;
  int32_T ixLead;
  int32_T iyLead;
  real_T work;
  int32_T m;
  real_T tmp2;
  ixStart = 1;
  iyStart = 0;
  for (r = 0; r < 3; r++) {
    ixLead = ixStart;
    iyLead = iyStart;
    work = x[ixStart - 1];
    for (m = 0; m < 2047; m++) {
      tmp2 = work;
      work = x[ixLead];
      y[iyLead] = x[ixLead] - tmp2;
      ixLead++;
      iyLead++;
    }

    ixStart += 2048;
    iyStart += 2047;
  }
}

/* End of code generation (diff.c) */

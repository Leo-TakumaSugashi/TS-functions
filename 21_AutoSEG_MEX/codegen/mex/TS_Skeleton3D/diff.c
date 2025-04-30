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
#include "TS_Skeleton3D.h"
#include "TS_Skeleton3D_data.h"
#include "TS_Skeleton3D_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo yb_emlrtRSI = { 108,/* lineNo */
  "diff",                              /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/datafun/diff.m"/* pathName */
};

static emlrtRSInfo ac_emlrtRSI = { 106,/* lineNo */
  "diff",                              /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/datafun/diff.m"/* pathName */
};

static emlrtRTEInfo gc_emlrtRTEI = { 1,/* lineNo */
  14,                                  /* colNo */
  "diff",                              /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/datafun/diff.m"/* pName */
};

/* Function Definitions */
void diff(const emlrtStack *sp, const emxArray_real32_T *x, emxArray_real32_T *y)
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
  emxEnsureCapacity_real32_T(sp, y, ixLead, &gc_emlrtRTEI);
  ixLead = 1;
  iyLead = 0;
  work_data_idx_0 = x->data[0];
  st.site = &ac_emlrtRSI;
  if ((2 <= x->size[0]) && (x->size[0] > 2147483646)) {
    b_st.site = &s_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  for (m = 2; m <= dimSize; m++) {
    st.site = &yb_emlrtRSI;
    tmp1 = x->data[ixLead] - work_data_idx_0;
    work_data_idx_0 = x->data[ixLead];
    ixLead++;
    y->data[iyLead] = tmp1;
    iyLead++;
  }
}

/* End of code generation (diff.c) */

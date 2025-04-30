/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sum.c
 *
 * Code generation for function 'sum'
 *
 */

/* Include files */
#include "sum.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo ue_emlrtRSI = { 168,/* lineNo */
  "colMajorFlatIter",                  /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/private/combineVectorElements.m"/* pathName */
};

static emlrtRSInfo we_emlrtRSI = { 186,/* lineNo */
  "colMajorFlatIter",                  /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/private/combineVectorElements.m"/* pathName */
};

static emlrtRSInfo df_emlrtRSI = { 151,/* lineNo */
  "colMajorFlatIter",                  /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/private/combineVectorElements.m"/* pathName */
};

static emlrtRTEInfo we_emlrtRTEI = { 20,/* lineNo */
  1,                                   /* colNo */
  "sum",                               /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/sum.m"/* pName */
};

static emlrtRTEInfo xe_emlrtRTEI = { 124,/* lineNo */
  13,                                  /* colNo */
  "combineVectorElements",             /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/private/combineVectorElements.m"/* pName */
};

/* Function Definitions */
void b_sum(const emlrtStack *sp, const emxArray_real_T *x, emxArray_real_T *y)
{
  int32_T vlen;
  uint32_T sz_idx_1;
  int32_T npages;
  int32_T xpageoffset;
  int32_T i;
  int32_T k;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &qe_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  b_st.site = &re_emlrtRSI;
  vlen = x->size[0];
  if ((x->size[0] == 0) || (x->size[1] == 0)) {
    sz_idx_1 = (uint32_T)x->size[1];
    xpageoffset = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = (int32_T)sz_idx_1;
    emxEnsureCapacity_real_T(&b_st, y, xpageoffset, &we_emlrtRTEI);
    i = (int32_T)sz_idx_1;
    for (xpageoffset = 0; xpageoffset < i; xpageoffset++) {
      y->data[xpageoffset] = 0.0;
    }
  } else {
    c_st.site = &se_emlrtRSI;
    npages = x->size[1];
    xpageoffset = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = x->size[1];
    emxEnsureCapacity_real_T(&c_st, y, xpageoffset, &xe_emlrtRTEI);
    d_st.site = &te_emlrtRSI;
    if (x->size[1] > 2147483646) {
      e_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    for (i = 0; i < npages; i++) {
      xpageoffset = i * x->size[0];
      y->data[i] = x->data[xpageoffset];
      d_st.site = &ve_emlrtRSI;
      if ((2 <= vlen) && (vlen > 2147483646)) {
        e_st.site = &i_emlrtRSI;
        check_forloop_overflow_error(&e_st);
      }

      for (k = 2; k <= vlen; k++) {
        y->data[i] += x->data[(xpageoffset + k) - 1];
      }
    }
  }
}

real_T c_sum(const emlrtStack *sp, const emxArray_real_T *x)
{
  real_T y;
  int32_T vlen;
  int32_T k;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &qe_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  b_st.site = &re_emlrtRSI;
  vlen = x->size[1];
  if (x->size[1] == 0) {
    y = 0.0;
  } else {
    c_st.site = &se_emlrtRSI;
    y = x->data[0];
    d_st.site = &ve_emlrtRSI;
    if ((2 <= x->size[1]) && (x->size[1] > 2147483646)) {
      e_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    for (k = 2; k <= vlen; k++) {
      y += x->data[k - 1];
    }
  }

  return y;
}

void d_sum(const emlrtStack *sp, const emxArray_real_T *x, emxArray_real_T *y)
{
  int32_T vlen;
  uint32_T sz_idx_0;
  int32_T vstride;
  int32_T k;
  int32_T j;
  int32_T xoffset;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &qe_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  b_st.site = &re_emlrtRSI;
  vlen = x->size[1];
  if ((x->size[0] == 0) || (x->size[1] == 0)) {
    sz_idx_0 = (uint32_T)x->size[0];
    k = y->size[0];
    y->size[0] = (int32_T)sz_idx_0;
    emxEnsureCapacity_real_T(&b_st, y, k, &we_emlrtRTEI);
    j = (int32_T)sz_idx_0;
    for (k = 0; k < j; k++) {
      y->data[k] = 0.0;
    }
  } else {
    c_st.site = &se_emlrtRSI;
    vstride = x->size[0];
    k = y->size[0];
    y->size[0] = x->size[0];
    emxEnsureCapacity_real_T(&c_st, y, k, &xe_emlrtRTEI);
    d_st.site = &ue_emlrtRSI;
    if (x->size[0] > 2147483646) {
      e_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    for (j = 0; j < vstride; j++) {
      y->data[j] = x->data[j];
    }

    d_st.site = &ve_emlrtRSI;
    if ((2 <= x->size[1]) && (x->size[1] > 2147483646)) {
      e_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    for (k = 2; k <= vlen; k++) {
      xoffset = (k - 1) * vstride;
      d_st.site = &we_emlrtRSI;
      if (vstride > 2147483646) {
        e_st.site = &i_emlrtRSI;
        check_forloop_overflow_error(&e_st);
      }

      for (j = 0; j < vstride; j++) {
        y->data[j] += x->data[xoffset + j];
      }
    }
  }
}

void e_sum(const emlrtStack *sp, const emxArray_real_T *x, emxArray_real_T *y)
{
  int32_T vlen;
  uint32_T sz_idx_0;
  int32_T vstride;
  uint32_T sz_idx_2;
  int32_T pagesize;
  int32_T xpageoffset;
  int32_T npages;
  int32_T k;
  int32_T b_k;
  int32_T ypageoffset;
  int32_T j;
  int32_T xoffset;
  int32_T iy;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &qe_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  b_st.site = &re_emlrtRSI;
  vlen = x->size[1];
  if ((x->size[0] == 0) || (x->size[1] == 0) || (x->size[2] == 0)) {
    sz_idx_0 = (uint32_T)x->size[0];
    sz_idx_2 = (uint32_T)x->size[2];
    xpageoffset = y->size[0] * y->size[1] * y->size[2];
    y->size[0] = (int32_T)sz_idx_0;
    y->size[1] = 1;
    y->size[2] = (int32_T)sz_idx_2;
    emxEnsureCapacity_real_T(&b_st, y, xpageoffset, &we_emlrtRTEI);
    b_k = (int32_T)sz_idx_0 * (int32_T)sz_idx_2;
    for (xpageoffset = 0; xpageoffset < b_k; xpageoffset++) {
      y->data[xpageoffset] = 0.0;
    }
  } else {
    c_st.site = &se_emlrtRSI;
    vstride = x->size[0];
    pagesize = x->size[0] * x->size[1];
    npages = 1;
    k = 3;
    if (x->size[2] == 1) {
      k = 2;
    }

    for (b_k = 3; b_k <= k; b_k++) {
      npages *= x->size[2];
    }

    xpageoffset = y->size[0] * y->size[1] * y->size[2];
    y->size[0] = x->size[0];
    y->size[1] = 1;
    y->size[2] = x->size[2];
    emxEnsureCapacity_real_T(&c_st, y, xpageoffset, &xe_emlrtRTEI);
    d_st.site = &te_emlrtRSI;
    if ((1 <= npages) && (npages > 2147483646)) {
      e_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    for (b_k = 0; b_k < npages; b_k++) {
      xpageoffset = b_k * pagesize;
      ypageoffset = b_k * vstride;
      d_st.site = &ue_emlrtRSI;
      if (vstride > 2147483646) {
        e_st.site = &i_emlrtRSI;
        check_forloop_overflow_error(&e_st);
      }

      for (j = 0; j < vstride; j++) {
        y->data[ypageoffset + j] = x->data[xpageoffset + j];
      }

      d_st.site = &ve_emlrtRSI;
      if ((2 <= vlen) && (vlen > 2147483646)) {
        e_st.site = &i_emlrtRSI;
        check_forloop_overflow_error(&e_st);
      }

      for (k = 2; k <= vlen; k++) {
        xoffset = xpageoffset + (k - 1) * vstride;
        d_st.site = &we_emlrtRSI;
        for (j = 0; j < vstride; j++) {
          iy = ypageoffset + j;
          y->data[iy] += x->data[xoffset + j];
        }
      }
    }
  }
}

void f_sum(const emlrtStack *sp, const emxArray_real_T *x, emxArray_real_T *y)
{
  int32_T vlen;
  uint32_T sz_idx_2;
  int32_T xpageoffset;
  int32_T npages;
  int32_T k;
  int32_T b_k;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &qe_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  b_st.site = &re_emlrtRSI;
  vlen = x->size[0];
  if ((x->size[0] == 0) || (x->size[2] == 0)) {
    sz_idx_2 = (uint32_T)x->size[2];
    xpageoffset = y->size[0] * y->size[1] * y->size[2];
    y->size[0] = 1;
    y->size[1] = 1;
    y->size[2] = (int32_T)sz_idx_2;
    emxEnsureCapacity_real_T(&b_st, y, xpageoffset, &we_emlrtRTEI);
    b_k = (int32_T)sz_idx_2;
    for (xpageoffset = 0; xpageoffset < b_k; xpageoffset++) {
      y->data[xpageoffset] = 0.0;
    }
  } else {
    c_st.site = &se_emlrtRSI;
    d_st.site = &df_emlrtRSI;
    npages = 1;
    k = 3;
    if (x->size[2] == 1) {
      k = 2;
    }

    for (b_k = 2; b_k <= k; b_k++) {
      npages *= x->size[b_k - 1];
    }

    xpageoffset = y->size[0] * y->size[1] * y->size[2];
    y->size[0] = 1;
    y->size[1] = 1;
    y->size[2] = x->size[2];
    emxEnsureCapacity_real_T(&c_st, y, xpageoffset, &xe_emlrtRTEI);
    d_st.site = &te_emlrtRSI;
    if ((1 <= npages) && (npages > 2147483646)) {
      e_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    for (b_k = 0; b_k < npages; b_k++) {
      xpageoffset = b_k * x->size[0];
      d_st.site = &ue_emlrtRSI;
      y->data[b_k] = x->data[xpageoffset];
      d_st.site = &ve_emlrtRSI;
      if ((2 <= vlen) && (vlen > 2147483646)) {
        e_st.site = &i_emlrtRSI;
        check_forloop_overflow_error(&e_st);
      }

      for (k = 2; k <= vlen; k++) {
        d_st.site = &we_emlrtRSI;
        y->data[b_k] += x->data[(xpageoffset + k) - 1];
      }
    }
  }
}

void g_sum(const emlrtStack *sp, const emxArray_real_T *x, emxArray_real_T *y)
{
  int32_T vstride;
  int32_T j;
  boolean_T overflow;
  int32_T xoffset;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &qe_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  b_st.site = &re_emlrtRSI;
  if (x->size[0] == 0) {
    y->size[0] = 0;
  } else {
    c_st.site = &se_emlrtRSI;
    vstride = x->size[0];
    j = y->size[0];
    y->size[0] = x->size[0];
    emxEnsureCapacity_real_T(&c_st, y, j, &xe_emlrtRTEI);
    d_st.site = &ue_emlrtRSI;
    if (x->size[0] > 2147483646) {
      e_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    for (j = 0; j < vstride; j++) {
      y->data[j] = x->data[j];
    }

    overflow = (x->size[0] > 2147483646);
    d_st.site = &we_emlrtRSI;
    if (overflow) {
      e_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    for (j = 0; j < vstride; j++) {
      y->data[j] += x->data[vstride + j];
    }

    xoffset = 2 * x->size[0];
    d_st.site = &we_emlrtRSI;
    for (j = 0; j < vstride; j++) {
      y->data[j] += x->data[xoffset + j];
    }
  }
}

void sum(const emlrtStack *sp, const emxArray_real_T *x, emxArray_real_T *y)
{
  int32_T vlen;
  uint32_T sz_idx_0;
  int32_T k;
  uint32_T sz_idx_1;
  int32_T j;
  int32_T vstride;
  int32_T xoffset;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &qe_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  b_st.site = &re_emlrtRSI;
  vlen = x->size[2];
  if ((x->size[0] == 0) || (x->size[1] == 0) || (x->size[2] == 0)) {
    sz_idx_0 = (uint32_T)x->size[0];
    sz_idx_1 = (uint32_T)x->size[1];
    j = y->size[0] * y->size[1];
    y->size[0] = (int32_T)sz_idx_0;
    y->size[1] = (int32_T)sz_idx_1;
    emxEnsureCapacity_real_T(&b_st, y, j, &we_emlrtRTEI);
    k = (int32_T)sz_idx_0 * (int32_T)sz_idx_1;
    for (j = 0; j < k; j++) {
      y->data[j] = 0.0;
    }
  } else {
    c_st.site = &se_emlrtRSI;
    k = 3;
    if (x->size[2] == 1) {
      k = 2;
    }

    if (3 > k) {
      vstride = x->size[0] * x->size[1] * x->size[2];
    } else {
      vstride = x->size[0] * x->size[1];
    }

    j = y->size[0] * y->size[1];
    y->size[0] = x->size[0];
    y->size[1] = x->size[1];
    emxEnsureCapacity_real_T(&c_st, y, j, &xe_emlrtRTEI);
    d_st.site = &te_emlrtRSI;
    d_st.site = &ue_emlrtRSI;
    if ((1 <= vstride) && (vstride > 2147483646)) {
      e_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    for (j = 0; j < vstride; j++) {
      y->data[j] = x->data[j];
    }

    d_st.site = &ve_emlrtRSI;
    if ((2 <= x->size[2]) && (x->size[2] > 2147483646)) {
      e_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    for (k = 2; k <= vlen; k++) {
      xoffset = (k - 1) * vstride;
      d_st.site = &we_emlrtRSI;
      for (j = 0; j < vstride; j++) {
        y->data[j] += x->data[xoffset + j];
      }
    }
  }
}

/* End of code generation (sum.c) */

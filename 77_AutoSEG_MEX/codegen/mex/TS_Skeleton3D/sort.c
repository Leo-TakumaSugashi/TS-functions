/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sort.c
 *
 * Code generation for function 'sort'
 *
 */

/* Include files */
#include "sort.h"
#include "TS_Skeleton3D.h"
#include "TS_Skeleton3D_data.h"
#include "TS_Skeleton3D_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "rt_nonfinite.h"
#include "sortIdx.h"

/* Variable Definitions */
static emlrtRSInfo y_emlrtRSI = { 76,  /* lineNo */
  "sort",                              /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/eml/+coder/+internal/sort.m"/* pathName */
};

static emlrtRSInfo ab_emlrtRSI = { 79, /* lineNo */
  "sort",                              /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/eml/+coder/+internal/sort.m"/* pathName */
};

static emlrtRSInfo bb_emlrtRSI = { 81, /* lineNo */
  "sort",                              /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/eml/+coder/+internal/sort.m"/* pathName */
};

static emlrtRSInfo cb_emlrtRSI = { 84, /* lineNo */
  "sort",                              /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/eml/+coder/+internal/sort.m"/* pathName */
};

static emlrtRSInfo db_emlrtRSI = { 87, /* lineNo */
  "sort",                              /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/eml/+coder/+internal/sort.m"/* pathName */
};

static emlrtRSInfo eb_emlrtRSI = { 90, /* lineNo */
  "sort",                              /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/eml/+coder/+internal/sort.m"/* pathName */
};

static emlrtRTEInfo lc_emlrtRTEI = { 1,/* lineNo */
  20,                                  /* colNo */
  "sort",                              /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/eml/+coder/+internal/sort.m"/* pName */
};

static emlrtRTEInfo mc_emlrtRTEI = { 56,/* lineNo */
  1,                                   /* colNo */
  "sort",                              /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/eml/+coder/+internal/sort.m"/* pName */
};

/* Function Definitions */
void b_sort(const emlrtStack *sp, emxArray_real_T *x, emxArray_int32_T *idx)
{
  int32_T dim;
  emxArray_real_T *vwork;
  int32_T i;
  int32_T vlen;
  int32_T i1;
  int32_T vstride;
  int32_T k;
  emxArray_int32_T *iidx;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  dim = 0;
  if (x->size[0] != 1) {
    dim = -1;
  }

  emxInit_real_T(sp, &vwork, 1, &mc_emlrtRTEI, true);
  if (dim + 2 <= 1) {
    i = x->size[0];
  } else {
    i = 1;
  }

  vlen = i - 1;
  i1 = vwork->size[0];
  vwork->size[0] = i;
  emxEnsureCapacity_real_T(sp, vwork, i1, &lc_emlrtRTEI);
  i1 = idx->size[0];
  idx->size[0] = x->size[0];
  emxEnsureCapacity_int32_T(sp, idx, i1, &lc_emlrtRTEI);
  st.site = &y_emlrtRSI;
  vstride = 1;
  for (k = 0; k <= dim; k++) {
    vstride *= x->size[0];
  }

  st.site = &ab_emlrtRSI;
  st.site = &bb_emlrtRSI;
  if ((1 <= vstride) && (vstride > 2147483646)) {
    b_st.site = &s_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  emxInit_int32_T(sp, &iidx, 1, &lc_emlrtRTEI, true);
  for (dim = 0; dim < vstride; dim++) {
    st.site = &cb_emlrtRSI;
    if ((1 <= i) && (i > 2147483646)) {
      b_st.site = &s_emlrtRSI;
      check_forloop_overflow_error(&b_st);
    }

    for (k = 0; k <= vlen; k++) {
      vwork->data[k] = x->data[dim + k * vstride];
    }

    st.site = &db_emlrtRSI;
    b_sortIdx(&st, vwork, iidx);
    st.site = &eb_emlrtRSI;
    for (k = 0; k <= vlen; k++) {
      i1 = dim + k * vstride;
      x->data[i1] = vwork->data[k];
      idx->data[i1] = iidx->data[k];
    }
  }

  emxFree_int32_T(&iidx);
  emxFree_real_T(&vwork);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void c_sort(const emlrtStack *sp, emxArray_real_T *x, emxArray_int32_T *idx)
{
  int32_T dim;
  emxArray_real_T *vwork;
  int32_T i;
  int32_T vlen;
  int32_T i1;
  int32_T vstride;
  int32_T k;
  emxArray_int32_T *iidx;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  dim = 0;
  if (x->size[0] != 1) {
    dim = -1;
  }

  emxInit_real_T(sp, &vwork, 1, &mc_emlrtRTEI, true);
  if (dim + 2 <= 1) {
    i = x->size[0];
  } else {
    i = 1;
  }

  vlen = i - 1;
  i1 = vwork->size[0];
  vwork->size[0] = i;
  emxEnsureCapacity_real_T(sp, vwork, i1, &lc_emlrtRTEI);
  i1 = idx->size[0];
  idx->size[0] = x->size[0];
  emxEnsureCapacity_int32_T(sp, idx, i1, &lc_emlrtRTEI);
  st.site = &y_emlrtRSI;
  vstride = 1;
  for (k = 0; k <= dim; k++) {
    vstride *= x->size[0];
  }

  st.site = &ab_emlrtRSI;
  st.site = &bb_emlrtRSI;
  if ((1 <= vstride) && (vstride > 2147483646)) {
    b_st.site = &s_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  emxInit_int32_T(sp, &iidx, 1, &lc_emlrtRTEI, true);
  for (dim = 0; dim < vstride; dim++) {
    st.site = &cb_emlrtRSI;
    if ((1 <= i) && (i > 2147483646)) {
      b_st.site = &s_emlrtRSI;
      check_forloop_overflow_error(&b_st);
    }

    for (k = 0; k <= vlen; k++) {
      vwork->data[k] = x->data[dim + k * vstride];
    }

    st.site = &db_emlrtRSI;
    c_sortIdx(&st, vwork, iidx);
    st.site = &eb_emlrtRSI;
    for (k = 0; k <= vlen; k++) {
      i1 = dim + k * vstride;
      x->data[i1] = vwork->data[k];
      idx->data[i1] = iidx->data[k];
    }
  }

  emxFree_int32_T(&iidx);
  emxFree_real_T(&vwork);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void sort(const emlrtStack *sp, emxArray_real32_T *x)
{
  emxArray_real32_T *vwork;
  int32_T j;
  int32_T vlen;
  int32_T k;
  boolean_T overflow;
  boolean_T b_overflow;
  emxArray_int32_T *id_emlrtRSI;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInit_real32_T(sp, &vwork, 1, &mc_emlrtRTEI, true);
  j = x->size[0];
  vlen = x->size[0] - 1;
  k = vwork->size[0];
  vwork->size[0] = x->size[0];
  emxEnsureCapacity_real32_T(sp, vwork, k, &lc_emlrtRTEI);
  st.site = &y_emlrtRSI;
  st.site = &ab_emlrtRSI;
  overflow = ((1 <= j) && (j > 2147483646));
  b_overflow = ((1 <= j) && (j > 2147483646));
  st.site = &bb_emlrtRSI;
  emxInit_int32_T(sp, &id_emlrtRSI, 1, &lc_emlrtRTEI, true);
  for (j = 0; j < 1; j++) {
    st.site = &cb_emlrtRSI;
    if (overflow) {
      b_st.site = &s_emlrtRSI;
      check_forloop_overflow_error(&b_st);
    }

    for (k = 0; k <= vlen; k++) {
      vwork->data[k] = x->data[k];
    }

    st.site = &db_emlrtRSI;
    sortIdx(&st, vwork, id_emlrtRSI);
    st.site = &eb_emlrtRSI;
    if (b_overflow) {
      b_st.site = &s_emlrtRSI;
      check_forloop_overflow_error(&b_st);
    }

    for (k = 0; k <= vlen; k++) {
      x->data[k] = vwork->data[k];
    }
  }

  emxFree_int32_T(&id_emlrtRSI);
  emxFree_real32_T(&vwork);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (sort.c) */

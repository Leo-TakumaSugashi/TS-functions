/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * nullAssignment.c
 *
 * Code generation for function 'nullAssignment'
 *
 */

/* Include files */
#include "nullAssignment.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo rm_emlrtRSI = { 22, /* lineNo */
  "nullAssignment",                    /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/nullAssignment.m"/* pathName */
};

static emlrtRSInfo sm_emlrtRSI = { 26, /* lineNo */
  "nullAssignment",                    /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/nullAssignment.m"/* pathName */
};

static emlrtRSInfo tm_emlrtRSI = { 286,/* lineNo */
  "delete_rows",                       /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/nullAssignment.m"/* pathName */
};

static emlrtRSInfo um_emlrtRSI = { 289,/* lineNo */
  "delete_rows",                       /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/nullAssignment.m"/* pathName */
};

static emlrtRSInfo vm_emlrtRSI = { 132,/* lineNo */
  "num_true",                          /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/nullAssignment.m"/* pathName */
};

static emlrtRSInfo hn_emlrtRSI = { 276,/* lineNo */
  "delete_rows",                       /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/nullAssignment.m"/* pathName */
};

static emlrtRTEInfo t_emlrtRTEI = { 81,/* lineNo */
  27,                                  /* colNo */
  "validate_inputs",                   /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/nullAssignment.m"/* pName */
};

static emlrtRTEInfo u_emlrtRTEI = { 298,/* lineNo */
  1,                                   /* colNo */
  "delete_rows",                       /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/nullAssignment.m"/* pName */
};

static emlrtRTEInfo hk_emlrtRTEI = { 299,/* lineNo */
  5,                                   /* colNo */
  "nullAssignment",                    /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/nullAssignment.m"/* pName */
};

/* Function Definitions */
void b_nullAssignment(const emlrtStack *sp, emxArray_real_T *x, int32_T idx)
{
  int32_T nrowx;
  int32_T nrows;
  boolean_T overflow;
  int32_T j;
  emxArray_real_T *b_x;
  int32_T i;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  st.site = &rm_emlrtRSI;
  if (idx > x->size[0]) {
    emlrtErrorWithMessageIdR2018a(&st, &t_emlrtRTEI, "MATLAB:subsdeldimmismatch",
      "MATLAB:subsdeldimmismatch", 0);
  }

  st.site = &sm_emlrtRSI;
  nrowx = x->size[0] - 1;
  nrows = x->size[0] - 1;
  overflow = ((idx <= nrowx) && (nrowx > 2147483646));
  for (j = 0; j < 3; j++) {
    b_st.site = &hn_emlrtRSI;
    if (overflow) {
      c_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&c_st);
    }

    for (i = idx; i <= nrows; i++) {
      x->data[(i + x->size[0] * j) - 1] = x->data[i + x->size[0] * j];
    }
  }

  if (nrowx > nrowx + 1) {
    emlrtErrorWithMessageIdR2018a(&st, &u_emlrtRTEI,
      "Coder:builtins:AssertionFailed", "Coder:builtins:AssertionFailed", 0);
  }

  emxInit_real_T(&st, &b_x, 2, &hk_emlrtRTEI, true);
  if (1 > nrows) {
    nrowx = 0;
  }

  nrows = b_x->size[0] * b_x->size[1];
  b_x->size[0] = nrowx;
  b_x->size[1] = 3;
  emxEnsureCapacity_real_T(&st, b_x, nrows, &hk_emlrtRTEI);
  for (nrows = 0; nrows < 3; nrows++) {
    for (j = 0; j < nrowx; j++) {
      b_x->data[j + b_x->size[0] * nrows] = x->data[j + x->size[0] * nrows];
    }
  }

  nrows = x->size[0] * x->size[1];
  x->size[0] = b_x->size[0];
  x->size[1] = 3;
  emxEnsureCapacity_real_T(&st, x, nrows, &hk_emlrtRTEI);
  nrowx = b_x->size[0];
  for (nrows = 0; nrows < 3; nrows++) {
    for (j = 0; j < nrowx; j++) {
      x->data[j + x->size[0] * nrows] = b_x->data[j + b_x->size[0] * nrows];
    }
  }

  emxFree_real_T(&b_x);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void nullAssignment(const emlrtStack *sp, emxArray_real_T *x, const
                    emxArray_boolean_T *idx)
{
  int32_T k;
  int32_T nrowx;
  int32_T i;
  int32_T b;
  int32_T nrows;
  emxArray_real_T *b_x;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  st.site = &rm_emlrtRSI;
  k = idx->size[0];
  while ((k >= 1) && (!idx->data[k - 1])) {
    k--;
  }

  if (k > x->size[0]) {
    emlrtErrorWithMessageIdR2018a(&st, &t_emlrtRTEI, "MATLAB:subsdeldimmismatch",
      "MATLAB:subsdeldimmismatch", 0);
  }

  st.site = &sm_emlrtRSI;
  nrowx = x->size[0];
  b_st.site = &tm_emlrtRSI;
  i = 0;
  b = idx->size[0];
  c_st.site = &vm_emlrtRSI;
  if ((1 <= idx->size[0]) && (idx->size[0] > 2147483646)) {
    d_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&d_st);
  }

  for (k = 0; k < b; k++) {
    i += idx->data[k];
  }

  nrows = x->size[0] - i;
  i = 0;
  b_st.site = &um_emlrtRSI;
  if ((1 <= x->size[0]) && (x->size[0] > 2147483646)) {
    c_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&c_st);
  }

  for (k = 0; k < nrowx; k++) {
    if ((k + 1 > idx->size[0]) || (!idx->data[k])) {
      x->data[i] = x->data[k];
      x->data[i + x->size[0]] = x->data[k + x->size[0]];
      x->data[i + x->size[0] * 2] = x->data[k + x->size[0] * 2];
      i++;
    }
  }

  if (nrows > nrowx) {
    emlrtErrorWithMessageIdR2018a(&st, &u_emlrtRTEI,
      "Coder:builtins:AssertionFailed", "Coder:builtins:AssertionFailed", 0);
  }

  emxInit_real_T(&st, &b_x, 2, &hk_emlrtRTEI, true);
  if (1 > nrows) {
    i = 0;
  } else {
    i = nrows;
  }

  b = b_x->size[0] * b_x->size[1];
  b_x->size[0] = i;
  b_x->size[1] = 3;
  emxEnsureCapacity_real_T(&st, b_x, b, &hk_emlrtRTEI);
  for (b = 0; b < 3; b++) {
    for (nrows = 0; nrows < i; nrows++) {
      b_x->data[nrows + b_x->size[0] * b] = x->data[nrows + x->size[0] * b];
    }
  }

  b = x->size[0] * x->size[1];
  x->size[0] = b_x->size[0];
  x->size[1] = 3;
  emxEnsureCapacity_real_T(&st, x, b, &hk_emlrtRTEI);
  i = b_x->size[0];
  for (b = 0; b < 3; b++) {
    for (nrows = 0; nrows < i; nrows++) {
      x->data[nrows + x->size[0] * b] = b_x->data[nrows + b_x->size[0] * b];
    }
  }

  emxFree_real_T(&b_x);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (nullAssignment.c) */

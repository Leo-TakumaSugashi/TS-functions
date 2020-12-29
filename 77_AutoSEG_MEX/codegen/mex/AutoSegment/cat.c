/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * cat.c
 *
 * Code generation for function 'cat'
 *
 */

/* Include files */
#include "cat.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo h_emlrtRSI = { 65,  /* lineNo */
  "cat",                               /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/cat.m"/* pathName */
};

static emlrtRTEInfo b_emlrtRTEI = { 55,/* lineNo */
  27,                                  /* colNo */
  "cat",                               /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/cat.m"/* pName */
};

static emlrtRTEInfo hb_emlrtRTEI = { 1,/* lineNo */
  14,                                  /* colNo */
  "cat",                               /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/cat.m"/* pName */
};

/* Function Definitions */
void b_cat(const emlrtStack *sp, const emxArray_real_T *varargin_1, const
           emxArray_real_T *varargin_2, const emxArray_real_T *varargin_3,
           emxArray_real_T *y)
{
  int32_T j;
  boolean_T exitg1;
  int32_T iy;
  int32_T b;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  j = y->size[0] * y->size[1];
  y->size[0] = varargin_1->size[0];
  y->size[1] = 3;
  emxEnsureCapacity_real_T(sp, y, j, &hb_emlrtRTEI);
  j = 0;
  exitg1 = false;
  while ((!exitg1) && (j < 2)) {
    if ((j + 1 != 2) && (y->size[0] != varargin_1->size[0])) {
      emlrtErrorWithMessageIdR2018a(sp, &b_emlrtRTEI,
        "Coder:MATLAB:catenate_dimensionMismatch",
        "Coder:MATLAB:catenate_dimensionMismatch", 0);
    } else {
      j++;
    }
  }

  j = 0;
  exitg1 = false;
  while ((!exitg1) && (j < 2)) {
    if ((j + 1 != 2) && (y->size[0] != varargin_2->size[0])) {
      emlrtErrorWithMessageIdR2018a(sp, &b_emlrtRTEI,
        "Coder:MATLAB:catenate_dimensionMismatch",
        "Coder:MATLAB:catenate_dimensionMismatch", 0);
    } else {
      j++;
    }
  }

  j = 0;
  exitg1 = false;
  while ((!exitg1) && (j < 2)) {
    if ((j + 1 != 2) && (y->size[0] != varargin_3->size[0])) {
      emlrtErrorWithMessageIdR2018a(sp, &b_emlrtRTEI,
        "Coder:MATLAB:catenate_dimensionMismatch",
        "Coder:MATLAB:catenate_dimensionMismatch", 0);
    } else {
      j++;
    }
  }

  iy = -1;
  b = varargin_1->size[0];
  st.site = &h_emlrtRSI;
  if ((1 <= varargin_1->size[0]) && (varargin_1->size[0] > 2147483646)) {
    b_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  for (j = 0; j < b; j++) {
    iy++;
    y->data[iy] = varargin_1->data[j];
  }

  b = varargin_2->size[0];
  st.site = &h_emlrtRSI;
  if ((1 <= varargin_2->size[0]) && (varargin_2->size[0] > 2147483646)) {
    b_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  for (j = 0; j < b; j++) {
    iy++;
    y->data[iy] = varargin_2->data[j];
  }

  b = varargin_3->size[0];
  st.site = &h_emlrtRSI;
  if ((1 <= varargin_3->size[0]) && (varargin_3->size[0] > 2147483646)) {
    b_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  for (j = 0; j < b; j++) {
    iy++;
    y->data[iy] = varargin_3->data[j];
  }
}

void c_cat(const emlrtStack *sp, const emxArray_real_T *varargin_1, const
           emxArray_real_T *varargin_2, const emxArray_real_T *varargin_3, const
           emxArray_real_T *varargin_4, const emxArray_real_T *varargin_5,
           emxArray_real_T *y)
{
  int32_T j;
  boolean_T exitg1;
  int32_T iy;
  int32_T b;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  j = y->size[0] * y->size[1];
  y->size[0] = varargin_1->size[0];
  y->size[1] = 5;
  emxEnsureCapacity_real_T(sp, y, j, &hb_emlrtRTEI);
  j = 0;
  exitg1 = false;
  while ((!exitg1) && (j < 2)) {
    if ((j + 1 != 2) && (y->size[0] != varargin_1->size[0])) {
      emlrtErrorWithMessageIdR2018a(sp, &b_emlrtRTEI,
        "Coder:MATLAB:catenate_dimensionMismatch",
        "Coder:MATLAB:catenate_dimensionMismatch", 0);
    } else {
      j++;
    }
  }

  j = 0;
  exitg1 = false;
  while ((!exitg1) && (j < 2)) {
    if ((j + 1 != 2) && (y->size[0] != varargin_2->size[0])) {
      emlrtErrorWithMessageIdR2018a(sp, &b_emlrtRTEI,
        "Coder:MATLAB:catenate_dimensionMismatch",
        "Coder:MATLAB:catenate_dimensionMismatch", 0);
    } else {
      j++;
    }
  }

  j = 0;
  exitg1 = false;
  while ((!exitg1) && (j < 2)) {
    if ((j + 1 != 2) && (y->size[0] != varargin_3->size[0])) {
      emlrtErrorWithMessageIdR2018a(sp, &b_emlrtRTEI,
        "Coder:MATLAB:catenate_dimensionMismatch",
        "Coder:MATLAB:catenate_dimensionMismatch", 0);
    } else {
      j++;
    }
  }

  j = 0;
  exitg1 = false;
  while ((!exitg1) && (j < 2)) {
    if ((j + 1 != 2) && (y->size[0] != varargin_4->size[0])) {
      emlrtErrorWithMessageIdR2018a(sp, &b_emlrtRTEI,
        "Coder:MATLAB:catenate_dimensionMismatch",
        "Coder:MATLAB:catenate_dimensionMismatch", 0);
    } else {
      j++;
    }
  }

  j = 0;
  exitg1 = false;
  while ((!exitg1) && (j < 2)) {
    if ((j + 1 != 2) && (y->size[0] != varargin_5->size[0])) {
      emlrtErrorWithMessageIdR2018a(sp, &b_emlrtRTEI,
        "Coder:MATLAB:catenate_dimensionMismatch",
        "Coder:MATLAB:catenate_dimensionMismatch", 0);
    } else {
      j++;
    }
  }

  iy = -1;
  b = varargin_1->size[0];
  st.site = &h_emlrtRSI;
  if ((1 <= varargin_1->size[0]) && (varargin_1->size[0] > 2147483646)) {
    b_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  for (j = 0; j < b; j++) {
    iy++;
    y->data[iy] = varargin_1->data[j];
  }

  b = varargin_2->size[0];
  st.site = &h_emlrtRSI;
  if ((1 <= varargin_2->size[0]) && (varargin_2->size[0] > 2147483646)) {
    b_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  for (j = 0; j < b; j++) {
    iy++;
    y->data[iy] = varargin_2->data[j];
  }

  b = varargin_3->size[0];
  st.site = &h_emlrtRSI;
  if ((1 <= varargin_3->size[0]) && (varargin_3->size[0] > 2147483646)) {
    b_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  for (j = 0; j < b; j++) {
    iy++;
    y->data[iy] = varargin_3->data[j];
  }

  b = varargin_4->size[0];
  st.site = &h_emlrtRSI;
  if ((1 <= varargin_4->size[0]) && (varargin_4->size[0] > 2147483646)) {
    b_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  for (j = 0; j < b; j++) {
    iy++;
    y->data[iy] = varargin_4->data[j];
  }

  b = varargin_5->size[0];
  st.site = &h_emlrtRSI;
  if ((1 <= varargin_5->size[0]) && (varargin_5->size[0] > 2147483646)) {
    b_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  for (j = 0; j < b; j++) {
    iy++;
    y->data[iy] = 0.0;
  }
}

void cat(const emlrtStack *sp, const emxArray_boolean_T *varargin_1, const
         emxArray_boolean_T *varargin_2, emxArray_boolean_T *y)
{
  int32_T j;
  boolean_T exitg1;
  int32_T iy;
  int32_T b;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  j = y->size[0] * y->size[1] * y->size[2];
  y->size[0] = varargin_1->size[0];
  y->size[1] = varargin_1->size[1];
  y->size[2] = varargin_1->size[2] + varargin_2->size[2];
  emxEnsureCapacity_boolean_T(sp, y, j, &hb_emlrtRTEI);
  j = 0;
  exitg1 = false;
  while ((!exitg1) && (j < 3)) {
    if ((j + 1 != 3) && (y->size[j] != varargin_1->size[j])) {
      emlrtErrorWithMessageIdR2018a(sp, &b_emlrtRTEI,
        "Coder:MATLAB:catenate_dimensionMismatch",
        "Coder:MATLAB:catenate_dimensionMismatch", 0);
    } else {
      j++;
    }
  }

  j = 0;
  exitg1 = false;
  while ((!exitg1) && (j < 3)) {
    if ((j + 1 != 3) && (y->size[j] != varargin_2->size[j])) {
      emlrtErrorWithMessageIdR2018a(sp, &b_emlrtRTEI,
        "Coder:MATLAB:catenate_dimensionMismatch",
        "Coder:MATLAB:catenate_dimensionMismatch", 0);
    } else {
      j++;
    }
  }

  iy = -1;
  b = varargin_1->size[0] * varargin_1->size[1] * varargin_1->size[2];
  st.site = &h_emlrtRSI;
  if ((1 <= b) && (b > 2147483646)) {
    b_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  for (j = 0; j < b; j++) {
    iy++;
    y->data[iy] = varargin_1->data[j];
  }

  b = varargin_2->size[0] * varargin_2->size[1] * varargin_2->size[2];
  st.site = &h_emlrtRSI;
  if ((1 <= b) && (b > 2147483646)) {
    b_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  for (j = 0; j < b; j++) {
    iy++;
    y->data[iy] = false;
  }
}

void d_cat(real_T varargin_1, real_T varargin_2, real_T y[2])
{
  y[0] = varargin_1;
  y[1] = varargin_2;
}

void e_cat(const emlrtStack *sp, const real_T varargin_1[3], const
           emxArray_real_T *varargin_2, const real_T varargin_3[3],
           emxArray_real_T *y)
{
  int32_T b;
  boolean_T overflow;
  int32_T k;
  int32_T b_k;
  int32_T j;
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
  b = y->size[0] * y->size[1];
  y->size[0] = varargin_2->size[0] + 2;
  y->size[1] = 3;
  emxEnsureCapacity_real_T(sp, y, b, &hb_emlrtRTEI);
  st.site = &in_emlrtRSI;
  b = varargin_2->size[0];
  overflow = ((1 <= varargin_2->size[0]) && (varargin_2->size[0] > 2147483646));
  for (k = 0; k < 3; k++) {
    b_st.site = &jn_emlrtRSI;
    b_k = 1;
    y->data[y->size[0] * k] = varargin_1[k];
    c_st.site = &kn_emlrtRSI;
    if (overflow) {
      d_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&d_st);
    }

    for (j = 0; j < b; j++) {
      b_k++;
      y->data[(b_k + y->size[0] * k) - 1] = varargin_2->data[j +
        varargin_2->size[0] * k];
    }

    y->data[b_k + y->size[0] * k] = varargin_3[k];
  }
}

void f_cat(const real_T varargin_1[3], const real_T varargin_2[3], real_T y[6])
{
  y[0] = varargin_1[0];
  y[1] = varargin_2[0];
  y[2] = varargin_1[1];
  y[3] = varargin_2[1];
  y[4] = varargin_1[2];
  y[5] = varargin_2[2];
}

/* End of code generation (cat.c) */

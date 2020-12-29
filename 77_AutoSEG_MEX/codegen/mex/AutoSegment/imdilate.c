/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * imdilate.c
 *
 * Code generation for function 'imdilate'
 *
 */

/* Include files */
#include "imdilate.h"
#include "AutoSegment.h"
#include "AutoSegment_emxutil.h"
#include "libmwmorphop_binary_tbb.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo de_emlrtRSI = { 98, /* lineNo */
  "imdilate",                          /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/imdilate.m"/* pathName */
};

static emlrtRSInfo ee_emlrtRSI = { 17, /* lineNo */
  "morphop",                           /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/+images/+internal/morphop.m"/* pathName */
};

static emlrtRSInfo fe_emlrtRSI = { 645,/* lineNo */
  "morphop",                           /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/+images/+internal/+coder/morphop.m"/* pathName */
};

static emlrtRSInfo ge_emlrtRSI = { 867,/* lineNo */
  "callSharedLibrary",                 /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/+images/+internal/+coder/morphop.m"/* pathName */
};

static emlrtRTEInfo ee_emlrtRTEI = { 17,/* lineNo */
  9,                                   /* colNo */
  "morphop",                           /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/+images/+internal/morphop.m"/* pName */
};

static emlrtRTEInfo fe_emlrtRTEI = { 658,/* lineNo */
  9,                                   /* colNo */
  "morphop",                           /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/+images/+internal/+coder/morphop.m"/* pName */
};

static emlrtRTEInfo ge_emlrtRTEI = { 435,/* lineNo */
  9,                                   /* colNo */
  "morphop",                           /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/+images/+internal/+coder/morphop.m"/* pName */
};

/* Function Definitions */
void imdilate(const emlrtStack *sp, const emxArray_boolean_T *A,
              emxArray_boolean_T *B)
{
  int32_T k;
  real_T asizeT[3];
  emxArray_boolean_T *Apadpack;
  boolean_T nhood[3];
  real_T nsizeT[2];
  int32_T loop_ub;
  static const real_T b_nsizeT[3] = { 1.0, 1.0, 3.0 };

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
  st.site = &de_emlrtRSI;
  b_st.site = &ee_emlrtRSI;
  k = B->size[0] * B->size[1] * B->size[2];
  B->size[0] = A->size[0];
  B->size[1] = A->size[1];
  B->size[2] = A->size[2];
  emxEnsureCapacity_boolean_T(&b_st, B, k, &ee_emlrtRTEI);
  c_st.site = &fe_emlrtRSI;
  d_st.site = &ge_emlrtRSI;
  asizeT[0] = A->size[0];
  asizeT[1] = A->size[1];
  asizeT[2] = A->size[2];
  k = 3;
  if (A->size[2] == 1) {
    k = 2;
  }

  emxInit_boolean_T(&d_st, &Apadpack, 3, &ge_emlrtRTEI, true);
  nhood[0] = true;
  nhood[1] = true;
  nhood[2] = true;
  nsizeT[0] = 3.0;
  nsizeT[1] = 1.0;
  dilate_binary_tbb(&A->data[0], asizeT, (real_T)k, nhood, nsizeT, 2.0, &B->
                    data[0]);
  k = Apadpack->size[0] * Apadpack->size[1] * Apadpack->size[2];
  Apadpack->size[0] = B->size[0];
  Apadpack->size[1] = B->size[1];
  Apadpack->size[2] = B->size[2];
  emxEnsureCapacity_boolean_T(&b_st, Apadpack, k, &fe_emlrtRTEI);
  loop_ub = B->size[0] * B->size[1] * B->size[2];
  for (k = 0; k < loop_ub; k++) {
    Apadpack->data[k] = B->data[k];
  }

  k = B->size[0] * B->size[1] * B->size[2];
  B->size[0] = Apadpack->size[0];
  B->size[1] = Apadpack->size[1];
  B->size[2] = Apadpack->size[2];
  emxEnsureCapacity_boolean_T(&b_st, B, k, &ee_emlrtRTEI);
  c_st.site = &fe_emlrtRSI;
  asizeT[0] = Apadpack->size[0];
  asizeT[1] = Apadpack->size[1];
  asizeT[2] = Apadpack->size[2];
  k = 3;
  if (Apadpack->size[2] == 1) {
    k = 2;
  }

  nhood[0] = true;
  nhood[1] = true;
  nhood[2] = true;
  nsizeT[0] = 1.0;
  nsizeT[1] = 3.0;
  dilate_binary_tbb(&Apadpack->data[0], asizeT, (real_T)k, nhood, nsizeT, 2.0,
                    &B->data[0]);
  k = Apadpack->size[0] * Apadpack->size[1] * Apadpack->size[2];
  Apadpack->size[0] = B->size[0];
  Apadpack->size[1] = B->size[1];
  Apadpack->size[2] = B->size[2];
  emxEnsureCapacity_boolean_T(&b_st, Apadpack, k, &fe_emlrtRTEI);
  loop_ub = B->size[0] * B->size[1] * B->size[2];
  for (k = 0; k < loop_ub; k++) {
    Apadpack->data[k] = B->data[k];
  }

  k = B->size[0] * B->size[1] * B->size[2];
  B->size[0] = Apadpack->size[0];
  B->size[1] = Apadpack->size[1];
  B->size[2] = Apadpack->size[2];
  emxEnsureCapacity_boolean_T(&b_st, B, k, &ee_emlrtRTEI);
  c_st.site = &fe_emlrtRSI;
  asizeT[0] = Apadpack->size[0];
  asizeT[1] = Apadpack->size[1];
  asizeT[2] = Apadpack->size[2];
  k = 3;
  if (Apadpack->size[2] == 1) {
    k = 2;
  }

  nhood[0] = true;
  nhood[1] = true;
  nhood[2] = true;
  dilate_binary_tbb(&Apadpack->data[0], asizeT, (real_T)k, nhood, b_nsizeT, 3.0,
                    &B->data[0]);
  emxFree_boolean_T(&Apadpack);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (imdilate.c) */

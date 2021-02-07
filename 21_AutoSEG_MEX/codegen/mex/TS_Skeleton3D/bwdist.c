/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * bwdist.c
 *
 * Code generation for function 'bwdist'
 *
 */

/* Include files */
#include "bwdist.h"
#include "TS_Skeleton3D.h"
#include "TS_Skeleton3D_data.h"
#include "TS_Skeleton3D_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "libmwbwdistEDT_tbb.h"
#include "mwmathutil.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo t_emlrtRSI = { 101, /* lineNo */
  "bwdist",                            /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/bwdist.m"/* pathName */
};

static emlrtRSInfo u_emlrtRSI = { 104, /* lineNo */
  "bwdist",                            /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/bwdist.m"/* pathName */
};

static emlrtRSInfo v_emlrtRSI = { 16,  /* lineNo */
  "sqrt",                              /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elfun/sqrt.m"/* pathName */
};

static emlrtRSInfo w_emlrtRSI = { 33,  /* lineNo */
  "applyScalarFunctionInPlace",        /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/eml/+coder/+internal/applyScalarFunctionInPlace.m"/* pathName */
};

static emlrtRTEInfo f_emlrtRTEI = { 13,/* lineNo */
  9,                                   /* colNo */
  "sqrt",                              /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elfun/sqrt.m"/* pName */
};

static emlrtRTEInfo dc_emlrtRTEI = { 14,/* lineNo */
  1,                                   /* colNo */
  "bwdist",                            /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/bwdist.m"/* pName */
};

static emlrtRTEInfo ec_emlrtRTEI = { 1,/* lineNo */
  22,                                  /* colNo */
  "bwdist",                            /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/bwdist.m"/* pName */
};

/* Function Definitions */
void bwdist(const emlrtStack *sp, const emxArray_boolean_T *varargin_1,
            emxArray_real32_T *varargout_1)
{
  emxArray_boolean_T *BW;
  int32_T i;
  int32_T nx;
  int32_T k;
  real_T b_BW[3];
  boolean_T p;
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
  emxInit_boolean_T(sp, &BW, 3, &dc_emlrtRTEI, true);
  i = BW->size[0] * BW->size[1] * BW->size[2];
  BW->size[0] = varargin_1->size[0];
  BW->size[1] = varargin_1->size[1];
  BW->size[2] = varargin_1->size[2];
  emxEnsureCapacity_boolean_T(sp, BW, i, &dc_emlrtRTEI);
  nx = varargin_1->size[0] * varargin_1->size[1] * varargin_1->size[2];
  for (i = 0; i < nx; i++) {
    BW->data[i] = varargin_1->data[i];
  }

  i = varargout_1->size[0] * varargout_1->size[1] * varargout_1->size[2];
  varargout_1->size[0] = BW->size[0];
  varargout_1->size[1] = BW->size[1];
  varargout_1->size[2] = BW->size[2];
  emxEnsureCapacity_real32_T(sp, varargout_1, i, &ec_emlrtRTEI);
  st.site = &t_emlrtRSI;
  k = 3;
  if (BW->size[2] == 1) {
    k = 2;
  }

  b_BW[0] = BW->size[0];
  b_BW[1] = BW->size[1];
  b_BW[2] = BW->size[2];
  bwdistEDT_tbb_boolean(&BW->data[0], b_BW, (real_T)k, &varargout_1->data[0]);
  st.site = &u_emlrtRSI;
  p = false;
  i = varargout_1->size[0] * varargout_1->size[1] * varargout_1->size[2];
  emxFree_boolean_T(&BW);
  for (k = 0; k < i; k++) {
    if (p || (varargout_1->data[k] < 0.0F)) {
      p = true;
    }
  }

  if (p) {
    emlrtErrorWithMessageIdR2018a(&st, &f_emlrtRTEI,
      "Coder:toolbox:ElFunDomainError", "Coder:toolbox:ElFunDomainError", 3, 4,
      4, "sqrt");
  }

  b_st.site = &v_emlrtRSI;
  nx = varargout_1->size[0] * varargout_1->size[1] * varargout_1->size[2];
  c_st.site = &w_emlrtRSI;
  if ((1 <= nx) && (nx > 2147483646)) {
    d_st.site = &s_emlrtRSI;
    check_forloop_overflow_error(&d_st);
  }

  for (k = 0; k < nx; k++) {
    varargout_1->data[k] = muSingleScalarSqrt(varargout_1->data[k]);
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (bwdist.c) */

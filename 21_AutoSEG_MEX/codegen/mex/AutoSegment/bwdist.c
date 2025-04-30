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
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "libmwbwdistEDTFT_tbb.h"
#include "rt_nonfinite.h"
#include "sqrt.h"

/* Variable Definitions */
static emlrtRSInfo vf_emlrtRSI = { 74, /* lineNo */
  "bwdist",                            /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/bwdist.m"/* pathName */
};

static emlrtRTEInfo kf_emlrtRTEI = { 1,/* lineNo */
  22,                                  /* colNo */
  "bwdist",                            /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/bwdist.m"/* pName */
};

/* Function Definitions */
void bwdist(const emlrtStack *sp, const emxArray_boolean_T *varargin_1,
            emxArray_real32_T *varargout_1, emxArray_uint32_T *varargout_2)
{
  emxArray_boolean_T *BW;
  int32_T k;
  int32_T loop_ub;
  real_T b_BW[3];
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInit_boolean_T(sp, &BW, 3, &jf_emlrtRTEI, true);
  k = BW->size[0] * BW->size[1] * BW->size[2];
  BW->size[0] = varargin_1->size[0];
  BW->size[1] = varargin_1->size[1];
  BW->size[2] = varargin_1->size[2];
  emxEnsureCapacity_boolean_T(sp, BW, k, &jf_emlrtRTEI);
  loop_ub = varargin_1->size[0] * varargin_1->size[1] * varargin_1->size[2];
  for (k = 0; k < loop_ub; k++) {
    BW->data[k] = varargin_1->data[k];
  }

  k = varargout_1->size[0] * varargout_1->size[1] * varargout_1->size[2];
  varargout_1->size[0] = BW->size[0];
  varargout_1->size[1] = BW->size[1];
  varargout_1->size[2] = BW->size[2];
  emxEnsureCapacity_real32_T(sp, varargout_1, k, &kf_emlrtRTEI);
  k = varargout_2->size[0] * varargout_2->size[1] * varargout_2->size[2];
  varargout_2->size[0] = BW->size[0];
  varargout_2->size[1] = BW->size[1];
  varargout_2->size[2] = BW->size[2];
  emxEnsureCapacity_uint32_T(sp, varargout_2, k, &kf_emlrtRTEI);
  k = 3;
  if (BW->size[2] == 1) {
    k = 2;
  }

  b_BW[0] = BW->size[0];
  b_BW[1] = BW->size[1];
  b_BW[2] = BW->size[2];
  bwdistEDTFT32_tbb_boolean(&BW->data[0], b_BW, (real_T)k, &varargout_1->data[0],
    &varargout_2->data[0]);
  st.site = &vf_emlrtRSI;
  c_sqrt(&st, varargout_1);
  emxFree_boolean_T(&BW);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (bwdist.c) */

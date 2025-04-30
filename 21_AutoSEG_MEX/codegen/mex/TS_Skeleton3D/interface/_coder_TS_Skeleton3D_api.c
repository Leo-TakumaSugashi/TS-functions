/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_TS_Skeleton3D_api.c
 *
 * Code generation for function '_coder_TS_Skeleton3D_api'
 *
 */

/* Include files */
#include "_coder_TS_Skeleton3D_api.h"
#include "TS_Skeleton3D.h"
#include "TS_Skeleton3D_data.h"
#include "TS_Skeleton3D_emxutil.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRTEInfo kc_emlrtRTEI = { 1,/* lineNo */
  1,                                   /* colNo */
  "_coder_TS_Skeleton3D_api",          /* fName */
  ""                                   /* pName */
};

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_boolean_T *y);
static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_boolean_T *ret);
static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *bw, const
  char_T *identifier, emxArray_boolean_T *y);
static const mxArray *emlrt_marshallOut(const emxArray_boolean_T *u);

/* Function Definitions */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_boolean_T *y)
{
  c_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_boolean_T *ret)
{
  static const int32_T dims[3] = { -1, -1, -1 };

  const boolean_T bv[3] = { true, true, true };

  int32_T iv[3];
  int32_T i;
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "logical", false, 3U, dims, &bv[0],
    iv);
  ret->allocatedSize = iv[0] * iv[1] * iv[2];
  i = ret->size[0] * ret->size[1] * ret->size[2];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  ret->size[2] = iv[2];
  emxEnsureCapacity_boolean_T(sp, ret, i, (emlrtRTEInfo *)NULL);
  ret->data = (boolean_T *)emlrtMxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *bw, const
  char_T *identifier, emxArray_boolean_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(bw), &thisId, y);
  emlrtDestroyArray(&bw);
}

static const mxArray *emlrt_marshallOut(const emxArray_boolean_T *u)
{
  const mxArray *y;
  const mxArray *m;
  static const int32_T iv[3] = { 0, 0, 0 };

  y = NULL;
  m = emlrtCreateLogicalArray(3, iv);
  emlrtMxSetData((mxArray *)m, &u->data[0]);
  emlrtSetDimensions((mxArray *)m, u->size, 3);
  emlrtAssign(&y, m);
  return y;
}

void TS_Skeleton3D_api(const mxArray * const prhs[1], int32_T nlhs, const
  mxArray *plhs[1])
{
  emxArray_boolean_T *bw;
  emxArray_boolean_T *A;
  const mxArray *prhs_copy_idx_0;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  (void)nlhs;
  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_boolean_T(&st, &bw, 3, &kc_emlrtRTEI, true);
  emxInit_boolean_T(&st, &A, 3, &kc_emlrtRTEI, true);
  prhs_copy_idx_0 = emlrtProtectR2012b(prhs[0], 0, false, -1);

  /* Marshall function inputs */
  bw->canFreeData = false;
  emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_0), "bw", bw);

  /* Invoke the target function */
  TS_Skeleton3D(&st, bw, A);

  /* Marshall function outputs */
  A->canFreeData = false;
  plhs[0] = emlrt_marshallOut(A);
  emxFree_boolean_T(&A);
  emxFree_boolean_T(&bw);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_TS_Skeleton3D_api.c) */

/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_AutoSegment_api.c
 *
 * Code generation for function '_coder_AutoSegment_api'
 *
 */

/* Include files */
#include "_coder_AutoSegment_api.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "rt_nonfinite.h"
#include <string.h>

/* Variable Definitions */
static emlrtRTEInfo wj_emlrtRTEI = { 1,/* lineNo */
  1,                                   /* colNo */
  "_coder_AutoSegment_api",            /* fName */
  ""                                   /* pName */
};

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_boolean_T *y);
static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *NewReso,
  const char_T *identifier))[3];
static real_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[3];
static const mxArray *d_emlrt_marshallOut(const emlrtStack *sp,
  AutoSegmentStackData *SD, const struct0_T *u);
static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *cutlen,
  const char_T *identifier);
static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *skel, const
  char_T *identifier, emxArray_boolean_T *y);
static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_boolean_T *ret);
static real_T (*h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[3];
static real_T i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);

/* Function Definitions */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_boolean_T *y)
{
  g_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *NewReso,
  const char_T *identifier))[3]
{
  real_T (*y)[3];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(sp, emlrtAlias(NewReso), &thisId);
  emlrtDestroyArray(&NewReso);
  return y;
}
  static real_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId))[3]
{
  real_T (*y)[3];
  y = h_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static const mxArray *d_emlrt_marshallOut(const emlrtStack *sp,
  AutoSegmentStackData *SD, const struct0_T *u)
{
  const mxArray *y;
  emxArray_boolean_T *b_u;
  static const char * sv[11] = { "Output", "AddBP", "Branch", "BranchGroup",
    "End", "Pointdata", "ResolutionXYZ", "BPmatrix", "loopNum", "cutlen",
    "Original" };

  int32_T i;
  int32_T loop_ub;
  const mxArray *b_y;
  int32_T iv[3];
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m3;
  const mxArray *m4;
  int32_T iv1[2];
  static const char * sv1[4] = { "PointXYZ", "Type", "Length", "Branch" };

  const struct1_T *r;
  int32_T i1;
  const mxArray *m5;
  static const int32_T iv2[2] = { 1, 3 };

  real_T *pData;
  const mxArray *c_y;
  real_T c_u[6144];
  const mxArray *m6;
  static const int32_T iv3[2] = { 2048, 3 };

  real_T *b_pData;
  int32_T b_i;
  real_T d_u;
  const mxArray *m7;
  real_T *c_pData;
  const mxArray *m8;
  const mxArray *m9;
  const mxArray *m10;
  real_T e_u[6];
  const mxArray *m11;
  const mxArray *m12;
  static const int32_T iv4[2] = { 2, 3 };

  real_T *d_pData;
  const mxArray *m13;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInit_boolean_T(sp, &b_u, 3, (emlrtRTEInfo *)NULL, true);
  y = NULL;
  emlrtAssign(&y, emlrtCreateStructMatrix(1, 1, 11, sv));
  i = b_u->size[0] * b_u->size[1] * b_u->size[2];
  b_u->size[0] = u->Output->size[0];
  b_u->size[1] = u->Output->size[1];
  b_u->size[2] = u->Output->size[2];
  emxEnsureCapacity_boolean_T(sp, b_u, i, (emlrtRTEInfo *)NULL);
  loop_ub = u->Output->size[0] * u->Output->size[1] * u->Output->size[2];
  for (i = 0; i < loop_ub; i++) {
    b_u->data[i] = u->Output->data[i];
  }

  b_y = NULL;
  iv[0] = u->Output->size[0];
  iv[1] = u->Output->size[1];
  iv[2] = u->Output->size[2];
  m = emlrtCreateLogicalArray(3, &iv[0]);
  emlrtInitLogicalArray(u->Output->size[0] * (u->Output->size[1] * u->
    Output->size[2]), m, &b_u->data[0]);
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "Output", b_y, 0);
  i = b_u->size[0] * b_u->size[1] * b_u->size[2];
  b_u->size[0] = u->AddBP->size[0];
  b_u->size[1] = u->AddBP->size[1];
  b_u->size[2] = u->AddBP->size[2];
  emxEnsureCapacity_boolean_T(sp, b_u, i, (emlrtRTEInfo *)NULL);
  loop_ub = u->AddBP->size[0] * u->AddBP->size[1] * u->AddBP->size[2];
  for (i = 0; i < loop_ub; i++) {
    b_u->data[i] = u->AddBP->data[i];
  }

  b_y = NULL;
  iv[0] = u->AddBP->size[0];
  iv[1] = u->AddBP->size[1];
  iv[2] = u->AddBP->size[2];
  m1 = emlrtCreateLogicalArray(3, &iv[0]);
  emlrtInitLogicalArray(u->AddBP->size[0] * (u->AddBP->size[1] * u->AddBP->size
    [2]), m1, &b_u->data[0]);
  emlrtAssign(&b_y, m1);
  emlrtSetFieldR2017b(y, 0, "AddBP", b_y, 1);
  i = b_u->size[0] * b_u->size[1] * b_u->size[2];
  b_u->size[0] = u->Branch->size[0];
  b_u->size[1] = u->Branch->size[1];
  b_u->size[2] = u->Branch->size[2];
  emxEnsureCapacity_boolean_T(sp, b_u, i, (emlrtRTEInfo *)NULL);
  loop_ub = u->Branch->size[0] * u->Branch->size[1] * u->Branch->size[2];
  for (i = 0; i < loop_ub; i++) {
    b_u->data[i] = u->Branch->data[i];
  }

  b_y = NULL;
  iv[0] = u->Branch->size[0];
  iv[1] = u->Branch->size[1];
  iv[2] = u->Branch->size[2];
  m2 = emlrtCreateLogicalArray(3, &iv[0]);
  emlrtInitLogicalArray(u->Branch->size[0] * (u->Branch->size[1] * u->
    Branch->size[2]), m2, &b_u->data[0]);
  emlrtAssign(&b_y, m2);
  emlrtSetFieldR2017b(y, 0, "Branch", b_y, 2);
  i = b_u->size[0] * b_u->size[1] * b_u->size[2];
  b_u->size[0] = u->BranchGroup->size[0];
  b_u->size[1] = u->BranchGroup->size[1];
  b_u->size[2] = u->BranchGroup->size[2];
  emxEnsureCapacity_boolean_T(sp, b_u, i, (emlrtRTEInfo *)NULL);
  loop_ub = u->BranchGroup->size[0] * u->BranchGroup->size[1] * u->
    BranchGroup->size[2];
  for (i = 0; i < loop_ub; i++) {
    b_u->data[i] = u->BranchGroup->data[i];
  }

  b_y = NULL;
  iv[0] = u->BranchGroup->size[0];
  iv[1] = u->BranchGroup->size[1];
  iv[2] = u->BranchGroup->size[2];
  m3 = emlrtCreateLogicalArray(3, &iv[0]);
  emlrtInitLogicalArray(u->BranchGroup->size[0] * (u->BranchGroup->size[1] *
    u->BranchGroup->size[2]), m3, &b_u->data[0]);
  emlrtAssign(&b_y, m3);
  emlrtSetFieldR2017b(y, 0, "BranchGroup", b_y, 3);
  i = b_u->size[0] * b_u->size[1] * b_u->size[2];
  b_u->size[0] = u->End->size[0];
  b_u->size[1] = u->End->size[1];
  b_u->size[2] = u->End->size[2];
  emxEnsureCapacity_boolean_T(sp, b_u, i, (emlrtRTEInfo *)NULL);
  loop_ub = u->End->size[0] * u->End->size[1] * u->End->size[2];
  for (i = 0; i < loop_ub; i++) {
    b_u->data[i] = u->End->data[i];
  }

  b_y = NULL;
  iv[0] = u->End->size[0];
  iv[1] = u->End->size[1];
  iv[2] = u->End->size[2];
  m4 = emlrtCreateLogicalArray(3, &iv[0]);
  emlrtInitLogicalArray(u->End->size[0] * (u->End->size[1] * u->End->size[2]),
                        m4, &b_u->data[0]);
  emlrtAssign(&b_y, m4);
  emlrtSetFieldR2017b(y, 0, "End", b_y, 4);
  memcpy(&SD->u1.f3.u[0], &u->Pointdata[0], 32768U * sizeof(struct1_T));
  b_y = NULL;
  iv1[0] = 1;
  iv1[1] = 32768;
  emlrtAssign(&b_y, emlrtCreateStructArray(2, iv1, 4, sv1));
  for (i = 0; i < 32768; i++) {
    r = &SD->u1.f3.u[i];
    for (i1 = 0; i1 < 6144; i1++) {
      c_u[i1] = r->PointXYZ[i1];
    }

    c_y = NULL;
    m6 = emlrtCreateNumericArray(2, iv3, mxDOUBLE_CLASS, mxREAL);
    b_pData = emlrtMxGetPr(m6);
    i1 = 0;
    for (b_i = 0; b_i < 3; b_i++) {
      for (loop_ub = 0; loop_ub < 2048; loop_ub++) {
        b_pData[i1] = c_u[loop_ub + (b_i << 11)];
        i1++;
      }
    }

    emlrtAssign(&c_y, m6);
    emlrtSetFieldR2017b(b_y, i, "PointXYZ", c_y, 0);
    d_u = r->Type;
    c_y = NULL;
    m8 = emlrtCreateDoubleScalar(d_u);
    emlrtAssign(&c_y, m8);
    emlrtSetFieldR2017b(b_y, i, "Type", c_y, 1);
    d_u = r->Length;
    c_y = NULL;
    m9 = emlrtCreateDoubleScalar(d_u);
    emlrtAssign(&c_y, m9);
    emlrtSetFieldR2017b(b_y, i, "Length", c_y, 2);
    for (i1 = 0; i1 < 6; i1++) {
      e_u[i1] = r->Branch[i1];
    }

    c_y = NULL;
    m12 = emlrtCreateNumericArray(2, iv4, mxDOUBLE_CLASS, mxREAL);
    d_pData = emlrtMxGetPr(m12);
    i1 = 0;
    for (b_i = 0; b_i < 3; b_i++) {
      loop_ub = b_i << 1;
      d_pData[i1] = e_u[loop_ub];
      i1++;
      d_pData[i1] = e_u[loop_ub + 1];
      i1++;
    }

    emlrtAssign(&c_y, m12);
    emlrtSetFieldR2017b(b_y, i, "Branch", c_y, 3);
  }

  emlrtSetFieldR2017b(y, 0, "Pointdata", b_y, 5);
  b_y = NULL;
  m5 = emlrtCreateNumericArray(2, iv2, mxDOUBLE_CLASS, mxREAL);
  pData = emlrtMxGetPr(m5);
  pData[0] = u->ResolutionXYZ[0];
  pData[1] = u->ResolutionXYZ[1];
  pData[2] = u->ResolutionXYZ[2];
  emlrtAssign(&b_y, m5);
  emlrtSetFieldR2017b(y, 0, "ResolutionXYZ", b_y, 6);
  b_y = NULL;
  iv1[0] = u->BPmatrix->size[0];
  iv1[1] = u->BPmatrix->size[1];
  m7 = emlrtCreateNumericArray(2, &iv1[0], mxDOUBLE_CLASS, mxREAL);
  c_pData = emlrtMxGetPr(m7);
  i = 0;
  for (b_i = 0; b_i < 5; b_i++) {
    for (loop_ub = 0; loop_ub < u->BPmatrix->size[0]; loop_ub++) {
      c_pData[i] = u->BPmatrix->data[loop_ub + u->BPmatrix->size[0] * b_i];
      i++;
    }
  }

  emlrtAssign(&b_y, m7);
  emlrtSetFieldR2017b(y, 0, "BPmatrix", b_y, 7);
  b_y = NULL;
  m10 = emlrtCreateDoubleScalar(u->loopNum);
  emlrtAssign(&b_y, m10);
  emlrtSetFieldR2017b(y, 0, "loopNum", b_y, 8);
  b_y = NULL;
  m11 = emlrtCreateDoubleScalar(u->cutlen);
  emlrtAssign(&b_y, m11);
  emlrtSetFieldR2017b(y, 0, "cutlen", b_y, 9);
  i = b_u->size[0] * b_u->size[1] * b_u->size[2];
  b_u->size[0] = u->Original->size[0];
  b_u->size[1] = u->Original->size[1];
  b_u->size[2] = u->Original->size[2];
  emxEnsureCapacity_boolean_T(sp, b_u, i, (emlrtRTEInfo *)NULL);
  loop_ub = u->Original->size[0] * u->Original->size[1] * u->Original->size[2];
  for (i = 0; i < loop_ub; i++) {
    b_u->data[i] = u->Original->data[i];
  }

  b_y = NULL;
  iv[0] = u->Original->size[0];
  iv[1] = u->Original->size[1];
  iv[2] = u->Original->size[2];
  m13 = emlrtCreateLogicalArray(3, &iv[0]);
  emlrtInitLogicalArray(u->Original->size[0] * (u->Original->size[1] *
    u->Original->size[2]), m13, &b_u->data[0]);
  emlrtAssign(&b_y, m13);
  emlrtSetFieldR2017b(y, 0, "Original", b_y, 10);
  emxFree_boolean_T(&b_u);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
  return y;
}

static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *cutlen,
  const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = f_emlrt_marshallIn(sp, emlrtAlias(cutlen), &thisId);
  emlrtDestroyArray(&cutlen);
  return y;
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *skel, const
  char_T *identifier, emxArray_boolean_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(skel), &thisId, y);
  emlrtDestroyArray(&skel);
}

static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = i_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
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

static real_T (*h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[3]
{
  real_T (*ret)[3];
  static const int32_T dims[2] = { 1, 3 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims);
  ret = (real_T (*)[3])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static real_T i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

void AutoSegment_api(AutoSegmentStackData *SD, const mxArray * const prhs[4],
                     int32_T nlhs, const mxArray *plhs[1])
{
  emxArray_boolean_T *skel;
  emxArray_boolean_T *AddBP;
  const mxArray *prhs_copy_idx_0;
  const mxArray *prhs_copy_idx_2;
  real_T (*NewReso)[3];
  real_T cutlen;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  (void)nlhs;
  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_boolean_T(&st, &skel, 3, &wj_emlrtRTEI, true);
  emxInit_boolean_T(&st, &AddBP, 3, &wj_emlrtRTEI, true);
  emxInitStruct_struct0_T(&st, &SD->f5.SEG, &wj_emlrtRTEI, true);
  prhs_copy_idx_0 = emlrtProtectR2012b(prhs[0], 0, false, -1);
  prhs_copy_idx_2 = emlrtProtectR2012b(prhs[2], 2, false, -1);

  /* Marshall function inputs */
  skel->canFreeData = false;
  emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_0), "skel", skel);
  NewReso = c_emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "NewReso");
  AddBP->canFreeData = false;
  emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_2), "AddBP", AddBP);
  cutlen = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[3]), "cutlen");

  /* Invoke the target function */
  AutoSegment(SD, &st, skel, *NewReso, AddBP, cutlen, &SD->f5.SEG);

  /* Marshall function outputs */
  plhs[0] = d_emlrt_marshallOut(&st, SD, &SD->f5.SEG);
  emxFreeStruct_struct0_T(&SD->f5.SEG);
  emxFree_boolean_T(&AddBP);
  emxFree_boolean_T(&skel);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_AutoSegment_api.c) */

/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * padarray.c
 *
 * Code generation for function 'padarray'
 *
 */

/* Include files */
#include "padarray.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "mwmathutil.h"
#include "repmat.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo ef_emlrtRSI = { 80, /* lineNo */
  "padarray",                          /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m"/* pathName */
};

static emlrtRSInfo ff_emlrtRSI = { 734,/* lineNo */
  "getPaddingIndices",                 /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m"/* pathName */
};

static emlrtRSInfo gf_emlrtRSI = { 802,/* lineNo */
  "SymmetricPad",                      /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m"/* pathName */
};

static emlrtRSInfo hf_emlrtRSI = { 28, /* lineNo */
  "colon",                             /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/ops/colon.m"/* pathName */
};

static emlrtRSInfo if_emlrtRSI = { 103,/* lineNo */
  "colon",                             /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/ops/colon.m"/* pathName */
};

static emlrtRSInfo jf_emlrtRSI = { 306,/* lineNo */
  "eml_float_colon",                   /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/ops/colon.m"/* pathName */
};

static emlrtRSInfo kf_emlrtRSI = { 72, /* lineNo */
  "mod",                               /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elfun/mod.m"/* pathName */
};

static emlrtDCInfo b_emlrtDCI = { 251, /* lineNo */
  35,                                  /* colNo */
  "ConstantPad",                       /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo fd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  100,                                 /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "padarray",                          /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo gd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  100,                                 /* lineNo */
  30,                                  /* colNo */
  "",                                  /* aName */
  "padarray",                          /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo hd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  100,                                 /* lineNo */
  32,                                  /* colNo */
  "",                                  /* aName */
  "padarray",                          /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo d_emlrtDCI = { 793, /* lineNo */
  33,                                  /* colNo */
  "SymmetricPad",                      /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  4                                    /* checkKind */
};

static emlrtDCInfo e_emlrtDCI = { 793, /* lineNo */
  33,                                  /* colNo */
  "SymmetricPad",                      /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo id_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  803,                                 /* lineNo */
  14,                                  /* colNo */
  "",                                  /* aName */
  "SymmetricPad",                      /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo jd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  803,                                 /* lineNo */
  16,                                  /* colNo */
  "",                                  /* aName */
  "SymmetricPad",                      /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo o_emlrtECI = { -1,  /* nDims */
  803,                                 /* lineNo */
  9,                                   /* colNo */
  "SymmetricPad",                      /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m"/* pName */
};

static emlrtBCInfo kd_emlrtBCI = { 1,  /* iFirst */
  1,                                   /* iLast */
  100,                                 /* lineNo */
  32,                                  /* colNo */
  "",                                  /* aName */
  "padarray",                          /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo o_emlrtRTEI = { 14,/* lineNo */
  37,                                  /* colNo */
  "validatenonnan",                    /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/+valattr/validatenonnan.m"/* pName */
};

static emlrtRTEInfo p_emlrtRTEI = { 14,/* lineNo */
  37,                                  /* colNo */
  "validatenonnegative",               /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/+valattr/validatenonnegative.m"/* pName */
};

static emlrtRTEInfo q_emlrtRTEI = { 13,/* lineNo */
  37,                                  /* colNo */
  "validateinteger",                   /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/+valattr/validateinteger.m"/* pName */
};

static emlrtRTEInfo ye_emlrtRTEI = { 734,/* lineNo */
  12,                                  /* colNo */
  "padarray",                          /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m"/* pName */
};

static emlrtRTEInfo af_emlrtRTEI = { 28,/* lineNo */
  9,                                   /* colNo */
  "colon",                             /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/ops/colon.m"/* pName */
};

static emlrtRTEInfo bf_emlrtRTEI = { 72,/* lineNo */
  9,                                   /* colNo */
  "mod",                               /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elfun/mod.m"/* pName */
};

static emlrtRTEInfo cf_emlrtRTEI = { 103,/* lineNo */
  9,                                   /* colNo */
  "colon",                             /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/ops/colon.m"/* pName */
};

static emlrtRTEInfo df_emlrtRTEI = { 802,/* lineNo */
  9,                                   /* colNo */
  "padarray",                          /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m"/* pName */
};

static emlrtRTEInfo ef_emlrtRTEI = { 1,/* lineNo */
  14,                                  /* colNo */
  "padarray",                          /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m"/* pName */
};

static emlrtRTEInfo ff_emlrtRTEI = { 80,/* lineNo */
  5,                                   /* colNo */
  "padarray",                          /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m"/* pName */
};

static emlrtRTEInfo gf_emlrtRTEI = { 802,/* lineNo */
  30,                                  /* colNo */
  "padarray",                          /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m"/* pName */
};

static emlrtRTEInfo hf_emlrtRTEI = { 802,/* lineNo */
  26,                                  /* colNo */
  "padarray",                          /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m"/* pName */
};

/* Function Definitions */
void b_padarray(const emlrtStack *sp, const real_T varargin_1[3], const real_T
                varargin_2[2], emxArray_real_T *b)
{
  boolean_T p;
  int32_T k;
  boolean_T exitg1;
  real_T ndbl;
  emxArray_int8_T *idxA;
  emxArray_real_T *y;
  int32_T i;
  int32_T i1;
  real_T apnd;
  int32_T nm1d2;
  emxArray_real_T *r;
  int32_T n;
  emxArray_int8_T *idxDir;
  int32_T y_tmp;
  int8_T z1_data[3];
  static const int8_T iv[6] = { 1, 2, 3, 3, 2, 1 };

  int32_T b_idxDir[1];
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack f_st;
  emlrtStack g_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  f_st.prev = &e_st;
  f_st.tls = e_st.tls;
  g_st.prev = &f_st;
  g_st.tls = f_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  st.site = &qc_emlrtRSI;
  b_st.site = &tc_emlrtRSI;
  p = true;
  k = 0;
  exitg1 = false;
  while ((!exitg1) && (k < 2)) {
    if (!muDoubleScalarIsNaN(varargin_2[k])) {
      k++;
    } else {
      p = false;
      exitg1 = true;
    }
  }

  if (!p) {
    emlrtErrorWithMessageIdR2018a(&b_st, &o_emlrtRTEI,
      "Coder:toolbox:ValidateattributesexpectedNonNaN",
      "MATLAB:padarray:expectedNonNaN", 3, 4, 24, "input number 2, PADSIZE,");
  }

  b_st.site = &tc_emlrtRSI;
  p = true;
  k = 0;
  exitg1 = false;
  while ((!exitg1) && (k < 2)) {
    if (!(varargin_2[k] < 0.0)) {
      k++;
    } else {
      p = false;
      exitg1 = true;
    }
  }

  if (!p) {
    emlrtErrorWithMessageIdR2018a(&b_st, &p_emlrtRTEI,
      "Coder:toolbox:ValidateattributesexpectedNonnegative",
      "MATLAB:padarray:expectedNonnegative", 3, 4, 24,
      "input number 2, PADSIZE,");
  }

  b_st.site = &tc_emlrtRSI;
  p = true;
  k = 0;
  exitg1 = false;
  while ((!exitg1) && (k < 2)) {
    if ((!muDoubleScalarIsInf(varargin_2[k])) && (!muDoubleScalarIsNaN
         (varargin_2[k])) && (muDoubleScalarFloor(varargin_2[k]) == varargin_2[k]))
    {
      k++;
    } else {
      p = false;
      exitg1 = true;
    }
  }

  if (!p) {
    emlrtErrorWithMessageIdR2018a(&b_st, &q_emlrtRTEI,
      "Coder:toolbox:ValidateattributesexpectedInteger",
      "MATLAB:padarray:expectedInteger", 3, 4, 24, "input number 2, PADSIZE,");
  }

  st.site = &ef_emlrtRSI;
  b_st.site = &ff_emlrtRSI;
  ndbl = 2.0 * varargin_2[0];
  if ((ndbl + 1.0 < 3.0) || muDoubleScalarIsNaN(ndbl + 1.0)) {
    ndbl = 3.0;
  } else {
    ndbl++;
  }

  if (!(ndbl >= 0.0)) {
    emlrtNonNegativeCheckR2012b(ndbl, &d_emlrtDCI, &b_st);
  }

  if (ndbl != (int32_T)muDoubleScalarFloor(ndbl)) {
    emlrtIntegerCheckR2012b(ndbl, &e_emlrtDCI, &b_st);
  }

  emxInit_int8_T(&b_st, &idxA, 2, &ff_emlrtRTEI, true);
  emxInit_real_T(&b_st, &y, 2, &gf_emlrtRTEI, true);
  i = (int32_T)ndbl;
  i1 = idxA->size[0] * idxA->size[1];
  idxA->size[0] = i;
  idxA->size[1] = 2;
  emxEnsureCapacity_int8_T(&b_st, idxA, i1, &ye_emlrtRTEI);
  c_st.site = &gf_emlrtRSI;
  d_st.site = &hf_emlrtRSI;
  if (muDoubleScalarIsNaN(-varargin_2[0])) {
    i1 = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = 1;
    emxEnsureCapacity_real_T(&d_st, y, i1, &af_emlrtRTEI);
    y->data[0] = rtNaN;
  } else if (0.0 < -varargin_2[0]) {
    y->size[0] = 1;
    y->size[1] = 0;
  } else if (muDoubleScalarIsInf(-varargin_2[0]) && (-varargin_2[0] == 0.0)) {
    i1 = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = 1;
    emxEnsureCapacity_real_T(&d_st, y, i1, &af_emlrtRTEI);
    y->data[0] = rtNaN;
  } else if (muDoubleScalarFloor(-varargin_2[0]) == -varargin_2[0]) {
    i1 = y->size[0] * y->size[1];
    y->size[0] = 1;
    nm1d2 = (int32_T)muDoubleScalarFloor(0.0 - (-varargin_2[0]));
    y->size[1] = nm1d2 + 1;
    emxEnsureCapacity_real_T(&d_st, y, i1, &af_emlrtRTEI);
    for (i1 = 0; i1 <= nm1d2; i1++) {
      y->data[i1] = -varargin_2[0] + (real_T)i1;
    }
  } else {
    e_st.site = &if_emlrtRSI;
    ndbl = muDoubleScalarFloor((0.0 - (-varargin_2[0])) + 0.5);
    apnd = -varargin_2[0] + ndbl;
    if (muDoubleScalarAbs(apnd) < 4.4408920985006262E-16 * muDoubleScalarMax
        (muDoubleScalarAbs(-varargin_2[0]), 0.0)) {
      ndbl++;
      apnd = 0.0;
    } else if (apnd > 0.0) {
      apnd = -varargin_2[0] + (ndbl - 1.0);
    } else {
      ndbl++;
    }

    n = (int32_T)ndbl;
    i1 = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = n;
    emxEnsureCapacity_real_T(&e_st, y, i1, &cf_emlrtRTEI);
    if (n > 0) {
      y->data[0] = -varargin_2[0];
      if (n > 1) {
        y->data[n - 1] = apnd;
        nm1d2 = (n - 1) / 2;
        f_st.site = &jf_emlrtRSI;
        for (k = 0; k <= nm1d2 - 2; k++) {
          y_tmp = k + 1;
          y->data[k + 1] = -varargin_2[0] + (real_T)y_tmp;
          y->data[(n - k) - 2] = apnd - (real_T)y_tmp;
        }

        if (nm1d2 << 1 == n - 1) {
          y->data[nm1d2] = (-varargin_2[0] + apnd) / 2.0;
        } else {
          y->data[nm1d2] = -varargin_2[0] + (real_T)nm1d2;
          y->data[nm1d2 + 1] = apnd - (real_T)nm1d2;
        }
      }
    }
  }

  emxInit_real_T(&d_st, &r, 2, &hf_emlrtRTEI, true);
  c_st.site = &gf_emlrtRSI;
  d_st.site = &kf_emlrtRSI;
  i1 = r->size[0] * r->size[1];
  r->size[0] = 1;
  r->size[1] = y->size[1];
  emxEnsureCapacity_real_T(&d_st, r, i1, &bf_emlrtRTEI);
  e_st.site = &lf_emlrtRSI;
  nm1d2 = y->size[1];
  f_st.site = &mf_emlrtRSI;
  if ((1 <= y->size[1]) && (y->size[1] > 2147483646)) {
    g_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&g_st);
  }

  for (k = 0; k < nm1d2; k++) {
    ndbl = y->data[k];
    if (muDoubleScalarIsNaN(ndbl) || muDoubleScalarIsInf(ndbl)) {
      apnd = rtNaN;
    } else if (ndbl == 0.0) {
      apnd = 0.0;
    } else {
      apnd = muDoubleScalarRem(ndbl, 2.0);
      if (apnd == 0.0) {
        apnd = 0.0;
      } else {
        if (ndbl < 0.0) {
          apnd += 2.0;
        }
      }
    }

    r->data[k] = apnd;
  }

  emxFree_real_T(&y);
  emxInit_int8_T(&e_st, &idxDir, 2, &df_emlrtRTEI, true);
  i1 = idxDir->size[0] * idxDir->size[1];
  idxDir->size[0] = 1;
  idxDir->size[1] = r->size[1];
  emxEnsureCapacity_int8_T(&b_st, idxDir, i1, &df_emlrtRTEI);
  nm1d2 = r->size[0] * r->size[1];
  for (i1 = 0; i1 < nm1d2; i1++) {
    idxDir->data[i1] = 1;
  }

  if (1 > r->size[1]) {
    nm1d2 = 0;
  } else {
    if (1 > i) {
      emlrtDynamicBoundsCheckR2012b(1, 1, i, &id_emlrtBCI, &b_st);
    }

    if ((r->size[1] < 1) || (r->size[1] > i)) {
      emlrtDynamicBoundsCheckR2012b(r->size[1], 1, i, &jd_emlrtBCI, &b_st);
    }

    nm1d2 = r->size[1];
  }

  emlrtSubAssignSizeCheckR2012b(&nm1d2, 1, &r->size[0], 2, &o_emlrtECI, &b_st);
  emxFree_real_T(&r);
  for (i = 0; i < nm1d2; i++) {
    idxA->data[i] = idxDir->data[i];
  }

  c_st.site = &gf_emlrtRSI;
  d_st.site = &hf_emlrtRSI;
  c_st.site = &gf_emlrtRSI;
  d_st.site = &kf_emlrtRSI;
  e_st.site = &lf_emlrtRSI;
  f_st.site = &mf_emlrtRSI;
  z1_data[0] = 0;
  z1_data[1] = 1;
  z1_data[2] = 2;
  i = idxDir->size[0] * idxDir->size[1];
  idxDir->size[0] = 1;
  idxDir->size[1] = 3;
  emxEnsureCapacity_int8_T(&b_st, idxDir, i, &df_emlrtRTEI);
  for (i = 0; i < 3; i++) {
    idxDir->data[i] = iv[z1_data[i]];
  }

  if (1 > idxA->size[0]) {
    emlrtDynamicBoundsCheckR2012b(1, 1, idxA->size[0], &id_emlrtBCI, &b_st);
  }

  if (3 > idxA->size[0]) {
    emlrtDynamicBoundsCheckR2012b(3, 1, idxA->size[0], &jd_emlrtBCI, &b_st);
  }

  b_idxDir[0] = idxDir->size[1];
  emlrtSubAssignSizeCheckR2012b(&b_idxDir[0], 1, &idxDir->size[0], 2,
    &o_emlrtECI, &b_st);
  nm1d2 = idxDir->size[1];
  for (i = 0; i < nm1d2; i++) {
    idxA->data[i + idxA->size[0]] = idxDir->data[i];
  }

  emxFree_int8_T(&idxDir);
  i = b->size[0] * b->size[1];
  b->size[0] = (int32_T)(varargin_2[0] + 1.0);
  b->size[1] = 3;
  emxEnsureCapacity_real_T(sp, b, i, &ef_emlrtRTEI);
  for (nm1d2 = 0; nm1d2 < 3; nm1d2++) {
    i = b->size[0];
    for (y_tmp = 0; y_tmp < i; y_tmp++) {
      i1 = y_tmp + 1;
      if ((i1 < 1) || (i1 > idxA->size[0])) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, idxA->size[0], &hd_emlrtBCI, sp);
      }

      k = idxA->data[i1 - 1];
      if ((k < 1) || (k > 1)) {
        emlrtDynamicBoundsCheckR2012b(idxA->data[i1 - 1], 1, 1, &kd_emlrtBCI, sp);
      }

      i1 = y_tmp + 1;
      if ((i1 < 1) || (i1 > b->size[0])) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, b->size[0], &fd_emlrtBCI, sp);
      }

      k = nm1d2 + 1;
      if (k > idxA->size[0]) {
        emlrtDynamicBoundsCheckR2012b(k, 1, idxA->size[0], &gd_emlrtBCI, sp);
      }

      b->data[(i1 + b->size[0] * nm1d2) - 1] = varargin_1[idxA->data[(k +
        idxA->size[0]) - 1] - 1];
    }
  }

  emxFree_int8_T(&idxA);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void c_padarray(const emlrtStack *sp, const emxArray_boolean_T *varargin_1,
                emxArray_boolean_T *b)
{
  real_T sizeB[3];
  int32_T i;
  int32_T j;
  int32_T i1;
  int32_T b_i;
  int32_T a;
  int32_T i2;
  int32_T b_b;
  int32_T i3;
  int32_T k;
  int32_T i4;
  int32_T i5;
  int32_T i6;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  if ((varargin_1->size[0] == 0) || (varargin_1->size[1] == 0) ||
      (varargin_1->size[2] == 0)) {
    sizeB[0] = varargin_1->size[0] + 4U;
    sizeB[1] = varargin_1->size[1] + 4U;
    sizeB[2] = varargin_1->size[2] + 4U;
    st.site = &rc_emlrtRSI;
    repmat(&st, sizeB, b);
  } else {
    st.site = &sc_emlrtRSI;
    if ((real_T)varargin_1->size[0] + 4.0 != (int32_T)((real_T)varargin_1->size
         [0] + 4.0)) {
      emlrtIntegerCheckR2012b((real_T)varargin_1->size[0] + 4.0, &b_emlrtDCI,
        &st);
    }

    if ((real_T)varargin_1->size[1] + 4.0 != (int32_T)((real_T)varargin_1->size
         [1] + 4.0)) {
      emlrtIntegerCheckR2012b((real_T)varargin_1->size[1] + 4.0, &b_emlrtDCI,
        &st);
    }

    if ((real_T)varargin_1->size[2] + 4.0 != (int32_T)((real_T)varargin_1->size
         [2] + 4.0)) {
      emlrtIntegerCheckR2012b((real_T)varargin_1->size[2] + 4.0, &b_emlrtDCI,
        &st);
    }

    i = b->size[0] * b->size[1] * b->size[2];
    b->size[0] = (int32_T)(uint32_T)((real_T)varargin_1->size[0] + 4.0);
    b->size[1] = (int32_T)(uint32_T)((real_T)varargin_1->size[1] + 4.0);
    b->size[2] = (int32_T)(uint32_T)((real_T)varargin_1->size[2] + 4.0);
    emxEnsureCapacity_boolean_T(&st, b, i, &wd_emlrtRTEI);
    i = b->size[1];
    for (j = 0; j < i; j++) {
      i1 = b->size[0];
      for (b_i = 0; b_i < i1; b_i++) {
        i2 = b_i + 1;
        if ((i2 < 1) || (i2 > b->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &uc_emlrtBCI, &st);
        }

        i3 = j + 1;
        if ((i3 < 1) || (i3 > b->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[1], &uc_emlrtBCI, &st);
        }

        b->data[(i2 + b->size[0] * (i3 - 1)) - 1] = false;
      }
    }

    i = b->size[1];
    for (j = 0; j < i; j++) {
      i1 = b->size[0];
      for (b_i = 0; b_i < i1; b_i++) {
        i2 = b_i + 1;
        if ((i2 < 1) || (i2 > b->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &uc_emlrtBCI, &st);
        }

        i3 = j + 1;
        if ((i3 < 1) || (i3 > b->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[1], &uc_emlrtBCI, &st);
        }

        b->data[((i2 + b->size[0] * (i3 - 1)) + b->size[0] * b->size[1]) - 1] =
          false;
      }
    }

    a = varargin_1->size[2] + 3;
    b_b = b->size[2];
    b_st.site = &vc_emlrtRSI;
    if ((varargin_1->size[2] + 3 <= b->size[2]) && (b->size[2] > 2147483646)) {
      c_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&c_st);
    }

    for (k = a; k <= b_b; k++) {
      i = b->size[1];
      for (j = 0; j < i; j++) {
        i1 = b->size[0];
        for (b_i = 0; b_i < i1; b_i++) {
          i2 = b_i + 1;
          if ((i2 < 1) || (i2 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &pc_emlrtBCI, &st);
          }

          i3 = j + 1;
          if ((i3 < 1) || (i3 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[1], &pc_emlrtBCI, &st);
          }

          if ((k < 1) || (k > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(k, 1, b->size[2], &pc_emlrtBCI, &st);
          }

          b->data[((i2 + b->size[0] * (i3 - 1)) + b->size[0] * b->size[1] * (k -
                    1)) - 1] = false;
        }
      }
    }

    i = varargin_1->size[2];
    for (k = 0; k < i; k++) {
      i1 = b->size[0];
      for (b_i = 0; b_i < i1; b_i++) {
        i2 = b_i + 1;
        if ((i2 < 1) || (i2 > b->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &vc_emlrtBCI, &st);
        }

        i3 = k + 3;
        if ((i3 < 1) || (i3 > b->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &vc_emlrtBCI, &st);
        }

        b->data[(i2 + b->size[0] * b->size[1] * (i3 - 1)) - 1] = false;
      }

      i1 = b->size[0];
      for (b_i = 0; b_i < i1; b_i++) {
        i2 = b_i + 1;
        if ((i2 < 1) || (i2 > b->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &vc_emlrtBCI, &st);
        }

        i3 = k + 3;
        if ((i3 < 1) || (i3 > b->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &vc_emlrtBCI, &st);
        }

        b->data[((i2 + b->size[0]) + b->size[0] * b->size[1] * (i3 - 1)) - 1] =
          false;
      }

      a = varargin_1->size[1] + 3;
      b_b = b->size[1];
      b_st.site = &wc_emlrtRSI;
      if ((varargin_1->size[1] + 3 <= b->size[1]) && (b->size[1] > 2147483646))
      {
        c_st.site = &i_emlrtRSI;
        check_forloop_overflow_error(&c_st);
      }

      for (j = a; j <= b_b; j++) {
        i1 = b->size[0];
        for (b_i = 0; b_i < i1; b_i++) {
          i2 = b_i + 1;
          if ((i2 < 1) || (i2 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &sc_emlrtBCI, &st);
          }

          if ((j < 1) || (j > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(j, 1, b->size[1], &sc_emlrtBCI, &st);
          }

          i3 = k + 3;
          if ((i3 < 1) || (i3 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &sc_emlrtBCI, &st);
          }

          b->data[((i2 + b->size[0] * (j - 1)) + b->size[0] * b->size[1] * (i3 -
                    1)) - 1] = false;
        }
      }

      i1 = varargin_1->size[1];
      for (j = 0; j < i1; j++) {
        i2 = j + 3;
        if ((i2 < 1) || (i2 > b->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[1], &wc_emlrtBCI, &st);
        }

        i3 = k + 3;
        if ((i3 < 1) || (i3 > b->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &wc_emlrtBCI, &st);
        }

        b->data[b->size[0] * (i2 - 1) + b->size[0] * b->size[1] * (i3 - 1)] =
          false;
        i2 = j + 3;
        if ((i2 < 1) || (i2 > b->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[1], &wc_emlrtBCI, &st);
        }

        i3 = k + 3;
        if ((i3 < 1) || (i3 > b->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &wc_emlrtBCI, &st);
        }

        b->data[(b->size[0] * (i2 - 1) + b->size[0] * b->size[1] * (i3 - 1)) + 1]
          = false;
      }

      i1 = varargin_1->size[1];
      for (j = 0; j < i1; j++) {
        a = varargin_1->size[0] + 3;
        b_b = b->size[0];
        b_st.site = &xc_emlrtRSI;
        if ((varargin_1->size[0] + 3 <= b->size[0]) && (b->size[0] > 2147483646))
        {
          c_st.site = &i_emlrtRSI;
          check_forloop_overflow_error(&c_st);
        }

        for (b_i = a; b_i <= b_b; b_i++) {
          if ((b_i < 1) || (b_i > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(b_i, 1, b->size[0], &tc_emlrtBCI, &st);
          }

          i2 = j + 3;
          if ((i2 < 1) || (i2 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[1], &tc_emlrtBCI, &st);
          }

          i3 = k + 3;
          if ((i3 < 1) || (i3 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &tc_emlrtBCI, &st);
          }

          b->data[((b_i + b->size[0] * (i2 - 1)) + b->size[0] * b->size[1] * (i3
                    - 1)) - 1] = false;
        }
      }
    }

    i = varargin_1->size[2];
    for (k = 0; k < i; k++) {
      i1 = varargin_1->size[1];
      for (j = 0; j < i1; j++) {
        i2 = varargin_1->size[0];
        for (b_i = 0; b_i < i2; b_i++) {
          i3 = b_i + 1;
          if ((i3 < 1) || (i3 > varargin_1->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, varargin_1->size[0],
              &qc_emlrtBCI, &st);
          }

          a = j + 1;
          if ((a < 1) || (a > varargin_1->size[1])) {
            emlrtDynamicBoundsCheckR2012b(a, 1, varargin_1->size[1],
              &qc_emlrtBCI, &st);
          }

          b_b = k + 1;
          if ((b_b < 1) || (b_b > varargin_1->size[2])) {
            emlrtDynamicBoundsCheckR2012b(b_b, 1, varargin_1->size[2],
              &qc_emlrtBCI, &st);
          }

          i4 = b_i + 3;
          if ((i4 < 1) || (i4 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i4, 1, b->size[0], &rc_emlrtBCI, &st);
          }

          i5 = j + 3;
          if ((i5 < 1) || (i5 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i5, 1, b->size[1], &rc_emlrtBCI, &st);
          }

          i6 = k + 3;
          if ((i6 < 1) || (i6 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i6, 1, b->size[2], &rc_emlrtBCI, &st);
          }

          b->data[((i4 + b->size[0] * (i5 - 1)) + b->size[0] * b->size[1] * (i6
                    - 1)) - 1] = varargin_1->data[((i3 + varargin_1->size[0] *
            (a - 1)) + varargin_1->size[0] * varargin_1->size[1] * (b_b - 1)) -
            1];
        }
      }
    }
  }
}

void padarray(const emlrtStack *sp, const emxArray_boolean_T *varargin_1,
              emxArray_boolean_T *b)
{
  real_T sizeB[3];
  uint32_T sizeB_idx_1;
  int32_T i;
  int32_T j;
  int32_T a;
  int32_T i1;
  int32_T b_b;
  int32_T b_i;
  int32_T i2;
  int32_T k;
  int32_T i3;
  int32_T i4;
  int32_T i5;
  int32_T i6;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  if ((varargin_1->size[0] == 0) || (varargin_1->size[1] == 0) ||
      (varargin_1->size[2] == 0)) {
    sizeB[0] = varargin_1->size[0] + 2U;
    sizeB[1] = varargin_1->size[1] + 2U;
    sizeB[2] = varargin_1->size[2] + 2U;
    st.site = &rc_emlrtRSI;
    repmat(&st, sizeB, b);
  } else {
    st.site = &sc_emlrtRSI;
    if ((real_T)varargin_1->size[0] + 2.0 != (int32_T)((real_T)varargin_1->size
         [0] + 2.0)) {
      emlrtIntegerCheckR2012b((real_T)varargin_1->size[0] + 2.0, &b_emlrtDCI,
        &st);
    }

    if ((real_T)varargin_1->size[1] + 2.0 != (int32_T)((real_T)varargin_1->size
         [1] + 2.0)) {
      emlrtIntegerCheckR2012b((real_T)varargin_1->size[1] + 2.0, &b_emlrtDCI,
        &st);
    }

    sizeB_idx_1 = (uint32_T)((real_T)varargin_1->size[1] + 2.0);
    if ((real_T)varargin_1->size[2] + 2.0 != (int32_T)((real_T)varargin_1->size
         [2] + 2.0)) {
      emlrtIntegerCheckR2012b((real_T)varargin_1->size[2] + 2.0, &b_emlrtDCI,
        &st);
    }

    i = b->size[0] * b->size[1] * b->size[2];
    b->size[0] = (int32_T)(uint32_T)((real_T)varargin_1->size[0] + 2.0);
    b->size[1] = (int32_T)sizeB_idx_1;
    b->size[2] = (int32_T)(uint32_T)((real_T)varargin_1->size[2] + 2.0);
    emxEnsureCapacity_boolean_T(&st, b, i, &wd_emlrtRTEI);
    i = (int32_T)sizeB_idx_1;
    for (j = 0; j < i; j++) {
      i1 = b->size[0];
      for (b_i = 0; b_i < i1; b_i++) {
        i2 = b_i + 1;
        if ((i2 < 1) || (i2 > b->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &uc_emlrtBCI, &st);
        }

        i3 = j + 1;
        if ((i3 < 1) || (i3 > b->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[1], &uc_emlrtBCI, &st);
        }

        b->data[(i2 + b->size[0] * (i3 - 1)) - 1] = false;
      }
    }

    a = varargin_1->size[2] + 2;
    b_b = b->size[2];
    b_st.site = &vc_emlrtRSI;
    if ((varargin_1->size[2] + 2 <= b->size[2]) && (b->size[2] > 2147483646)) {
      c_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&c_st);
    }

    for (k = a; k <= b_b; k++) {
      i = b->size[1];
      for (j = 0; j < i; j++) {
        i1 = b->size[0];
        for (b_i = 0; b_i < i1; b_i++) {
          i2 = b_i + 1;
          if ((i2 < 1) || (i2 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &pc_emlrtBCI, &st);
          }

          i3 = j + 1;
          if ((i3 < 1) || (i3 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[1], &pc_emlrtBCI, &st);
          }

          if ((k < 1) || (k > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(k, 1, b->size[2], &pc_emlrtBCI, &st);
          }

          b->data[((i2 + b->size[0] * (i3 - 1)) + b->size[0] * b->size[1] * (k -
                    1)) - 1] = false;
        }
      }
    }

    i = varargin_1->size[2];
    for (k = 0; k < i; k++) {
      i1 = b->size[0];
      for (b_i = 0; b_i < i1; b_i++) {
        i2 = b_i + 1;
        if ((i2 < 1) || (i2 > b->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &vc_emlrtBCI, &st);
        }

        i3 = k + 2;
        if ((i3 < 1) || (i3 > b->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &vc_emlrtBCI, &st);
        }

        b->data[(i2 + b->size[0] * b->size[1] * (i3 - 1)) - 1] = false;
      }

      a = varargin_1->size[1] + 2;
      b_b = b->size[1];
      b_st.site = &wc_emlrtRSI;
      if ((varargin_1->size[1] + 2 <= b->size[1]) && (b->size[1] > 2147483646))
      {
        c_st.site = &i_emlrtRSI;
        check_forloop_overflow_error(&c_st);
      }

      for (j = a; j <= b_b; j++) {
        i1 = b->size[0];
        for (b_i = 0; b_i < i1; b_i++) {
          i2 = b_i + 1;
          if ((i2 < 1) || (i2 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &sc_emlrtBCI, &st);
          }

          if ((j < 1) || (j > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(j, 1, b->size[1], &sc_emlrtBCI, &st);
          }

          i3 = k + 2;
          if ((i3 < 1) || (i3 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &sc_emlrtBCI, &st);
          }

          b->data[((i2 + b->size[0] * (j - 1)) + b->size[0] * b->size[1] * (i3 -
                    1)) - 1] = false;
        }
      }

      i1 = varargin_1->size[1];
      for (j = 0; j < i1; j++) {
        i2 = j + 2;
        if ((i2 < 1) || (i2 > b->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[1], &wc_emlrtBCI, &st);
        }

        i3 = k + 2;
        if ((i3 < 1) || (i3 > b->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &wc_emlrtBCI, &st);
        }

        b->data[b->size[0] * (i2 - 1) + b->size[0] * b->size[1] * (i3 - 1)] =
          false;
      }

      i1 = varargin_1->size[1];
      for (j = 0; j < i1; j++) {
        a = varargin_1->size[0] + 2;
        b_b = b->size[0];
        b_st.site = &xc_emlrtRSI;
        if ((varargin_1->size[0] + 2 <= b->size[0]) && (b->size[0] > 2147483646))
        {
          c_st.site = &i_emlrtRSI;
          check_forloop_overflow_error(&c_st);
        }

        for (b_i = a; b_i <= b_b; b_i++) {
          if ((b_i < 1) || (b_i > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(b_i, 1, b->size[0], &tc_emlrtBCI, &st);
          }

          i2 = j + 2;
          if ((i2 < 1) || (i2 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[1], &tc_emlrtBCI, &st);
          }

          i3 = k + 2;
          if ((i3 < 1) || (i3 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &tc_emlrtBCI, &st);
          }

          b->data[((b_i + b->size[0] * (i2 - 1)) + b->size[0] * b->size[1] * (i3
                    - 1)) - 1] = false;
        }
      }
    }

    i = varargin_1->size[2];
    for (k = 0; k < i; k++) {
      i1 = varargin_1->size[1];
      for (j = 0; j < i1; j++) {
        i2 = varargin_1->size[0];
        for (b_i = 0; b_i < i2; b_i++) {
          i3 = b_i + 1;
          if ((i3 < 1) || (i3 > varargin_1->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, varargin_1->size[0],
              &qc_emlrtBCI, &st);
          }

          a = j + 1;
          if ((a < 1) || (a > varargin_1->size[1])) {
            emlrtDynamicBoundsCheckR2012b(a, 1, varargin_1->size[1],
              &qc_emlrtBCI, &st);
          }

          b_b = k + 1;
          if ((b_b < 1) || (b_b > varargin_1->size[2])) {
            emlrtDynamicBoundsCheckR2012b(b_b, 1, varargin_1->size[2],
              &qc_emlrtBCI, &st);
          }

          i4 = b_i + 2;
          if ((i4 < 1) || (i4 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i4, 1, b->size[0], &rc_emlrtBCI, &st);
          }

          i5 = j + 2;
          if ((i5 < 1) || (i5 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i5, 1, b->size[1], &rc_emlrtBCI, &st);
          }

          i6 = k + 2;
          if ((i6 < 1) || (i6 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i6, 1, b->size[2], &rc_emlrtBCI, &st);
          }

          b->data[((i4 + b->size[0] * (i5 - 1)) + b->size[0] * b->size[1] * (i6
                    - 1)) - 1] = varargin_1->data[((i3 + varargin_1->size[0] *
            (a - 1)) + varargin_1->size[0] * varargin_1->size[1] * (b_b - 1)) -
            1];
        }
      }
    }
  }
}

/* End of code generation (padarray.c) */

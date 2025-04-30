/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * TS_Label2Centroid.c
 *
 * Code generation for function 'TS_Label2Centroid'
 *
 */

/* Include files */
#include "TS_Label2Centroid.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "mwmathutil.h"
#include "rt_nonfinite.h"
#include "sum.h"

/* Variable Definitions */
static emlrtRSInfo je_emlrtRSI = { 2,  /* lineNo */
  "TS_Label2Centroid",                 /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pathName */
};

static emlrtRSInfo ke_emlrtRSI = { 8,  /* lineNo */
  "TS_Label2Centroid",                 /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pathName */
};

static emlrtRSInfo le_emlrtRSI = { 9,  /* lineNo */
  "TS_Label2Centroid",                 /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pathName */
};

static emlrtRSInfo me_emlrtRSI = { 10, /* lineNo */
  "TS_Label2Centroid",                 /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pathName */
};

static emlrtRSInfo ne_emlrtRSI = { 11, /* lineNo */
  "TS_Label2Centroid",                 /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pathName */
};

static emlrtRSInfo oe_emlrtRSI = { 12, /* lineNo */
  "TS_Label2Centroid",                 /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pathName */
};

static emlrtRSInfo pe_emlrtRSI = { 13, /* lineNo */
  "TS_Label2Centroid",                 /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pathName */
};

static emlrtRSInfo xe_emlrtRSI = { 32, /* lineNo */
  "squeeze",                           /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/squeeze.m"/* pathName */
};

static emlrtRSInfo ye_emlrtRSI = { 29, /* lineNo */
  "reshapeSizeChecks",                 /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/reshapeSizeChecks.m"/* pathName */
};

static emlrtRSInfo af_emlrtRSI = { 109,/* lineNo */
  "computeDimsData",                   /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/reshapeSizeChecks.m"/* pathName */
};

static emlrtRSInfo bf_emlrtRSI = { 23, /* lineNo */
  "TS_Label2Centroid/vectGra",         /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pathName */
};

static emlrtBCInfo bd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  21,                                  /* lineNo */
  13,                                  /* colNo */
  "m",                                 /* aName */
  "TS_Label2Centroid/vectGra",         /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo cd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  21,                                  /* lineNo */
  29,                                  /* colNo */
  "h",                                 /* aName */
  "TS_Label2Centroid/vectGra",         /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo dd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  21,                                  /* lineNo */
  20,                                  /* colNo */
  "num",                               /* aName */
  "TS_Label2Centroid/vectGra",         /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo c_emlrtDCI = { 3,   /* lineNo */
  11,                                  /* colNo */
  "TS_Label2Centroid",                 /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m",/* pName */
  1                                    /* checkKind */
};

static emlrtRTEInfo l_emlrtRTEI = { 52,/* lineNo */
  13,                                  /* colNo */
  "reshapeSizeChecks",                 /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/reshapeSizeChecks.m"/* pName */
};

static emlrtRTEInfo m_emlrtRTEI = { 59,/* lineNo */
  23,                                  /* colNo */
  "reshapeSizeChecks",                 /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/reshapeSizeChecks.m"/* pName */
};

static emlrtBCInfo ed_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  14,                                  /* lineNo */
  7,                                   /* colNo */
  "s",                                 /* aName */
  "TS_Label2Centroid",                 /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo n_emlrtRTEI = { 6, /* lineNo */
  9,                                   /* colNo */
  "TS_Label2Centroid",                 /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pName */
};

static emlrtRTEInfo ne_emlrtRTEI = { 3,/* lineNo */
  5,                                   /* colNo */
  "TS_Label2Centroid",                 /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pName */
};

static emlrtRTEInfo oe_emlrtRTEI = { 7,/* lineNo */
  5,                                   /* colNo */
  "TS_Label2Centroid",                 /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pName */
};

static emlrtRTEInfo pe_emlrtRTEI = { 18,/* lineNo */
  9,                                   /* colNo */
  "TS_Label2Centroid",                 /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pName */
};

static emlrtRTEInfo qe_emlrtRTEI = { 19,/* lineNo */
  9,                                   /* colNo */
  "TS_Label2Centroid",                 /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pName */
};

static emlrtRTEInfo re_emlrtRTEI = { 8,/* lineNo */
  21,                                  /* colNo */
  "TS_Label2Centroid",                 /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pName */
};

static emlrtRTEInfo se_emlrtRTEI = { 10,/* lineNo */
  21,                                  /* colNo */
  "TS_Label2Centroid",                 /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pName */
};

static emlrtRTEInfo te_emlrtRTEI = { 12,/* lineNo */
  21,                                  /* colNo */
  "TS_Label2Centroid",                 /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pName */
};

static emlrtRTEInfo ue_emlrtRTEI = { 8,/* lineNo */
  26,                                  /* colNo */
  "TS_Label2Centroid",                 /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pName */
};

static emlrtRTEInfo ve_emlrtRTEI = { 12,/* lineNo */
  26,                                  /* colNo */
  "TS_Label2Centroid",                 /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Label2Centroid.m"/* pName */
};

/* Function Declarations */
static real_T vectGra(const emlrtStack *sp, const emxArray_real_T *h);

/* Function Definitions */
static real_T vectGra(const emlrtStack *sp, const emxArray_real_T *h)
{
  real_T x;
  int32_T vlen;
  emxArray_real_T *num;
  int32_T i;
  emxArray_real_T *m;
  int32_T k;
  real_T B;
  int32_T i1;
  int32_T i2;
  real_T B_data_idx_0;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack f_st;
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
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  if (h->size[0] == 0) {
    vlen = 0;
  } else {
    vlen = muIntScalarMax_sint32(h->size[0], 1);
  }

  emxInit_real_T(sp, &num, 2, &pe_emlrtRTEI, true);
  if (vlen < 1) {
    num->size[0] = 1;
    num->size[1] = 0;
  } else {
    i = num->size[0] * num->size[1];
    num->size[0] = 1;
    num->size[1] = vlen;
    emxEnsureCapacity_real_T(sp, num, i, &pe_emlrtRTEI);
    vlen--;
    for (i = 0; i <= vlen; i++) {
      num->data[i] = (real_T)i + 1.0;
    }
  }

  emxInit_real_T(sp, &m, 2, &qe_emlrtRTEI, true);
  if (h->size[0] == 0) {
    vlen = 0;
  } else {
    vlen = muIntScalarMax_sint32(h->size[0], 1);
  }

  i = m->size[0] * m->size[1];
  m->size[0] = 1;
  m->size[1] = vlen;
  emxEnsureCapacity_real_T(sp, m, i, &qe_emlrtRTEI);
  for (i = 0; i < vlen; i++) {
    m->data[i] = 0.0;
  }

  if (h->size[0] == 0) {
    vlen = 0;
  } else {
    vlen = muIntScalarMax_sint32(h->size[0], 1);
  }

  for (k = 0; k < vlen; k++) {
    i = k + 1;
    if (i > m->size[1]) {
      emlrtDynamicBoundsCheckR2012b(i, 1, m->size[1], &bd_emlrtBCI, sp);
    }

    i1 = k + 1;
    if (i1 > h->size[0]) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, h->size[0], &cd_emlrtBCI, sp);
    }

    i2 = k + 1;
    if (i2 > num->size[1]) {
      emlrtDynamicBoundsCheckR2012b(i2, 1, num->size[1], &dd_emlrtBCI, sp);
    }

    m->data[i - 1] = num->data[i2 - 1] * h->data[i1 - 1];
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(&num);
  st.site = &bf_emlrtRSI;
  B = c_sum(&st, m);
  st.site = &bf_emlrtRSI;
  b_st.site = &qe_emlrtRSI;
  emxFree_real_T(&m);
  c_st.site = &re_emlrtRSI;
  vlen = h->size[0];
  if (h->size[0] == 0) {
    B_data_idx_0 = 0.0;
  } else {
    d_st.site = &se_emlrtRSI;
    e_st.site = &te_emlrtRSI;
    B_data_idx_0 = h->data[0];
    e_st.site = &ve_emlrtRSI;
    if ((2 <= h->size[0]) && (h->size[0] > 2147483646)) {
      f_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&f_st);
    }

    for (k = 2; k <= vlen; k++) {
      B_data_idx_0 += h->data[k - 1];
    }
  }

  x = B / B_data_idx_0;
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
  return x;
}

void TS_Label2Centroid(const emlrtStack *sp, const emxArray_real_T *L,
  emxArray_real_T *s)
{
  int32_T n;
  real_T NUM;
  int32_T idx;
  int32_T k;
  boolean_T exitg1;
  int32_T a;
  int32_T i;
  int32_T i1;
  emxArray_real_T *bw;
  emxArray_real_T *b_a;
  emxArray_real_T *num;
  emxArray_real_T *m;
  emxArray_real_T *c_a;
  emxArray_real_T *d_a;
  emxArray_real_T *r;
  emxArray_real_T *r1;
  int32_T sqsz_idx_0;
  emxArray_real_T e_a;
  int32_T sqsz[2];
  real_T c_idx_1;
  int32_T b_sqsz[2];
  real_T c_idx_2;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack f_st;
  emlrtStack g_st;
  emlrtStack h_st;
  emlrtStack i_st;
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
  h_st.prev = &g_st;
  h_st.tls = g_st.tls;
  i_st.prev = &h_st;
  i_st.tls = h_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  st.site = &je_emlrtRSI;
  b_st.site = &qd_emlrtRSI;
  c_st.site = &rd_emlrtRSI;
  d_st.site = &sd_emlrtRSI;
  if (L->size[0] * L->size[1] * L->size[2] < 1) {
    emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
      "Coder:toolbox:eml_min_or_max_varDimZero",
      "Coder:toolbox:eml_min_or_max_varDimZero", 0);
  }

  e_st.site = &td_emlrtRSI;
  f_st.site = &ud_emlrtRSI;
  n = L->size[0] * L->size[1] * L->size[2];
  if (L->size[0] * L->size[1] * L->size[2] <= 2) {
    if (L->size[0] * L->size[1] * L->size[2] == 1) {
      NUM = L->data[0];
    } else if ((L->data[0] < L->data[1]) || (muDoubleScalarIsNaN(L->data[0]) &&
                (!muDoubleScalarIsNaN(L->data[1])))) {
      NUM = L->data[1];
    } else {
      NUM = L->data[0];
    }
  } else {
    g_st.site = &xd_emlrtRSI;
    if (!muDoubleScalarIsNaN(L->data[0])) {
      idx = 1;
    } else {
      idx = 0;
      h_st.site = &yd_emlrtRSI;
      if ((2 <= L->size[0] * L->size[1] * L->size[2]) && (L->size[0] * L->size[1]
           * L->size[2] > 2147483646)) {
        i_st.site = &i_emlrtRSI;
        check_forloop_overflow_error(&i_st);
      }

      k = 2;
      exitg1 = false;
      while ((!exitg1) && (k <= L->size[0] * L->size[1] * L->size[2])) {
        if (!muDoubleScalarIsNaN(L->data[k - 1])) {
          idx = k;
          exitg1 = true;
        } else {
          k++;
        }
      }
    }

    if (idx == 0) {
      NUM = L->data[0];
    } else {
      g_st.site = &vd_emlrtRSI;
      NUM = L->data[idx - 1];
      a = idx + 1;
      h_st.site = &wd_emlrtRSI;
      if ((idx + 1 <= L->size[0] * L->size[1] * L->size[2]) && (L->size[0] *
           L->size[1] * L->size[2] > 2147483646)) {
        i_st.site = &i_emlrtRSI;
        check_forloop_overflow_error(&i_st);
      }

      for (k = a; k <= n; k++) {
        if (NUM < L->data[k - 1]) {
          NUM = L->data[k - 1];
        }
      }
    }
  }

  if (NUM != (int32_T)muDoubleScalarFloor(NUM)) {
    emlrtIntegerCheckR2012b(NUM, &c_emlrtDCI, sp);
  }

  i = (int32_T)NUM;
  i1 = s->size[0] * s->size[1];
  s->size[0] = i;
  s->size[1] = 3;
  emxEnsureCapacity_real_T(sp, s, i1, &ne_emlrtRTEI);
  emlrtForLoopVectorCheckR2012b(1.0, 1.0, NUM, mxDOUBLE_CLASS, (int32_T)NUM,
    &n_emlrtRTEI, sp);
  emxInit_real_T(sp, &bw, 3, &oe_emlrtRTEI, true);
  emxInit_real_T(sp, &b_a, 2, &re_emlrtRTEI, true);
  emxInit_real_T(sp, &num, 2, &pe_emlrtRTEI, true);
  emxInit_real_T(sp, &m, 2, &qe_emlrtRTEI, true);
  emxInit_real_T(sp, &c_a, 1, &se_emlrtRTEI, true);
  emxInit_real_T(sp, &d_a, 3, &te_emlrtRTEI, true);
  emxInit_real_T(sp, &r, 2, &ue_emlrtRTEI, true);
  emxInit_real_T(sp, &r1, 3, &ve_emlrtRTEI, true);
  for (n = 0; n < i; n++) {
    i1 = bw->size[0] * bw->size[1] * bw->size[2];
    bw->size[0] = L->size[0];
    bw->size[1] = L->size[1];
    bw->size[2] = L->size[2];
    emxEnsureCapacity_real_T(sp, bw, i1, &oe_emlrtRTEI);
    idx = L->size[0] * L->size[1] * L->size[2];
    for (i1 = 0; i1 < idx; i1++) {
      bw->data[i1] = (L->data[i1] == (real_T)n + 1.0);
    }

    st.site = &ke_emlrtRSI;
    b_st.site = &ke_emlrtRSI;
    sum(&b_st, bw, r);
    b_st.site = &ke_emlrtRSI;
    b_sum(&b_st, r, b_a);
    b_st.site = &xe_emlrtRSI;
    idx = b_a->size[1];
    c_st.site = &ye_emlrtRSI;
    d_st.site = &af_emlrtRSI;
    a = 1;
    if (b_a->size[1] > 1) {
      a = b_a->size[1];
    }

    if (b_a->size[1] > muIntScalarMax_sint32(idx, a)) {
      emlrtErrorWithMessageIdR2018a(&b_st, &l_emlrtRTEI,
        "Coder:toolbox:reshape_emptyReshapeLimit",
        "Coder:toolbox:reshape_emptyReshapeLimit", 0);
    }

    st.site = &le_emlrtRSI;
    if (b_a->size[1] < 1) {
      num->size[0] = 1;
      num->size[1] = 0;
    } else {
      i1 = num->size[0] * num->size[1];
      num->size[0] = 1;
      num->size[1] = (int32_T)((real_T)b_a->size[1] - 1.0) + 1;
      emxEnsureCapacity_real_T(&st, num, i1, &pe_emlrtRTEI);
      idx = (int32_T)((real_T)b_a->size[1] - 1.0);
      for (i1 = 0; i1 <= idx; i1++) {
        num->data[i1] = (real_T)i1 + 1.0;
      }
    }

    i1 = m->size[0] * m->size[1];
    m->size[0] = 1;
    m->size[1] = b_a->size[1];
    emxEnsureCapacity_real_T(&st, m, i1, &qe_emlrtRTEI);
    idx = b_a->size[1];
    for (i1 = 0; i1 < idx; i1++) {
      m->data[i1] = 0.0;
    }

    i1 = b_a->size[1];
    for (k = 0; k < i1; k++) {
      idx = k + 1;
      if ((idx < 1) || (idx > m->size[1])) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, m->size[1], &bd_emlrtBCI, &st);
      }

      a = k + 1;
      if ((a < 1) || (a > b_a->size[1])) {
        emlrtDynamicBoundsCheckR2012b(a, 1, b_a->size[1], &cd_emlrtBCI, &st);
      }

      sqsz_idx_0 = k + 1;
      if ((sqsz_idx_0 < 1) || (sqsz_idx_0 > num->size[1])) {
        emlrtDynamicBoundsCheckR2012b(sqsz_idx_0, 1, num->size[1], &dd_emlrtBCI,
          &st);
      }

      m->data[idx - 1] = num->data[sqsz_idx_0 - 1] * b_a->data[a - 1];
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(&st);
      }
    }

    b_st.site = &bf_emlrtRSI;
    NUM = c_sum(&b_st, m) / c_sum(&b_st, b_a);
    st.site = &me_emlrtRSI;
    b_st.site = &me_emlrtRSI;
    sum(&b_st, bw, r);
    b_st.site = &me_emlrtRSI;
    d_sum(&b_st, r, c_a);
    sqsz_idx_0 = 1;
    if (c_a->size[0] != 1) {
      sqsz_idx_0 = c_a->size[0];
    }

    b_st.site = &xe_emlrtRSI;
    idx = c_a->size[0];
    c_st.site = &ye_emlrtRSI;
    d_st.site = &af_emlrtRSI;
    d_st.site = &af_emlrtRSI;
    a = c_a->size[0];
    if (1 > c_a->size[0]) {
      a = 1;
    }

    if (sqsz_idx_0 > muIntScalarMax_sint32(idx, a)) {
      emlrtErrorWithMessageIdR2018a(&b_st, &l_emlrtRTEI,
        "Coder:toolbox:reshape_emptyReshapeLimit",
        "Coder:toolbox:reshape_emptyReshapeLimit", 0);
    }

    if (sqsz_idx_0 != c_a->size[0]) {
      emlrtErrorWithMessageIdR2018a(&b_st, &m_emlrtRTEI,
        "Coder:MATLAB:getReshapeDims_notSameNumel",
        "Coder:MATLAB:getReshapeDims_notSameNumel", 0);
    }

    e_a = *c_a;
    sqsz[0] = sqsz_idx_0;
    sqsz[1] = 1;
    e_a.size = &sqsz[0];
    e_a.numDimensions = 2;
    st.site = &ne_emlrtRSI;
    c_idx_1 = vectGra(&st, &e_a);
    st.site = &oe_emlrtRSI;
    b_st.site = &oe_emlrtRSI;
    e_sum(&b_st, bw, r1);
    b_st.site = &oe_emlrtRSI;
    f_sum(&b_st, r1, d_a);
    sqsz_idx_0 = 1;
    k = 3;
    if (d_a->size[2] == 1) {
      k = 2;
    }

    if ((k != 2) && (d_a->size[2] != 1)) {
      sqsz_idx_0 = d_a->size[2];
    }

    b_st.site = &xe_emlrtRSI;
    idx = d_a->size[2];
    c_st.site = &ye_emlrtRSI;
    d_st.site = &af_emlrtRSI;
    d_st.site = &af_emlrtRSI;
    a = 1;
    if (d_a->size[2] > 1) {
      a = d_a->size[2];
    }

    if (sqsz_idx_0 > muIntScalarMax_sint32(idx, a)) {
      emlrtErrorWithMessageIdR2018a(&b_st, &l_emlrtRTEI,
        "Coder:toolbox:reshape_emptyReshapeLimit",
        "Coder:toolbox:reshape_emptyReshapeLimit", 0);
    }

    if (sqsz_idx_0 != d_a->size[2]) {
      emlrtErrorWithMessageIdR2018a(&b_st, &m_emlrtRTEI,
        "Coder:MATLAB:getReshapeDims_notSameNumel",
        "Coder:MATLAB:getReshapeDims_notSameNumel", 0);
    }

    e_a = *d_a;
    b_sqsz[0] = sqsz_idx_0;
    b_sqsz[1] = 1;
    e_a.size = &b_sqsz[0];
    e_a.numDimensions = 2;
    st.site = &pe_emlrtRSI;
    c_idx_2 = vectGra(&st, &e_a);
    i1 = (int32_T)(n + 1U);
    if ((i1 < 1) || (i1 > s->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, s->size[0], &ed_emlrtBCI, sp);
    }

    s->data[n] = NUM;
    s->data[n + s->size[0]] = c_idx_1;
    s->data[n + s->size[0] * 2] = c_idx_2;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(&r1);
  emxFree_real_T(&r);
  emxFree_real_T(&d_a);
  emxFree_real_T(&c_a);
  emxFree_real_T(&m);
  emxFree_real_T(&num);
  emxFree_real_T(&b_a);
  emxFree_real_T(&bw);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (TS_Label2Centroid.c) */

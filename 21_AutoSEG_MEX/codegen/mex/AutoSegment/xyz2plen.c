/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * xyz2plen.c
 *
 * Code generation for function 'xyz2plen'
 *
 */

/* Include files */
#include "xyz2plen.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "mwmathutil.h"
#include "power.h"
#include "rt_nonfinite.h"
#include "sqrt.h"

/* Variable Definitions */
static emlrtRSInfo ln_emlrtRSI = { 3,  /* lineNo */
  "xyz2plen",                          /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/xyz2plen.m"/* pathName */
};

static emlrtRSInfo mn_emlrtRSI = { 4,  /* lineNo */
  "xyz2plen",                          /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/xyz2plen.m"/* pathName */
};

static emlrtRSInfo nn_emlrtRSI = { 97, /* lineNo */
  "nan_sum_or_mean",                   /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/stats/eml/private/nan_sum_or_mean.m"/* pathName */
};

static emlrtBCInfo gk_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  128,                                 /* lineNo */
  13,                                  /* colNo */
  "",                                  /* aName */
  "nan_sum_or_mean",                   /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/stats/eml/private/nan_sum_or_mean.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo hk_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  101,                                 /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "nan_sum_or_mean",                   /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/stats/eml/private/nan_sum_or_mean.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo tb_emlrtECI = { 2,  /* nDims */
  3,                                   /* lineNo */
  33,                                  /* colNo */
  "xyz2plen",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/xyz2plen.m"/* pName */
};

static emlrtBCInfo ik_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  100,                                 /* lineNo */
  25,                                  /* colNo */
  "",                                  /* aName */
  "nan_sum_or_mean",                   /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/stats/eml/private/nan_sum_or_mean.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo jk_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  113,                                 /* lineNo */
  29,                                  /* colNo */
  "",                                  /* aName */
  "nan_sum_or_mean",                   /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/stats/eml/private/nan_sum_or_mean.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo kk_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  114,                                 /* lineNo */
  29,                                  /* colNo */
  "",                                  /* aName */
  "nan_sum_or_mean",                   /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/stats/eml/private/nan_sum_or_mean.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo oj_emlrtRTEI = { 3,/* lineNo */
  42,                                  /* colNo */
  "xyz2plen",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/xyz2plen.m"/* pName */
};

static emlrtRTEInfo pj_emlrtRTEI = { 3,/* lineNo */
  33,                                  /* colNo */
  "xyz2plen",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/xyz2plen.m"/* pName */
};

static emlrtRTEInfo qj_emlrtRTEI = { 3,/* lineNo */
  28,                                  /* colNo */
  "xyz2plen",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/xyz2plen.m"/* pName */
};

static emlrtRTEInfo rj_emlrtRTEI = { 7,/* lineNo */
  5,                                   /* colNo */
  "nansum",                            /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/stats/eml/nansum.m"/* pName */
};

static emlrtRTEInfo sj_emlrtRTEI = { 7,/* lineNo */
  1,                                   /* colNo */
  "nansum",                            /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/stats/eml/nansum.m"/* pName */
};

static emlrtRTEInfo tj_emlrtRTEI = { 4,/* lineNo */
  15,                                  /* colNo */
  "xyz2plen",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/xyz2plen.m"/* pName */
};

static emlrtRTEInfo uj_emlrtRTEI = { 78,/* lineNo */
  1,                                   /* colNo */
  "diff",                              /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/diff.m"/* pName */
};

static emlrtRTEInfo vj_emlrtRTEI = { 3,/* lineNo */
  21,                                  /* colNo */
  "xyz2plen",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/xyz2plen.m"/* pName */
};

/* Function Definitions */
void xyz2plen(const emlrtStack *sp, const emxArray_real_T *xyz, const real_T
              Reso[3], emxArray_real_T *PieceLength)
{
  emxArray_real_T *x;
  int32_T iyLead;
  int32_T ntilerows;
  boolean_T overflow;
  int32_T iy;
  emxArray_real_T *b_y1;
  int32_T ibmat;
  int32_T ixLead;
  int32_T dimSize;
  emxArray_real_T *y;
  real_T work;
  int32_T m;
  real_T tmp2;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
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
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInit_real_T(sp, &x, 2, &pj_emlrtRTEI, true);

  /*  xyz position data caluculate to piece length */
  st.site = &ln_emlrtRSI;
  b_st.site = &uc_emlrtRSI;
  iyLead = x->size[0] * x->size[1];
  x->size[0] = xyz->size[0];
  x->size[1] = 3;
  emxEnsureCapacity_real_T(&st, x, iyLead, &oj_emlrtRTEI);
  ntilerows = xyz->size[0];
  overflow = ((1 <= xyz->size[0]) && (xyz->size[0] > 2147483646));
  for (iy = 0; iy < 3; iy++) {
    ibmat = iy * ntilerows;
    b_st.site = &xf_emlrtRSI;
    if (overflow) {
      c_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&c_st);
    }

    for (ixLead = 0; ixLead < ntilerows; ixLead++) {
      x->data[ibmat + ixLead] = Reso[iy];
    }
  }

  emxInit_real_T(&st, &b_y1, 2, &uj_emlrtRTEI, true);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])xyz->size, *(int32_T (*)[2])x->size,
    &tb_emlrtECI, sp);
  st.site = &ln_emlrtRSI;
  ntilerows = xyz->size[0] * xyz->size[1];
  iyLead = x->size[0] * x->size[1];
  x->size[0] = xyz->size[0];
  x->size[1] = 3;
  emxEnsureCapacity_real_T(&st, x, iyLead, &pj_emlrtRTEI);
  for (iyLead = 0; iyLead < ntilerows; iyLead++) {
    x->data[iyLead] *= xyz->data[iyLead] - 1.0;
  }

  dimSize = x->size[0];
  iyLead = b_y1->size[0] * b_y1->size[1];
  b_y1->size[0] = x->size[0] - 1;
  b_y1->size[1] = 3;
  emxEnsureCapacity_real_T(&st, b_y1, iyLead, &qj_emlrtRTEI);
  ntilerows = 1;
  ibmat = 0;
  overflow = ((2 <= x->size[0]) && (x->size[0] > 2147483646));
  for (iy = 0; iy < 3; iy++) {
    ixLead = ntilerows;
    iyLead = ibmat;
    work = x->data[ntilerows - 1];
    b_st.site = &yh_emlrtRSI;
    if (overflow) {
      c_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&c_st);
    }

    for (m = 2; m <= dimSize; m++) {
      tmp2 = work;
      work = x->data[ixLead];
      b_y1->data[iyLead] = x->data[ixLead] - tmp2;
      ixLead++;
      iyLead++;
    }

    ntilerows += dimSize;
    ibmat = (ibmat + dimSize) - 1;
  }

  emxInit_real_T(&st, &y, 1, &vj_emlrtRTEI, true);
  st.site = &ln_emlrtRSI;
  b_st.site = &ln_emlrtRSI;
  power(&b_st, b_y1, x);
  b_st.site = &ag_emlrtRSI;
  iyLead = y->size[0];
  y->size[0] = x->size[0];
  emxEnsureCapacity_real_T(&b_st, y, iyLead, &rj_emlrtRTEI);
  emxFree_real_T(&b_y1);
  if (x->size[0] == 0) {
    ntilerows = x->size[0];
    iyLead = y->size[0];
    y->size[0] = x->size[0];
    emxEnsureCapacity_real_T(&b_st, y, iyLead, &sj_emlrtRTEI);
    for (iyLead = 0; iyLead < ntilerows; iyLead++) {
      y->data[iyLead] = 0.0;
    }
  } else {
    ntilerows = x->size[0];
    iy = 0;
    ibmat = 0;
    c_st.site = &nn_emlrtRSI;
    if (x->size[0] > 2147483646) {
      d_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&d_st);
    }

    for (m = 0; m < ntilerows; m++) {
      ibmat++;
      iyLead = x->size[0] * 3;
      if ((ibmat < 1) || (ibmat > iyLead)) {
        emlrtDynamicBoundsCheckR2012b(ibmat, 1, iyLead, &ik_emlrtBCI, &b_st);
      }

      if (!muDoubleScalarIsNaN(x->data[ibmat - 1])) {
        iyLead = x->size[0] * 3;
        if (ibmat > iyLead) {
          emlrtDynamicBoundsCheckR2012b(ibmat, 1, iyLead, &hk_emlrtBCI, &b_st);
        }

        work = x->data[ibmat - 1];
      } else {
        work = 0.0;
      }

      ixLead = ibmat + ntilerows;
      iyLead = x->size[0] * 3;
      if ((ixLead < 1) || (ixLead > iyLead)) {
        emlrtDynamicBoundsCheckR2012b(ixLead, 1, iyLead, &jk_emlrtBCI, &b_st);
      }

      if (!muDoubleScalarIsNaN(x->data[ixLead - 1])) {
        iyLead = x->size[0] * 3;
        if (ixLead > iyLead) {
          emlrtDynamicBoundsCheckR2012b(ixLead, 1, iyLead, &kk_emlrtBCI, &b_st);
        }

        work += x->data[ixLead - 1];
      }

      ixLead += ntilerows;
      iyLead = x->size[0] * 3;
      if ((ixLead < 1) || (ixLead > iyLead)) {
        emlrtDynamicBoundsCheckR2012b(ixLead, 1, iyLead, &jk_emlrtBCI, &b_st);
      }

      if (!muDoubleScalarIsNaN(x->data[ixLead - 1])) {
        iyLead = x->size[0] * 3;
        if (ixLead > iyLead) {
          emlrtDynamicBoundsCheckR2012b(ixLead, 1, iyLead, &kk_emlrtBCI, &b_st);
        }

        work += x->data[ixLead - 1];
      }

      iy++;
      if ((iy < 1) || (iy > y->size[0])) {
        emlrtDynamicBoundsCheckR2012b(iy, 1, y->size[0], &gk_emlrtBCI, &b_st);
      }

      y->data[iy - 1] = work;
    }
  }

  emxFree_real_T(&x);
  st.site = &ln_emlrtRSI;
  b_sqrt(&st, y);
  st.site = &mn_emlrtRSI;
  iyLead = PieceLength->size[0];
  PieceLength->size[0] = y->size[0] + 1;
  emxEnsureCapacity_real_T(&st, PieceLength, iyLead, &tj_emlrtRTEI);
  b_st.site = &in_emlrtRSI;
  c_st.site = &jn_emlrtRSI;
  ntilerows = 0;
  PieceLength->data[0] = 0.0;
  iy = y->size[0];
  d_st.site = &kn_emlrtRSI;
  if ((1 <= y->size[0]) && (y->size[0] > 2147483646)) {
    e_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&e_st);
  }

  for (m = 0; m < iy; m++) {
    ntilerows++;
    PieceLength->data[ntilerows] = y->data[m];
  }

  emxFree_real_T(&y);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (xyz2plen.c) */

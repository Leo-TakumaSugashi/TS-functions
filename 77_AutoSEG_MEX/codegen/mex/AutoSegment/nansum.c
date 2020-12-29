/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * nansum.c
 *
 * Code generation for function 'nansum'
 *
 */

/* Include files */
#include "nansum.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "eml_int_forloop_overflow_check.h"
#include "mwmathutil.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo on_emlrtRSI = { 74, /* lineNo */
  "nan_sum_or_mean",                   /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/stats/eml/private/nan_sum_or_mean.m"/* pathName */
};

static emlrtBCInfo ld_emlrtBCI = { 1,  /* iFirst */
  6141,                                /* iLast */
  100,                                 /* lineNo */
  25,                                  /* colNo */
  "",                                  /* aName */
  "nan_sum_or_mean",                   /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/stats/eml/private/nan_sum_or_mean.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo md_emlrtBCI = { 1,  /* iFirst */
  2047,                                /* iLast */
  128,                                 /* lineNo */
  15,                                  /* colNo */
  "",                                  /* aName */
  "nan_sum_or_mean",                   /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/stats/eml/private/nan_sum_or_mean.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo nd_emlrtBCI = { 1,  /* iFirst */
  6141,                                /* iLast */
  113,                                 /* lineNo */
  29,                                  /* colNo */
  "",                                  /* aName */
  "nan_sum_or_mean",                   /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/stats/eml/private/nan_sum_or_mean.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo lk_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  75,                                  /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "nan_sum_or_mean",                   /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/stats/eml/private/nan_sum_or_mean.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo mk_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  76,                                  /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "nan_sum_or_mean",                   /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/stats/eml/private/nan_sum_or_mean.m",/* pName */
  0                                    /* checkKind */
};

/* Function Definitions */
real_T b_nansum(const real_T varargin_1[2047])
{
  real_T y;
  int32_T k;
  y = 0.0;
  for (k = 0; k < 2047; k++) {
    if (!muDoubleScalarIsNaN(varargin_1[k])) {
      y += varargin_1[k];
    }
  }

  return y;
}

real_T c_nansum(const emlrtStack *sp, const emxArray_real_T *varargin_1)
{
  real_T y;
  int32_T vlen;
  int32_T k;
  int32_T i;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &ag_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  vlen = varargin_1->size[0];
  y = 0.0;
  b_st.site = &on_emlrtRSI;
  if ((1 <= varargin_1->size[0]) && (varargin_1->size[0] > 2147483646)) {
    c_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&c_st);
  }

  for (k = 0; k < vlen; k++) {
    i = k + 1;
    if ((i < 1) || (i > varargin_1->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i, 1, varargin_1->size[0], &lk_emlrtBCI, &st);
    }

    if (!muDoubleScalarIsNaN(varargin_1->data[k])) {
      i = k + 1;
      if ((i < 1) || (i > varargin_1->size[0])) {
        emlrtDynamicBoundsCheckR2012b(i, 1, varargin_1->size[0], &mk_emlrtBCI,
          &st);
      }

      y += varargin_1->data[i - 1];
    }
  }

  return y;
}

void nansum(const emlrtStack *sp, const real_T varargin_1[6141], real_T y[2047])
{
  int32_T iy;
  int32_T ixstart;
  int32_T j;
  int32_T i;
  real_T s;
  int32_T ix;
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &ag_emlrtRSI;
  iy = 0;
  ixstart = -1;
  for (j = 0; j < 2047; j++) {
    ixstart++;
    i = ixstart + 1;
    if ((i < 1) || (i > 6141)) {
      emlrtDynamicBoundsCheckR2012b(i, 1, 6141, &ld_emlrtBCI, &st);
    }

    if (!muDoubleScalarIsNaN(varargin_1[ixstart])) {
      s = varargin_1[ixstart];
    } else {
      s = 0.0;
    }

    ix = ixstart + 2047;
    i = ix + 1;
    if ((i < 1) || (i > 6141)) {
      emlrtDynamicBoundsCheckR2012b(i, 1, 6141, &nd_emlrtBCI, &st);
    }

    if (!muDoubleScalarIsNaN(varargin_1[ix])) {
      s += varargin_1[ix];
    }

    ix += 2047;
    i = ix + 1;
    if ((i < 1) || (i > 6141)) {
      emlrtDynamicBoundsCheckR2012b(i, 1, 6141, &nd_emlrtBCI, &st);
    }

    if (!muDoubleScalarIsNaN(varargin_1[ix])) {
      s += varargin_1[ix];
    }

    iy++;
    if (iy > 2047) {
      emlrtDynamicBoundsCheckR2012b(2048, 1, 2047, &md_emlrtBCI, &st);
    }

    y[iy - 1] = s;
  }
}

/* End of code generation (nansum.c) */

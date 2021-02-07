/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * TS_skel2endpoint.c
 *
 * Code generation for function 'TS_skel2endpoint'
 *
 */

/* Include files */
#include "TS_skel2endpoint.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "AutoSegment_mexutil.h"
#include "TS_Skeleton3D_oldest.h"
#include "TS_bwlabeln3D26.h"
#include "eml_int_forloop_overflow_check.h"
#include "imfilter.h"
#include "indexShapeCheck.h"
#include "libmwimfilter.h"
#include "padarray.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo jc_emlrtRSI = { 6,  /* lineNo */
  "TS_skel2endpoint",                  /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m"/* pathName */
};

static emlrtRSInfo kc_emlrtRSI = { 9,  /* lineNo */
  "TS_skel2endpoint",                  /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m"/* pathName */
};

static emlrtRSInfo lc_emlrtRSI = { 10, /* lineNo */
  "TS_skel2endpoint",                  /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m"/* pathName */
};

static emlrtRSInfo mc_emlrtRSI = { 14, /* lineNo */
  "TS_skel2endpoint",                  /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m"/* pathName */
};

static emlrtBCInfo cc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  18,                                  /* lineNo */
  9,                                   /* colNo */
  "z",                                 /* aName */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo dc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  18,                                  /* lineNo */
  9,                                   /* colNo */
  "A",                                 /* aName */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ec_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  18,                                  /* lineNo */
  9,                                   /* colNo */
  "x",                                 /* aName */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo fc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  18,                                  /* lineNo */
  9,                                   /* colNo */
  "y",                                 /* aName */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo m_emlrtECI = { 3,   /* nDims */
  7,                                   /* lineNo */
  14,                                  /* colNo */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m"/* pName */
};

static emlrtECInfo n_emlrtECI = { 3,   /* nDims */
  7,                                   /* lineNo */
  9,                                   /* colNo */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m"/* pName */
};

static emlrtBCInfo gc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  12,                                  /* lineNo */
  20,                                  /* colNo */
  "y",                                 /* aName */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo hc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  12,                                  /* lineNo */
  25,                                  /* colNo */
  "y",                                 /* aName */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ic_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  12,                                  /* lineNo */
  32,                                  /* colNo */
  "x",                                 /* aName */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo jc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  12,                                  /* lineNo */
  37,                                  /* colNo */
  "x",                                 /* aName */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo kc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  12,                                  /* lineNo */
  44,                                  /* colNo */
  "z",                                 /* aName */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo lc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  12,                                  /* lineNo */
  49,                                  /* colNo */
  "z",                                 /* aName */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo mc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  12,                                  /* lineNo */
  18,                                  /* colNo */
  "cropbw",                            /* aName */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo nc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  12,                                  /* lineNo */
  30,                                  /* colNo */
  "cropbw",                            /* aName */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo oc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  12,                                  /* lineNo */
  42,                                  /* colNo */
  "cropbw",                            /* aName */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo md_emlrtRTEI = { 3,/* lineNo */
  1,                                   /* colNo */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m"/* pName */
};

static emlrtRTEInfo od_emlrtRTEI = { 6,/* lineNo */
  20,                                  /* colNo */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m"/* pName */
};

static emlrtRTEInfo qd_emlrtRTEI = { 7,/* lineNo */
  18,                                  /* colNo */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m"/* pName */
};

static emlrtRTEInfo sd_emlrtRTEI = { 6,/* lineNo */
  5,                                   /* colNo */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m"/* pName */
};

static emlrtRTEInfo td_emlrtRTEI = { 10,/* lineNo */
  1,                                   /* colNo */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m"/* pName */
};

static emlrtRTEInfo ud_emlrtRTEI = { 1,/* lineNo */
  14,                                  /* colNo */
  "TS_skel2endpoint",                  /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skel2endpoint.m"/* pName */
};

/* Function Definitions */
void TS_skel2endpoint(const emlrtStack *sp, const emxArray_boolean_T *bw,
                      emxArray_boolean_T *A)
{
  int32_T i;
  int32_T nx;
  int32_T idx;
  int32_T b_i;
  int32_T loop_ub;
  emxArray_uint8_T *fbw;
  emxArray_boolean_T *cropbw;
  emxArray_uint8_T *a;
  int32_T n;
  emxArray_int32_T *ii;
  real_T se[27];
  boolean_T exitg1;
  real_T outSizeT[3];
  real_T startT[3];
  int32_T iv[2];
  int8_T tmp_data[27];
  int32_T k;
  real_T nonzero_h_data[27];
  boolean_T ROI[27];
  emxArray_int32_T *vk;
  emxArray_int32_T *varargout_6;
  real_T padSizeT[3];
  real_T connDimsT[3];
  boolean_T maxval;
  int32_T i1;
  real_T NUM;
  int32_T ROI_tmp;
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
  i = bw->size[0];
  nx = A->size[0] * A->size[1] * A->size[2];
  A->size[0] = i;
  idx = bw->size[1];
  A->size[1] = idx;
  b_i = bw->size[2];
  A->size[2] = b_i;
  emxEnsureCapacity_boolean_T(sp, A, nx, &md_emlrtRTEI);
  loop_ub = i * idx * b_i;
  for (i = 0; i < loop_ub; i++) {
    A->data[i] = false;
  }

  loop_ub = bw->size[0] * bw->size[1] * bw->size[2];
  emxInit_uint8_T(sp, &fbw, 3, &sd_emlrtRTEI, true);
  emxInit_boolean_T(sp, &cropbw, 3, &td_emlrtRTEI, true);
  emxInit_uint8_T(sp, &a, 3, &vd_emlrtRTEI, true);
  for (n = 0; n < 6; n++) {
    /*  for End point */
    for (i = 0; i < 27; i++) {
      se[i] = 1.0;
    }

    switch (n + 1) {
     case 1:
      for (i = 0; i < 3; i++) {
        se[9 * i + 6] = 0.0;
        se[9 * i + 7] = 0.0;
        se[9 * i + 8] = 0.0;
      }

      /*  Left Plane */
      break;

     case 2:
      for (i = 0; i < 3; i++) {
        se[9 * i] = 0.0;
        se[9 * i + 1] = 0.0;
        se[9 * i + 2] = 0.0;
      }

      /*  Right Plane */
      break;

     case 3:
      for (i = 0; i < 3; i++) {
        se[9 * i + 2] = 0.0;
        se[9 * i + 5] = 0.0;
        se[9 * i + 8] = 0.0;
      }

      /*  Top Plane */
      break;

     case 4:
      for (i = 0; i < 3; i++) {
        se[9 * i] = 0.0;
        se[9 * i + 3] = 0.0;
        se[9 * i + 6] = 0.0;
      }

      /*  Bottom Plane */
      break;

     case 5:
      for (i = 0; i < 3; i++) {
        se[3 * i + 18] = 0.0;
        se[3 * i + 19] = 0.0;
        se[3 * i + 20] = 0.0;
      }

      /*  Surface Plane */
      break;

     default:
      for (i = 0; i < 3; i++) {
        se[3 * i] = 0.0;
        se[3 * i + 1] = 0.0;
        se[3 * i + 2] = 0.0;
      }

      /*  Deep Plane */
      break;
    }

    st.site = &jc_emlrtRSI;
    i = fbw->size[0] * fbw->size[1] * fbw->size[2];
    fbw->size[0] = bw->size[0];
    fbw->size[1] = bw->size[1];
    fbw->size[2] = bw->size[2];
    emxEnsureCapacity_uint8_T(&st, fbw, i, &od_emlrtRTEI);
    for (i = 0; i < loop_ub; i++) {
      fbw->data[i] = bw->data[i];
    }

    outSizeT[0] = fbw->size[0];
    startT[0] = 1.0;
    outSizeT[1] = fbw->size[1];
    startT[1] = 1.0;
    outSizeT[2] = fbw->size[2];
    startT[2] = 1.0;
    if ((fbw->size[0] != 0) && (fbw->size[1] != 0) && (fbw->size[2] != 0)) {
      b_st.site = &nc_emlrtRSI;
      padImage(&b_st, fbw, startT, a);
      b_st.site = &oc_emlrtRSI;
      idx = 0;
      for (b_i = 0; b_i < 27; b_i++) {
        if (se[b_i] != 0.0) {
          idx++;
        }
      }

      nx = 0;
      for (b_i = 0; b_i < 27; b_i++) {
        if (se[b_i] != 0.0) {
          tmp_data[nx] = (int8_T)(b_i + 1);
          nx++;
        }
      }

      c_st.site = &yc_emlrtRSI;
      for (i = 0; i < idx; i++) {
        nonzero_h_data[i] = se[tmp_data[i] - 1];
      }

      for (i = 0; i < 27; i++) {
        ROI[i] = (se[i] != 0.0);
      }

      d_st.site = &ad_emlrtRSI;
      i = fbw->size[0] * fbw->size[1] * fbw->size[2];
      fbw->size[0] = (int32_T)outSizeT[0];
      fbw->size[1] = (int32_T)outSizeT[1];
      fbw->size[2] = (int32_T)outSizeT[2];
      emxEnsureCapacity_uint8_T(&d_st, fbw, i, &rd_emlrtRTEI);
      k = 3;
      if (a->size[2] == 1) {
        k = 2;
      }

      padSizeT[0] = a->size[0];
      connDimsT[0] = 3.0;
      padSizeT[1] = a->size[1];
      connDimsT[1] = 3.0;
      padSizeT[2] = a->size[2];
      connDimsT[2] = 3.0;
      imfilter_uint8(&a->data[0], &fbw->data[0], 3.0, outSizeT, (real_T)k,
                     padSizeT, &nonzero_h_data[0], (real_T)idx, ROI, 3.0,
                     connDimsT, startT, 3.0, true, false);
    }

    i = cropbw->size[0] * cropbw->size[1] * cropbw->size[2];
    cropbw->size[0] = fbw->size[0];
    cropbw->size[1] = fbw->size[1];
    cropbw->size[2] = fbw->size[2];
    emxEnsureCapacity_boolean_T(sp, cropbw, i, &qd_emlrtRTEI);
    b_i = fbw->size[0] * fbw->size[1] * fbw->size[2];
    for (i = 0; i < b_i; i++) {
      cropbw->data[i] = (fbw->data[i] == 1);
    }

    emlrtSizeEqCheckNDR2012b(*(int32_T (*)[3])cropbw->size, *(int32_T (*)[3])
      bw->size, &m_emlrtECI, sp);
    b_i = cropbw->size[0] * cropbw->size[1] * cropbw->size[2];
    for (i = 0; i < b_i; i++) {
      cropbw->data[i] = (cropbw->data[i] && bw->data[i]);
    }

    emlrtSizeEqCheckNDR2012b(*(int32_T (*)[3])A->size, *(int32_T (*)[3])
      cropbw->size, &n_emlrtECI, sp);
    b_i = A->size[0] * A->size[1] * A->size[2];
    for (i = 0; i < b_i; i++) {
      A->data[i] = (A->data[i] || cropbw->data[i]);
    }

    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_uint8_T(&a);
  emxFree_uint8_T(&fbw);
  emxInit_int32_T(sp, &ii, 1, &oc_emlrtRTEI, true);
  st.site = &kc_emlrtRSI;
  b_st.site = &cd_emlrtRSI;
  nx = A->size[0] * A->size[1] * A->size[2];
  c_st.site = &dd_emlrtRSI;
  idx = 0;
  i = ii->size[0];
  ii->size[0] = A->size[0] * A->size[1] * A->size[2];
  emxEnsureCapacity_int32_T(&c_st, ii, i, &nd_emlrtRTEI);
  d_st.site = &ed_emlrtRSI;
  if ((1 <= A->size[0] * A->size[1] * A->size[2]) && (A->size[0] * A->size[1] *
       A->size[2] > 2147483646)) {
    e_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&e_st);
  }

  b_i = 0;
  exitg1 = false;
  while ((!exitg1) && (b_i <= nx - 1)) {
    if (A->data[b_i]) {
      idx++;
      ii->data[idx - 1] = b_i + 1;
      if (idx >= nx) {
        exitg1 = true;
      } else {
        b_i++;
      }
    } else {
      b_i++;
    }
  }

  if (idx > A->size[0] * A->size[1] * A->size[2]) {
    emlrtErrorWithMessageIdR2018a(&c_st, &h_emlrtRTEI,
      "Coder:builtins:AssertionFailed", "Coder:builtins:AssertionFailed", 0);
  }

  if (A->size[0] * A->size[1] * A->size[2] == 1) {
    if (idx == 0) {
      ii->size[0] = 0;
    }
  } else {
    if (1 > idx) {
      i = 0;
    } else {
      i = idx;
    }

    iv[0] = 1;
    iv[1] = i;
    d_st.site = &fd_emlrtRSI;
    indexShapeCheck(&d_st, ii->size[0], iv);
    nx = ii->size[0];
    ii->size[0] = i;
    emxEnsureCapacity_int32_T(&c_st, ii, nx, &pd_emlrtRTEI);
  }

  st.site = &kc_emlrtRSI;
  b_st.site = &hd_emlrtRSI;
  nx = bw->size[0];
  idx = bw->size[1] * nx;
  b_i = idx * bw->size[2];
  k = 0;
  exitg1 = false;
  while ((!exitg1) && (k <= ii->size[0] - 1)) {
    if (ii->data[k] <= b_i) {
      k++;
    } else {
      emlrtErrorWithMessageIdR2018a(&b_st, &g_emlrtRTEI,
        "Coder:MATLAB:ind2sub_IndexOutOfRange",
        "Coder:MATLAB:ind2sub_IndexOutOfRange", 0);
    }
  }

  loop_ub = ii->size[0];
  for (i = 0; i < loop_ub; i++) {
    ii->data[i]--;
  }

  emxInit_int32_T(&b_st, &vk, 1, &wc_emlrtRTEI, true);
  i = vk->size[0];
  vk->size[0] = ii->size[0];
  emxEnsureCapacity_int32_T(&b_st, vk, i, &wc_emlrtRTEI);
  loop_ub = ii->size[0];
  for (i = 0; i < loop_ub; i++) {
    c_st.site = &un_emlrtRSI;
    vk->data[i] = div_s32(&c_st, ii->data[i], idx);
  }

  emxInit_int32_T(&b_st, &varargout_6, 1, &ud_emlrtRTEI, true);
  i = varargout_6->size[0];
  varargout_6->size[0] = vk->size[0];
  emxEnsureCapacity_int32_T(&b_st, varargout_6, i, &xc_emlrtRTEI);
  loop_ub = vk->size[0];
  for (i = 0; i < loop_ub; i++) {
    varargout_6->data[i] = vk->data[i] + 1;
  }

  loop_ub = ii->size[0];
  for (i = 0; i < loop_ub; i++) {
    ii->data[i] -= vk->data[i] * idx;
  }

  i = vk->size[0];
  vk->size[0] = ii->size[0];
  emxEnsureCapacity_int32_T(&b_st, vk, i, &wc_emlrtRTEI);
  loop_ub = ii->size[0];
  for (i = 0; i < loop_ub; i++) {
    c_st.site = &un_emlrtRSI;
    vk->data[i] = div_s32(&c_st, ii->data[i], nx);
  }

  loop_ub = ii->size[0];
  for (i = 0; i < loop_ub; i++) {
    ii->data[i] -= vk->data[i] * nx;
  }

  loop_ub = ii->size[0];
  for (i = 0; i < loop_ub; i++) {
    ii->data[i]++;
  }

  loop_ub = vk->size[0];
  for (i = 0; i < loop_ub; i++) {
    vk->data[i]++;
  }

  st.site = &lc_emlrtRSI;
  padarray(&st, bw, cropbw);
  i = ii->size[0];
  for (n = 0; n < i; n++) {
    nx = n + 1;
    if ((nx < 1) || (nx > ii->size[0])) {
      emlrtDynamicBoundsCheckR2012b(nx, 1, ii->size[0], &gc_emlrtBCI, sp);
    }

    nx = n + 1;
    if ((nx < 1) || (nx > ii->size[0])) {
      emlrtDynamicBoundsCheckR2012b(nx, 1, ii->size[0], &hc_emlrtBCI, sp);
    }

    nx = n + 1;
    if ((nx < 1) || (nx > vk->size[0])) {
      emlrtDynamicBoundsCheckR2012b(nx, 1, vk->size[0], &ic_emlrtBCI, sp);
    }

    nx = n + 1;
    if ((nx < 1) || (nx > vk->size[0])) {
      emlrtDynamicBoundsCheckR2012b(nx, 1, vk->size[0], &jc_emlrtBCI, sp);
    }

    nx = n + 1;
    if ((nx < 1) || (nx > varargout_6->size[0])) {
      emlrtDynamicBoundsCheckR2012b(nx, 1, varargout_6->size[0], &kc_emlrtBCI,
        sp);
    }

    nx = n + 1;
    if ((nx < 1) || (nx > varargout_6->size[0])) {
      emlrtDynamicBoundsCheckR2012b(nx, 1, varargout_6->size[0], &lc_emlrtBCI,
        sp);
    }

    nx = ii->data[n] + 1;
    idx = ii->data[n] + 2;
    for (b_i = 0; b_i < 3; b_i++) {
      k = varargout_6->data[n] + b_i;
      for (loop_ub = 0; loop_ub < 3; loop_ub++) {
        if ((ii->data[n] < 1) || (ii->data[n] > cropbw->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[n], 1, cropbw->size[0],
            &mc_emlrtBCI, sp);
        }

        i1 = vk->data[n] + loop_ub;
        if ((i1 < 1) || (i1 > cropbw->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, cropbw->size[1], &nc_emlrtBCI, sp);
        }

        if ((k < 1) || (k > cropbw->size[2])) {
          emlrtDynamicBoundsCheckR2012b(k, 1, cropbw->size[2], &oc_emlrtBCI, sp);
        }

        ROI_tmp = 3 * loop_ub + 9 * b_i;
        ROI[ROI_tmp] = cropbw->data[((ii->data[n] + cropbw->size[0] * (i1 - 1))
          + cropbw->size[0] * cropbw->size[1] * (k - 1)) - 1];
        if ((nx < 1) || (nx > cropbw->size[0])) {
          emlrtDynamicBoundsCheckR2012b(nx, 1, cropbw->size[0], &mc_emlrtBCI, sp);
        }

        if (i1 > cropbw->size[1]) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, cropbw->size[1], &nc_emlrtBCI, sp);
        }

        if (k > cropbw->size[2]) {
          emlrtDynamicBoundsCheckR2012b(k, 1, cropbw->size[2], &oc_emlrtBCI, sp);
        }

        ROI[ROI_tmp + 1] = cropbw->data[((nx + cropbw->size[0] * (i1 - 1)) +
          cropbw->size[0] * cropbw->size[1] * (k - 1)) - 1];
        if ((idx < 1) || (idx > cropbw->size[0])) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, cropbw->size[0], &mc_emlrtBCI,
            sp);
        }

        if (i1 > cropbw->size[1]) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, cropbw->size[1], &nc_emlrtBCI, sp);
        }

        if (k > cropbw->size[2]) {
          emlrtDynamicBoundsCheckR2012b(k, 1, cropbw->size[2], &oc_emlrtBCI, sp);
        }

        ROI[ROI_tmp + 2] = cropbw->data[((idx + cropbw->size[0] * (i1 - 1)) +
          cropbw->size[0] * cropbw->size[1] * (k - 1)) - 1];
      }
    }

    ROI[13] = false;
    st.site = &mc_emlrtRSI;
    maxval = cropbw->data[((ii->data[n] + cropbw->size[0] * (vk->data[n] - 1)) +
      cropbw->size[0] * cropbw->size[1] * (varargout_6->data[n] - 1)) - 1];
    for (k = 0; k < 26; k++) {
      maxval = (((int32_T)maxval < (int32_T)ROI[k + 1]) || maxval);
    }

    if (!maxval) {
      NUM = 0.0;
    } else {
      b_st.site = &id_emlrtRSI;
      TS_bwlabeln_linux_c(&b_st, ROI, se, &NUM);
    }

    /*      s = bwconncomp(ROI,26); */
    /*      NUM = s.NumObjects; */
    if (NUM > 1.0) {
      nx = n + 1;
      if ((nx < 1) || (nx > varargout_6->size[0])) {
        emlrtDynamicBoundsCheckR2012b(nx, 1, varargout_6->size[0], &cc_emlrtBCI,
          sp);
      }

      idx = varargout_6->data[nx - 1];
      if ((idx < 1) || (idx > A->size[2])) {
        emlrtDynamicBoundsCheckR2012b(varargout_6->data[nx - 1], 1, A->size[2],
          &dc_emlrtBCI, sp);
      }

      nx = n + 1;
      if ((nx < 1) || (nx > vk->size[0])) {
        emlrtDynamicBoundsCheckR2012b(nx, 1, vk->size[0], &ec_emlrtBCI, sp);
      }

      b_i = vk->data[nx - 1];
      if ((b_i < 1) || (b_i > A->size[1])) {
        emlrtDynamicBoundsCheckR2012b(vk->data[nx - 1], 1, A->size[1],
          &dc_emlrtBCI, sp);
      }

      nx = n + 1;
      if ((nx < 1) || (nx > ii->size[0])) {
        emlrtDynamicBoundsCheckR2012b(nx, 1, ii->size[0], &fc_emlrtBCI, sp);
      }

      k = ii->data[nx - 1];
      if ((k < 1) || (k > A->size[0])) {
        emlrtDynamicBoundsCheckR2012b(ii->data[nx - 1], 1, A->size[0],
          &dc_emlrtBCI, sp);
      }

      A->data[((k + A->size[0] * (b_i - 1)) + A->size[0] * A->size[1] * (idx - 1))
        - 1] = false;
    }

    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_int32_T(&vk);
  emxFree_int32_T(&varargout_6);
  emxFree_int32_T(&ii);
  emxFree_boolean_T(&cropbw);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (TS_skel2endpoint.c) */

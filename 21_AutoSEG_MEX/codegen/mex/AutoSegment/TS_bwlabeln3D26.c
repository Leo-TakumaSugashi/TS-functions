/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * TS_bwlabeln3D26.c
 *
 * Code generation for function 'TS_bwlabeln3D26'
 *
 */

/* Include files */
#include "TS_bwlabeln3D26.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "AutoSegment_mexutil.h"
#include "TS_Skeleton3D_oldest.h"
#include "cat.h"
#include "eml_int_forloop_overflow_check.h"
#include "ind2sub.h"
#include "indexShapeCheck.h"
#include "mwmathutil.h"
#include "padarray.h"
#include "rt_nonfinite.h"
#include <string.h>

/* Variable Definitions */
static emlrtRSInfo jd_emlrtRSI = { 28, /* lineNo */
  "TS_bwlabeln_linux_c",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pathName */
};

static emlrtRSInfo kd_emlrtRSI = { 24, /* lineNo */
  "TS_bwlabeln_linux_c",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pathName */
};

static emlrtRSInfo ld_emlrtRSI = { 22, /* lineNo */
  "TS_bwlabeln_linux_c",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pathName */
};

static emlrtRSInfo md_emlrtRSI = { 19, /* lineNo */
  "TS_bwlabeln_linux_c",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pathName */
};

static emlrtRSInfo nd_emlrtRSI = { 44, /* lineNo */
  "Labeling",                          /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pathName */
};

static emlrtRSInfo od_emlrtRSI = { 47, /* lineNo */
  "Labeling",                          /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pathName */
};

static emlrtRSInfo pd_emlrtRSI = { 55, /* lineNo */
  "Labeling",                          /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pathName */
};

static emlrtRSInfo he_emlrtRSI = { 3,  /* lineNo */
  "TS_bwlabeln3D26",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pathName */
};

static emlrtRSInfo ie_emlrtRSI = { 13, /* lineNo */
  "TS_bwlabeln_linux_c",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pathName */
};

static emlrtMCInfo emlrtMCI = { 58,    /* lineNo */
  9,                                   /* colNo */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pName */
};

static emlrtBCInfo xc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  30,                                  /* lineNo */
  29,                                  /* colNo */
  "L",                                 /* aName */
  "TS_bwlabeln_linux_c",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo yc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  30,                                  /* lineNo */
  21,                                  /* colNo */
  "L",                                 /* aName */
  "TS_bwlabeln_linux_c",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ad_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  30,                                  /* lineNo */
  13,                                  /* colNo */
  "L",                                 /* aName */
  "TS_bwlabeln_linux_c",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo nk_emlrtBCI = { 1,  /* iFirst */
  5,                                   /* iLast */
  41,                                  /* lineNo */
  5,                                   /* colNo */
  "bw",                                /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo ok_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  55,                                  /* lineNo */
  41,                                  /* colNo */
  "y1",                                /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo pk_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  55,                                  /* lineNo */
  47,                                  /* colNo */
  "x1",                                /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo qk_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  55,                                  /* lineNo */
  53,                                  /* colNo */
  "z1",                                /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo rk_emlrtBCI = { 1,  /* iFirst */
  5,                                   /* iLast */
  37,                                  /* lineNo */
  17,                                  /* colNo */
  "bw",                                /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo sk_emlrtBCI = { 1,  /* iFirst */
  5,                                   /* iLast */
  37,                                  /* lineNo */
  25,                                  /* colNo */
  "bw",                                /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo tk_emlrtBCI = { 1,  /* iFirst */
  5,                                   /* iLast */
  37,                                  /* lineNo */
  33,                                  /* colNo */
  "bw",                                /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo uk_emlrtBCI = { 1,  /* iFirst */
  5,                                   /* iLast */
  38,                                  /* lineNo */
  15,                                  /* colNo */
  "L",                                 /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo vk_emlrtBCI = { 1,  /* iFirst */
  5,                                   /* iLast */
  38,                                  /* lineNo */
  23,                                  /* colNo */
  "L",                                 /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo wk_emlrtBCI = { 1,  /* iFirst */
  5,                                   /* iLast */
  38,                                  /* lineNo */
  31,                                  /* colNo */
  "L",                                 /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo xk_emlrtBCI = { 1,  /* iFirst */
  5,                                   /* iLast */
  40,                                  /* lineNo */
  5,                                   /* colNo */
  "L",                                 /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo yk_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  41,                                  /* lineNo */
  5,                                   /* colNo */
  "bw",                                /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo al_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  37,                                  /* lineNo */
  17,                                  /* colNo */
  "bw",                                /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo bl_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  37,                                  /* lineNo */
  25,                                  /* colNo */
  "bw",                                /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo cl_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  37,                                  /* lineNo */
  33,                                  /* colNo */
  "bw",                                /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo dl_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  38,                                  /* lineNo */
  15,                                  /* colNo */
  "L",                                 /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo el_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  38,                                  /* lineNo */
  23,                                  /* colNo */
  "L",                                 /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo fl_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  38,                                  /* lineNo */
  31,                                  /* colNo */
  "L",                                 /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo gl_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  40,                                  /* lineNo */
  5,                                   /* colNo */
  "L",                                 /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo hl_emlrtBCI = { 1,  /* iFirst */
  7,                                   /* iLast */
  41,                                  /* lineNo */
  5,                                   /* colNo */
  "bw",                                /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo il_emlrtBCI = { 1,  /* iFirst */
  7,                                   /* iLast */
  37,                                  /* lineNo */
  17,                                  /* colNo */
  "bw",                                /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo jl_emlrtBCI = { 1,  /* iFirst */
  7,                                   /* iLast */
  37,                                  /* lineNo */
  25,                                  /* colNo */
  "bw",                                /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo kl_emlrtBCI = { 1,  /* iFirst */
  7,                                   /* iLast */
  37,                                  /* lineNo */
  33,                                  /* colNo */
  "bw",                                /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ll_emlrtBCI = { 1,  /* iFirst */
  7,                                   /* iLast */
  38,                                  /* lineNo */
  15,                                  /* colNo */
  "L",                                 /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ml_emlrtBCI = { 1,  /* iFirst */
  7,                                   /* iLast */
  38,                                  /* lineNo */
  23,                                  /* colNo */
  "L",                                 /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo nl_emlrtBCI = { 1,  /* iFirst */
  7,                                   /* iLast */
  38,                                  /* lineNo */
  31,                                  /* colNo */
  "L",                                 /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ol_emlrtBCI = { 1,  /* iFirst */
  7,                                   /* iLast */
  40,                                  /* lineNo */
  5,                                   /* colNo */
  "L",                                 /* aName */
  "Labeling",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m",/* pName */
  3                                    /* checkKind */
};

static emlrtRTEInfo ce_emlrtRTEI = { 12,/* lineNo */
  20,                                  /* colNo */
  "TS_bwlabeln3D26",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pName */
};

static emlrtRTEInfo de_emlrtRTEI = { 22,/* lineNo */
  15,                                  /* colNo */
  "TS_bwlabeln3D26",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pName */
};

static emlrtRTEInfo he_emlrtRTEI = { 7,/* lineNo */
  35,                                  /* colNo */
  "TS_bwlabeln3D26",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pName */
};

static emlrtRTEInfo ie_emlrtRTEI = { 4,/* lineNo */
  5,                                   /* colNo */
  "TS_bwlabeln3D26",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pName */
};

static emlrtRTEInfo je_emlrtRTEI = { 13,/* lineNo */
  19,                                  /* colNo */
  "TS_bwlabeln3D26",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pName */
};

static emlrtRTEInfo ke_emlrtRTEI = { 14,/* lineNo */
  5,                                   /* colNo */
  "TS_bwlabeln3D26",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pName */
};

static emlrtRTEInfo le_emlrtRTEI = { 30,/* lineNo */
  9,                                   /* colNo */
  "TS_bwlabeln3D26",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pName */
};

static emlrtRTEInfo me_emlrtRTEI = { 30,/* lineNo */
  5,                                   /* colNo */
  "TS_bwlabeln3D26",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pName */
};

static emlrtRTEInfo ch_emlrtRTEI = { 1,/* lineNo */
  20,                                  /* colNo */
  "TS_bwlabeln3D26",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pName */
};

static emlrtRTEInfo xj_emlrtRTEI = { 18,/* lineNo */
  5,                                   /* colNo */
  "indexDivide",                       /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/indexDivide.m"/* pName */
};

static emlrtRTEInfo yj_emlrtRTEI = { 42,/* lineNo */
  10,                                  /* colNo */
  "ind2sub",                           /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/ind2sub.m"/* pName */
};

static emlrtRSInfo tn_emlrtRSI = { 58, /* lineNo */
  "Labeling",                          /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pathName */
};

/* Function Declarations */
static void Labeling(const emlrtStack *sp, const real_T yxz_data[], boolean_T
                     bw[125], real_T L[125], real_T *Num);
static void b_Labeling(const emlrtStack *sp, const real_T yxz[3], boolean_T bw
  [125], real_T L[125], real_T *Num);
static void b_TS_bwlabeln_linux_c(const emlrtStack *sp, emxArray_boolean_T *bw,
  emxArray_real_T *L, real_T *Num);
static void c_Labeling(const emlrtStack *sp, const real_T yxz_data[],
  emxArray_boolean_T *bw, emxArray_real_T *L, real_T *Num);
static void d_Labeling(const emlrtStack *sp, const real_T yxz[3],
  emxArray_boolean_T *bw, emxArray_real_T *L, real_T *Num);
static void e_Labeling(const emlrtStack *sp, const real_T yxz_data[], boolean_T
  bw[343], real_T L[343], real_T *Num);
static void f_Labeling(const emlrtStack *sp, const real_T yxz[3], boolean_T bw
  [343], real_T L[343], real_T *Num);

/* Function Definitions */
static void Labeling(const emlrtStack *sp, const real_T yxz_data[], boolean_T
                     bw[125], real_T L[125], real_T *Num)
{
  real_T d;
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T i3;
  int32_T i4;
  int32_T idx;
  int32_T i5;
  int32_T ROI_bw_tmp;
  int32_T ROI_L_tmp;
  real_T ROI_L[27];
  int32_T b_ROI_bw_tmp;
  boolean_T ROI_bw[27];
  int32_T b_ROI_L_tmp;
  boolean_T TF1;
  boolean_T exitg1;
  real_T ex;
  emxArray_int8_T *c;
  emxArray_int8_T *b_c;
  const mxArray *y;
  const mxArray *m;
  int32_T iv[2];
  int8_T ii_data[27];
  real_T y1_data[27];
  real_T x1_data[27];
  real_T z1_data[27];
  real_T b_y[3];
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
  d = yxz_data[0];
  i = (int32_T)(d + -1.0);
  i1 = (int32_T)d;
  i2 = (int32_T)(d + 1.0);
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)(yxz_data[2] + ((real_T)i3 + -1.0));
    idx = 25 * (i4 - 1);
    for (i5 = 0; i5 < 3; i5++) {
      if ((i < 1) || (i > 5)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 5, &rk_emlrtBCI, sp);
      }

      ROI_bw_tmp = (int32_T)(yxz_data[1] + ((real_T)i5 + -1.0));
      if ((ROI_bw_tmp < 1) || (ROI_bw_tmp > 5)) {
        emlrtDynamicBoundsCheckR2012b(ROI_bw_tmp, 1, 5, &sk_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 5, &tk_emlrtBCI, sp);
      }

      b_ROI_bw_tmp = 3 * i5 + 9 * i3;
      ROI_bw_tmp = 5 * (ROI_bw_tmp - 1);
      ROI_bw[b_ROI_bw_tmp] = bw[((i + ROI_bw_tmp) + idx) - 1];
      if ((i1 < 1) || (i1 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 5, &rk_emlrtBCI, sp);
      }

      ROI_bw[b_ROI_bw_tmp + 1] = bw[((i1 + ROI_bw_tmp) + idx) - 1];
      if ((i2 < 1) || (i2 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 5, &rk_emlrtBCI, sp);
      }

      ROI_bw[b_ROI_bw_tmp + 2] = bw[((i2 + ROI_bw_tmp) + idx) - 1];
    }
  }

  d = yxz_data[0];
  i = (int32_T)(d + -1.0);
  i1 = (int32_T)d;
  i2 = (int32_T)(d + 1.0);
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)(yxz_data[2] + ((real_T)i3 + -1.0));
    ROI_L_tmp = 25 * (i4 - 1);
    for (i5 = 0; i5 < 3; i5++) {
      if ((i < 1) || (i > 5)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 5, &uk_emlrtBCI, sp);
      }

      ROI_bw_tmp = (int32_T)(yxz_data[1] + ((real_T)i5 + -1.0));
      if ((ROI_bw_tmp < 1) || (ROI_bw_tmp > 5)) {
        emlrtDynamicBoundsCheckR2012b(ROI_bw_tmp, 1, 5, &vk_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 5, &wk_emlrtBCI, sp);
      }

      b_ROI_L_tmp = 3 * i5 + 9 * i3;
      idx = 5 * (ROI_bw_tmp - 1);
      ROI_L[b_ROI_L_tmp] = L[((i + idx) + ROI_L_tmp) - 1];
      if ((i1 < 1) || (i1 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 5, &uk_emlrtBCI, sp);
      }

      ROI_L[b_ROI_L_tmp + 1] = L[((i1 + idx) + ROI_L_tmp) - 1];
      if ((i2 < 1) || (i2 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 5, &uk_emlrtBCI, sp);
      }

      ROI_L[b_ROI_L_tmp + 2] = L[((i2 + idx) + ROI_L_tmp) - 1];
    }
  }

  for (ROI_bw_tmp = 0; ROI_bw_tmp < 27; ROI_bw_tmp++) {
    if (bw[(((int32_T)(yxz_data[0] + ((real_T)(ROI_bw_tmp % 3) + -1.0)) + 5 *
             ((int32_T)(yxz_data[1] + ((real_T)(ROI_bw_tmp / 3 % 3) + -1.0)) - 1))
            + 25 * ((int32_T)(yxz_data[2] + ((real_T)(ROI_bw_tmp / 9) + -1.0)) -
                    1)) - 1]) {
      ROI_L[ROI_bw_tmp] = *Num;
    }
  }

  d = yxz_data[0];
  i = (int32_T)(d + -1.0);
  i1 = (int32_T)d;
  i2 = (int32_T)(d + 1.0);
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)(yxz_data[2] + ((real_T)i3 + -1.0));
    i5 = 25 * (i4 - 1);
    for (ROI_bw_tmp = 0; ROI_bw_tmp < 3; ROI_bw_tmp++) {
      if ((i < 1) || (i > 5)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 5, &xk_emlrtBCI, sp);
      }

      idx = (int32_T)(yxz_data[1] + ((real_T)ROI_bw_tmp + -1.0));
      if ((idx < 1) || (idx > 5)) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, 5, &xk_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 5, &xk_emlrtBCI, sp);
      }

      b_ROI_bw_tmp = 3 * ROI_bw_tmp + 9 * i3;
      idx = 5 * (idx - 1);
      L[((i + idx) + i5) - 1] = ROI_L[b_ROI_bw_tmp];
      if ((i1 < 1) || (i1 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 5, &xk_emlrtBCI, sp);
      }

      L[((i1 + idx) + i5) - 1] = ROI_L[b_ROI_bw_tmp + 1];
      if ((i2 < 1) || (i2 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 5, &xk_emlrtBCI, sp);
      }

      L[((i2 + idx) + i5) - 1] = ROI_L[b_ROI_bw_tmp + 2];
    }
  }

  i = (int32_T)yxz_data[0];
  if ((i < 1) || (i > 5)) {
    emlrtDynamicBoundsCheckR2012b(i, 1, 5, &nk_emlrtBCI, sp);
  }

  i1 = (int32_T)yxz_data[1];
  if ((i1 < 1) || (i1 > 5)) {
    emlrtDynamicBoundsCheckR2012b(i1, 1, 5, &nk_emlrtBCI, sp);
  }

  i2 = (int32_T)yxz_data[2];
  if ((i2 < 1) || (i2 > 5)) {
    emlrtDynamicBoundsCheckR2012b(i2, 1, 5, &nk_emlrtBCI, sp);
  }

  bw[((i + 5 * (i1 - 1)) + 25 * (i2 - 1)) - 1] = false;
  ROI_bw[13] = false;
  TF1 = ROI_bw[0];
  for (b_ROI_L_tmp = 0; b_ROI_L_tmp < 26; b_ROI_L_tmp++) {
    TF1 = (((int32_T)TF1 < (int32_T)ROI_bw[b_ROI_L_tmp + 1]) || TF1);
  }

  st.site = &nd_emlrtRSI;
  b_st.site = &qd_emlrtRSI;
  c_st.site = &rd_emlrtRSI;
  if (!muDoubleScalarIsNaN(ROI_L[0])) {
    idx = 1;
  } else {
    idx = 0;
    b_ROI_L_tmp = 2;
    exitg1 = false;
    while ((!exitg1) && (b_ROI_L_tmp <= 27)) {
      if (!muDoubleScalarIsNaN(ROI_L[b_ROI_L_tmp - 1])) {
        idx = b_ROI_L_tmp;
        exitg1 = true;
      } else {
        b_ROI_L_tmp++;
      }
    }
  }

  if (idx == 0) {
    ex = ROI_L[0];
  } else {
    ex = ROI_L[idx - 1];
    ROI_bw_tmp = idx + 1;
    for (b_ROI_L_tmp = ROI_bw_tmp; b_ROI_L_tmp < 28; b_ROI_L_tmp++) {
      d = ROI_L[b_ROI_L_tmp - 1];
      if (ex < d) {
        ex = d;
      }
    }
  }

  emxInit_int8_T(sp, &c, 1, &yj_emlrtRTEI, true);
  emxInit_int8_T(sp, &b_c, 1, &yj_emlrtRTEI, true);
  if (TF1 || (ex == *Num)) {
    st.site = &od_emlrtRSI;
    b_st.site = &cd_emlrtRSI;
    c_st.site = &dd_emlrtRSI;
    idx = 0;
    ROI_bw_tmp = 0;
    exitg1 = false;
    while ((!exitg1) && (ROI_bw_tmp < 27)) {
      if (ROI_bw[ROI_bw_tmp]) {
        idx++;
        ii_data[idx - 1] = (int8_T)(ROI_bw_tmp + 1);
        if (idx >= 27) {
          exitg1 = true;
        } else {
          ROI_bw_tmp++;
        }
      } else {
        ROI_bw_tmp++;
      }
    }

    if (1 > idx) {
      idx = 0;
    }

    iv[0] = 1;
    iv[1] = idx;
    d_st.site = &fd_emlrtRSI;
    indexShapeCheck(&d_st, 27, iv);
    st.site = &od_emlrtRSI;
    b_st.site = &hd_emlrtRSI;
    for (i = 0; i < idx; i++) {
      ii_data[i]--;
    }

    i = c->size[0];
    c->size[0] = idx;
    emxEnsureCapacity_int8_T(&b_st, c, i, &xj_emlrtRTEI);
    for (i = 0; i < idx; i++) {
      c->data[i] = (int8_T)(ii_data[i] / 9);
    }

    for (i = 0; i < idx; i++) {
      ii_data[i] -= (int8_T)(ii_data[i] / 9 * 9);
    }

    i = b_c->size[0];
    b_c->size[0] = idx;
    emxEnsureCapacity_int8_T(&b_st, b_c, i, &xj_emlrtRTEI);
    for (i = 0; i < idx; i++) {
      b_c->data[i] = (int8_T)(ii_data[i] / 3);
    }

    for (i = 0; i < idx; i++) {
      ii_data[i] -= (int8_T)(ii_data[i] / 3 * 3);
    }

    for (i = 0; i < idx; i++) {
      y1_data[i] = (real_T)ii_data[i] + 1.0;
    }

    if (idx != 0) {
      for (i = 0; i < idx; i++) {
        y1_data[i] = (yxz_data[0] + y1_data[i]) - 2.0;
      }

      b_ROI_bw_tmp = b_c->size[0];
      ROI_bw_tmp = b_c->size[0];
      for (i = 0; i < ROI_bw_tmp; i++) {
        x1_data[i] = (yxz_data[1] + ((real_T)b_c->data[i] + 1.0)) - 2.0;
      }

      ROI_L_tmp = c->size[0];
      ROI_bw_tmp = c->size[0];
      for (i = 0; i < ROI_bw_tmp; i++) {
        z1_data[i] = (yxz_data[2] + ((real_T)c->data[i] + 1.0)) - 2.0;
      }

      for (b_ROI_L_tmp = 0; b_ROI_L_tmp < idx; b_ROI_L_tmp++) {
        i = b_ROI_L_tmp + 1;
        if (i > idx) {
          emlrtDynamicBoundsCheckR2012b(i, 1, idx, &ok_emlrtBCI, sp);
        }

        b_y[0] = y1_data[i - 1];
        i = b_ROI_L_tmp + 1;
        if (i > b_ROI_bw_tmp) {
          emlrtDynamicBoundsCheckR2012b(i, 1, b_ROI_bw_tmp, &pk_emlrtBCI, sp);
        }

        b_y[1] = x1_data[i - 1];
        i = b_ROI_L_tmp + 1;
        if (i > ROI_L_tmp) {
          emlrtDynamicBoundsCheckR2012b(i, 1, ROI_L_tmp, &qk_emlrtBCI, sp);
        }

        b_y[2] = z1_data[i - 1];
        st.site = &pd_emlrtRSI;
        b_Labeling(&st, b_y, bw, L, Num);
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(sp);
        }
      }
    }
  } else {
    y = NULL;
    m = emlrtCreateDoubleScalar(*Num);
    emlrtAssign(&y, m);
    st.site = &tn_emlrtRSI;
    disp(&st, y, &emlrtMCI);
    (*Num)++;
  }

  emxFree_int8_T(&b_c);
  emxFree_int8_T(&c);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

static void b_Labeling(const emlrtStack *sp, const real_T yxz[3], boolean_T bw
  [125], real_T L[125], real_T *Num)
{
  real_T d;
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T i3;
  int32_T i4;
  int32_T idx;
  int32_T i5;
  int32_T ROI_bw_tmp;
  int32_T ROI_L_tmp;
  real_T ROI_L[27];
  int32_T b_ROI_bw_tmp;
  boolean_T ROI_bw[27];
  int32_T b_ROI_L_tmp;
  boolean_T TF1;
  boolean_T exitg1;
  real_T ex;
  emxArray_int8_T *c;
  emxArray_int8_T *b_c;
  const mxArray *y;
  const mxArray *m;
  int32_T iv[2];
  int8_T ii_data[27];
  real_T y1_data[27];
  real_T x1_data[27];
  real_T z1_data[27];
  real_T b_y[3];
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
  if (*emlrtBreakCheckR2012bFlagVar != 0) {
    emlrtBreakCheckR2012b(sp);
  }

  d = yxz[0];
  i = (int32_T)(d + -1.0);
  i1 = (int32_T)d;
  i2 = (int32_T)(d + 1.0);
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)(yxz[2] + ((real_T)i3 + -1.0));
    idx = 25 * (i4 - 1);
    for (i5 = 0; i5 < 3; i5++) {
      if ((i < 1) || (i > 5)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 5, &rk_emlrtBCI, sp);
      }

      ROI_bw_tmp = (int32_T)(yxz[1] + ((real_T)i5 + -1.0));
      if ((ROI_bw_tmp < 1) || (ROI_bw_tmp > 5)) {
        emlrtDynamicBoundsCheckR2012b(ROI_bw_tmp, 1, 5, &sk_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 5, &tk_emlrtBCI, sp);
      }

      b_ROI_bw_tmp = 3 * i5 + 9 * i3;
      ROI_bw_tmp = 5 * (ROI_bw_tmp - 1);
      ROI_bw[b_ROI_bw_tmp] = bw[((i + ROI_bw_tmp) + idx) - 1];
      if ((i1 < 1) || (i1 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 5, &rk_emlrtBCI, sp);
      }

      ROI_bw[b_ROI_bw_tmp + 1] = bw[((i1 + ROI_bw_tmp) + idx) - 1];
      if ((i2 < 1) || (i2 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 5, &rk_emlrtBCI, sp);
      }

      ROI_bw[b_ROI_bw_tmp + 2] = bw[((i2 + ROI_bw_tmp) + idx) - 1];
    }
  }

  d = yxz[0];
  i = (int32_T)(d + -1.0);
  i1 = (int32_T)d;
  i2 = (int32_T)(d + 1.0);
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)(yxz[2] + ((real_T)i3 + -1.0));
    ROI_L_tmp = 25 * (i4 - 1);
    for (i5 = 0; i5 < 3; i5++) {
      if ((i < 1) || (i > 5)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 5, &uk_emlrtBCI, sp);
      }

      ROI_bw_tmp = (int32_T)(yxz[1] + ((real_T)i5 + -1.0));
      if ((ROI_bw_tmp < 1) || (ROI_bw_tmp > 5)) {
        emlrtDynamicBoundsCheckR2012b(ROI_bw_tmp, 1, 5, &vk_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 5, &wk_emlrtBCI, sp);
      }

      b_ROI_L_tmp = 3 * i5 + 9 * i3;
      idx = 5 * (ROI_bw_tmp - 1);
      ROI_L[b_ROI_L_tmp] = L[((i + idx) + ROI_L_tmp) - 1];
      if ((i1 < 1) || (i1 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 5, &uk_emlrtBCI, sp);
      }

      ROI_L[b_ROI_L_tmp + 1] = L[((i1 + idx) + ROI_L_tmp) - 1];
      if ((i2 < 1) || (i2 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 5, &uk_emlrtBCI, sp);
      }

      ROI_L[b_ROI_L_tmp + 2] = L[((i2 + idx) + ROI_L_tmp) - 1];
    }
  }

  for (ROI_bw_tmp = 0; ROI_bw_tmp < 27; ROI_bw_tmp++) {
    if (bw[(((int32_T)(yxz[0] + ((real_T)(ROI_bw_tmp % 3) + -1.0)) + 5 *
             ((int32_T)(yxz[1] + ((real_T)(ROI_bw_tmp / 3 % 3) + -1.0)) - 1)) +
            25 * ((int32_T)(yxz[2] + ((real_T)(ROI_bw_tmp / 9) + -1.0)) - 1)) -
        1]) {
      ROI_L[ROI_bw_tmp] = *Num;
    }
  }

  d = yxz[0];
  i = (int32_T)(d + -1.0);
  i1 = (int32_T)d;
  i2 = (int32_T)(d + 1.0);
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)(yxz[2] + ((real_T)i3 + -1.0));
    i5 = 25 * (i4 - 1);
    for (ROI_bw_tmp = 0; ROI_bw_tmp < 3; ROI_bw_tmp++) {
      if ((i < 1) || (i > 5)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 5, &xk_emlrtBCI, sp);
      }

      idx = (int32_T)(yxz[1] + ((real_T)ROI_bw_tmp + -1.0));
      if ((idx < 1) || (idx > 5)) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, 5, &xk_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 5, &xk_emlrtBCI, sp);
      }

      b_ROI_bw_tmp = 3 * ROI_bw_tmp + 9 * i3;
      idx = 5 * (idx - 1);
      L[((i + idx) + i5) - 1] = ROI_L[b_ROI_bw_tmp];
      if ((i1 < 1) || (i1 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 5, &xk_emlrtBCI, sp);
      }

      L[((i1 + idx) + i5) - 1] = ROI_L[b_ROI_bw_tmp + 1];
      if ((i2 < 1) || (i2 > 5)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 5, &xk_emlrtBCI, sp);
      }

      L[((i2 + idx) + i5) - 1] = ROI_L[b_ROI_bw_tmp + 2];
    }
  }

  i = (int32_T)yxz[0];
  if ((i < 1) || (i > 5)) {
    emlrtDynamicBoundsCheckR2012b(i, 1, 5, &nk_emlrtBCI, sp);
  }

  i1 = (int32_T)yxz[1];
  if ((i1 < 1) || (i1 > 5)) {
    emlrtDynamicBoundsCheckR2012b(i1, 1, 5, &nk_emlrtBCI, sp);
  }

  i2 = (int32_T)yxz[2];
  if ((i2 < 1) || (i2 > 5)) {
    emlrtDynamicBoundsCheckR2012b(i2, 1, 5, &nk_emlrtBCI, sp);
  }

  bw[((i + 5 * (i1 - 1)) + 25 * (i2 - 1)) - 1] = false;
  ROI_bw[13] = false;
  TF1 = ROI_bw[0];
  for (b_ROI_L_tmp = 0; b_ROI_L_tmp < 26; b_ROI_L_tmp++) {
    TF1 = (((int32_T)TF1 < (int32_T)ROI_bw[b_ROI_L_tmp + 1]) || TF1);
  }

  st.site = &nd_emlrtRSI;
  b_st.site = &qd_emlrtRSI;
  c_st.site = &rd_emlrtRSI;
  if (!muDoubleScalarIsNaN(ROI_L[0])) {
    idx = 1;
  } else {
    idx = 0;
    b_ROI_L_tmp = 2;
    exitg1 = false;
    while ((!exitg1) && (b_ROI_L_tmp <= 27)) {
      if (!muDoubleScalarIsNaN(ROI_L[b_ROI_L_tmp - 1])) {
        idx = b_ROI_L_tmp;
        exitg1 = true;
      } else {
        b_ROI_L_tmp++;
      }
    }
  }

  if (idx == 0) {
    ex = ROI_L[0];
  } else {
    ex = ROI_L[idx - 1];
    ROI_bw_tmp = idx + 1;
    for (b_ROI_L_tmp = ROI_bw_tmp; b_ROI_L_tmp < 28; b_ROI_L_tmp++) {
      d = ROI_L[b_ROI_L_tmp - 1];
      if (ex < d) {
        ex = d;
      }
    }
  }

  emxInit_int8_T(sp, &c, 1, &yj_emlrtRTEI, true);
  emxInit_int8_T(sp, &b_c, 1, &yj_emlrtRTEI, true);
  if (TF1 || (ex == *Num)) {
    st.site = &od_emlrtRSI;
    b_st.site = &cd_emlrtRSI;
    c_st.site = &dd_emlrtRSI;
    idx = 0;
    ROI_bw_tmp = 0;
    exitg1 = false;
    while ((!exitg1) && (ROI_bw_tmp < 27)) {
      if (ROI_bw[ROI_bw_tmp]) {
        idx++;
        ii_data[idx - 1] = (int8_T)(ROI_bw_tmp + 1);
        if (idx >= 27) {
          exitg1 = true;
        } else {
          ROI_bw_tmp++;
        }
      } else {
        ROI_bw_tmp++;
      }
    }

    if (1 > idx) {
      idx = 0;
    }

    iv[0] = 1;
    iv[1] = idx;
    d_st.site = &fd_emlrtRSI;
    indexShapeCheck(&d_st, 27, iv);
    st.site = &od_emlrtRSI;
    b_st.site = &hd_emlrtRSI;
    for (i = 0; i < idx; i++) {
      ii_data[i]--;
    }

    i = c->size[0];
    c->size[0] = idx;
    emxEnsureCapacity_int8_T(&b_st, c, i, &xj_emlrtRTEI);
    for (i = 0; i < idx; i++) {
      c->data[i] = (int8_T)(ii_data[i] / 9);
    }

    for (i = 0; i < idx; i++) {
      ii_data[i] -= (int8_T)(ii_data[i] / 9 * 9);
    }

    i = b_c->size[0];
    b_c->size[0] = idx;
    emxEnsureCapacity_int8_T(&b_st, b_c, i, &xj_emlrtRTEI);
    for (i = 0; i < idx; i++) {
      b_c->data[i] = (int8_T)(ii_data[i] / 3);
    }

    for (i = 0; i < idx; i++) {
      ii_data[i] -= (int8_T)(ii_data[i] / 3 * 3);
    }

    for (i = 0; i < idx; i++) {
      y1_data[i] = (real_T)ii_data[i] + 1.0;
    }

    if (idx != 0) {
      for (i = 0; i < idx; i++) {
        y1_data[i] = (yxz[0] + y1_data[i]) - 2.0;
      }

      b_ROI_bw_tmp = b_c->size[0];
      ROI_bw_tmp = b_c->size[0];
      for (i = 0; i < ROI_bw_tmp; i++) {
        x1_data[i] = (yxz[1] + ((real_T)b_c->data[i] + 1.0)) - 2.0;
      }

      ROI_L_tmp = c->size[0];
      ROI_bw_tmp = c->size[0];
      for (i = 0; i < ROI_bw_tmp; i++) {
        z1_data[i] = (yxz[2] + ((real_T)c->data[i] + 1.0)) - 2.0;
      }

      for (b_ROI_L_tmp = 0; b_ROI_L_tmp < idx; b_ROI_L_tmp++) {
        i = b_ROI_L_tmp + 1;
        if (i > idx) {
          emlrtDynamicBoundsCheckR2012b(i, 1, idx, &ok_emlrtBCI, sp);
        }

        b_y[0] = y1_data[i - 1];
        i = b_ROI_L_tmp + 1;
        if (i > b_ROI_bw_tmp) {
          emlrtDynamicBoundsCheckR2012b(i, 1, b_ROI_bw_tmp, &pk_emlrtBCI, sp);
        }

        b_y[1] = x1_data[i - 1];
        i = b_ROI_L_tmp + 1;
        if (i > ROI_L_tmp) {
          emlrtDynamicBoundsCheckR2012b(i, 1, ROI_L_tmp, &qk_emlrtBCI, sp);
        }

        b_y[2] = z1_data[i - 1];
        st.site = &pd_emlrtRSI;
        b_Labeling(&st, b_y, bw, L, Num);
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(sp);
        }
      }
    }
  } else {
    y = NULL;
    m = emlrtCreateDoubleScalar(*Num);
    emlrtAssign(&y, m);
    st.site = &tn_emlrtRSI;
    disp(&st, y, &emlrtMCI);
    (*Num)++;
  }

  emxFree_int8_T(&b_c);
  emxFree_int8_T(&c);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

static void b_TS_bwlabeln_linux_c(const emlrtStack *sp, emxArray_boolean_T *bw,
  emxArray_real_T *L, real_T *Num)
{
  emxArray_boolean_T *b_bw;
  int32_T i;
  int32_T loop_ub;
  uint32_T siz_idx_0;
  uint32_T siz_idx_1;
  uint32_T siz_idx_2;
  int32_T idx;
  int32_T ii_size_idx_0;
  int32_T ii;
  boolean_T exitg1;
  emxArray_int32_T *b_idx;
  int32_T ii_data[1];
  int32_T hi_tmp;
  emxArray_int32_T *vk;
  emxArray_int32_T *varargout_6;
  int32_T y_size[1];
  int32_T x_size[1];
  real_T y_data[1];
  int32_T z_size[1];
  real_T x_data[1];
  real_T z_data[1];
  int32_T hi;
  emxArray_real_T *r;
  int32_T cpsiz;
  int32_T cpsiz_tmp;
  emxArray_real_T b_y_data;
  emxArray_real_T b_x_data;
  emxArray_real_T b_z_data;
  emxArray_real_T *b_L;
  real_T preNum;
  real_T yxz_data[3];
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
  emxInit_boolean_T(sp, &b_bw, 3, &je_emlrtRTEI, true);
  i = b_bw->size[0] * b_bw->size[1] * b_bw->size[2];
  b_bw->size[0] = bw->size[0];
  b_bw->size[1] = bw->size[1];
  b_bw->size[2] = bw->size[2];
  emxEnsureCapacity_boolean_T(sp, b_bw, i, &je_emlrtRTEI);
  loop_ub = bw->size[0] * bw->size[1] * bw->size[2] - 1;
  for (i = 0; i <= loop_ub; i++) {
    b_bw->data[i] = bw->data[i];
  }

  st.site = &ie_emlrtRSI;
  padarray(&st, b_bw, bw);
  siz_idx_0 = (uint32_T)bw->size[0];
  siz_idx_1 = (uint32_T)bw->size[1];
  siz_idx_2 = (uint32_T)bw->size[2];
  i = L->size[0] * L->size[1] * L->size[2];
  L->size[0] = (int32_T)siz_idx_0;
  L->size[1] = (int32_T)siz_idx_1;
  L->size[2] = (int32_T)siz_idx_2;
  emxEnsureCapacity_real_T(sp, L, i, &ke_emlrtRTEI);
  loop_ub = (int32_T)siz_idx_0 * (int32_T)siz_idx_1 * (int32_T)siz_idx_2;
  emxFree_boolean_T(&b_bw);
  for (i = 0; i < loop_ub; i++) {
    L->data[i] = 0.0;
  }

  if (*emlrtBreakCheckR2012bFlagVar != 0) {
    emlrtBreakCheckR2012b(sp);
  }

  if (*emlrtBreakCheckR2012bFlagVar != 0) {
    emlrtBreakCheckR2012b(sp);
  }

  siz_idx_2 = (uint32_T)bw->size[2];
  if (*emlrtBreakCheckR2012bFlagVar != 0) {
    emlrtBreakCheckR2012b(sp);
  }

  st.site = &md_emlrtRSI;
  b_st.site = &cd_emlrtRSI;
  c_st.site = &dd_emlrtRSI;
  idx = 0;
  ii_size_idx_0 = 1;
  d_st.site = &ed_emlrtRSI;
  if ((1 <= bw->size[0] * bw->size[1] * bw->size[2]) && (bw->size[0] * bw->size
       [1] * bw->size[2] > 2147483646)) {
    e_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&e_st);
  }

  ii = 0;
  exitg1 = false;
  while ((!exitg1) && (ii <= bw->size[0] * bw->size[1] * bw->size[2] - 1)) {
    if (bw->data[ii]) {
      idx = 1;
      ii_data[0] = ii + 1;
      exitg1 = true;
    } else {
      ii++;
    }
  }

  if (idx == 0) {
    ii_size_idx_0 = 0;
  }

  emxInit_int32_T(&c_st, &b_idx, 1, &ae_emlrtRTEI, true);
  st.site = &md_emlrtRSI;
  b_st.site = &hd_emlrtRSI;
  i = b_idx->size[0];
  b_idx->size[0] = ii_size_idx_0;
  emxEnsureCapacity_int32_T(&b_st, b_idx, i, &ae_emlrtRTEI);
  for (i = 0; i < ii_size_idx_0; i++) {
    b_idx->data[0] = ii_data[0];
  }

  ii = bw->size[0];
  ii_size_idx_0 = bw->size[1] * ii;
  hi_tmp = ii_size_idx_0 * (int32_T)siz_idx_2;
  idx = 0;
  exitg1 = false;
  while ((!exitg1) && (idx <= b_idx->size[0] - 1)) {
    if (b_idx->data[0] <= hi_tmp) {
      idx = 1;
    } else {
      emlrtErrorWithMessageIdR2018a(&b_st, &g_emlrtRTEI,
        "Coder:MATLAB:ind2sub_IndexOutOfRange",
        "Coder:MATLAB:ind2sub_IndexOutOfRange", 0);
    }
  }

  loop_ub = b_idx->size[0];
  for (i = 0; i < loop_ub; i++) {
    b_idx->data[i]--;
  }

  emxInit_int32_T(&b_st, &vk, 1, &wc_emlrtRTEI, true);
  i = vk->size[0];
  vk->size[0] = b_idx->size[0];
  emxEnsureCapacity_int32_T(&b_st, vk, i, &wc_emlrtRTEI);
  loop_ub = b_idx->size[0];
  for (i = 0; i < loop_ub; i++) {
    c_st.site = &un_emlrtRSI;
    vk->data[i] = div_s32(&c_st, b_idx->data[i], ii_size_idx_0);
  }

  emxInit_int32_T(&b_st, &varargout_6, 1, &ce_emlrtRTEI, true);
  i = varargout_6->size[0];
  varargout_6->size[0] = vk->size[0];
  emxEnsureCapacity_int32_T(&b_st, varargout_6, i, &xc_emlrtRTEI);
  loop_ub = vk->size[0];
  for (i = 0; i < loop_ub; i++) {
    varargout_6->data[i] = vk->data[i] + 1;
  }

  loop_ub = b_idx->size[0];
  for (i = 0; i < loop_ub; i++) {
    b_idx->data[i] -= vk->data[i] * ii_size_idx_0;
  }

  i = vk->size[0];
  vk->size[0] = b_idx->size[0];
  emxEnsureCapacity_int32_T(&b_st, vk, i, &wc_emlrtRTEI);
  loop_ub = b_idx->size[0];
  for (i = 0; i < loop_ub; i++) {
    c_st.site = &un_emlrtRSI;
    vk->data[i] = div_s32(&c_st, b_idx->data[i], ii);
  }

  loop_ub = b_idx->size[0];
  for (i = 0; i < loop_ub; i++) {
    b_idx->data[i] -= vk->data[i] * ii;
  }

  y_size[0] = b_idx->size[0];
  loop_ub = b_idx->size[0];
  for (i = 0; i < loop_ub; i++) {
    y_data[i] = b_idx->data[i] + 1;
  }

  x_size[0] = vk->size[0];
  loop_ub = vk->size[0];
  for (i = 0; i < loop_ub; i++) {
    x_data[i] = vk->data[i] + 1;
  }

  z_size[0] = varargout_6->size[0];
  loop_ub = varargout_6->size[0];
  for (i = 0; i < loop_ub; i++) {
    z_data[i] = varargout_6->data[i];
  }

  *Num = 1.0;
  if (y_size[0] != 0) {
    hi = hi_tmp;
    cpsiz = ii_size_idx_0;
    cpsiz_tmp = ii;
  }

  emxInit_real_T(sp, &r, 2, &de_emlrtRTEI, true);
  while (y_size[0] != 0) {
    b_y_data.data = &y_data[0];
    b_y_data.size = &y_size[0];
    b_y_data.allocatedSize = 1;
    b_y_data.numDimensions = 1;
    b_y_data.canFreeData = false;
    b_x_data.data = &x_data[0];
    b_x_data.size = &x_size[0];
    b_x_data.allocatedSize = 1;
    b_x_data.numDimensions = 1;
    b_x_data.canFreeData = false;
    b_z_data.data = &z_data[0];
    b_z_data.size = &z_size[0];
    b_z_data.allocatedSize = 1;
    b_z_data.numDimensions = 1;
    b_z_data.canFreeData = false;
    st.site = &ld_emlrtRSI;
    b_cat(&st, &b_y_data, &b_x_data, &b_z_data, r);
    loop_ub = r->size[0] * r->size[1];
    for (i = 0; i < loop_ub; i++) {
      yxz_data[i] = r->data[i];
    }

    preNum = *Num;
    st.site = &kd_emlrtRSI;
    c_Labeling(&st, yxz_data, bw, L, Num);
    if (preNum == *Num) {
      (*Num)++;
    }

    st.site = &jd_emlrtRSI;
    b_st.site = &cd_emlrtRSI;
    c_st.site = &dd_emlrtRSI;
    idx = 0;
    ii_size_idx_0 = 1;
    d_st.site = &ed_emlrtRSI;
    if ((1 <= bw->size[0] * bw->size[1] * bw->size[2]) && (bw->size[0] *
         bw->size[1] * bw->size[2] > 2147483646)) {
      e_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    ii = 0;
    exitg1 = false;
    while ((!exitg1) && (ii <= bw->size[0] * bw->size[1] * bw->size[2] - 1)) {
      if (bw->data[ii]) {
        idx = 1;
        ii_data[0] = ii + 1;
        exitg1 = true;
      } else {
        ii++;
      }
    }

    if (idx == 0) {
      ii_size_idx_0 = 0;
    }

    st.site = &jd_emlrtRSI;
    b_st.site = &hd_emlrtRSI;
    i = b_idx->size[0];
    b_idx->size[0] = ii_size_idx_0;
    emxEnsureCapacity_int32_T(&b_st, b_idx, i, &ae_emlrtRTEI);
    for (i = 0; i < ii_size_idx_0; i++) {
      b_idx->data[0] = ii_data[0];
    }

    idx = 0;
    exitg1 = false;
    while ((!exitg1) && (idx <= b_idx->size[0] - 1)) {
      if (b_idx->data[0] <= hi) {
        idx = 1;
      } else {
        emlrtErrorWithMessageIdR2018a(&b_st, &g_emlrtRTEI,
          "Coder:MATLAB:ind2sub_IndexOutOfRange",
          "Coder:MATLAB:ind2sub_IndexOutOfRange", 0);
      }
    }

    loop_ub = b_idx->size[0];
    for (i = 0; i < loop_ub; i++) {
      b_idx->data[i]--;
    }

    i = vk->size[0];
    vk->size[0] = b_idx->size[0];
    emxEnsureCapacity_int32_T(&b_st, vk, i, &wc_emlrtRTEI);
    loop_ub = b_idx->size[0];
    for (i = 0; i < loop_ub; i++) {
      c_st.site = &un_emlrtRSI;
      vk->data[i] = div_s32(&c_st, b_idx->data[i], cpsiz);
    }

    i = varargout_6->size[0];
    varargout_6->size[0] = vk->size[0];
    emxEnsureCapacity_int32_T(&b_st, varargout_6, i, &xc_emlrtRTEI);
    loop_ub = vk->size[0];
    for (i = 0; i < loop_ub; i++) {
      varargout_6->data[i] = vk->data[i] + 1;
    }

    loop_ub = b_idx->size[0];
    for (i = 0; i < loop_ub; i++) {
      b_idx->data[i] -= vk->data[i] * cpsiz;
    }

    i = vk->size[0];
    vk->size[0] = b_idx->size[0];
    emxEnsureCapacity_int32_T(&b_st, vk, i, &wc_emlrtRTEI);
    loop_ub = b_idx->size[0];
    for (i = 0; i < loop_ub; i++) {
      c_st.site = &un_emlrtRSI;
      vk->data[i] = div_s32(&c_st, b_idx->data[i], cpsiz_tmp);
    }

    loop_ub = b_idx->size[0];
    for (i = 0; i < loop_ub; i++) {
      b_idx->data[i] -= vk->data[i] * cpsiz_tmp;
    }

    y_size[0] = b_idx->size[0];
    loop_ub = b_idx->size[0];
    for (i = 0; i < loop_ub; i++) {
      y_data[i] = b_idx->data[i] + 1;
    }

    x_size[0] = vk->size[0];
    loop_ub = vk->size[0];
    for (i = 0; i < loop_ub; i++) {
      x_data[i] = vk->data[i] + 1;
    }

    z_size[0] = varargout_6->size[0];
    loop_ub = varargout_6->size[0];
    for (i = 0; i < loop_ub; i++) {
      z_data[i] = varargout_6->data[i];
    }

    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(&r);
  emxFree_int32_T(&vk);
  emxFree_int32_T(&b_idx);
  emxFree_int32_T(&varargout_6);
  if (2.0 > (real_T)L->size[0] - 1.0) {
    i = 0;
    idx = 0;
  } else {
    i = 1;
    idx = L->size[0] - 1;
    if ((idx < 1) || (idx > L->size[0])) {
      emlrtDynamicBoundsCheckR2012b(idx, 1, L->size[0], &ad_emlrtBCI, sp);
    }
  }

  if (2.0 > (real_T)L->size[1] - 1.0) {
    ii = 0;
    ii_size_idx_0 = 0;
  } else {
    ii = 1;
    ii_size_idx_0 = L->size[1] - 1;
    if ((ii_size_idx_0 < 1) || (ii_size_idx_0 > L->size[1])) {
      emlrtDynamicBoundsCheckR2012b(ii_size_idx_0, 1, L->size[1], &yc_emlrtBCI,
        sp);
    }
  }

  if (2.0 > (real_T)L->size[2] - 1.0) {
    hi_tmp = 0;
    hi = 0;
  } else {
    hi_tmp = 1;
    hi = L->size[2] - 1;
    if ((hi < 1) || (hi > L->size[2])) {
      emlrtDynamicBoundsCheckR2012b(hi, 1, L->size[2], &xc_emlrtBCI, sp);
    }
  }

  emxInit_real_T(sp, &b_L, 3, &le_emlrtRTEI, true);
  loop_ub = idx - i;
  idx = b_L->size[0] * b_L->size[1] * b_L->size[2];
  b_L->size[0] = loop_ub;
  cpsiz = ii_size_idx_0 - ii;
  b_L->size[1] = cpsiz;
  cpsiz_tmp = hi - hi_tmp;
  b_L->size[2] = cpsiz_tmp;
  emxEnsureCapacity_real_T(sp, b_L, idx, &le_emlrtRTEI);
  for (idx = 0; idx < cpsiz_tmp; idx++) {
    for (ii_size_idx_0 = 0; ii_size_idx_0 < cpsiz; ii_size_idx_0++) {
      for (hi = 0; hi < loop_ub; hi++) {
        b_L->data[(hi + b_L->size[0] * ii_size_idx_0) + b_L->size[0] * b_L->
          size[1] * idx] = L->data[((i + hi) + L->size[0] * (ii + ii_size_idx_0))
          + L->size[0] * L->size[1] * (hi_tmp + idx)];
      }
    }
  }

  i = L->size[0] * L->size[1] * L->size[2];
  L->size[0] = b_L->size[0];
  L->size[1] = b_L->size[1];
  L->size[2] = b_L->size[2];
  emxEnsureCapacity_real_T(sp, L, i, &me_emlrtRTEI);
  loop_ub = b_L->size[0] * b_L->size[1] * b_L->size[2];
  for (i = 0; i < loop_ub; i++) {
    L->data[i] = b_L->data[i];
  }

  emxFree_real_T(&b_L);
  (*Num)--;
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

static void c_Labeling(const emlrtStack *sp, const real_T yxz_data[],
  emxArray_boolean_T *bw, emxArray_real_T *L, real_T *Num)
{
  real_T ROI_bw_tmp[3];
  real_T b_ROI_bw_tmp[3];
  real_T c_ROI_bw_tmp[3];
  int32_T b_bw;
  int32_T idx;
  int32_T c_bw;
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T i3;
  int32_T i4;
  int32_T b_L;
  int32_T i5;
  int32_T i6;
  int32_T d_ROI_bw_tmp;
  real_T ROI_L[27];
  boolean_T ROI_bw[27];
  boolean_T TF1;
  boolean_T exitg1;
  real_T ex;
  real_T d;
  emxArray_int8_T *c;
  emxArray_int8_T *b_c;
  const mxArray *y;
  const mxArray *m;
  int32_T iv[2];
  int8_T ii_data[27];
  real_T y1_data[27];
  real_T x1_data[27];
  real_T z1_data[27];
  real_T b_y[3];
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
  ROI_bw_tmp[0] = yxz_data[0] + -1.0;
  b_ROI_bw_tmp[0] = yxz_data[1] + -1.0;
  c_ROI_bw_tmp[0] = yxz_data[2] + -1.0;
  ROI_bw_tmp[1] = yxz_data[0];
  b_ROI_bw_tmp[1] = yxz_data[1];
  c_ROI_bw_tmp[1] = yxz_data[2];
  ROI_bw_tmp[2] = yxz_data[0] + 1.0;
  b_ROI_bw_tmp[2] = yxz_data[1] + 1.0;
  c_ROI_bw_tmp[2] = yxz_data[2] + 1.0;
  b_bw = bw->size[0];
  idx = bw->size[1];
  c_bw = bw->size[2];
  i = (int32_T)ROI_bw_tmp[0];
  i1 = (int32_T)ROI_bw_tmp[1];
  i2 = (int32_T)ROI_bw_tmp[2];
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)c_ROI_bw_tmp[i3];
    for (i5 = 0; i5 < 3; i5++) {
      if ((i < 1) || (i > b_bw)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, b_bw, &al_emlrtBCI, sp);
      }

      i6 = (int32_T)b_ROI_bw_tmp[i5];
      if ((i6 < 1) || (i6 > idx)) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, idx, &bl_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > c_bw)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, c_bw, &cl_emlrtBCI, sp);
      }

      d_ROI_bw_tmp = 3 * i5 + 9 * i3;
      ROI_bw[d_ROI_bw_tmp] = bw->data[((i + bw->size[0] * (i6 - 1)) + bw->size[0]
        * bw->size[1] * (i4 - 1)) - 1];
      if ((i1 < 1) || (i1 > b_bw)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, b_bw, &al_emlrtBCI, sp);
      }

      if (i6 > idx) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, idx, &bl_emlrtBCI, sp);
      }

      if (i4 > c_bw) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, c_bw, &cl_emlrtBCI, sp);
      }

      ROI_bw[d_ROI_bw_tmp + 1] = bw->data[((i1 + bw->size[0] * (i6 - 1)) +
        bw->size[0] * bw->size[1] * (i4 - 1)) - 1];
      if ((i2 < 1) || (i2 > b_bw)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, b_bw, &al_emlrtBCI, sp);
      }

      if (i6 > idx) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, idx, &bl_emlrtBCI, sp);
      }

      if (i4 > c_bw) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, c_bw, &cl_emlrtBCI, sp);
      }

      ROI_bw[d_ROI_bw_tmp + 2] = bw->data[((i2 + bw->size[0] * (i6 - 1)) +
        bw->size[0] * bw->size[1] * (i4 - 1)) - 1];
    }
  }

  idx = L->size[0];
  b_L = L->size[1];
  b_bw = L->size[2];
  i = (int32_T)ROI_bw_tmp[0];
  i1 = (int32_T)ROI_bw_tmp[1];
  i2 = (int32_T)ROI_bw_tmp[2];
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)c_ROI_bw_tmp[i3];
    for (i5 = 0; i5 < 3; i5++) {
      if ((i < 1) || (i > idx)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, idx, &dl_emlrtBCI, sp);
      }

      i6 = (int32_T)b_ROI_bw_tmp[i5];
      if ((i6 < 1) || (i6 > b_L)) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, b_L, &el_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > b_bw)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, b_bw, &fl_emlrtBCI, sp);
      }

      c_bw = 3 * i5 + 9 * i3;
      ROI_L[c_bw] = L->data[((i + L->size[0] * (i6 - 1)) + L->size[0] * L->size
        [1] * (i4 - 1)) - 1];
      if ((i1 < 1) || (i1 > idx)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, idx, &dl_emlrtBCI, sp);
      }

      if (i6 > b_L) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, b_L, &el_emlrtBCI, sp);
      }

      if (i4 > b_bw) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, b_bw, &fl_emlrtBCI, sp);
      }

      ROI_L[c_bw + 1] = L->data[((i1 + L->size[0] * (i6 - 1)) + L->size[0] *
        L->size[1] * (i4 - 1)) - 1];
      if ((i2 < 1) || (i2 > idx)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, idx, &dl_emlrtBCI, sp);
      }

      if (i6 > b_L) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, b_L, &el_emlrtBCI, sp);
      }

      if (i4 > b_bw) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, b_bw, &fl_emlrtBCI, sp);
      }

      ROI_L[c_bw + 2] = L->data[((i2 + L->size[0] * (i6 - 1)) + L->size[0] *
        L->size[1] * (i4 - 1)) - 1];
    }
  }

  for (b_bw = 0; b_bw < 27; b_bw++) {
    if (bw->data[(((int32_T)ROI_bw_tmp[b_bw % 3] + bw->size[0] * ((int32_T)
           b_ROI_bw_tmp[b_bw / 3 % 3] - 1)) + bw->size[0] * bw->size[1] *
                  ((int32_T)c_ROI_bw_tmp[b_bw / 9] - 1)) - 1]) {
      ROI_L[b_bw] = *Num;
    }
  }

  i = L->size[0];
  i1 = L->size[1];
  i2 = L->size[2];
  i3 = (int32_T)ROI_bw_tmp[0];
  i4 = (int32_T)ROI_bw_tmp[1];
  i5 = (int32_T)ROI_bw_tmp[2];
  for (i6 = 0; i6 < 3; i6++) {
    idx = (int32_T)c_ROI_bw_tmp[i6];
    for (b_bw = 0; b_bw < 3; b_bw++) {
      if ((i3 < 1) || (i3 > i)) {
        emlrtDynamicBoundsCheckR2012b(i3, 1, i, &gl_emlrtBCI, sp);
      }

      c_bw = (int32_T)b_ROI_bw_tmp[b_bw];
      if ((c_bw < 1) || (c_bw > i1)) {
        emlrtDynamicBoundsCheckR2012b(c_bw, 1, i1, &gl_emlrtBCI, sp);
      }

      if ((idx < 1) || (idx > i2)) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, i2, &gl_emlrtBCI, sp);
      }

      d_ROI_bw_tmp = 3 * b_bw + 9 * i6;
      L->data[((i3 + L->size[0] * (c_bw - 1)) + L->size[0] * L->size[1] * (idx -
                1)) - 1] = ROI_L[d_ROI_bw_tmp];
      if ((i4 < 1) || (i4 > i)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, i, &gl_emlrtBCI, sp);
      }

      if (c_bw > i1) {
        emlrtDynamicBoundsCheckR2012b(c_bw, 1, i1, &gl_emlrtBCI, sp);
      }

      if (idx > i2) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, i2, &gl_emlrtBCI, sp);
      }

      L->data[((i4 + L->size[0] * (c_bw - 1)) + L->size[0] * L->size[1] * (idx -
                1)) - 1] = ROI_L[d_ROI_bw_tmp + 1];
      if ((i5 < 1) || (i5 > i)) {
        emlrtDynamicBoundsCheckR2012b(i5, 1, i, &gl_emlrtBCI, sp);
      }

      if (c_bw > i1) {
        emlrtDynamicBoundsCheckR2012b(c_bw, 1, i1, &gl_emlrtBCI, sp);
      }

      if (idx > i2) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, i2, &gl_emlrtBCI, sp);
      }

      L->data[((i5 + L->size[0] * (c_bw - 1)) + L->size[0] * L->size[1] * (idx -
                1)) - 1] = ROI_L[d_ROI_bw_tmp + 2];
    }
  }

  i = bw->size[0];
  i1 = (int32_T)yxz_data[0];
  if ((i1 < 1) || (i1 > i)) {
    emlrtDynamicBoundsCheckR2012b(i1, 1, i, &yk_emlrtBCI, sp);
  }

  i = bw->size[1];
  i2 = (int32_T)yxz_data[1];
  if ((i2 < 1) || (i2 > i)) {
    emlrtDynamicBoundsCheckR2012b(i2, 1, i, &yk_emlrtBCI, sp);
  }

  i = bw->size[2];
  i3 = (int32_T)yxz_data[2];
  if ((i3 < 1) || (i3 > i)) {
    emlrtDynamicBoundsCheckR2012b(i3, 1, i, &yk_emlrtBCI, sp);
  }

  bw->data[((i1 + bw->size[0] * (i2 - 1)) + bw->size[0] * bw->size[1] * (i3 - 1))
    - 1] = false;
  ROI_bw[13] = false;
  TF1 = ROI_bw[0];
  for (b_L = 0; b_L < 26; b_L++) {
    TF1 = (((int32_T)TF1 < (int32_T)ROI_bw[b_L + 1]) || TF1);
  }

  st.site = &nd_emlrtRSI;
  b_st.site = &qd_emlrtRSI;
  c_st.site = &rd_emlrtRSI;
  if (!muDoubleScalarIsNaN(ROI_L[0])) {
    idx = 1;
  } else {
    idx = 0;
    b_L = 2;
    exitg1 = false;
    while ((!exitg1) && (b_L <= 27)) {
      if (!muDoubleScalarIsNaN(ROI_L[b_L - 1])) {
        idx = b_L;
        exitg1 = true;
      } else {
        b_L++;
      }
    }
  }

  if (idx == 0) {
    ex = ROI_L[0];
  } else {
    ex = ROI_L[idx - 1];
    b_bw = idx + 1;
    for (b_L = b_bw; b_L < 28; b_L++) {
      d = ROI_L[b_L - 1];
      if (ex < d) {
        ex = d;
      }
    }
  }

  emxInit_int8_T(sp, &c, 1, &yj_emlrtRTEI, true);
  emxInit_int8_T(sp, &b_c, 1, &yj_emlrtRTEI, true);
  if (TF1 || (ex == *Num)) {
    st.site = &od_emlrtRSI;
    b_st.site = &cd_emlrtRSI;
    c_st.site = &dd_emlrtRSI;
    idx = 0;
    b_bw = 0;
    exitg1 = false;
    while ((!exitg1) && (b_bw < 27)) {
      if (ROI_bw[b_bw]) {
        idx++;
        ii_data[idx - 1] = (int8_T)(b_bw + 1);
        if (idx >= 27) {
          exitg1 = true;
        } else {
          b_bw++;
        }
      } else {
        b_bw++;
      }
    }

    if (1 > idx) {
      idx = 0;
    }

    iv[0] = 1;
    iv[1] = idx;
    d_st.site = &fd_emlrtRSI;
    indexShapeCheck(&d_st, 27, iv);
    st.site = &od_emlrtRSI;
    b_st.site = &hd_emlrtRSI;
    for (i = 0; i < idx; i++) {
      ii_data[i]--;
    }

    i = c->size[0];
    c->size[0] = idx;
    emxEnsureCapacity_int8_T(&b_st, c, i, &xj_emlrtRTEI);
    for (i = 0; i < idx; i++) {
      c->data[i] = (int8_T)(ii_data[i] / 9);
    }

    for (i = 0; i < idx; i++) {
      ii_data[i] -= (int8_T)(ii_data[i] / 9 * 9);
    }

    i = b_c->size[0];
    b_c->size[0] = idx;
    emxEnsureCapacity_int8_T(&b_st, b_c, i, &xj_emlrtRTEI);
    for (i = 0; i < idx; i++) {
      b_c->data[i] = (int8_T)(ii_data[i] / 3);
    }

    for (i = 0; i < idx; i++) {
      ii_data[i] -= (int8_T)(ii_data[i] / 3 * 3);
    }

    for (i = 0; i < idx; i++) {
      y1_data[i] = (real_T)ii_data[i] + 1.0;
    }

    if (idx != 0) {
      for (i = 0; i < idx; i++) {
        y1_data[i] = (yxz_data[0] + y1_data[i]) - 2.0;
      }

      c_bw = b_c->size[0];
      b_bw = b_c->size[0];
      for (i = 0; i < b_bw; i++) {
        x1_data[i] = (yxz_data[1] + ((real_T)b_c->data[i] + 1.0)) - 2.0;
      }

      d_ROI_bw_tmp = c->size[0];
      b_bw = c->size[0];
      for (i = 0; i < b_bw; i++) {
        z1_data[i] = (yxz_data[2] + ((real_T)c->data[i] + 1.0)) - 2.0;
      }

      for (b_L = 0; b_L < idx; b_L++) {
        i = b_L + 1;
        if (i > idx) {
          emlrtDynamicBoundsCheckR2012b(i, 1, idx, &ok_emlrtBCI, sp);
        }

        b_y[0] = y1_data[i - 1];
        i = b_L + 1;
        if (i > c_bw) {
          emlrtDynamicBoundsCheckR2012b(i, 1, c_bw, &pk_emlrtBCI, sp);
        }

        b_y[1] = x1_data[i - 1];
        i = b_L + 1;
        if (i > d_ROI_bw_tmp) {
          emlrtDynamicBoundsCheckR2012b(i, 1, d_ROI_bw_tmp, &qk_emlrtBCI, sp);
        }

        b_y[2] = z1_data[i - 1];
        st.site = &pd_emlrtRSI;
        d_Labeling(&st, b_y, bw, L, Num);
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(sp);
        }
      }
    }
  } else {
    y = NULL;
    m = emlrtCreateDoubleScalar(*Num);
    emlrtAssign(&y, m);
    st.site = &tn_emlrtRSI;
    disp(&st, y, &emlrtMCI);
    (*Num)++;
  }

  emxFree_int8_T(&b_c);
  emxFree_int8_T(&c);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

static void d_Labeling(const emlrtStack *sp, const real_T yxz[3],
  emxArray_boolean_T *bw, emxArray_real_T *L, real_T *Num)
{
  real_T ROI_bw_tmp[3];
  real_T b_ROI_bw_tmp[3];
  real_T c_ROI_bw_tmp[3];
  int32_T b_bw;
  int32_T idx;
  int32_T c_bw;
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T i3;
  int32_T i4;
  int32_T b_L;
  int32_T i5;
  int32_T i6;
  int32_T d_ROI_bw_tmp;
  real_T ROI_L[27];
  boolean_T ROI_bw[27];
  boolean_T TF1;
  boolean_T exitg1;
  real_T ex;
  real_T d;
  emxArray_int8_T *c;
  emxArray_int8_T *b_c;
  const mxArray *y;
  const mxArray *m;
  int32_T iv[2];
  int8_T ii_data[27];
  real_T y1_data[27];
  real_T x1_data[27];
  real_T z1_data[27];
  real_T b_y[3];
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
  if (*emlrtBreakCheckR2012bFlagVar != 0) {
    emlrtBreakCheckR2012b(sp);
  }

  ROI_bw_tmp[0] = yxz[0] + -1.0;
  b_ROI_bw_tmp[0] = yxz[1] + -1.0;
  c_ROI_bw_tmp[0] = yxz[2] + -1.0;
  ROI_bw_tmp[1] = yxz[0];
  b_ROI_bw_tmp[1] = yxz[1];
  c_ROI_bw_tmp[1] = yxz[2];
  ROI_bw_tmp[2] = yxz[0] + 1.0;
  b_ROI_bw_tmp[2] = yxz[1] + 1.0;
  c_ROI_bw_tmp[2] = yxz[2] + 1.0;
  b_bw = bw->size[0];
  idx = bw->size[1];
  c_bw = bw->size[2];
  i = (int32_T)ROI_bw_tmp[0];
  i1 = (int32_T)ROI_bw_tmp[1];
  i2 = (int32_T)ROI_bw_tmp[2];
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)c_ROI_bw_tmp[i3];
    for (i5 = 0; i5 < 3; i5++) {
      if ((i < 1) || (i > b_bw)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, b_bw, &al_emlrtBCI, sp);
      }

      i6 = (int32_T)b_ROI_bw_tmp[i5];
      if ((i6 < 1) || (i6 > idx)) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, idx, &bl_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > c_bw)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, c_bw, &cl_emlrtBCI, sp);
      }

      d_ROI_bw_tmp = 3 * i5 + 9 * i3;
      ROI_bw[d_ROI_bw_tmp] = bw->data[((i + bw->size[0] * (i6 - 1)) + bw->size[0]
        * bw->size[1] * (i4 - 1)) - 1];
      if ((i1 < 1) || (i1 > b_bw)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, b_bw, &al_emlrtBCI, sp);
      }

      if (i6 > idx) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, idx, &bl_emlrtBCI, sp);
      }

      if (i4 > c_bw) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, c_bw, &cl_emlrtBCI, sp);
      }

      ROI_bw[d_ROI_bw_tmp + 1] = bw->data[((i1 + bw->size[0] * (i6 - 1)) +
        bw->size[0] * bw->size[1] * (i4 - 1)) - 1];
      if ((i2 < 1) || (i2 > b_bw)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, b_bw, &al_emlrtBCI, sp);
      }

      if (i6 > idx) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, idx, &bl_emlrtBCI, sp);
      }

      if (i4 > c_bw) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, c_bw, &cl_emlrtBCI, sp);
      }

      ROI_bw[d_ROI_bw_tmp + 2] = bw->data[((i2 + bw->size[0] * (i6 - 1)) +
        bw->size[0] * bw->size[1] * (i4 - 1)) - 1];
    }
  }

  idx = L->size[0];
  b_L = L->size[1];
  b_bw = L->size[2];
  i = (int32_T)ROI_bw_tmp[0];
  i1 = (int32_T)ROI_bw_tmp[1];
  i2 = (int32_T)ROI_bw_tmp[2];
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)c_ROI_bw_tmp[i3];
    for (i5 = 0; i5 < 3; i5++) {
      if ((i < 1) || (i > idx)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, idx, &dl_emlrtBCI, sp);
      }

      i6 = (int32_T)b_ROI_bw_tmp[i5];
      if ((i6 < 1) || (i6 > b_L)) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, b_L, &el_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > b_bw)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, b_bw, &fl_emlrtBCI, sp);
      }

      c_bw = 3 * i5 + 9 * i3;
      ROI_L[c_bw] = L->data[((i + L->size[0] * (i6 - 1)) + L->size[0] * L->size
        [1] * (i4 - 1)) - 1];
      if ((i1 < 1) || (i1 > idx)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, idx, &dl_emlrtBCI, sp);
      }

      if (i6 > b_L) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, b_L, &el_emlrtBCI, sp);
      }

      if (i4 > b_bw) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, b_bw, &fl_emlrtBCI, sp);
      }

      ROI_L[c_bw + 1] = L->data[((i1 + L->size[0] * (i6 - 1)) + L->size[0] *
        L->size[1] * (i4 - 1)) - 1];
      if ((i2 < 1) || (i2 > idx)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, idx, &dl_emlrtBCI, sp);
      }

      if (i6 > b_L) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, b_L, &el_emlrtBCI, sp);
      }

      if (i4 > b_bw) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, b_bw, &fl_emlrtBCI, sp);
      }

      ROI_L[c_bw + 2] = L->data[((i2 + L->size[0] * (i6 - 1)) + L->size[0] *
        L->size[1] * (i4 - 1)) - 1];
    }
  }

  for (b_bw = 0; b_bw < 27; b_bw++) {
    if (bw->data[(((int32_T)ROI_bw_tmp[b_bw % 3] + bw->size[0] * ((int32_T)
           b_ROI_bw_tmp[b_bw / 3 % 3] - 1)) + bw->size[0] * bw->size[1] *
                  ((int32_T)c_ROI_bw_tmp[b_bw / 9] - 1)) - 1]) {
      ROI_L[b_bw] = *Num;
    }
  }

  i = L->size[0];
  i1 = L->size[1];
  i2 = L->size[2];
  i3 = (int32_T)ROI_bw_tmp[0];
  i4 = (int32_T)ROI_bw_tmp[1];
  i5 = (int32_T)ROI_bw_tmp[2];
  for (i6 = 0; i6 < 3; i6++) {
    idx = (int32_T)c_ROI_bw_tmp[i6];
    for (b_bw = 0; b_bw < 3; b_bw++) {
      if ((i3 < 1) || (i3 > i)) {
        emlrtDynamicBoundsCheckR2012b(i3, 1, i, &gl_emlrtBCI, sp);
      }

      c_bw = (int32_T)b_ROI_bw_tmp[b_bw];
      if ((c_bw < 1) || (c_bw > i1)) {
        emlrtDynamicBoundsCheckR2012b(c_bw, 1, i1, &gl_emlrtBCI, sp);
      }

      if ((idx < 1) || (idx > i2)) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, i2, &gl_emlrtBCI, sp);
      }

      d_ROI_bw_tmp = 3 * b_bw + 9 * i6;
      L->data[((i3 + L->size[0] * (c_bw - 1)) + L->size[0] * L->size[1] * (idx -
                1)) - 1] = ROI_L[d_ROI_bw_tmp];
      if ((i4 < 1) || (i4 > i)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, i, &gl_emlrtBCI, sp);
      }

      if (c_bw > i1) {
        emlrtDynamicBoundsCheckR2012b(c_bw, 1, i1, &gl_emlrtBCI, sp);
      }

      if (idx > i2) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, i2, &gl_emlrtBCI, sp);
      }

      L->data[((i4 + L->size[0] * (c_bw - 1)) + L->size[0] * L->size[1] * (idx -
                1)) - 1] = ROI_L[d_ROI_bw_tmp + 1];
      if ((i5 < 1) || (i5 > i)) {
        emlrtDynamicBoundsCheckR2012b(i5, 1, i, &gl_emlrtBCI, sp);
      }

      if (c_bw > i1) {
        emlrtDynamicBoundsCheckR2012b(c_bw, 1, i1, &gl_emlrtBCI, sp);
      }

      if (idx > i2) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, i2, &gl_emlrtBCI, sp);
      }

      L->data[((i5 + L->size[0] * (c_bw - 1)) + L->size[0] * L->size[1] * (idx -
                1)) - 1] = ROI_L[d_ROI_bw_tmp + 2];
    }
  }

  i = bw->size[0];
  i1 = (int32_T)yxz[0];
  if ((i1 < 1) || (i1 > i)) {
    emlrtDynamicBoundsCheckR2012b(i1, 1, i, &yk_emlrtBCI, sp);
  }

  i = bw->size[1];
  i2 = (int32_T)yxz[1];
  if ((i2 < 1) || (i2 > i)) {
    emlrtDynamicBoundsCheckR2012b(i2, 1, i, &yk_emlrtBCI, sp);
  }

  i = bw->size[2];
  i3 = (int32_T)yxz[2];
  if ((i3 < 1) || (i3 > i)) {
    emlrtDynamicBoundsCheckR2012b(i3, 1, i, &yk_emlrtBCI, sp);
  }

  bw->data[((i1 + bw->size[0] * (i2 - 1)) + bw->size[0] * bw->size[1] * (i3 - 1))
    - 1] = false;
  ROI_bw[13] = false;
  TF1 = ROI_bw[0];
  for (b_L = 0; b_L < 26; b_L++) {
    TF1 = (((int32_T)TF1 < (int32_T)ROI_bw[b_L + 1]) || TF1);
  }

  st.site = &nd_emlrtRSI;
  b_st.site = &qd_emlrtRSI;
  c_st.site = &rd_emlrtRSI;
  if (!muDoubleScalarIsNaN(ROI_L[0])) {
    idx = 1;
  } else {
    idx = 0;
    b_L = 2;
    exitg1 = false;
    while ((!exitg1) && (b_L <= 27)) {
      if (!muDoubleScalarIsNaN(ROI_L[b_L - 1])) {
        idx = b_L;
        exitg1 = true;
      } else {
        b_L++;
      }
    }
  }

  if (idx == 0) {
    ex = ROI_L[0];
  } else {
    ex = ROI_L[idx - 1];
    b_bw = idx + 1;
    for (b_L = b_bw; b_L < 28; b_L++) {
      d = ROI_L[b_L - 1];
      if (ex < d) {
        ex = d;
      }
    }
  }

  emxInit_int8_T(sp, &c, 1, &yj_emlrtRTEI, true);
  emxInit_int8_T(sp, &b_c, 1, &yj_emlrtRTEI, true);
  if (TF1 || (ex == *Num)) {
    st.site = &od_emlrtRSI;
    b_st.site = &cd_emlrtRSI;
    c_st.site = &dd_emlrtRSI;
    idx = 0;
    b_bw = 0;
    exitg1 = false;
    while ((!exitg1) && (b_bw < 27)) {
      if (ROI_bw[b_bw]) {
        idx++;
        ii_data[idx - 1] = (int8_T)(b_bw + 1);
        if (idx >= 27) {
          exitg1 = true;
        } else {
          b_bw++;
        }
      } else {
        b_bw++;
      }
    }

    if (1 > idx) {
      idx = 0;
    }

    iv[0] = 1;
    iv[1] = idx;
    d_st.site = &fd_emlrtRSI;
    indexShapeCheck(&d_st, 27, iv);
    st.site = &od_emlrtRSI;
    b_st.site = &hd_emlrtRSI;
    for (i = 0; i < idx; i++) {
      ii_data[i]--;
    }

    i = c->size[0];
    c->size[0] = idx;
    emxEnsureCapacity_int8_T(&b_st, c, i, &xj_emlrtRTEI);
    for (i = 0; i < idx; i++) {
      c->data[i] = (int8_T)(ii_data[i] / 9);
    }

    for (i = 0; i < idx; i++) {
      ii_data[i] -= (int8_T)(ii_data[i] / 9 * 9);
    }

    i = b_c->size[0];
    b_c->size[0] = idx;
    emxEnsureCapacity_int8_T(&b_st, b_c, i, &xj_emlrtRTEI);
    for (i = 0; i < idx; i++) {
      b_c->data[i] = (int8_T)(ii_data[i] / 3);
    }

    for (i = 0; i < idx; i++) {
      ii_data[i] -= (int8_T)(ii_data[i] / 3 * 3);
    }

    for (i = 0; i < idx; i++) {
      y1_data[i] = (real_T)ii_data[i] + 1.0;
    }

    if (idx != 0) {
      for (i = 0; i < idx; i++) {
        y1_data[i] = (yxz[0] + y1_data[i]) - 2.0;
      }

      c_bw = b_c->size[0];
      b_bw = b_c->size[0];
      for (i = 0; i < b_bw; i++) {
        x1_data[i] = (yxz[1] + ((real_T)b_c->data[i] + 1.0)) - 2.0;
      }

      d_ROI_bw_tmp = c->size[0];
      b_bw = c->size[0];
      for (i = 0; i < b_bw; i++) {
        z1_data[i] = (yxz[2] + ((real_T)c->data[i] + 1.0)) - 2.0;
      }

      for (b_L = 0; b_L < idx; b_L++) {
        i = b_L + 1;
        if (i > idx) {
          emlrtDynamicBoundsCheckR2012b(i, 1, idx, &ok_emlrtBCI, sp);
        }

        b_y[0] = y1_data[i - 1];
        i = b_L + 1;
        if (i > c_bw) {
          emlrtDynamicBoundsCheckR2012b(i, 1, c_bw, &pk_emlrtBCI, sp);
        }

        b_y[1] = x1_data[i - 1];
        i = b_L + 1;
        if (i > d_ROI_bw_tmp) {
          emlrtDynamicBoundsCheckR2012b(i, 1, d_ROI_bw_tmp, &qk_emlrtBCI, sp);
        }

        b_y[2] = z1_data[i - 1];
        st.site = &pd_emlrtRSI;
        d_Labeling(&st, b_y, bw, L, Num);
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(sp);
        }
      }
    }
  } else {
    y = NULL;
    m = emlrtCreateDoubleScalar(*Num);
    emlrtAssign(&y, m);
    st.site = &tn_emlrtRSI;
    disp(&st, y, &emlrtMCI);
    (*Num)++;
  }

  emxFree_int8_T(&b_c);
  emxFree_int8_T(&c);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

static void e_Labeling(const emlrtStack *sp, const real_T yxz_data[], boolean_T
  bw[343], real_T L[343], real_T *Num)
{
  real_T d;
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T i3;
  int32_T i4;
  int32_T idx;
  int32_T i5;
  int32_T ROI_bw_tmp;
  int32_T i6;
  int32_T ROI_L_tmp;
  real_T ROI_L[27];
  int32_T b_ROI_bw_tmp;
  boolean_T ROI_bw[27];
  boolean_T TF1;
  boolean_T exitg1;
  real_T ex;
  const mxArray *y;
  const mxArray *m;
  int32_T ii_data[27];
  int32_T iv[2];
  int32_T y1_size[1];
  int32_T ii_size[1];
  int32_T varargout_5_data[27];
  int32_T varargout_5_size[1];
  int32_T varargout_6_data[27];
  int32_T varargout_6_size[1];
  real_T x1_data[27];
  real_T z1_data[27];
  real_T b_y[3];
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
  d = yxz_data[0];
  i = (int32_T)(d + -1.0);
  i1 = (int32_T)d;
  i2 = (int32_T)(d + 1.0);
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)(yxz_data[2] + ((real_T)i3 + -1.0));
    idx = 49 * (i4 - 1);
    for (i5 = 0; i5 < 3; i5++) {
      if ((i < 1) || (i > 7)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 7, &il_emlrtBCI, sp);
      }

      i6 = (int32_T)(yxz_data[1] + ((real_T)i5 + -1.0));
      if ((i6 < 1) || (i6 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, 7, &jl_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 7, &kl_emlrtBCI, sp);
      }

      b_ROI_bw_tmp = 3 * i5 + 9 * i3;
      ROI_bw_tmp = 7 * (i6 - 1);
      ROI_bw[b_ROI_bw_tmp] = bw[((i + ROI_bw_tmp) + idx) - 1];
      if ((i1 < 1) || (i1 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 7, &il_emlrtBCI, sp);
      }

      ROI_bw[b_ROI_bw_tmp + 1] = bw[((i1 + ROI_bw_tmp) + idx) - 1];
      if ((i2 < 1) || (i2 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 7, &il_emlrtBCI, sp);
      }

      ROI_bw[b_ROI_bw_tmp + 2] = bw[((i2 + ROI_bw_tmp) + idx) - 1];
    }
  }

  d = yxz_data[0];
  i = (int32_T)(d + -1.0);
  i1 = (int32_T)d;
  i2 = (int32_T)(d + 1.0);
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)(yxz_data[2] + ((real_T)i3 + -1.0));
    ROI_L_tmp = 49 * (i4 - 1);
    for (i5 = 0; i5 < 3; i5++) {
      if ((i < 1) || (i > 7)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 7, &ll_emlrtBCI, sp);
      }

      i6 = (int32_T)(yxz_data[1] + ((real_T)i5 + -1.0));
      if ((i6 < 1) || (i6 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, 7, &ml_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 7, &nl_emlrtBCI, sp);
      }

      ROI_bw_tmp = 3 * i5 + 9 * i3;
      idx = 7 * (i6 - 1);
      ROI_L[ROI_bw_tmp] = L[((i + idx) + ROI_L_tmp) - 1];
      if ((i1 < 1) || (i1 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 7, &ll_emlrtBCI, sp);
      }

      ROI_L[ROI_bw_tmp + 1] = L[((i1 + idx) + ROI_L_tmp) - 1];
      if ((i2 < 1) || (i2 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 7, &ll_emlrtBCI, sp);
      }

      ROI_L[ROI_bw_tmp + 2] = L[((i2 + idx) + ROI_L_tmp) - 1];
    }
  }

  for (ROI_bw_tmp = 0; ROI_bw_tmp < 27; ROI_bw_tmp++) {
    if (bw[(((int32_T)(yxz_data[0] + ((real_T)(ROI_bw_tmp % 3) + -1.0)) + 7 *
             ((int32_T)(yxz_data[1] + ((real_T)(ROI_bw_tmp / 3 % 3) + -1.0)) - 1))
            + 49 * ((int32_T)(yxz_data[2] + ((real_T)(ROI_bw_tmp / 9) + -1.0)) -
                    1)) - 1]) {
      ROI_L[ROI_bw_tmp] = *Num;
    }
  }

  d = yxz_data[0];
  i = (int32_T)(d + -1.0);
  i1 = (int32_T)d;
  i2 = (int32_T)(d + 1.0);
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)(yxz_data[2] + ((real_T)i3 + -1.0));
    i5 = 49 * (i4 - 1);
    for (i6 = 0; i6 < 3; i6++) {
      if ((i < 1) || (i > 7)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 7, &ol_emlrtBCI, sp);
      }

      idx = (int32_T)(yxz_data[1] + ((real_T)i6 + -1.0));
      if ((idx < 1) || (idx > 7)) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, 7, &ol_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 7, &ol_emlrtBCI, sp);
      }

      b_ROI_bw_tmp = 3 * i6 + 9 * i3;
      idx = 7 * (idx - 1);
      L[((i + idx) + i5) - 1] = ROI_L[b_ROI_bw_tmp];
      if ((i1 < 1) || (i1 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 7, &ol_emlrtBCI, sp);
      }

      L[((i1 + idx) + i5) - 1] = ROI_L[b_ROI_bw_tmp + 1];
      if ((i2 < 1) || (i2 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 7, &ol_emlrtBCI, sp);
      }

      L[((i2 + idx) + i5) - 1] = ROI_L[b_ROI_bw_tmp + 2];
    }
  }

  i = (int32_T)yxz_data[0];
  if ((i < 1) || (i > 7)) {
    emlrtDynamicBoundsCheckR2012b(i, 1, 7, &hl_emlrtBCI, sp);
  }

  i1 = (int32_T)yxz_data[1];
  if ((i1 < 1) || (i1 > 7)) {
    emlrtDynamicBoundsCheckR2012b(i1, 1, 7, &hl_emlrtBCI, sp);
  }

  i2 = (int32_T)yxz_data[2];
  if ((i2 < 1) || (i2 > 7)) {
    emlrtDynamicBoundsCheckR2012b(i2, 1, 7, &hl_emlrtBCI, sp);
  }

  bw[((i + 7 * (i1 - 1)) + 49 * (i2 - 1)) - 1] = false;
  ROI_bw[13] = false;
  TF1 = ROI_bw[0];
  for (ROI_L_tmp = 0; ROI_L_tmp < 26; ROI_L_tmp++) {
    TF1 = (((int32_T)TF1 < (int32_T)ROI_bw[ROI_L_tmp + 1]) || TF1);
  }

  st.site = &nd_emlrtRSI;
  b_st.site = &qd_emlrtRSI;
  c_st.site = &rd_emlrtRSI;
  if (!muDoubleScalarIsNaN(ROI_L[0])) {
    idx = 1;
  } else {
    idx = 0;
    ROI_L_tmp = 2;
    exitg1 = false;
    while ((!exitg1) && (ROI_L_tmp <= 27)) {
      if (!muDoubleScalarIsNaN(ROI_L[ROI_L_tmp - 1])) {
        idx = ROI_L_tmp;
        exitg1 = true;
      } else {
        ROI_L_tmp++;
      }
    }
  }

  if (idx == 0) {
    ex = ROI_L[0];
  } else {
    ex = ROI_L[idx - 1];
    ROI_bw_tmp = idx + 1;
    for (ROI_L_tmp = ROI_bw_tmp; ROI_L_tmp < 28; ROI_L_tmp++) {
      d = ROI_L[ROI_L_tmp - 1];
      if (ex < d) {
        ex = d;
      }
    }
  }

  if (TF1 || (ex == *Num)) {
    st.site = &od_emlrtRSI;
    b_st.site = &cd_emlrtRSI;
    c_st.site = &dd_emlrtRSI;
    idx = 0;
    ROI_bw_tmp = 0;
    exitg1 = false;
    while ((!exitg1) && (ROI_bw_tmp < 27)) {
      if (ROI_bw[ROI_bw_tmp]) {
        idx++;
        ii_data[idx - 1] = ROI_bw_tmp + 1;
        if (idx >= 27) {
          exitg1 = true;
        } else {
          ROI_bw_tmp++;
        }
      } else {
        ROI_bw_tmp++;
      }
    }

    if (1 > idx) {
      ROI_bw_tmp = 0;
    } else {
      ROI_bw_tmp = idx;
    }

    iv[0] = 1;
    iv[1] = ROI_bw_tmp;
    d_st.site = &fd_emlrtRSI;
    indexShapeCheck(&d_st, 27, iv);
    st.site = &od_emlrtRSI;
    y1_size[0] = ROI_bw_tmp;
    for (i = 0; i < ROI_bw_tmp; i++) {
      ROI_L[i] = ii_data[i];
    }

    b_st.site = &hd_emlrtRSI;
    b_ind2sub_indexClass(&b_st, ROI_L, y1_size, ii_data, ii_size,
                         varargout_5_data, varargout_5_size, varargout_6_data,
                         varargout_6_size);
    y1_size[0] = ii_size[0];
    ROI_bw_tmp = ii_size[0];
    for (i = 0; i < ROI_bw_tmp; i++) {
      ROI_L[i] = ii_data[i];
    }

    if (ii_size[0] != 0) {
      ROI_bw_tmp = ii_size[0];
      for (i = 0; i < ROI_bw_tmp; i++) {
        ROI_L[i] = (yxz_data[0] + ROI_L[i]) - 2.0;
      }

      idx = varargout_5_size[0];
      ROI_bw_tmp = varargout_5_size[0];
      for (i = 0; i < ROI_bw_tmp; i++) {
        x1_data[i] = (yxz_data[1] + (real_T)varargout_5_data[i]) - 2.0;
      }

      b_ROI_bw_tmp = varargout_6_size[0];
      ROI_bw_tmp = varargout_6_size[0];
      for (i = 0; i < ROI_bw_tmp; i++) {
        z1_data[i] = (yxz_data[2] + (real_T)varargout_6_data[i]) - 2.0;
      }

      i = ii_size[0];
      for (ROI_L_tmp = 0; ROI_L_tmp < i; ROI_L_tmp++) {
        i1 = ROI_L_tmp + 1;
        if ((i1 < 1) || (i1 > y1_size[0])) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, y1_size[0], &ok_emlrtBCI, sp);
        }

        b_y[0] = ROI_L[i1 - 1];
        i1 = ROI_L_tmp + 1;
        if ((i1 < 1) || (i1 > idx)) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, idx, &pk_emlrtBCI, sp);
        }

        b_y[1] = x1_data[i1 - 1];
        i1 = ROI_L_tmp + 1;
        if ((i1 < 1) || (i1 > b_ROI_bw_tmp)) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, b_ROI_bw_tmp, &qk_emlrtBCI, sp);
        }

        b_y[2] = z1_data[i1 - 1];
        st.site = &pd_emlrtRSI;
        f_Labeling(&st, b_y, bw, L, Num);
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(sp);
        }
      }
    }
  } else {
    y = NULL;
    m = emlrtCreateDoubleScalar(*Num);
    emlrtAssign(&y, m);
    st.site = &tn_emlrtRSI;
    disp(&st, y, &emlrtMCI);
    (*Num)++;
  }
}

static void f_Labeling(const emlrtStack *sp, const real_T yxz[3], boolean_T bw
  [343], real_T L[343], real_T *Num)
{
  real_T d;
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T i3;
  int32_T i4;
  int32_T idx;
  int32_T i5;
  int32_T ROI_bw_tmp;
  int32_T i6;
  int32_T ROI_L_tmp;
  real_T ROI_L[27];
  int32_T b_ROI_bw_tmp;
  boolean_T ROI_bw[27];
  boolean_T TF1;
  boolean_T exitg1;
  real_T ex;
  const mxArray *y;
  const mxArray *m;
  int32_T ii_data[27];
  int32_T iv[2];
  int32_T y1_size[1];
  int32_T ii_size[1];
  int32_T varargout_5_data[27];
  int32_T varargout_5_size[1];
  int32_T varargout_6_data[27];
  int32_T varargout_6_size[1];
  real_T x1_data[27];
  real_T z1_data[27];
  real_T b_y[3];
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
  if (*emlrtBreakCheckR2012bFlagVar != 0) {
    emlrtBreakCheckR2012b(sp);
  }

  d = yxz[0];
  i = (int32_T)(d + -1.0);
  i1 = (int32_T)d;
  i2 = (int32_T)(d + 1.0);
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)(yxz[2] + ((real_T)i3 + -1.0));
    idx = 49 * (i4 - 1);
    for (i5 = 0; i5 < 3; i5++) {
      if ((i < 1) || (i > 7)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 7, &il_emlrtBCI, sp);
      }

      i6 = (int32_T)(yxz[1] + ((real_T)i5 + -1.0));
      if ((i6 < 1) || (i6 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, 7, &jl_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 7, &kl_emlrtBCI, sp);
      }

      b_ROI_bw_tmp = 3 * i5 + 9 * i3;
      ROI_bw_tmp = 7 * (i6 - 1);
      ROI_bw[b_ROI_bw_tmp] = bw[((i + ROI_bw_tmp) + idx) - 1];
      if ((i1 < 1) || (i1 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 7, &il_emlrtBCI, sp);
      }

      ROI_bw[b_ROI_bw_tmp + 1] = bw[((i1 + ROI_bw_tmp) + idx) - 1];
      if ((i2 < 1) || (i2 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 7, &il_emlrtBCI, sp);
      }

      ROI_bw[b_ROI_bw_tmp + 2] = bw[((i2 + ROI_bw_tmp) + idx) - 1];
    }
  }

  d = yxz[0];
  i = (int32_T)(d + -1.0);
  i1 = (int32_T)d;
  i2 = (int32_T)(d + 1.0);
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)(yxz[2] + ((real_T)i3 + -1.0));
    ROI_L_tmp = 49 * (i4 - 1);
    for (i5 = 0; i5 < 3; i5++) {
      if ((i < 1) || (i > 7)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 7, &ll_emlrtBCI, sp);
      }

      i6 = (int32_T)(yxz[1] + ((real_T)i5 + -1.0));
      if ((i6 < 1) || (i6 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, 7, &ml_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 7, &nl_emlrtBCI, sp);
      }

      ROI_bw_tmp = 3 * i5 + 9 * i3;
      idx = 7 * (i6 - 1);
      ROI_L[ROI_bw_tmp] = L[((i + idx) + ROI_L_tmp) - 1];
      if ((i1 < 1) || (i1 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 7, &ll_emlrtBCI, sp);
      }

      ROI_L[ROI_bw_tmp + 1] = L[((i1 + idx) + ROI_L_tmp) - 1];
      if ((i2 < 1) || (i2 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 7, &ll_emlrtBCI, sp);
      }

      ROI_L[ROI_bw_tmp + 2] = L[((i2 + idx) + ROI_L_tmp) - 1];
    }
  }

  for (ROI_bw_tmp = 0; ROI_bw_tmp < 27; ROI_bw_tmp++) {
    if (bw[(((int32_T)(yxz[0] + ((real_T)(ROI_bw_tmp % 3) + -1.0)) + 7 *
             ((int32_T)(yxz[1] + ((real_T)(ROI_bw_tmp / 3 % 3) + -1.0)) - 1)) +
            49 * ((int32_T)(yxz[2] + ((real_T)(ROI_bw_tmp / 9) + -1.0)) - 1)) -
        1]) {
      ROI_L[ROI_bw_tmp] = *Num;
    }
  }

  d = yxz[0];
  i = (int32_T)(d + -1.0);
  i1 = (int32_T)d;
  i2 = (int32_T)(d + 1.0);
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)(yxz[2] + ((real_T)i3 + -1.0));
    i5 = 49 * (i4 - 1);
    for (i6 = 0; i6 < 3; i6++) {
      if ((i < 1) || (i > 7)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 7, &ol_emlrtBCI, sp);
      }

      idx = (int32_T)(yxz[1] + ((real_T)i6 + -1.0));
      if ((idx < 1) || (idx > 7)) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, 7, &ol_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 7, &ol_emlrtBCI, sp);
      }

      b_ROI_bw_tmp = 3 * i6 + 9 * i3;
      idx = 7 * (idx - 1);
      L[((i + idx) + i5) - 1] = ROI_L[b_ROI_bw_tmp];
      if ((i1 < 1) || (i1 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 7, &ol_emlrtBCI, sp);
      }

      L[((i1 + idx) + i5) - 1] = ROI_L[b_ROI_bw_tmp + 1];
      if ((i2 < 1) || (i2 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 7, &ol_emlrtBCI, sp);
      }

      L[((i2 + idx) + i5) - 1] = ROI_L[b_ROI_bw_tmp + 2];
    }
  }

  i = (int32_T)yxz[0];
  if ((i < 1) || (i > 7)) {
    emlrtDynamicBoundsCheckR2012b(i, 1, 7, &hl_emlrtBCI, sp);
  }

  i1 = (int32_T)yxz[1];
  if ((i1 < 1) || (i1 > 7)) {
    emlrtDynamicBoundsCheckR2012b(i1, 1, 7, &hl_emlrtBCI, sp);
  }

  i2 = (int32_T)yxz[2];
  if ((i2 < 1) || (i2 > 7)) {
    emlrtDynamicBoundsCheckR2012b(i2, 1, 7, &hl_emlrtBCI, sp);
  }

  bw[((i + 7 * (i1 - 1)) + 49 * (i2 - 1)) - 1] = false;
  ROI_bw[13] = false;
  TF1 = ROI_bw[0];
  for (ROI_L_tmp = 0; ROI_L_tmp < 26; ROI_L_tmp++) {
    TF1 = (((int32_T)TF1 < (int32_T)ROI_bw[ROI_L_tmp + 1]) || TF1);
  }

  st.site = &nd_emlrtRSI;
  b_st.site = &qd_emlrtRSI;
  c_st.site = &rd_emlrtRSI;
  if (!muDoubleScalarIsNaN(ROI_L[0])) {
    idx = 1;
  } else {
    idx = 0;
    ROI_L_tmp = 2;
    exitg1 = false;
    while ((!exitg1) && (ROI_L_tmp <= 27)) {
      if (!muDoubleScalarIsNaN(ROI_L[ROI_L_tmp - 1])) {
        idx = ROI_L_tmp;
        exitg1 = true;
      } else {
        ROI_L_tmp++;
      }
    }
  }

  if (idx == 0) {
    ex = ROI_L[0];
  } else {
    ex = ROI_L[idx - 1];
    ROI_bw_tmp = idx + 1;
    for (ROI_L_tmp = ROI_bw_tmp; ROI_L_tmp < 28; ROI_L_tmp++) {
      d = ROI_L[ROI_L_tmp - 1];
      if (ex < d) {
        ex = d;
      }
    }
  }

  if (TF1 || (ex == *Num)) {
    st.site = &od_emlrtRSI;
    b_st.site = &cd_emlrtRSI;
    c_st.site = &dd_emlrtRSI;
    idx = 0;
    ROI_bw_tmp = 0;
    exitg1 = false;
    while ((!exitg1) && (ROI_bw_tmp < 27)) {
      if (ROI_bw[ROI_bw_tmp]) {
        idx++;
        ii_data[idx - 1] = ROI_bw_tmp + 1;
        if (idx >= 27) {
          exitg1 = true;
        } else {
          ROI_bw_tmp++;
        }
      } else {
        ROI_bw_tmp++;
      }
    }

    if (1 > idx) {
      ROI_bw_tmp = 0;
    } else {
      ROI_bw_tmp = idx;
    }

    iv[0] = 1;
    iv[1] = ROI_bw_tmp;
    d_st.site = &fd_emlrtRSI;
    indexShapeCheck(&d_st, 27, iv);
    st.site = &od_emlrtRSI;
    y1_size[0] = ROI_bw_tmp;
    for (i = 0; i < ROI_bw_tmp; i++) {
      ROI_L[i] = ii_data[i];
    }

    b_st.site = &hd_emlrtRSI;
    b_ind2sub_indexClass(&b_st, ROI_L, y1_size, ii_data, ii_size,
                         varargout_5_data, varargout_5_size, varargout_6_data,
                         varargout_6_size);
    y1_size[0] = ii_size[0];
    ROI_bw_tmp = ii_size[0];
    for (i = 0; i < ROI_bw_tmp; i++) {
      ROI_L[i] = ii_data[i];
    }

    if (ii_size[0] != 0) {
      ROI_bw_tmp = ii_size[0];
      for (i = 0; i < ROI_bw_tmp; i++) {
        ROI_L[i] = (yxz[0] + ROI_L[i]) - 2.0;
      }

      idx = varargout_5_size[0];
      ROI_bw_tmp = varargout_5_size[0];
      for (i = 0; i < ROI_bw_tmp; i++) {
        x1_data[i] = (yxz[1] + (real_T)varargout_5_data[i]) - 2.0;
      }

      b_ROI_bw_tmp = varargout_6_size[0];
      ROI_bw_tmp = varargout_6_size[0];
      for (i = 0; i < ROI_bw_tmp; i++) {
        z1_data[i] = (yxz[2] + (real_T)varargout_6_data[i]) - 2.0;
      }

      i = ii_size[0];
      for (ROI_L_tmp = 0; ROI_L_tmp < i; ROI_L_tmp++) {
        i1 = ROI_L_tmp + 1;
        if ((i1 < 1) || (i1 > y1_size[0])) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, y1_size[0], &ok_emlrtBCI, sp);
        }

        b_y[0] = ROI_L[i1 - 1];
        i1 = ROI_L_tmp + 1;
        if ((i1 < 1) || (i1 > idx)) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, idx, &pk_emlrtBCI, sp);
        }

        b_y[1] = x1_data[i1 - 1];
        i1 = ROI_L_tmp + 1;
        if ((i1 < 1) || (i1 > b_ROI_bw_tmp)) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, b_ROI_bw_tmp, &qk_emlrtBCI, sp);
        }

        b_y[2] = z1_data[i1 - 1];
        st.site = &pd_emlrtRSI;
        f_Labeling(&st, b_y, bw, L, Num);
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(sp);
        }
      }
    }
  } else {
    y = NULL;
    m = emlrtCreateDoubleScalar(*Num);
    emlrtAssign(&y, m);
    st.site = &tn_emlrtRSI;
    disp(&st, y, &emlrtMCI);
    (*Num)++;
  }
}

void TS_bwlabeln3D26(const emlrtStack *sp, const emxArray_boolean_T *bw,
                     emxArray_real_T *L)
{
  int32_T istop;
  boolean_T maxval;
  int32_T k;
  emxArray_boolean_T *b_bw;
  uint32_T unnamed_idx_0;
  uint32_T unnamed_idx_1;
  uint32_T unnamed_idx_2;
  real_T Num;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack f_st;
  emlrtStack g_st;
  emlrtStack h_st;
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
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  st.site = &he_emlrtRSI;
  b_st.site = &qd_emlrtRSI;
  c_st.site = &rd_emlrtRSI;
  d_st.site = &sd_emlrtRSI;
  if (bw->size[0] * bw->size[1] * bw->size[2] < 1) {
    emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
      "Coder:toolbox:eml_min_or_max_varDimZero",
      "Coder:toolbox:eml_min_or_max_varDimZero", 0);
  }

  e_st.site = &ae_emlrtRSI;
  istop = bw->size[0] * bw->size[1] * bw->size[2];
  f_st.site = &be_emlrtRSI;
  maxval = bw->data[0];
  g_st.site = &ce_emlrtRSI;
  if ((2 <= bw->size[0] * bw->size[1] * bw->size[2]) && (bw->size[0] * bw->size
       [1] * bw->size[2] > 2147483646)) {
    h_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&h_st);
  }

  for (k = 2; k <= istop; k++) {
    if ((int32_T)maxval < (int32_T)bw->data[k - 1]) {
      maxval = bw->data[k - 1];
    }
  }

  if (!maxval) {
    unnamed_idx_0 = (uint32_T)bw->size[0];
    unnamed_idx_1 = (uint32_T)bw->size[1];
    unnamed_idx_2 = (uint32_T)bw->size[2];
    istop = L->size[0] * L->size[1] * L->size[2];
    L->size[0] = (int32_T)unnamed_idx_0;
    L->size[1] = (int32_T)unnamed_idx_1;
    L->size[2] = (int32_T)unnamed_idx_2;
    emxEnsureCapacity_real_T(sp, L, istop, &ie_emlrtRTEI);
    k = (int32_T)unnamed_idx_0 * (int32_T)unnamed_idx_1 * (int32_T)unnamed_idx_2;
    for (istop = 0; istop < k; istop++) {
      L->data[istop] = 0.0;
    }
  } else {
    emxInit_boolean_T(sp, &b_bw, 3, &he_emlrtRTEI, true);
    istop = b_bw->size[0] * b_bw->size[1] * b_bw->size[2];
    b_bw->size[0] = bw->size[0];
    b_bw->size[1] = bw->size[1];
    b_bw->size[2] = bw->size[2];
    emxEnsureCapacity_boolean_T(sp, b_bw, istop, &he_emlrtRTEI);
    k = bw->size[0] * bw->size[1] * bw->size[2] - 1;
    for (istop = 0; istop <= k; istop++) {
      b_bw->data[istop] = bw->data[istop];
    }

    st.site = &id_emlrtRSI;
    b_TS_bwlabeln_linux_c(&st, b_bw, L, &Num);
    emxFree_boolean_T(&b_bw);
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void TS_bwlabeln_linux_c(const emlrtStack *sp, const boolean_T bw[27], real_T L
  [27], real_T *Num)
{
  int32_T j;
  int32_T k;
  int32_T idx;
  real_T b_L[125];
  int32_T bw_tmp;
  boolean_T b_bw[125];
  boolean_T exitg1;
  emxArray_int16_T *b_idx;
  int8_T ii_data[1];
  emxArray_int8_T *vk;
  emxArray_int8_T *varargout_6;
  int32_T y_size[1];
  int32_T x_size[1];
  real_T y_data[1];
  int32_T z_size[1];
  real_T x_data[1];
  real_T z_data[1];
  emxArray_real_T *r;
  emxArray_real_T b_y_data;
  emxArray_real_T b_x_data;
  emxArray_real_T b_z_data;
  real_T preNum;
  real_T yxz_data[3];
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  for (j = 0; j < 5; j++) {
    for (idx = 0; idx < 5; idx++) {
      bw_tmp = idx + 5 * j;
      b_bw[bw_tmp] = false;
      b_bw[bw_tmp + 100] = false;
    }
  }

  for (k = 0; k < 3; k++) {
    for (idx = 0; idx < 5; idx++) {
      bw_tmp = idx + 25 * (k + 1);
      b_bw[bw_tmp] = false;
      b_bw[bw_tmp + 20] = false;
    }

    for (j = 0; j < 3; j++) {
      bw_tmp = 5 * (j + 1) + 25 * (k + 1);
      b_bw[bw_tmp] = false;
      b_bw[bw_tmp + 4] = false;
      idx = 3 * j + 9 * k;
      b_bw[bw_tmp + 1] = bw[idx];
      b_bw[bw_tmp + 2] = bw[idx + 1];
      b_bw[bw_tmp + 3] = bw[idx + 2];
    }
  }

  memset(&b_L[0], 0, 125U * sizeof(real_T));
  if (*emlrtBreakCheckR2012bFlagVar != 0) {
    emlrtBreakCheckR2012b(sp);
  }

  if (*emlrtBreakCheckR2012bFlagVar != 0) {
    emlrtBreakCheckR2012b(sp);
  }

  if (*emlrtBreakCheckR2012bFlagVar != 0) {
    emlrtBreakCheckR2012b(sp);
  }

  idx = 0;
  bw_tmp = 1;
  j = 0;
  exitg1 = false;
  while ((!exitg1) && (j < 125)) {
    if (b_bw[j]) {
      idx = 1;
      ii_data[0] = (int8_T)(j + 1);
      exitg1 = true;
    } else {
      j++;
    }
  }

  if (idx == 0) {
    bw_tmp = 0;
  }

  emxInit_int16_T(sp, &b_idx, 1, &ae_emlrtRTEI, true);
  st.site = &md_emlrtRSI;
  b_st.site = &hd_emlrtRSI;
  k = b_idx->size[0];
  b_idx->size[0] = bw_tmp;
  emxEnsureCapacity_int16_T(&b_st, b_idx, k, &ae_emlrtRTEI);
  for (k = 0; k < bw_tmp; k++) {
    b_idx->data[0] = ii_data[0];
  }

  idx = b_idx->size[0];
  for (k = 0; k < idx; k++) {
    b_idx->data[k]--;
  }

  emxInit_int8_T(&b_st, &vk, 1, &wc_emlrtRTEI, true);
  k = vk->size[0];
  vk->size[0] = b_idx->size[0];
  emxEnsureCapacity_int8_T(&b_st, vk, k, &wc_emlrtRTEI);
  idx = b_idx->size[0];
  for (k = 0; k < idx; k++) {
    vk->data[k] = (int8_T)(b_idx->data[k] / 25);
  }

  emxInit_int8_T(&b_st, &varargout_6, 1, &ce_emlrtRTEI, true);
  k = varargout_6->size[0];
  varargout_6->size[0] = vk->size[0];
  emxEnsureCapacity_int8_T(&b_st, varargout_6, k, &xc_emlrtRTEI);
  idx = vk->size[0];
  for (k = 0; k < idx; k++) {
    varargout_6->data[k] = (int8_T)(vk->data[k] + 1);
  }

  idx = b_idx->size[0];
  for (k = 0; k < idx; k++) {
    b_idx->data[k] = (int16_T)(b_idx->data[k] - vk->data[k] * 25);
  }

  k = vk->size[0];
  vk->size[0] = b_idx->size[0];
  emxEnsureCapacity_int8_T(&b_st, vk, k, &wc_emlrtRTEI);
  idx = b_idx->size[0];
  for (k = 0; k < idx; k++) {
    vk->data[k] = (int8_T)(b_idx->data[k] / 5);
  }

  idx = b_idx->size[0];
  for (k = 0; k < idx; k++) {
    b_idx->data[k] = (int16_T)(b_idx->data[k] - vk->data[k] * 5);
  }

  y_size[0] = b_idx->size[0];
  idx = b_idx->size[0];
  for (k = 0; k < idx; k++) {
    y_data[k] = (real_T)b_idx->data[k] + 1.0;
  }

  x_size[0] = vk->size[0];
  idx = vk->size[0];
  for (k = 0; k < idx; k++) {
    x_data[k] = (real_T)vk->data[k] + 1.0;
  }

  z_size[0] = varargout_6->size[0];
  idx = varargout_6->size[0];
  for (k = 0; k < idx; k++) {
    z_data[k] = varargout_6->data[k];
  }

  *Num = 1.0;
  emxInit_real_T(sp, &r, 2, &de_emlrtRTEI, true);
  while (y_size[0] != 0) {
    b_y_data.data = &y_data[0];
    b_y_data.size = &y_size[0];
    b_y_data.allocatedSize = 1;
    b_y_data.numDimensions = 1;
    b_y_data.canFreeData = false;
    b_x_data.data = &x_data[0];
    b_x_data.size = &x_size[0];
    b_x_data.allocatedSize = 1;
    b_x_data.numDimensions = 1;
    b_x_data.canFreeData = false;
    b_z_data.data = &z_data[0];
    b_z_data.size = &z_size[0];
    b_z_data.allocatedSize = 1;
    b_z_data.numDimensions = 1;
    b_z_data.canFreeData = false;
    st.site = &ld_emlrtRSI;
    b_cat(&st, &b_y_data, &b_x_data, &b_z_data, r);
    idx = r->size[0] * r->size[1];
    for (k = 0; k < idx; k++) {
      yxz_data[k] = r->data[k];
    }

    preNum = *Num;
    st.site = &kd_emlrtRSI;
    Labeling(&st, yxz_data, b_bw, b_L, Num);
    if (preNum == *Num) {
      (*Num)++;
    }

    idx = 0;
    bw_tmp = 1;
    j = 0;
    exitg1 = false;
    while ((!exitg1) && (j < 125)) {
      if (b_bw[j]) {
        idx = 1;
        ii_data[0] = (int8_T)(j + 1);
        exitg1 = true;
      } else {
        j++;
      }
    }

    if (idx == 0) {
      bw_tmp = 0;
    }

    st.site = &jd_emlrtRSI;
    b_st.site = &hd_emlrtRSI;
    k = b_idx->size[0];
    b_idx->size[0] = bw_tmp;
    emxEnsureCapacity_int16_T(&b_st, b_idx, k, &ae_emlrtRTEI);
    for (k = 0; k < bw_tmp; k++) {
      b_idx->data[0] = ii_data[0];
    }

    idx = b_idx->size[0];
    for (k = 0; k < idx; k++) {
      b_idx->data[k]--;
    }

    k = vk->size[0];
    vk->size[0] = b_idx->size[0];
    emxEnsureCapacity_int8_T(&b_st, vk, k, &wc_emlrtRTEI);
    idx = b_idx->size[0];
    for (k = 0; k < idx; k++) {
      vk->data[k] = (int8_T)(b_idx->data[k] / 25);
    }

    k = varargout_6->size[0];
    varargout_6->size[0] = vk->size[0];
    emxEnsureCapacity_int8_T(&b_st, varargout_6, k, &xc_emlrtRTEI);
    idx = vk->size[0];
    for (k = 0; k < idx; k++) {
      varargout_6->data[k] = (int8_T)(vk->data[k] + 1);
    }

    idx = b_idx->size[0];
    for (k = 0; k < idx; k++) {
      b_idx->data[k] = (int16_T)(b_idx->data[k] - vk->data[k] * 25);
    }

    k = vk->size[0];
    vk->size[0] = b_idx->size[0];
    emxEnsureCapacity_int8_T(&b_st, vk, k, &wc_emlrtRTEI);
    idx = b_idx->size[0];
    for (k = 0; k < idx; k++) {
      vk->data[k] = (int8_T)(b_idx->data[k] / 5);
    }

    idx = b_idx->size[0];
    for (k = 0; k < idx; k++) {
      b_idx->data[k] = (int16_T)(b_idx->data[k] - vk->data[k] * 5);
    }

    y_size[0] = b_idx->size[0];
    idx = b_idx->size[0];
    for (k = 0; k < idx; k++) {
      y_data[k] = (real_T)b_idx->data[k] + 1.0;
    }

    x_size[0] = vk->size[0];
    idx = vk->size[0];
    for (k = 0; k < idx; k++) {
      x_data[k] = (real_T)vk->data[k] + 1.0;
    }

    z_size[0] = varargout_6->size[0];
    idx = varargout_6->size[0];
    for (k = 0; k < idx; k++) {
      z_data[k] = varargout_6->data[k];
    }

    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(&r);
  emxFree_int8_T(&vk);
  emxFree_int16_T(&b_idx);
  emxFree_int8_T(&varargout_6);
  for (k = 0; k < 3; k++) {
    for (idx = 0; idx < 3; idx++) {
      j = 5 * (idx + 1) + 25 * (k + 1);
      bw_tmp = 3 * idx + 9 * k;
      L[bw_tmp] = b_L[j + 1];
      L[bw_tmp + 1] = b_L[j + 2];
      L[bw_tmp + 2] = b_L[j + 3];
    }
  }

  (*Num)--;
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void b_TS_bwlabeln3D26(const emlrtStack *sp, const boolean_T bw[125], real_T L
  [125], real_T *Num)
{
  boolean_T maxval;
  int32_T idx;
  int32_T j;
  int32_T i;
  real_T b_L[343];
  int32_T bw_tmp;
  real_T siz[3];
  boolean_T b_bw[343];
  int32_T bw_tmp_tmp;
  int32_T b_bw_tmp_tmp;
  boolean_T exitg1;
  int16_T ii_data[1];
  int32_T y_size[1];
  emxArray_int32_T *varargout_6;
  real_T y_data[1];
  emxArray_int32_T *varargout_5;
  emxArray_int32_T *varargout_4;
  emxArray_real_T b_y_data;
  int32_T x_size[1];
  int32_T z_size[1];
  real_T x_data[1];
  real_T z_data[1];
  emxArray_real_T *r;
  emxArray_real_T c_y_data;
  emxArray_real_T b_x_data;
  emxArray_real_T b_z_data;
  real_T preNum;
  real_T yxz_data[3];
  emxArray_real_T d_y_data;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  maxval = bw[0];
  for (idx = 0; idx < 124; idx++) {
    maxval = (((int32_T)maxval < (int32_T)bw[idx + 1]) || maxval);
  }

  if (!maxval) {
    memset(&L[0], 0, 125U * sizeof(real_T));
    *Num = 0.0;
  } else {
    st.site = &id_emlrtRSI;
    for (j = 0; j < 7; j++) {
      for (i = 0; i < 7; i++) {
        bw_tmp = i + 7 * j;
        b_bw[bw_tmp] = false;
        b_bw[bw_tmp + 294] = false;
      }
    }

    for (idx = 0; idx < 5; idx++) {
      for (i = 0; i < 7; i++) {
        bw_tmp = i + 49 * (idx + 1);
        b_bw[bw_tmp] = false;
        b_bw[bw_tmp + 42] = false;
      }

      bw_tmp_tmp = 49 * (idx + 1);
      for (j = 0; j < 5; j++) {
        b_bw_tmp_tmp = 7 * (j + 1);
        bw_tmp = b_bw_tmp_tmp + bw_tmp_tmp;
        b_bw[bw_tmp] = false;
        b_bw[bw_tmp + 6] = false;
        for (i = 0; i < 5; i++) {
          b_bw[((i + b_bw_tmp_tmp) + bw_tmp_tmp) + 1] = bw[(i + 5 * j) + 25 *
            idx];
        }
      }
    }

    memset(&b_L[0], 0, 343U * sizeof(real_T));
    siz[0] = 7.0;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }

    siz[1] = 7.0;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }

    siz[2] = 7.0;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }

    idx = 0;
    i = 1;
    j = 0;
    exitg1 = false;
    while ((!exitg1) && (j < 343)) {
      if (b_bw[j]) {
        idx = 1;
        ii_data[0] = (int16_T)(j + 1);
        exitg1 = true;
      } else {
        j++;
      }
    }

    if (idx == 0) {
      i = 0;
    }

    b_st.site = &md_emlrtRSI;
    y_size[0] = i;
    for (bw_tmp = 0; bw_tmp < i; bw_tmp++) {
      y_data[0] = ii_data[0];
    }

    emxInit_int32_T(&b_st, &varargout_6, 1, &ch_emlrtRTEI, true);
    emxInit_int32_T(&b_st, &varargout_5, 1, &ch_emlrtRTEI, true);
    emxInit_int32_T(&b_st, &varargout_4, 1, &ch_emlrtRTEI, true);
    b_y_data.data = &y_data[0];
    b_y_data.size = &y_size[0];
    b_y_data.allocatedSize = 1;
    b_y_data.numDimensions = 1;
    b_y_data.canFreeData = false;
    c_st.site = &hd_emlrtRSI;
    ind2sub_indexClass(&c_st, siz, &b_y_data, varargout_4, varargout_5,
                       varargout_6);
    y_size[0] = varargout_4->size[0];
    idx = varargout_4->size[0];
    for (bw_tmp = 0; bw_tmp < idx; bw_tmp++) {
      y_data[bw_tmp] = varargout_4->data[bw_tmp];
    }

    x_size[0] = varargout_5->size[0];
    idx = varargout_5->size[0];
    for (bw_tmp = 0; bw_tmp < idx; bw_tmp++) {
      x_data[bw_tmp] = varargout_5->data[bw_tmp];
    }

    z_size[0] = varargout_6->size[0];
    idx = varargout_6->size[0];
    for (bw_tmp = 0; bw_tmp < idx; bw_tmp++) {
      z_data[bw_tmp] = varargout_6->data[bw_tmp];
    }

    *Num = 1.0;
    emxInit_real_T(&st, &r, 2, &de_emlrtRTEI, true);
    while (y_size[0] != 0) {
      c_y_data.data = &y_data[0];
      c_y_data.size = &y_size[0];
      c_y_data.allocatedSize = 1;
      c_y_data.numDimensions = 1;
      c_y_data.canFreeData = false;
      b_x_data.data = &x_data[0];
      b_x_data.size = &x_size[0];
      b_x_data.allocatedSize = 1;
      b_x_data.numDimensions = 1;
      b_x_data.canFreeData = false;
      b_z_data.data = &z_data[0];
      b_z_data.size = &z_size[0];
      b_z_data.allocatedSize = 1;
      b_z_data.numDimensions = 1;
      b_z_data.canFreeData = false;
      b_st.site = &ld_emlrtRSI;
      b_cat(&b_st, &c_y_data, &b_x_data, &b_z_data, r);
      idx = r->size[0] * r->size[1];
      for (bw_tmp = 0; bw_tmp < idx; bw_tmp++) {
        yxz_data[bw_tmp] = r->data[bw_tmp];
      }

      preNum = *Num;
      b_st.site = &kd_emlrtRSI;
      e_Labeling(&b_st, yxz_data, b_bw, b_L, Num);
      if (preNum == *Num) {
        (*Num)++;
      }

      idx = 0;
      i = 1;
      j = 0;
      exitg1 = false;
      while ((!exitg1) && (j < 343)) {
        if (b_bw[j]) {
          idx = 1;
          ii_data[0] = (int16_T)(j + 1);
          exitg1 = true;
        } else {
          j++;
        }
      }

      if (idx == 0) {
        i = 0;
      }

      b_st.site = &jd_emlrtRSI;
      y_size[0] = i;
      for (bw_tmp = 0; bw_tmp < i; bw_tmp++) {
        y_data[0] = ii_data[0];
      }

      d_y_data.data = &y_data[0];
      d_y_data.size = &y_size[0];
      d_y_data.allocatedSize = 1;
      d_y_data.numDimensions = 1;
      d_y_data.canFreeData = false;
      c_st.site = &hd_emlrtRSI;
      ind2sub_indexClass(&c_st, siz, &d_y_data, varargout_4, varargout_5,
                         varargout_6);
      y_size[0] = varargout_4->size[0];
      idx = varargout_4->size[0];
      for (bw_tmp = 0; bw_tmp < idx; bw_tmp++) {
        y_data[bw_tmp] = varargout_4->data[bw_tmp];
      }

      x_size[0] = varargout_5->size[0];
      idx = varargout_5->size[0];
      for (bw_tmp = 0; bw_tmp < idx; bw_tmp++) {
        x_data[bw_tmp] = varargout_5->data[bw_tmp];
      }

      z_size[0] = varargout_6->size[0];
      idx = varargout_6->size[0];
      for (bw_tmp = 0; bw_tmp < idx; bw_tmp++) {
        z_data[bw_tmp] = varargout_6->data[bw_tmp];
      }

      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(&st);
      }
    }

    emxFree_real_T(&r);
    emxFree_int32_T(&varargout_4);
    emxFree_int32_T(&varargout_5);
    emxFree_int32_T(&varargout_6);
    for (bw_tmp = 0; bw_tmp < 5; bw_tmp++) {
      for (idx = 0; idx < 5; idx++) {
        for (j = 0; j < 5; j++) {
          L[(j + 5 * idx) + 25 * bw_tmp] = b_L[((j + 7 * (idx + 1)) + 49 *
            (bw_tmp + 1)) + 1];
        }
      }
    }

    (*Num)--;
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void c_TS_bwlabeln3D26(const emlrtStack *sp, const emxArray_boolean_T *bw,
  emxArray_real_T *L, real_T *Num)
{
  int32_T istop;
  boolean_T maxval;
  int32_T k;
  emxArray_boolean_T *b_bw;
  uint32_T unnamed_idx_0;
  uint32_T unnamed_idx_1;
  uint32_T unnamed_idx_2;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack f_st;
  emlrtStack g_st;
  emlrtStack h_st;
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
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  st.site = &he_emlrtRSI;
  b_st.site = &qd_emlrtRSI;
  c_st.site = &rd_emlrtRSI;
  d_st.site = &sd_emlrtRSI;
  if (bw->size[0] * bw->size[1] * bw->size[2] < 1) {
    emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
      "Coder:toolbox:eml_min_or_max_varDimZero",
      "Coder:toolbox:eml_min_or_max_varDimZero", 0);
  }

  e_st.site = &ae_emlrtRSI;
  istop = bw->size[0] * bw->size[1] * bw->size[2];
  f_st.site = &be_emlrtRSI;
  maxval = bw->data[0];
  g_st.site = &ce_emlrtRSI;
  if ((2 <= bw->size[0] * bw->size[1] * bw->size[2]) && (bw->size[0] * bw->size
       [1] * bw->size[2] > 2147483646)) {
    h_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&h_st);
  }

  for (k = 2; k <= istop; k++) {
    if ((int32_T)maxval < (int32_T)bw->data[k - 1]) {
      maxval = bw->data[k - 1];
    }
  }

  if (!maxval) {
    unnamed_idx_0 = (uint32_T)bw->size[0];
    unnamed_idx_1 = (uint32_T)bw->size[1];
    unnamed_idx_2 = (uint32_T)bw->size[2];
    istop = L->size[0] * L->size[1] * L->size[2];
    L->size[0] = (int32_T)unnamed_idx_0;
    L->size[1] = (int32_T)unnamed_idx_1;
    L->size[2] = (int32_T)unnamed_idx_2;
    emxEnsureCapacity_real_T(sp, L, istop, &ie_emlrtRTEI);
    k = (int32_T)unnamed_idx_0 * (int32_T)unnamed_idx_1 * (int32_T)unnamed_idx_2;
    for (istop = 0; istop < k; istop++) {
      L->data[istop] = 0.0;
    }

    *Num = 0.0;
  } else {
    emxInit_boolean_T(sp, &b_bw, 3, &he_emlrtRTEI, true);
    istop = b_bw->size[0] * b_bw->size[1] * b_bw->size[2];
    b_bw->size[0] = bw->size[0];
    b_bw->size[1] = bw->size[1];
    b_bw->size[2] = bw->size[2];
    emxEnsureCapacity_boolean_T(sp, b_bw, istop, &he_emlrtRTEI);
    k = bw->size[0] * bw->size[1] * bw->size[2] - 1;
    for (istop = 0; istop <= k; istop++) {
      b_bw->data[istop] = bw->data[istop];
    }

    st.site = &id_emlrtRSI;
    b_TS_bwlabeln_linux_c(&st, b_bw, L, Num);
    emxFree_boolean_T(&b_bw);
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (TS_bwlabeln3D26.c) */

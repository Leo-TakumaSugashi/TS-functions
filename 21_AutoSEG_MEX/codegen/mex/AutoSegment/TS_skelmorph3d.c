/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * TS_skelmorph3d.c
 *
 * Code generation for function 'TS_skelmorph3d'
 *
 */

/* Include files */
#include "TS_skelmorph3d.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "AutoSegment_mexutil.h"
#include "TS_Label2Centroid.h"
#include "TS_Skeleton3D_oldest.h"
#include "TS_bwlabeln3D26.h"
#include "TS_skel2endpoint.h"
#include "cat.h"
#include "eml_int_forloop_overflow_check.h"
#include "find.h"
#include "imdilate.h"
#include "imfilter.h"
#include "ind2sub.h"
#include "mwmathutil.h"
#include "padarray.h"
#include "power.h"
#include "rt_nonfinite.h"
#include "sqrt.h"
#include "sum.h"

/* Variable Definitions */
static emlrtRSInfo vb_emlrtRSI = { 39, /* lineNo */
  "TS_skelmorph3d",                    /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pathName */
};

static emlrtRSInfo wb_emlrtRSI = { 38, /* lineNo */
  "TS_skelmorph3d",                    /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pathName */
};

static emlrtRSInfo xb_emlrtRSI = { 37, /* lineNo */
  "TS_skelmorph3d",                    /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pathName */
};

static emlrtRSInfo yb_emlrtRSI = { 33, /* lineNo */
  "TS_skelmorph3d",                    /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pathName */
};

static emlrtRSInfo ac_emlrtRSI = { 26, /* lineNo */
  "TS_skelmorph3d",                    /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pathName */
};

static emlrtRSInfo bc_emlrtRSI = { 22, /* lineNo */
  "TS_skelmorph3d",                    /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pathName */
};

static emlrtRSInfo cc_emlrtRSI = { 20, /* lineNo */
  "TS_skelmorph3d",                    /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pathName */
};

static emlrtRSInfo dc_emlrtRSI = { 17, /* lineNo */
  "TS_skelmorph3d",                    /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pathName */
};

static emlrtRSInfo ec_emlrtRSI = { 16, /* lineNo */
  "TS_skelmorph3d",                    /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pathName */
};

static emlrtRSInfo fc_emlrtRSI = { 14, /* lineNo */
  "TS_skelmorph3d",                    /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pathName */
};

static emlrtRSInfo gc_emlrtRSI = { 13, /* lineNo */
  "TS_skelmorph3d",                    /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pathName */
};

static emlrtRSInfo hc_emlrtRSI = { 10, /* lineNo */
  "TS_skelmorph3d",                    /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pathName */
};

static emlrtRSInfo ic_emlrtRSI = { 8,  /* lineNo */
  "TS_skelmorph3d",                    /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pathName */
};

static emlrtECInfo i_emlrtECI = { 3,   /* nDims */
  10,                                  /* lineNo */
  8,                                   /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtECInfo j_emlrtECI = { 3,   /* nDims */
  14,                                  /* lineNo */
  10,                                  /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtECInfo k_emlrtECI = { 3,   /* nDims */
  17,                                  /* lineNo */
  12,                                  /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtBCInfo sb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  32,                                  /* lineNo */
  15,                                  /* colNo */
  "s",                                 /* aName */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo l_emlrtECI = { 2,   /* nDims */
  38,                                  /* lineNo */
  32,                                  /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtBCInfo tb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  28,                                  /* lineNo */
  18,                                  /* colNo */
  "outputBP",                          /* aName */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ub_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  28,                                  /* lineNo */
  20,                                  /* colNo */
  "outputBP",                          /* aName */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo vb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  28,                                  /* lineNo */
  22,                                  /* colNo */
  "outputBP",                          /* aName */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo wb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  16,                                  /* lineNo */
  5,                                   /* colNo */
  "bw",                                /* aName */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo xb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  40,                                  /* lineNo */
  9,                                   /* colNo */
  "outputBP",                          /* aName */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo yb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  40,                                  /* lineNo */
  9,                                   /* colNo */
  "y",                                 /* aName */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ac_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  40,                                  /* lineNo */
  9,                                   /* colNo */
  "x",                                 /* aName */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo bc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  40,                                  /* lineNo */
  9,                                   /* colNo */
  "z",                                 /* aName */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo qc_emlrtRTEI = { 10,/* lineNo */
  8,                                   /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo rc_emlrtRTEI = { 11,/* lineNo */
  1,                                   /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo sc_emlrtRTEI = { 12,/* lineNo */
  1,                                   /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo tc_emlrtRTEI = { 23,/* lineNo */
  1,                                   /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo uc_emlrtRTEI = { 26,/* lineNo */
  37,                                  /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo vc_emlrtRTEI = { 14,/* lineNo */
  16,                                  /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo yc_emlrtRTEI = { 1,/* lineNo */
  33,                                  /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo ad_emlrtRTEI = { 17,/* lineNo */
  12,                                  /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo bd_emlrtRTEI = { 28,/* lineNo */
  18,                                  /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo cd_emlrtRTEI = { 28,/* lineNo */
  20,                                  /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo dd_emlrtRTEI = { 28,/* lineNo */
  22,                                  /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo ed_emlrtRTEI = { 38,/* lineNo */
  32,                                  /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo fd_emlrtRTEI = { 10,/* lineNo */
  1,                                   /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo gd_emlrtRTEI = { 20,/* lineNo */
  1,                                   /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo hd_emlrtRTEI = { 22,/* lineNo */
  1,                                   /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo id_emlrtRTEI = { 37,/* lineNo */
  9,                                   /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo jd_emlrtRTEI = { 38,/* lineNo */
  9,                                   /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo kd_emlrtRTEI = { 32,/* lineNo */
  9,                                   /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

static emlrtRTEInfo ld_emlrtRTEI = { 16,/* lineNo */
  8,                                   /* colNo */
  "TS_skelmorph3d",                    /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_skelmorph3d.m"/* pName */
};

/* Function Definitions */
void TS_skelmorph3d(const emlrtStack *sp, emxArray_boolean_T *bw,
                    emxArray_boolean_T *A, emxArray_boolean_T *BP,
                    emxArray_boolean_T *oldestBP, emxArray_boolean_T *EndP)
{
  emxArray_uint8_T *BPf1;
  int32_T i;
  int32_T loop_ub;
  uint32_T siz_idx_0;
  uint32_T siz_idx_1;
  uint32_T siz_idx_2;
  emxArray_boolean_T *r;
  emxArray_int32_T *ii;
  int32_T exitg1;
  int32_T cpsiz_idx_1;
  uint8_T maxval;
  emxArray_real_T *LBP;
  emxArray_real_T *s;
  emxArray_boolean_T *b_LBP;
  int32_T LBP_idx_0;
  emxArray_real_T *xyz;
  emxArray_real_T *length_xyz;
  emxArray_real_T *y;
  emxArray_real_T *x;
  emxArray_real_T *z;
  emxArray_real_T *p;
  emxArray_int32_T *varargout_6;
  emxArray_int32_T *vk;
  emxArray_real_T *b_xyz;
  int32_T n;
  int32_T a;
  int32_T i1;
  int32_T cpsiz_idx_0;
  int32_T i2;
  real_T b_s[3];
  real_T b_y[2];
  real_T ex;
  boolean_T exitg2;
  real_T d;
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
  emxInit_uint8_T(sp, &BPf1, 3, &fd_emlrtRTEI, true);

  /*  View Check */
  /*  Main func.         */
  st.site = &ic_emlrtRSI;
  TS_skel2endpoint(&st, bw, EndP);
  i = BPf1->size[0] * BPf1->size[1] * BPf1->size[2];
  BPf1->size[0] = bw->size[0];
  BPf1->size[1] = bw->size[1];
  BPf1->size[2] = bw->size[2];
  emxEnsureCapacity_uint8_T(sp, BPf1, i, &qc_emlrtRTEI);
  loop_ub = bw->size[0] * bw->size[1] * bw->size[2];
  for (i = 0; i < loop_ub; i++) {
    BPf1->data[i] = bw->data[i];
  }

  st.site = &hc_emlrtRSI;
  imfilter(&st, BPf1);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[3])BPf1->size, *(int32_T (*)[3])
    bw->size, &i_emlrtECI, sp);
  loop_ub = BPf1->size[0] * BPf1->size[1] * BPf1->size[2];
  for (i = 0; i < loop_ub; i++) {
    BPf1->data[i] = (uint8_T)((uint32_T)BPf1->data[i] * bw->data[i]);
  }

  i = oldestBP->size[0] * oldestBP->size[1] * oldestBP->size[2];
  oldestBP->size[0] = BPf1->size[0];
  oldestBP->size[1] = BPf1->size[1];
  oldestBP->size[2] = BPf1->size[2];
  emxEnsureCapacity_boolean_T(sp, oldestBP, i, &rc_emlrtRTEI);
  loop_ub = BPf1->size[0] * BPf1->size[1] * BPf1->size[2];
  for (i = 0; i < loop_ub; i++) {
    oldestBP->data[i] = (BPf1->data[i] > 3);
  }

  siz_idx_0 = (uint32_T)BPf1->size[0];
  siz_idx_1 = (uint32_T)BPf1->size[1];
  siz_idx_2 = (uint32_T)BPf1->size[2];
  i = BP->size[0] * BP->size[1] * BP->size[2];
  BP->size[0] = (int32_T)siz_idx_0;
  BP->size[1] = (int32_T)siz_idx_1;
  BP->size[2] = (int32_T)siz_idx_2;
  emxEnsureCapacity_boolean_T(sp, BP, i, &sc_emlrtRTEI);
  loop_ub = (int32_T)siz_idx_0 * (int32_T)siz_idx_1 * (int32_T)siz_idx_2;
  for (i = 0; i < loop_ub; i++) {
    BP->data[i] = false;
  }

  emxInit_boolean_T(sp, &r, 3, &ld_emlrtRTEI, true);
  emxInit_int32_T(sp, &ii, 1, &oc_emlrtRTEI, true);
  do {
    exitg1 = 0;
    st.site = &gc_emlrtRSI;
    b_st.site = &qd_emlrtRSI;
    c_st.site = &rd_emlrtRSI;
    d_st.site = &sd_emlrtRSI;
    if (BPf1->size[0] * BPf1->size[1] * BPf1->size[2] < 1) {
      emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
        "Coder:toolbox:eml_min_or_max_varDimZero",
        "Coder:toolbox:eml_min_or_max_varDimZero", 0);
    }

    e_st.site = &ae_emlrtRSI;
    cpsiz_idx_1 = BPf1->size[0] * BPf1->size[1] * BPf1->size[2];
    f_st.site = &be_emlrtRSI;
    maxval = BPf1->data[0];
    g_st.site = &ce_emlrtRSI;
    if ((2 <= BPf1->size[0] * BPf1->size[1] * BPf1->size[2]) && (BPf1->size[0] *
         BPf1->size[1] * BPf1->size[2] > 2147483646)) {
      h_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&h_st);
    }

    for (loop_ub = 2; loop_ub <= cpsiz_idx_1; loop_ub++) {
      if (maxval < BPf1->data[loop_ub - 1]) {
        maxval = BPf1->data[loop_ub - 1];
      }
    }

    if (maxval > 3) {
      st.site = &fc_emlrtRSI;
      b_st.site = &qd_emlrtRSI;
      c_st.site = &rd_emlrtRSI;
      d_st.site = &sd_emlrtRSI;
      if (BPf1->size[0] * BPf1->size[1] * BPf1->size[2] < 1) {
        emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
          "Coder:toolbox:eml_min_or_max_varDimZero",
          "Coder:toolbox:eml_min_or_max_varDimZero", 0);
      }

      e_st.site = &ae_emlrtRSI;
      cpsiz_idx_1 = BPf1->size[0] * BPf1->size[1] * BPf1->size[2];
      f_st.site = &be_emlrtRSI;
      maxval = BPf1->data[0];
      g_st.site = &ce_emlrtRSI;
      if ((2 <= BPf1->size[0] * BPf1->size[1] * BPf1->size[2]) && (BPf1->size[0]
           * BPf1->size[1] * BPf1->size[2] > 2147483646)) {
        h_st.site = &i_emlrtRSI;
        check_forloop_overflow_error(&h_st);
      }

      for (loop_ub = 2; loop_ub <= cpsiz_idx_1; loop_ub++) {
        if (maxval < BPf1->data[loop_ub - 1]) {
          maxval = BPf1->data[loop_ub - 1];
        }
      }

      i = r->size[0] * r->size[1] * r->size[2];
      r->size[0] = BPf1->size[0];
      r->size[1] = BPf1->size[1];
      r->size[2] = BPf1->size[2];
      emxEnsureCapacity_boolean_T(sp, r, i, &vc_emlrtRTEI);
      loop_ub = BPf1->size[0] * BPf1->size[1] * BPf1->size[2];
      for (i = 0; i < loop_ub; i++) {
        r->data[i] = (BPf1->data[i] == maxval);
      }

      emlrtSizeEqCheckNDR2012b(*(int32_T (*)[3])BP->size, *(int32_T (*)[3])
        r->size, &j_emlrtECI, sp);
      loop_ub = BP->size[0] * BP->size[1] * BP->size[2];
      for (i = 0; i < loop_ub; i++) {
        BP->data[i] = (BP->data[i] || r->data[i]);
      }

      /*  %nearest 26 point ---> false */
      st.site = &ec_emlrtRSI;
      imdilate(&st, BP, r);
      a = r->size[0] * (r->size[1] * r->size[2]) - 1;
      cpsiz_idx_1 = 0;
      for (cpsiz_idx_0 = 0; cpsiz_idx_0 <= a; cpsiz_idx_0++) {
        if (r->data[cpsiz_idx_0]) {
          cpsiz_idx_1++;
        }
      }

      i = ii->size[0];
      ii->size[0] = cpsiz_idx_1;
      emxEnsureCapacity_int32_T(sp, ii, i, &yc_emlrtRTEI);
      cpsiz_idx_1 = 0;
      for (cpsiz_idx_0 = 0; cpsiz_idx_0 <= a; cpsiz_idx_0++) {
        if (r->data[cpsiz_idx_0]) {
          ii->data[cpsiz_idx_1] = cpsiz_idx_0 + 1;
          cpsiz_idx_1++;
        }
      }

      loop_ub = ii->size[0] - 1;
      i = bw->size[0] * bw->size[1] * bw->size[2];
      for (i1 = 0; i1 <= loop_ub; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > i)) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, i, &wb_emlrtBCI, sp);
        }

        bw->data[ii->data[i1] - 1] = false;
      }

      i = BPf1->size[0] * BPf1->size[1] * BPf1->size[2];
      BPf1->size[0] = bw->size[0];
      BPf1->size[1] = bw->size[1];
      BPf1->size[2] = bw->size[2];
      emxEnsureCapacity_uint8_T(sp, BPf1, i, &ad_emlrtRTEI);
      loop_ub = bw->size[0] * bw->size[1] * bw->size[2];
      for (i = 0; i < loop_ub; i++) {
        BPf1->data[i] = bw->data[i];
      }

      st.site = &dc_emlrtRSI;
      imfilter(&st, BPf1);
      emlrtSizeEqCheckNDR2012b(*(int32_T (*)[3])BPf1->size, *(int32_T (*)[3])
        bw->size, &k_emlrtECI, sp);
      loop_ub = BPf1->size[0] * BPf1->size[1] * BPf1->size[2];
      for (i = 0; i < loop_ub; i++) {
        BPf1->data[i] = (uint8_T)((uint32_T)BPf1->data[i] * bw->data[i]);
      }

      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(sp);
      }
    } else {
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  emxFree_boolean_T(&r);
  emxFree_uint8_T(&BPf1);
  emxInit_real_T(sp, &LBP, 3, &gd_emlrtRTEI, true);
  emxInit_real_T(sp, &s, 2, &hd_emlrtRTEI, true);

  /*  LBP = uint32(bwlabeln(BP,26)); */
  st.site = &cc_emlrtRSI;
  TS_bwlabeln3D26(&st, BP, LBP);

  /*  s = regionprops3(LBP,'Centroid'); */
  st.site = &bc_emlrtRSI;
  TS_Label2Centroid(&st, LBP, s);
  siz_idx_0 = (uint32_T)BP->size[0];
  siz_idx_1 = (uint32_T)BP->size[1];
  siz_idx_2 = (uint32_T)BP->size[2];
  i = A->size[0] * A->size[1] * A->size[2];
  A->size[0] = (int32_T)siz_idx_0;
  A->size[1] = (int32_T)siz_idx_1;
  A->size[2] = (int32_T)siz_idx_2;
  emxEnsureCapacity_boolean_T(sp, A, i, &tc_emlrtRTEI);
  loop_ub = (int32_T)siz_idx_0 * (int32_T)siz_idx_1 * (int32_T)siz_idx_2;
  for (i = 0; i < loop_ub; i++) {
    A->data[i] = false;
  }

  /*  % Nearest to Centroid Point */
  i = s->size[0];
  emxInit_boolean_T(sp, &b_LBP, 1, &uc_emlrtRTEI, true);
  if (0 <= s->size[0] - 1) {
    LBP_idx_0 = LBP->size[0] * LBP->size[1] * LBP->size[2];
    siz_idx_0 = (uint32_T)BP->size[0];
    siz_idx_1 = (uint32_T)BP->size[1];
    siz_idx_2 = (uint32_T)BP->size[2];
  }

  emxInit_real_T(sp, &xyz, 2, &id_emlrtRTEI, true);
  emxInit_real_T(sp, &length_xyz, 1, &jd_emlrtRTEI, true);
  emxInit_real_T(sp, &y, 1, &yc_emlrtRTEI, true);
  emxInit_real_T(sp, &x, 1, &yc_emlrtRTEI, true);
  emxInit_real_T(sp, &z, 1, &yc_emlrtRTEI, true);
  emxInit_real_T(sp, &p, 2, &kd_emlrtRTEI, true);
  emxInit_int32_T(sp, &varargout_6, 1, &yc_emlrtRTEI, true);
  emxInit_int32_T(sp, &vk, 1, &wc_emlrtRTEI, true);
  emxInit_real_T(sp, &b_xyz, 2, &ed_emlrtRTEI, true);
  for (n = 0; n < i; n++) {
    st.site = &ac_emlrtRSI;
    i1 = b_LBP->size[0];
    b_LBP->size[0] = LBP_idx_0;
    emxEnsureCapacity_boolean_T(&st, b_LBP, i1, &uc_emlrtRTEI);
    for (i1 = 0; i1 < LBP_idx_0; i1++) {
      b_LBP->data[i1] = (LBP->data[i1] == (real_T)n + 1.0);
    }

    b_st.site = &cd_emlrtRSI;
    eml_find(&b_st, b_LBP, ii);
    st.site = &ac_emlrtRSI;
    b_st.site = &hd_emlrtRSI;
    cpsiz_idx_0 = (int32_T)siz_idx_0;
    cpsiz_idx_1 = (int32_T)siz_idx_1 * cpsiz_idx_0;
    if (!allinrange(ii, cpsiz_idx_1 * (int32_T)siz_idx_2)) {
      emlrtErrorWithMessageIdR2018a(&b_st, &g_emlrtRTEI,
        "Coder:MATLAB:ind2sub_IndexOutOfRange",
        "Coder:MATLAB:ind2sub_IndexOutOfRange", 0);
    }

    loop_ub = ii->size[0];
    for (i1 = 0; i1 < loop_ub; i1++) {
      ii->data[i1]--;
    }

    i1 = vk->size[0];
    vk->size[0] = ii->size[0];
    emxEnsureCapacity_int32_T(&b_st, vk, i1, &wc_emlrtRTEI);
    loop_ub = ii->size[0];
    for (i1 = 0; i1 < loop_ub; i1++) {
      c_st.site = &un_emlrtRSI;
      vk->data[i1] = div_s32(&c_st, ii->data[i1], cpsiz_idx_1);
    }

    i1 = varargout_6->size[0];
    varargout_6->size[0] = vk->size[0];
    emxEnsureCapacity_int32_T(&b_st, varargout_6, i1, &xc_emlrtRTEI);
    loop_ub = vk->size[0];
    for (i1 = 0; i1 < loop_ub; i1++) {
      varargout_6->data[i1] = vk->data[i1] + 1;
    }

    loop_ub = ii->size[0];
    for (i1 = 0; i1 < loop_ub; i1++) {
      ii->data[i1] -= vk->data[i1] * cpsiz_idx_1;
    }

    i1 = vk->size[0];
    vk->size[0] = ii->size[0];
    emxEnsureCapacity_int32_T(&b_st, vk, i1, &wc_emlrtRTEI);
    loop_ub = ii->size[0];
    for (i1 = 0; i1 < loop_ub; i1++) {
      c_st.site = &un_emlrtRSI;
      i2 = div_s32(&c_st, ii->data[i1], cpsiz_idx_0);
      vk->data[i1] = i2;
      ii->data[i1] -= i2 * cpsiz_idx_0;
    }

    i1 = y->size[0];
    y->size[0] = ii->size[0];
    emxEnsureCapacity_real_T(&st, y, i1, &mb_emlrtRTEI);
    loop_ub = ii->size[0];
    for (i1 = 0; i1 < loop_ub; i1++) {
      y->data[i1] = ii->data[i1] + 1;
    }

    i1 = x->size[0];
    x->size[0] = vk->size[0];
    emxEnsureCapacity_real_T(&st, x, i1, &mb_emlrtRTEI);
    loop_ub = vk->size[0];
    for (i1 = 0; i1 < loop_ub; i1++) {
      x->data[i1] = vk->data[i1] + 1;
    }

    loop_ub = varargout_6->size[0];
    i1 = z->size[0];
    z->size[0] = varargout_6->size[0];
    emxEnsureCapacity_real_T(&st, z, i1, &mb_emlrtRTEI);
    for (i1 = 0; i1 < loop_ub; i1++) {
      z->data[i1] = varargout_6->data[i1];
    }

    if (y->size[0] == 1) {
      i1 = ii->size[0];
      ii->size[0] = y->size[0];
      emxEnsureCapacity_int32_T(sp, ii, i1, &bd_emlrtRTEI);
      loop_ub = y->size[0];
      for (i1 = 0; i1 < loop_ub; i1++) {
        i2 = (int32_T)y->data[i1];
        if ((i2 < 1) || (i2 > A->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, A->size[0], &tb_emlrtBCI, sp);
        }

        ii->data[i1] = i2;
      }

      i1 = vk->size[0];
      vk->size[0] = x->size[0];
      emxEnsureCapacity_int32_T(sp, vk, i1, &cd_emlrtRTEI);
      loop_ub = x->size[0];
      for (i1 = 0; i1 < loop_ub; i1++) {
        i2 = (int32_T)x->data[i1];
        if ((i2 < 1) || (i2 > A->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, A->size[1], &ub_emlrtBCI, sp);
        }

        vk->data[i1] = i2;
      }

      i1 = varargout_6->size[0];
      varargout_6->size[0] = z->size[0];
      emxEnsureCapacity_int32_T(sp, varargout_6, i1, &dd_emlrtRTEI);
      loop_ub = z->size[0];
      for (i1 = 0; i1 < loop_ub; i1++) {
        i2 = (int32_T)z->data[i1];
        if ((i2 < 1) || (i2 > A->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, A->size[2], &vb_emlrtBCI, sp);
        }

        varargout_6->data[i1] = i2;
      }

      loop_ub = varargout_6->size[0];
      for (i1 = 0; i1 < loop_ub; i1++) {
        a = vk->size[0];
        for (i2 = 0; i2 < a; i2++) {
          for (cpsiz_idx_1 = 0; cpsiz_idx_1 < 1; cpsiz_idx_1++) {
            A->data[((ii->data[0] + A->size[0] * (vk->data[i2] - 1)) + A->size[0]
                     * A->size[1] * (varargout_6->data[i1] - 1)) - 1] = true;
          }
        }
      }
    } else {
      /*          p = s(n).Centroid; */
      i1 = n + 1;
      if ((i1 < 1) || (i1 > s->size[0])) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, s->size[0], &sb_emlrtBCI, sp);
      }

      b_s[0] = s->data[n];
      b_s[1] = s->data[n + s->size[0]];
      b_s[2] = s->data[n + s->size[0] * 2];
      b_y[0] = (real_T)y->size[0] - 1.0;
      b_y[1] = 0.0;
      st.site = &yb_emlrtRSI;
      b_padarray(&st, b_s, b_y, p);
      st.site = &xb_emlrtRSI;
      b_cat(&st, x, y, z, xyz);
      emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])xyz->size, *(int32_T (*)[2])
        p->size, &l_emlrtECI, sp);
      i1 = b_xyz->size[0] * b_xyz->size[1];
      b_xyz->size[0] = xyz->size[0];
      b_xyz->size[1] = 3;
      emxEnsureCapacity_real_T(sp, b_xyz, i1, &ed_emlrtRTEI);
      loop_ub = xyz->size[0] * xyz->size[1];
      for (i1 = 0; i1 < loop_ub; i1++) {
        b_xyz->data[i1] = xyz->data[i1] - p->data[i1];
      }

      st.site = &wb_emlrtRSI;
      power(&st, b_xyz, p);
      st.site = &wb_emlrtRSI;
      g_sum(&st, p, length_xyz);
      st.site = &wb_emlrtRSI;
      b_sqrt(&st, length_xyz);
      st.site = &vb_emlrtRSI;
      b_st.site = &rf_emlrtRSI;
      c_st.site = &sf_emlrtRSI;
      d_st.site = &tf_emlrtRSI;
      if (length_xyz->size[0] < 1) {
        emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
          "Coder:toolbox:eml_min_or_max_varDimZero",
          "Coder:toolbox:eml_min_or_max_varDimZero", 0);
      }

      e_st.site = &uf_emlrtRSI;
      cpsiz_idx_0 = length_xyz->size[0];
      if (length_xyz->size[0] <= 2) {
        if (length_xyz->size[0] == 1) {
          cpsiz_idx_1 = 1;
        } else if ((length_xyz->data[0] > length_xyz->data[1]) ||
                   (muDoubleScalarIsNaN(length_xyz->data[0]) &&
                    (!muDoubleScalarIsNaN(length_xyz->data[1])))) {
          cpsiz_idx_1 = 2;
        } else {
          cpsiz_idx_1 = 1;
        }
      } else {
        f_st.site = &xd_emlrtRSI;
        if (!muDoubleScalarIsNaN(length_xyz->data[0])) {
          cpsiz_idx_1 = 1;
        } else {
          cpsiz_idx_1 = 0;
          g_st.site = &yd_emlrtRSI;
          if (length_xyz->size[0] > 2147483646) {
            h_st.site = &i_emlrtRSI;
            check_forloop_overflow_error(&h_st);
          }

          loop_ub = 2;
          exitg2 = false;
          while ((!exitg2) && (loop_ub <= length_xyz->size[0])) {
            if (!muDoubleScalarIsNaN(length_xyz->data[loop_ub - 1])) {
              cpsiz_idx_1 = loop_ub;
              exitg2 = true;
            } else {
              loop_ub++;
            }
          }
        }

        if (cpsiz_idx_1 == 0) {
          cpsiz_idx_1 = 1;
        } else {
          f_st.site = &vd_emlrtRSI;
          ex = length_xyz->data[cpsiz_idx_1 - 1];
          a = cpsiz_idx_1 + 1;
          g_st.site = &wd_emlrtRSI;
          if ((cpsiz_idx_1 + 1 <= length_xyz->size[0]) && (length_xyz->size[0] >
               2147483646)) {
            h_st.site = &i_emlrtRSI;
            check_forloop_overflow_error(&h_st);
          }

          for (loop_ub = a; loop_ub <= cpsiz_idx_0; loop_ub++) {
            d = length_xyz->data[loop_ub - 1];
            if (ex > d) {
              ex = d;
              cpsiz_idx_1 = loop_ub;
            }
          }
        }
      }

      if ((cpsiz_idx_1 < 1) || (cpsiz_idx_1 > y->size[0])) {
        emlrtDynamicBoundsCheckR2012b(cpsiz_idx_1, 1, y->size[0], &yb_emlrtBCI,
          sp);
      }

      i1 = (int32_T)y->data[cpsiz_idx_1 - 1];
      if ((i1 < 1) || (i1 > A->size[0])) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, A->size[0], &xb_emlrtBCI, sp);
      }

      if (cpsiz_idx_1 > x->size[0]) {
        emlrtDynamicBoundsCheckR2012b(cpsiz_idx_1, 1, x->size[0], &ac_emlrtBCI,
          sp);
      }

      i2 = (int32_T)x->data[cpsiz_idx_1 - 1];
      if ((i2 < 1) || (i2 > A->size[1])) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, A->size[1], &xb_emlrtBCI, sp);
      }

      if (cpsiz_idx_1 > z->size[0]) {
        emlrtDynamicBoundsCheckR2012b(cpsiz_idx_1, 1, z->size[0], &bc_emlrtBCI,
          sp);
      }

      cpsiz_idx_1 = (int32_T)z->data[cpsiz_idx_1 - 1];
      if ((cpsiz_idx_1 < 1) || (cpsiz_idx_1 > A->size[2])) {
        emlrtDynamicBoundsCheckR2012b(cpsiz_idx_1, 1, A->size[2], &xb_emlrtBCI,
          sp);
      }

      A->data[((i1 + A->size[0] * (i2 - 1)) + A->size[0] * A->size[1] *
               (cpsiz_idx_1 - 1)) - 1] = true;
    }

    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(&b_xyz);
  emxFree_boolean_T(&b_LBP);
  emxFree_int32_T(&vk);
  emxFree_int32_T(&varargout_6);
  emxFree_int32_T(&ii);
  emxFree_real_T(&p);
  emxFree_real_T(&z);
  emxFree_real_T(&x);
  emxFree_real_T(&y);
  emxFree_real_T(&length_xyz);
  emxFree_real_T(&xyz);
  emxFree_real_T(&s);
  emxFree_real_T(&LBP);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (TS_skelmorph3d.c) */

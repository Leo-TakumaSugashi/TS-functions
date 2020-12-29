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
#include "TS_Skeleton3D.h"
#include "TS_Skeleton3D_data.h"
#include "TS_Skeleton3D_emxutil.h"
#include "ind2sub.h"
#include "indexShapeCheck.h"
#include "rt_nonfinite.h"
#include <string.h>

/* Variable Definitions */
static emlrtRSInfo qc_emlrtRSI = { 28, /* lineNo */
  "TS_bwlabeln_linux_c",               /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m"/* pathName */
};

static emlrtRSInfo rc_emlrtRSI = { 24, /* lineNo */
  "TS_bwlabeln_linux_c",               /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m"/* pathName */
};

static emlrtRSInfo sc_emlrtRSI = { 22, /* lineNo */
  "TS_bwlabeln_linux_c",               /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m"/* pathName */
};

static emlrtRSInfo tc_emlrtRSI = { 19, /* lineNo */
  "TS_bwlabeln_linux_c",               /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m"/* pathName */
};

static emlrtRSInfo vc_emlrtRSI = { 44, /* lineNo */
  "Labeling",                          /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m"/* pathName */
};

static emlrtRSInfo wc_emlrtRSI = { 47, /* lineNo */
  "Labeling",                          /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m"/* pathName */
};

static emlrtRSInfo xc_emlrtRSI = { 55, /* lineNo */
  "Labeling",                          /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m"/* pathName */
};

static emlrtRSInfo yc_emlrtRSI = { 14, /* lineNo */
  "max",                               /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/datafun/max.m"/* pathName */
};

static emlrtRSInfo ad_emlrtRSI = { 20, /* lineNo */
  "minOrMax",                          /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/eml/+coder/+internal/minOrMax.m"/* pathName */
};

static emlrtMCInfo emlrtMCI = { 58,    /* lineNo */
  9,                                   /* colNo */
  "Labeling",                          /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m"/* pName */
};

static emlrtRTEInfo h_emlrtRTEI = { 55,/* lineNo */
  27,                                  /* colNo */
  "cat",                               /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/cat.m"/* pName */
};

static emlrtBCInfo kb_emlrtBCI = { 1,  /* iFirst */
  7,                                   /* iLast */
  41,                                  /* lineNo */
  5,                                   /* colNo */
  "bw",                                /* aName */
  "Labeling",                          /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo lb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  55,                                  /* lineNo */
  41,                                  /* colNo */
  "y1",                                /* aName */
  "Labeling",                          /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo mb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  55,                                  /* lineNo */
  47,                                  /* colNo */
  "x1",                                /* aName */
  "Labeling",                          /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo nb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  55,                                  /* lineNo */
  53,                                  /* colNo */
  "z1",                                /* aName */
  "Labeling",                          /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ob_emlrtBCI = { 1,  /* iFirst */
  7,                                   /* iLast */
  37,                                  /* lineNo */
  17,                                  /* colNo */
  "bw",                                /* aName */
  "Labeling",                          /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo pb_emlrtBCI = { 1,  /* iFirst */
  7,                                   /* iLast */
  37,                                  /* lineNo */
  25,                                  /* colNo */
  "bw",                                /* aName */
  "Labeling",                          /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo qb_emlrtBCI = { 1,  /* iFirst */
  7,                                   /* iLast */
  37,                                  /* lineNo */
  33,                                  /* colNo */
  "bw",                                /* aName */
  "Labeling",                          /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo rb_emlrtBCI = { 1,  /* iFirst */
  7,                                   /* iLast */
  38,                                  /* lineNo */
  15,                                  /* colNo */
  "L",                                 /* aName */
  "Labeling",                          /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo sb_emlrtBCI = { 1,  /* iFirst */
  7,                                   /* iLast */
  38,                                  /* lineNo */
  23,                                  /* colNo */
  "L",                                 /* aName */
  "Labeling",                          /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo tb_emlrtBCI = { 1,  /* iFirst */
  7,                                   /* iLast */
  38,                                  /* lineNo */
  31,                                  /* colNo */
  "L",                                 /* aName */
  "Labeling",                          /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ub_emlrtBCI = { 1,  /* iFirst */
  7,                                   /* iLast */
  40,                                  /* lineNo */
  5,                                   /* colNo */
  "L",                                 /* aName */
  "Labeling",                          /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m",/* pName */
  3                                    /* checkKind */
};

static emlrtRTEInfo jc_emlrtRTEI = { 12,/* lineNo */
  20,                                  /* colNo */
  "TS_bwlabeln3D26",                   /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m"/* pName */
};

static emlrtRSInfo gd_emlrtRSI = { 58, /* lineNo */
  "Labeling",                          /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m"/* pathName */
};

/* Function Declarations */
static void Labeling(const emlrtStack *sp, const real_T yxz_data[], boolean_T
                     bw[343], real_T L[343], real_T *Num);
static void b_Labeling(const emlrtStack *sp, const real_T yxz[3], boolean_T bw
  [343], real_T L[343], real_T *Num);
static void disp(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location);

/* Function Definitions */
static void Labeling(const emlrtStack *sp, const real_T yxz_data[], boolean_T
                     bw[343], real_T L[343], real_T *Num)
{
  real_T d;
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T i3;
  int32_T i4;
  int32_T ROI_bw_tmp;
  int32_T i5;
  int32_T idx;
  int32_T i6;
  real_T ROI_L[27];
  int32_T b_ROI_bw_tmp;
  boolean_T ROI_bw[27];
  boolean_T TF1;
  real_T ex;
  const mxArray *y;
  const mxArray *m;
  boolean_T exitg1;
  int32_T iv[2];
  int32_T ii_data[27];
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
    ROI_bw_tmp = 49 * (i4 - 1);
    for (i5 = 0; i5 < 3; i5++) {
      if ((i < 1) || (i > 7)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 7, &ob_emlrtBCI, sp);
      }

      i6 = (int32_T)(yxz_data[1] + ((real_T)i5 + -1.0));
      if ((i6 < 1) || (i6 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, 7, &pb_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 7, &qb_emlrtBCI, sp);
      }

      b_ROI_bw_tmp = 3 * i5 + 9 * i3;
      idx = 7 * (i6 - 1);
      ROI_bw[b_ROI_bw_tmp] = bw[((i + idx) + ROI_bw_tmp) - 1];
      if ((i1 < 1) || (i1 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 7, &ob_emlrtBCI, sp);
      }

      ROI_bw[b_ROI_bw_tmp + 1] = bw[((i1 + idx) + ROI_bw_tmp) - 1];
      if ((i2 < 1) || (i2 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 7, &ob_emlrtBCI, sp);
      }

      ROI_bw[b_ROI_bw_tmp + 2] = bw[((i2 + idx) + ROI_bw_tmp) - 1];
    }
  }

  d = yxz_data[0];
  i = (int32_T)(d + -1.0);
  i1 = (int32_T)d;
  i2 = (int32_T)(d + 1.0);
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)(yxz_data[2] + ((real_T)i3 + -1.0));
    ROI_bw_tmp = 49 * (i4 - 1);
    for (i5 = 0; i5 < 3; i5++) {
      if ((i < 1) || (i > 7)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 7, &rb_emlrtBCI, sp);
      }

      i6 = (int32_T)(yxz_data[1] + ((real_T)i5 + -1.0));
      if ((i6 < 1) || (i6 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, 7, &sb_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 7, &tb_emlrtBCI, sp);
      }

      b_ROI_bw_tmp = 3 * i5 + 9 * i3;
      idx = 7 * (i6 - 1);
      ROI_L[b_ROI_bw_tmp] = L[((i + idx) + ROI_bw_tmp) - 1];
      if ((i1 < 1) || (i1 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 7, &rb_emlrtBCI, sp);
      }

      ROI_L[b_ROI_bw_tmp + 1] = L[((i1 + idx) + ROI_bw_tmp) - 1];
      if ((i2 < 1) || (i2 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 7, &rb_emlrtBCI, sp);
      }

      ROI_L[b_ROI_bw_tmp + 2] = L[((i2 + idx) + ROI_bw_tmp) - 1];
    }
  }

  for (idx = 0; idx < 27; idx++) {
    if (bw[(((int32_T)(yxz_data[0] + ((real_T)(idx % 3) + -1.0)) + 7 * ((int32_T)
           (yxz_data[1] + ((real_T)(idx / 3 % 3) + -1.0)) - 1)) + 49 * ((int32_T)
          (yxz_data[2] + ((real_T)(idx / 9) + -1.0)) - 1)) - 1]) {
      ROI_L[idx] = *Num;
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
        emlrtDynamicBoundsCheckR2012b(i, 1, 7, &ub_emlrtBCI, sp);
      }

      idx = (int32_T)(yxz_data[1] + ((real_T)i6 + -1.0));
      if ((idx < 1) || (idx > 7)) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, 7, &ub_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 7, &ub_emlrtBCI, sp);
      }

      ROI_bw_tmp = 3 * i6 + 9 * i3;
      idx = 7 * (idx - 1);
      L[((i + idx) + i5) - 1] = ROI_L[ROI_bw_tmp];
      if ((i1 < 1) || (i1 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 7, &ub_emlrtBCI, sp);
      }

      L[((i1 + idx) + i5) - 1] = ROI_L[ROI_bw_tmp + 1];
      if ((i2 < 1) || (i2 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 7, &ub_emlrtBCI, sp);
      }

      L[((i2 + idx) + i5) - 1] = ROI_L[ROI_bw_tmp + 2];
    }
  }

  i = (int32_T)yxz_data[0];
  if ((i < 1) || (i > 7)) {
    emlrtDynamicBoundsCheckR2012b(i, 1, 7, &kb_emlrtBCI, sp);
  }

  i1 = (int32_T)yxz_data[1];
  if ((i1 < 1) || (i1 > 7)) {
    emlrtDynamicBoundsCheckR2012b(i1, 1, 7, &kb_emlrtBCI, sp);
  }

  i2 = (int32_T)yxz_data[2];
  if ((i2 < 1) || (i2 > 7)) {
    emlrtDynamicBoundsCheckR2012b(i2, 1, 7, &kb_emlrtBCI, sp);
  }

  bw[((i + 7 * (i1 - 1)) + 49 * (i2 - 1)) - 1] = false;
  ROI_bw[13] = false;
  TF1 = ROI_bw[0];
  for (idx = 0; idx < 26; idx++) {
    TF1 = (((int32_T)TF1 < (int32_T)ROI_bw[idx + 1]) || TF1);
  }

  st.site = &vc_emlrtRSI;
  b_st.site = &yc_emlrtRSI;
  c_st.site = &ad_emlrtRSI;
  ex = ROI_L[0];
  for (idx = 0; idx < 26; idx++) {
    d = ROI_L[idx + 1];
    if (ex < d) {
      ex = d;
    }
  }

  if (TF1 || (ex == *Num)) {
    st.site = &wc_emlrtRSI;
    b_st.site = &bc_emlrtRSI;
    c_st.site = &cc_emlrtRSI;
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
      idx = 0;
    }

    iv[0] = 1;
    iv[1] = idx;
    d_st.site = &ec_emlrtRSI;
    indexShapeCheck(&d_st, 27, iv);
    st.site = &wc_emlrtRSI;
    y1_size[0] = idx;
    for (i = 0; i < idx; i++) {
      ROI_L[i] = ii_data[i];
    }

    b_st.site = &nc_emlrtRSI;
    b_ind2sub_indexClass(&b_st, ROI_L, y1_size, ii_data, ii_size,
                         varargout_5_data, varargout_5_size, varargout_6_data,
                         varargout_6_size);
    y1_size[0] = ii_size[0];
    idx = ii_size[0];
    for (i = 0; i < idx; i++) {
      ROI_L[i] = ii_data[i];
    }

    if (ii_size[0] != 0) {
      idx = ii_size[0];
      for (i = 0; i < idx; i++) {
        ROI_L[i] = (yxz_data[0] + ROI_L[i]) - 2.0;
      }

      ROI_bw_tmp = varargout_5_size[0];
      idx = varargout_5_size[0];
      for (i = 0; i < idx; i++) {
        x1_data[i] = (yxz_data[1] + (real_T)varargout_5_data[i]) - 2.0;
      }

      b_ROI_bw_tmp = varargout_6_size[0];
      idx = varargout_6_size[0];
      for (i = 0; i < idx; i++) {
        z1_data[i] = (yxz_data[2] + (real_T)varargout_6_data[i]) - 2.0;
      }

      i = ii_size[0];
      for (idx = 0; idx < i; idx++) {
        i1 = idx + 1;
        if ((i1 < 1) || (i1 > y1_size[0])) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, y1_size[0], &lb_emlrtBCI, sp);
        }

        b_y[0] = ROI_L[i1 - 1];
        i1 = idx + 1;
        if ((i1 < 1) || (i1 > ROI_bw_tmp)) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, ROI_bw_tmp, &mb_emlrtBCI, sp);
        }

        b_y[1] = x1_data[i1 - 1];
        i1 = idx + 1;
        if ((i1 < 1) || (i1 > b_ROI_bw_tmp)) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, b_ROI_bw_tmp, &nb_emlrtBCI, sp);
        }

        b_y[2] = z1_data[i1 - 1];
        st.site = &xc_emlrtRSI;
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
    st.site = &gd_emlrtRSI;
    disp(&st, y, &emlrtMCI);
    (*Num)++;
  }
}

static void b_Labeling(const emlrtStack *sp, const real_T yxz[3], boolean_T bw
  [343], real_T L[343], real_T *Num)
{
  real_T d;
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T i3;
  int32_T i4;
  int32_T ROI_bw_tmp;
  int32_T i5;
  int32_T idx;
  int32_T i6;
  real_T ROI_L[27];
  int32_T b_ROI_bw_tmp;
  boolean_T ROI_bw[27];
  boolean_T TF1;
  real_T ex;
  const mxArray *y;
  const mxArray *m;
  boolean_T exitg1;
  int32_T iv[2];
  int32_T ii_data[27];
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
    ROI_bw_tmp = 49 * (i4 - 1);
    for (i5 = 0; i5 < 3; i5++) {
      if ((i < 1) || (i > 7)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 7, &ob_emlrtBCI, sp);
      }

      i6 = (int32_T)(yxz[1] + ((real_T)i5 + -1.0));
      if ((i6 < 1) || (i6 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, 7, &pb_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 7, &qb_emlrtBCI, sp);
      }

      b_ROI_bw_tmp = 3 * i5 + 9 * i3;
      idx = 7 * (i6 - 1);
      ROI_bw[b_ROI_bw_tmp] = bw[((i + idx) + ROI_bw_tmp) - 1];
      if ((i1 < 1) || (i1 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 7, &ob_emlrtBCI, sp);
      }

      ROI_bw[b_ROI_bw_tmp + 1] = bw[((i1 + idx) + ROI_bw_tmp) - 1];
      if ((i2 < 1) || (i2 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 7, &ob_emlrtBCI, sp);
      }

      ROI_bw[b_ROI_bw_tmp + 2] = bw[((i2 + idx) + ROI_bw_tmp) - 1];
    }
  }

  d = yxz[0];
  i = (int32_T)(d + -1.0);
  i1 = (int32_T)d;
  i2 = (int32_T)(d + 1.0);
  for (i3 = 0; i3 < 3; i3++) {
    i4 = (int32_T)(yxz[2] + ((real_T)i3 + -1.0));
    ROI_bw_tmp = 49 * (i4 - 1);
    for (i5 = 0; i5 < 3; i5++) {
      if ((i < 1) || (i > 7)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 7, &rb_emlrtBCI, sp);
      }

      i6 = (int32_T)(yxz[1] + ((real_T)i5 + -1.0));
      if ((i6 < 1) || (i6 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i6, 1, 7, &sb_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 7, &tb_emlrtBCI, sp);
      }

      b_ROI_bw_tmp = 3 * i5 + 9 * i3;
      idx = 7 * (i6 - 1);
      ROI_L[b_ROI_bw_tmp] = L[((i + idx) + ROI_bw_tmp) - 1];
      if ((i1 < 1) || (i1 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 7, &rb_emlrtBCI, sp);
      }

      ROI_L[b_ROI_bw_tmp + 1] = L[((i1 + idx) + ROI_bw_tmp) - 1];
      if ((i2 < 1) || (i2 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 7, &rb_emlrtBCI, sp);
      }

      ROI_L[b_ROI_bw_tmp + 2] = L[((i2 + idx) + ROI_bw_tmp) - 1];
    }
  }

  for (idx = 0; idx < 27; idx++) {
    if (bw[(((int32_T)(yxz[0] + ((real_T)(idx % 3) + -1.0)) + 7 * ((int32_T)
           (yxz[1] + ((real_T)(idx / 3 % 3) + -1.0)) - 1)) + 49 * ((int32_T)
          (yxz[2] + ((real_T)(idx / 9) + -1.0)) - 1)) - 1]) {
      ROI_L[idx] = *Num;
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
        emlrtDynamicBoundsCheckR2012b(i, 1, 7, &ub_emlrtBCI, sp);
      }

      idx = (int32_T)(yxz[1] + ((real_T)i6 + -1.0));
      if ((idx < 1) || (idx > 7)) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, 7, &ub_emlrtBCI, sp);
      }

      if ((i4 < 1) || (i4 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, 7, &ub_emlrtBCI, sp);
      }

      ROI_bw_tmp = 3 * i6 + 9 * i3;
      idx = 7 * (idx - 1);
      L[((i + idx) + i5) - 1] = ROI_L[ROI_bw_tmp];
      if ((i1 < 1) || (i1 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 7, &ub_emlrtBCI, sp);
      }

      L[((i1 + idx) + i5) - 1] = ROI_L[ROI_bw_tmp + 1];
      if ((i2 < 1) || (i2 > 7)) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, 7, &ub_emlrtBCI, sp);
      }

      L[((i2 + idx) + i5) - 1] = ROI_L[ROI_bw_tmp + 2];
    }
  }

  i = (int32_T)yxz[0];
  if ((i < 1) || (i > 7)) {
    emlrtDynamicBoundsCheckR2012b(i, 1, 7, &kb_emlrtBCI, sp);
  }

  i1 = (int32_T)yxz[1];
  if ((i1 < 1) || (i1 > 7)) {
    emlrtDynamicBoundsCheckR2012b(i1, 1, 7, &kb_emlrtBCI, sp);
  }

  i2 = (int32_T)yxz[2];
  if ((i2 < 1) || (i2 > 7)) {
    emlrtDynamicBoundsCheckR2012b(i2, 1, 7, &kb_emlrtBCI, sp);
  }

  bw[((i + 7 * (i1 - 1)) + 49 * (i2 - 1)) - 1] = false;
  ROI_bw[13] = false;
  TF1 = ROI_bw[0];
  for (idx = 0; idx < 26; idx++) {
    TF1 = (((int32_T)TF1 < (int32_T)ROI_bw[idx + 1]) || TF1);
  }

  st.site = &vc_emlrtRSI;
  b_st.site = &yc_emlrtRSI;
  c_st.site = &ad_emlrtRSI;
  ex = ROI_L[0];
  for (idx = 0; idx < 26; idx++) {
    d = ROI_L[idx + 1];
    if (ex < d) {
      ex = d;
    }
  }

  if (TF1 || (ex == *Num)) {
    st.site = &wc_emlrtRSI;
    b_st.site = &bc_emlrtRSI;
    c_st.site = &cc_emlrtRSI;
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
      idx = 0;
    }

    iv[0] = 1;
    iv[1] = idx;
    d_st.site = &ec_emlrtRSI;
    indexShapeCheck(&d_st, 27, iv);
    st.site = &wc_emlrtRSI;
    y1_size[0] = idx;
    for (i = 0; i < idx; i++) {
      ROI_L[i] = ii_data[i];
    }

    b_st.site = &nc_emlrtRSI;
    b_ind2sub_indexClass(&b_st, ROI_L, y1_size, ii_data, ii_size,
                         varargout_5_data, varargout_5_size, varargout_6_data,
                         varargout_6_size);
    y1_size[0] = ii_size[0];
    idx = ii_size[0];
    for (i = 0; i < idx; i++) {
      ROI_L[i] = ii_data[i];
    }

    if (ii_size[0] != 0) {
      idx = ii_size[0];
      for (i = 0; i < idx; i++) {
        ROI_L[i] = (yxz[0] + ROI_L[i]) - 2.0;
      }

      ROI_bw_tmp = varargout_5_size[0];
      idx = varargout_5_size[0];
      for (i = 0; i < idx; i++) {
        x1_data[i] = (yxz[1] + (real_T)varargout_5_data[i]) - 2.0;
      }

      b_ROI_bw_tmp = varargout_6_size[0];
      idx = varargout_6_size[0];
      for (i = 0; i < idx; i++) {
        z1_data[i] = (yxz[2] + (real_T)varargout_6_data[i]) - 2.0;
      }

      i = ii_size[0];
      for (idx = 0; idx < i; idx++) {
        i1 = idx + 1;
        if ((i1 < 1) || (i1 > y1_size[0])) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, y1_size[0], &lb_emlrtBCI, sp);
        }

        b_y[0] = ROI_L[i1 - 1];
        i1 = idx + 1;
        if ((i1 < 1) || (i1 > ROI_bw_tmp)) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, ROI_bw_tmp, &mb_emlrtBCI, sp);
        }

        b_y[1] = x1_data[i1 - 1];
        i1 = idx + 1;
        if ((i1 < 1) || (i1 > b_ROI_bw_tmp)) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, b_ROI_bw_tmp, &nb_emlrtBCI, sp);
        }

        b_y[2] = z1_data[i1 - 1];
        st.site = &xc_emlrtRSI;
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
    st.site = &gd_emlrtRSI;
    disp(&st, y, &emlrtMCI);
    (*Num)++;
  }
}

static void disp(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(sp, 0, NULL, 1, &pArray, "disp", true, location);
}

void TS_bwlabeln_linux_c(const emlrtStack *sp, const boolean_T bw[125], real_T
  L[125], real_T *Num)
{
  int32_T j;
  int32_T k;
  int32_T idx;
  real_T b_L[343];
  int32_T bw_tmp;
  real_T siz[3];
  boolean_T b_bw[343];
  int32_T bw_tmp_tmp;
  int32_T b_bw_tmp_tmp;
  boolean_T exitg1;
  int32_T ii_data[1];
  int32_T ii_size[1];
  emxArray_int32_T *varargout_6;
  real_T b_ii_data[1];
  emxArray_int32_T *varargout_5;
  emxArray_int32_T *varargout_4;
  emxArray_real_T c_ii_data;
  int32_T x_data[1];
  int32_T z_data[1];
  real_T yxz_data[3];
  real_T preNum;
  emxArray_real_T d_ii_data;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  for (j = 0; j < 7; j++) {
    for (idx = 0; idx < 7; idx++) {
      bw_tmp = idx + 7 * j;
      b_bw[bw_tmp] = false;
      b_bw[bw_tmp + 294] = false;
    }
  }

  for (k = 0; k < 5; k++) {
    for (idx = 0; idx < 7; idx++) {
      bw_tmp = idx + 49 * (k + 1);
      b_bw[bw_tmp] = false;
      b_bw[bw_tmp + 42] = false;
    }

    bw_tmp_tmp = 49 * (k + 1);
    for (j = 0; j < 5; j++) {
      b_bw_tmp_tmp = 7 * (j + 1);
      bw_tmp = b_bw_tmp_tmp + bw_tmp_tmp;
      b_bw[bw_tmp] = false;
      b_bw[bw_tmp + 6] = false;
      for (idx = 0; idx < 5; idx++) {
        b_bw[((idx + b_bw_tmp_tmp) + bw_tmp_tmp) + 1] = bw[(idx + 5 * j) + 25 *
          k];
      }
    }
  }

  memset(&b_L[0], 0, 343U * sizeof(real_T));
  siz[0] = 7.0;
  if (*emlrtBreakCheckR2012bFlagVar != 0) {
    emlrtBreakCheckR2012b(sp);
  }

  siz[1] = 7.0;
  if (*emlrtBreakCheckR2012bFlagVar != 0) {
    emlrtBreakCheckR2012b(sp);
  }

  siz[2] = 7.0;
  if (*emlrtBreakCheckR2012bFlagVar != 0) {
    emlrtBreakCheckR2012b(sp);
  }

  idx = 0;
  k = 1;
  bw_tmp = 0;
  exitg1 = false;
  while ((!exitg1) && (bw_tmp < 343)) {
    if (b_bw[bw_tmp]) {
      idx = 1;
      ii_data[0] = bw_tmp + 1;
      exitg1 = true;
    } else {
      bw_tmp++;
    }
  }

  if (idx == 0) {
    k = 0;
  }

  st.site = &tc_emlrtRSI;
  ii_size[0] = k;
  for (bw_tmp_tmp = 0; bw_tmp_tmp < k; bw_tmp_tmp++) {
    b_ii_data[0] = ii_data[0];
  }

  emxInit_int32_T(&st, &varargout_6, 1, &jc_emlrtRTEI, true);
  emxInit_int32_T(&st, &varargout_5, 1, &jc_emlrtRTEI, true);
  emxInit_int32_T(&st, &varargout_4, 1, &jc_emlrtRTEI, true);
  c_ii_data.data = &b_ii_data[0];
  c_ii_data.size = &ii_size[0];
  c_ii_data.allocatedSize = 1;
  c_ii_data.numDimensions = 1;
  c_ii_data.canFreeData = false;
  b_st.site = &nc_emlrtRSI;
  ind2sub_indexClass(&b_st, siz, &c_ii_data, varargout_4, varargout_5,
                     varargout_6);
  k = varargout_4->size[0];
  idx = varargout_4->size[0];
  for (bw_tmp_tmp = 0; bw_tmp_tmp < idx; bw_tmp_tmp++) {
    ii_data[bw_tmp_tmp] = varargout_4->data[bw_tmp_tmp];
  }

  bw_tmp = varargout_5->size[0];
  idx = varargout_5->size[0];
  for (bw_tmp_tmp = 0; bw_tmp_tmp < idx; bw_tmp_tmp++) {
    x_data[bw_tmp_tmp] = varargout_5->data[bw_tmp_tmp];
  }

  b_bw_tmp_tmp = varargout_6->size[0];
  idx = varargout_6->size[0];
  for (bw_tmp_tmp = 0; bw_tmp_tmp < idx; bw_tmp_tmp++) {
    z_data[bw_tmp_tmp] = varargout_6->data[bw_tmp_tmp];
  }

  *Num = 1.0;
  while (k != 0) {
    st.site = &sc_emlrtRSI;
    j = 0;
    exitg1 = false;
    while ((!exitg1) && (j < 2)) {
      if ((j + 1 != 2) && (1 != bw_tmp)) {
        emlrtErrorWithMessageIdR2018a(&st, &h_emlrtRTEI,
          "Coder:MATLAB:catenate_dimensionMismatch",
          "Coder:MATLAB:catenate_dimensionMismatch", 0);
      } else {
        j++;
      }
    }

    j = 0;
    exitg1 = false;
    while ((!exitg1) && (j < 2)) {
      if ((j + 1 != 2) && (1 != b_bw_tmp_tmp)) {
        emlrtErrorWithMessageIdR2018a(&st, &h_emlrtRTEI,
          "Coder:MATLAB:catenate_dimensionMismatch",
          "Coder:MATLAB:catenate_dimensionMismatch", 0);
      } else {
        j++;
      }
    }

    idx = 0;
    yxz_data[0] = ii_data[0];
    for (j = 0; j < bw_tmp; j++) {
      idx++;
      yxz_data[idx] = x_data[0];
    }

    for (j = 0; j < b_bw_tmp_tmp; j++) {
      idx++;
      yxz_data[idx] = z_data[0];
    }

    preNum = *Num;
    st.site = &rc_emlrtRSI;
    Labeling(&st, yxz_data, b_bw, b_L, Num);
    if (preNum == *Num) {
      (*Num)++;
    }

    idx = 0;
    k = 1;
    bw_tmp = 0;
    exitg1 = false;
    while ((!exitg1) && (bw_tmp < 343)) {
      if (b_bw[bw_tmp]) {
        idx = 1;
        ii_data[0] = bw_tmp + 1;
        exitg1 = true;
      } else {
        bw_tmp++;
      }
    }

    if (idx == 0) {
      k = 0;
    }

    st.site = &qc_emlrtRSI;
    ii_size[0] = k;
    for (bw_tmp_tmp = 0; bw_tmp_tmp < k; bw_tmp_tmp++) {
      b_ii_data[0] = ii_data[0];
    }

    d_ii_data.data = &b_ii_data[0];
    d_ii_data.size = &ii_size[0];
    d_ii_data.allocatedSize = 1;
    d_ii_data.numDimensions = 1;
    d_ii_data.canFreeData = false;
    b_st.site = &nc_emlrtRSI;
    ind2sub_indexClass(&b_st, siz, &d_ii_data, varargout_4, varargout_5,
                       varargout_6);
    k = varargout_4->size[0];
    idx = varargout_4->size[0];
    for (bw_tmp_tmp = 0; bw_tmp_tmp < idx; bw_tmp_tmp++) {
      ii_data[bw_tmp_tmp] = varargout_4->data[bw_tmp_tmp];
    }

    bw_tmp = varargout_5->size[0];
    idx = varargout_5->size[0];
    for (bw_tmp_tmp = 0; bw_tmp_tmp < idx; bw_tmp_tmp++) {
      x_data[bw_tmp_tmp] = varargout_5->data[bw_tmp_tmp];
    }

    b_bw_tmp_tmp = varargout_6->size[0];
    idx = varargout_6->size[0];
    for (bw_tmp_tmp = 0; bw_tmp_tmp < idx; bw_tmp_tmp++) {
      z_data[bw_tmp_tmp] = varargout_6->data[bw_tmp_tmp];
    }

    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_int32_T(&varargout_4);
  emxFree_int32_T(&varargout_5);
  emxFree_int32_T(&varargout_6);
  for (bw_tmp_tmp = 0; bw_tmp_tmp < 5; bw_tmp_tmp++) {
    for (idx = 0; idx < 5; idx++) {
      for (bw_tmp = 0; bw_tmp < 5; bw_tmp++) {
        L[(bw_tmp + 5 * idx) + 25 * bw_tmp_tmp] = b_L[((bw_tmp + 7 * (idx + 1))
          + 49 * (bw_tmp_tmp + 1)) + 1];
      }
    }
  }

  (*Num)--;
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (TS_bwlabeln3D26.c) */

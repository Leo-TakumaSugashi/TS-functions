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
#include "TS_Skeleton3D.h"
#include "TS_Skeleton3D_data.h"
#include "TS_Skeleton3D_emxutil.h"
#include "assertValidSizeArg.h"
#include "eml_int_forloop_overflow_check.h"
#include "repmat.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo m_emlrtRSI = { 64,  /* lineNo */
  "padarray",                          /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/padarray.m"/* pathName */
};

static emlrtRSInfo n_emlrtRSI = { 72,  /* lineNo */
  "padarray",                          /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/padarray.m"/* pathName */
};

static emlrtRSInfo p_emlrtRSI = { 301, /* lineNo */
  "ConstantPad",                       /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/padarray.m"/* pathName */
};

static emlrtRSInfo q_emlrtRSI = { 317, /* lineNo */
  "ConstantPad",                       /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/padarray.m"/* pathName */
};

static emlrtRSInfo r_emlrtRSI = { 330, /* lineNo */
  "ConstantPad",                       /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/padarray.m"/* pathName */
};

static emlrtBCInfo cb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  304,                                 /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "ConstantPad",                       /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo db_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  366,                                 /* lineNo */
  143,                                 /* colNo */
  "",                                  /* aName */
  "ConstantPad",                       /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo eb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  366,                                 /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "ConstantPad",                       /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo fb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  319,                                 /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "ConstantPad",                       /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo gb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  331,                                 /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "ConstantPad",                       /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo emlrtDCI = { 251,   /* lineNo */
  35,                                  /* colNo */
  "ConstantPad",                       /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/padarray.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo hb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  313,                                 /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "ConstantPad",                       /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ib_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  325,                                 /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "ConstantPad",                       /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo jb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  296,                                 /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "ConstantPad",                       /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo b_emlrtDCI = { 253, /* lineNo */
  35,                                  /* colNo */
  "ConstantPad",                       /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/padarray.m",/* pName */
  1                                    /* checkKind */
};

static emlrtRTEInfo bc_emlrtRTEI = { 72,/* lineNo */
  13,                                  /* colNo */
  "padarray",                          /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/padarray.m"/* pName */
};

static emlrtRTEInfo fc_emlrtRTEI = { 64,/* lineNo */
  9,                                   /* colNo */
  "padarray",                          /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/images/images/eml/padarray.m"/* pName */
};

/* Function Definitions */
void b_padarray(const emlrtStack *sp, const emxArray_boolean_T *varargin_1,
                emxArray_boolean_T *b)
{
  real_T sizeB[3];
  uint32_T u;
  uint32_T u1;
  uint32_T u2;
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
  if (varargin_1->size[2] == 0) {
    sizeB[0] = (uint32_T)varargin_1->size[0];
    sizeB[1] = (uint32_T)varargin_1->size[1];
    sizeB[2] = 4.0;
    st.site = &m_emlrtRSI;
    repmat(&st, sizeB, b);
  } else {
    st.site = &n_emlrtRSI;
    u = (uint32_T)varargin_1->size[0];
    if ((real_T)u != (int32_T)u) {
      emlrtIntegerCheckR2012b(u, &emlrtDCI, &st);
    }

    u1 = (uint32_T)varargin_1->size[1];
    if ((real_T)u1 != (int32_T)u1) {
      emlrtIntegerCheckR2012b(u1, &emlrtDCI, &st);
    }

    u2 = varargin_1->size[2] + 4U;
    if ((real_T)u2 != (int32_T)u2) {
      emlrtIntegerCheckR2012b(u2, &emlrtDCI, &st);
    }

    i = b->size[0] * b->size[1] * b->size[2];
    b->size[0] = (int32_T)u;
    b->size[1] = (int32_T)u1;
    b->size[2] = (int32_T)u2;
    emxEnsureCapacity_boolean_T(&st, b, i, &bc_emlrtRTEI);
    i = b->size[1];
    for (j = 0; j < i; j++) {
      i1 = b->size[0];
      for (b_i = 0; b_i < i1; b_i++) {
        i2 = b_i + 1;
        if ((i2 < 1) || (i2 > b->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &jb_emlrtBCI, &st);
        }

        i3 = j + 1;
        if ((i3 < 1) || (i3 > b->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[1], &jb_emlrtBCI, &st);
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
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &jb_emlrtBCI, &st);
        }

        i3 = j + 1;
        if ((i3 < 1) || (i3 > b->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[1], &jb_emlrtBCI, &st);
        }

        b->data[((i2 + b->size[0] * (i3 - 1)) + b->size[0] * b->size[1]) - 1] =
          false;
      }
    }

    a = varargin_1->size[2] + 3;
    b_b = b->size[2];
    b_st.site = &p_emlrtRSI;
    if ((varargin_1->size[2] + 3 <= b->size[2]) && (b->size[2] > 2147483646)) {
      c_st.site = &s_emlrtRSI;
      check_forloop_overflow_error(&c_st);
    }

    for (k = a; k <= b_b; k++) {
      i = b->size[1];
      for (j = 0; j < i; j++) {
        i1 = b->size[0];
        for (b_i = 0; b_i < i1; b_i++) {
          i2 = b_i + 1;
          if ((i2 < 1) || (i2 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &cb_emlrtBCI, &st);
          }

          i3 = j + 1;
          if ((i3 < 1) || (i3 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[1], &cb_emlrtBCI, &st);
          }

          if ((k < 1) || (k > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(k, 1, b->size[2], &cb_emlrtBCI, &st);
          }

          b->data[((i2 + b->size[0] * (i3 - 1)) + b->size[0] * b->size[1] * (k -
                    1)) - 1] = false;
        }
      }
    }

    i = varargin_1->size[2];
    for (k = 0; k < i; k++) {
      a = varargin_1->size[1] + 1;
      b_b = b->size[1];
      b_st.site = &q_emlrtRSI;
      if ((varargin_1->size[1] + 1 <= b->size[1]) && (b->size[1] > 2147483646))
      {
        c_st.site = &s_emlrtRSI;
        check_forloop_overflow_error(&c_st);
      }

      for (j = a; j <= b_b; j++) {
        i1 = b->size[0];
        for (b_i = 0; b_i < i1; b_i++) {
          i2 = b_i + 1;
          if ((i2 < 1) || (i2 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &fb_emlrtBCI, &st);
          }

          if ((j < 1) || (j > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(j, 1, b->size[1], &fb_emlrtBCI, &st);
          }

          i3 = k + 3;
          if ((i3 < 1) || (i3 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &fb_emlrtBCI, &st);
          }

          b->data[((i2 + b->size[0] * (j - 1)) + b->size[0] * b->size[1] * (i3 -
                    1)) - 1] = false;
        }
      }

      i1 = varargin_1->size[1];
      for (j = 0; j < i1; j++) {
        a = varargin_1->size[0] + 1;
        b_b = b->size[0];
        b_st.site = &r_emlrtRSI;
        if ((varargin_1->size[0] + 1 <= b->size[0]) && (b->size[0] > 2147483646))
        {
          c_st.site = &s_emlrtRSI;
          check_forloop_overflow_error(&c_st);
        }

        for (b_i = a; b_i <= b_b; b_i++) {
          if ((b_i < 1) || (b_i > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(b_i, 1, b->size[0], &gb_emlrtBCI, &st);
          }

          i2 = j + 1;
          if ((i2 < 1) || (i2 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[1], &gb_emlrtBCI, &st);
          }

          i3 = k + 3;
          if ((i3 < 1) || (i3 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &gb_emlrtBCI, &st);
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
              &db_emlrtBCI, &st);
          }

          a = j + 1;
          if ((a < 1) || (a > varargin_1->size[1])) {
            emlrtDynamicBoundsCheckR2012b(a, 1, varargin_1->size[1],
              &db_emlrtBCI, &st);
          }

          b_b = k + 1;
          if ((b_b < 1) || (b_b > varargin_1->size[2])) {
            emlrtDynamicBoundsCheckR2012b(b_b, 1, varargin_1->size[2],
              &db_emlrtBCI, &st);
          }

          i4 = b_i + 1;
          if ((i4 < 1) || (i4 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i4, 1, b->size[0], &eb_emlrtBCI, &st);
          }

          i5 = j + 1;
          if ((i5 < 1) || (i5 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i5, 1, b->size[1], &eb_emlrtBCI, &st);
          }

          i6 = k + 3;
          if ((i6 < 1) || (i6 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i6, 1, b->size[2], &eb_emlrtBCI, &st);
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

void c_padarray(const emlrtStack *sp, const emxArray_real32_T *varargin_1,
                emxArray_real32_T *b)
{
  uint32_T sizeB_idx_0;
  uint32_T sizeB_idx_1;
  real_T b_varargin_1[3];
  uint32_T u;
  int32_T i;
  int32_T a;
  int32_T j;
  int32_T i1;
  int32_T b_i;
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
  if (varargin_1->size[2] == 0) {
    sizeB_idx_0 = (uint32_T)varargin_1->size[0];
    sizeB_idx_1 = (uint32_T)varargin_1->size[1];
    st.site = &m_emlrtRSI;
    b_varargin_1[0] = sizeB_idx_0;
    b_varargin_1[1] = sizeB_idx_1;
    b_varargin_1[2] = 4.0;
    b_st.site = &o_emlrtRSI;
    assertValidSizeArg(&b_st, b_varargin_1);
    i = b->size[0] * b->size[1] * b->size[2];
    b->size[0] = (int32_T)sizeB_idx_0;
    b->size[1] = (int32_T)sizeB_idx_1;
    b->size[2] = 4;
    emxEnsureCapacity_real32_T(&st, b, i, &fc_emlrtRTEI);
    a = ((int32_T)sizeB_idx_0 * (int32_T)sizeB_idx_1) << 2;
    for (i = 0; i < a; i++) {
      b->data[i] = 0.0F;
    }
  } else {
    st.site = &n_emlrtRSI;
    sizeB_idx_0 = (uint32_T)varargin_1->size[0];
    if ((real_T)sizeB_idx_0 != (int32_T)sizeB_idx_0) {
      emlrtIntegerCheckR2012b(sizeB_idx_0, &b_emlrtDCI, &st);
    }

    sizeB_idx_1 = (uint32_T)varargin_1->size[1];
    if ((real_T)sizeB_idx_1 != (int32_T)sizeB_idx_1) {
      emlrtIntegerCheckR2012b(sizeB_idx_1, &b_emlrtDCI, &st);
    }

    u = varargin_1->size[2] + 4U;
    if ((real_T)u != (int32_T)u) {
      emlrtIntegerCheckR2012b(u, &b_emlrtDCI, &st);
    }

    i = b->size[0] * b->size[1] * b->size[2];
    b->size[0] = (int32_T)sizeB_idx_0;
    b->size[1] = (int32_T)sizeB_idx_1;
    b->size[2] = (int32_T)u;
    emxEnsureCapacity_real32_T(&st, b, i, &bc_emlrtRTEI);
    i = b->size[1];
    for (j = 0; j < i; j++) {
      i1 = b->size[0];
      for (b_i = 0; b_i < i1; b_i++) {
        i2 = b_i + 1;
        if ((i2 < 1) || (i2 > b->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &jb_emlrtBCI, &st);
        }

        i3 = j + 1;
        if ((i3 < 1) || (i3 > b->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[1], &jb_emlrtBCI, &st);
        }

        b->data[(i2 + b->size[0] * (i3 - 1)) - 1] = 0.0F;
      }
    }

    i = b->size[1];
    for (j = 0; j < i; j++) {
      i1 = b->size[0];
      for (b_i = 0; b_i < i1; b_i++) {
        i2 = b_i + 1;
        if ((i2 < 1) || (i2 > b->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &jb_emlrtBCI, &st);
        }

        i3 = j + 1;
        if ((i3 < 1) || (i3 > b->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[1], &jb_emlrtBCI, &st);
        }

        b->data[((i2 + b->size[0] * (i3 - 1)) + b->size[0] * b->size[1]) - 1] =
          0.0F;
      }
    }

    a = varargin_1->size[2] + 3;
    b_b = b->size[2];
    b_st.site = &p_emlrtRSI;
    if ((varargin_1->size[2] + 3 <= b->size[2]) && (b->size[2] > 2147483646)) {
      c_st.site = &s_emlrtRSI;
      check_forloop_overflow_error(&c_st);
    }

    for (k = a; k <= b_b; k++) {
      i = b->size[1];
      for (j = 0; j < i; j++) {
        i1 = b->size[0];
        for (b_i = 0; b_i < i1; b_i++) {
          i2 = b_i + 1;
          if ((i2 < 1) || (i2 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &cb_emlrtBCI, &st);
          }

          i3 = j + 1;
          if ((i3 < 1) || (i3 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[1], &cb_emlrtBCI, &st);
          }

          if ((k < 1) || (k > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(k, 1, b->size[2], &cb_emlrtBCI, &st);
          }

          b->data[((i2 + b->size[0] * (i3 - 1)) + b->size[0] * b->size[1] * (k -
                    1)) - 1] = 0.0F;
        }
      }
    }

    i = varargin_1->size[2];
    for (k = 0; k < i; k++) {
      a = varargin_1->size[1] + 1;
      b_b = b->size[1];
      b_st.site = &q_emlrtRSI;
      if ((varargin_1->size[1] + 1 <= b->size[1]) && (b->size[1] > 2147483646))
      {
        c_st.site = &s_emlrtRSI;
        check_forloop_overflow_error(&c_st);
      }

      for (j = a; j <= b_b; j++) {
        i1 = b->size[0];
        for (b_i = 0; b_i < i1; b_i++) {
          i2 = b_i + 1;
          if ((i2 < 1) || (i2 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &fb_emlrtBCI, &st);
          }

          if ((j < 1) || (j > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(j, 1, b->size[1], &fb_emlrtBCI, &st);
          }

          i3 = k + 3;
          if ((i3 < 1) || (i3 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &fb_emlrtBCI, &st);
          }

          b->data[((i2 + b->size[0] * (j - 1)) + b->size[0] * b->size[1] * (i3 -
                    1)) - 1] = 0.0F;
        }
      }

      i1 = varargin_1->size[1];
      for (j = 0; j < i1; j++) {
        a = varargin_1->size[0] + 1;
        b_b = b->size[0];
        b_st.site = &r_emlrtRSI;
        if ((varargin_1->size[0] + 1 <= b->size[0]) && (b->size[0] > 2147483646))
        {
          c_st.site = &s_emlrtRSI;
          check_forloop_overflow_error(&c_st);
        }

        for (b_i = a; b_i <= b_b; b_i++) {
          if ((b_i < 1) || (b_i > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(b_i, 1, b->size[0], &gb_emlrtBCI, &st);
          }

          i2 = j + 1;
          if ((i2 < 1) || (i2 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[1], &gb_emlrtBCI, &st);
          }

          i3 = k + 3;
          if ((i3 < 1) || (i3 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &gb_emlrtBCI, &st);
          }

          b->data[((b_i + b->size[0] * (i2 - 1)) + b->size[0] * b->size[1] * (i3
                    - 1)) - 1] = 0.0F;
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
              &db_emlrtBCI, &st);
          }

          a = j + 1;
          if ((a < 1) || (a > varargin_1->size[1])) {
            emlrtDynamicBoundsCheckR2012b(a, 1, varargin_1->size[1],
              &db_emlrtBCI, &st);
          }

          b_b = k + 1;
          if ((b_b < 1) || (b_b > varargin_1->size[2])) {
            emlrtDynamicBoundsCheckR2012b(b_b, 1, varargin_1->size[2],
              &db_emlrtBCI, &st);
          }

          i4 = b_i + 1;
          if ((i4 < 1) || (i4 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i4, 1, b->size[0], &eb_emlrtBCI, &st);
          }

          i5 = j + 1;
          if ((i5 < 1) || (i5 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i5, 1, b->size[1], &eb_emlrtBCI, &st);
          }

          i6 = k + 3;
          if ((i6 < 1) || (i6 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i6, 1, b->size[2], &eb_emlrtBCI, &st);
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

void d_padarray(const emlrtStack *sp, const emxArray_boolean_T *varargin_1,
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
    st.site = &m_emlrtRSI;
    repmat(&st, sizeB, b);
  } else {
    st.site = &n_emlrtRSI;
    if ((real_T)varargin_1->size[0] + 4.0 != (int32_T)((real_T)varargin_1->size
         [0] + 4.0)) {
      emlrtIntegerCheckR2012b((real_T)varargin_1->size[0] + 4.0, &emlrtDCI, &st);
    }

    if ((real_T)varargin_1->size[1] + 4.0 != (int32_T)((real_T)varargin_1->size
         [1] + 4.0)) {
      emlrtIntegerCheckR2012b((real_T)varargin_1->size[1] + 4.0, &emlrtDCI, &st);
    }

    if ((real_T)varargin_1->size[2] + 4.0 != (int32_T)((real_T)varargin_1->size
         [2] + 4.0)) {
      emlrtIntegerCheckR2012b((real_T)varargin_1->size[2] + 4.0, &emlrtDCI, &st);
    }

    i = b->size[0] * b->size[1] * b->size[2];
    b->size[0] = (int32_T)(uint32_T)((real_T)varargin_1->size[0] + 4.0);
    b->size[1] = (int32_T)(uint32_T)((real_T)varargin_1->size[1] + 4.0);
    b->size[2] = (int32_T)(uint32_T)((real_T)varargin_1->size[2] + 4.0);
    emxEnsureCapacity_boolean_T(&st, b, i, &bc_emlrtRTEI);
    i = b->size[1];
    for (j = 0; j < i; j++) {
      i1 = b->size[0];
      for (b_i = 0; b_i < i1; b_i++) {
        i2 = b_i + 1;
        if ((i2 < 1) || (i2 > b->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &jb_emlrtBCI, &st);
        }

        i3 = j + 1;
        if ((i3 < 1) || (i3 > b->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[1], &jb_emlrtBCI, &st);
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
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &jb_emlrtBCI, &st);
        }

        i3 = j + 1;
        if ((i3 < 1) || (i3 > b->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[1], &jb_emlrtBCI, &st);
        }

        b->data[((i2 + b->size[0] * (i3 - 1)) + b->size[0] * b->size[1]) - 1] =
          false;
      }
    }

    a = varargin_1->size[2] + 3;
    b_b = b->size[2];
    b_st.site = &p_emlrtRSI;
    if ((varargin_1->size[2] + 3 <= b->size[2]) && (b->size[2] > 2147483646)) {
      c_st.site = &s_emlrtRSI;
      check_forloop_overflow_error(&c_st);
    }

    for (k = a; k <= b_b; k++) {
      i = b->size[1];
      for (j = 0; j < i; j++) {
        i1 = b->size[0];
        for (b_i = 0; b_i < i1; b_i++) {
          i2 = b_i + 1;
          if ((i2 < 1) || (i2 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &cb_emlrtBCI, &st);
          }

          i3 = j + 1;
          if ((i3 < 1) || (i3 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[1], &cb_emlrtBCI, &st);
          }

          if ((k < 1) || (k > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(k, 1, b->size[2], &cb_emlrtBCI, &st);
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
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &hb_emlrtBCI, &st);
        }

        i3 = k + 3;
        if ((i3 < 1) || (i3 > b->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &hb_emlrtBCI, &st);
        }

        b->data[(i2 + b->size[0] * b->size[1] * (i3 - 1)) - 1] = false;
      }

      i1 = b->size[0];
      for (b_i = 0; b_i < i1; b_i++) {
        i2 = b_i + 1;
        if ((i2 < 1) || (i2 > b->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &hb_emlrtBCI, &st);
        }

        i3 = k + 3;
        if ((i3 < 1) || (i3 > b->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &hb_emlrtBCI, &st);
        }

        b->data[((i2 + b->size[0]) + b->size[0] * b->size[1] * (i3 - 1)) - 1] =
          false;
      }

      a = varargin_1->size[1] + 3;
      b_b = b->size[1];
      b_st.site = &q_emlrtRSI;
      if ((varargin_1->size[1] + 3 <= b->size[1]) && (b->size[1] > 2147483646))
      {
        c_st.site = &s_emlrtRSI;
        check_forloop_overflow_error(&c_st);
      }

      for (j = a; j <= b_b; j++) {
        i1 = b->size[0];
        for (b_i = 0; b_i < i1; b_i++) {
          i2 = b_i + 1;
          if ((i2 < 1) || (i2 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &fb_emlrtBCI, &st);
          }

          if ((j < 1) || (j > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(j, 1, b->size[1], &fb_emlrtBCI, &st);
          }

          i3 = k + 3;
          if ((i3 < 1) || (i3 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &fb_emlrtBCI, &st);
          }

          b->data[((i2 + b->size[0] * (j - 1)) + b->size[0] * b->size[1] * (i3 -
                    1)) - 1] = false;
        }
      }

      i1 = varargin_1->size[1];
      for (j = 0; j < i1; j++) {
        i2 = j + 3;
        if ((i2 < 1) || (i2 > b->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[1], &ib_emlrtBCI, &st);
        }

        i3 = k + 3;
        if ((i3 < 1) || (i3 > b->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &ib_emlrtBCI, &st);
        }

        b->data[b->size[0] * (i2 - 1) + b->size[0] * b->size[1] * (i3 - 1)] =
          false;
        i2 = j + 3;
        if ((i2 < 1) || (i2 > b->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[1], &ib_emlrtBCI, &st);
        }

        i3 = k + 3;
        if ((i3 < 1) || (i3 > b->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &ib_emlrtBCI, &st);
        }

        b->data[(b->size[0] * (i2 - 1) + b->size[0] * b->size[1] * (i3 - 1)) + 1]
          = false;
      }

      i1 = varargin_1->size[1];
      for (j = 0; j < i1; j++) {
        a = varargin_1->size[0] + 3;
        b_b = b->size[0];
        b_st.site = &r_emlrtRSI;
        if ((varargin_1->size[0] + 3 <= b->size[0]) && (b->size[0] > 2147483646))
        {
          c_st.site = &s_emlrtRSI;
          check_forloop_overflow_error(&c_st);
        }

        for (b_i = a; b_i <= b_b; b_i++) {
          if ((b_i < 1) || (b_i > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(b_i, 1, b->size[0], &gb_emlrtBCI, &st);
          }

          i2 = j + 3;
          if ((i2 < 1) || (i2 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[1], &gb_emlrtBCI, &st);
          }

          i3 = k + 3;
          if ((i3 < 1) || (i3 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &gb_emlrtBCI, &st);
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
              &db_emlrtBCI, &st);
          }

          a = j + 1;
          if ((a < 1) || (a > varargin_1->size[1])) {
            emlrtDynamicBoundsCheckR2012b(a, 1, varargin_1->size[1],
              &db_emlrtBCI, &st);
          }

          b_b = k + 1;
          if ((b_b < 1) || (b_b > varargin_1->size[2])) {
            emlrtDynamicBoundsCheckR2012b(b_b, 1, varargin_1->size[2],
              &db_emlrtBCI, &st);
          }

          i4 = b_i + 3;
          if ((i4 < 1) || (i4 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i4, 1, b->size[0], &eb_emlrtBCI, &st);
          }

          i5 = j + 3;
          if ((i5 < 1) || (i5 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i5, 1, b->size[1], &eb_emlrtBCI, &st);
          }

          i6 = k + 3;
          if ((i6 < 1) || (i6 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i6, 1, b->size[2], &eb_emlrtBCI, &st);
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
  uint32_T u;
  uint32_T u1;
  uint32_T u2;
  int32_T i;
  int32_T a;
  int32_T b_b;
  int32_T k;
  int32_T j;
  int32_T i1;
  int32_T b_i;
  int32_T i2;
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
    sizeB[0] = varargin_1->size[0] + 4U;
    sizeB[1] = varargin_1->size[1] + 4U;
    sizeB[2] = (uint32_T)varargin_1->size[2];
    st.site = &m_emlrtRSI;
    repmat(&st, sizeB, b);
  } else {
    st.site = &n_emlrtRSI;
    u = varargin_1->size[0] + 4U;
    if ((real_T)u != (int32_T)u) {
      emlrtIntegerCheckR2012b(u, &emlrtDCI, &st);
    }

    u1 = varargin_1->size[1] + 4U;
    if ((real_T)u1 != (int32_T)u1) {
      emlrtIntegerCheckR2012b(u1, &emlrtDCI, &st);
    }

    u2 = (uint32_T)varargin_1->size[2];
    if ((real_T)u2 != (int32_T)u2) {
      emlrtIntegerCheckR2012b(u2, &emlrtDCI, &st);
    }

    i = b->size[0] * b->size[1] * b->size[2];
    b->size[0] = (int32_T)u;
    b->size[1] = (int32_T)u1;
    b->size[2] = (int32_T)u2;
    emxEnsureCapacity_boolean_T(&st, b, i, &bc_emlrtRTEI);
    a = varargin_1->size[2] + 1;
    b_b = (int32_T)u2;
    b_st.site = &p_emlrtRSI;
    if ((varargin_1->size[2] + 1 <= (int32_T)u2) && ((int32_T)u2 > 2147483646))
    {
      c_st.site = &s_emlrtRSI;
      check_forloop_overflow_error(&c_st);
    }

    for (k = a; k <= b_b; k++) {
      i = b->size[1];
      for (j = 0; j < i; j++) {
        i1 = b->size[0];
        for (b_i = 0; b_i < i1; b_i++) {
          i2 = b_i + 1;
          if ((i2 < 1) || (i2 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &cb_emlrtBCI, &st);
          }

          i3 = j + 1;
          if ((i3 < 1) || (i3 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[1], &cb_emlrtBCI, &st);
          }

          if ((k < 1) || (k > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(k, 1, b->size[2], &cb_emlrtBCI, &st);
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
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &hb_emlrtBCI, &st);
        }

        i3 = k + 1;
        if ((i3 < 1) || (i3 > b->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &hb_emlrtBCI, &st);
        }

        b->data[(i2 + b->size[0] * b->size[1] * (i3 - 1)) - 1] = false;
      }

      i1 = b->size[0];
      for (b_i = 0; b_i < i1; b_i++) {
        i2 = b_i + 1;
        if ((i2 < 1) || (i2 > b->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &hb_emlrtBCI, &st);
        }

        i3 = k + 1;
        if ((i3 < 1) || (i3 > b->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &hb_emlrtBCI, &st);
        }

        b->data[((i2 + b->size[0]) + b->size[0] * b->size[1] * (i3 - 1)) - 1] =
          false;
      }

      a = varargin_1->size[1] + 3;
      b_b = b->size[1];
      b_st.site = &q_emlrtRSI;
      if ((varargin_1->size[1] + 3 <= b->size[1]) && (b->size[1] > 2147483646))
      {
        c_st.site = &s_emlrtRSI;
        check_forloop_overflow_error(&c_st);
      }

      for (j = a; j <= b_b; j++) {
        i1 = b->size[0];
        for (b_i = 0; b_i < i1; b_i++) {
          i2 = b_i + 1;
          if ((i2 < 1) || (i2 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[0], &fb_emlrtBCI, &st);
          }

          if ((j < 1) || (j > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(j, 1, b->size[1], &fb_emlrtBCI, &st);
          }

          i3 = k + 1;
          if ((i3 < 1) || (i3 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &fb_emlrtBCI, &st);
          }

          b->data[((i2 + b->size[0] * (j - 1)) + b->size[0] * b->size[1] * (i3 -
                    1)) - 1] = false;
        }
      }

      i1 = varargin_1->size[1];
      for (j = 0; j < i1; j++) {
        i2 = j + 3;
        if ((i2 < 1) || (i2 > b->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[1], &ib_emlrtBCI, &st);
        }

        i3 = k + 1;
        if ((i3 < 1) || (i3 > b->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &ib_emlrtBCI, &st);
        }

        b->data[b->size[0] * (i2 - 1) + b->size[0] * b->size[1] * (i3 - 1)] =
          false;
        i2 = j + 3;
        if ((i2 < 1) || (i2 > b->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[1], &ib_emlrtBCI, &st);
        }

        i3 = k + 1;
        if ((i3 < 1) || (i3 > b->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &ib_emlrtBCI, &st);
        }

        b->data[(b->size[0] * (i2 - 1) + b->size[0] * b->size[1] * (i3 - 1)) + 1]
          = false;
      }

      i1 = varargin_1->size[1];
      for (j = 0; j < i1; j++) {
        a = varargin_1->size[0] + 3;
        b_b = b->size[0];
        b_st.site = &r_emlrtRSI;
        if ((varargin_1->size[0] + 3 <= b->size[0]) && (b->size[0] > 2147483646))
        {
          c_st.site = &s_emlrtRSI;
          check_forloop_overflow_error(&c_st);
        }

        for (b_i = a; b_i <= b_b; b_i++) {
          if ((b_i < 1) || (b_i > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(b_i, 1, b->size[0], &gb_emlrtBCI, &st);
          }

          i2 = j + 3;
          if ((i2 < 1) || (i2 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, b->size[1], &gb_emlrtBCI, &st);
          }

          i3 = k + 1;
          if ((i3 < 1) || (i3 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, b->size[2], &gb_emlrtBCI, &st);
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
              &db_emlrtBCI, &st);
          }

          a = j + 1;
          if ((a < 1) || (a > varargin_1->size[1])) {
            emlrtDynamicBoundsCheckR2012b(a, 1, varargin_1->size[1],
              &db_emlrtBCI, &st);
          }

          b_b = k + 1;
          if ((b_b < 1) || (b_b > varargin_1->size[2])) {
            emlrtDynamicBoundsCheckR2012b(b_b, 1, varargin_1->size[2],
              &db_emlrtBCI, &st);
          }

          i4 = b_i + 3;
          if ((i4 < 1) || (i4 > b->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i4, 1, b->size[0], &eb_emlrtBCI, &st);
          }

          i5 = j + 3;
          if ((i5 < 1) || (i5 > b->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i5, 1, b->size[1], &eb_emlrtBCI, &st);
          }

          i6 = k + 1;
          if ((i6 < 1) || (i6 > b->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i6, 1, b->size[2], &eb_emlrtBCI, &st);
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

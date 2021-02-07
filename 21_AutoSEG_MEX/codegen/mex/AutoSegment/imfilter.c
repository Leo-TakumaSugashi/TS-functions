/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * imfilter.c
 *
 * Code generation for function 'imfilter'
 *
 */

/* Include files */
#include "imfilter.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "assertValidSizeArg.h"
#include "eml_int_forloop_overflow_check.h"
#include "libmwimfilter.h"
#include "mwmathutil.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo pc_emlrtRSI = { 773,/* lineNo */
  "padImage",                          /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/imfilter.m"/* pathName */
};

static emlrtDCInfo emlrtDCI = { 253,   /* lineNo */
  35,                                  /* colNo */
  "ConstantPad",                       /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  1                                    /* checkKind */
};

static emlrtRTEInfo xd_emlrtRTEI = { 773,/* lineNo */
  5,                                   /* colNo */
  "imfilter",                          /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/imfilter.m"/* pName */
};

/* Function Definitions */
void imfilter(const emlrtStack *sp, emxArray_uint8_T *varargin_1)
{
  real_T outSizeT[3];
  real_T startT[3];
  emxArray_uint8_T *a;
  int32_T k;
  real_T padSizeT[3];
  int32_T i;
  real_T nonZeroKernel[27];
  real_T connDimsT[3];
  boolean_T conn[27];
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
  outSizeT[0] = varargin_1->size[0];
  startT[0] = 1.0;
  outSizeT[1] = varargin_1->size[1];
  startT[1] = 1.0;
  outSizeT[2] = varargin_1->size[2];
  startT[2] = 1.0;
  if ((varargin_1->size[0] != 0) && (varargin_1->size[1] != 0) &&
      (varargin_1->size[2] != 0)) {
    emxInit_uint8_T(sp, &a, 3, &vd_emlrtRTEI, true);
    st.site = &nc_emlrtRSI;
    padImage(&st, varargin_1, startT, a);
    st.site = &oc_emlrtRSI;
    b_st.site = &yc_emlrtRSI;
    c_st.site = &ad_emlrtRSI;
    k = varargin_1->size[0] * varargin_1->size[1] * varargin_1->size[2];
    varargin_1->size[0] = (int32_T)outSizeT[0];
    varargin_1->size[1] = (int32_T)outSizeT[1];
    varargin_1->size[2] = (int32_T)outSizeT[2];
    emxEnsureCapacity_uint8_T(&c_st, varargin_1, k, &rd_emlrtRTEI);
    k = 3;
    if (a->size[2] == 1) {
      k = 2;
    }

    padSizeT[0] = a->size[0];
    padSizeT[1] = a->size[1];
    padSizeT[2] = a->size[2];
    for (i = 0; i < 27; i++) {
      nonZeroKernel[i] = 1.0;
      conn[i] = true;
    }

    connDimsT[0] = 3.0;
    connDimsT[1] = 3.0;
    connDimsT[2] = 3.0;
    imfilter_uint8(&a->data[0], &varargin_1->data[0], 3.0, outSizeT, (real_T)k,
                   padSizeT, nonZeroKernel, 27.0, conn, 3.0, connDimsT, startT,
                   3.0, true, false);
    emxFree_uint8_T(&a);
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void padImage(const emlrtStack *sp, const emxArray_uint8_T *a_tmp, const real_T
              pad[3], emxArray_uint8_T *a)
{
  real_T sizeB_idx_0;
  real_T sizeB_idx_1;
  real_T sizeB_idx_2;
  real_T varargin_1[3];
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T i3;
  int32_T j;
  int32_T b_a;
  int32_T b;
  int32_T b_i;
  int32_T k;
  int32_T i4;
  int32_T i5;
  int32_T i6;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &pc_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  b_st.site = &qc_emlrtRSI;
  c_st.site = &tc_emlrtRSI;
  c_st.site = &tc_emlrtRSI;
  c_st.site = &tc_emlrtRSI;
  if ((a_tmp->size[0] == 0) || (a_tmp->size[1] == 0) || (a_tmp->size[2] == 0)) {
    sizeB_idx_0 = (real_T)a_tmp->size[0] + 2.0 * pad[0];
    sizeB_idx_1 = (real_T)a_tmp->size[1] + 2.0 * pad[1];
    sizeB_idx_2 = (real_T)a_tmp->size[2] + 2.0 * pad[2];
    b_st.site = &rc_emlrtRSI;
    varargin_1[0] = sizeB_idx_0;
    varargin_1[1] = sizeB_idx_1;
    varargin_1[2] = sizeB_idx_2;
    c_st.site = &uc_emlrtRSI;
    assertValidSizeArg(&c_st, varargin_1);
    i = (int32_T)sizeB_idx_0;
    i1 = a->size[0] * a->size[1] * a->size[2];
    a->size[0] = i;
    i2 = (int32_T)sizeB_idx_1;
    a->size[1] = i2;
    i3 = (int32_T)sizeB_idx_2;
    a->size[2] = i3;
    emxEnsureCapacity_uint8_T(&b_st, a, i1, &xd_emlrtRTEI);
    b_a = i * i2 * i3;
    for (i = 0; i < b_a; i++) {
      a->data[i] = 0U;
    }
  } else {
    b_st.site = &sc_emlrtRSI;
    sizeB_idx_0 = (real_T)a_tmp->size[0] + 2.0 * pad[0];
    if (sizeB_idx_0 != (int32_T)muDoubleScalarFloor(sizeB_idx_0)) {
      emlrtIntegerCheckR2012b(sizeB_idx_0, &emlrtDCI, &b_st);
    }

    sizeB_idx_1 = (real_T)a_tmp->size[1] + 2.0 * pad[1];
    if (sizeB_idx_1 != (int32_T)muDoubleScalarFloor(sizeB_idx_1)) {
      emlrtIntegerCheckR2012b(sizeB_idx_1, &emlrtDCI, &b_st);
    }

    sizeB_idx_2 = (real_T)a_tmp->size[2] + 2.0 * pad[2];
    if (sizeB_idx_2 != (int32_T)muDoubleScalarFloor(sizeB_idx_2)) {
      emlrtIntegerCheckR2012b(sizeB_idx_2, &emlrtDCI, &b_st);
    }

    i = a->size[0] * a->size[1] * a->size[2];
    a->size[0] = (int32_T)sizeB_idx_0;
    a->size[1] = (int32_T)sizeB_idx_1;
    a->size[2] = (int32_T)sizeB_idx_2;
    emxEnsureCapacity_uint8_T(&b_st, a, i, &wd_emlrtRTEI);
    i = a->size[1];
    for (j = 0; j < i; j++) {
      i1 = a->size[0];
      for (b_i = 0; b_i < i1; b_i++) {
        i2 = b_i + 1;
        if ((i2 < 1) || (i2 > a->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, a->size[0], &uc_emlrtBCI, &b_st);
        }

        i3 = j + 1;
        if ((i3 < 1) || (i3 > a->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, a->size[1], &uc_emlrtBCI, &b_st);
        }

        a->data[(i2 + a->size[0] * (i3 - 1)) - 1] = 0U;
      }
    }

    b_a = a_tmp->size[2] + 2;
    b = a->size[2];
    c_st.site = &vc_emlrtRSI;
    if ((a_tmp->size[2] + 2 <= a->size[2]) && (a->size[2] > 2147483646)) {
      d_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&d_st);
    }

    for (k = b_a; k <= b; k++) {
      i = a->size[1];
      for (j = 0; j < i; j++) {
        i1 = a->size[0];
        for (b_i = 0; b_i < i1; b_i++) {
          i2 = b_i + 1;
          if ((i2 < 1) || (i2 > a->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, a->size[0], &pc_emlrtBCI, &b_st);
          }

          i3 = j + 1;
          if ((i3 < 1) || (i3 > a->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, a->size[1], &pc_emlrtBCI, &b_st);
          }

          if ((k < 1) || (k > a->size[2])) {
            emlrtDynamicBoundsCheckR2012b(k, 1, a->size[2], &pc_emlrtBCI, &b_st);
          }

          a->data[((i2 + a->size[0] * (i3 - 1)) + a->size[0] * a->size[1] * (k -
                    1)) - 1] = 0U;
        }
      }
    }

    i = a_tmp->size[2];
    for (k = 0; k < i; k++) {
      i1 = a->size[0];
      for (b_i = 0; b_i < i1; b_i++) {
        i2 = b_i + 1;
        if ((i2 < 1) || (i2 > a->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, a->size[0], &vc_emlrtBCI, &b_st);
        }

        i3 = k + 2;
        if ((i3 < 1) || (i3 > a->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, a->size[2], &vc_emlrtBCI, &b_st);
        }

        a->data[(i2 + a->size[0] * a->size[1] * (i3 - 1)) - 1] = 0U;
      }

      b_a = a_tmp->size[1] + 2;
      b = a->size[1];
      c_st.site = &wc_emlrtRSI;
      if ((a_tmp->size[1] + 2 <= a->size[1]) && (a->size[1] > 2147483646)) {
        d_st.site = &i_emlrtRSI;
        check_forloop_overflow_error(&d_st);
      }

      for (j = b_a; j <= b; j++) {
        i1 = a->size[0];
        for (b_i = 0; b_i < i1; b_i++) {
          i2 = b_i + 1;
          if ((i2 < 1) || (i2 > a->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, a->size[0], &sc_emlrtBCI, &b_st);
          }

          if ((j < 1) || (j > a->size[1])) {
            emlrtDynamicBoundsCheckR2012b(j, 1, a->size[1], &sc_emlrtBCI, &b_st);
          }

          i3 = k + 2;
          if ((i3 < 1) || (i3 > a->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, a->size[2], &sc_emlrtBCI, &b_st);
          }

          a->data[((i2 + a->size[0] * (j - 1)) + a->size[0] * a->size[1] * (i3 -
                    1)) - 1] = 0U;
        }
      }

      i1 = a_tmp->size[1];
      for (j = 0; j < i1; j++) {
        i2 = j + 2;
        if ((i2 < 1) || (i2 > a->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, a->size[1], &wc_emlrtBCI, &b_st);
        }

        i3 = k + 2;
        if ((i3 < 1) || (i3 > a->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, a->size[2], &wc_emlrtBCI, &b_st);
        }

        a->data[a->size[0] * (i2 - 1) + a->size[0] * a->size[1] * (i3 - 1)] = 0U;
      }

      i1 = a_tmp->size[1];
      for (j = 0; j < i1; j++) {
        b_a = a_tmp->size[0] + 2;
        b = a->size[0];
        c_st.site = &xc_emlrtRSI;
        if ((a_tmp->size[0] + 2 <= a->size[0]) && (a->size[0] > 2147483646)) {
          d_st.site = &i_emlrtRSI;
          check_forloop_overflow_error(&d_st);
        }

        for (b_i = b_a; b_i <= b; b_i++) {
          if ((b_i < 1) || (b_i > a->size[0])) {
            emlrtDynamicBoundsCheckR2012b(b_i, 1, a->size[0], &tc_emlrtBCI,
              &b_st);
          }

          i2 = j + 2;
          if ((i2 < 1) || (i2 > a->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, a->size[1], &tc_emlrtBCI, &b_st);
          }

          i3 = k + 2;
          if ((i3 < 1) || (i3 > a->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, a->size[2], &tc_emlrtBCI, &b_st);
          }

          a->data[((b_i + a->size[0] * (i2 - 1)) + a->size[0] * a->size[1] * (i3
                    - 1)) - 1] = 0U;
        }
      }
    }

    i = a_tmp->size[2];
    for (k = 0; k < i; k++) {
      i1 = a_tmp->size[1];
      for (j = 0; j < i1; j++) {
        i2 = a_tmp->size[0];
        for (b_i = 0; b_i < i2; b_i++) {
          i3 = b_i + 1;
          if ((i3 < 1) || (i3 > a_tmp->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, a_tmp->size[0], &qc_emlrtBCI,
              &b_st);
          }

          b_a = j + 1;
          if ((b_a < 1) || (b_a > a_tmp->size[1])) {
            emlrtDynamicBoundsCheckR2012b(b_a, 1, a_tmp->size[1], &qc_emlrtBCI,
              &b_st);
          }

          b = k + 1;
          if ((b < 1) || (b > a_tmp->size[2])) {
            emlrtDynamicBoundsCheckR2012b(b, 1, a_tmp->size[2], &qc_emlrtBCI,
              &b_st);
          }

          i4 = b_i + 2;
          if ((i4 < 1) || (i4 > a->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i4, 1, a->size[0], &rc_emlrtBCI, &b_st);
          }

          i5 = j + 2;
          if ((i5 < 1) || (i5 > a->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i5, 1, a->size[1], &rc_emlrtBCI, &b_st);
          }

          i6 = k + 2;
          if ((i6 < 1) || (i6 > a->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i6, 1, a->size[2], &rc_emlrtBCI, &b_st);
          }

          a->data[((i4 + a->size[0] * (i5 - 1)) + a->size[0] * a->size[1] * (i6
                    - 1)) - 1] = a_tmp->data[((i3 + a_tmp->size[0] * (b_a - 1))
            + a_tmp->size[0] * a_tmp->size[1] * (b - 1)) - 1];
        }
      }
    }
  }
}

/* End of code generation (imfilter.c) */

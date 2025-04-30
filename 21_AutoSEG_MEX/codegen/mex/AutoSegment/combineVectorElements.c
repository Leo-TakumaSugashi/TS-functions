/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * combineVectorElements.c
 *
 * Code generation for function 'combineVectorElements'
 *
 */

/* Include files */
#include "combineVectorElements.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "eml_int_forloop_overflow_check.h"
#include "rt_nonfinite.h"

/* Function Definitions */
int32_T b_combineVectorElements(const emlrtStack *sp, const emxArray_boolean_T
  *x)
{
  int32_T y;
  int32_T vlen;
  int32_T k;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  vlen = x->size[0];
  if (x->size[0] == 0) {
    y = 0;
  } else {
    st.site = &se_emlrtRSI;
    y = x->data[0];
    b_st.site = &ve_emlrtRSI;
    if ((2 <= x->size[0]) && (x->size[0] > 2147483646)) {
      c_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&c_st);
    }

    for (k = 2; k <= vlen; k++) {
      y += x->data[k - 1];
    }
  }

  return y;
}

void combineVectorElements(const boolean_T x_data[], const int32_T x_size[2],
  int32_T y_data[], int32_T y_size[1])
{
  int32_T vstride;
  int32_T j;
  int32_T xoffset;
  if (x_size[0] == 0) {
    y_size[0] = 0;
  } else {
    vstride = x_size[0];
    y_size[0] = (int16_T)x_size[0];
    for (j = 0; j < vstride; j++) {
      y_data[j] = x_data[j];
    }

    for (j = 0; j < vstride; j++) {
      y_data[j] += x_data[vstride + j];
    }

    xoffset = 2 * x_size[0];
    for (j = 0; j < vstride; j++) {
      y_data[j] += x_data[xoffset + j];
    }
  }
}

/* End of code generation (combineVectorElements.c) */

/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * ind2sub.c
 *
 * Code generation for function 'ind2sub'
 *
 */

/* Include files */
#include "ind2sub.h"
#include "TS_Skeleton3D.h"
#include "TS_Skeleton3D_data.h"
#include "TS_Skeleton3D_emxutil.h"
#include "TS_Skeleton3D_mexutil.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRTEInfo ic_emlrtRTEI = { 30,/* lineNo */
  1,                                   /* colNo */
  "ind2sub",                           /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/ind2sub.m"/* pName */
};

/* Function Definitions */
void b_ind2sub_indexClass(const emlrtStack *sp, const real_T ndx_data[], const
  int32_T ndx_size[1], int32_T varargout_1_data[], int32_T varargout_1_size[1],
  int32_T varargout_2_data[], int32_T varargout_2_size[1], int32_T
  varargout_3_data[], int32_T varargout_3_size[1])
{
  int32_T loop_ub;
  int32_T i;
  boolean_T exitg1;
  varargout_1_size[0] = ndx_size[0];
  loop_ub = ndx_size[0];
  for (i = 0; i < loop_ub; i++) {
    varargout_1_data[i] = (int32_T)ndx_data[i];
  }

  loop_ub = 0;
  exitg1 = false;
  while ((!exitg1) && (loop_ub <= varargout_1_size[0] - 1)) {
    if ((varargout_1_data[loop_ub] >= 1) && (varargout_1_data[loop_ub] <= 27)) {
      loop_ub++;
    } else {
      emlrtErrorWithMessageIdR2018a(sp, &emlrtRTEI,
        "Coder:MATLAB:ind2sub_IndexOutOfRange",
        "Coder:MATLAB:ind2sub_IndexOutOfRange", 0);
    }
  }

  loop_ub = ndx_size[0];
  for (i = 0; i < loop_ub; i++) {
    varargout_1_data[i]--;
  }

  varargout_3_size[0] = ndx_size[0];
  loop_ub = ndx_size[0];
  for (i = 0; i < loop_ub; i++) {
    varargout_3_data[i] = varargout_1_data[i] / 9 + 1;
  }

  loop_ub = ndx_size[0];
  for (i = 0; i < loop_ub; i++) {
    varargout_1_data[i] -= varargout_1_data[i] / 9 * 9;
  }

  varargout_2_size[0] = ndx_size[0];
  loop_ub = ndx_size[0];
  for (i = 0; i < loop_ub; i++) {
    varargout_2_data[i] = varargout_1_data[i] / 3 + 1;
  }

  loop_ub = ndx_size[0];
  for (i = 0; i < loop_ub; i++) {
    varargout_1_data[i] -= varargout_1_data[i] / 3 * 3;
  }

  loop_ub = ndx_size[0];
  for (i = 0; i < loop_ub; i++) {
    varargout_1_data[i]++;
  }
}

void ind2sub_indexClass(const emlrtStack *sp, const real_T siz[3], const
  emxArray_real_T *ndx, emxArray_int32_T *varargout_1, emxArray_int32_T
  *varargout_2, emxArray_int32_T *varargout_3)
{
  int32_T hi;
  int32_T loop_ub;
  int32_T cpsiz_idx_0;
  int32_T cpsiz_idx_1;
  boolean_T exitg1;
  emxArray_int32_T *vk;
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  hi = varargout_1->size[0];
  varargout_1->size[0] = ndx->size[0];
  emxEnsureCapacity_int32_T(sp, varargout_1, hi, &ic_emlrtRTEI);
  loop_ub = ndx->size[0];
  for (hi = 0; hi < loop_ub; hi++) {
    varargout_1->data[hi] = (int32_T)ndx->data[hi];
  }

  cpsiz_idx_0 = (int32_T)siz[0];
  cpsiz_idx_1 = (int32_T)siz[1] * cpsiz_idx_0;
  hi = cpsiz_idx_1 * (int32_T)siz[2];
  loop_ub = 0;
  exitg1 = false;
  while ((!exitg1) && (loop_ub <= varargout_1->size[0] - 1)) {
    if ((varargout_1->data[loop_ub] >= 1) && (varargout_1->data[loop_ub] <= hi))
    {
      loop_ub++;
    } else {
      emlrtErrorWithMessageIdR2018a(sp, &emlrtRTEI,
        "Coder:MATLAB:ind2sub_IndexOutOfRange",
        "Coder:MATLAB:ind2sub_IndexOutOfRange", 0);
    }
  }

  loop_ub = varargout_1->size[0];
  for (hi = 0; hi < loop_ub; hi++) {
    varargout_1->data[hi]--;
  }

  emxInit_int32_T(sp, &vk, 1, &x_emlrtRTEI, true);
  hi = vk->size[0];
  vk->size[0] = varargout_1->size[0];
  emxEnsureCapacity_int32_T(sp, vk, hi, &x_emlrtRTEI);
  loop_ub = varargout_1->size[0];
  for (hi = 0; hi < loop_ub; hi++) {
    st.site = &hd_emlrtRSI;
    vk->data[hi] = div_s32(&st, varargout_1->data[hi], cpsiz_idx_1);
  }

  hi = varargout_3->size[0];
  varargout_3->size[0] = vk->size[0];
  emxEnsureCapacity_int32_T(sp, varargout_3, hi, &y_emlrtRTEI);
  loop_ub = vk->size[0];
  for (hi = 0; hi < loop_ub; hi++) {
    varargout_3->data[hi] = vk->data[hi] + 1;
  }

  loop_ub = varargout_1->size[0];
  for (hi = 0; hi < loop_ub; hi++) {
    varargout_1->data[hi] -= vk->data[hi] * cpsiz_idx_1;
  }

  hi = vk->size[0];
  vk->size[0] = varargout_1->size[0];
  emxEnsureCapacity_int32_T(sp, vk, hi, &x_emlrtRTEI);
  loop_ub = varargout_1->size[0];
  for (hi = 0; hi < loop_ub; hi++) {
    st.site = &hd_emlrtRSI;
    vk->data[hi] = div_s32(&st, varargout_1->data[hi], cpsiz_idx_0);
  }

  hi = varargout_2->size[0];
  varargout_2->size[0] = vk->size[0];
  emxEnsureCapacity_int32_T(sp, varargout_2, hi, &y_emlrtRTEI);
  loop_ub = vk->size[0];
  for (hi = 0; hi < loop_ub; hi++) {
    varargout_2->data[hi] = vk->data[hi] + 1;
  }

  loop_ub = varargout_1->size[0];
  for (hi = 0; hi < loop_ub; hi++) {
    varargout_1->data[hi] -= vk->data[hi] * cpsiz_idx_0;
  }

  emxFree_int32_T(&vk);
  loop_ub = varargout_1->size[0];
  for (hi = 0; hi < loop_ub; hi++) {
    varargout_1->data[hi]++;
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (ind2sub.c) */

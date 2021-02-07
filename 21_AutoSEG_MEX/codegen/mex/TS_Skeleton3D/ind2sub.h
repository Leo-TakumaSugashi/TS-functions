/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * ind2sub.h
 *
 * Code generation for function 'ind2sub'
 *
 */

#pragma once

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mex.h"
#include "emlrt.h"
#include "rtwtypes.h"
#include "TS_Skeleton3D_types.h"

/* Function Declarations */
void b_ind2sub_indexClass(const emlrtStack *sp, const real_T ndx_data[], const
  int32_T ndx_size[1], int32_T varargout_1_data[], int32_T varargout_1_size[1],
  int32_T varargout_2_data[], int32_T varargout_2_size[1], int32_T
  varargout_3_data[], int32_T varargout_3_size[1]);
void ind2sub_indexClass(const emlrtStack *sp, const real_T siz[3], const
  emxArray_real_T *ndx, emxArray_int32_T *varargout_1, emxArray_int32_T
  *varargout_2, emxArray_int32_T *varargout_3);

/* End of code generation (ind2sub.h) */

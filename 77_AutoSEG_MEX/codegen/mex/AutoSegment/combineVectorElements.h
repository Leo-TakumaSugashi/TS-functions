/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * combineVectorElements.h
 *
 * Code generation for function 'combineVectorElements'
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
#include "AutoSegment_types.h"

/* Function Declarations */
int32_T b_combineVectorElements(const emlrtStack *sp, const emxArray_boolean_T
  *x);
void combineVectorElements(const boolean_T x_data[], const int32_T x_size[2],
  int32_T y_data[], int32_T y_size[1]);

/* End of code generation (combineVectorElements.h) */

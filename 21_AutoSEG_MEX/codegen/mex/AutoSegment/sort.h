/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sort.h
 *
 * Code generation for function 'sort'
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
void b_sort(const emlrtStack *sp, emxArray_real_T *x, emxArray_int32_T *idx);
void c_sort(const emlrtStack *sp, emxArray_real_T *x, emxArray_int32_T *idx);
void sort(const emlrtStack *sp, emxArray_real32_T *x);

/* End of code generation (sort.h) */

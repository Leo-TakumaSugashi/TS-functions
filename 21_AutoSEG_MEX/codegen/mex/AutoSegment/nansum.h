/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * nansum.h
 *
 * Code generation for function 'nansum'
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
real_T b_nansum(const real_T varargin_1[2047]);
real_T c_nansum(const emlrtStack *sp, const emxArray_real_T *varargin_1);
void nansum(const emlrtStack *sp, const real_T varargin_1[6141], real_T y[2047]);

/* End of code generation (nansum.h) */

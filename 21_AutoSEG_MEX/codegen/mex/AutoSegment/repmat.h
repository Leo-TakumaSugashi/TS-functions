/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * repmat.h
 *
 * Code generation for function 'repmat'
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
void b_repmat(const emlrtStack *sp, const real_T a[3], const real_T varargin_1[2],
              emxArray_real_T *b);
void c_repmat(const real_T a[3], real_T b[6141]);
void repmat(const emlrtStack *sp, const real_T varargin_1[3], emxArray_boolean_T
            *b);

/* End of code generation (repmat.h) */

/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * padarray.h
 *
 * Code generation for function 'padarray'
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
void b_padarray(const emlrtStack *sp, const real_T varargin_1[3], const real_T
                varargin_2[2], emxArray_real_T *b);
void c_padarray(const emlrtStack *sp, const emxArray_boolean_T *varargin_1,
                emxArray_boolean_T *b);
void padarray(const emlrtStack *sp, const emxArray_boolean_T *varargin_1,
              emxArray_boolean_T *b);

/* End of code generation (padarray.h) */

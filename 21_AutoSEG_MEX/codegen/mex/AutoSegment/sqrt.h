/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sqrt.h
 *
 * Code generation for function 'sqrt'
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
void b_sqrt(const emlrtStack *sp, emxArray_real_T *x);
void c_sqrt(const emlrtStack *sp, emxArray_real32_T *x);
void d_sqrt(const emlrtStack *sp, real_T x[2047]);

/* End of code generation (sqrt.h) */

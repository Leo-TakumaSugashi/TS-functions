/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * power.h
 *
 * Code generation for function 'power'
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
void b_power(const real_T a[6141], real_T y[6141]);
void c_power(const real_T a[3], real_T y[3]);
void power(const emlrtStack *sp, const emxArray_real_T *a, emxArray_real_T *y);

/* End of code generation (power.h) */

/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * cat.h
 *
 * Code generation for function 'cat'
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
void b_cat(const emlrtStack *sp, const emxArray_real_T *varargin_1, const
           emxArray_real_T *varargin_2, const emxArray_real_T *varargin_3,
           emxArray_real_T *y);
void c_cat(const emlrtStack *sp, const emxArray_real_T *varargin_1, const
           emxArray_real_T *varargin_2, const emxArray_real_T *varargin_3, const
           emxArray_real_T *varargin_4, const emxArray_real_T *varargin_5,
           emxArray_real_T *y);
void cat(const emlrtStack *sp, const emxArray_boolean_T *varargin_1, const
         emxArray_boolean_T *varargin_2, emxArray_boolean_T *y);
void d_cat(real_T varargin_1, real_T varargin_2, real_T y[2]);
void e_cat(const emlrtStack *sp, const real_T varargin_1[3], const
           emxArray_real_T *varargin_2, const real_T varargin_3[3],
           emxArray_real_T *y);
void f_cat(const real_T varargin_1[3], const real_T varargin_2[3], real_T y[6]);

/* End of code generation (cat.h) */

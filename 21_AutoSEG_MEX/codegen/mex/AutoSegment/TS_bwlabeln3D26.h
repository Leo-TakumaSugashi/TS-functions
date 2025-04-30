/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * TS_bwlabeln3D26.h
 *
 * Code generation for function 'TS_bwlabeln3D26'
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
void TS_bwlabeln3D26(const emlrtStack *sp, const emxArray_boolean_T *bw,
                     emxArray_real_T *L);
void TS_bwlabeln_linux_c(const emlrtStack *sp, const boolean_T bw[27], real_T L
  [27], real_T *Num);
void b_TS_bwlabeln3D26(const emlrtStack *sp, const boolean_T bw[125], real_T L
  [125], real_T *Num);
void c_TS_bwlabeln3D26(const emlrtStack *sp, const emxArray_boolean_T *bw,
  emxArray_real_T *L, real_T *Num);

/* End of code generation (TS_bwlabeln3D26.h) */

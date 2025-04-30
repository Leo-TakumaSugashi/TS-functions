/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * xyz2plen.h
 *
 * Code generation for function 'xyz2plen'
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
void xyz2plen(const emlrtStack *sp, const emxArray_real_T *xyz, const real_T
              Reso[3], emxArray_real_T *PieceLength);

/* End of code generation (xyz2plen.h) */

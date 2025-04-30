/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * AutoSegment.h
 *
 * Code generation for function 'AutoSegment'
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
void AutoSegment(AutoSegmentStackData *SD, const emlrtStack *sp,
                 emxArray_boolean_T *skel, const real_T NewReso[3],
                 emxArray_boolean_T *AddBP, real_T cutlen, struct0_T *SEG);

/* End of code generation (AutoSegment.h) */

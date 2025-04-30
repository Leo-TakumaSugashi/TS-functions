/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * AtSEG_shaving.h
 *
 * Code generation for function 'AtSEG_shaving'
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
void AtSEG_shaving(AutoSegmentStackData *SD, const emlrtStack *sp, const
                   emxArray_boolean_T *Segmentdata_Input, const struct_T
                   Segmentdata_Pointdata[32768], const emxArray_real_T
                   *Segmentdata_BPmatrix, real_T Cutlen, emxArray_boolean_T
                   *Output_skel);

/* End of code generation (AtSEG_shaving.h) */

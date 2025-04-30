/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * TS_skelmorph3d.h
 *
 * Code generation for function 'TS_skelmorph3d'
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
void TS_skelmorph3d(const emlrtStack *sp, emxArray_boolean_T *bw,
                    emxArray_boolean_T *A, emxArray_boolean_T *BP,
                    emxArray_boolean_T *oldestBP, emxArray_boolean_T *EndP);

/* End of code generation (TS_skelmorph3d.h) */

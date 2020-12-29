/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * TS_Skeleton3D_initialize.c
 *
 * Code generation for function 'TS_Skeleton3D_initialize'
 *
 */

/* Include files */
#include "TS_Skeleton3D_initialize.h"
#include "TS_Skeleton3D.h"
#include "TS_Skeleton3D_data.h"
#include "_coder_TS_Skeleton3D_mex.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void TS_Skeleton3D_initialize(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mex_InitInfAndNan();
  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtLicenseCheckR2012b(&st, "Image_Toolbox", 2);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (TS_Skeleton3D_initialize.c) */

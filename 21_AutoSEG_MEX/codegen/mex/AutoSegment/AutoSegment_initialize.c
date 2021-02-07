/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * AutoSegment_initialize.c
 *
 * Code generation for function 'AutoSegment_initialize'
 *
 */

/* Include files */
#include "AutoSegment_initialize.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "_coder_AutoSegment_mex.h"
#include "rt_nonfinite.h"
#include "timeKeeper.h"

/* Function Declarations */
static void AutoSegment_once(void);

/* Function Definitions */
static void AutoSegment_once(void)
{
  mex_InitInfAndNan();
  savedTime_not_empty_init();
}

void AutoSegment_initialize(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtLicenseCheckR2012b(&st, "Image_Toolbox", 2);
  emlrtLicenseCheckR2012b(&st, "Statistics_Toolbox", 2);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    AutoSegment_once();
  }
}

/* End of code generation (AutoSegment_initialize.c) */

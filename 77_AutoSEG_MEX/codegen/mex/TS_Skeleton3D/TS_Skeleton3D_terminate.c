/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * TS_Skeleton3D_terminate.c
 *
 * Code generation for function 'TS_Skeleton3D_terminate'
 *
 */

/* Include files */
#include "TS_Skeleton3D_terminate.h"
#include "TS_Skeleton3D.h"
#include "TS_Skeleton3D_data.h"
#include "_coder_TS_Skeleton3D_mex.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void TS_Skeleton3D_atexit(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void TS_Skeleton3D_terminate(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (TS_Skeleton3D_terminate.c) */

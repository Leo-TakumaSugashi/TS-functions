/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_TS_Skeleton3D_mex.c
 *
 * Code generation for function '_coder_TS_Skeleton3D_mex'
 *
 */

/* Include files */
#include "_coder_TS_Skeleton3D_mex.h"
#include "TS_Skeleton3D.h"
#include "TS_Skeleton3D_data.h"
#include "TS_Skeleton3D_initialize.h"
#include "TS_Skeleton3D_terminate.h"
#include "_coder_TS_Skeleton3D_api.h"

/* Function Declarations */
MEXFUNCTION_LINKAGE void TS_Skeleton3D_mexFunction(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[1]);

/* Function Definitions */
void TS_Skeleton3D_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
  const mxArray *prhs[1])
{
  const mxArray *outputs[1];
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 1, 4,
                        13, "TS_Skeleton3D");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 13,
                        "TS_Skeleton3D");
  }

  /* Call the function. */
  TS_Skeleton3D_api(prhs, nlhs, outputs);

  /* Copy over outputs to the caller. */
  emlrtReturnArrays(1, plhs, outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(TS_Skeleton3D_atexit);

  /* Module initialization. */
  TS_Skeleton3D_initialize();

  /* Dispatch the entry-point. */
  TS_Skeleton3D_mexFunction(nlhs, plhs, nrhs, prhs);

  /* Module termination. */
  TS_Skeleton3D_terminate();
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_TS_Skeleton3D_mex.c) */

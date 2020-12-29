/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_AutoSegment_mex.c
 *
 * Code generation for function '_coder_AutoSegment_mex'
 *
 */

/* Include files */
#include "_coder_AutoSegment_mex.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_initialize.h"
#include "AutoSegment_terminate.h"
#include "_coder_AutoSegment_api.h"

/* Function Declarations */
MEXFUNCTION_LINKAGE void AutoSegment_mexFunction(AutoSegmentStackData *SD,
  int32_T nlhs, mxArray *plhs[1], int32_T nrhs, const mxArray *prhs[4]);

/* Function Definitions */
void AutoSegment_mexFunction(AutoSegmentStackData *SD, int32_T nlhs, mxArray
  *plhs[1], int32_T nrhs, const mxArray *prhs[4])
{
  const mxArray *outputs[1];
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 4) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 4, 4,
                        11, "AutoSegment");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 11,
                        "AutoSegment");
  }

  /* Call the function. */
  AutoSegment_api(SD, prhs, nlhs, outputs);

  /* Copy over outputs to the caller. */
  emlrtReturnArrays(1, plhs, outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  AutoSegmentStackData *AutoSegmentStackDataGlobal = NULL;
  AutoSegmentStackDataGlobal = (AutoSegmentStackData *)emlrtMxCalloc(1, (size_t)
    1U * sizeof(AutoSegmentStackData));
  mexAtExit(AutoSegment_atexit);

  /* Module initialization. */
  AutoSegment_initialize();

  /* Dispatch the entry-point. */
  AutoSegment_mexFunction(AutoSegmentStackDataGlobal, nlhs, plhs, nrhs, prhs);

  /* Module termination. */
  AutoSegment_terminate();
  emlrtMxFree(AutoSegmentStackDataGlobal);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_AutoSegment_mex.c) */

/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * tic.c
 *
 * Code generation for function 'tic'
 *
 */

/* Include files */
#include "tic.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "rt_nonfinite.h"
#include "timeKeeper.h"

/* Variable Definitions */
static emlrtRSInfo rb_emlrtRSI = { 34, /* lineNo */
  "tic",                               /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/timefun/tic.m"/* pathName */
};

/* Function Definitions */
void tic(const emlrtStack *sp)
{
  int32_T status;
  emlrtTimespec b_timespec;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &rb_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  b_st.site = &sb_emlrtRSI;
  status = emlrtClockGettimeMonotonic(&b_timespec);
  c_st.site = &tb_emlrtRSI;
  if (status != 0) {
    emlrtErrorWithMessageIdR2018a(&c_st, &f_emlrtRTEI,
      "Coder:toolbox:POSIXCallFailed", "Coder:toolbox:POSIXCallFailed", 5, 4, 26,
      cv, 12, status);
  }

  st.site = &rb_emlrtRSI;
  timeKeeper(&st);
}

/* End of code generation (tic.c) */

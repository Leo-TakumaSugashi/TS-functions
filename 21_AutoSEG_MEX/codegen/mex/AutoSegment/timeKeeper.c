/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * timeKeeper.c
 *
 * Code generation for function 'timeKeeper'
 *
 */

/* Include files */
#include "timeKeeper.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static boolean_T savedTime_not_empty;
static emlrtRSInfo ub_emlrtRSI = { 14, /* lineNo */
  "timeKeeper",                        /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/timefun/private/timeKeeper.m"/* pathName */
};

/* Function Definitions */
void savedTime_not_empty_init(void)
{
  savedTime_not_empty = false;
}

void timeKeeper(const emlrtStack *sp)
{
  int32_T status;
  emlrtTimespec b_timespec;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  if (!savedTime_not_empty) {
    st.site = &ub_emlrtRSI;
    b_st.site = &sb_emlrtRSI;
    status = emlrtClockGettimeMonotonic(&b_timespec);
    c_st.site = &tb_emlrtRSI;
    if (status != 0) {
      emlrtErrorWithMessageIdR2018a(&c_st, &f_emlrtRTEI,
        "Coder:toolbox:POSIXCallFailed", "Coder:toolbox:POSIXCallFailed", 5, 4,
        26, cv, 12, status);
    }

    savedTime_not_empty = true;
  }
}

/* End of code generation (timeKeeper.c) */

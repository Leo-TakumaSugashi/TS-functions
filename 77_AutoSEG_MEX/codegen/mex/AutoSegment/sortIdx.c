/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sortIdx.c
 *
 * Code generation for function 'sortIdx'
 *
 */

/* Include files */
#include "sortIdx.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "mwmathutil.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo fh_emlrtRSI = { 105,/* lineNo */
  "sortIdx",                           /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

static emlrtRSInfo gh_emlrtRSI = { 308,/* lineNo */
  "block_merge_sort",                  /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

static emlrtRSInfo hh_emlrtRSI = { 316,/* lineNo */
  "block_merge_sort",                  /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

static emlrtRSInfo ih_emlrtRSI = { 317,/* lineNo */
  "block_merge_sort",                  /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

static emlrtRSInfo jh_emlrtRSI = { 325,/* lineNo */
  "block_merge_sort",                  /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

static emlrtRSInfo kh_emlrtRSI = { 333,/* lineNo */
  "block_merge_sort",                  /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

static emlrtRSInfo lh_emlrtRSI = { 392,/* lineNo */
  "initialize_vector_sort",            /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

static emlrtRSInfo mh_emlrtRSI = { 420,/* lineNo */
  "initialize_vector_sort",            /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

static emlrtRSInfo nh_emlrtRSI = { 427,/* lineNo */
  "initialize_vector_sort",            /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

static emlrtRSInfo rh_emlrtRSI = { 499,/* lineNo */
  "merge_block",                       /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

static emlrtRSInfo th_emlrtRSI = { 507,/* lineNo */
  "merge_block",                       /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

static emlrtRSInfo uh_emlrtRSI = { 514,/* lineNo */
  "merge_block",                       /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

static emlrtRSInfo vh_emlrtRSI = { 561,/* lineNo */
  "merge",                             /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

static emlrtRSInfo wh_emlrtRSI = { 530,/* lineNo */
  "merge",                             /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

static emlrtRSInfo ii_emlrtRSI = { 340,/* lineNo */
  "block_merge_sort",                  /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

static emlrtRSInfo ji_emlrtRSI = { 354,/* lineNo */
  "shift_NaNs",                        /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

static emlrtRSInfo ki_emlrtRSI = { 363,/* lineNo */
  "shift_NaNs",                        /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

static emlrtRTEInfo ck_emlrtRTEI = { 61,/* lineNo */
  5,                                   /* colNo */
  "sortIdx",                           /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pName */
};

static emlrtRTEInfo dk_emlrtRTEI = { 386,/* lineNo */
  1,                                   /* colNo */
  "sortIdx",                           /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pName */
};

static emlrtRTEInfo ek_emlrtRTEI = { 308,/* lineNo */
  1,                                   /* colNo */
  "sortIdx",                           /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pName */
};

static emlrtRTEInfo fk_emlrtRTEI = { 308,/* lineNo */
  14,                                  /* colNo */
  "sortIdx",                           /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pName */
};

static emlrtRTEInfo gk_emlrtRTEI = { 308,/* lineNo */
  20,                                  /* colNo */
  "sortIdx",                           /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pName */
};

/* Function Declarations */
static void b_merge(const emlrtStack *sp, emxArray_int32_T *idx, emxArray_real_T
                    *x, int32_T offset, int32_T np, int32_T nq, emxArray_int32_T
                    *iwork, emxArray_real_T *xwork);
static void b_merge_block(const emlrtStack *sp, emxArray_int32_T *idx,
  emxArray_real_T *x, int32_T offset, int32_T n, int32_T preSortLevel,
  emxArray_int32_T *iwork, emxArray_real_T *xwork);
static void b_merge_pow2_block(emxArray_int32_T *idx, emxArray_real_T *x,
  int32_T offset);
static void c_merge(const emlrtStack *sp, emxArray_int32_T *idx, emxArray_real_T
                    *x, int32_T offset, int32_T np, int32_T nq, emxArray_int32_T
                    *iwork, emxArray_real_T *xwork);
static void c_merge_block(const emlrtStack *sp, emxArray_int32_T *idx,
  emxArray_real_T *x, int32_T offset, int32_T n, int32_T preSortLevel,
  emxArray_int32_T *iwork, emxArray_real_T *xwork);
static void c_merge_pow2_block(emxArray_int32_T *idx, emxArray_real_T *x,
  int32_T offset);
static void merge(const emlrtStack *sp, emxArray_int32_T *idx, emxArray_real32_T
                  *x, int32_T offset, int32_T np, int32_T nq, emxArray_int32_T
                  *iwork, emxArray_real32_T *xwork);
static void merge_block(const emlrtStack *sp, emxArray_int32_T *idx,
  emxArray_real32_T *x, int32_T offset, int32_T n, int32_T preSortLevel,
  emxArray_int32_T *iwork, emxArray_real32_T *xwork);
static void merge_pow2_block(emxArray_int32_T *idx, emxArray_real32_T *x,
  int32_T offset);

/* Function Definitions */
static void b_merge(const emlrtStack *sp, emxArray_int32_T *idx, emxArray_real_T
                    *x, int32_T offset, int32_T np, int32_T nq, emxArray_int32_T
                    *iwork, emxArray_real_T *xwork)
{
  int32_T n_tmp;
  int32_T iout;
  int32_T p;
  int32_T i;
  int32_T q;
  int32_T exitg1;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  if (nq != 0) {
    n_tmp = np + nq;
    st.site = &wh_emlrtRSI;
    if ((1 <= n_tmp) && (n_tmp > 2147483646)) {
      b_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&b_st);
    }

    for (iout = 0; iout < n_tmp; iout++) {
      i = offset + iout;
      iwork->data[iout] = idx->data[i];
      xwork->data[iout] = x->data[i];
    }

    p = 0;
    q = np;
    iout = offset - 1;
    do {
      exitg1 = 0;
      iout++;
      if (xwork->data[p] >= xwork->data[q]) {
        idx->data[iout] = iwork->data[p];
        x->data[iout] = xwork->data[p];
        if (p + 1 < np) {
          p++;
        } else {
          exitg1 = 1;
        }
      } else {
        idx->data[iout] = iwork->data[q];
        x->data[iout] = xwork->data[q];
        if (q + 1 < n_tmp) {
          q++;
        } else {
          q = iout - p;
          st.site = &vh_emlrtRSI;
          if ((p + 1 <= np) && (np > 2147483646)) {
            b_st.site = &i_emlrtRSI;
            check_forloop_overflow_error(&b_st);
          }

          for (iout = p + 1; iout <= np; iout++) {
            i = q + iout;
            idx->data[i] = iwork->data[iout - 1];
            x->data[i] = xwork->data[iout - 1];
          }

          exitg1 = 1;
        }
      }
    } while (exitg1 == 0);
  }
}

static void b_merge_block(const emlrtStack *sp, emxArray_int32_T *idx,
  emxArray_real_T *x, int32_T offset, int32_T n, int32_T preSortLevel,
  emxArray_int32_T *iwork, emxArray_real_T *xwork)
{
  int32_T nPairs;
  int32_T bLen;
  int32_T tailOffset;
  int32_T nTail;
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  nPairs = n >> preSortLevel;
  bLen = 1 << preSortLevel;
  while (nPairs > 1) {
    if ((nPairs & 1) != 0) {
      nPairs--;
      tailOffset = bLen * nPairs;
      nTail = n - tailOffset;
      if (nTail > bLen) {
        st.site = &rh_emlrtRSI;
        b_merge(&st, idx, x, offset + tailOffset, bLen, nTail - bLen, iwork,
                xwork);
      }
    }

    tailOffset = bLen << 1;
    nPairs >>= 1;
    for (nTail = 0; nTail < nPairs; nTail++) {
      st.site = &th_emlrtRSI;
      b_merge(&st, idx, x, offset + nTail * tailOffset, bLen, bLen, iwork, xwork);
    }

    bLen = tailOffset;
  }

  if (n > bLen) {
    st.site = &uh_emlrtRSI;
    b_merge(&st, idx, x, offset, bLen, n - bLen, iwork, xwork);
  }
}

static void b_merge_pow2_block(emxArray_int32_T *idx, emxArray_real_T *x,
  int32_T offset)
{
  int32_T b;
  int32_T bLen;
  int32_T bLen2;
  int32_T nPairs;
  int32_T k;
  int32_T blockOffset;
  int32_T j;
  int32_T p;
  int32_T iout;
  int32_T q;
  int32_T iwork[256];
  real_T xwork[256];
  int32_T exitg1;
  for (b = 0; b < 6; b++) {
    bLen = 1 << (b + 2);
    bLen2 = bLen << 1;
    nPairs = 256 >> (b + 3);
    for (k = 0; k < nPairs; k++) {
      blockOffset = offset + k * bLen2;
      for (j = 0; j < bLen2; j++) {
        iout = blockOffset + j;
        iwork[j] = idx->data[iout];
        xwork[j] = x->data[iout];
      }

      p = 0;
      q = bLen;
      iout = blockOffset - 1;
      do {
        exitg1 = 0;
        iout++;
        if (xwork[p] >= xwork[q]) {
          idx->data[iout] = iwork[p];
          x->data[iout] = xwork[p];
          if (p + 1 < bLen) {
            p++;
          } else {
            exitg1 = 1;
          }
        } else {
          idx->data[iout] = iwork[q];
          x->data[iout] = xwork[q];
          if (q + 1 < bLen2) {
            q++;
          } else {
            iout -= p;
            for (j = p + 1; j <= bLen; j++) {
              q = iout + j;
              idx->data[q] = iwork[j - 1];
              x->data[q] = xwork[j - 1];
            }

            exitg1 = 1;
          }
        }
      } while (exitg1 == 0);
    }
  }
}

static void c_merge(const emlrtStack *sp, emxArray_int32_T *idx, emxArray_real_T
                    *x, int32_T offset, int32_T np, int32_T nq, emxArray_int32_T
                    *iwork, emxArray_real_T *xwork)
{
  int32_T n_tmp;
  int32_T iout;
  int32_T p;
  int32_T i;
  int32_T q;
  int32_T exitg1;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  if (nq != 0) {
    n_tmp = np + nq;
    st.site = &wh_emlrtRSI;
    if ((1 <= n_tmp) && (n_tmp > 2147483646)) {
      b_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&b_st);
    }

    for (iout = 0; iout < n_tmp; iout++) {
      i = offset + iout;
      iwork->data[iout] = idx->data[i];
      xwork->data[iout] = x->data[i];
    }

    p = 0;
    q = np;
    iout = offset - 1;
    do {
      exitg1 = 0;
      iout++;
      if (xwork->data[p] <= xwork->data[q]) {
        idx->data[iout] = iwork->data[p];
        x->data[iout] = xwork->data[p];
        if (p + 1 < np) {
          p++;
        } else {
          exitg1 = 1;
        }
      } else {
        idx->data[iout] = iwork->data[q];
        x->data[iout] = xwork->data[q];
        if (q + 1 < n_tmp) {
          q++;
        } else {
          q = iout - p;
          st.site = &vh_emlrtRSI;
          if ((p + 1 <= np) && (np > 2147483646)) {
            b_st.site = &i_emlrtRSI;
            check_forloop_overflow_error(&b_st);
          }

          for (iout = p + 1; iout <= np; iout++) {
            i = q + iout;
            idx->data[i] = iwork->data[iout - 1];
            x->data[i] = xwork->data[iout - 1];
          }

          exitg1 = 1;
        }
      }
    } while (exitg1 == 0);
  }
}

static void c_merge_block(const emlrtStack *sp, emxArray_int32_T *idx,
  emxArray_real_T *x, int32_T offset, int32_T n, int32_T preSortLevel,
  emxArray_int32_T *iwork, emxArray_real_T *xwork)
{
  int32_T nPairs;
  int32_T bLen;
  int32_T tailOffset;
  int32_T nTail;
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  nPairs = n >> preSortLevel;
  bLen = 1 << preSortLevel;
  while (nPairs > 1) {
    if ((nPairs & 1) != 0) {
      nPairs--;
      tailOffset = bLen * nPairs;
      nTail = n - tailOffset;
      if (nTail > bLen) {
        st.site = &rh_emlrtRSI;
        c_merge(&st, idx, x, offset + tailOffset, bLen, nTail - bLen, iwork,
                xwork);
      }
    }

    tailOffset = bLen << 1;
    nPairs >>= 1;
    for (nTail = 0; nTail < nPairs; nTail++) {
      st.site = &th_emlrtRSI;
      c_merge(&st, idx, x, offset + nTail * tailOffset, bLen, bLen, iwork, xwork);
    }

    bLen = tailOffset;
  }

  if (n > bLen) {
    st.site = &uh_emlrtRSI;
    c_merge(&st, idx, x, offset, bLen, n - bLen, iwork, xwork);
  }
}

static void c_merge_pow2_block(emxArray_int32_T *idx, emxArray_real_T *x,
  int32_T offset)
{
  int32_T b;
  int32_T bLen;
  int32_T bLen2;
  int32_T nPairs;
  int32_T k;
  int32_T blockOffset;
  int32_T j;
  int32_T p;
  int32_T iout;
  int32_T q;
  int32_T iwork[256];
  real_T xwork[256];
  int32_T exitg1;
  for (b = 0; b < 6; b++) {
    bLen = 1 << (b + 2);
    bLen2 = bLen << 1;
    nPairs = 256 >> (b + 3);
    for (k = 0; k < nPairs; k++) {
      blockOffset = offset + k * bLen2;
      for (j = 0; j < bLen2; j++) {
        iout = blockOffset + j;
        iwork[j] = idx->data[iout];
        xwork[j] = x->data[iout];
      }

      p = 0;
      q = bLen;
      iout = blockOffset - 1;
      do {
        exitg1 = 0;
        iout++;
        if (xwork[p] <= xwork[q]) {
          idx->data[iout] = iwork[p];
          x->data[iout] = xwork[p];
          if (p + 1 < bLen) {
            p++;
          } else {
            exitg1 = 1;
          }
        } else {
          idx->data[iout] = iwork[q];
          x->data[iout] = xwork[q];
          if (q + 1 < bLen2) {
            q++;
          } else {
            iout -= p;
            for (j = p + 1; j <= bLen; j++) {
              q = iout + j;
              idx->data[q] = iwork[j - 1];
              x->data[q] = xwork[j - 1];
            }

            exitg1 = 1;
          }
        }
      } while (exitg1 == 0);
    }
  }
}

static void merge(const emlrtStack *sp, emxArray_int32_T *idx, emxArray_real32_T
                  *x, int32_T offset, int32_T np, int32_T nq, emxArray_int32_T
                  *iwork, emxArray_real32_T *xwork)
{
  int32_T n_tmp;
  int32_T iout;
  int32_T p;
  int32_T i;
  int32_T q;
  int32_T exitg1;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  if (nq != 0) {
    n_tmp = np + nq;
    st.site = &wh_emlrtRSI;
    if ((1 <= n_tmp) && (n_tmp > 2147483646)) {
      b_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&b_st);
    }

    for (iout = 0; iout < n_tmp; iout++) {
      i = offset + iout;
      iwork->data[iout] = idx->data[i];
      xwork->data[iout] = x->data[i];
    }

    p = 0;
    q = np;
    iout = offset - 1;
    do {
      exitg1 = 0;
      iout++;
      if (xwork->data[p] <= xwork->data[q]) {
        idx->data[iout] = iwork->data[p];
        x->data[iout] = xwork->data[p];
        if (p + 1 < np) {
          p++;
        } else {
          exitg1 = 1;
        }
      } else {
        idx->data[iout] = iwork->data[q];
        x->data[iout] = xwork->data[q];
        if (q + 1 < n_tmp) {
          q++;
        } else {
          q = iout - p;
          st.site = &vh_emlrtRSI;
          if ((p + 1 <= np) && (np > 2147483646)) {
            b_st.site = &i_emlrtRSI;
            check_forloop_overflow_error(&b_st);
          }

          for (iout = p + 1; iout <= np; iout++) {
            i = q + iout;
            idx->data[i] = iwork->data[iout - 1];
            x->data[i] = xwork->data[iout - 1];
          }

          exitg1 = 1;
        }
      }
    } while (exitg1 == 0);
  }
}

static void merge_block(const emlrtStack *sp, emxArray_int32_T *idx,
  emxArray_real32_T *x, int32_T offset, int32_T n, int32_T preSortLevel,
  emxArray_int32_T *iwork, emxArray_real32_T *xwork)
{
  int32_T nPairs;
  int32_T bLen;
  int32_T tailOffset;
  int32_T nTail;
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  nPairs = n >> preSortLevel;
  bLen = 1 << preSortLevel;
  while (nPairs > 1) {
    if ((nPairs & 1) != 0) {
      nPairs--;
      tailOffset = bLen * nPairs;
      nTail = n - tailOffset;
      if (nTail > bLen) {
        st.site = &rh_emlrtRSI;
        merge(&st, idx, x, offset + tailOffset, bLen, nTail - bLen, iwork, xwork);
      }
    }

    tailOffset = bLen << 1;
    nPairs >>= 1;
    for (nTail = 0; nTail < nPairs; nTail++) {
      st.site = &th_emlrtRSI;
      merge(&st, idx, x, offset + nTail * tailOffset, bLen, bLen, iwork, xwork);
    }

    bLen = tailOffset;
  }

  if (n > bLen) {
    st.site = &uh_emlrtRSI;
    merge(&st, idx, x, offset, bLen, n - bLen, iwork, xwork);
  }
}

static void merge_pow2_block(emxArray_int32_T *idx, emxArray_real32_T *x,
  int32_T offset)
{
  int32_T b;
  int32_T bLen;
  int32_T bLen2;
  int32_T nPairs;
  int32_T k;
  int32_T blockOffset;
  int32_T j;
  int32_T p;
  int32_T iout;
  int32_T q;
  int32_T iwork[256];
  real32_T xwork[256];
  int32_T exitg1;
  for (b = 0; b < 6; b++) {
    bLen = 1 << (b + 2);
    bLen2 = bLen << 1;
    nPairs = 256 >> (b + 3);
    for (k = 0; k < nPairs; k++) {
      blockOffset = offset + k * bLen2;
      for (j = 0; j < bLen2; j++) {
        iout = blockOffset + j;
        iwork[j] = idx->data[iout];
        xwork[j] = x->data[iout];
      }

      p = 0;
      q = bLen;
      iout = blockOffset - 1;
      do {
        exitg1 = 0;
        iout++;
        if (xwork[p] <= xwork[q]) {
          idx->data[iout] = iwork[p];
          x->data[iout] = xwork[p];
          if (p + 1 < bLen) {
            p++;
          } else {
            exitg1 = 1;
          }
        } else {
          idx->data[iout] = iwork[q];
          x->data[iout] = xwork[q];
          if (q + 1 < bLen2) {
            q++;
          } else {
            iout -= p;
            for (j = p + 1; j <= bLen; j++) {
              q = iout + j;
              idx->data[q] = iwork[j - 1];
              x->data[q] = xwork[j - 1];
            }

            exitg1 = 1;
          }
        }
      } while (exitg1 == 0);
    }
  }
}

void b_sortIdx(const emlrtStack *sp, emxArray_real_T *x, emxArray_int32_T *idx)
{
  int32_T ib;
  int32_T i1;
  emxArray_int32_T *iwork;
  int32_T n;
  int32_T b_n;
  real_T x4[4];
  int32_T idx4[4];
  emxArray_real_T *xwork;
  int32_T nNaNs;
  int32_T k;
  int32_T i4;
  int32_T idx_tmp;
  int8_T perm[4];
  int32_T quartetOffset;
  int32_T i3;
  real_T d;
  real_T d1;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  ib = x->size[0];
  i1 = idx->size[0];
  idx->size[0] = ib;
  emxEnsureCapacity_int32_T(sp, idx, i1, &ck_emlrtRTEI);
  for (i1 = 0; i1 < ib; i1++) {
    idx->data[i1] = 0;
  }

  if (x->size[0] != 0) {
    emxInit_int32_T(sp, &iwork, 1, &fk_emlrtRTEI, true);
    st.site = &fh_emlrtRSI;
    n = x->size[0];
    b_st.site = &gh_emlrtRSI;
    b_n = x->size[0];
    x4[0] = 0.0;
    idx4[0] = 0;
    x4[1] = 0.0;
    idx4[1] = 0;
    x4[2] = 0.0;
    idx4[2] = 0;
    x4[3] = 0.0;
    idx4[3] = 0;
    i1 = iwork->size[0];
    iwork->size[0] = ib;
    emxEnsureCapacity_int32_T(&b_st, iwork, i1, &dk_emlrtRTEI);
    for (i1 = 0; i1 < ib; i1++) {
      iwork->data[i1] = 0;
    }

    emxInit_real_T(&b_st, &xwork, 1, &gk_emlrtRTEI, true);
    i1 = xwork->size[0];
    xwork->size[0] = x->size[0];
    emxEnsureCapacity_real_T(&b_st, xwork, i1, &ek_emlrtRTEI);
    ib = xwork->size[0];
    for (i1 = 0; i1 < ib; i1++) {
      xwork->data[i1] = 0.0;
    }

    nNaNs = 0;
    ib = -1;
    c_st.site = &lh_emlrtRSI;
    if ((1 <= x->size[0]) && (x->size[0] > 2147483646)) {
      d_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&d_st);
    }

    for (k = 0; k < b_n; k++) {
      if (muDoubleScalarIsNaN(x->data[k])) {
        idx_tmp = (b_n - nNaNs) - 1;
        idx->data[idx_tmp] = k + 1;
        xwork->data[idx_tmp] = x->data[k];
        nNaNs++;
      } else {
        ib++;
        idx4[ib] = k + 1;
        x4[ib] = x->data[k];
        if (ib + 1 == 4) {
          quartetOffset = k - nNaNs;
          if (x4[0] >= x4[1]) {
            i1 = 1;
            ib = 2;
          } else {
            i1 = 2;
            ib = 1;
          }

          if (x4[2] >= x4[3]) {
            i3 = 3;
            i4 = 4;
          } else {
            i3 = 4;
            i4 = 3;
          }

          d = x4[i1 - 1];
          d1 = x4[i3 - 1];
          if (d >= d1) {
            d = x4[ib - 1];
            if (d >= d1) {
              perm[0] = (int8_T)i1;
              perm[1] = (int8_T)ib;
              perm[2] = (int8_T)i3;
              perm[3] = (int8_T)i4;
            } else if (d >= x4[i4 - 1]) {
              perm[0] = (int8_T)i1;
              perm[1] = (int8_T)i3;
              perm[2] = (int8_T)ib;
              perm[3] = (int8_T)i4;
            } else {
              perm[0] = (int8_T)i1;
              perm[1] = (int8_T)i3;
              perm[2] = (int8_T)i4;
              perm[3] = (int8_T)ib;
            }
          } else {
            d1 = x4[i4 - 1];
            if (d >= d1) {
              if (x4[ib - 1] >= d1) {
                perm[0] = (int8_T)i3;
                perm[1] = (int8_T)i1;
                perm[2] = (int8_T)ib;
                perm[3] = (int8_T)i4;
              } else {
                perm[0] = (int8_T)i3;
                perm[1] = (int8_T)i1;
                perm[2] = (int8_T)i4;
                perm[3] = (int8_T)ib;
              }
            } else {
              perm[0] = (int8_T)i3;
              perm[1] = (int8_T)i4;
              perm[2] = (int8_T)i1;
              perm[3] = (int8_T)ib;
            }
          }

          idx_tmp = perm[0] - 1;
          idx->data[quartetOffset - 3] = idx4[idx_tmp];
          i3 = perm[1] - 1;
          idx->data[quartetOffset - 2] = idx4[i3];
          ib = perm[2] - 1;
          idx->data[quartetOffset - 1] = idx4[ib];
          i1 = perm[3] - 1;
          idx->data[quartetOffset] = idx4[i1];
          x->data[quartetOffset - 3] = x4[idx_tmp];
          x->data[quartetOffset - 2] = x4[i3];
          x->data[quartetOffset - 1] = x4[ib];
          x->data[quartetOffset] = x4[i1];
          ib = -1;
        }
      }
    }

    i4 = (b_n - nNaNs) - 1;
    if (ib + 1 > 0) {
      perm[1] = 0;
      perm[2] = 0;
      perm[3] = 0;
      if (ib + 1 == 1) {
        perm[0] = 1;
      } else if (ib + 1 == 2) {
        if (x4[0] >= x4[1]) {
          perm[0] = 1;
          perm[1] = 2;
        } else {
          perm[0] = 2;
          perm[1] = 1;
        }
      } else if (x4[0] >= x4[1]) {
        if (x4[1] >= x4[2]) {
          perm[0] = 1;
          perm[1] = 2;
          perm[2] = 3;
        } else if (x4[0] >= x4[2]) {
          perm[0] = 1;
          perm[1] = 3;
          perm[2] = 2;
        } else {
          perm[0] = 3;
          perm[1] = 1;
          perm[2] = 2;
        }
      } else if (x4[0] >= x4[2]) {
        perm[0] = 2;
        perm[1] = 1;
        perm[2] = 3;
      } else if (x4[1] >= x4[2]) {
        perm[0] = 2;
        perm[1] = 3;
        perm[2] = 1;
      } else {
        perm[0] = 3;
        perm[1] = 2;
        perm[2] = 1;
      }

      c_st.site = &mh_emlrtRSI;
      if (ib + 1 > 2147483646) {
        d_st.site = &i_emlrtRSI;
        check_forloop_overflow_error(&d_st);
      }

      for (k = 0; k <= ib; k++) {
        idx_tmp = perm[k] - 1;
        i3 = (i4 - ib) + k;
        idx->data[i3] = idx4[idx_tmp];
        x->data[i3] = x4[idx_tmp];
      }
    }

    ib = (nNaNs >> 1) + 1;
    c_st.site = &nh_emlrtRSI;
    for (k = 0; k <= ib - 2; k++) {
      i1 = (i4 + k) + 1;
      i3 = idx->data[i1];
      idx_tmp = (b_n - k) - 1;
      idx->data[i1] = idx->data[idx_tmp];
      idx->data[idx_tmp] = i3;
      x->data[i1] = xwork->data[idx_tmp];
      x->data[idx_tmp] = xwork->data[i1];
    }

    if ((nNaNs & 1) != 0) {
      i1 = i4 + ib;
      x->data[i1] = xwork->data[i1];
    }

    i3 = n - nNaNs;
    ib = 2;
    if (i3 > 1) {
      if (n >= 256) {
        i1 = i3 >> 8;
        if (i1 > 0) {
          b_st.site = &hh_emlrtRSI;
          for (ib = 0; ib < i1; ib++) {
            b_st.site = &ih_emlrtRSI;
            b_merge_pow2_block(idx, x, ib << 8);
          }

          ib = i1 << 8;
          i1 = i3 - ib;
          if (i1 > 0) {
            b_st.site = &jh_emlrtRSI;
            b_merge_block(&b_st, idx, x, ib, i1, 2, iwork, xwork);
          }

          ib = 8;
        }
      }

      b_st.site = &kh_emlrtRSI;
      b_merge_block(&b_st, idx, x, 0, i3, ib, iwork, xwork);
    }

    if ((nNaNs > 0) && (i3 > 0)) {
      b_st.site = &ii_emlrtRSI;
      c_st.site = &ji_emlrtRSI;
      if (nNaNs > 2147483646) {
        d_st.site = &i_emlrtRSI;
        check_forloop_overflow_error(&d_st);
      }

      for (k = 0; k < nNaNs; k++) {
        ib = i3 + k;
        xwork->data[k] = x->data[ib];
        iwork->data[k] = idx->data[ib];
      }

      for (k = i3; k >= 1; k--) {
        i1 = (nNaNs + k) - 1;
        x->data[i1] = x->data[k - 1];
        idx->data[i1] = idx->data[k - 1];
      }

      c_st.site = &ki_emlrtRSI;
      for (k = 0; k < nNaNs; k++) {
        x->data[k] = xwork->data[k];
        idx->data[k] = iwork->data[k];
      }
    }

    emxFree_real_T(&xwork);
    emxFree_int32_T(&iwork);
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void c_sortIdx(const emlrtStack *sp, emxArray_real_T *x, emxArray_int32_T *idx)
{
  int32_T ib;
  int32_T i1;
  emxArray_int32_T *iwork;
  int32_T n;
  int32_T b_n;
  real_T x4[4];
  int32_T idx4[4];
  emxArray_real_T *xwork;
  int32_T nNaNs;
  int32_T k;
  int32_T i4;
  int32_T idx_tmp;
  int8_T perm[4];
  int32_T quartetOffset;
  int32_T i2;
  real_T d;
  real_T d1;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  ib = x->size[0];
  i1 = idx->size[0];
  idx->size[0] = ib;
  emxEnsureCapacity_int32_T(sp, idx, i1, &ck_emlrtRTEI);
  for (i1 = 0; i1 < ib; i1++) {
    idx->data[i1] = 0;
  }

  if (x->size[0] != 0) {
    emxInit_int32_T(sp, &iwork, 1, &fk_emlrtRTEI, true);
    st.site = &fh_emlrtRSI;
    n = x->size[0];
    b_st.site = &gh_emlrtRSI;
    b_n = x->size[0];
    x4[0] = 0.0;
    idx4[0] = 0;
    x4[1] = 0.0;
    idx4[1] = 0;
    x4[2] = 0.0;
    idx4[2] = 0;
    x4[3] = 0.0;
    idx4[3] = 0;
    i1 = iwork->size[0];
    iwork->size[0] = ib;
    emxEnsureCapacity_int32_T(&b_st, iwork, i1, &dk_emlrtRTEI);
    for (i1 = 0; i1 < ib; i1++) {
      iwork->data[i1] = 0;
    }

    emxInit_real_T(&b_st, &xwork, 1, &gk_emlrtRTEI, true);
    i1 = xwork->size[0];
    xwork->size[0] = x->size[0];
    emxEnsureCapacity_real_T(&b_st, xwork, i1, &ek_emlrtRTEI);
    ib = xwork->size[0];
    for (i1 = 0; i1 < ib; i1++) {
      xwork->data[i1] = 0.0;
    }

    nNaNs = 0;
    ib = -1;
    c_st.site = &lh_emlrtRSI;
    if ((1 <= x->size[0]) && (x->size[0] > 2147483646)) {
      d_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&d_st);
    }

    for (k = 0; k < b_n; k++) {
      if (muDoubleScalarIsNaN(x->data[k])) {
        idx_tmp = (b_n - nNaNs) - 1;
        idx->data[idx_tmp] = k + 1;
        xwork->data[idx_tmp] = x->data[k];
        nNaNs++;
      } else {
        ib++;
        idx4[ib] = k + 1;
        x4[ib] = x->data[k];
        if (ib + 1 == 4) {
          quartetOffset = k - nNaNs;
          if (x4[0] <= x4[1]) {
            i1 = 1;
            i2 = 2;
          } else {
            i1 = 2;
            i2 = 1;
          }

          if (x4[2] <= x4[3]) {
            ib = 3;
            i4 = 4;
          } else {
            ib = 4;
            i4 = 3;
          }

          d = x4[i1 - 1];
          d1 = x4[ib - 1];
          if (d <= d1) {
            d = x4[i2 - 1];
            if (d <= d1) {
              perm[0] = (int8_T)i1;
              perm[1] = (int8_T)i2;
              perm[2] = (int8_T)ib;
              perm[3] = (int8_T)i4;
            } else if (d <= x4[i4 - 1]) {
              perm[0] = (int8_T)i1;
              perm[1] = (int8_T)ib;
              perm[2] = (int8_T)i2;
              perm[3] = (int8_T)i4;
            } else {
              perm[0] = (int8_T)i1;
              perm[1] = (int8_T)ib;
              perm[2] = (int8_T)i4;
              perm[3] = (int8_T)i2;
            }
          } else {
            d1 = x4[i4 - 1];
            if (d <= d1) {
              if (x4[i2 - 1] <= d1) {
                perm[0] = (int8_T)ib;
                perm[1] = (int8_T)i1;
                perm[2] = (int8_T)i2;
                perm[3] = (int8_T)i4;
              } else {
                perm[0] = (int8_T)ib;
                perm[1] = (int8_T)i1;
                perm[2] = (int8_T)i4;
                perm[3] = (int8_T)i2;
              }
            } else {
              perm[0] = (int8_T)ib;
              perm[1] = (int8_T)i4;
              perm[2] = (int8_T)i1;
              perm[3] = (int8_T)i2;
            }
          }

          idx_tmp = perm[0] - 1;
          idx->data[quartetOffset - 3] = idx4[idx_tmp];
          i2 = perm[1] - 1;
          idx->data[quartetOffset - 2] = idx4[i2];
          ib = perm[2] - 1;
          idx->data[quartetOffset - 1] = idx4[ib];
          i1 = perm[3] - 1;
          idx->data[quartetOffset] = idx4[i1];
          x->data[quartetOffset - 3] = x4[idx_tmp];
          x->data[quartetOffset - 2] = x4[i2];
          x->data[quartetOffset - 1] = x4[ib];
          x->data[quartetOffset] = x4[i1];
          ib = -1;
        }
      }
    }

    i4 = (b_n - nNaNs) - 1;
    if (ib + 1 > 0) {
      perm[1] = 0;
      perm[2] = 0;
      perm[3] = 0;
      if (ib + 1 == 1) {
        perm[0] = 1;
      } else if (ib + 1 == 2) {
        if (x4[0] <= x4[1]) {
          perm[0] = 1;
          perm[1] = 2;
        } else {
          perm[0] = 2;
          perm[1] = 1;
        }
      } else if (x4[0] <= x4[1]) {
        if (x4[1] <= x4[2]) {
          perm[0] = 1;
          perm[1] = 2;
          perm[2] = 3;
        } else if (x4[0] <= x4[2]) {
          perm[0] = 1;
          perm[1] = 3;
          perm[2] = 2;
        } else {
          perm[0] = 3;
          perm[1] = 1;
          perm[2] = 2;
        }
      } else if (x4[0] <= x4[2]) {
        perm[0] = 2;
        perm[1] = 1;
        perm[2] = 3;
      } else if (x4[1] <= x4[2]) {
        perm[0] = 2;
        perm[1] = 3;
        perm[2] = 1;
      } else {
        perm[0] = 3;
        perm[1] = 2;
        perm[2] = 1;
      }

      c_st.site = &mh_emlrtRSI;
      if (ib + 1 > 2147483646) {
        d_st.site = &i_emlrtRSI;
        check_forloop_overflow_error(&d_st);
      }

      for (k = 0; k <= ib; k++) {
        idx_tmp = perm[k] - 1;
        i2 = (i4 - ib) + k;
        idx->data[i2] = idx4[idx_tmp];
        x->data[i2] = x4[idx_tmp];
      }
    }

    ib = (nNaNs >> 1) + 1;
    c_st.site = &nh_emlrtRSI;
    for (k = 0; k <= ib - 2; k++) {
      i1 = (i4 + k) + 1;
      i2 = idx->data[i1];
      idx_tmp = (b_n - k) - 1;
      idx->data[i1] = idx->data[idx_tmp];
      idx->data[idx_tmp] = i2;
      x->data[i1] = xwork->data[idx_tmp];
      x->data[idx_tmp] = xwork->data[i1];
    }

    if ((nNaNs & 1) != 0) {
      i1 = i4 + ib;
      x->data[i1] = xwork->data[i1];
    }

    i2 = n - nNaNs;
    ib = 2;
    if (i2 > 1) {
      if (n >= 256) {
        i1 = i2 >> 8;
        if (i1 > 0) {
          b_st.site = &hh_emlrtRSI;
          for (ib = 0; ib < i1; ib++) {
            b_st.site = &ih_emlrtRSI;
            c_merge_pow2_block(idx, x, ib << 8);
          }

          ib = i1 << 8;
          i1 = i2 - ib;
          if (i1 > 0) {
            b_st.site = &jh_emlrtRSI;
            c_merge_block(&b_st, idx, x, ib, i1, 2, iwork, xwork);
          }

          ib = 8;
        }
      }

      b_st.site = &kh_emlrtRSI;
      c_merge_block(&b_st, idx, x, 0, i2, ib, iwork, xwork);
    }

    emxFree_real_T(&xwork);
    emxFree_int32_T(&iwork);
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void sortIdx(const emlrtStack *sp, emxArray_real32_T *x, emxArray_int32_T *idx)
{
  int32_T ib;
  int32_T i1;
  emxArray_int32_T *iwork;
  int32_T n;
  int32_T b_n;
  real32_T x4[4];
  int32_T idx4[4];
  emxArray_real32_T *xwork;
  int32_T nNaNs;
  int32_T k;
  int32_T i4;
  int32_T idx_tmp;
  int8_T perm[4];
  int32_T quartetOffset;
  int32_T i2;
  real32_T f;
  real32_T f1;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  ib = x->size[0];
  i1 = idx->size[0];
  idx->size[0] = ib;
  emxEnsureCapacity_int32_T(sp, idx, i1, &ck_emlrtRTEI);
  for (i1 = 0; i1 < ib; i1++) {
    idx->data[i1] = 0;
  }

  emxInit_int32_T(sp, &iwork, 1, &fk_emlrtRTEI, true);
  st.site = &fh_emlrtRSI;
  n = x->size[0];
  b_st.site = &gh_emlrtRSI;
  b_n = x->size[0];
  x4[0] = 0.0F;
  idx4[0] = 0;
  x4[1] = 0.0F;
  idx4[1] = 0;
  x4[2] = 0.0F;
  idx4[2] = 0;
  x4[3] = 0.0F;
  idx4[3] = 0;
  i1 = iwork->size[0];
  iwork->size[0] = ib;
  emxEnsureCapacity_int32_T(&b_st, iwork, i1, &dk_emlrtRTEI);
  for (i1 = 0; i1 < ib; i1++) {
    iwork->data[i1] = 0;
  }

  emxInit_real32_T(&b_st, &xwork, 1, &gk_emlrtRTEI, true);
  i1 = xwork->size[0];
  xwork->size[0] = x->size[0];
  emxEnsureCapacity_real32_T(&b_st, xwork, i1, &ek_emlrtRTEI);
  ib = xwork->size[0];
  for (i1 = 0; i1 < ib; i1++) {
    xwork->data[i1] = 0.0F;
  }

  nNaNs = 0;
  ib = -1;
  c_st.site = &lh_emlrtRSI;
  if ((1 <= x->size[0]) && (x->size[0] > 2147483646)) {
    d_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&d_st);
  }

  for (k = 0; k < b_n; k++) {
    if (muSingleScalarIsNaN(x->data[k])) {
      idx_tmp = (b_n - nNaNs) - 1;
      idx->data[idx_tmp] = k + 1;
      xwork->data[idx_tmp] = x->data[k];
      nNaNs++;
    } else {
      ib++;
      idx4[ib] = k + 1;
      x4[ib] = x->data[k];
      if (ib + 1 == 4) {
        quartetOffset = k - nNaNs;
        if (x4[0] <= x4[1]) {
          i1 = 1;
          i2 = 2;
        } else {
          i1 = 2;
          i2 = 1;
        }

        if (x4[2] <= x4[3]) {
          ib = 3;
          i4 = 4;
        } else {
          ib = 4;
          i4 = 3;
        }

        f = x4[i1 - 1];
        f1 = x4[ib - 1];
        if (f <= f1) {
          f = x4[i2 - 1];
          if (f <= f1) {
            perm[0] = (int8_T)i1;
            perm[1] = (int8_T)i2;
            perm[2] = (int8_T)ib;
            perm[3] = (int8_T)i4;
          } else if (f <= x4[i4 - 1]) {
            perm[0] = (int8_T)i1;
            perm[1] = (int8_T)ib;
            perm[2] = (int8_T)i2;
            perm[3] = (int8_T)i4;
          } else {
            perm[0] = (int8_T)i1;
            perm[1] = (int8_T)ib;
            perm[2] = (int8_T)i4;
            perm[3] = (int8_T)i2;
          }
        } else {
          f1 = x4[i4 - 1];
          if (f <= f1) {
            if (x4[i2 - 1] <= f1) {
              perm[0] = (int8_T)ib;
              perm[1] = (int8_T)i1;
              perm[2] = (int8_T)i2;
              perm[3] = (int8_T)i4;
            } else {
              perm[0] = (int8_T)ib;
              perm[1] = (int8_T)i1;
              perm[2] = (int8_T)i4;
              perm[3] = (int8_T)i2;
            }
          } else {
            perm[0] = (int8_T)ib;
            perm[1] = (int8_T)i4;
            perm[2] = (int8_T)i1;
            perm[3] = (int8_T)i2;
          }
        }

        idx_tmp = perm[0] - 1;
        idx->data[quartetOffset - 3] = idx4[idx_tmp];
        i2 = perm[1] - 1;
        idx->data[quartetOffset - 2] = idx4[i2];
        ib = perm[2] - 1;
        idx->data[quartetOffset - 1] = idx4[ib];
        i1 = perm[3] - 1;
        idx->data[quartetOffset] = idx4[i1];
        x->data[quartetOffset - 3] = x4[idx_tmp];
        x->data[quartetOffset - 2] = x4[i2];
        x->data[quartetOffset - 1] = x4[ib];
        x->data[quartetOffset] = x4[i1];
        ib = -1;
      }
    }
  }

  i4 = (b_n - nNaNs) - 1;
  if (ib + 1 > 0) {
    perm[1] = 0;
    perm[2] = 0;
    perm[3] = 0;
    if (ib + 1 == 1) {
      perm[0] = 1;
    } else if (ib + 1 == 2) {
      if (x4[0] <= x4[1]) {
        perm[0] = 1;
        perm[1] = 2;
      } else {
        perm[0] = 2;
        perm[1] = 1;
      }
    } else if (x4[0] <= x4[1]) {
      if (x4[1] <= x4[2]) {
        perm[0] = 1;
        perm[1] = 2;
        perm[2] = 3;
      } else if (x4[0] <= x4[2]) {
        perm[0] = 1;
        perm[1] = 3;
        perm[2] = 2;
      } else {
        perm[0] = 3;
        perm[1] = 1;
        perm[2] = 2;
      }
    } else if (x4[0] <= x4[2]) {
      perm[0] = 2;
      perm[1] = 1;
      perm[2] = 3;
    } else if (x4[1] <= x4[2]) {
      perm[0] = 2;
      perm[1] = 3;
      perm[2] = 1;
    } else {
      perm[0] = 3;
      perm[1] = 2;
      perm[2] = 1;
    }

    c_st.site = &mh_emlrtRSI;
    if (ib + 1 > 2147483646) {
      d_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&d_st);
    }

    for (k = 0; k <= ib; k++) {
      idx_tmp = perm[k] - 1;
      i2 = (i4 - ib) + k;
      idx->data[i2] = idx4[idx_tmp];
      x->data[i2] = x4[idx_tmp];
    }
  }

  ib = (nNaNs >> 1) + 1;
  c_st.site = &nh_emlrtRSI;
  for (k = 0; k <= ib - 2; k++) {
    i1 = (i4 + k) + 1;
    i2 = idx->data[i1];
    idx_tmp = (b_n - k) - 1;
    idx->data[i1] = idx->data[idx_tmp];
    idx->data[idx_tmp] = i2;
    x->data[i1] = xwork->data[idx_tmp];
    x->data[idx_tmp] = xwork->data[i1];
  }

  if ((nNaNs & 1) != 0) {
    i1 = i4 + ib;
    x->data[i1] = xwork->data[i1];
  }

  i2 = n - nNaNs;
  ib = 2;
  if (i2 > 1) {
    if (n >= 256) {
      i1 = i2 >> 8;
      if (i1 > 0) {
        b_st.site = &hh_emlrtRSI;
        for (ib = 0; ib < i1; ib++) {
          b_st.site = &ih_emlrtRSI;
          merge_pow2_block(idx, x, ib << 8);
        }

        ib = i1 << 8;
        i1 = i2 - ib;
        if (i1 > 0) {
          b_st.site = &jh_emlrtRSI;
          merge_block(&b_st, idx, x, ib, i1, 2, iwork, xwork);
        }

        ib = 8;
      }
    }

    b_st.site = &kh_emlrtRSI;
    merge_block(&b_st, idx, x, 0, i2, ib, iwork, xwork);
  }

  emxFree_real32_T(&xwork);
  emxFree_int32_T(&iwork);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (sortIdx.c) */

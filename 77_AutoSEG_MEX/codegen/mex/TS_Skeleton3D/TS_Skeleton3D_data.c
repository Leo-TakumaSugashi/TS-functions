/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * TS_Skeleton3D_data.c
 *
 * Code generation for function 'TS_Skeleton3D_data'
 *
 */

/* Include files */
#include "TS_Skeleton3D_data.h"
#include "TS_Skeleton3D.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
emlrtCTX emlrtRootTLSGlobal = NULL;
const volatile char_T *emlrtBreakCheckR2012bFlagVar = NULL;
emlrtContext emlrtContextGlobal = { true,/* bFirstTime */
  false,                               /* bInitialized */
  131483U,                             /* fVersionInfo */
  NULL,                                /* fErrorFunction */
  "TS_Skeleton3D",                     /* fFunctionName */
  NULL,                                /* fRTCallStack */
  false,                               /* bDebugMode */
  { 1858410525U, 2505464270U, 328108647U, 1256672073U },/* fSigWrd */
  NULL                                 /* fSigMem */
};

emlrtRSInfo o_emlrtRSI = { 28,         /* lineNo */
  "repmat",                            /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/repmat.m"/* pathName */
};

emlrtRSInfo s_emlrtRSI = { 21,         /* lineNo */
  "eml_int_forloop_overflow_check",    /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"/* pathName */
};

emlrtRSInfo fb_emlrtRSI = { 50,        /* lineNo */
  "prodsize",                          /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/shared/coder/coder/+coder/+internal/prodsize.m"/* pathName */
};

emlrtRSInfo tb_emlrtRSI = { 506,       /* lineNo */
  "merge_block",                       /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

emlrtRSInfo bc_emlrtRSI = { 41,        /* lineNo */
  "find",                              /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/find.m"/* pathName */
};

emlrtRSInfo cc_emlrtRSI = { 153,       /* lineNo */
  "eml_find",                          /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/find.m"/* pathName */
};

emlrtRSInfo dc_emlrtRSI = { 377,       /* lineNo */
  "find_first_indices",                /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/find.m"/* pathName */
};

emlrtRSInfo ec_emlrtRSI = { 397,       /* lineNo */
  "find_first_indices",                /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/find.m"/* pathName */
};

emlrtRSInfo nc_emlrtRSI = { 19,        /* lineNo */
  "ind2sub",                           /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/ind2sub.m"/* pathName */
};

emlrtRSInfo uc_emlrtRSI = { 65,        /* lineNo */
  "cat",                               /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/cat.m"/* pathName */
};

emlrtRSInfo bd_emlrtRSI = { 45,        /* lineNo */
  "unaryOrBinaryDispatch",             /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/eml/+coder/+internal/minOrMax.m"/* pathName */
};

emlrtRSInfo cd_emlrtRSI = { 145,       /* lineNo */
  "unaryMinOrMax",                     /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"/* pathName */
};

emlrtRSInfo dd_emlrtRSI = { 1019,      /* lineNo */
  "maxRealVectorOmitNaN",              /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"/* pathName */
};

emlrtRSInfo ed_emlrtRSI = { 932,       /* lineNo */
  "minOrMaxRealVector",                /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"/* pathName */
};

emlrtRSInfo fd_emlrtRSI = { 992,       /* lineNo */
  "minOrMaxRealVectorKernel",          /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"/* pathName */
};

emlrtRTEInfo emlrtRTEI = { 38,         /* lineNo */
  15,                                  /* colNo */
  "ind2sub_indexClass",                /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/ind2sub.m"/* pName */
};

emlrtRTEInfo b_emlrtRTEI = { 387,      /* lineNo */
  1,                                   /* colNo */
  "find_first_indices",                /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/find.m"/* pName */
};

emlrtRTEInfo v_emlrtRTEI = { 153,      /* lineNo */
  13,                                  /* colNo */
  "find",                              /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/find.m"/* pName */
};

emlrtRTEInfo x_emlrtRTEI = { 42,       /* lineNo */
  5,                                   /* colNo */
  "ind2sub",                           /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/ind2sub.m"/* pName */
};

emlrtRTEInfo y_emlrtRTEI = { 43,       /* lineNo */
  5,                                   /* colNo */
  "ind2sub",                           /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/ind2sub.m"/* pName */
};

emlrtRSInfo hd_emlrtRSI = { 18,        /* lineNo */
  "indexDivide",                       /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/eml/+coder/+internal/indexDivide.m"/* pathName */
};

/* End of code generation (TS_Skeleton3D_data.c) */

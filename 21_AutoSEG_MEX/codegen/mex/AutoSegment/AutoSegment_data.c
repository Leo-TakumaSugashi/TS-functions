/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * AutoSegment_data.c
 *
 * Code generation for function 'AutoSegment_data'
 *
 */

/* Include files */
#include "AutoSegment_data.h"
#include "AutoSegment.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
emlrtCTX emlrtRootTLSGlobal = NULL;
const volatile char_T *emlrtBreakCheckR2012bFlagVar = NULL;
emlrtContext emlrtContextGlobal = { true,/* bFirstTime */
  false,                               /* bInitialized */
  131483U,                             /* fVersionInfo */
  NULL,                                /* fErrorFunction */
  "AutoSegment",                       /* fFunctionName */
  NULL,                                /* fRTCallStack */
  false,                               /* bDebugMode */
  { 4209757260U, 1383518620U, 1328961664U, 2918865455U },/* fSigWrd */
  NULL                                 /* fSigMem */
};

emlrtRSInfo i_emlrtRSI = { 21,         /* lineNo */
  "eml_int_forloop_overflow_check",    /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"/* pathName */
};

emlrtRSInfo sb_emlrtRSI = { 8,         /* lineNo */
  "getTime",                           /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/timefun/private/getTime.m"/* pathName */
};

emlrtRSInfo tb_emlrtRSI = { 25,        /* lineNo */
  "getTimeEMLRT",                      /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/timefun/private/getTime.m"/* pathName */
};

emlrtRSInfo nc_emlrtRSI = { 106,       /* lineNo */
  "imfilter",                          /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/imfilter.m"/* pathName */
};

emlrtRSInfo oc_emlrtRSI = { 110,       /* lineNo */
  "imfilter",                          /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/imfilter.m"/* pathName */
};

emlrtRSInfo qc_emlrtRSI = { 20,        /* lineNo */
  "padarray",                          /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m"/* pathName */
};

emlrtRSInfo rc_emlrtRSI = { 64,        /* lineNo */
  "padarray",                          /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m"/* pathName */
};

emlrtRSInfo sc_emlrtRSI = { 72,        /* lineNo */
  "padarray",                          /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m"/* pathName */
};

emlrtRSInfo tc_emlrtRSI = { 76,        /* lineNo */
  "validateattributes",                /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/lang/validateattributes.m"/* pathName */
};

emlrtRSInfo uc_emlrtRSI = { 28,        /* lineNo */
  "repmat",                            /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/repmat.m"/* pathName */
};

emlrtRSInfo vc_emlrtRSI = { 301,       /* lineNo */
  "ConstantPad",                       /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m"/* pathName */
};

emlrtRSInfo wc_emlrtRSI = { 317,       /* lineNo */
  "ConstantPad",                       /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m"/* pathName */
};

emlrtRSInfo xc_emlrtRSI = { 330,       /* lineNo */
  "ConstantPad",                       /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m"/* pathName */
};

emlrtRSInfo yc_emlrtRSI = { 843,       /* lineNo */
  "filterPartOrWhole",                 /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/imfilter.m"/* pathName */
};

emlrtRSInfo ad_emlrtRSI = { 917,       /* lineNo */
  "imfiltercore",                      /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/imfilter.m"/* pathName */
};

emlrtRSInfo bd_emlrtRSI = { 957,       /* lineNo */
  "imfiltercoreAlgo",                  /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/imfilter.m"/* pathName */
};

emlrtRSInfo cd_emlrtRSI = { 41,        /* lineNo */
  "find",                              /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/find.m"/* pathName */
};

emlrtRSInfo dd_emlrtRSI = { 153,       /* lineNo */
  "eml_find",                          /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/find.m"/* pathName */
};

emlrtRSInfo ed_emlrtRSI = { 377,       /* lineNo */
  "find_first_indices",                /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/find.m"/* pathName */
};

emlrtRSInfo fd_emlrtRSI = { 397,       /* lineNo */
  "find_first_indices",                /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/find.m"/* pathName */
};

emlrtRSInfo hd_emlrtRSI = { 19,        /* lineNo */
  "ind2sub",                           /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/ind2sub.m"/* pathName */
};

emlrtRSInfo id_emlrtRSI = { 7,         /* lineNo */
  "TS_bwlabeln3D26",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_bwlabeln3D26.m"/* pathName */
};

emlrtRSInfo qd_emlrtRSI = { 14,        /* lineNo */
  "max",                               /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/max.m"/* pathName */
};

emlrtRSInfo rd_emlrtRSI = { 20,        /* lineNo */
  "minOrMax",                          /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/minOrMax.m"/* pathName */
};

emlrtRSInfo sd_emlrtRSI = { 45,        /* lineNo */
  "unaryOrBinaryDispatch",             /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/minOrMax.m"/* pathName */
};

emlrtRSInfo td_emlrtRSI = { 145,       /* lineNo */
  "unaryMinOrMax",                     /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"/* pathName */
};

emlrtRSInfo ud_emlrtRSI = { 1019,      /* lineNo */
  "maxRealVectorOmitNaN",              /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"/* pathName */
};

emlrtRSInfo vd_emlrtRSI = { 932,       /* lineNo */
  "minOrMaxRealVector",                /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"/* pathName */
};

emlrtRSInfo wd_emlrtRSI = { 992,       /* lineNo */
  "minOrMaxRealVectorKernel",          /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"/* pathName */
};

emlrtRSInfo xd_emlrtRSI = { 924,       /* lineNo */
  "minOrMaxRealVector",                /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"/* pathName */
};

emlrtRSInfo yd_emlrtRSI = { 975,       /* lineNo */
  "findFirst",                         /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"/* pathName */
};

emlrtRSInfo ae_emlrtRSI = { 167,       /* lineNo */
  "unaryMinOrMax",                     /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"/* pathName */
};

emlrtRSInfo be_emlrtRSI = { 320,       /* lineNo */
  "unaryMinOrMaxDispatch",             /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"/* pathName */
};

emlrtRSInfo ce_emlrtRSI = { 361,       /* lineNo */
  "minOrMax1D",                        /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"/* pathName */
};

emlrtRSInfo qe_emlrtRSI = { 20,        /* lineNo */
  "sum",                               /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/sum.m"/* pathName */
};

emlrtRSInfo re_emlrtRSI = { 96,        /* lineNo */
  "sumprod",                           /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/private/sumprod.m"/* pathName */
};

emlrtRSInfo se_emlrtRSI = { 124,       /* lineNo */
  "combineVectorElements",             /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/private/combineVectorElements.m"/* pathName */
};

emlrtRSInfo te_emlrtRSI = { 163,       /* lineNo */
  "colMajorFlatIter",                  /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/private/combineVectorElements.m"/* pathName */
};

emlrtRSInfo ve_emlrtRSI = { 184,       /* lineNo */
  "colMajorFlatIter",                  /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/private/combineVectorElements.m"/* pathName */
};

emlrtRSInfo cf_emlrtRSI = { 55,        /* lineNo */
  "prodsize",                          /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/shared/coder/coder/+coder/+internal/prodsize.m"/* pathName */
};

emlrtRSInfo lf_emlrtRSI = { 66,        /* lineNo */
  "applyBinaryScalarFunction",         /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/applyBinaryScalarFunction.m"/* pathName */
};

emlrtRSInfo mf_emlrtRSI = { 188,       /* lineNo */
  "flatIter",                          /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/applyBinaryScalarFunction.m"/* pathName */
};

emlrtRSInfo rf_emlrtRSI = { 16,        /* lineNo */
  "min",                               /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/min.m"/* pathName */
};

emlrtRSInfo sf_emlrtRSI = { 17,        /* lineNo */
  "minOrMax",                          /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/minOrMax.m"/* pathName */
};

emlrtRSInfo tf_emlrtRSI = { 43,        /* lineNo */
  "unaryOrBinaryDispatch",             /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/minOrMax.m"/* pathName */
};

emlrtRSInfo uf_emlrtRSI = { 131,       /* lineNo */
  "unaryMinOrMax",                     /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"/* pathName */
};

emlrtRSInfo wf_emlrtRSI = { 70,        /* lineNo */
  "bwdist",                            /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/bwdist.m"/* pathName */
};

emlrtRSInfo xf_emlrtRSI = { 69,        /* lineNo */
  "repmat",                            /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/repmat.m"/* pathName */
};

emlrtRSInfo ag_emlrtRSI = { 7,         /* lineNo */
  "nansum",                            /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/stats/eml/nansum.m"/* pathName */
};

emlrtRSInfo kg_emlrtRSI = { 7,         /* lineNo */
  "nanmax",                            /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/stats/eml/nanmax.m"/* pathName */
};

emlrtRSInfo eh_emlrtRSI = { 50,        /* lineNo */
  "prodsize",                          /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/shared/coder/coder/+coder/+internal/prodsize.m"/* pathName */
};

emlrtRSInfo oh_emlrtRSI = { 587,       /* lineNo */
  "merge_pow2_block",                  /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

emlrtRSInfo ph_emlrtRSI = { 589,       /* lineNo */
  "merge_pow2_block",                  /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

emlrtRSInfo qh_emlrtRSI = { 617,       /* lineNo */
  "merge_pow2_block",                  /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

emlrtRSInfo sh_emlrtRSI = { 506,       /* lineNo */
  "merge_block",                       /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/sortIdx.m"/* pathName */
};

emlrtRSInfo yh_emlrtRSI = { 106,       /* lineNo */
  "diff",                              /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/diff.m"/* pathName */
};

emlrtRSInfo in_emlrtRSI = { 78,        /* lineNo */
  "cat",                               /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/cat.m"/* pathName */
};

emlrtRSInfo jn_emlrtRSI = { 110,       /* lineNo */
  "looper",                            /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/cat.m"/* pathName */
};

emlrtRSInfo kn_emlrtRSI = { 95,        /* lineNo */
  "looper",                            /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/cat.m"/* pathName */
};

emlrtRTEInfo emlrtRTEI = { 43,         /* lineNo */
  23,                                  /* colNo */
  "sumprod",                           /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/private/sumprod.m"/* pName */
};

emlrtRTEInfo d_emlrtRTEI = { 95,       /* lineNo */
  27,                                  /* colNo */
  "unaryMinOrMax",                     /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"/* pName */
};

emlrtRTEInfo e_emlrtRTEI = { 26,       /* lineNo */
  27,                                  /* colNo */
  "unaryMinOrMax",                     /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"/* pName */
};

emlrtRTEInfo f_emlrtRTEI = { 83,       /* lineNo */
  9,                                   /* colNo */
  "checkPOSIXStatus",                  /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/timefun/private/getTime.m"/* pName */
};

emlrtRTEInfo g_emlrtRTEI = { 38,       /* lineNo */
  15,                                  /* colNo */
  "ind2sub_indexClass",                /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/ind2sub.m"/* pName */
};

emlrtRTEInfo h_emlrtRTEI = { 387,      /* lineNo */
  1,                                   /* colNo */
  "find_first_indices",                /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/find.m"/* pName */
};

emlrtBCInfo pc_emlrtBCI = { -1,        /* iFirst */
  -1,                                  /* iLast */
  304,                                 /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "ConstantPad",                       /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

emlrtBCInfo qc_emlrtBCI = { -1,        /* iFirst */
  -1,                                  /* iLast */
  366,                                 /* lineNo */
  143,                                 /* colNo */
  "",                                  /* aName */
  "ConstantPad",                       /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

emlrtBCInfo rc_emlrtBCI = { -1,        /* iFirst */
  -1,                                  /* iLast */
  366,                                 /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "ConstantPad",                       /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

emlrtBCInfo sc_emlrtBCI = { -1,        /* iFirst */
  -1,                                  /* iLast */
  319,                                 /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "ConstantPad",                       /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

emlrtBCInfo tc_emlrtBCI = { -1,        /* iFirst */
  -1,                                  /* iLast */
  331,                                 /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "ConstantPad",                       /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

emlrtBCInfo uc_emlrtBCI = { -1,        /* iFirst */
  -1,                                  /* iLast */
  296,                                 /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "ConstantPad",                       /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

emlrtBCInfo vc_emlrtBCI = { -1,        /* iFirst */
  -1,                                  /* iLast */
  313,                                 /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "ConstantPad",                       /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

emlrtBCInfo wc_emlrtBCI = { -1,        /* iFirst */
  -1,                                  /* iLast */
  325,                                 /* lineNo */
  21,                                  /* colNo */
  "",                                  /* aName */
  "ConstantPad",                       /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m",/* pName */
  0                                    /* checkKind */
};

emlrtRTEInfo i_emlrtRTEI = { 49,       /* lineNo */
  19,                                  /* colNo */
  "assertValidSizeArg",                /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/assertValidSizeArg.m"/* pName */
};

emlrtRTEInfo j_emlrtRTEI = { 64,       /* lineNo */
  15,                                  /* colNo */
  "assertValidSizeArg",                /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/assertValidSizeArg.m"/* pName */
};

emlrtRTEInfo s_emlrtRTEI = { 13,       /* lineNo */
  9,                                   /* colNo */
  "sqrt",                              /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elfun/sqrt.m"/* pName */
};

emlrtRTEInfo mb_emlrtRTEI = { 21,      /* lineNo */
  5,                                   /* colNo */
  "ind2sub",                           /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/ind2sub.m"/* pName */
};

emlrtRTEInfo oc_emlrtRTEI = { 33,      /* lineNo */
  6,                                   /* colNo */
  "find",                              /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/find.m"/* pName */
};

emlrtRTEInfo wc_emlrtRTEI = { 42,      /* lineNo */
  5,                                   /* colNo */
  "ind2sub",                           /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/ind2sub.m"/* pName */
};

emlrtRTEInfo xc_emlrtRTEI = { 43,      /* lineNo */
  5,                                   /* colNo */
  "ind2sub",                           /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/ind2sub.m"/* pName */
};

emlrtRTEInfo nd_emlrtRTEI = { 153,     /* lineNo */
  13,                                  /* colNo */
  "find",                              /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/find.m"/* pName */
};

emlrtRTEInfo pd_emlrtRTEI = { 41,      /* lineNo */
  5,                                   /* colNo */
  "find",                              /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/find.m"/* pName */
};

emlrtRTEInfo rd_emlrtRTEI = { 917,     /* lineNo */
  11,                                  /* colNo */
  "imfilter",                          /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/imfilter.m"/* pName */
};

emlrtRTEInfo vd_emlrtRTEI = { 59,      /* lineNo */
  9,                                   /* colNo */
  "imfilter",                          /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/imfilter.m"/* pName */
};

emlrtRTEInfo wd_emlrtRTEI = { 72,      /* lineNo */
  13,                                  /* colNo */
  "padarray",                          /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/padarray.m"/* pName */
};

emlrtRTEInfo ae_emlrtRTEI = { 30,      /* lineNo */
  1,                                   /* colNo */
  "ind2sub",                           /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/ind2sub.m"/* pName */
};

emlrtRTEInfo jf_emlrtRTEI = { 14,      /* lineNo */
  1,                                   /* colNo */
  "bwdist",                            /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/bwdist.m"/* pName */
};

const char_T cv[26] = { 'e', 'm', 'l', 'r', 't', 'C', 'l', 'o', 'c', 'k', 'G',
  'e', 't', 't', 'i', 'm', 'e', 'M', 'o', 'n', 'o', 't', 'o', 'n', 'i', 'c' };

emlrtRSInfo un_emlrtRSI = { 18,        /* lineNo */
  "indexDivide",                       /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/eml/+coder/+internal/indexDivide.m"/* pathName */
};

/* End of code generation (AutoSegment_data.c) */

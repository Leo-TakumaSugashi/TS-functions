/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * TS_Skeleton3D_oldest.c
 *
 * Code generation for function 'TS_Skeleton3D_oldest'
 *
 */

/* Include files */
#include "TS_Skeleton3D_oldest.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "AutoSegment_mexutil.h"
#include "TS_bwlabeln3D26.h"
#include "diff.h"
#include "eml_int_forloop_overflow_check.h"
#include "find.h"
#include "indexShapeCheck.h"
#include "libmwbwdistEDT_tbb.h"
#include "mwmathutil.h"
#include "padarray.h"
#include "rt_nonfinite.h"
#include "sort.h"
#include "sqrt.h"

/* Variable Definitions */
static emlrtRSInfo mg_emlrtRSI = { 8,  /* lineNo */
  "TS_Skeleton3D_oldest",              /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pathName */
};

static emlrtRSInfo ng_emlrtRSI = { 9,  /* lineNo */
  "TS_Skeleton3D_oldest",              /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pathName */
};

static emlrtRSInfo og_emlrtRSI = { 10, /* lineNo */
  "TS_Skeleton3D_oldest",              /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pathName */
};

static emlrtRSInfo pg_emlrtRSI = { 11, /* lineNo */
  "TS_Skeleton3D_oldest",              /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pathName */
};

static emlrtRSInfo qg_emlrtRSI = { 13, /* lineNo */
  "TS_Skeleton3D_oldest",              /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pathName */
};

static emlrtRSInfo rg_emlrtRSI = { 24, /* lineNo */
  "TS_Skeleton3D_oldest",              /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pathName */
};

static emlrtRSInfo sg_emlrtRSI = { 32, /* lineNo */
  "TS_Skeleton3D_oldest",              /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pathName */
};

static emlrtRSInfo tg_emlrtRSI = { 37, /* lineNo */
  "TS_Skeleton3D_oldest",              /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pathName */
};

static emlrtRSInfo ug_emlrtRSI = { 101,/* lineNo */
  "bwdist",                            /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/bwdist.m"/* pathName */
};

static emlrtRSInfo vg_emlrtRSI = { 104,/* lineNo */
  "bwdist",                            /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/bwdist.m"/* pathName */
};

static emlrtRSInfo wg_emlrtRSI = { 32, /* lineNo */
  "sort",                              /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/sort.m"/* pathName */
};

static emlrtRSInfo ai_emlrtRSI = { 61, /* lineNo */
  "TS_find",                           /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pathName */
};

static emlrtRSInfo bi_emlrtRSI = { 67, /* lineNo */
  "TS_find",                           /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pathName */
};

static emlrtRSInfo ci_emlrtRSI = { 69, /* lineNo */
  "TS_find",                           /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pathName */
};

static emlrtRSInfo di_emlrtRSI = { 71, /* lineNo */
  "TS_find",                           /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pathName */
};

static emlrtRSInfo ei_emlrtRSI = { 73, /* lineNo */
  "TS_find",                           /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pathName */
};

static emlrtRSInfo fi_emlrtRSI = { 75, /* lineNo */
  "TS_find",                           /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pathName */
};

static emlrtRSInfo gi_emlrtRSI = { 77, /* lineNo */
  "TS_find",                           /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pathName */
};

static emlrtRSInfo hi_emlrtRSI = { 27, /* lineNo */
  "sort",                              /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/sort.m"/* pathName */
};

static emlrtBCInfo ee_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  46,                                  /* lineNo */
  9,                                   /* colNo */
  "distBW",                            /* aName */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo fe_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  44,                                  /* lineNo */
  13,                                  /* colNo */
  "bw",                                /* aName */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ge_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  29,                                  /* lineNo */
  49,                                  /* colNo */
  "bw",                                /* aName */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo he_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  29,                                  /* lineNo */
  34,                                  /* colNo */
  "bw",                                /* aName */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ie_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  29,                                  /* lineNo */
  19,                                  /* colNo */
  "bw",                                /* aName */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo je_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  77,                                  /* lineNo */
  55,                                  /* colNo */
  "Z",                                 /* aName */
  "TS_find",                           /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ke_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  75,                                  /* lineNo */
  56,                                  /* colNo */
  "Z",                                 /* aName */
  "TS_find",                           /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo le_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  73,                                  /* lineNo */
  56,                                  /* colNo */
  "Z",                                 /* aName */
  "TS_find",                           /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo me_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  71,                                  /* lineNo */
  55,                                  /* colNo */
  "Z",                                 /* aName */
  "TS_find",                           /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ne_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  69,                                  /* lineNo */
  55,                                  /* colNo */
  "X",                                 /* aName */
  "TS_find",                           /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo oe_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  67,                                  /* lineNo */
  56,                                  /* colNo */
  "X",                                 /* aName */
  "TS_find",                           /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo pe_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  77,                                  /* lineNo */
  43,                                  /* colNo */
  "X",                                 /* aName */
  "TS_find",                           /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo qe_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  75,                                  /* lineNo */
  44,                                  /* colNo */
  "X",                                 /* aName */
  "TS_find",                           /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo re_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  73,                                  /* lineNo */
  44,                                  /* colNo */
  "Y",                                 /* aName */
  "TS_find",                           /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo se_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  71,                                  /* lineNo */
  43,                                  /* colNo */
  "Y",                                 /* aName */
  "TS_find",                           /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo te_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  69,                                  /* lineNo */
  43,                                  /* colNo */
  "Y",                                 /* aName */
  "TS_find",                           /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ue_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  67,                                  /* lineNo */
  44,                                  /* colNo */
  "Y",                                 /* aName */
  "TS_find",                           /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ve_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  13,                                  /* lineNo */
  12,                                  /* colNo */
  "DistStep",                          /* aName */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo we_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  13,                                  /* lineNo */
  14,                                  /* colNo */
  "s",                                 /* aName */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo xe_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  56,                                  /* lineNo */
  26,                                  /* colNo */
  "bw",                                /* aName */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ye_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  56,                                  /* lineNo */
  18,                                  /* colNo */
  "bw",                                /* aName */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo af_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  56,                                  /* lineNo */
  10,                                  /* colNo */
  "bw",                                /* aName */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo bf_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  28,                                  /* lineNo */
  21,                                  /* colNo */
  "newZ",                              /* aName */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo cf_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  21,                                  /* colNo */
  "newX",                              /* aName */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo df_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  21,                                  /* colNo */
  "newY",                              /* aName */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ef_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  13,                                  /* lineNo */
  26,                                  /* colNo */
  "stepfind",                          /* aName */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ff_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  13,                                  /* lineNo */
  24,                                  /* colNo */
  "stepfind",                          /* aName */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo sf_emlrtRTEI = { 8,/* lineNo */
  15,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo tf_emlrtRTEI = { 9,/* lineNo */
  10,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo uf_emlrtRTEI = { 10,/* lineNo */
  1,                                   /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo vf_emlrtRTEI = { 11,/* lineNo */
  17,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo wf_emlrtRTEI = { 11,/* lineNo */
  1,                                   /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo xf_emlrtRTEI = { 13,/* lineNo */
  14,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo yf_emlrtRTEI = { 13,/* lineNo */
  12,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo ag_emlrtRTEI = { 23,/* lineNo */
  5,                                   /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo bg_emlrtRTEI = { 56,/* lineNo */
  1,                                   /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo cg_emlrtRTEI = { 62,/* lineNo */
  1,                                   /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo dg_emlrtRTEI = { 63,/* lineNo */
  1,                                   /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo eg_emlrtRTEI = { 64,/* lineNo */
  1,                                   /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo fg_emlrtRTEI = { 67,/* lineNo */
  10,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo gg_emlrtRTEI = { 69,/* lineNo */
  10,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo hg_emlrtRTEI = { 71,/* lineNo */
  10,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo ig_emlrtRTEI = { 73,/* lineNo */
  10,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo jg_emlrtRTEI = { 75,/* lineNo */
  10,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo kg_emlrtRTEI = { 77,/* lineNo */
  10,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo lg_emlrtRTEI = { 67,/* lineNo */
  38,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo mg_emlrtRTEI = { 69,/* lineNo */
  37,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo ng_emlrtRTEI = { 71,/* lineNo */
  37,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo og_emlrtRTEI = { 73,/* lineNo */
  38,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo pg_emlrtRTEI = { 75,/* lineNo */
  38,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo qg_emlrtRTEI = { 77,/* lineNo */
  37,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo rg_emlrtRTEI = { 67,/* lineNo */
  50,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo sg_emlrtRTEI = { 69,/* lineNo */
  49,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo tg_emlrtRTEI = { 71,/* lineNo */
  49,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo ug_emlrtRTEI = { 73,/* lineNo */
  50,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo vg_emlrtRTEI = { 75,/* lineNo */
  50,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo wg_emlrtRTEI = { 77,/* lineNo */
  49,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo xg_emlrtRTEI = { 1,/* lineNo */
  14,                                  /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

static emlrtRTEInfo yg_emlrtRTEI = { 26,/* lineNo */
  1,                                   /* colNo */
  "bwdist",                            /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/images/images/eml/bwdist.m"/* pName */
};

static emlrtRTEInfo ah_emlrtRTEI = { 61,/* lineNo */
  6,                                   /* colNo */
  "TS_Skeleton3D_oldest",              /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/TS_Skeleton3D_oldest.m"/* pName */
};

/* Function Definitions */
void TS_Skeleton3D_oldest(const emlrtStack *sp, emxArray_boolean_T *bw,
  emxArray_boolean_T *A)
{
  emxArray_boolean_T *b_bw;
  int32_T i;
  int32_T nz;
  emxArray_boolean_T *BW;
  emxArray_real32_T *D;
  int32_T k;
  emxArray_real32_T *s;
  real_T b_BW[3];
  emxArray_boolean_T *x;
  emxArray_real32_T *r;
  emxArray_int32_T *stepfind;
  emxArray_int32_T *ii;
  int32_T i1;
  emxArray_int32_T *r1;
  int32_T i2;
  emxArray_real_T *newY;
  emxArray_real_T *newX;
  emxArray_real_T *newZ;
  emxArray_int32_T *varargout_6;
  emxArray_int32_T *vk;
  int32_T n;
  real32_T b_s;
  int32_T nx;
  int32_T i3;
  int32_T idx;
  int32_T i4;
  int32_T i5;
  boolean_T exitg1;
  int32_T iv[2];
  real_T NUMdef;
  int8_T i6;
  boolean_T ROI[125];
  real_T unusedU0[125];
  real_T NUM;
  boolean_T b_x[27];
  boolean_T b_ROI[27];
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack f_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  f_st.prev = &e_st;
  f_st.tls = e_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInit_boolean_T(sp, &b_bw, 3, &sf_emlrtRTEI, true);

  /*   */
  /*  coder.extrinsic('bwlabeln') */
  /*  A = false(size(bw)); */
  /*  timeval = tic; */
  i = b_bw->size[0] * b_bw->size[1] * b_bw->size[2];
  b_bw->size[0] = bw->size[0];
  b_bw->size[1] = bw->size[1];
  b_bw->size[2] = bw->size[2];
  emxEnsureCapacity_boolean_T(sp, b_bw, i, &sf_emlrtRTEI);
  nz = bw->size[0] * bw->size[1] * bw->size[2] - 1;
  for (i = 0; i <= nz; i++) {
    b_bw->data[i] = bw->data[i];
  }

  emxInit_boolean_T(sp, &BW, 3, &jf_emlrtRTEI, true);
  st.site = &mg_emlrtRSI;
  c_padarray(&st, b_bw, bw);
  st.site = &ng_emlrtRSI;
  i = BW->size[0] * BW->size[1] * BW->size[2];
  BW->size[0] = bw->size[0];
  BW->size[1] = bw->size[1];
  BW->size[2] = bw->size[2];
  emxEnsureCapacity_boolean_T(&st, BW, i, &jf_emlrtRTEI);
  nz = bw->size[0] * bw->size[1] * bw->size[2];
  emxFree_boolean_T(&b_bw);
  for (i = 0; i < nz; i++) {
    BW->data[i] = !bw->data[i];
  }

  emxInit_real32_T(&st, &D, 3, &yg_emlrtRTEI, true);
  i = D->size[0] * D->size[1] * D->size[2];
  D->size[0] = BW->size[0];
  D->size[1] = BW->size[1];
  D->size[2] = BW->size[2];
  emxEnsureCapacity_real32_T(&st, D, i, &tf_emlrtRTEI);
  b_st.site = &ug_emlrtRSI;
  k = 3;
  if (BW->size[2] == 1) {
    k = 2;
  }

  emxInit_real32_T(&b_st, &s, 1, &uf_emlrtRTEI, true);
  b_BW[0] = BW->size[0];
  b_BW[1] = BW->size[1];
  b_BW[2] = BW->size[2];
  bwdistEDT_tbb_boolean(&BW->data[0], b_BW, (real_T)k, &D->data[0]);
  b_st.site = &vg_emlrtRSI;
  c_sqrt(&b_st, D);
  st.site = &og_emlrtRSI;
  i = s->size[0];
  s->size[0] = D->size[0] * D->size[1] * D->size[2];
  emxEnsureCapacity_real32_T(&st, s, i, &uf_emlrtRTEI);
  nz = D->size[0] * D->size[1] * D->size[2];
  for (i = 0; i < nz; i++) {
    s->data[i] = D->data[i];
  }

  emxInit_boolean_T(&st, &x, 1, &vf_emlrtRTEI, true);
  emxInit_real32_T(&st, &r, 1, &vf_emlrtRTEI, true);
  b_st.site = &wg_emlrtRSI;
  sort(&b_st, s);
  st.site = &pg_emlrtRSI;
  b_st.site = &pg_emlrtRSI;
  b_diff(&b_st, s, r);
  i = x->size[0];
  x->size[0] = r->size[0];
  emxEnsureCapacity_boolean_T(&st, x, i, &vf_emlrtRTEI);
  nz = r->size[0];
  for (i = 0; i < nz; i++) {
    x->data[i] = (r->data[i] > 0.0F);
  }

  emxFree_real32_T(&r);
  emxInit_int32_T(&st, &stepfind, 1, &wf_emlrtRTEI, true);
  emxInit_int32_T(&st, &ii, 1, &oc_emlrtRTEI, true);
  b_st.site = &cd_emlrtRSI;
  eml_find(&b_st, x, ii);
  i = stepfind->size[0];
  stepfind->size[0] = ii->size[0];
  emxEnsureCapacity_int32_T(&st, stepfind, i, &wf_emlrtRTEI);
  nz = ii->size[0];
  emxFree_boolean_T(&x);
  for (i = 0; i < nz; i++) {
    stepfind->data[i] = ii->data[i];
  }

  if (2 > stepfind->size[0]) {
    i = 0;
    i1 = 0;
  } else {
    if (2 > stepfind->size[0]) {
      emlrtDynamicBoundsCheckR2012b(2, 1, stepfind->size[0], &ff_emlrtBCI, sp);
    }

    i = 1;
    if ((ii->size[0] < 1) || (ii->size[0] > stepfind->size[0])) {
      emlrtDynamicBoundsCheckR2012b(ii->size[0], 1, stepfind->size[0],
        &ef_emlrtBCI, sp);
    }

    i1 = ii->size[0];
  }

  emxInit_int32_T(sp, &r1, 2, &xg_emlrtRTEI, true);
  i2 = r1->size[0] * r1->size[1];
  r1->size[0] = 1;
  nz = i1 - i;
  r1->size[1] = nz + 1;
  emxEnsureCapacity_int32_T(sp, r1, i2, &xf_emlrtRTEI);
  for (i1 = 0; i1 < nz; i1++) {
    r1->data[i1] = stepfind->data[i + i1];
  }

  r1->data[nz] = s->size[0];
  st.site = &qg_emlrtRSI;
  indexShapeCheck(&st, s->size[0], *(int32_T (*)[2])r1->size);
  nz = r1->size[0] * r1->size[1];
  for (i = 0; i < nz; i++) {
    i1 = r1->data[i];
    if ((i1 < 1) || (i1 > s->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, s->size[0], &we_emlrtBCI, sp);
    }
  }

  /*  clear s stepfind */
  /*  waitbarh = waitbar(0,'Please wait....'); */
  /*   set(waitbarh,'Name',[mfilename '  ,Skeletoning...']) */
  /*  count = 1; */
  /*  NUMbw = sum(bw(:)); */
  /*  NUMdef = double(1); */
  /*  NUM = NUMdef; */
  i = ii->size[0];
  ii->size[0] = r1->size[1];
  emxEnsureCapacity_int32_T(sp, ii, i, &yf_emlrtRTEI);
  nz = r1->size[1];
  for (i = 0; i < nz; i++) {
    ii->data[i] = r1->data[i];
  }

  i = ii->size[0];
  emxInit_real_T(sp, &newY, 1, &xg_emlrtRTEI, true);
  emxInit_real_T(sp, &newX, 1, &xg_emlrtRTEI, true);
  emxInit_real_T(sp, &newZ, 1, &xg_emlrtRTEI, true);
  emxInit_int32_T(sp, &varargout_6, 1, &ah_emlrtRTEI, true);
  emxInit_int32_T(sp, &vk, 1, &wc_emlrtRTEI, true);
  for (n = 0; n < i; n++) {
    i1 = BW->size[0] * BW->size[1] * BW->size[2];
    BW->size[0] = D->size[0];
    BW->size[1] = D->size[1];
    BW->size[2] = D->size[2];
    emxEnsureCapacity_boolean_T(sp, BW, i1, &ag_emlrtRTEI);
    nz = r1->size[1];
    i1 = ii->size[0];
    ii->size[0] = r1->size[1];
    emxEnsureCapacity_int32_T(sp, ii, i1, &yf_emlrtRTEI);
    for (i1 = 0; i1 < nz; i1++) {
      ii->data[i1] = r1->data[i1];
    }

    i1 = n + 1;
    if ((i1 < 1) || (i1 > ii->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, ii->size[0], &ve_emlrtBCI, sp);
    }

    b_s = s->data[r1->data[i1 - 1] - 1];
    nz = D->size[0] * D->size[1] * D->size[2];
    for (i1 = 0; i1 < nz; i1++) {
      BW->data[i1] = (D->data[i1] == b_s);
    }

    st.site = &rg_emlrtRSI;
    b_st.site = &ai_emlrtRSI;
    c_st.site = &cd_emlrtRSI;
    nx = BW->size[0] * BW->size[1] * BW->size[2];
    d_st.site = &dd_emlrtRSI;
    idx = 0;
    i1 = ii->size[0];
    ii->size[0] = BW->size[0] * BW->size[1] * BW->size[2];
    emxEnsureCapacity_int32_T(&d_st, ii, i1, &nd_emlrtRTEI);
    e_st.site = &ed_emlrtRSI;
    if ((1 <= BW->size[0] * BW->size[1] * BW->size[2]) && (BW->size[0] *
         BW->size[1] * BW->size[2] > 2147483646)) {
      f_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&f_st);
    }

    nz = 0;
    exitg1 = false;
    while ((!exitg1) && (nz <= nx - 1)) {
      if (BW->data[nz]) {
        idx++;
        ii->data[idx - 1] = nz + 1;
        if (idx >= nx) {
          exitg1 = true;
        } else {
          nz++;
        }
      } else {
        nz++;
      }
    }

    if (idx > BW->size[0] * BW->size[1] * BW->size[2]) {
      emlrtErrorWithMessageIdR2018a(&d_st, &h_emlrtRTEI,
        "Coder:builtins:AssertionFailed", "Coder:builtins:AssertionFailed", 0);
    }

    if (BW->size[0] * BW->size[1] * BW->size[2] == 1) {
      if (idx == 0) {
        ii->size[0] = 0;
      }
    } else {
      if (1 > idx) {
        i1 = 0;
      } else {
        i1 = idx;
      }

      iv[0] = 1;
      iv[1] = i1;
      e_st.site = &fd_emlrtRSI;
      indexShapeCheck(&e_st, ii->size[0], iv);
      i2 = ii->size[0];
      ii->size[0] = i1;
      emxEnsureCapacity_int32_T(&d_st, ii, i2, &pd_emlrtRTEI);
    }

    b_st.site = &ai_emlrtRSI;
    nx = BW->size[0];
    c_st.site = &hd_emlrtRSI;
    idx = BW->size[1] * BW->size[0];
    nz = idx * BW->size[2];
    k = 0;
    exitg1 = false;
    while ((!exitg1) && (k <= ii->size[0] - 1)) {
      if (ii->data[k] <= nz) {
        k++;
      } else {
        emlrtErrorWithMessageIdR2018a(&c_st, &g_emlrtRTEI,
          "Coder:MATLAB:ind2sub_IndexOutOfRange",
          "Coder:MATLAB:ind2sub_IndexOutOfRange", 0);
      }
    }

    nz = ii->size[0];
    for (i1 = 0; i1 < nz; i1++) {
      ii->data[i1]--;
    }

    i1 = vk->size[0];
    vk->size[0] = ii->size[0];
    emxEnsureCapacity_int32_T(&c_st, vk, i1, &wc_emlrtRTEI);
    nz = ii->size[0];
    for (i1 = 0; i1 < nz; i1++) {
      d_st.site = &un_emlrtRSI;
      vk->data[i1] = div_s32(&d_st, ii->data[i1], idx);
    }

    nz = vk->size[0];
    i1 = varargout_6->size[0];
    varargout_6->size[0] = vk->size[0];
    emxEnsureCapacity_int32_T(&c_st, varargout_6, i1, &xc_emlrtRTEI);
    for (i1 = 0; i1 < nz; i1++) {
      varargout_6->data[i1] = vk->data[i1] + 1;
    }

    nz = ii->size[0];
    for (i1 = 0; i1 < nz; i1++) {
      ii->data[i1] -= vk->data[i1] * idx;
    }

    i1 = vk->size[0];
    vk->size[0] = ii->size[0];
    emxEnsureCapacity_int32_T(&c_st, vk, i1, &wc_emlrtRTEI);
    nz = ii->size[0];
    for (i1 = 0; i1 < nz; i1++) {
      d_st.site = &un_emlrtRSI;
      vk->data[i1] = div_s32(&d_st, ii->data[i1], nx);
    }

    nz = ii->size[0];
    for (i1 = 0; i1 < nz; i1++) {
      ii->data[i1] -= vk->data[i1] * nx;
    }

    i1 = stepfind->size[0];
    stepfind->size[0] = ii->size[0];
    emxEnsureCapacity_int32_T(&b_st, stepfind, i1, &mb_emlrtRTEI);
    nz = ii->size[0];
    for (i1 = 0; i1 < nz; i1++) {
      stepfind->data[i1] = ii->data[i1] + 1;
    }

    nz = vk->size[0];
    for (i1 = 0; i1 < nz; i1++) {
      vk->data[i1]++;
    }

    i1 = newY->size[0];
    newY->size[0] = stepfind->size[0];
    emxEnsureCapacity_real_T(&st, newY, i1, &cg_emlrtRTEI);
    nz = stepfind->size[0];
    for (i1 = 0; i1 < nz; i1++) {
      newY->data[i1] = 0.0;
    }

    i1 = newX->size[0];
    newX->size[0] = stepfind->size[0];
    emxEnsureCapacity_real_T(&st, newX, i1, &dg_emlrtRTEI);
    nz = stepfind->size[0];
    for (i1 = 0; i1 < nz; i1++) {
      newX->data[i1] = 0.0;
    }

    i1 = newZ->size[0];
    newZ->size[0] = stepfind->size[0];
    emxEnsureCapacity_real_T(&st, newZ, i1, &eg_emlrtRTEI);
    nz = stepfind->size[0];
    for (i1 = 0; i1 < nz; i1++) {
      newZ->data[i1] = 0.0;
    }

    NUMdef = (((real_T)n + 1.0) - 1.0) / 6.0;
    i1 = (int32_T)muDoubleScalarRound((NUMdef - muDoubleScalarFloor(NUMdef)) *
      6.0);
    if (i1 < 128) {
      if (i1 >= -128) {
        i6 = (int8_T)i1;
      } else {
        i6 = MIN_int8_T;
      }
    } else {
      i6 = MAX_int8_T;
    }

    switch (i6) {
     case 0:
      b_st.site = &bi_emlrtRSI;
      nz = varargout_6->size[0];
      i1 = newZ->size[0];
      newZ->size[0] = varargout_6->size[0];
      emxEnsureCapacity_real_T(&b_st, newZ, i1, &fg_emlrtRTEI);
      for (i1 = 0; i1 < nz; i1++) {
        newZ->data[i1] = varargout_6->data[i1];
      }

      c_st.site = &hi_emlrtRSI;
      b_sort(&c_st, newZ, ii);
      i1 = newY->size[0];
      newY->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newY, i1, &lg_emlrtRTEI);
      nz = ii->size[0];
      for (i1 = 0; i1 < nz; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > stepfind->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, stepfind->size[0],
            &ue_emlrtBCI, &st);
        }

        newY->data[i1] = stepfind->data[ii->data[i1] - 1];
      }

      i1 = newX->size[0];
      newX->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newX, i1, &rg_emlrtRTEI);
      nz = ii->size[0];
      for (i1 = 0; i1 < nz; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > vk->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, vk->size[0],
            &oe_emlrtBCI, &st);
        }

        newX->data[i1] = vk->data[ii->data[i1] - 1];
      }
      break;

     case 1:
      b_st.site = &ci_emlrtRSI;
      nz = varargout_6->size[0];
      i1 = newZ->size[0];
      newZ->size[0] = varargout_6->size[0];
      emxEnsureCapacity_real_T(&b_st, newZ, i1, &gg_emlrtRTEI);
      for (i1 = 0; i1 < nz; i1++) {
        newZ->data[i1] = varargout_6->data[i1];
      }

      c_st.site = &hi_emlrtRSI;
      c_sort(&c_st, newZ, ii);
      i1 = newY->size[0];
      newY->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newY, i1, &mg_emlrtRTEI);
      nz = ii->size[0];
      for (i1 = 0; i1 < nz; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > stepfind->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, stepfind->size[0],
            &te_emlrtBCI, &st);
        }

        newY->data[i1] = stepfind->data[ii->data[i1] - 1];
      }

      i1 = newX->size[0];
      newX->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newX, i1, &sg_emlrtRTEI);
      nz = ii->size[0];
      for (i1 = 0; i1 < nz; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > vk->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, vk->size[0],
            &ne_emlrtBCI, &st);
        }

        newX->data[i1] = vk->data[ii->data[i1] - 1];
      }
      break;

     case 2:
      b_st.site = &di_emlrtRSI;
      nz = vk->size[0];
      i1 = newX->size[0];
      newX->size[0] = vk->size[0];
      emxEnsureCapacity_real_T(&b_st, newX, i1, &hg_emlrtRTEI);
      for (i1 = 0; i1 < nz; i1++) {
        newX->data[i1] = vk->data[i1];
      }

      c_st.site = &hi_emlrtRSI;
      c_sort(&c_st, newX, ii);
      i1 = newY->size[0];
      newY->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newY, i1, &ng_emlrtRTEI);
      nz = ii->size[0];
      for (i1 = 0; i1 < nz; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > stepfind->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, stepfind->size[0],
            &se_emlrtBCI, &st);
        }

        newY->data[i1] = stepfind->data[ii->data[i1] - 1];
      }

      i1 = newZ->size[0];
      newZ->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newZ, i1, &tg_emlrtRTEI);
      nz = ii->size[0];
      for (i1 = 0; i1 < nz; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > varargout_6->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, varargout_6->size[0],
            &me_emlrtBCI, &st);
        }

        newZ->data[i1] = varargout_6->data[ii->data[i1] - 1];
      }
      break;

     case 3:
      b_st.site = &ei_emlrtRSI;
      nz = vk->size[0];
      i1 = newX->size[0];
      newX->size[0] = vk->size[0];
      emxEnsureCapacity_real_T(&b_st, newX, i1, &ig_emlrtRTEI);
      for (i1 = 0; i1 < nz; i1++) {
        newX->data[i1] = vk->data[i1];
      }

      c_st.site = &hi_emlrtRSI;
      b_sort(&c_st, newX, ii);
      i1 = newY->size[0];
      newY->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newY, i1, &og_emlrtRTEI);
      nz = ii->size[0];
      for (i1 = 0; i1 < nz; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > stepfind->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, stepfind->size[0],
            &re_emlrtBCI, &st);
        }

        newY->data[i1] = stepfind->data[ii->data[i1] - 1];
      }

      i1 = newZ->size[0];
      newZ->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newZ, i1, &ug_emlrtRTEI);
      nz = ii->size[0];
      for (i1 = 0; i1 < nz; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > varargout_6->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, varargout_6->size[0],
            &le_emlrtBCI, &st);
        }

        newZ->data[i1] = varargout_6->data[ii->data[i1] - 1];
      }
      break;

     case 4:
      b_st.site = &fi_emlrtRSI;
      nz = stepfind->size[0];
      i1 = newY->size[0];
      newY->size[0] = stepfind->size[0];
      emxEnsureCapacity_real_T(&b_st, newY, i1, &jg_emlrtRTEI);
      for (i1 = 0; i1 < nz; i1++) {
        newY->data[i1] = stepfind->data[i1];
      }

      c_st.site = &hi_emlrtRSI;
      b_sort(&c_st, newY, ii);
      i1 = newX->size[0];
      newX->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newX, i1, &pg_emlrtRTEI);
      nz = ii->size[0];
      for (i1 = 0; i1 < nz; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > vk->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, vk->size[0],
            &qe_emlrtBCI, &st);
        }

        newX->data[i1] = vk->data[ii->data[i1] - 1];
      }

      i1 = newZ->size[0];
      newZ->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newZ, i1, &vg_emlrtRTEI);
      nz = ii->size[0];
      for (i1 = 0; i1 < nz; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > varargout_6->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, varargout_6->size[0],
            &ke_emlrtBCI, &st);
        }

        newZ->data[i1] = varargout_6->data[ii->data[i1] - 1];
      }
      break;

     case 5:
      b_st.site = &gi_emlrtRSI;
      nz = stepfind->size[0];
      i1 = newY->size[0];
      newY->size[0] = stepfind->size[0];
      emxEnsureCapacity_real_T(&b_st, newY, i1, &kg_emlrtRTEI);
      for (i1 = 0; i1 < nz; i1++) {
        newY->data[i1] = stepfind->data[i1];
      }

      c_st.site = &hi_emlrtRSI;
      c_sort(&c_st, newY, ii);
      i1 = newX->size[0];
      newX->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newX, i1, &qg_emlrtRTEI);
      nz = ii->size[0];
      for (i1 = 0; i1 < nz; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > vk->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, vk->size[0],
            &pe_emlrtBCI, &st);
        }

        newX->data[i1] = vk->data[ii->data[i1] - 1];
      }

      i1 = newZ->size[0];
      newZ->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newZ, i1, &wg_emlrtRTEI);
      nz = ii->size[0];
      for (i1 = 0; i1 < nz; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > varargout_6->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, varargout_6->size[0],
            &je_emlrtBCI, &st);
        }

        newZ->data[i1] = varargout_6->data[ii->data[i1] - 1];
      }
      break;
    }

    /*   */
    /*  function [y,x,z] = TS_find(ROI,val) */
    /*  val = int8(round((val/6 - floor(val/6)) * 6)); */
    /*  [Y,X,Z] = ind2sub(size(ROI),find(ROI(:))); */
    /*  y = zeros(size(Y),'like',double(1)); */
    /*  x = y; */
    /*  z = y; */
    /*  switch val */
    /*      case 0 */
    /*          [z,Ind] = sort(Z,'ascend'); y = Y(Ind); x = X(Ind); */
    /*      case 1 */
    /*          [Y,Ind] = sort(Y,'descend'); X = X(Ind); Z = Z(Ind); */
    /*          [X,Ind] = sort(X,'descend'); Y = Y(Ind); Z = Z(Ind); */
    /*          [z,Ind] = sort(Z,'descend'); y = Y(Ind); x = X(Ind); */
    /*      case 2 */
    /*          [x,Ind] = sort(X,'ascend'); y = Y(Ind); z = Z(Ind);                 */
    /*      case 3 */
    /*          [Y,Ind] = sort(Y,'descend'); X = X(Ind); Z = Z(Ind); */
    /*          [Z,Ind] = sort(Z,'descend'); Y = Y(Ind); X = X(Ind); */
    /*          [x,Ind] = sort(X,'descend'); y = Y(Ind); z = Z(Ind); */
    /*      case 4 */
    /*          [y,Ind] = sort(Y,'ascend'); x = X(Ind); z = Z(Ind);                 */
    /*      case 5 */
    /*          [Z,Ind] = sort(Z,'descend'); Y = Y(Ind); X = X(Ind); */
    /*          [X,Ind] = sort(X,'descend'); Y = Y(Ind); Z = Z(Ind); */
    /*          [y,Ind] = sort(Y,'descend'); x = X(Ind); z = Z(Ind); */
    /*  end */
    /*           */
    /*  end */
    i1 = newY->size[0];
    for (k = 0; k < i1; k++) {
      i2 = k + 1;
      if ((i2 < 1) || (i2 > newY->size[0])) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, newY->size[0], &df_emlrtBCI, sp);
      }

      i2 = k + 1;
      if ((i2 < 1) || (i2 > newX->size[0])) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, newX->size[0], &cf_emlrtBCI, sp);
      }

      i2 = k + 1;
      if ((i2 < 1) || (i2 > newZ->size[0])) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, newZ->size[0], &bf_emlrtBCI, sp);
      }

      for (i2 = 0; i2 < 5; i2++) {
        i3 = (int32_T)(newZ->data[k] + ((real_T)i2 + -2.0));
        for (i4 = 0; i4 < 5; i4++) {
          i5 = (int32_T)(newX->data[k] + ((real_T)i4 + -2.0));
          for (nx = 0; nx < 5; nx++) {
            if ((i3 < 1) || (i3 > bw->size[2])) {
              emlrtDynamicBoundsCheckR2012b(i3, 1, bw->size[2], &ge_emlrtBCI, sp);
            }

            if ((i5 < 1) || (i5 > bw->size[1])) {
              emlrtDynamicBoundsCheckR2012b(i5, 1, bw->size[1], &he_emlrtBCI, sp);
            }

            idx = (int32_T)(newY->data[k] + ((real_T)nx + -2.0));
            if ((idx < 1) || (idx > bw->size[0])) {
              emlrtDynamicBoundsCheckR2012b(idx, 1, bw->size[0], &ie_emlrtBCI,
                sp);
            }

            ROI[(nx + 5 * i4) + 25 * i2] = bw->data[((idx + bw->size[0] * (i5 -
              1)) + bw->size[0] * bw->size[1] * (i3 - 1)) - 1];
          }
        }
      }

      /*              s = bwconncomp(ROI,26);             */
      /*              NUMdef = s.NumObjects; */
      st.site = &sg_emlrtRSI;
      b_TS_bwlabeln3D26(&st, ROI, unusedU0, &NUMdef);

      /*              mxDestroyArray(NUMdef) */
      ROI[62] = false;

      /*              s = bwconncomp(ROI,26); */
      /*              NUM = s.NumObjects; */
      st.site = &tg_emlrtRSI;
      b_TS_bwlabeln3D26(&st, ROI, unusedU0, &NUM);

      /*              mxDestroyArray(NUM) */
      /*  Object Number is Equal or Not */
      for (i2 = 0; i2 < 3; i2++) {
        for (i3 = 0; i3 < 3; i3++) {
          nx = 5 * (i3 + 1) + 25 * (i2 + 1);
          idx = 3 * i3 + 9 * i2;
          b_ROI[idx] = ROI[nx + 1];
          b_ROI[idx + 1] = ROI[nx + 2];
          b_ROI[idx + 2] = ROI[nx + 3];
        }
      }

      for (i2 = 0; i2 < 27; i2++) {
        b_x[i2] = b_ROI[i2];
      }

      nz = ROI[31];
      for (nx = 0; nx < 26; nx++) {
        nz += b_x[nx + 1];
      }

      /*  End point or Not */
      /*                  TF3 =  */
      if ((NUM == NUMdef) && (nz != 1)) {
        i2 = (int32_T)newZ->data[k];
        if ((i2 < 1) || (i2 > bw->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, bw->size[2], &fe_emlrtBCI, sp);
        }

        i3 = (int32_T)newX->data[k];
        if ((i3 < 1) || (i3 > bw->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, bw->size[1], &fe_emlrtBCI, sp);
        }

        i4 = (int32_T)newY->data[k];
        if ((i4 < 1) || (i4 > bw->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, bw->size[0], &fe_emlrtBCI, sp);
        }

        bw->data[((i4 + bw->size[0] * (i3 - 1)) + bw->size[0] * bw->size[1] *
                  (i2 - 1)) - 1] = false;
      }

      i2 = (int32_T)newZ->data[k];
      if ((i2 < 1) || (i2 > BW->size[2])) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, BW->size[2], &ee_emlrtBCI, sp);
      }

      i3 = (int32_T)newX->data[k];
      if ((i3 < 1) || (i3 > BW->size[1])) {
        emlrtDynamicBoundsCheckR2012b(i3, 1, BW->size[1], &ee_emlrtBCI, sp);
      }

      i4 = (int32_T)newY->data[k];
      if ((i4 < 1) || (i4 > BW->size[0])) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, BW->size[0], &ee_emlrtBCI, sp);
      }

      BW->data[((i4 + BW->size[0] * (i3 - 1)) + BW->size[0] * BW->size[1] * (i2
                 - 1)) - 1] = false;

      /*          waitbar(count/NUMbw,waitbarh,['Please wait...  ' num2str(count) '/' num2str(NUMbw)])  */
      /*          count = count + 1; */
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(sp);
      }
    }

    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_int32_T(&vk);
  emxFree_int32_T(&varargout_6);
  emxFree_real32_T(&D);
  emxFree_boolean_T(&BW);
  emxFree_int32_T(&ii);
  emxFree_int32_T(&r1);
  emxFree_real_T(&newZ);
  emxFree_real_T(&newX);
  emxFree_real_T(&newY);
  emxFree_int32_T(&stepfind);
  emxFree_real32_T(&s);

  /*  close(waitbarh) */
  /*  TIMEout = toc(timeval); */
  /*  disp(['    ' mfilename ... */
  /*      '/Time :' num2str(floor(TIMEout/60),'%.0f') ' min. ' .... */
  /*      num2str(TIMEout-60*floor(TIMEout/60),'%.1f') ' sec. ']) */
  if (3 > bw->size[0] - 2) {
    i = 0;
    i1 = 0;
  } else {
    i = 2;
    i1 = bw->size[0] - 2;
    if ((i1 < 1) || (i1 > bw->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, bw->size[0], &af_emlrtBCI, sp);
    }
  }

  if (3 > bw->size[1] - 2) {
    i2 = 0;
    i3 = 0;
  } else {
    i2 = 2;
    i3 = bw->size[1] - 2;
    if ((i3 < 1) || (i3 > bw->size[1])) {
      emlrtDynamicBoundsCheckR2012b(i3, 1, bw->size[1], &ye_emlrtBCI, sp);
    }
  }

  if (3 > bw->size[2] - 2) {
    i4 = 0;
    i5 = 0;
  } else {
    i4 = 2;
    i5 = bw->size[2] - 2;
    if ((i5 < 1) || (i5 > bw->size[2])) {
      emlrtDynamicBoundsCheckR2012b(i5, 1, bw->size[2], &xe_emlrtBCI, sp);
    }
  }

  nz = i1 - i;
  i1 = A->size[0] * A->size[1] * A->size[2];
  A->size[0] = nz;
  nx = i3 - i2;
  A->size[1] = nx;
  idx = i5 - i4;
  A->size[2] = idx;
  emxEnsureCapacity_boolean_T(sp, A, i1, &bg_emlrtRTEI);
  for (i1 = 0; i1 < idx; i1++) {
    for (i3 = 0; i3 < nx; i3++) {
      for (i5 = 0; i5 < nz; i5++) {
        A->data[(i5 + A->size[0] * i3) + A->size[0] * A->size[1] * i1] =
          bw->data[((i + i5) + bw->size[0] * (i2 + i3)) + bw->size[0] * bw->
          size[1] * (i4 + i1)];
      }
    }
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (TS_Skeleton3D_oldest.c) */

/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * TS_Skeleton3D.c
 *
 * Code generation for function 'TS_Skeleton3D'
 *
 */

/* Include files */
#include "TS_Skeleton3D.h"
#include "TS_Skeleton3D_data.h"
#include "TS_Skeleton3D_emxutil.h"
#include "TS_Skeleton3D_mexutil.h"
#include "TS_bwlabeln3D26.h"
#include "bwdist.h"
#include "diff.h"
#include "eml_int_forloop_overflow_check.h"
#include "find.h"
#include "indexShapeCheck.h"
#include "mwmathutil.h"
#include "padarray.h"
#include "rt_nonfinite.h"
#include "sort.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 10,    /* lineNo */
  "TS_Skeleton3D",                     /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo b_emlrtRSI = { 11,  /* lineNo */
  "TS_Skeleton3D",                     /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo c_emlrtRSI = { 12,  /* lineNo */
  "TS_Skeleton3D",                     /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo d_emlrtRSI = { 13,  /* lineNo */
  "TS_Skeleton3D",                     /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo e_emlrtRSI = { 15,  /* lineNo */
  "TS_Skeleton3D",                     /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo f_emlrtRSI = { 16,  /* lineNo */
  "TS_Skeleton3D",                     /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo g_emlrtRSI = { 18,  /* lineNo */
  "TS_Skeleton3D",                     /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo h_emlrtRSI = { 19,  /* lineNo */
  "TS_Skeleton3D",                     /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo i_emlrtRSI = { 21,  /* lineNo */
  "TS_Skeleton3D",                     /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo j_emlrtRSI = { 32,  /* lineNo */
  "TS_Skeleton3D",                     /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo k_emlrtRSI = { 40,  /* lineNo */
  "TS_Skeleton3D",                     /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo l_emlrtRSI = { 45,  /* lineNo */
  "TS_Skeleton3D",                     /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo x_emlrtRSI = { 32,  /* lineNo */
  "sort",                              /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/datafun/sort.m"/* pathName */
};

static emlrtRSInfo gc_emlrtRSI = { 70, /* lineNo */
  "TS_find",                           /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo hc_emlrtRSI = { 76, /* lineNo */
  "TS_find",                           /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo ic_emlrtRSI = { 78, /* lineNo */
  "TS_find",                           /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo jc_emlrtRSI = { 80, /* lineNo */
  "TS_find",                           /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo kc_emlrtRSI = { 82, /* lineNo */
  "TS_find",                           /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo lc_emlrtRSI = { 84, /* lineNo */
  "TS_find",                           /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo mc_emlrtRSI = { 86, /* lineNo */
  "TS_find",                           /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pathName */
};

static emlrtRSInfo oc_emlrtRSI = { 27, /* lineNo */
  "sort",                              /* fcnName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/datafun/sort.m"/* pathName */
};

static emlrtRSInfo pc_emlrtRSI = { 7,  /* lineNo */
  "TS_bwlabeln3D26",                   /* fcnName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_bwlabeln3D26.m"/* pathName */
};

static emlrtBCInfo emlrtBCI = { -1,    /* iFirst */
  -1,                                  /* iLast */
  54,                                  /* lineNo */
  9,                                   /* colNo */
  "distBW",                            /* aName */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo b_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  52,                                  /* lineNo */
  13,                                  /* colNo */
  "bw",                                /* aName */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  37,                                  /* lineNo */
  49,                                  /* colNo */
  "bw",                                /* aName */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo d_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  37,                                  /* lineNo */
  34,                                  /* colNo */
  "bw",                                /* aName */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo e_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  37,                                  /* lineNo */
  19,                                  /* colNo */
  "bw",                                /* aName */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo f_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  86,                                  /* lineNo */
  55,                                  /* colNo */
  "Z",                                 /* aName */
  "TS_find",                           /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo g_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  84,                                  /* lineNo */
  56,                                  /* colNo */
  "Z",                                 /* aName */
  "TS_find",                           /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo h_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  82,                                  /* lineNo */
  56,                                  /* colNo */
  "Z",                                 /* aName */
  "TS_find",                           /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo i_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  80,                                  /* lineNo */
  55,                                  /* colNo */
  "Z",                                 /* aName */
  "TS_find",                           /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo j_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  78,                                  /* lineNo */
  55,                                  /* colNo */
  "X",                                 /* aName */
  "TS_find",                           /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo k_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  76,                                  /* lineNo */
  56,                                  /* colNo */
  "X",                                 /* aName */
  "TS_find",                           /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo l_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  86,                                  /* lineNo */
  43,                                  /* colNo */
  "X",                                 /* aName */
  "TS_find",                           /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo m_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  84,                                  /* lineNo */
  44,                                  /* colNo */
  "X",                                 /* aName */
  "TS_find",                           /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo n_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  82,                                  /* lineNo */
  44,                                  /* colNo */
  "Y",                                 /* aName */
  "TS_find",                           /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo o_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  80,                                  /* lineNo */
  43,                                  /* colNo */
  "Y",                                 /* aName */
  "TS_find",                           /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo p_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  78,                                  /* lineNo */
  43,                                  /* colNo */
  "Y",                                 /* aName */
  "TS_find",                           /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo q_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  76,                                  /* lineNo */
  44,                                  /* colNo */
  "Y",                                 /* aName */
  "TS_find",                           /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo r_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  21,                                  /* lineNo */
  12,                                  /* colNo */
  "DistStep",                          /* aName */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo s_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  21,                                  /* lineNo */
  14,                                  /* colNo */
  "s",                                 /* aName */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo t_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  65,                                  /* lineNo */
  26,                                  /* colNo */
  "bw",                                /* aName */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo u_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  65,                                  /* lineNo */
  18,                                  /* colNo */
  "bw",                                /* aName */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo v_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  65,                                  /* lineNo */
  10,                                  /* colNo */
  "bw",                                /* aName */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo w_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  36,                                  /* lineNo */
  21,                                  /* colNo */
  "newZ",                              /* aName */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo x_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  35,                                  /* lineNo */
  21,                                  /* colNo */
  "newX",                              /* aName */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo y_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  34,                                  /* lineNo */
  21,                                  /* colNo */
  "newY",                              /* aName */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ab_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  21,                                  /* lineNo */
  26,                                  /* colNo */
  "stepfind",                          /* aName */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo bb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  21,                                  /* lineNo */
  24,                                  /* colNo */
  "stepfind",                          /* aName */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo i_emlrtRTEI = { 15,/* lineNo */
  19,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo j_emlrtRTEI = { 10,/* lineNo */
  19,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo k_emlrtRTEI = { 16,/* lineNo */
  21,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo l_emlrtRTEI = { 11,/* lineNo */
  21,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo m_emlrtRTEI = { 18,/* lineNo */
  1,                                   /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo n_emlrtRTEI = { 12,/* lineNo */
  19,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo o_emlrtRTEI = { 19,/* lineNo */
  17,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo p_emlrtRTEI = { 13,/* lineNo */
  23,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo q_emlrtRTEI = { 19,/* lineNo */
  1,                                   /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo r_emlrtRTEI = { 21,/* lineNo */
  14,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo s_emlrtRTEI = { 21,/* lineNo */
  12,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo t_emlrtRTEI = { 31,/* lineNo */
  5,                                   /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo u_emlrtRTEI = { 65,/* lineNo */
  1,                                   /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo w_emlrtRTEI = { 41,/* lineNo */
  5,                                   /* colNo */
  "find",                              /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/find.m"/* pName */
};

static emlrtRTEInfo ab_emlrtRTEI = { 21,/* lineNo */
  5,                                   /* colNo */
  "ind2sub",                           /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/ind2sub.m"/* pName */
};

static emlrtRTEInfo bb_emlrtRTEI = { 71,/* lineNo */
  1,                                   /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo cb_emlrtRTEI = { 72,/* lineNo */
  1,                                   /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo db_emlrtRTEI = { 73,/* lineNo */
  1,                                   /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo eb_emlrtRTEI = { 76,/* lineNo */
  10,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo fb_emlrtRTEI = { 78,/* lineNo */
  10,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo gb_emlrtRTEI = { 80,/* lineNo */
  10,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo hb_emlrtRTEI = { 82,/* lineNo */
  10,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo ib_emlrtRTEI = { 84,/* lineNo */
  10,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo jb_emlrtRTEI = { 86,/* lineNo */
  10,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo kb_emlrtRTEI = { 76,/* lineNo */
  38,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo lb_emlrtRTEI = { 78,/* lineNo */
  37,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo mb_emlrtRTEI = { 80,/* lineNo */
  37,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo nb_emlrtRTEI = { 82,/* lineNo */
  38,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo ob_emlrtRTEI = { 84,/* lineNo */
  38,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo pb_emlrtRTEI = { 86,/* lineNo */
  37,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo qb_emlrtRTEI = { 76,/* lineNo */
  50,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo rb_emlrtRTEI = { 78,/* lineNo */
  49,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo sb_emlrtRTEI = { 80,/* lineNo */
  49,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo tb_emlrtRTEI = { 82,/* lineNo */
  50,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo ub_emlrtRTEI = { 84,/* lineNo */
  50,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo vb_emlrtRTEI = { 86,/* lineNo */
  49,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo wb_emlrtRTEI = { 11,/* lineNo */
  5,                                   /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo xb_emlrtRTEI = { 1,/* lineNo */
  14,                                  /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

static emlrtRTEInfo yb_emlrtRTEI = { 33,/* lineNo */
  6,                                   /* colNo */
  "find",                              /* fName */
  "/mnt/NAS/SSD/R2019b/toolbox/eml/lib/matlab/elmat/find.m"/* pName */
};

static emlrtRTEInfo ac_emlrtRTEI = { 70,/* lineNo */
  6,                                   /* colNo */
  "TS_Skeleton3D",                     /* fName */
  "/mnt/NAS/SSD/AutoSegMex/Originals/TS_Skeleton3D.m"/* pName */
};

/* Function Definitions */
void TS_Skeleton3D(const emlrtStack *sp, emxArray_boolean_T *bw,
                   emxArray_boolean_T *A)
{
  int32_T k;
  emxArray_real32_T *DistBW;
  emxArray_boolean_T *b_bw;
  int32_T i;
  emxArray_real32_T *s;
  emxArray_real32_T *b_DistBW;
  emxArray_boolean_T *x;
  emxArray_real32_T *r;
  emxArray_int32_T *stepfind;
  emxArray_int32_T *ii;
  int32_T i1;
  emxArray_int32_T *r1;
  int32_T i2;
  emxArray_boolean_T *distBW;
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
  int32_T b_ii;
  boolean_T exitg1;
  int32_T iv[2];
  real_T NUMdef;
  int8_T i5;
  boolean_T maxval_tmp;
  boolean_T maxval;
  boolean_T b;
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

  /*  edit for mex(c-code) */
  /*  by sugashi, takuma 2019,Nov. 18th */
  /*  coder.extrinsic('bwlabeln') */
  /*  A = false(size(bw)); */
  /*  timeval = tic; */
  k = 3;
  if (bw->size[2] == 1) {
    k = 2;
  }

  emxInit_real32_T(sp, &DistBW, 3, &wb_emlrtRTEI, true);
  emxInit_boolean_T(sp, &b_bw, 3, &i_emlrtRTEI, true);
  if (k == 2) {
    i = b_bw->size[0] * b_bw->size[1] * b_bw->size[2];
    b_bw->size[0] = bw->size[0];
    b_bw->size[1] = bw->size[1];
    b_bw->size[2] = bw->size[2];
    emxEnsureCapacity_boolean_T(sp, b_bw, i, &j_emlrtRTEI);
    k = bw->size[0] * bw->size[1] * bw->size[2] - 1;
    for (i = 0; i <= k; i++) {
      b_bw->data[i] = bw->data[i];
    }

    st.site = &emlrtRSI;
    padarray(&st, b_bw, bw);
    i = b_bw->size[0] * b_bw->size[1] * b_bw->size[2];
    b_bw->size[0] = bw->size[0];
    b_bw->size[1] = bw->size[1];
    b_bw->size[2] = bw->size[2];
    emxEnsureCapacity_boolean_T(sp, b_bw, i, &l_emlrtRTEI);
    k = bw->size[0] * bw->size[1] * bw->size[2];
    for (i = 0; i < k; i++) {
      b_bw->data[i] = !bw->data[i];
    }

    st.site = &b_emlrtRSI;
    bwdist(&st, b_bw, DistBW);
    i = b_bw->size[0] * b_bw->size[1] * b_bw->size[2];
    b_bw->size[0] = bw->size[0];
    b_bw->size[1] = bw->size[1];
    b_bw->size[2] = bw->size[2];
    emxEnsureCapacity_boolean_T(sp, b_bw, i, &n_emlrtRTEI);
    k = bw->size[0] * bw->size[1] * bw->size[2] - 1;
    for (i = 0; i <= k; i++) {
      b_bw->data[i] = bw->data[i];
    }

    emxInit_real32_T(sp, &b_DistBW, 3, &p_emlrtRTEI, true);
    st.site = &c_emlrtRSI;
    b_padarray(&st, b_bw, bw);
    i = b_DistBW->size[0] * b_DistBW->size[1] * b_DistBW->size[2];
    b_DistBW->size[0] = DistBW->size[0];
    b_DistBW->size[1] = DistBW->size[1];
    b_DistBW->size[2] = DistBW->size[2];
    emxEnsureCapacity_real32_T(sp, b_DistBW, i, &p_emlrtRTEI);
    k = DistBW->size[0] * DistBW->size[1] * DistBW->size[2] - 1;
    for (i = 0; i <= k; i++) {
      b_DistBW->data[i] = DistBW->data[i];
    }

    st.site = &d_emlrtRSI;
    c_padarray(&st, b_DistBW, DistBW);
    emxFree_real32_T(&b_DistBW);
  } else {
    i = b_bw->size[0] * b_bw->size[1] * b_bw->size[2];
    b_bw->size[0] = bw->size[0];
    b_bw->size[1] = bw->size[1];
    b_bw->size[2] = bw->size[2];
    emxEnsureCapacity_boolean_T(sp, b_bw, i, &i_emlrtRTEI);
    k = bw->size[0] * bw->size[1] * bw->size[2] - 1;
    for (i = 0; i <= k; i++) {
      b_bw->data[i] = bw->data[i];
    }

    st.site = &e_emlrtRSI;
    d_padarray(&st, b_bw, bw);
    i = b_bw->size[0] * b_bw->size[1] * b_bw->size[2];
    b_bw->size[0] = bw->size[0];
    b_bw->size[1] = bw->size[1];
    b_bw->size[2] = bw->size[2];
    emxEnsureCapacity_boolean_T(sp, b_bw, i, &k_emlrtRTEI);
    k = bw->size[0] * bw->size[1] * bw->size[2];
    for (i = 0; i < k; i++) {
      b_bw->data[i] = !bw->data[i];
    }

    st.site = &f_emlrtRSI;
    bwdist(&st, b_bw, DistBW);
  }

  emxFree_boolean_T(&b_bw);
  emxInit_real32_T(sp, &s, 1, &m_emlrtRTEI, true);
  st.site = &g_emlrtRSI;
  i = s->size[0];
  s->size[0] = DistBW->size[0] * DistBW->size[1] * DistBW->size[2];
  emxEnsureCapacity_real32_T(&st, s, i, &m_emlrtRTEI);
  k = DistBW->size[0] * DistBW->size[1] * DistBW->size[2];
  for (i = 0; i < k; i++) {
    s->data[i] = DistBW->data[i];
  }

  emxInit_boolean_T(&st, &x, 1, &o_emlrtRTEI, true);
  emxInit_real32_T(&st, &r, 1, &o_emlrtRTEI, true);
  b_st.site = &x_emlrtRSI;
  sort(&b_st, s);
  st.site = &h_emlrtRSI;
  b_st.site = &h_emlrtRSI;
  diff(&b_st, s, r);
  i = x->size[0];
  x->size[0] = r->size[0];
  emxEnsureCapacity_boolean_T(&st, x, i, &o_emlrtRTEI);
  k = r->size[0];
  for (i = 0; i < k; i++) {
    x->data[i] = (r->data[i] > 0.0F);
  }

  emxFree_real32_T(&r);
  emxInit_int32_T(&st, &stepfind, 1, &q_emlrtRTEI, true);
  emxInit_int32_T(&st, &ii, 1, &yb_emlrtRTEI, true);
  b_st.site = &bc_emlrtRSI;
  eml_find(&b_st, x, ii);
  i = stepfind->size[0];
  stepfind->size[0] = ii->size[0];
  emxEnsureCapacity_int32_T(&st, stepfind, i, &q_emlrtRTEI);
  k = ii->size[0];
  emxFree_boolean_T(&x);
  for (i = 0; i < k; i++) {
    stepfind->data[i] = ii->data[i];
  }

  if (2 > stepfind->size[0]) {
    i = 0;
    i1 = 0;
  } else {
    if (2 > stepfind->size[0]) {
      emlrtDynamicBoundsCheckR2012b(2, 1, stepfind->size[0], &bb_emlrtBCI, sp);
    }

    i = 1;
    if ((ii->size[0] < 1) || (ii->size[0] > stepfind->size[0])) {
      emlrtDynamicBoundsCheckR2012b(ii->size[0], 1, stepfind->size[0],
        &ab_emlrtBCI, sp);
    }

    i1 = ii->size[0];
  }

  emxInit_int32_T(sp, &r1, 2, &xb_emlrtRTEI, true);
  i2 = r1->size[0] * r1->size[1];
  r1->size[0] = 1;
  k = i1 - i;
  r1->size[1] = k + 1;
  emxEnsureCapacity_int32_T(sp, r1, i2, &r_emlrtRTEI);
  for (i1 = 0; i1 < k; i1++) {
    r1->data[i1] = stepfind->data[i + i1];
  }

  r1->data[k] = s->size[0];
  st.site = &i_emlrtRSI;
  indexShapeCheck(&st, s->size[0], *(int32_T (*)[2])r1->size);
  k = r1->size[0] * r1->size[1];
  for (i = 0; i < k; i++) {
    i1 = r1->data[i];
    if ((i1 < 1) || (i1 > s->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, s->size[0], &s_emlrtBCI, sp);
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
  emxEnsureCapacity_int32_T(sp, ii, i, &s_emlrtRTEI);
  k = r1->size[1];
  for (i = 0; i < k; i++) {
    ii->data[i] = r1->data[i];
  }

  i = ii->size[0];
  emxInit_boolean_T(sp, &distBW, 3, &t_emlrtRTEI, true);
  emxInit_real_T(sp, &newY, 1, &xb_emlrtRTEI, true);
  emxInit_real_T(sp, &newX, 1, &xb_emlrtRTEI, true);
  emxInit_real_T(sp, &newZ, 1, &xb_emlrtRTEI, true);
  emxInit_int32_T(sp, &varargout_6, 1, &ac_emlrtRTEI, true);
  emxInit_int32_T(sp, &vk, 1, &x_emlrtRTEI, true);
  for (n = 0; n < i; n++) {
    i1 = distBW->size[0] * distBW->size[1] * distBW->size[2];
    distBW->size[0] = DistBW->size[0];
    distBW->size[1] = DistBW->size[1];
    distBW->size[2] = DistBW->size[2];
    emxEnsureCapacity_boolean_T(sp, distBW, i1, &t_emlrtRTEI);
    k = r1->size[1];
    i1 = ii->size[0];
    ii->size[0] = r1->size[1];
    emxEnsureCapacity_int32_T(sp, ii, i1, &s_emlrtRTEI);
    for (i1 = 0; i1 < k; i1++) {
      ii->data[i1] = r1->data[i1];
    }

    i1 = n + 1;
    if ((i1 < 1) || (i1 > ii->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, ii->size[0], &r_emlrtBCI, sp);
    }

    b_s = s->data[r1->data[i1 - 1] - 1];
    k = DistBW->size[0] * DistBW->size[1] * DistBW->size[2];
    for (i1 = 0; i1 < k; i1++) {
      distBW->data[i1] = (DistBW->data[i1] == b_s);
    }

    st.site = &j_emlrtRSI;
    b_st.site = &gc_emlrtRSI;
    c_st.site = &bc_emlrtRSI;
    nx = distBW->size[0] * distBW->size[1] * distBW->size[2];
    d_st.site = &cc_emlrtRSI;
    idx = 0;
    i1 = ii->size[0];
    ii->size[0] = distBW->size[0] * distBW->size[1] * distBW->size[2];
    emxEnsureCapacity_int32_T(&d_st, ii, i1, &v_emlrtRTEI);
    e_st.site = &dc_emlrtRSI;
    if ((1 <= distBW->size[0] * distBW->size[1] * distBW->size[2]) &&
        (distBW->size[0] * distBW->size[1] * distBW->size[2] > 2147483646)) {
      f_st.site = &s_emlrtRSI;
      check_forloop_overflow_error(&f_st);
    }

    b_ii = 0;
    exitg1 = false;
    while ((!exitg1) && (b_ii <= nx - 1)) {
      if (distBW->data[b_ii]) {
        idx++;
        ii->data[idx - 1] = b_ii + 1;
        if (idx >= nx) {
          exitg1 = true;
        } else {
          b_ii++;
        }
      } else {
        b_ii++;
      }
    }

    if (idx > distBW->size[0] * distBW->size[1] * distBW->size[2]) {
      emlrtErrorWithMessageIdR2018a(&d_st, &b_emlrtRTEI,
        "Coder:builtins:AssertionFailed", "Coder:builtins:AssertionFailed", 0);
    }

    if (distBW->size[0] * distBW->size[1] * distBW->size[2] == 1) {
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
      e_st.site = &ec_emlrtRSI;
      indexShapeCheck(&e_st, ii->size[0], iv);
      i2 = ii->size[0];
      ii->size[0] = i1;
      emxEnsureCapacity_int32_T(&d_st, ii, i2, &w_emlrtRTEI);
    }

    b_st.site = &gc_emlrtRSI;
    c_st.site = &nc_emlrtRSI;
    nx = distBW->size[0];
    idx = distBW->size[1] * nx;
    b_ii = idx * distBW->size[2];
    k = 0;
    exitg1 = false;
    while ((!exitg1) && (k <= ii->size[0] - 1)) {
      if (ii->data[k] <= b_ii) {
        k++;
      } else {
        emlrtErrorWithMessageIdR2018a(&c_st, &emlrtRTEI,
          "Coder:MATLAB:ind2sub_IndexOutOfRange",
          "Coder:MATLAB:ind2sub_IndexOutOfRange", 0);
      }
    }

    k = ii->size[0];
    for (i1 = 0; i1 < k; i1++) {
      ii->data[i1]--;
    }

    i1 = vk->size[0];
    vk->size[0] = ii->size[0];
    emxEnsureCapacity_int32_T(&c_st, vk, i1, &x_emlrtRTEI);
    k = ii->size[0];
    for (i1 = 0; i1 < k; i1++) {
      d_st.site = &hd_emlrtRSI;
      vk->data[i1] = div_s32(&d_st, ii->data[i1], idx);
    }

    k = vk->size[0];
    i1 = varargout_6->size[0];
    varargout_6->size[0] = vk->size[0];
    emxEnsureCapacity_int32_T(&c_st, varargout_6, i1, &y_emlrtRTEI);
    for (i1 = 0; i1 < k; i1++) {
      varargout_6->data[i1] = vk->data[i1] + 1;
    }

    k = ii->size[0];
    for (i1 = 0; i1 < k; i1++) {
      ii->data[i1] -= vk->data[i1] * idx;
    }

    i1 = vk->size[0];
    vk->size[0] = ii->size[0];
    emxEnsureCapacity_int32_T(&c_st, vk, i1, &x_emlrtRTEI);
    k = ii->size[0];
    for (i1 = 0; i1 < k; i1++) {
      d_st.site = &hd_emlrtRSI;
      vk->data[i1] = div_s32(&d_st, ii->data[i1], nx);
    }

    k = ii->size[0];
    for (i1 = 0; i1 < k; i1++) {
      ii->data[i1] -= vk->data[i1] * nx;
    }

    i1 = stepfind->size[0];
    stepfind->size[0] = ii->size[0];
    emxEnsureCapacity_int32_T(&b_st, stepfind, i1, &ab_emlrtRTEI);
    k = ii->size[0];
    for (i1 = 0; i1 < k; i1++) {
      stepfind->data[i1] = ii->data[i1] + 1;
    }

    k = vk->size[0];
    for (i1 = 0; i1 < k; i1++) {
      vk->data[i1]++;
    }

    i1 = newY->size[0];
    newY->size[0] = stepfind->size[0];
    emxEnsureCapacity_real_T(&st, newY, i1, &bb_emlrtRTEI);
    k = stepfind->size[0];
    for (i1 = 0; i1 < k; i1++) {
      newY->data[i1] = 0.0;
    }

    i1 = newX->size[0];
    newX->size[0] = stepfind->size[0];
    emxEnsureCapacity_real_T(&st, newX, i1, &cb_emlrtRTEI);
    k = stepfind->size[0];
    for (i1 = 0; i1 < k; i1++) {
      newX->data[i1] = 0.0;
    }

    i1 = newZ->size[0];
    newZ->size[0] = stepfind->size[0];
    emxEnsureCapacity_real_T(&st, newZ, i1, &db_emlrtRTEI);
    k = stepfind->size[0];
    for (i1 = 0; i1 < k; i1++) {
      newZ->data[i1] = 0.0;
    }

    NUMdef = (((real_T)n + 1.0) - 1.0) / 6.0;
    i1 = (int32_T)muDoubleScalarRound((NUMdef - muDoubleScalarFloor(NUMdef)) *
      6.0);
    if (i1 < 128) {
      if (i1 >= -128) {
        i5 = (int8_T)i1;
      } else {
        i5 = MIN_int8_T;
      }
    } else {
      i5 = MAX_int8_T;
    }

    switch (i5) {
     case 0:
      b_st.site = &hc_emlrtRSI;
      k = varargout_6->size[0];
      i1 = newZ->size[0];
      newZ->size[0] = varargout_6->size[0];
      emxEnsureCapacity_real_T(&b_st, newZ, i1, &eb_emlrtRTEI);
      for (i1 = 0; i1 < k; i1++) {
        newZ->data[i1] = varargout_6->data[i1];
      }

      c_st.site = &oc_emlrtRSI;
      b_sort(&c_st, newZ, ii);
      i1 = newY->size[0];
      newY->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newY, i1, &kb_emlrtRTEI);
      k = ii->size[0];
      for (i1 = 0; i1 < k; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > stepfind->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, stepfind->size[0],
            &q_emlrtBCI, &st);
        }

        newY->data[i1] = stepfind->data[ii->data[i1] - 1];
      }

      i1 = newX->size[0];
      newX->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newX, i1, &qb_emlrtRTEI);
      k = ii->size[0];
      for (i1 = 0; i1 < k; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > vk->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, vk->size[0],
            &k_emlrtBCI, &st);
        }

        newX->data[i1] = vk->data[ii->data[i1] - 1];
      }
      break;

     case 1:
      b_st.site = &ic_emlrtRSI;
      k = varargout_6->size[0];
      i1 = newZ->size[0];
      newZ->size[0] = varargout_6->size[0];
      emxEnsureCapacity_real_T(&b_st, newZ, i1, &fb_emlrtRTEI);
      for (i1 = 0; i1 < k; i1++) {
        newZ->data[i1] = varargout_6->data[i1];
      }

      c_st.site = &oc_emlrtRSI;
      c_sort(&c_st, newZ, ii);
      i1 = newY->size[0];
      newY->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newY, i1, &lb_emlrtRTEI);
      k = ii->size[0];
      for (i1 = 0; i1 < k; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > stepfind->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, stepfind->size[0],
            &p_emlrtBCI, &st);
        }

        newY->data[i1] = stepfind->data[ii->data[i1] - 1];
      }

      i1 = newX->size[0];
      newX->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newX, i1, &rb_emlrtRTEI);
      k = ii->size[0];
      for (i1 = 0; i1 < k; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > vk->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, vk->size[0],
            &j_emlrtBCI, &st);
        }

        newX->data[i1] = vk->data[ii->data[i1] - 1];
      }
      break;

     case 2:
      b_st.site = &jc_emlrtRSI;
      k = vk->size[0];
      i1 = newX->size[0];
      newX->size[0] = vk->size[0];
      emxEnsureCapacity_real_T(&b_st, newX, i1, &gb_emlrtRTEI);
      for (i1 = 0; i1 < k; i1++) {
        newX->data[i1] = vk->data[i1];
      }

      c_st.site = &oc_emlrtRSI;
      c_sort(&c_st, newX, ii);
      i1 = newY->size[0];
      newY->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newY, i1, &mb_emlrtRTEI);
      k = ii->size[0];
      for (i1 = 0; i1 < k; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > stepfind->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, stepfind->size[0],
            &o_emlrtBCI, &st);
        }

        newY->data[i1] = stepfind->data[ii->data[i1] - 1];
      }

      i1 = newZ->size[0];
      newZ->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newZ, i1, &sb_emlrtRTEI);
      k = ii->size[0];
      for (i1 = 0; i1 < k; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > varargout_6->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, varargout_6->size[0],
            &i_emlrtBCI, &st);
        }

        newZ->data[i1] = varargout_6->data[ii->data[i1] - 1];
      }
      break;

     case 3:
      b_st.site = &kc_emlrtRSI;
      k = vk->size[0];
      i1 = newX->size[0];
      newX->size[0] = vk->size[0];
      emxEnsureCapacity_real_T(&b_st, newX, i1, &hb_emlrtRTEI);
      for (i1 = 0; i1 < k; i1++) {
        newX->data[i1] = vk->data[i1];
      }

      c_st.site = &oc_emlrtRSI;
      b_sort(&c_st, newX, ii);
      i1 = newY->size[0];
      newY->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newY, i1, &nb_emlrtRTEI);
      k = ii->size[0];
      for (i1 = 0; i1 < k; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > stepfind->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, stepfind->size[0],
            &n_emlrtBCI, &st);
        }

        newY->data[i1] = stepfind->data[ii->data[i1] - 1];
      }

      i1 = newZ->size[0];
      newZ->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newZ, i1, &tb_emlrtRTEI);
      k = ii->size[0];
      for (i1 = 0; i1 < k; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > varargout_6->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, varargout_6->size[0],
            &h_emlrtBCI, &st);
        }

        newZ->data[i1] = varargout_6->data[ii->data[i1] - 1];
      }
      break;

     case 4:
      b_st.site = &lc_emlrtRSI;
      k = stepfind->size[0];
      i1 = newY->size[0];
      newY->size[0] = stepfind->size[0];
      emxEnsureCapacity_real_T(&b_st, newY, i1, &ib_emlrtRTEI);
      for (i1 = 0; i1 < k; i1++) {
        newY->data[i1] = stepfind->data[i1];
      }

      c_st.site = &oc_emlrtRSI;
      b_sort(&c_st, newY, ii);
      i1 = newX->size[0];
      newX->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newX, i1, &ob_emlrtRTEI);
      k = ii->size[0];
      for (i1 = 0; i1 < k; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > vk->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, vk->size[0],
            &m_emlrtBCI, &st);
        }

        newX->data[i1] = vk->data[ii->data[i1] - 1];
      }

      i1 = newZ->size[0];
      newZ->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newZ, i1, &ub_emlrtRTEI);
      k = ii->size[0];
      for (i1 = 0; i1 < k; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > varargout_6->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, varargout_6->size[0],
            &g_emlrtBCI, &st);
        }

        newZ->data[i1] = varargout_6->data[ii->data[i1] - 1];
      }
      break;

     case 5:
      b_st.site = &mc_emlrtRSI;
      k = stepfind->size[0];
      i1 = newY->size[0];
      newY->size[0] = stepfind->size[0];
      emxEnsureCapacity_real_T(&b_st, newY, i1, &jb_emlrtRTEI);
      for (i1 = 0; i1 < k; i1++) {
        newY->data[i1] = stepfind->data[i1];
      }

      c_st.site = &oc_emlrtRSI;
      c_sort(&c_st, newY, ii);
      i1 = newX->size[0];
      newX->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newX, i1, &pb_emlrtRTEI);
      k = ii->size[0];
      for (i1 = 0; i1 < k; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > vk->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, vk->size[0],
            &l_emlrtBCI, &st);
        }

        newX->data[i1] = vk->data[ii->data[i1] - 1];
      }

      i1 = newZ->size[0];
      newZ->size[0] = ii->size[0];
      emxEnsureCapacity_real_T(&st, newZ, i1, &vb_emlrtRTEI);
      k = ii->size[0];
      for (i1 = 0; i1 < k; i1++) {
        if ((ii->data[i1] < 1) || (ii->data[i1] > varargout_6->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, varargout_6->size[0],
            &f_emlrtBCI, &st);
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
        emlrtDynamicBoundsCheckR2012b(i2, 1, newY->size[0], &y_emlrtBCI, sp);
      }

      i2 = k + 1;
      if ((i2 < 1) || (i2 > newX->size[0])) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, newX->size[0], &x_emlrtBCI, sp);
      }

      i2 = k + 1;
      if ((i2 < 1) || (i2 > newZ->size[0])) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, newZ->size[0], &w_emlrtBCI, sp);
      }

      for (i2 = 0; i2 < 5; i2++) {
        i3 = (int32_T)(newZ->data[k] + ((real_T)i2 + -2.0));
        for (idx = 0; idx < 5; idx++) {
          i4 = (int32_T)(newX->data[k] + ((real_T)idx + -2.0));
          for (b_ii = 0; b_ii < 5; b_ii++) {
            if ((i3 < 1) || (i3 > bw->size[2])) {
              emlrtDynamicBoundsCheckR2012b(i3, 1, bw->size[2], &c_emlrtBCI, sp);
            }

            if ((i4 < 1) || (i4 > bw->size[1])) {
              emlrtDynamicBoundsCheckR2012b(i4, 1, bw->size[1], &d_emlrtBCI, sp);
            }

            nx = (int32_T)(newY->data[k] + ((real_T)b_ii + -2.0));
            if ((nx < 1) || (nx > bw->size[0])) {
              emlrtDynamicBoundsCheckR2012b(nx, 1, bw->size[0], &e_emlrtBCI, sp);
            }

            ROI[(b_ii + 5 * idx) + 25 * i2] = bw->data[((nx + bw->size[0] * (i4
              - 1)) + bw->size[0] * bw->size[1] * (i3 - 1)) - 1];
          }
        }
      }

      /*              s = bwconncomp(ROI,26);             */
      /*              NUMdef = s.NumObjects; */
      st.site = &k_emlrtRSI;
      maxval_tmp = bw->data[(((int32_T)(newY->data[k] + -2.0) + bw->size[0] *
        ((int32_T)(newX->data[k] + -2.0) - 1)) + bw->size[0] * bw->size[1] *
        ((int32_T)(newZ->data[k] + -2.0) - 1)) - 1];
      maxval = maxval_tmp;
      for (b_ii = 0; b_ii < 124; b_ii++) {
        b = bw->data[(((int32_T)(newY->data[k] + ((real_T)((b_ii + 1) % 5) +
          -2.0)) + bw->size[0] * ((int32_T)(newX->data[k] + ((real_T)((b_ii + 1)
          / 5 % 5) + -2.0)) - 1)) + bw->size[0] * bw->size[1] * ((int32_T)
          (newZ->data[k] + ((real_T)((b_ii + 1) / 25) + -2.0)) - 1)) - 1];
        maxval = (((int32_T)maxval < (int32_T)b) || maxval);
      }

      if (!maxval) {
        NUMdef = 0.0;
      } else {
        b_st.site = &pc_emlrtRSI;
        TS_bwlabeln_linux_c(&b_st, ROI, unusedU0, &NUMdef);
      }

      /*              mxDestroyArray(NUMdef) */
      ROI[62] = false;

      /*              s = bwconncomp(ROI,26); */
      /*              NUM = s.NumObjects; */
      st.site = &l_emlrtRSI;
      for (b_ii = 0; b_ii < 124; b_ii++) {
        maxval_tmp = (((int32_T)maxval_tmp < (int32_T)ROI[b_ii + 1]) ||
                      maxval_tmp);
      }

      if (!maxval_tmp) {
        NUM = 0.0;
      } else {
        b_st.site = &pc_emlrtRSI;
        TS_bwlabeln_linux_c(&b_st, ROI, unusedU0, &NUM);
      }

      /*              mxDestroyArray(NUM) */
      /*  Object Number is Equal or Not */
      for (i2 = 0; i2 < 3; i2++) {
        for (i3 = 0; i3 < 3; i3++) {
          b_ii = 5 * (i3 + 1) + 25 * (i2 + 1);
          nx = 3 * i3 + 9 * i2;
          b_ROI[nx] = ROI[b_ii + 1];
          b_ROI[nx + 1] = ROI[b_ii + 2];
          b_ROI[nx + 2] = ROI[b_ii + 3];
        }
      }

      for (i2 = 0; i2 < 27; i2++) {
        b_x[i2] = b_ROI[i2];
      }

      nx = ROI[31];
      for (b_ii = 0; b_ii < 26; b_ii++) {
        nx += b_x[b_ii + 1];
      }

      /*  End point or Not */
      /*                  TF3 =  */
      if ((NUM == NUMdef) && (nx != 1)) {
        i2 = (int32_T)newZ->data[k];
        if ((i2 < 1) || (i2 > bw->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, bw->size[2], &b_emlrtBCI, sp);
        }

        i3 = (int32_T)newX->data[k];
        if ((i3 < 1) || (i3 > bw->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, bw->size[1], &b_emlrtBCI, sp);
        }

        idx = (int32_T)newY->data[k];
        if ((idx < 1) || (idx > bw->size[0])) {
          emlrtDynamicBoundsCheckR2012b(idx, 1, bw->size[0], &b_emlrtBCI, sp);
        }

        bw->data[((idx + bw->size[0] * (i3 - 1)) + bw->size[0] * bw->size[1] *
                  (i2 - 1)) - 1] = false;
      }

      i2 = (int32_T)newZ->data[k];
      if ((i2 < 1) || (i2 > distBW->size[2])) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, distBW->size[2], &emlrtBCI, sp);
      }

      i3 = (int32_T)newX->data[k];
      if ((i3 < 1) || (i3 > distBW->size[1])) {
        emlrtDynamicBoundsCheckR2012b(i3, 1, distBW->size[1], &emlrtBCI, sp);
      }

      idx = (int32_T)newY->data[k];
      if ((idx < 1) || (idx > distBW->size[0])) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, distBW->size[0], &emlrtBCI, sp);
      }

      distBW->data[((idx + distBW->size[0] * (i3 - 1)) + distBW->size[0] *
                    distBW->size[1] * (i2 - 1)) - 1] = false;

      /*          waitbar(count/NUMbw,waitbarh,['Please wait...  ' num2str(count) '/' num2str(NUMbw)])  */
      /*          count = count + 1; */
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(sp);
      }
    }

    /*      disp(num2str(n)) */
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_int32_T(&vk);
  emxFree_int32_T(&varargout_6);
  emxFree_int32_T(&ii);
  emxFree_int32_T(&r1);
  emxFree_real_T(&newZ);
  emxFree_real_T(&newX);
  emxFree_real_T(&newY);
  emxFree_boolean_T(&distBW);
  emxFree_int32_T(&stepfind);
  emxFree_real32_T(&s);
  emxFree_real32_T(&DistBW);

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
      emlrtDynamicBoundsCheckR2012b(i1, 1, bw->size[0], &v_emlrtBCI, sp);
    }
  }

  if (3 > bw->size[1] - 2) {
    i2 = 0;
    i3 = 0;
  } else {
    i2 = 2;
    i3 = bw->size[1] - 2;
    if ((i3 < 1) || (i3 > bw->size[1])) {
      emlrtDynamicBoundsCheckR2012b(i3, 1, bw->size[1], &u_emlrtBCI, sp);
    }
  }

  if (3 > bw->size[2] - 2) {
    idx = 0;
    i4 = 0;
  } else {
    idx = 2;
    i4 = bw->size[2] - 2;
    if ((i4 < 1) || (i4 > bw->size[2])) {
      emlrtDynamicBoundsCheckR2012b(i4, 1, bw->size[2], &t_emlrtBCI, sp);
    }
  }

  k = i1 - i;
  i1 = A->size[0] * A->size[1] * A->size[2];
  A->size[0] = k;
  b_ii = i3 - i2;
  A->size[1] = b_ii;
  nx = i4 - idx;
  A->size[2] = nx;
  emxEnsureCapacity_boolean_T(sp, A, i1, &u_emlrtRTEI);
  for (i1 = 0; i1 < nx; i1++) {
    for (i3 = 0; i3 < b_ii; i3++) {
      for (i4 = 0; i4 < k; i4++) {
        A->data[(i4 + A->size[0] * i3) + A->size[0] * A->size[1] * i1] =
          bw->data[((i + i4) + bw->size[0] * (i2 + i3)) + bw->size[0] * bw->
          size[1] * (idx + i1)];
      }
    }
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (TS_Skeleton3D.c) */

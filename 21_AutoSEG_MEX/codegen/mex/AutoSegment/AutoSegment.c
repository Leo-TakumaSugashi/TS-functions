/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * AutoSegment.c
 *
 * Code generation for function 'AutoSegment'
 *
 */

/* Include files */
#include "AutoSegment.h"
#include "AtSEG_shaving.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "AutoSegment_mexutil.h"
#include "TS_bwlabeln3D26.h"
#include "TS_skel2endpoint.h"
#include "TS_skelmorph3d.h"
#include "bwdist.h"
#include "cat.h"
#include "combineVectorElements.h"
#include "diff.h"
#include "eml_int_forloop_overflow_check.h"
#include "find.h"
#include "ind2sub.h"
#include "mwmathutil.h"
#include "nansum.h"
#include "nullAssignment.h"
#include "padarray.h"
#include "power.h"
#include "repmat.h"
#include "rt_nonfinite.h"
#include "sqrt.h"
#include "sum.h"
#include "tic.h"
#include "xyz2plen.h"
#include <string.h>

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 29,    /* lineNo */
  "AutoSegment",                       /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo b_emlrtRSI = { 38,  /* lineNo */
  "AutoSegment",                       /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo c_emlrtRSI = { 39,  /* lineNo */
  "AutoSegment",                       /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo d_emlrtRSI = { 41,  /* lineNo */
  "AutoSegment",                       /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo e_emlrtRSI = { 44,  /* lineNo */
  "AutoSegment",                       /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo f_emlrtRSI = { 45,  /* lineNo */
  "AutoSegment",                       /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo g_emlrtRSI = { 52,  /* lineNo */
  "AutoSegment",                       /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo j_emlrtRSI = { 861, /* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo k_emlrtRSI = { 826, /* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo l_emlrtRSI = { 825, /* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo m_emlrtRSI = { 824, /* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo n_emlrtRSI = { 823, /* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo o_emlrtRSI = { 822, /* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo p_emlrtRSI = { 802, /* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo q_emlrtRSI = { 801, /* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo r_emlrtRSI = { 790, /* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo s_emlrtRSI = { 788, /* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo t_emlrtRSI = { 787, /* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo u_emlrtRSI = { 779, /* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo v_emlrtRSI = { 778, /* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo w_emlrtRSI = { 777, /* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo x_emlrtRSI = { 776, /* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo y_emlrtRSI = { 775, /* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ab_emlrtRSI = { 763,/* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo bb_emlrtRSI = { 762,/* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo cb_emlrtRSI = { 761,/* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo db_emlrtRSI = { 760,/* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo eb_emlrtRSI = { 759,/* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo fb_emlrtRSI = { 734,/* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo gb_emlrtRSI = { 726,/* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo hb_emlrtRSI = { 721,/* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ib_emlrtRSI = { 720,/* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo jb_emlrtRSI = { 718,/* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo kb_emlrtRSI = { 717,/* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo lb_emlrtRSI = { 716,/* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo mb_emlrtRSI = { 714,/* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo nb_emlrtRSI = { 702,/* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ob_emlrtRSI = { 700,/* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo pb_emlrtRSI = { 691,/* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo qb_emlrtRSI = { 676,/* lineNo */
  "AutoSegment_Pre",                   /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo jg_emlrtRSI = { 15, /* lineNo */
  "sum",                               /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/sum.m"/* pathName */
};

static emlrtRSInfo lg_emlrtRSI = { 16, /* lineNo */
  "max",                               /* fcnName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/datafun/max.m"/* pathName */
};

static emlrtRSInfo li_emlrtRSI = { 619,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo mi_emlrtRSI = { 616,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ni_emlrtRSI = { 615,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo oi_emlrtRSI = { 612,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo pi_emlrtRSI = { 611,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo qi_emlrtRSI = { 610,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ri_emlrtRSI = { 607,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo si_emlrtRSI = { 606,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ti_emlrtRSI = { 604,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ui_emlrtRSI = { 603,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo vi_emlrtRSI = { 602,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo wi_emlrtRSI = { 601,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo xi_emlrtRSI = { 599,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo yi_emlrtRSI = { 596,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo aj_emlrtRSI = { 569,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo bj_emlrtRSI = { 538,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo cj_emlrtRSI = { 537,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo dj_emlrtRSI = { 536,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ej_emlrtRSI = { 535,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo fj_emlrtRSI = { 534,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo gj_emlrtRSI = { 532,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo hj_emlrtRSI = { 515,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ij_emlrtRSI = { 514,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo jj_emlrtRSI = { 511,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo kj_emlrtRSI = { 510,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo lj_emlrtRSI = { 509,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo mj_emlrtRSI = { 501,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo nj_emlrtRSI = { 496,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo oj_emlrtRSI = { 495,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo pj_emlrtRSI = { 482,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo qj_emlrtRSI = { 481,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo rj_emlrtRSI = { 480,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo sj_emlrtRSI = { 479,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo tj_emlrtRSI = { 478,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo uj_emlrtRSI = { 467,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo vj_emlrtRSI = { 466,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo wj_emlrtRSI = { 465,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo xj_emlrtRSI = { 464,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo yj_emlrtRSI = { 463,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ak_emlrtRSI = { 437,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo bk_emlrtRSI = { 436,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ck_emlrtRSI = { 435,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo dk_emlrtRSI = { 433,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ek_emlrtRSI = { 432,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo fk_emlrtRSI = { 408,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo gk_emlrtRSI = { 407,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo hk_emlrtRSI = { 406,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ik_emlrtRSI = { 405,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo jk_emlrtRSI = { 404,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo kk_emlrtRSI = { 391,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo lk_emlrtRSI = { 390,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo mk_emlrtRSI = { 389,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo nk_emlrtRSI = { 388,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ok_emlrtRSI = { 387,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo pk_emlrtRSI = { 362,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo qk_emlrtRSI = { 361,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo rk_emlrtRSI = { 359,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo sk_emlrtRSI = { 358,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo tk_emlrtRSI = { 357,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo uk_emlrtRSI = { 349,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo vk_emlrtRSI = { 346,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo wk_emlrtRSI = { 345,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo xk_emlrtRSI = { 328,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo yk_emlrtRSI = { 327,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo al_emlrtRSI = { 326,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo bl_emlrtRSI = { 325,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo cl_emlrtRSI = { 324,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo dl_emlrtRSI = { 288,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo el_emlrtRSI = { 285,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo fl_emlrtRSI = { 274,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo gl_emlrtRSI = { 243,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo hl_emlrtRSI = { 242,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo il_emlrtRSI = { 241,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo jl_emlrtRSI = { 240,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo kl_emlrtRSI = { 239,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ll_emlrtRSI = { 219,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ml_emlrtRSI = { 218,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo nl_emlrtRSI = { 216,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ol_emlrtRSI = { 215,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo pl_emlrtRSI = { 214,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ql_emlrtRSI = { 206,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo rl_emlrtRSI = { 203,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo sl_emlrtRSI = { 202,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo tl_emlrtRSI = { 193,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ul_emlrtRSI = { 192,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo vl_emlrtRSI = { 191,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo wl_emlrtRSI = { 190,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo xl_emlrtRSI = { 189,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo yl_emlrtRSI = { 177,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo am_emlrtRSI = { 176,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo bm_emlrtRSI = { 175,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo cm_emlrtRSI = { 174,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo dm_emlrtRSI = { 173,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo em_emlrtRSI = { 147,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo fm_emlrtRSI = { 146,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo gm_emlrtRSI = { 142,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo hm_emlrtRSI = { 137,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo im_emlrtRSI = { 135,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo jm_emlrtRSI = { 133,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo km_emlrtRSI = { 132,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo lm_emlrtRSI = { 131,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo mm_emlrtRSI = { 129,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo nm_emlrtRSI = { 118,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo om_emlrtRSI = { 116,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo pm_emlrtRSI = { 109,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo qm_emlrtRSI = { 95, /* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo wm_emlrtRSI = { 64, /* lineNo */
  "sort_xyz",                          /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo xm_emlrtRSI = { 65, /* lineNo */
  "sort_xyz",                          /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo ym_emlrtRSI = { 66, /* lineNo */
  "sort_xyz",                          /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo an_emlrtRSI = { 71, /* lineNo */
  "sort_xyz",                          /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo bn_emlrtRSI = { 74, /* lineNo */
  "sort_xyz",                          /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo cn_emlrtRSI = { 75, /* lineNo */
  "sort_xyz",                          /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo dn_emlrtRSI = { 79, /* lineNo */
  "sort_xyz",                          /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo en_emlrtRSI = { 890,/* lineNo */
  "GetEachLength",                     /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo fn_emlrtRSI = { 891,/* lineNo */
  "GetEachLength",                     /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo gn_emlrtRSI = { 892,/* lineNo */
  "GetEachLength",                     /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtMCInfo b_emlrtMCI = { 108, /* lineNo */
  1,                                   /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtMCInfo c_emlrtMCI = { 115, /* lineNo */
  1,                                   /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtMCInfo d_emlrtMCI = { 145, /* lineNo */
  1,                                   /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtMCInfo e_emlrtMCI = { 284, /* lineNo */
  1,                                   /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo emlrtECI = { 3,     /* nDims */
  675,                                 /* lineNo */
  9,                                   /* colNo */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo b_emlrtECI = { 3,   /* nDims */
  695,                                 /* lineNo */
  12,                                  /* colNo */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo c_emlrtECI = { 2,   /* nDims */
  762,                                 /* lineNo */
  24,                                  /* colNo */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo d_emlrtECI = { 2,   /* nDims */
  778,                                 /* lineNo */
  24,                                  /* colNo */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo e_emlrtECI = { 3,   /* nDims */
  786,                                 /* lineNo */
  29,                                  /* colNo */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo f_emlrtECI = { 2,   /* nDims */
  801,                                 /* lineNo */
  24,                                  /* colNo */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo g_emlrtECI = { 2,   /* nDims */
  825,                                 /* lineNo */
  24,                                  /* colNo */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtBCInfo emlrtBCI = { 1,     /* iFirst */
  2048,                                /* iLast */
  767,                                 /* lineNo */
  18,                                  /* colNo */
  "SegP",                              /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo b_emlrtBCI = { 1,   /* iFirst */
  2048,                                /* iLast */
  783,                                 /* lineNo */
  18,                                  /* colNo */
  "SegP",                              /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = { 1,   /* iFirst */
  2048,                                /* iLast */
  808,                                 /* lineNo */
  18,                                  /* colNo */
  "SegP",                              /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo d_emlrtBCI = { 1,   /* iFirst */
  2048,                                /* iLast */
  832,                                 /* lineNo */
  18,                                  /* colNo */
  "SegP",                              /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo e_emlrtBCI = { 1,   /* iFirst */
  2048,                                /* iLast */
  853,                                 /* lineNo */
  54,                                  /* colNo */
  "SegP",                              /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo h_emlrtECI = { -1,  /* nDims */
  853,                                 /* lineNo */
  5,                                   /* colNo */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtBCInfo f_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  692,                                 /* lineNo */
  1,                                   /* colNo */
  "BPcentroid",                        /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo g_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  693,                                 /* lineNo */
  1,                                   /* colNo */
  "EndP",                              /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo h_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  721,                                 /* lineNo */
  40,                                  /* colNo */
  "DistInd",                           /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo i_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  721,                                 /* lineNo */
  32,                                  /* colNo */
  "L_BPgroup",                         /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo j_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  721,                                 /* lineNo */
  1,                                   /* colNo */
  "L_BPgroup",                         /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo k_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  723,                                 /* lineNo */
  1,                                   /* colNo */
  "bwthindata",                        /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo l_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  724,                                 /* lineNo */
  1,                                   /* colNo */
  "bwthindata",                        /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo m_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  737,                                 /* lineNo */
  9,                                   /* colNo */
  "ey",                                /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo n_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  738,                                 /* lineNo */
  9,                                   /* colNo */
  "ex",                                /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo o_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  739,                                 /* lineNo */
  9,                                   /* colNo */
  "ez",                                /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo p_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  742,                                 /* lineNo */
  12,                                  /* colNo */
  "bwthindata",                        /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo q_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  749,                                 /* lineNo */
  5,                                   /* colNo */
  "bwthindata",                        /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo r_emlrtBCI = { 1,   /* iFirst */
  32768,                               /* iLast */
  853,                                 /* lineNo */
  5,                                   /* colNo */
  "Pdata",                             /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo s_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  755,                                 /* lineNo */
  9,                                   /* colNo */
  "bwthindata",                        /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo t_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  765,                                 /* lineNo */
  17,                                  /* colNo */
  "BPC",                               /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo u_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  765,                                 /* lineNo */
  33,                                  /* colNo */
  "BPC",                               /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo v_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  765,                                 /* lineNo */
  49,                                  /* colNo */
  "BPC",                               /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo w_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  781,                                 /* lineNo */
  17,                                  /* colNo */
  "BPG",                               /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo x_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  781,                                 /* lineNo */
  33,                                  /* colNo */
  "BPG",                               /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo y_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  781,                                 /* lineNo */
  49,                                  /* colNo */
  "BPG",                               /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ab_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  828,                                 /* lineNo */
  17,                                  /* colNo */
  "C",                                 /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo bb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  829,                                 /* lineNo */
  17,                                  /* colNo */
  "C",                                 /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo cb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  785,                                 /* lineNo */
  20,                                  /* colNo */
  "L_BPgroup",                         /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo db_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  830,                                 /* lineNo */
  17,                                  /* colNo */
  "C",                                 /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo eb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  833,                                 /* lineNo */
  13,                                  /* colNo */
  "bwthindata",                        /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo fb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  834,                                 /* lineNo */
  16,                                  /* colNo */
  "EndP",                              /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo gb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  804,                                 /* lineNo */
  17,                                  /* colNo */
  "Fyxz",                              /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo hb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  805,                                 /* lineNo */
  17,                                  /* colNo */
  "Fyxz",                              /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ib_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  806,                                 /* lineNo */
  17,                                  /* colNo */
  "Fyxz",                              /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo jb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  753,                                 /* lineNo */
  37,                                  /* colNo */
  "BPcentroid",                        /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo kb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  753,                                 /* lineNo */
  45,                                  /* colNo */
  "BPcentroid",                        /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo lb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  753,                                 /* lineNo */
  53,                                  /* colNo */
  "BPcentroid",                        /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo mb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  754,                                 /* lineNo */
  31,                                  /* colNo */
  "BPgroup",                           /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo nb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  754,                                 /* lineNo */
  39,                                  /* colNo */
  "BPgroup",                           /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ob_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  754,                                 /* lineNo */
  47,                                  /* colNo */
  "BPgroup",                           /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo pb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  756,                                 /* lineNo */
  26,                                  /* colNo */
  "bwthindata",                        /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo qb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  756,                                 /* lineNo */
  34,                                  /* colNo */
  "bwthindata",                        /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo rb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  756,                                 /* lineNo */
  42,                                  /* colNo */
  "bwthindata",                        /* aName */
  "AutoSegment_Pre",                   /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo q_emlrtECI = { 3,   /* nDims */
  93,                                  /* lineNo */
  12,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo r_emlrtECI = { 3,   /* nDims */
  113,                                 /* lineNo */
  12,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo s_emlrtECI = { 2,   /* nDims */
  176,                                 /* lineNo */
  24,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo t_emlrtECI = { 2,   /* nDims */
  192,                                 /* lineNo */
  24,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo u_emlrtECI = { 3,   /* nDims */
  201,                                 /* lineNo */
  29,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo v_emlrtECI = { 2,   /* nDims */
  218,                                 /* lineNo */
  24,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo w_emlrtECI = { 2,   /* nDims */
  242,                                 /* lineNo */
  24,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtBCInfo gf_emlrtBCI = { 1,  /* iFirst */
  2048,                                /* iLast */
  181,                                 /* lineNo */
  18,                                  /* colNo */
  "SegP",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo hf_emlrtBCI = { 1,  /* iFirst */
  2048,                                /* iLast */
  197,                                 /* lineNo */
  18,                                  /* colNo */
  "SegP",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo if_emlrtBCI = { 1,  /* iFirst */
  2048,                                /* iLast */
  225,                                 /* lineNo */
  18,                                  /* colNo */
  "SegP",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo jf_emlrtBCI = { 1,  /* iFirst */
  2048,                                /* iLast */
  249,                                 /* lineNo */
  18,                                  /* colNo */
  "SegP",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo kf_emlrtBCI = { 1,  /* iFirst */
  2048,                                /* iLast */
  265,                                 /* lineNo */
  54,                                  /* colNo */
  "SegP",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo x_emlrtECI = { -1,  /* nDims */
  265,                                 /* lineNo */
  5,                                   /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo y_emlrtECI = { 2,   /* nDims */
  327,                                 /* lineNo */
  16,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo ab_emlrtECI = { 3,  /* nDims */
  344,                                 /* lineNo */
  25,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo bb_emlrtECI = { 2,  /* nDims */
  361,                                 /* lineNo */
  20,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtBCInfo lf_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  364,                                 /* lineNo */
  19,                                  /* colNo */
  "Fyxz",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo mf_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  365,                                 /* lineNo */
  19,                                  /* colNo */
  "Fyxz",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo nf_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  366,                                 /* lineNo */
  19,                                  /* colNo */
  "Fyxz",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo cb_emlrtECI = { 2,  /* nDims */
  390,                                 /* lineNo */
  20,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo db_emlrtECI = { 3,  /* nDims */
  403,                                 /* lineNo */
  29,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo eb_emlrtECI = { 2,  /* nDims */
  407,                                 /* lineNo */
  24,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtBCInfo of_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  415,                                 /* lineNo */
  23,                                  /* colNo */
  "Fyxz",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo pf_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  416,                                 /* lineNo */
  23,                                  /* colNo */
  "Fyxz",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo qf_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  417,                                 /* lineNo */
  23,                                  /* colNo */
  "Fyxz",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo fb_emlrtECI = { 2,  /* nDims */
  436,                                 /* lineNo */
  24,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtBCInfo rf_emlrtBCI = { 1,  /* iFirst */
  2048,                                /* iLast */
  452,                                 /* lineNo */
  18,                                  /* colNo */
  "SegP",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  3                                    /* checkKind */
};

static emlrtECInfo gb_emlrtECI = { 2,  /* nDims */
  466,                                 /* lineNo */
  32,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtBCInfo sf_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  469,                                 /* lineNo */
  30,                                  /* colNo */
  "BPG",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo tf_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  470,                                 /* lineNo */
  30,                                  /* colNo */
  "BPG",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo uf_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  471,                                 /* lineNo */
  30,                                  /* colNo */
  "BPG",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo vf_emlrtBCI = { 1,  /* iFirst */
  2048,                                /* iLast */
  473,                                 /* lineNo */
  26,                                  /* colNo */
  "SegP",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  3                                    /* checkKind */
};

static emlrtECInfo hb_emlrtECI = { 2,  /* nDims */
  481,                                 /* lineNo */
  32,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtBCInfo wf_emlrtBCI = { 1,  /* iFirst */
  2048,                                /* iLast */
  488,                                 /* lineNo */
  26,                                  /* colNo */
  "SegP",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  3                                    /* checkKind */
};

static emlrtECInfo ib_emlrtECI = { 3,  /* nDims */
  494,                                 /* lineNo */
  37,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo jb_emlrtECI = { 2,  /* nDims */
  514,                                 /* lineNo */
  32,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtBCInfo xf_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  517,                                 /* lineNo */
  31,                                  /* colNo */
  "Fyxz",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo yf_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  518,                                 /* lineNo */
  31,                                  /* colNo */
  "Fyxz",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ag_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  519,                                 /* lineNo */
  31,                                  /* colNo */
  "Fyxz",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo bg_emlrtBCI = { 1,  /* iFirst */
  2048,                                /* iLast */
  521,                                 /* lineNo */
  26,                                  /* colNo */
  "SegP",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  3                                    /* checkKind */
};

static emlrtECInfo kb_emlrtECI = { -1, /* nDims */
  533,                                 /* lineNo */
  34,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo lb_emlrtECI = { -1, /* nDims */
  533,                                 /* lineNo */
  30,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo mb_emlrtECI = { 2,  /* nDims */
  537,                                 /* lineNo */
  36,                                  /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtBCInfo cg_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  540,                                 /* lineNo */
  35,                                  /* colNo */
  "Fyxz",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo dg_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  541,                                 /* lineNo */
  35,                                  /* colNo */
  "Fyxz",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo eg_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  542,                                 /* lineNo */
  35,                                  /* colNo */
  "Fyxz",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo fg_emlrtBCI = { 1,  /* iFirst */
  2048,                                /* iLast */
  544,                                 /* lineNo */
  30,                                  /* colNo */
  "SegP",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo gg_emlrtBCI = { 1,  /* iFirst */
  2048,                                /* iLast */
  561,                                 /* lineNo */
  49,                                  /* colNo */
  "SegP",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo nb_emlrtECI = { -1, /* nDims */
  561,                                 /* lineNo */
  5,                                   /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo r_emlrtRTEI = { 600,/* lineNo */
  9,                                   /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtBCInfo hg_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  606,                                 /* lineNo */
  33,                                  /* colNo */
  "Nxyz",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ig_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  609,                                 /* lineNo */
  21,                                  /* colNo */
  "FiBPxyz",                           /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo jg_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  611,                                 /* lineNo */
  33,                                  /* colNo */
  "Nxyz",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo kg_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  614,                                 /* lineNo */
  21,                                  /* colNo */
  "FiBPxyz",                           /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo lg_emlrtBCI = { 1,  /* iFirst */
  2048,                                /* iLast */
  618,                                 /* lineNo */
  39,                                  /* colNo */
  "Pdata(Pdata_count).PointXYZ",       /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo ob_emlrtECI = { -1, /* nDims */
  618,                                 /* lineNo */
  9,                                   /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtBCInfo mg_emlrtBCI = { 1,  /* iFirst */
  2,                                   /* iLast */
  645,                                 /* lineNo */
  32,                                  /* colNo */
  "bp",                                /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ng_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  650,                                 /* lineNo */
  18,                                  /* colNo */
  "BPmatrix",                          /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo og_emlrtBCI = { 1,  /* iFirst */
  65536,                               /* iLast */
  645,                                 /* lineNo */
  12,                                  /* colNo */
  "Branch",                            /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo pg_emlrtBCI = { 1,  /* iFirst */
  65536,                               /* iLast */
  645,                                 /* lineNo */
  14,                                  /* colNo */
  "Branch",                            /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo pb_emlrtECI = { -1, /* nDims */
  645,                                 /* lineNo */
  5,                                   /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtBCInfo qg_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  110,                                 /* lineNo */
  1,                                   /* colNo */
  "BPcentroid",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo rg_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  111,                                 /* lineNo */
  1,                                   /* colNo */
  "EndP",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo sg_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  137,                                 /* lineNo */
  40,                                  /* colNo */
  "DistInd",                           /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo tg_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  137,                                 /* lineNo */
  32,                                  /* colNo */
  "L_BPgroup",                         /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ug_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  137,                                 /* lineNo */
  1,                                   /* colNo */
  "L_BPgroup",                         /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo vg_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  139,                                 /* lineNo */
  1,                                   /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo wg_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  140,                                 /* lineNo */
  1,                                   /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo xg_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  150,                                 /* lineNo */
  9,                                   /* colNo */
  "ey",                                /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo yg_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  151,                                 /* lineNo */
  9,                                   /* colNo */
  "ex",                                /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ah_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  152,                                 /* lineNo */
  9,                                   /* colNo */
  "ez",                                /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo bh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  155,                                 /* lineNo */
  12,                                  /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ch_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  163,                                 /* lineNo */
  5,                                   /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo dh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  290,                                 /* lineNo */
  9,                                   /* colNo */
  "NewEy",                             /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo eh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  291,                                 /* lineNo */
  9,                                   /* colNo */
  "NewEx",                             /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo fh_emlrtBCI = { 1,  /* iFirst */
  32768,                               /* iLast */
  265,                                 /* lineNo */
  5,                                   /* colNo */
  "Pdata",                             /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo gh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  292,                                 /* lineNo */
  9,                                   /* colNo */
  "NewEz",                             /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo hh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  297,                                 /* lineNo */
  12,                                  /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ih_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  169,                                 /* lineNo */
  9,                                   /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo jh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  591,                                 /* lineNo */
  9,                                   /* colNo */
  "skel",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo l_emlrtDCI = { 591, /* lineNo */
  9,                                   /* colNo */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo kh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  306,                                 /* lineNo */
  5,                                   /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo lh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  660,                                 /* lineNo */
  5,                                   /* colNo */
  "BPmatrix",                          /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo mh_emlrtBCI = { 1,  /* iFirst */
  32768,                               /* iLast */
  561,                                 /* lineNo */
  5,                                   /* colNo */
  "Pdata",                             /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo nh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  179,                                 /* lineNo */
  17,                                  /* colNo */
  "BPC",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo oh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  179,                                 /* lineNo */
  33,                                  /* colNo */
  "BPC",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ph_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  179,                                 /* lineNo */
  49,                                  /* colNo */
  "BPC",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo qh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  195,                                 /* lineNo */
  17,                                  /* colNo */
  "BPG",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo rh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  195,                                 /* lineNo */
  33,                                  /* colNo */
  "BPG",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo sh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  195,                                 /* lineNo */
  49,                                  /* colNo */
  "BPG",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo th_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  245,                                 /* lineNo */
  17,                                  /* colNo */
  "C",                                 /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo uh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  246,                                 /* lineNo */
  17,                                  /* colNo */
  "C",                                 /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo vh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  200,                                 /* lineNo */
  20,                                  /* colNo */
  "L_BPgroup",                         /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo wh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  247,                                 /* lineNo */
  17,                                  /* colNo */
  "C",                                 /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo xh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  250,                                 /* lineNo */
  13,                                  /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo yh_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  251,                                 /* lineNo */
  16,                                  /* colNo */
  "EndP",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ai_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  330,                                 /* lineNo */
  10,                                  /* colNo */
  "BPG",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo bi_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  331,                                 /* lineNo */
  10,                                  /* colNo */
  "BPG",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ci_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  332,                                 /* lineNo */
  10,                                  /* colNo */
  "BPG",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo di_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  333,                                 /* lineNo */
  12,                                  /* colNo */
  "L_BPgroup",                         /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ei_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  335,                                 /* lineNo */
  8,                                   /* colNo */
  "BPcentroid",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo fi_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  382,                                 /* lineNo */
  5,                                   /* colNo */
  "NextBPgroup_ROI",                   /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo gi_emlrtBCI = { 1,  /* iFirst */
  32768,                               /* iLast */
  618,                                 /* lineNo */
  9,                                   /* colNo */
  "Pdata",                             /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo hi_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  221,                                 /* lineNo */
  17,                                  /* colNo */
  "Fyxz",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ii_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  222,                                 /* lineNo */
  17,                                  /* colNo */
  "Fyxz",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ji_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  223,                                 /* lineNo */
  17,                                  /* colNo */
  "Fyxz",                              /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ki_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  393,                                 /* lineNo */
  14,                                  /* colNo */
  "BPG",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo li_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  394,                                 /* lineNo */
  14,                                  /* colNo */
  "BPG",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo mi_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  395,                                 /* lineNo */
  14,                                  /* colNo */
  "BPG",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ni_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  396,                                 /* lineNo */
  12,                                  /* colNo */
  "BPcentroid",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo oi_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  448,                                 /* lineNo */
  17,                                  /* colNo */
  "NextPoint",                         /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo pi_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  449,                                 /* lineNo */
  17,                                  /* colNo */
  "NextPoint",                         /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo qi_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  450,                                 /* lineNo */
  17,                                  /* colNo */
  "NextPoint",                         /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ri_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  453,                                 /* lineNo */
  13,                                  /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo si_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  484,                                 /* lineNo */
  26,                                  /* colNo */
  "BPG",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ti_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  485,                                 /* lineNo */
  26,                                  /* colNo */
  "BPG",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ui_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  486,                                 /* lineNo */
  26,                                  /* colNo */
  "BPG",                               /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo vi_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  492,                                 /* lineNo */
  28,                                  /* colNo */
  "L_BPgroup",                         /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo wi_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  167,                                 /* lineNo */
  37,                                  /* colNo */
  "BPcentroid",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo xi_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  167,                                 /* lineNo */
  45,                                  /* colNo */
  "BPcentroid",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo yi_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  167,                                 /* lineNo */
  53,                                  /* colNo */
  "BPcentroid",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo aj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  168,                                 /* lineNo */
  31,                                  /* colNo */
  "BPgroup",                           /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo bj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  168,                                 /* lineNo */
  39,                                  /* colNo */
  "BPgroup",                           /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo cj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  168,                                 /* lineNo */
  47,                                  /* colNo */
  "BPgroup",                           /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo dj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  170,                                 /* lineNo */
  26,                                  /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ej_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  170,                                 /* lineNo */
  34,                                  /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo fj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  170,                                 /* lineNo */
  42,                                  /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo gj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  305,                                 /* lineNo */
  27,                                  /* colNo */
  "BPgroup",                           /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo hj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  305,                                 /* lineNo */
  35,                                  /* colNo */
  "BPgroup",                           /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ij_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  305,                                 /* lineNo */
  43,                                  /* colNo */
  "BPgroup",                           /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo jj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  307,                                 /* lineNo */
  22,                                  /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo kj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  307,                                 /* lineNo */
  30,                                  /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo lj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  307,                                 /* lineNo */
  38,                                  /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo mj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  383,                                 /* lineNo */
  35,                                  /* colNo */
  "NextBPgroup_ROI",                   /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo nj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  383,                                 /* lineNo */
  43,                                  /* colNo */
  "NextBPgroup_ROI",                   /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo oj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  383,                                 /* lineNo */
  51,                                  /* colNo */
  "NextBPgroup_ROI",                   /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo pj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  458,                                 /* lineNo */
  41,                                  /* colNo */
  "BPcentroid",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo qj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  458,                                 /* lineNo */
  49,                                  /* colNo */
  "BPcentroid",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo rj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  458,                                 /* lineNo */
  57,                                  /* colNo */
  "BPcentroid",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo sj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  459,                                 /* lineNo */
  35,                                  /* colNo */
  "BPgroup",                           /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo tj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  459,                                 /* lineNo */
  43,                                  /* colNo */
  "BPgroup",                           /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo uj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  459,                                 /* lineNo */
  51,                                  /* colNo */
  "BPgroup",                           /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo vj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  527,                                 /* lineNo */
  34,                                  /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo wj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  527,                                 /* lineNo */
  42,                                  /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo xj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  527,                                 /* lineNo */
  50,                                  /* colNo */
  "bwthindata",                        /* aName */
  "TS_AutoSegment_base",               /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo yj_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  69,                                  /* lineNo */
  17,                                  /* colNo */
  "xyz",                               /* aName */
  "sort_xyz",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ak_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  70,                                  /* lineNo */
  14,                                  /* colNo */
  "xyz",                               /* aName */
  "sort_xyz",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo bk_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  77,                                  /* lineNo */
  21,                                  /* colNo */
  "xyz",                               /* aName */
  "sort_xyz",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ck_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  78,                                  /* lineNo */
  18,                                  /* colNo */
  "xyz",                               /* aName */
  "sort_xyz",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo dk_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  77,                                  /* lineNo */
  10,                                  /* colNo */
  "Nxyz",                              /* aName */
  "sort_xyz",                          /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ek_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  889,                                 /* lineNo */
  23,                                  /* colNo */
  "xyz1",                              /* aName */
  "GetEachLength",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo qb_emlrtECI = { 2,  /* nDims */
  891,                                 /* lineNo */
  16,                                  /* colNo */
  "GetEachLength",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtECInfo rb_emlrtECI = { 2,  /* nDims */
  891,                                 /* lineNo */
  15,                                  /* colNo */
  "GetEachLength",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtBCInfo fk_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  893,                                 /* lineNo */
  19,                                  /* colNo */
  "Len_map",                           /* aName */
  "GetEachLength",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo sb_emlrtECI = { -1, /* nDims */
  893,                                 /* lineNo */
  9,                                   /* colNo */
  "GetEachLength",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo v_emlrtRTEI = { 32,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo w_emlrtRTEI = { 29,/* lineNo */
  23,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo x_emlrtRTEI = { 34,/* lineNo */
  5,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo y_emlrtRTEI = { 29,/* lineNo */
  18,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ab_emlrtRTEI = { 32,/* lineNo */
  9,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo bb_emlrtRTEI = { 52,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo cb_emlrtRTEI = { 55,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo db_emlrtRTEI = { 43,/* lineNo */
  9,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo eb_emlrtRTEI = { 39,/* lineNo */
  5,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo fb_emlrtRTEI = { 1,/* lineNo */
  10,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo gb_emlrtRTEI = { 38,/* lineNo */
  11,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ib_emlrtRTEI = { 691,/* lineNo */
  46,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo jb_emlrtRTEI = { 667,/* lineNo */
  19,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo kb_emlrtRTEI = { 695,/* lineNo */
  2,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo lb_emlrtRTEI = { 42,/* lineNo */
  9,                                   /* colNo */
  "find",                              /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/find.m"/* pName */
};

static emlrtRTEInfo nb_emlrtRTEI = { 21,/* lineNo */
  20,                                  /* colNo */
  "ind2sub",                           /* fName */
  "/Applications/MATLAB_R2019b.app/toolbox/eml/lib/matlab/elmat/ind2sub.m"/* pName */
};

static emlrtRTEInfo ob_emlrtRTEI = { 702,/* lineNo */
  51,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo pb_emlrtRTEI = { 705,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo qb_emlrtRTEI = { 706,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo rb_emlrtRTEI = { 707,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo sb_emlrtRTEI = { 708,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo tb_emlrtRTEI = { 709,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ub_emlrtRTEI = { 714,/* lineNo */
  23,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo vb_emlrtRTEI = { 716,/* lineNo */
  23,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo wb_emlrtRTEI = { 717,/* lineNo */
  20,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo xb_emlrtRTEI = { 721,/* lineNo */
  22,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo yb_emlrtRTEI = { 726,/* lineNo */
  17,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ac_emlrtRTEI = { 786,/* lineNo */
  44,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo bc_emlrtRTEI = { 786,/* lineNo */
  13,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo cc_emlrtRTEI = { 801,/* lineNo */
  24,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo dc_emlrtRTEI = { 691,/* lineNo */
  2,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ec_emlrtRTEI = { 691,/* lineNo */
  15,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo fc_emlrtRTEI = { 691,/* lineNo */
  23,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo gc_emlrtRTEI = { 720,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo hc_emlrtRTEI = { 762,/* lineNo */
  13,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ic_emlrtRTEI = { 788,/* lineNo */
  13,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo jc_emlrtRTEI = { 790,/* lineNo */
  17,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo kc_emlrtRTEI = { 721,/* lineNo */
  40,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo lc_emlrtRTEI = { 721,/* lineNo */
  11,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo mc_emlrtRTEI = { 723,/* lineNo */
  12,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo nc_emlrtRTEI = { 724,/* lineNo */
  12,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo pc_emlrtRTEI = { 693,/* lineNo */
  6,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo dh_emlrtRTEI = { 96,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo eh_emlrtRTEI = { 109,/* lineNo */
  46,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo fh_emlrtRTEI = { 84,/* lineNo */
  19,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo gh_emlrtRTEI = { 113,/* lineNo */
  2,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo hh_emlrtRTEI = { 118,/* lineNo */
  51,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ih_emlrtRTEI = { 121,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo jh_emlrtRTEI = { 122,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo kh_emlrtRTEI = { 123,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo lh_emlrtRTEI = { 124,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo mh_emlrtRTEI = { 125,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo nh_emlrtRTEI = { 129,/* lineNo */
  23,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo oh_emlrtRTEI = { 131,/* lineNo */
  23,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ph_emlrtRTEI = { 132,/* lineNo */
  20,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo qh_emlrtRTEI = { 137,/* lineNo */
  22,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo rh_emlrtRTEI = { 142,/* lineNo */
  17,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo sh_emlrtRTEI = { 597,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo th_emlrtRTEI = { 601,/* lineNo */
  16,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo uh_emlrtRTEI = { 604,/* lineNo */
  21,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo vh_emlrtRTEI = { 610,/* lineNo */
  5,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo wh_emlrtRTEI = { 344,/* lineNo */
  40,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo xh_emlrtRTEI = { 344,/* lineNo */
  9,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo yh_emlrtRTEI = { 201,/* lineNo */
  44,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ai_emlrtRTEI = { 381,/* lineNo */
  5,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo bi_emlrtRTEI = { 201,/* lineNo */
  13,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ci_emlrtRTEI = { 361,/* lineNo */
  20,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo di_emlrtRTEI = { 218,/* lineNo */
  24,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ei_emlrtRTEI = { 403,/* lineNo */
  44,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo fi_emlrtRTEI = { 403,/* lineNo */
  13,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo gi_emlrtRTEI = { 407,/* lineNo */
  24,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo hi_emlrtRTEI = { 533,/* lineNo */
  38,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ii_emlrtRTEI = { 533,/* lineNo */
  52,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ji_emlrtRTEI = { 533,/* lineNo */
  69,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ki_emlrtRTEI = { 537,/* lineNo */
  36,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo li_emlrtRTEI = { 494,/* lineNo */
  52,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo mi_emlrtRTEI = { 494,/* lineNo */
  21,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ni_emlrtRTEI = { 514,/* lineNo */
  32,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo oi_emlrtRTEI = { 109,/* lineNo */
  2,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo pi_emlrtRTEI = { 109,/* lineNo */
  15,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo qi_emlrtRTEI = { 109,/* lineNo */
  23,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ri_emlrtRTEI = { 135,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo si_emlrtRTEI = { 176,/* lineNo */
  13,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ti_emlrtRTEI = { 203,/* lineNo */
  13,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ui_emlrtRTEI = { 604,/* lineNo */
  5,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo vi_emlrtRTEI = { 606,/* lineNo */
  5,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo wi_emlrtRTEI = { 137,/* lineNo */
  40,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo xi_emlrtRTEI = { 137,/* lineNo */
  11,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo yi_emlrtRTEI = { 171,/* lineNo */
  9,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo aj_emlrtRTEI = { 139,/* lineNo */
  12,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo bj_emlrtRTEI = { 140,/* lineNo */
  12,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo cj_emlrtRTEI = { 382,/* lineNo */
  21,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo dj_emlrtRTEI = { 111,/* lineNo */
  6,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ej_emlrtRTEI = { 60,/* lineNo */
  5,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo fj_emlrtRTEI = { 64,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo gj_emlrtRTEI = { 891,/* lineNo */
  15,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo hj_emlrtRTEI = { 68,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo ij_emlrtRTEI = { 74,/* lineNo */
  5,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo jj_emlrtRTEI = { 65,/* lineNo */
  1,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo kj_emlrtRTEI = { 889,/* lineNo */
  9,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo lj_emlrtRTEI = { 891,/* lineNo */
  9,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo mj_emlrtRTEI = { 892,/* lineNo */
  24,                                  /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRTEInfo nj_emlrtRTEI = { 887,/* lineNo */
  5,                                   /* colNo */
  "AutoSegment",                       /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pName */
};

static emlrtRSInfo pn_emlrtRSI = { 115,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo qn_emlrtRSI = { 108,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo rn_emlrtRSI = { 145,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

static emlrtRSInfo sn_emlrtRSI = { 284,/* lineNo */
  "TS_AutoSegment_base",               /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AutoSegment.m"/* pathName */
};

/* Function Declarations */
static void AutoSegment_Pre(AutoSegmentStackData *SD, const emlrtStack *sp,
  emxArray_boolean_T *bwthindata, const real_T Reso[3], const emxArray_boolean_T
  *AddBP, emxArray_boolean_T *Output_Input, emxArray_boolean_T *Output_AddBP,
  emxArray_boolean_T *Output_Branch, emxArray_boolean_T *Output_BranchGroup,
  emxArray_boolean_T *Output_End, struct_T Output_Pointdata[32768], real_T
  Output_ResolutionXYZ[3], emxArray_real_T *Output_BPmatrix);
static void GetEachLength(const emlrtStack *sp, const real_T xyz1[3], const
  emxArray_real_T *xyz2, const real_T Reso[3], emxArray_real_T *Len_map);
static void TS_AutoSegment_base(AutoSegmentStackData *SD, const emlrtStack *sp,
  emxArray_boolean_T *bwthindata, const real_T Reso[3], const emxArray_boolean_T
  *AddBP, emxArray_boolean_T *Output_Output, emxArray_boolean_T *Output_AddBP,
  emxArray_boolean_T *Output_Branch, emxArray_boolean_T *Output_BranchGroup,
  emxArray_boolean_T *Output_End, struct1_T Output_Pointdata[32768], real_T
  Output_ResolutionXYZ[3], emxArray_real_T *Output_BPmatrix);
static const mxArray *b_emlrt_marshallOut(const emlrtStack *sp, const char_T u
  [51]);
static const mxArray *c_emlrt_marshallOut(const emlrtStack *sp, const char_T u
  [26]);
static const mxArray *emlrt_marshallOut(const emlrtStack *sp, const char_T u[36]);
static void sort_xyz(const emlrtStack *sp, emxArray_real_T *xyz, const real_T
                     Reso[3], emxArray_real_T *Nxyz);

/* Function Definitions */
static void AutoSegment_Pre(AutoSegmentStackData *SD, const emlrtStack *sp,
  emxArray_boolean_T *bwthindata, const real_T Reso[3], const emxArray_boolean_T
  *AddBP, emxArray_boolean_T *Output_Input, emxArray_boolean_T *Output_AddBP,
  emxArray_boolean_T *Output_Branch, emxArray_boolean_T *Output_BranchGroup,
  emxArray_boolean_T *Output_End, struct_T Output_Pointdata[32768], real_T
  Output_ResolutionXYZ[3], emxArray_real_T *Output_BPmatrix)
{
  int32_T i;
  emxArray_boolean_T *b_bwthindata;
  real_T SegP[6144];
  int32_T loop_ub;
  emxArray_boolean_T *BPcentroid;
  emxArray_boolean_T *BPgroup;
  emxArray_boolean_T *EndP;
  emxArray_boolean_T *FindNearestBP;
  int32_T n;
  int32_T b_i;
  emxArray_int32_T *ii;
  int32_T i1;
  emxArray_int32_T *varargout_4;
  emxArray_real_T *LEN;
  emxArray_boolean_T b_BPcentroid;
  int32_T c_BPcentroid[1];
  real_T BranchPoint[3];
  emxArray_real_T *bpx;
  emxArray_int32_T *varargout_6;
  emxArray_real_T *b_varargout_4;
  int32_T d_BPcentroid[1];
  emxArray_real_T *b_varargout_6;
  emxArray_real_T *r;
  emxArray_real_T *L_BPgroup;
  emxArray_real32_T *unusedU12;
  emxArray_uint32_T *DistInd;
  emxArray_int32_T *ex;
  emxArray_int32_T *ez;
  emxArray_int32_T *r1;
  emxArray_int32_T *r2;
  emxArray_int32_T *r3;
  int32_T TYPEnum;
  emxArray_boolean_T b_EndP;
  int32_T e_BPcentroid[1];
  int32_T Pdata_count;
  emxArray_real_T *Fyxz;
  emxArray_real_T *p;
  emxArray_real_T *b_Fyxz;
  int32_T b_n;
  real_T Y;
  real_T X;
  real_T Z;
  uint32_T c;
  boolean_T Go2Next;
  uint32_T qY;
  real_T BPcentroid_ROI_tmp[3];
  real_T b_BPcentroid_ROI_tmp[3];
  real_T c_BPcentroid_ROI_tmp[3];
  int32_T b_c[2];
  int32_T iv[2];
  int32_T i2;
  int32_T i3;
  boolean_T x[2048];
  int32_T k;
  int32_T i4;
  real_T dv[6141];
  real_T dv1[6141];
  real_T dv2[2047];
  int32_T i5;
  real_T lenp[3];
  int32_T maxval_tmp;
  boolean_T maxval;
  boolean_T b;
  boolean_T c_bwthindata[27];
  int32_T ii_data[27];
  int32_T ii_size[1];
  int32_T b_ii_size[1];
  int32_T c_ii_size[1];
  real_T b_ii_data[27];
  int32_T varargout_5_data[27];
  int32_T varargout_5_size[1];
  int32_T varargout_6_data[27];
  int32_T varargout_6_size[1];
  int32_T b_varargout_5_size[1];
  int32_T b_varargout_6_size[1];
  real_T b_varargout_5_data[27];
  emxArray_real_T c_ii_data;
  real_T b_varargout_6_data[27];
  emxArray_real_T d_ii_data;
  emxArray_real_T c_varargout_5_data;
  emxArray_real_T e_ii_data;
  emxArray_real_T d_varargout_5_data;
  emxArray_real_T c_varargout_6_data;
  emxArray_real_T e_varargout_5_data;
  emxArray_real_T d_varargout_6_data;
  int32_T C_size[2];
  emxArray_real_T e_varargout_6_data;
  real_T C[2];
  real_T C_data[81];
  int32_T lenp_size[2];
  real_T lenp_data[81];
  int32_T b_C_size[2];
  emxArray_real_T b_C_data;
  real_T c_C_data[81];
  emxArray_real_T d_C_data;
  emxArray_real_T e_C_data;
  boolean_T exitg1;
  real_T Lnum;
  int32_T f_BPcentroid[1];
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack f_st;
  emlrtStack g_st;
  emlrtStack h_st;
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
  g_st.prev = &f_st;
  g_st.tls = f_st.tls;
  h_st.prev = &g_st;
  h_st.tls = g_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);

  /*  Output = TS_AutoSegment1(skeleton_logicaldata,Resolution) */
  /*  0. Pre Processing */
  /*  1. End point to Branch or End Point */
  /*  2. Branch to Branch Point */
  /*   * Resolution need X:Y:Z = [1:1:1]!!! */
  /*  %  */
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[3])bwthindata->size, *(int32_T (*)[3])
    AddBP->size, &emlrtECI, sp);
  st.site = &qb_emlrtRSI;
  tic(&st);

  /*  Resi = sum(bwthindata(:)); */
  /*  % PointXYZ is matrix, Type is 'End to Branch' or 'Branch to Branch' */
  /*  Pdata(1:2^15) = struct('PointXYZ',[],'Type',[],'Length',[],'Branch',[]); %  point--->[Y X Z] */
  /*   point--->[Y X Z] */
  for (i = 0; i < 6144; i++) {
    SegP[i] = rtNaN;
    SD->u1.f1.s.PointXYZ[i] = rtNaN;
  }

  emxInit_boolean_T(sp, &b_bwthindata, 3, &ib_emlrtRTEI, true);
  SD->u1.f1.s.Type = 0.0;
  SD->u1.f1.s.Length = 0.0;
  SD->u1.f1.s.Branch[0] = rtNaN;
  SD->u1.f1.s.Branch[1] = rtNaN;
  SD->u1.f1.s.Branch[2] = rtNaN;

  /*  Analysis Branch-point and End-point  */
  /*  disp('Analysis Branch-point and End-point ') */
  i = b_bwthindata->size[0] * b_bwthindata->size[1] * b_bwthindata->size[2];
  b_bwthindata->size[0] = bwthindata->size[0];
  b_bwthindata->size[1] = bwthindata->size[1];
  b_bwthindata->size[2] = bwthindata->size[2];
  emxEnsureCapacity_boolean_T(sp, b_bwthindata, i, &ib_emlrtRTEI);
  loop_ub = bwthindata->size[0] * bwthindata->size[1] * bwthindata->size[2] - 1;
  for (i = 0; i <= loop_ub; i++) {
    b_bwthindata->data[i] = bwthindata->data[i];
  }

  emxInit_boolean_T(sp, &BPcentroid, 3, &dc_emlrtRTEI, true);
  emxInit_boolean_T(sp, &BPgroup, 3, &ec_emlrtRTEI, true);
  emxInit_boolean_T(sp, &EndP, 3, &fc_emlrtRTEI, true);
  emxInit_boolean_T(sp, &FindNearestBP, 3, &bc_emlrtRTEI, true);
  st.site = &pb_emlrtRSI;
  TS_skelmorph3d(&st, b_bwthindata, BPcentroid, FindNearestBP, BPgroup, EndP);
  loop_ub = bwthindata->size[0] * (bwthindata->size[1] * bwthindata->size[2]) -
    1;
  n = 0;
  for (b_i = 0; b_i <= loop_ub; b_i++) {
    if (bwthindata->data[b_i] && AddBP->data[b_i]) {
      n++;
    }
  }

  emxInit_int32_T(sp, &ii, 1, &oc_emlrtRTEI, true);
  i = ii->size[0];
  ii->size[0] = n;
  emxEnsureCapacity_int32_T(sp, ii, i, &jb_emlrtRTEI);
  n = 0;
  for (b_i = 0; b_i <= loop_ub; b_i++) {
    if (bwthindata->data[b_i] && AddBP->data[b_i]) {
      ii->data[n] = b_i + 1;
      n++;
    }
  }

  loop_ub = ii->size[0] - 1;
  i = BPcentroid->size[0] * BPcentroid->size[1] * BPcentroid->size[2];
  for (i1 = 0; i1 <= loop_ub; i1++) {
    if ((ii->data[i1] < 1) || (ii->data[i1] > i)) {
      emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, i, &f_emlrtBCI, sp);
    }

    BPcentroid->data[ii->data[i1] - 1] = true;
  }

  loop_ub = bwthindata->size[0] * (bwthindata->size[1] * bwthindata->size[2]) -
    1;
  n = 0;
  for (b_i = 0; b_i <= loop_ub; b_i++) {
    if (bwthindata->data[b_i] && AddBP->data[b_i]) {
      n++;
    }
  }

  emxInit_int32_T(sp, &varargout_4, 1, &pc_emlrtRTEI, true);
  i = varargout_4->size[0];
  varargout_4->size[0] = n;
  emxEnsureCapacity_int32_T(sp, varargout_4, i, &jb_emlrtRTEI);
  n = 0;
  for (b_i = 0; b_i <= loop_ub; b_i++) {
    if (bwthindata->data[b_i] && AddBP->data[b_i]) {
      varargout_4->data[n] = b_i + 1;
      n++;
    }
  }

  loop_ub = varargout_4->size[0] - 1;
  i = EndP->size[0] * EndP->size[1] * EndP->size[2];
  for (i1 = 0; i1 <= loop_ub; i1++) {
    if ((varargout_4->data[i1] < 1) || (varargout_4->data[i1] > i)) {
      emlrtDynamicBoundsCheckR2012b(varargout_4->data[i1], 1, i, &g_emlrtBCI, sp);
    }

    EndP->data[varargout_4->data[i1] - 1] = false;
  }

  /*  %% % term add . 2016.10.17 */
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[3])BPcentroid->size, *(int32_T (*)[3])
    BPgroup->size, &b_emlrtECI, sp);
  loop_ub = BPcentroid->size[0] * BPcentroid->size[1] * BPcentroid->size[2];
  i = BPgroup->size[0] * BPgroup->size[1] * BPgroup->size[2];
  BPgroup->size[0] = BPcentroid->size[0];
  BPgroup->size[1] = BPcentroid->size[1];
  BPgroup->size[2] = BPcentroid->size[2];
  emxEnsureCapacity_boolean_T(sp, BPgroup, i, &kb_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    BPgroup->data[i] = (BPcentroid->data[i] || BPgroup->data[i]);
  }

  emxInit_real_T(sp, &LEN, 1, &hc_emlrtRTEI, true);

  /*  main process */
  /*  disp('Analysis Branch-point and End-point ') */
  st.site = &ob_emlrtRSI;
  n = BPcentroid->size[0] * BPcentroid->size[1] * BPcentroid->size[2];
  b_BPcentroid = *BPcentroid;
  c_BPcentroid[0] = n;
  b_BPcentroid.size = &c_BPcentroid[0];
  b_BPcentroid.numDimensions = 1;
  b_st.site = &cd_emlrtRSI;
  eml_find(&b_st, &b_BPcentroid, ii);
  st.site = &ob_emlrtRSI;
  BranchPoint[0] = BPcentroid->size[0];
  BranchPoint[1] = BPcentroid->size[1];
  BranchPoint[2] = BPcentroid->size[2];
  i = LEN->size[0];
  LEN->size[0] = ii->size[0];
  emxEnsureCapacity_real_T(&st, LEN, i, &lb_emlrtRTEI);
  loop_ub = ii->size[0];
  for (i = 0; i < loop_ub; i++) {
    LEN->data[i] = ii->data[i];
  }

  emxInit_real_T(&st, &bpx, 1, &jb_emlrtRTEI, true);
  emxInit_int32_T(&st, &varargout_6, 1, &jb_emlrtRTEI, true);
  b_st.site = &hd_emlrtRSI;
  ind2sub_indexClass(&b_st, BranchPoint, LEN, varargout_4, ii, varargout_6);
  i = bpx->size[0];
  bpx->size[0] = ii->size[0];
  emxEnsureCapacity_real_T(&st, bpx, i, &mb_emlrtRTEI);
  loop_ub = ii->size[0];
  for (i = 0; i < loop_ub; i++) {
    bpx->data[i] = ii->data[i];
  }

  emxInit_real_T(&st, &b_varargout_4, 1, &nb_emlrtRTEI, true);

  /*  BP point infomation,[X Y Z Number Count] */
  st.site = &nb_emlrtRSI;
  n = BPcentroid->size[0] * BPcentroid->size[1] * BPcentroid->size[2];
  b_BPcentroid = *BPcentroid;
  d_BPcentroid[0] = n;
  b_BPcentroid.size = &d_BPcentroid[0];
  b_BPcentroid.numDimensions = 1;
  b_st.site = &cd_emlrtRSI;
  eml_find(&b_st, &b_BPcentroid, ii);
  i = b_varargout_4->size[0];
  b_varargout_4->size[0] = varargout_4->size[0];
  emxEnsureCapacity_real_T(sp, b_varargout_4, i, &nb_emlrtRTEI);
  loop_ub = varargout_4->size[0];
  for (i = 0; i < loop_ub; i++) {
    b_varargout_4->data[i] = varargout_4->data[i];
  }

  emxInit_real_T(sp, &b_varargout_6, 1, &nb_emlrtRTEI, true);
  i = b_varargout_6->size[0];
  b_varargout_6->size[0] = varargout_6->size[0];
  emxEnsureCapacity_real_T(sp, b_varargout_6, i, &nb_emlrtRTEI);
  loop_ub = varargout_6->size[0];
  for (i = 0; i < loop_ub; i++) {
    b_varargout_6->data[i] = varargout_6->data[i];
  }

  i = LEN->size[0];
  LEN->size[0] = ii->size[0];
  emxEnsureCapacity_real_T(sp, LEN, i, &lb_emlrtRTEI);
  loop_ub = ii->size[0];
  for (i = 0; i < loop_ub; i++) {
    LEN->data[i] = ii->data[i];
  }

  emxInit_real_T(sp, &r, 1, &ob_emlrtRTEI, true);
  i = r->size[0];
  r->size[0] = bpx->size[0];
  emxEnsureCapacity_real_T(sp, r, i, &ob_emlrtRTEI);
  loop_ub = bpx->size[0];
  for (i = 0; i < loop_ub; i++) {
    r->data[i] = 0.0;
  }

  st.site = &nb_emlrtRSI;
  c_cat(&st, bpx, b_varargout_4, b_varargout_6, LEN, r, Output_BPmatrix);

  /* clear  bpy bpx bpz */
  i = Output_Input->size[0] * Output_Input->size[1] * Output_Input->size[2];
  Output_Input->size[0] = bwthindata->size[0];
  Output_Input->size[1] = bwthindata->size[1];
  Output_Input->size[2] = bwthindata->size[2];
  emxEnsureCapacity_boolean_T(sp, Output_Input, i, &pb_emlrtRTEI);
  loop_ub = bwthindata->size[0] * bwthindata->size[1] * bwthindata->size[2];
  emxFree_real_T(&r);
  for (i = 0; i < loop_ub; i++) {
    Output_Input->data[i] = bwthindata->data[i];
  }

  i = Output_AddBP->size[0] * Output_AddBP->size[1] * Output_AddBP->size[2];
  Output_AddBP->size[0] = bwthindata->size[0];
  Output_AddBP->size[1] = bwthindata->size[1];
  Output_AddBP->size[2] = bwthindata->size[2];
  emxEnsureCapacity_boolean_T(sp, Output_AddBP, i, &qb_emlrtRTEI);
  loop_ub = bwthindata->size[0] * bwthindata->size[1] * bwthindata->size[2];
  for (i = 0; i < loop_ub; i++) {
    Output_AddBP->data[i] = (bwthindata->data[i] && AddBP->data[i]);
  }

  i = Output_Branch->size[0] * Output_Branch->size[1] * Output_Branch->size[2];
  Output_Branch->size[0] = BPcentroid->size[0];
  Output_Branch->size[1] = BPcentroid->size[1];
  Output_Branch->size[2] = BPcentroid->size[2];
  emxEnsureCapacity_boolean_T(sp, Output_Branch, i, &rb_emlrtRTEI);
  loop_ub = BPcentroid->size[0] * BPcentroid->size[1] * BPcentroid->size[2];
  for (i = 0; i < loop_ub; i++) {
    Output_Branch->data[i] = BPcentroid->data[i];
  }

  i = Output_BranchGroup->size[0] * Output_BranchGroup->size[1] *
    Output_BranchGroup->size[2];
  Output_BranchGroup->size[0] = BPgroup->size[0];
  Output_BranchGroup->size[1] = BPgroup->size[1];
  Output_BranchGroup->size[2] = BPgroup->size[2];
  emxEnsureCapacity_boolean_T(sp, Output_BranchGroup, i, &sb_emlrtRTEI);
  loop_ub = BPgroup->size[0] * BPgroup->size[1] * BPgroup->size[2];
  for (i = 0; i < loop_ub; i++) {
    Output_BranchGroup->data[i] = BPgroup->data[i];
  }

  i = Output_End->size[0] * Output_End->size[1] * Output_End->size[2];
  Output_End->size[0] = EndP->size[0];
  Output_End->size[1] = EndP->size[1];
  Output_End->size[2] = EndP->size[2];
  emxEnsureCapacity_boolean_T(sp, Output_End, i, &tb_emlrtRTEI);
  loop_ub = EndP->size[0] * EndP->size[1] * EndP->size[2];
  for (i = 0; i < loop_ub; i++) {
    Output_End->data[i] = EndP->data[i];
  }

  Output_ResolutionXYZ[0] = Reso[0];
  Output_ResolutionXYZ[1] = Reso[1];
  Output_ResolutionXYZ[2] = Reso[2];
  i = b_bwthindata->size[0] * b_bwthindata->size[1] * b_bwthindata->size[2];
  b_bwthindata->size[0] = bwthindata->size[0];
  b_bwthindata->size[1] = bwthindata->size[1];
  b_bwthindata->size[2] = bwthindata->size[2];
  emxEnsureCapacity_boolean_T(sp, b_bwthindata, i, &ub_emlrtRTEI);
  loop_ub = bwthindata->size[0] * bwthindata->size[1] * bwthindata->size[2] - 1;
  for (i = 0; i <= loop_ub; i++) {
    b_bwthindata->data[i] = bwthindata->data[i];
  }

  st.site = &mb_emlrtRSI;
  padarray(&st, b_bwthindata, bwthindata);

  /*  For Crop;Nearest 26 point */
  /*   pointview(bwthindata,Reso,'figure') */
  i = b_bwthindata->size[0] * b_bwthindata->size[1] * b_bwthindata->size[2];
  b_bwthindata->size[0] = BPcentroid->size[0];
  b_bwthindata->size[1] = BPcentroid->size[1];
  b_bwthindata->size[2] = BPcentroid->size[2];
  emxEnsureCapacity_boolean_T(sp, b_bwthindata, i, &vb_emlrtRTEI);
  loop_ub = BPcentroid->size[0] * BPcentroid->size[1] * BPcentroid->size[2] - 1;
  for (i = 0; i <= loop_ub; i++) {
    b_bwthindata->data[i] = BPcentroid->data[i];
  }

  st.site = &lb_emlrtRSI;
  padarray(&st, b_bwthindata, BPcentroid);
  i = b_bwthindata->size[0] * b_bwthindata->size[1] * b_bwthindata->size[2];
  b_bwthindata->size[0] = BPgroup->size[0];
  b_bwthindata->size[1] = BPgroup->size[1];
  b_bwthindata->size[2] = BPgroup->size[2];
  emxEnsureCapacity_boolean_T(sp, b_bwthindata, i, &wb_emlrtRTEI);
  loop_ub = BPgroup->size[0] * BPgroup->size[1] * BPgroup->size[2] - 1;
  for (i = 0; i <= loop_ub; i++) {
    b_bwthindata->data[i] = BPgroup->data[i];
  }

  emxInit_real_T(sp, &L_BPgroup, 3, &gc_emlrtRTEI, true);
  emxInit_real32_T(sp, &unusedU12, 3, &jb_emlrtRTEI, true);
  emxInit_uint32_T(sp, &DistInd, 3, &jb_emlrtRTEI, true);
  st.site = &kb_emlrtRSI;
  padarray(&st, b_bwthindata, BPgroup);
  st.site = &jb_emlrtRSI;
  bwdist(&st, BPcentroid, unusedU12, DistInd);

  /*  L_BPgroup = uint32(bwlabeln(BPcentroid,26)); */
  st.site = &ib_emlrtRSI;
  TS_bwlabeln3D26(&st, BPcentroid, L_BPgroup);
  st.site = &hb_emlrtRSI;
  loop_ub = BPgroup->size[0] * (BPgroup->size[1] * BPgroup->size[2]) - 1;
  n = 0;
  emxFree_real32_T(&unusedU12);
  for (b_i = 0; b_i <= loop_ub; b_i++) {
    if (BPgroup->data[b_i]) {
      n++;
    }
  }

  emxInit_int32_T(sp, &ex, 1, &kc_emlrtRTEI, true);
  i = ex->size[0];
  ex->size[0] = n;
  emxEnsureCapacity_int32_T(sp, ex, i, &jb_emlrtRTEI);
  n = 0;
  for (b_i = 0; b_i <= loop_ub; b_i++) {
    if (BPgroup->data[b_i]) {
      ex->data[n] = b_i + 1;
      n++;
    }
  }

  n = DistInd->size[0] * DistInd->size[1] * DistInd->size[2];
  b_i = L_BPgroup->size[0] * L_BPgroup->size[1] * L_BPgroup->size[2];
  loop_ub = ex->size[0];
  for (i = 0; i < loop_ub; i++) {
    if ((ex->data[i] < 1) || (ex->data[i] > n)) {
      emlrtDynamicBoundsCheckR2012b(ex->data[i], 1, n, &h_emlrtBCI, sp);
    }

    i1 = (int32_T)DistInd->data[ex->data[i] - 1];
    if ((i1 < 1) || (i1 > b_i)) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, b_i, &i_emlrtBCI, sp);
    }
  }

  loop_ub = BPgroup->size[0] * (BPgroup->size[1] * BPgroup->size[2]) - 1;
  n = 0;
  for (b_i = 0; b_i <= loop_ub; b_i++) {
    if (BPgroup->data[b_i]) {
      n++;
    }
  }

  emxInit_int32_T(sp, &ez, 1, &lc_emlrtRTEI, true);
  i = ez->size[0];
  ez->size[0] = n;
  emxEnsureCapacity_int32_T(sp, ez, i, &jb_emlrtRTEI);
  n = 0;
  for (b_i = 0; b_i <= loop_ub; b_i++) {
    if (BPgroup->data[b_i]) {
      ez->data[n] = b_i + 1;
      n++;
    }
  }

  loop_ub = BPgroup->size[0] * (BPgroup->size[1] * BPgroup->size[2]) - 1;
  n = 0;
  for (b_i = 0; b_i <= loop_ub; b_i++) {
    if (BPgroup->data[b_i]) {
      n++;
    }
  }

  emxInit_int32_T(sp, &r1, 1, &lc_emlrtRTEI, true);
  i = r1->size[0];
  r1->size[0] = n;
  emxEnsureCapacity_int32_T(sp, r1, i, &jb_emlrtRTEI);
  n = 0;
  for (b_i = 0; b_i <= loop_ub; b_i++) {
    if (BPgroup->data[b_i]) {
      r1->data[n] = b_i + 1;
      n++;
    }
  }

  i = L_BPgroup->size[0] * L_BPgroup->size[1] * L_BPgroup->size[2];
  i1 = LEN->size[0];
  LEN->size[0] = r1->size[0];
  emxEnsureCapacity_real_T(sp, LEN, i1, &xb_emlrtRTEI);
  loop_ub = r1->size[0];
  for (i1 = 0; i1 < loop_ub; i1++) {
    LEN->data[i1] = L_BPgroup->data[(int32_T)DistInd->data[r1->data[i1] - 1] - 1];
  }

  emxFree_uint32_T(&DistInd);
  loop_ub = LEN->size[0];
  for (i1 = 0; i1 < loop_ub; i1++) {
    if ((r1->data[i1] < 1) || (r1->data[i1] > i)) {
      emlrtDynamicBoundsCheckR2012b(r1->data[i1], 1, i, &j_emlrtBCI, sp);
    }

    L_BPgroup->data[r1->data[i1] - 1] = LEN->data[i1];
  }

  emxFree_int32_T(&r1);

  /* clear  DistInd */
  loop_ub = BPcentroid->size[0] * (BPcentroid->size[1] * BPcentroid->size[2]) -
    1;
  n = 0;
  for (b_i = 0; b_i <= loop_ub; b_i++) {
    if (BPcentroid->data[b_i]) {
      n++;
    }
  }

  emxInit_int32_T(sp, &r2, 1, &mc_emlrtRTEI, true);
  i = r2->size[0];
  r2->size[0] = n;
  emxEnsureCapacity_int32_T(sp, r2, i, &jb_emlrtRTEI);
  n = 0;
  for (b_i = 0; b_i <= loop_ub; b_i++) {
    if (BPcentroid->data[b_i]) {
      r2->data[n] = b_i + 1;
      n++;
    }
  }

  loop_ub = r2->size[0] - 1;
  i = bwthindata->size[0] * bwthindata->size[1] * bwthindata->size[2];
  for (i1 = 0; i1 <= loop_ub; i1++) {
    if ((r2->data[i1] < 1) || (r2->data[i1] > i)) {
      emlrtDynamicBoundsCheckR2012b(r2->data[i1], 1, i, &k_emlrtBCI, sp);
    }

    bwthindata->data[r2->data[i1] - 1] = false;
  }

  emxFree_int32_T(&r2);

  /*  bwthindata --->����čs���A�Ȃ��Ȃ�����I�� */
  loop_ub = BPgroup->size[0] * (BPgroup->size[1] * BPgroup->size[2]) - 1;
  n = 0;
  for (b_i = 0; b_i <= loop_ub; b_i++) {
    if (BPgroup->data[b_i]) {
      n++;
    }
  }

  emxInit_int32_T(sp, &r3, 1, &nc_emlrtRTEI, true);
  i = r3->size[0];
  r3->size[0] = n;
  emxEnsureCapacity_int32_T(sp, r3, i, &jb_emlrtRTEI);
  n = 0;
  for (b_i = 0; b_i <= loop_ub; b_i++) {
    if (BPgroup->data[b_i]) {
      r3->data[n] = b_i + 1;
      n++;
    }
  }

  loop_ub = r3->size[0] - 1;
  i = bwthindata->size[0] * bwthindata->size[1] * bwthindata->size[2];
  for (i1 = 0; i1 <= loop_ub; i1++) {
    if ((r3->data[i1] < 1) || (r3->data[i1] > i)) {
      emlrtDynamicBoundsCheckR2012b(r3->data[i1], 1, i, &l_emlrtBCI, sp);
    }

    bwthindata->data[r3->data[i1] - 1] = false;
  }

  emxFree_int32_T(&r3);
  i = b_bwthindata->size[0] * b_bwthindata->size[1] * b_bwthindata->size[2];
  b_bwthindata->size[0] = EndP->size[0];
  b_bwthindata->size[1] = EndP->size[1];
  b_bwthindata->size[2] = EndP->size[2];
  emxEnsureCapacity_boolean_T(sp, b_bwthindata, i, &yb_emlrtRTEI);
  loop_ub = EndP->size[0] * EndP->size[1] * EndP->size[2] - 1;
  for (i = 0; i <= loop_ub; i++) {
    b_bwthindata->data[i] = EndP->data[i];
  }

  st.site = &gb_emlrtRSI;
  padarray(&st, b_bwthindata, EndP);

  /*  End point to a Branchpoint or a Endpoint */
  /*  disp('   ... 1st End point to a Branchpoint or a Endpoint') */
  emxFree_boolean_T(&b_bwthindata);
  for (i = 0; i < 32768; i++) {
    Output_Pointdata[i] = SD->u1.f1.s;
  }

  TYPEnum = 0;
  st.site = &fb_emlrtRSI;
  n = EndP->size[0] * EndP->size[1] * EndP->size[2];
  b_EndP = *EndP;
  e_BPcentroid[0] = n;
  b_EndP.size = &e_BPcentroid[0];
  b_EndP.numDimensions = 1;
  b_st.site = &cd_emlrtRSI;
  eml_find(&b_st, &b_EndP, ii);
  st.site = &fb_emlrtRSI;
  BranchPoint[0] = EndP->size[0];
  BranchPoint[1] = EndP->size[1];
  BranchPoint[2] = EndP->size[2];
  i = LEN->size[0];
  LEN->size[0] = ii->size[0];
  emxEnsureCapacity_real_T(&st, LEN, i, &lb_emlrtRTEI);
  loop_ub = ii->size[0];
  for (i = 0; i < loop_ub; i++) {
    LEN->data[i] = ii->data[i];
  }

  b_st.site = &hd_emlrtRSI;
  ind2sub_indexClass(&b_st, BranchPoint, LEN, varargout_4, ii, varargout_6);
  i = bpx->size[0];
  bpx->size[0] = varargout_4->size[0];
  emxEnsureCapacity_real_T(&st, bpx, i, &mb_emlrtRTEI);
  loop_ub = varargout_4->size[0];
  for (i = 0; i < loop_ub; i++) {
    bpx->data[i] = varargout_4->data[i];
  }

  i = ex->size[0];
  ex->size[0] = ii->size[0];
  emxEnsureCapacity_int32_T(&st, ex, i, &mb_emlrtRTEI);
  loop_ub = ii->size[0];
  for (i = 0; i < loop_ub; i++) {
    ex->data[i] = ii->data[i];
  }

  i = ez->size[0];
  ez->size[0] = varargout_6->size[0];
  emxEnsureCapacity_int32_T(&st, ez, i, &mb_emlrtRTEI);
  loop_ub = varargout_6->size[0];
  for (i = 0; i < loop_ub; i++) {
    ez->data[i] = varargout_6->data[i];
  }

  Pdata_count = 0;
  i = bpx->size[0];
  emxInit_real_T(sp, &Fyxz, 2, &ic_emlrtRTEI, true);
  emxInit_real_T(sp, &p, 2, &jc_emlrtRTEI, true);
  emxInit_real_T(sp, &b_Fyxz, 2, &cc_emlrtRTEI, true);
  for (b_n = 0; b_n < i; b_n++) {
    i1 = b_n + 1;
    if ((i1 < 1) || (i1 > bpx->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, bpx->size[0], &m_emlrtBCI, sp);
    }

    Y = bpx->data[i1 - 1];
    i1 = b_n + 1;
    if ((i1 < 1) || (i1 > ex->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, ex->size[0], &n_emlrtBCI, sp);
    }

    X = ex->data[i1 - 1];
    i1 = b_n + 1;
    if ((i1 < 1) || (i1 > ez->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, ez->size[0], &o_emlrtBCI, sp);
    }

    Z = ez->data[i1 - 1];
    BranchPoint[0] = rtNaN;
    BranchPoint[1] = rtNaN;
    BranchPoint[2] = rtNaN;

    /*  % End point check(End-End�͓�Ԗڂ�EndPoint�������Ă��܂����߁B) */
    i1 = (int32_T)bpx->data[b_n];
    if ((i1 < 1) || (i1 > bwthindata->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, bwthindata->size[0], &p_emlrtBCI, sp);
    }

    if ((ex->data[b_n] < 1) || (ex->data[b_n] > bwthindata->size[1])) {
      emlrtDynamicBoundsCheckR2012b(ex->data[b_n], 1, bwthindata->size[1],
        &p_emlrtBCI, sp);
    }

    if ((ez->data[b_n] < 1) || (ez->data[b_n] > bwthindata->size[2])) {
      emlrtDynamicBoundsCheckR2012b(ez->data[b_n], 1, bwthindata->size[2],
        &p_emlrtBCI, sp);
    }

    if (bwthindata->data[((i1 + bwthindata->size[0] * (ex->data[b_n] - 1)) +
                          bwthindata->size[0] * bwthindata->size[1] * (ez->
          data[b_n] - 1)) - 1]) {
      c = 1U;

      /*      Segment = struct('point',[]); */
      /*      Segment(c).point = double([X Y Z]-1); %% padarray���Ă��邽��-1 */
      SegP[0] = (real_T)ex->data[b_n] - 1.0;
      SegP[2048] = bpx->data[b_n] - 1.0;
      SegP[4096] = (real_T)ez->data[b_n] - 1.0;
      if (i1 > bwthindata->size[0]) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, bwthindata->size[0], &q_emlrtBCI,
          sp);
      }

      if ((ex->data[b_n] < 1) || (ex->data[b_n] > bwthindata->size[1])) {
        emlrtDynamicBoundsCheckR2012b(ex->data[b_n], 1, bwthindata->size[1],
          &q_emlrtBCI, sp);
      }

      if ((ez->data[b_n] < 1) || (ez->data[b_n] > bwthindata->size[2])) {
        emlrtDynamicBoundsCheckR2012b(ez->data[b_n], 1, bwthindata->size[2],
          &q_emlrtBCI, sp);
      }

      bwthindata->data[((i1 + bwthindata->size[0] * (ex->data[b_n] - 1)) +
                        bwthindata->size[0] * bwthindata->size[1] * (ez->
        data[b_n] - 1)) - 1] = false;
      Go2Next = true;
      while (Go2Next) {
        qY = c + 1U;
        if (qY < c) {
          qY = MAX_uint32_T;
        }

        c = qY;
        BPcentroid_ROI_tmp[0] = Y + -1.0;
        b_BPcentroid_ROI_tmp[0] = X + -1.0;
        c_BPcentroid_ROI_tmp[0] = Z + -1.0;
        BPcentroid_ROI_tmp[1] = Y;
        b_BPcentroid_ROI_tmp[1] = X;
        c_BPcentroid_ROI_tmp[1] = Z;
        BPcentroid_ROI_tmp[2] = Y + 1.0;
        b_BPcentroid_ROI_tmp[2] = X + 1.0;
        c_BPcentroid_ROI_tmp[2] = Z + 1.0;
        i1 = (int32_T)(Y + -1.0);
        if ((i1 < 1) || (i1 > BPcentroid->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, BPcentroid->size[0], &jb_emlrtBCI,
            sp);
        }

        i2 = (int32_T)Y;
        if ((i2 < 1) || (i2 > BPcentroid->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, BPcentroid->size[0], &jb_emlrtBCI,
            sp);
        }

        i3 = (int32_T)(Y + 1.0);
        if ((i3 < 1) || (i3 > BPcentroid->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, BPcentroid->size[0], &jb_emlrtBCI,
            sp);
        }

        i4 = (int32_T)(X + -1.0);
        if ((i4 < 1) || (i4 > BPcentroid->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, BPcentroid->size[1], &kb_emlrtBCI,
            sp);
        }

        b_i = (int32_T)X;
        if ((b_i < 1) || (b_i > BPcentroid->size[1])) {
          emlrtDynamicBoundsCheckR2012b(b_i, 1, BPcentroid->size[1],
            &kb_emlrtBCI, sp);
        }

        n = (int32_T)(X + 1.0);
        if ((n < 1) || (n > BPcentroid->size[1])) {
          emlrtDynamicBoundsCheckR2012b(n, 1, BPcentroid->size[1], &kb_emlrtBCI,
            sp);
        }

        i5 = (int32_T)(Z + -1.0);
        if ((i5 < 1) || (i5 > BPcentroid->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, BPcentroid->size[2], &lb_emlrtBCI,
            sp);
        }

        loop_ub = (int32_T)Z;
        if ((loop_ub < 1) || (loop_ub > BPcentroid->size[2])) {
          emlrtDynamicBoundsCheckR2012b(loop_ub, 1, BPcentroid->size[2],
            &lb_emlrtBCI, sp);
        }

        k = (int32_T)(Z + 1.0);
        if ((k < 1) || (k > BPcentroid->size[2])) {
          emlrtDynamicBoundsCheckR2012b(k, 1, BPcentroid->size[2], &lb_emlrtBCI,
            sp);
        }

        if (i1 > BPgroup->size[0]) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, BPgroup->size[0], &mb_emlrtBCI,
            sp);
        }

        if (i2 > BPgroup->size[0]) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, BPgroup->size[0], &mb_emlrtBCI,
            sp);
        }

        if (i3 > BPgroup->size[0]) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, BPgroup->size[0], &mb_emlrtBCI,
            sp);
        }

        if (i4 > BPgroup->size[1]) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, BPgroup->size[1], &nb_emlrtBCI,
            sp);
        }

        if (b_i > BPgroup->size[1]) {
          emlrtDynamicBoundsCheckR2012b(b_i, 1, BPgroup->size[1], &nb_emlrtBCI,
            sp);
        }

        if (n > BPgroup->size[1]) {
          emlrtDynamicBoundsCheckR2012b(n, 1, BPgroup->size[1], &nb_emlrtBCI, sp);
        }

        if (i5 > BPgroup->size[2]) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, BPgroup->size[2], &ob_emlrtBCI,
            sp);
        }

        if (loop_ub > BPgroup->size[2]) {
          emlrtDynamicBoundsCheckR2012b(loop_ub, 1, BPgroup->size[2],
            &ob_emlrtBCI, sp);
        }

        if (k > BPgroup->size[2]) {
          emlrtDynamicBoundsCheckR2012b(k, 1, BPgroup->size[2], &ob_emlrtBCI, sp);
        }

        if ((i2 < 1) || (i2 > bwthindata->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, bwthindata->size[0], &s_emlrtBCI,
            sp);
        }

        if ((b_i < 1) || (b_i > bwthindata->size[1])) {
          emlrtDynamicBoundsCheckR2012b(b_i, 1, bwthindata->size[1], &s_emlrtBCI,
            sp);
        }

        if ((loop_ub < 1) || (loop_ub > bwthindata->size[2])) {
          emlrtDynamicBoundsCheckR2012b(loop_ub, 1, bwthindata->size[2],
            &s_emlrtBCI, sp);
        }

        bwthindata->data[((i2 + bwthindata->size[0] * (b_i - 1)) +
                          bwthindata->size[0] * bwthindata->size[1] * (loop_ub -
          1)) - 1] = false;
        if (i1 > bwthindata->size[0]) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, bwthindata->size[0], &pb_emlrtBCI,
            sp);
        }

        if (i2 > bwthindata->size[0]) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, bwthindata->size[0], &pb_emlrtBCI,
            sp);
        }

        if (i3 > bwthindata->size[0]) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, bwthindata->size[0], &pb_emlrtBCI,
            sp);
        }

        if (i4 > bwthindata->size[1]) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, bwthindata->size[1], &qb_emlrtBCI,
            sp);
        }

        if (b_i > bwthindata->size[1]) {
          emlrtDynamicBoundsCheckR2012b(b_i, 1, bwthindata->size[1],
            &qb_emlrtBCI, sp);
        }

        if (n > bwthindata->size[1]) {
          emlrtDynamicBoundsCheckR2012b(n, 1, bwthindata->size[1], &qb_emlrtBCI,
            sp);
        }

        if (i5 > bwthindata->size[2]) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, bwthindata->size[2], &rb_emlrtBCI,
            sp);
        }

        if (loop_ub > bwthindata->size[2]) {
          emlrtDynamicBoundsCheckR2012b(loop_ub, 1, bwthindata->size[2],
            &rb_emlrtBCI, sp);
        }

        if (k > bwthindata->size[2]) {
          emlrtDynamicBoundsCheckR2012b(k, 1, bwthindata->size[2], &rb_emlrtBCI,
            sp);
        }

        lenp[0] = Y;
        lenp[1] = X;
        lenp[2] = Z;
        maxval_tmp = i1 - 1;
        n = i4 - 1;
        b_i = i5 - 1;
        maxval = BPcentroid->data[(maxval_tmp + BPcentroid->size[0] * n) +
          BPcentroid->size[0] * BPcentroid->size[1] * b_i];
        for (k = 0; k < 26; k++) {
          b = BPcentroid->data[(((int32_T)BPcentroid_ROI_tmp[(k + 1) % 3] +
            BPcentroid->size[0] * ((int32_T)b_BPcentroid_ROI_tmp[(k + 1) / 3 % 3]
            - 1)) + BPcentroid->size[0] * BPcentroid->size[1] * ((int32_T)
            c_BPcentroid_ROI_tmp[(k + 1) / 9] - 1)) - 1];
          maxval = (((int32_T)maxval < (int32_T)b) || maxval);
        }

        if (maxval) {
          st.site = &eb_emlrtRSI;
          for (i1 = 0; i1 < 3; i1++) {
            b_i = (int32_T)c_BPcentroid_ROI_tmp[i1] - 1;
            for (i4 = 0; i4 < 3; i4++) {
              n = (int32_T)b_BPcentroid_ROI_tmp[i4] - 1;
              loop_ub = 3 * i4 + 9 * i1;
              c_bwthindata[loop_ub] = BPcentroid->data[(maxval_tmp +
                BPcentroid->size[0] * n) + BPcentroid->size[0] *
                BPcentroid->size[1] * b_i];
              c_bwthindata[loop_ub + 1] = BPcentroid->data[((i2 +
                BPcentroid->size[0] * n) + BPcentroid->size[0] *
                BPcentroid->size[1] * b_i) - 1];
              c_bwthindata[loop_ub + 2] = BPcentroid->data[((i3 +
                BPcentroid->size[0] * n) + BPcentroid->size[0] *
                BPcentroid->size[1] * b_i) - 1];
            }
          }

          b_st.site = &cd_emlrtRSI;
          b_eml_find(&b_st, c_bwthindata, ii_data, ii_size);
          st.site = &eb_emlrtRSI;
          b_ii_size[0] = ii_size[0];
          loop_ub = ii_size[0];
          for (i1 = 0; i1 < loop_ub; i1++) {
            b_ii_data[i1] = ii_data[i1];
          }

          c_ii_size[0] = b_ii_size[0];
          b_st.site = &hd_emlrtRSI;
          b_ind2sub_indexClass(&b_st, b_ii_data, c_ii_size, ii_data, ii_size,
                               varargout_5_data, varargout_5_size,
                               varargout_6_data, varargout_6_size);
          b_ii_size[0] = ii_size[0];
          loop_ub = ii_size[0];
          for (i1 = 0; i1 < loop_ub; i1++) {
            b_ii_data[i1] = ((real_T)ii_data[i1] + Y) - 2.0;
          }

          b_varargout_5_size[0] = varargout_5_size[0];
          loop_ub = varargout_5_size[0];
          for (i1 = 0; i1 < loop_ub; i1++) {
            b_varargout_5_data[i1] = ((real_T)varargout_5_data[i1] + X) - 2.0;
          }

          b_varargout_6_size[0] = varargout_6_size[0];
          loop_ub = varargout_6_size[0];
          for (i1 = 0; i1 < loop_ub; i1++) {
            b_varargout_6_data[i1] = ((real_T)varargout_6_data[i1] + Z) - 2.0;
          }

          c_ii_data.data = &b_ii_data[0];
          c_ii_data.size = &b_ii_size[0];
          c_ii_data.allocatedSize = 27;
          c_ii_data.numDimensions = 1;
          c_ii_data.canFreeData = false;
          c_varargout_5_data.data = &b_varargout_5_data[0];
          c_varargout_5_data.size = &b_varargout_5_size[0];
          c_varargout_5_data.allocatedSize = 27;
          c_varargout_5_data.numDimensions = 1;
          c_varargout_5_data.canFreeData = false;
          c_varargout_6_data.data = &b_varargout_6_data[0];
          c_varargout_6_data.size = &b_varargout_6_size[0];
          c_varargout_6_data.allocatedSize = 27;
          c_varargout_6_data.numDimensions = 1;
          c_varargout_6_data.canFreeData = false;
          st.site = &db_emlrtRSI;
          b_cat(&st, &c_ii_data, &c_varargout_5_data, &c_varargout_6_data, p);
          C_size[0] = p->size[0];
          C_size[1] = 3;
          loop_ub = p->size[0] * p->size[1];
          for (i1 = 0; i1 < loop_ub; i1++) {
            C_data[i1] = p->data[i1];
          }

          C[0] = C_size[0];
          C[1] = 1.0;
          st.site = &cb_emlrtRSI;
          b_repmat(&st, lenp, C, p);
          lenp_size[0] = p->size[0];
          lenp_size[1] = 3;
          loop_ub = p->size[0] * p->size[1];
          for (i1 = 0; i1 < loop_ub; i1++) {
            lenp_data[i1] = p->data[i1];
          }

          emlrtSizeEqCheckNDR2012b(C_size, lenp_size, &c_emlrtECI, sp);
          b_C_size[0] = C_size[0];
          b_C_size[1] = 3;
          loop_ub = C_size[0] * 3;
          for (i1 = 0; i1 < loop_ub; i1++) {
            c_C_data[i1] = C_data[i1] - lenp_data[i1];
          }

          b_C_data.data = &c_C_data[0];
          b_C_data.size = &b_C_size[0];
          b_C_data.allocatedSize = 81;
          b_C_data.numDimensions = 2;
          b_C_data.canFreeData = false;
          st.site = &bb_emlrtRSI;
          power(&st, &b_C_data, p);
          st.site = &bb_emlrtRSI;
          g_sum(&st, p, LEN);
          st.site = &ab_emlrtRSI;
          b_st.site = &rf_emlrtRSI;
          c_st.site = &sf_emlrtRSI;
          d_st.site = &tf_emlrtRSI;
          if (LEN->size[0] < 1) {
            emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
              "Coder:toolbox:eml_min_or_max_varDimZero",
              "Coder:toolbox:eml_min_or_max_varDimZero", 0);
          }

          e_st.site = &uf_emlrtRSI;
          n = LEN->size[0];
          if (LEN->size[0] <= 2) {
            if (LEN->size[0] == 1) {
              b_i = 1;
            } else if ((LEN->data[0] > LEN->data[1]) || (muDoubleScalarIsNaN
                        (LEN->data[0]) && (!muDoubleScalarIsNaN(LEN->data[1]))))
            {
              b_i = 2;
            } else {
              b_i = 1;
            }
          } else {
            f_st.site = &xd_emlrtRSI;
            if (!muDoubleScalarIsNaN(LEN->data[0])) {
              b_i = 1;
            } else {
              b_i = 0;
              g_st.site = &yd_emlrtRSI;
              if (LEN->size[0] > 2147483646) {
                h_st.site = &i_emlrtRSI;
                check_forloop_overflow_error(&h_st);
              }

              k = 2;
              exitg1 = false;
              while ((!exitg1) && (k <= LEN->size[0])) {
                if (!muDoubleScalarIsNaN(LEN->data[k - 1])) {
                  b_i = k;
                  exitg1 = true;
                } else {
                  k++;
                }
              }
            }

            if (b_i == 0) {
              b_i = 1;
            } else {
              f_st.site = &vd_emlrtRSI;
              Y = LEN->data[b_i - 1];
              loop_ub = b_i + 1;
              g_st.site = &wd_emlrtRSI;
              if ((b_i + 1 <= LEN->size[0]) && (LEN->size[0] > 2147483646)) {
                h_st.site = &i_emlrtRSI;
                check_forloop_overflow_error(&h_st);
              }

              for (k = loop_ub; k <= n; k++) {
                X = LEN->data[k - 1];
                if (Y > X) {
                  Y = X;
                  b_i = k;
                }
              }
            }
          }

          if ((b_i < 1) || (b_i > C_size[0])) {
            emlrtDynamicBoundsCheckR2012b(b_i, 1, C_size[0], &t_emlrtBCI, sp);
          }

          X = C_data[(b_i + C_size[0]) - 1];
          if (b_i > C_size[0]) {
            emlrtDynamicBoundsCheckR2012b(b_i, 1, C_size[0], &u_emlrtBCI, sp);
          }

          Y = C_data[b_i - 1];
          if (b_i > C_size[0]) {
            emlrtDynamicBoundsCheckR2012b(b_i, 1, C_size[0], &v_emlrtBCI, sp);
          }

          Z = C_data[(b_i + C_size[0] * 2) - 1];

          /*              Segment(c).point = double([X Y Z]-1); */
          BranchPoint[0] = X - 1.0;
          BranchPoint[1] = Y - 1.0;
          BranchPoint[2] = Z - 1.0;
          if (((int32_T)qY < 1) || ((int32_T)qY > 2048)) {
            emlrtDynamicBoundsCheckR2012b((int32_T)qY, 1, 2048, &emlrtBCI, sp);
          }

          SegP[(int32_T)qY - 1] = X - 1.0;
          SegP[(int32_T)qY + 2047] = Y - 1.0;
          SegP[(int32_T)qY + 4095] = Z - 1.0;

          /* clear  Ind LEN Lnum BPCy BPCx BPCz BPC                         */
          /*              TYPE = 'End to Branch'; */
          TYPEnum = 1;
          Go2Next = false;
        } else {
          maxval = BPgroup->data[(maxval_tmp + BPgroup->size[0] * n) +
            BPgroup->size[0] * BPgroup->size[1] * b_i];
          for (k = 0; k < 26; k++) {
            b = BPgroup->data[(((int32_T)BPcentroid_ROI_tmp[(k + 1) % 3] +
                                BPgroup->size[0] * ((int32_T)
              b_BPcentroid_ROI_tmp[(k + 1) / 3 % 3] - 1)) + BPgroup->size[0] *
                               BPgroup->size[1] * ((int32_T)
              c_BPcentroid_ROI_tmp[(k + 1) / 9] - 1)) - 1];
            maxval = (((int32_T)maxval < (int32_T)b) || maxval);
          }

          if (maxval) {
            st.site = &y_emlrtRSI;
            for (i1 = 0; i1 < 3; i1++) {
              b_i = (int32_T)c_BPcentroid_ROI_tmp[i1] - 1;
              for (i4 = 0; i4 < 3; i4++) {
                n = (int32_T)b_BPcentroid_ROI_tmp[i4] - 1;
                loop_ub = 3 * i4 + 9 * i1;
                c_bwthindata[loop_ub] = BPgroup->data[(maxval_tmp +
                  BPgroup->size[0] * n) + BPgroup->size[0] * BPgroup->size[1] *
                  b_i];
                c_bwthindata[loop_ub + 1] = BPgroup->data[((i2 + BPgroup->size[0]
                  * n) + BPgroup->size[0] * BPgroup->size[1] * b_i) - 1];
                c_bwthindata[loop_ub + 2] = BPgroup->data[((i3 + BPgroup->size[0]
                  * n) + BPgroup->size[0] * BPgroup->size[1] * b_i) - 1];
              }
            }

            b_st.site = &cd_emlrtRSI;
            b_eml_find(&b_st, c_bwthindata, ii_data, ii_size);
            st.site = &y_emlrtRSI;
            b_ii_size[0] = ii_size[0];
            loop_ub = ii_size[0];
            for (i1 = 0; i1 < loop_ub; i1++) {
              b_ii_data[i1] = ii_data[i1];
            }

            c_ii_size[0] = b_ii_size[0];
            b_st.site = &hd_emlrtRSI;
            b_ind2sub_indexClass(&b_st, b_ii_data, c_ii_size, ii_data, ii_size,
                                 varargout_5_data, varargout_5_size,
                                 varargout_6_data, varargout_6_size);
            b_ii_size[0] = ii_size[0];
            loop_ub = ii_size[0];
            for (i1 = 0; i1 < loop_ub; i1++) {
              b_ii_data[i1] = ((real_T)ii_data[i1] + Y) - 2.0;
            }

            b_varargout_5_size[0] = varargout_5_size[0];
            loop_ub = varargout_5_size[0];
            for (i1 = 0; i1 < loop_ub; i1++) {
              b_varargout_5_data[i1] = ((real_T)varargout_5_data[i1] + X) - 2.0;
            }

            b_varargout_6_size[0] = varargout_6_size[0];
            loop_ub = varargout_6_size[0];
            for (i1 = 0; i1 < loop_ub; i1++) {
              b_varargout_6_data[i1] = ((real_T)varargout_6_data[i1] + Z) - 2.0;
            }

            d_ii_data.data = &b_ii_data[0];
            d_ii_data.size = &b_ii_size[0];
            d_ii_data.allocatedSize = 27;
            d_ii_data.numDimensions = 1;
            d_ii_data.canFreeData = false;
            d_varargout_5_data.data = &b_varargout_5_data[0];
            d_varargout_5_data.size = &b_varargout_5_size[0];
            d_varargout_5_data.allocatedSize = 27;
            d_varargout_5_data.numDimensions = 1;
            d_varargout_5_data.canFreeData = false;
            d_varargout_6_data.data = &b_varargout_6_data[0];
            d_varargout_6_data.size = &b_varargout_6_size[0];
            d_varargout_6_data.allocatedSize = 27;
            d_varargout_6_data.numDimensions = 1;
            d_varargout_6_data.canFreeData = false;
            st.site = &x_emlrtRSI;
            b_cat(&st, &d_ii_data, &d_varargout_5_data, &d_varargout_6_data, p);
            C_size[0] = p->size[0];
            C_size[1] = 3;
            loop_ub = p->size[0] * p->size[1];
            for (i1 = 0; i1 < loop_ub; i1++) {
              C_data[i1] = p->data[i1];
            }

            C[0] = C_size[0];
            C[1] = 1.0;
            st.site = &w_emlrtRSI;
            b_repmat(&st, lenp, C, p);
            lenp_size[0] = p->size[0];
            lenp_size[1] = 3;
            loop_ub = p->size[0] * p->size[1];
            for (i1 = 0; i1 < loop_ub; i1++) {
              lenp_data[i1] = p->data[i1];
            }

            emlrtSizeEqCheckNDR2012b(C_size, lenp_size, &d_emlrtECI, sp);
            b_C_size[0] = C_size[0];
            b_C_size[1] = 3;
            loop_ub = C_size[0] * 3;
            for (i1 = 0; i1 < loop_ub; i1++) {
              c_C_data[i1] = C_data[i1] - lenp_data[i1];
            }

            d_C_data.data = &c_C_data[0];
            d_C_data.size = &b_C_size[0];
            d_C_data.allocatedSize = 81;
            d_C_data.numDimensions = 2;
            d_C_data.canFreeData = false;
            st.site = &v_emlrtRSI;
            power(&st, &d_C_data, p);
            st.site = &v_emlrtRSI;
            g_sum(&st, p, LEN);
            st.site = &u_emlrtRSI;
            b_st.site = &rf_emlrtRSI;
            c_st.site = &sf_emlrtRSI;
            d_st.site = &tf_emlrtRSI;
            if (LEN->size[0] < 1) {
              emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
                "Coder:toolbox:eml_min_or_max_varDimZero",
                "Coder:toolbox:eml_min_or_max_varDimZero", 0);
            }

            e_st.site = &uf_emlrtRSI;
            n = LEN->size[0];
            if (LEN->size[0] <= 2) {
              if (LEN->size[0] == 1) {
                b_i = 1;
              } else if ((LEN->data[0] > LEN->data[1]) || (muDoubleScalarIsNaN
                          (LEN->data[0]) && (!muDoubleScalarIsNaN(LEN->data[1]))))
              {
                b_i = 2;
              } else {
                b_i = 1;
              }
            } else {
              f_st.site = &xd_emlrtRSI;
              if (!muDoubleScalarIsNaN(LEN->data[0])) {
                b_i = 1;
              } else {
                b_i = 0;
                g_st.site = &yd_emlrtRSI;
                if (LEN->size[0] > 2147483646) {
                  h_st.site = &i_emlrtRSI;
                  check_forloop_overflow_error(&h_st);
                }

                k = 2;
                exitg1 = false;
                while ((!exitg1) && (k <= LEN->size[0])) {
                  if (!muDoubleScalarIsNaN(LEN->data[k - 1])) {
                    b_i = k;
                    exitg1 = true;
                  } else {
                    k++;
                  }
                }
              }

              if (b_i == 0) {
                b_i = 1;
              } else {
                f_st.site = &vd_emlrtRSI;
                Y = LEN->data[b_i - 1];
                loop_ub = b_i + 1;
                g_st.site = &wd_emlrtRSI;
                if ((b_i + 1 <= LEN->size[0]) && (LEN->size[0] > 2147483646)) {
                  h_st.site = &i_emlrtRSI;
                  check_forloop_overflow_error(&h_st);
                }

                for (k = loop_ub; k <= n; k++) {
                  X = LEN->data[k - 1];
                  if (Y > X) {
                    Y = X;
                    b_i = k;
                  }
                }
              }
            }

            if ((b_i < 1) || (b_i > C_size[0])) {
              emlrtDynamicBoundsCheckR2012b(b_i, 1, C_size[0], &w_emlrtBCI, sp);
            }

            X = C_data[(b_i + C_size[0]) - 1];
            if (b_i > C_size[0]) {
              emlrtDynamicBoundsCheckR2012b(b_i, 1, C_size[0], &x_emlrtBCI, sp);
            }

            Y = C_data[b_i - 1];
            if (b_i > C_size[0]) {
              emlrtDynamicBoundsCheckR2012b(b_i, 1, C_size[0], &y_emlrtBCI, sp);
            }

            Z = C_data[(b_i + C_size[0] * 2) - 1];

            /*              Segment(c).point = double([X Y Z]-1); */
            if (((int32_T)qY < 1) || ((int32_T)qY > 2048)) {
              emlrtDynamicBoundsCheckR2012b((int32_T)qY, 1, 2048, &b_emlrtBCI,
                sp);
            }

            SegP[(int32_T)qY - 1] = X - 1.0;
            SegP[(int32_T)qY + 2047] = Y - 1.0;
            SegP[(int32_T)qY + 4095] = Z - 1.0;
            c = qY + 1U;
            i1 = (int32_T)Y;
            if ((i1 < 1) || (i1 > L_BPgroup->size[0])) {
              emlrtDynamicBoundsCheckR2012b(i1, 1, L_BPgroup->size[0],
                &cb_emlrtBCI, sp);
            }

            i2 = (int32_T)X;
            if ((i2 < 1) || (i2 > L_BPgroup->size[1])) {
              emlrtDynamicBoundsCheckR2012b(i2, 1, L_BPgroup->size[1],
                &cb_emlrtBCI, sp);
            }

            i3 = (int32_T)Z;
            if ((i3 < 1) || (i3 > L_BPgroup->size[2])) {
              emlrtDynamicBoundsCheckR2012b(i3, 1, L_BPgroup->size[2],
                &cb_emlrtBCI, sp);
            }

            Lnum = L_BPgroup->data[((i1 + L_BPgroup->size[0] * (i2 - 1)) +
              L_BPgroup->size[0] * L_BPgroup->size[1] * (i3 - 1)) - 1];
            i1 = FindNearestBP->size[0] * FindNearestBP->size[1] *
              FindNearestBP->size[2];
            FindNearestBP->size[0] = L_BPgroup->size[0];
            FindNearestBP->size[1] = L_BPgroup->size[1];
            FindNearestBP->size[2] = L_BPgroup->size[2];
            emxEnsureCapacity_boolean_T(sp, FindNearestBP, i1, &ac_emlrtRTEI);
            loop_ub = L_BPgroup->size[0] * L_BPgroup->size[1] * L_BPgroup->size
              [2];
            for (i1 = 0; i1 < loop_ub; i1++) {
              FindNearestBP->data[i1] = (L_BPgroup->data[i1] == Lnum);
            }

            emlrtSizeEqCheckNDR2012b(*(int32_T (*)[3])BPcentroid->size,
              *(int32_T (*)[3])FindNearestBP->size, &e_emlrtECI, sp);
            loop_ub = BPcentroid->size[0] * BPcentroid->size[1] *
              BPcentroid->size[2];
            i1 = FindNearestBP->size[0] * FindNearestBP->size[1] *
              FindNearestBP->size[2];
            FindNearestBP->size[0] = BPcentroid->size[0];
            FindNearestBP->size[1] = BPcentroid->size[1];
            FindNearestBP->size[2] = BPcentroid->size[2];
            emxEnsureCapacity_boolean_T(sp, FindNearestBP, i1, &bc_emlrtRTEI);
            for (i1 = 0; i1 < loop_ub; i1++) {
              FindNearestBP->data[i1] = (BPcentroid->data[i1] &&
                FindNearestBP->data[i1]);
            }

            st.site = &t_emlrtRSI;
            n = FindNearestBP->size[0] * FindNearestBP->size[1] *
              FindNearestBP->size[2];
            b_EndP = *FindNearestBP;
            f_BPcentroid[0] = n;
            b_EndP.size = &f_BPcentroid[0];
            b_EndP.numDimensions = 1;
            b_st.site = &cd_emlrtRSI;
            eml_find(&b_st, &b_EndP, ii);
            st.site = &t_emlrtRSI;
            BranchPoint[0] = FindNearestBP->size[0];
            BranchPoint[1] = FindNearestBP->size[1];
            BranchPoint[2] = FindNearestBP->size[2];
            i1 = LEN->size[0];
            LEN->size[0] = ii->size[0];
            emxEnsureCapacity_real_T(&st, LEN, i1, &lb_emlrtRTEI);
            loop_ub = ii->size[0];
            for (i1 = 0; i1 < loop_ub; i1++) {
              LEN->data[i1] = ii->data[i1];
            }

            b_st.site = &hd_emlrtRSI;
            ind2sub_indexClass(&b_st, BranchPoint, LEN, varargout_4, ii,
                               varargout_6);
            i1 = b_varargout_4->size[0];
            b_varargout_4->size[0] = varargout_4->size[0];
            emxEnsureCapacity_real_T(sp, b_varargout_4, i1, &nb_emlrtRTEI);
            loop_ub = varargout_4->size[0];
            for (i1 = 0; i1 < loop_ub; i1++) {
              b_varargout_4->data[i1] = varargout_4->data[i1];
            }

            i1 = LEN->size[0];
            LEN->size[0] = ii->size[0];
            emxEnsureCapacity_real_T(sp, LEN, i1, &nb_emlrtRTEI);
            loop_ub = ii->size[0];
            for (i1 = 0; i1 < loop_ub; i1++) {
              LEN->data[i1] = ii->data[i1];
            }

            i1 = b_varargout_6->size[0];
            b_varargout_6->size[0] = varargout_6->size[0];
            emxEnsureCapacity_real_T(sp, b_varargout_6, i1, &nb_emlrtRTEI);
            loop_ub = varargout_6->size[0];
            for (i1 = 0; i1 < loop_ub; i1++) {
              b_varargout_6->data[i1] = varargout_6->data[i1];
            }

            st.site = &s_emlrtRSI;
            b_cat(&st, b_varargout_4, LEN, b_varargout_6, Fyxz);

            /*              try */
            BranchPoint[0] = Y;
            BranchPoint[1] = X;
            BranchPoint[2] = Z;
            C[0] = (real_T)Fyxz->size[0] - 1.0;
            C[1] = 0.0;
            st.site = &r_emlrtRSI;
            b_padarray(&st, BranchPoint, C, p);

            /*                  p = repmat([Y X Z],[size(Fyxz,1) 1]); */
            /*              catch err */
            /*                  warning(err.message) */
            /*                  disp(['*****Current Pointdata Number is ' num2str(Pdata_count) '*****']) */
            /*                  disp('   1.1---> Find Nearest Branch Point(centroid)') */
            /*                  disp('**********************************************') */
            /*                  [Fy,Fx,Fz] = ind2sub(size(BPcentroid),find(BPcentroid(:))); */
            /*                  Fyxz = cat(2,Fy,Fx,Fz); */
            /*                  p = repmat([Y X Z],[size(Fyxz,1) 1]);                 */
            /*              end */
            emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])Fyxz->size, *(int32_T (*)
              [2])p->size, &f_emlrtECI, sp);
            i1 = b_Fyxz->size[0] * b_Fyxz->size[1];
            b_Fyxz->size[0] = Fyxz->size[0];
            b_Fyxz->size[1] = 3;
            emxEnsureCapacity_real_T(sp, b_Fyxz, i1, &cc_emlrtRTEI);
            loop_ub = Fyxz->size[0] * Fyxz->size[1];
            for (i1 = 0; i1 < loop_ub; i1++) {
              b_Fyxz->data[i1] = Fyxz->data[i1] - p->data[i1];
            }

            st.site = &q_emlrtRSI;
            power(&st, b_Fyxz, p);
            st.site = &q_emlrtRSI;
            g_sum(&st, p, LEN);
            st.site = &p_emlrtRSI;
            b_st.site = &rf_emlrtRSI;
            c_st.site = &sf_emlrtRSI;
            d_st.site = &tf_emlrtRSI;
            if (LEN->size[0] < 1) {
              emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
                "Coder:toolbox:eml_min_or_max_varDimZero",
                "Coder:toolbox:eml_min_or_max_varDimZero", 0);
            }

            e_st.site = &uf_emlrtRSI;
            n = LEN->size[0];
            if (LEN->size[0] <= 2) {
              if (LEN->size[0] == 1) {
                b_i = 1;
              } else if ((LEN->data[0] > LEN->data[1]) || (muDoubleScalarIsNaN
                          (LEN->data[0]) && (!muDoubleScalarIsNaN(LEN->data[1]))))
              {
                b_i = 2;
              } else {
                b_i = 1;
              }
            } else {
              f_st.site = &xd_emlrtRSI;
              if (!muDoubleScalarIsNaN(LEN->data[0])) {
                b_i = 1;
              } else {
                b_i = 0;
                g_st.site = &yd_emlrtRSI;
                if (LEN->size[0] > 2147483646) {
                  h_st.site = &i_emlrtRSI;
                  check_forloop_overflow_error(&h_st);
                }

                k = 2;
                exitg1 = false;
                while ((!exitg1) && (k <= LEN->size[0])) {
                  if (!muDoubleScalarIsNaN(LEN->data[k - 1])) {
                    b_i = k;
                    exitg1 = true;
                  } else {
                    k++;
                  }
                }
              }

              if (b_i == 0) {
                b_i = 1;
              } else {
                f_st.site = &vd_emlrtRSI;
                Y = LEN->data[b_i - 1];
                loop_ub = b_i + 1;
                g_st.site = &wd_emlrtRSI;
                if ((b_i + 1 <= LEN->size[0]) && (LEN->size[0] > 2147483646)) {
                  h_st.site = &i_emlrtRSI;
                  check_forloop_overflow_error(&h_st);
                }

                for (k = loop_ub; k <= n; k++) {
                  X = LEN->data[k - 1];
                  if (Y > X) {
                    Y = X;
                    b_i = k;
                  }
                }
              }
            }

            if ((b_i < 1) || (b_i > Fyxz->size[0])) {
              emlrtDynamicBoundsCheckR2012b(b_i, 1, Fyxz->size[0], &gb_emlrtBCI,
                sp);
            }

            X = Fyxz->data[(b_i + Fyxz->size[0]) - 1];
            if (b_i > Fyxz->size[0]) {
              emlrtDynamicBoundsCheckR2012b(b_i, 1, Fyxz->size[0], &hb_emlrtBCI,
                sp);
            }

            Y = Fyxz->data[b_i - 1];
            if (b_i > Fyxz->size[0]) {
              emlrtDynamicBoundsCheckR2012b(b_i, 1, Fyxz->size[0], &ib_emlrtBCI,
                sp);
            }

            Z = Fyxz->data[(b_i + Fyxz->size[0] * 2) - 1];

            /*              Segment(c).point = double([X Y Z]-1); */
            BranchPoint[0] = X - 1.0;
            BranchPoint[1] = Y - 1.0;
            BranchPoint[2] = Z - 1.0;
            if (((int32_T)c < 1) || ((int32_T)c > 2048)) {
              emlrtDynamicBoundsCheckR2012b((int32_T)c, 1, 2048, &c_emlrtBCI, sp);
            }

            SegP[(int32_T)c - 1] = X - 1.0;
            SegP[(int32_T)c + 2047] = Y - 1.0;
            SegP[(int32_T)c + 4095] = Z - 1.0;

            /* clear  Fyxz Ind LEN p Fy Fx Fz FindNearestBP Lnum BPGy BPGx BPGz BPG */
            /*              TYPE = 'End to Branch'; */
            TYPEnum = 1;
            Go2Next = false;
          } else {
            maxval = bwthindata->data[(maxval_tmp + bwthindata->size[0] * n) +
              bwthindata->size[0] * bwthindata->size[1] * b_i];
            for (k = 0; k < 26; k++) {
              b = bwthindata->data[(((int32_T)BPcentroid_ROI_tmp[(k + 1) % 3] +
                bwthindata->size[0] * ((int32_T)b_BPcentroid_ROI_tmp[(k + 1) / 3
                % 3] - 1)) + bwthindata->size[0] * bwthindata->size[1] *
                                    ((int32_T)c_BPcentroid_ROI_tmp[(k + 1) / 9]
                - 1)) - 1];
              maxval = (((int32_T)maxval < (int32_T)b) || maxval);
            }

            if (!maxval) {
              /*              TYPE = 'End to End'; */
              TYPEnum = 5;
              Go2Next = false;
            } else {
              st.site = &o_emlrtRSI;
              for (i1 = 0; i1 < 3; i1++) {
                b_i = (int32_T)c_BPcentroid_ROI_tmp[i1] - 1;
                for (i4 = 0; i4 < 3; i4++) {
                  n = (int32_T)b_BPcentroid_ROI_tmp[i4] - 1;
                  loop_ub = 3 * i4 + 9 * i1;
                  c_bwthindata[loop_ub] = bwthindata->data[(maxval_tmp +
                    bwthindata->size[0] * n) + bwthindata->size[0] *
                    bwthindata->size[1] * b_i];
                  c_bwthindata[loop_ub + 1] = bwthindata->data[((i2 +
                    bwthindata->size[0] * n) + bwthindata->size[0] *
                    bwthindata->size[1] * b_i) - 1];
                  c_bwthindata[loop_ub + 2] = bwthindata->data[((i3 +
                    bwthindata->size[0] * n) + bwthindata->size[0] *
                    bwthindata->size[1] * b_i) - 1];
                }
              }

              b_st.site = &cd_emlrtRSI;
              b_eml_find(&b_st, c_bwthindata, ii_data, ii_size);
              st.site = &o_emlrtRSI;
              b_ii_size[0] = ii_size[0];
              loop_ub = ii_size[0];
              for (i1 = 0; i1 < loop_ub; i1++) {
                b_ii_data[i1] = ii_data[i1];
              }

              c_ii_size[0] = b_ii_size[0];
              b_st.site = &hd_emlrtRSI;
              b_ind2sub_indexClass(&b_st, b_ii_data, c_ii_size, ii_data, ii_size,
                                   varargout_5_data, varargout_5_size,
                                   varargout_6_data, varargout_6_size);
              b_ii_size[0] = ii_size[0];
              loop_ub = ii_size[0];
              for (i1 = 0; i1 < loop_ub; i1++) {
                b_ii_data[i1] = ((real_T)ii_data[i1] + Y) - 2.0;
              }

              b_varargout_5_size[0] = varargout_5_size[0];
              loop_ub = varargout_5_size[0];
              for (i1 = 0; i1 < loop_ub; i1++) {
                b_varargout_5_data[i1] = ((real_T)varargout_5_data[i1] + X) -
                  2.0;
              }

              b_varargout_6_size[0] = varargout_6_size[0];
              loop_ub = varargout_6_size[0];
              for (i1 = 0; i1 < loop_ub; i1++) {
                b_varargout_6_data[i1] = ((real_T)varargout_6_data[i1] + Z) -
                  2.0;
              }

              e_ii_data.data = &b_ii_data[0];
              e_ii_data.size = &b_ii_size[0];
              e_ii_data.allocatedSize = 27;
              e_ii_data.numDimensions = 1;
              e_ii_data.canFreeData = false;
              e_varargout_5_data.data = &b_varargout_5_data[0];
              e_varargout_5_data.size = &b_varargout_5_size[0];
              e_varargout_5_data.allocatedSize = 27;
              e_varargout_5_data.numDimensions = 1;
              e_varargout_5_data.canFreeData = false;
              e_varargout_6_data.data = &b_varargout_6_data[0];
              e_varargout_6_data.size = &b_varargout_6_size[0];
              e_varargout_6_data.allocatedSize = 27;
              e_varargout_6_data.numDimensions = 1;
              e_varargout_6_data.canFreeData = false;
              st.site = &n_emlrtRSI;
              b_cat(&st, &e_ii_data, &e_varargout_5_data, &e_varargout_6_data, p);
              C_size[0] = p->size[0];
              C_size[1] = 3;
              loop_ub = p->size[0] * p->size[1];
              for (i1 = 0; i1 < loop_ub; i1++) {
                C_data[i1] = p->data[i1];
              }

              C[0] = C_size[0];
              C[1] = 1.0;
              st.site = &m_emlrtRSI;
              b_repmat(&st, lenp, C, p);
              lenp_size[0] = p->size[0];
              lenp_size[1] = 3;
              loop_ub = p->size[0] * p->size[1];
              for (i1 = 0; i1 < loop_ub; i1++) {
                lenp_data[i1] = p->data[i1];
              }

              emlrtSizeEqCheckNDR2012b(C_size, lenp_size, &g_emlrtECI, sp);
              b_C_size[0] = C_size[0];
              b_C_size[1] = 3;
              loop_ub = C_size[0] * 3;
              for (i1 = 0; i1 < loop_ub; i1++) {
                c_C_data[i1] = C_data[i1] - lenp_data[i1];
              }

              e_C_data.data = &c_C_data[0];
              e_C_data.size = &b_C_size[0];
              e_C_data.allocatedSize = 81;
              e_C_data.numDimensions = 2;
              e_C_data.canFreeData = false;
              st.site = &l_emlrtRSI;
              power(&st, &e_C_data, p);
              st.site = &l_emlrtRSI;
              g_sum(&st, p, LEN);
              st.site = &k_emlrtRSI;
              b_st.site = &rf_emlrtRSI;
              c_st.site = &sf_emlrtRSI;
              d_st.site = &tf_emlrtRSI;
              if (LEN->size[0] < 1) {
                emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
                  "Coder:toolbox:eml_min_or_max_varDimZero",
                  "Coder:toolbox:eml_min_or_max_varDimZero", 0);
              }

              e_st.site = &uf_emlrtRSI;
              n = LEN->size[0];
              if (LEN->size[0] <= 2) {
                if (LEN->size[0] == 1) {
                  b_i = 1;
                } else if ((LEN->data[0] > LEN->data[1]) || (muDoubleScalarIsNaN
                            (LEN->data[0]) && (!muDoubleScalarIsNaN(LEN->data[1]))))
                {
                  b_i = 2;
                } else {
                  b_i = 1;
                }
              } else {
                f_st.site = &xd_emlrtRSI;
                if (!muDoubleScalarIsNaN(LEN->data[0])) {
                  b_i = 1;
                } else {
                  b_i = 0;
                  g_st.site = &yd_emlrtRSI;
                  if (LEN->size[0] > 2147483646) {
                    h_st.site = &i_emlrtRSI;
                    check_forloop_overflow_error(&h_st);
                  }

                  k = 2;
                  exitg1 = false;
                  while ((!exitg1) && (k <= LEN->size[0])) {
                    if (!muDoubleScalarIsNaN(LEN->data[k - 1])) {
                      b_i = k;
                      exitg1 = true;
                    } else {
                      k++;
                    }
                  }
                }

                if (b_i == 0) {
                  b_i = 1;
                } else {
                  f_st.site = &vd_emlrtRSI;
                  Y = LEN->data[b_i - 1];
                  loop_ub = b_i + 1;
                  g_st.site = &wd_emlrtRSI;
                  if ((b_i + 1 <= LEN->size[0]) && (LEN->size[0] > 2147483646))
                  {
                    h_st.site = &i_emlrtRSI;
                    check_forloop_overflow_error(&h_st);
                  }

                  for (k = loop_ub; k <= n; k++) {
                    X = LEN->data[k - 1];
                    if (Y > X) {
                      Y = X;
                      b_i = k;
                    }
                  }
                }
              }

              if ((b_i < 1) || (b_i > C_size[0])) {
                emlrtDynamicBoundsCheckR2012b(b_i, 1, C_size[0], &ab_emlrtBCI,
                  sp);
              }

              X = C_data[(b_i + C_size[0]) - 1];
              if (b_i > C_size[0]) {
                emlrtDynamicBoundsCheckR2012b(b_i, 1, C_size[0], &bb_emlrtBCI,
                  sp);
              }

              Y = C_data[b_i - 1];
              if (b_i > C_size[0]) {
                emlrtDynamicBoundsCheckR2012b(b_i, 1, C_size[0], &db_emlrtBCI,
                  sp);
              }

              Z = C_data[(b_i + C_size[0] * 2) - 1];

              /*              Segment(c).point = double([X Y Z]-1); */
              if (((int32_T)qY < 1) || ((int32_T)qY > 2048)) {
                emlrtDynamicBoundsCheckR2012b((int32_T)qY, 1, 2048, &d_emlrtBCI,
                  sp);
              }

              SegP[(int32_T)qY - 1] = X - 1.0;
              SegP[(int32_T)qY + 2047] = Y - 1.0;
              SegP[(int32_T)qY + 4095] = Z - 1.0;
              i1 = (int32_T)Y;
              if ((i1 < 1) || (i1 > bwthindata->size[0])) {
                emlrtDynamicBoundsCheckR2012b(i1, 1, bwthindata->size[0],
                  &eb_emlrtBCI, sp);
              }

              i2 = (int32_T)X;
              if ((i2 < 1) || (i2 > bwthindata->size[1])) {
                emlrtDynamicBoundsCheckR2012b(i2, 1, bwthindata->size[1],
                  &eb_emlrtBCI, sp);
              }

              i3 = (int32_T)Z;
              if ((i3 < 1) || (i3 > bwthindata->size[2])) {
                emlrtDynamicBoundsCheckR2012b(i3, 1, bwthindata->size[2],
                  &eb_emlrtBCI, sp);
              }

              bwthindata->data[((i1 + bwthindata->size[0] * (i2 - 1)) +
                                bwthindata->size[0] * bwthindata->size[1] * (i3
                - 1)) - 1] = false;
              i1 = (int32_T)Y;
              if ((i1 < 1) || (i1 > EndP->size[0])) {
                emlrtDynamicBoundsCheckR2012b(i1, 1, EndP->size[0], &fb_emlrtBCI,
                  sp);
              }

              i2 = (int32_T)X;
              if ((i2 < 1) || (i2 > EndP->size[1])) {
                emlrtDynamicBoundsCheckR2012b(i2, 1, EndP->size[1], &fb_emlrtBCI,
                  sp);
              }

              i3 = (int32_T)Z;
              if ((i3 < 1) || (i3 > EndP->size[2])) {
                emlrtDynamicBoundsCheckR2012b(i3, 1, EndP->size[2], &fb_emlrtBCI,
                  sp);
              }

              if (EndP->data[((i1 + EndP->size[0] * (i2 - 1)) + EndP->size[0] *
                              EndP->size[1] * (i3 - 1)) - 1]) {
                /*                  TYPE = 'End to End'; */
                TYPEnum = 5;
                Go2Next = false;
              }

              /* clear  Ind LEN Lnum Cy Cx Cz C */
            }
          }
        }

        /* clear  leny lenx lenz lenp LEN Index */
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(sp);
        }
      }

      /*      c = length(Segment); */
      /*      Point4Len = zeros(c,3); */
      /*      for ii = 1:c */
      /*          Point4Len(ii,:) = Segment(ii).point(1:3); */
      /*      end */
      /*      Point4Len = cat(1,Segment.point); */
      if (((int32_T)c < 1) || ((int32_T)c > 2048)) {
        emlrtDynamicBoundsCheckR2012b((int32_T)c, 1, 2048, &e_emlrtBCI, sp);
      }

      b_c[0] = (int32_T)c;
      b_c[1] = 3;
      iv[0] = (int32_T)c;
      iv[1] = 3;
      emlrtSubAssignSizeCheckR2012b(&b_c[0], 2, &iv[0], 2, &h_emlrtECI, sp);
      loop_ub = (int32_T)c;
      for (i1 = 0; i1 < 3; i1++) {
        for (i2 = 0; i2 < loop_ub; i2++) {
          i3 = Pdata_count + 1;
          if ((i3 < 1) || (i3 > 32768)) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, 32768, &r_emlrtBCI, sp);
          }

          i4 = i2 + (i1 << 11);
          Output_Pointdata[i3 - 1].PointXYZ[i4] = SegP[i4];
        }
      }

      /*  % Lenght by bilinear */
      for (i1 = 0; i1 < 2048; i1++) {
        x[i1] = !muDoubleScalarIsNaN(SegP[i1]);
      }

      n = x[0];
      for (k = 0; k < 2047; k++) {
        n += x[k + 1];
      }

      if (n == 1) {
        Output_Pointdata[Pdata_count].Length = 0.0;
      } else {
        diff(SegP, dv);
        c_repmat(Reso, dv1);
        for (i1 = 0; i1 < 6141; i1++) {
          dv1[i1] *= dv[i1];
        }

        b_power(dv1, dv);
        st.site = &j_emlrtRSI;
        nansum(&st, dv, dv2);
        st.site = &j_emlrtRSI;
        d_sqrt(&st, dv2);
        Output_Pointdata[Pdata_count].Length = b_nansum(dv2);
      }

      for (i1 = 0; i1 < 6144; i1++) {
        SegP[i1] = rtNaN;
      }

      /*      if strcmpi(TYPE,'End to End') */
      /*          Pdata(Pdata_count).Type = TYPE; */
      /*          Pdata(Pdata_count).Type = .5; */
      /*      elseif strcmpi(TYPE,'End to Branch') */
      /*          Pdata(Pdata_count).Type = 1; */
      /*      end */
      Output_Pointdata[Pdata_count].Type = TYPEnum;
      Output_Pointdata[Pdata_count].Branch[0] = BranchPoint[0];
      Output_Pointdata[Pdata_count].Branch[1] = BranchPoint[1];
      Output_Pointdata[Pdata_count].Branch[2] = BranchPoint[2];
      Pdata_count++;

      /* clear  Segment Y X Z c Go2Next Point4Len LEN_reso */
    }

    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(&b_Fyxz);
  emxFree_real_T(&b_varargout_6);
  emxFree_real_T(&b_varargout_4);
  emxFree_int32_T(&varargout_4);
  emxFree_int32_T(&varargout_6);
  emxFree_int32_T(&ii);
  emxFree_int32_T(&ez);
  emxFree_int32_T(&ex);
  emxFree_real_T(&bpx);
  emxFree_real_T(&p);
  emxFree_real_T(&Fyxz);
  emxFree_boolean_T(&FindNearestBP);
  emxFree_real_T(&LEN);
  emxFree_real_T(&L_BPgroup);
  emxFree_boolean_T(&EndP);
  emxFree_boolean_T(&BPgroup);
  emxFree_boolean_T(&BPcentroid);

  /*  disp(['End Point Num.:' num2str(n) ', Segment(bp-end) NUM.:' num2str(Pdata_count-1)]) */
  /*  Pdata(Pdata_count:end) = []; */
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

static void GetEachLength(const emlrtStack *sp, const real_T xyz1[3], const
  emxArray_real_T *xyz2, const real_T Reso[3], emxArray_real_T *Len_map)
{
  int32_T i;
  int32_T loop_ub;
  emxArray_real_T *b_select;
  emxArray_real_T *r;
  emxArray_real_T *b_xyz2;
  real_T c_xyz2[2];
  emxArray_real_T *LEN;
  int32_T d_xyz2[1];
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  i = Len_map->size[0];
  Len_map->size[0] = xyz2->size[0];
  emxEnsureCapacity_real_T(sp, Len_map, i, &nj_emlrtRTEI);
  loop_ub = xyz2->size[0];
  for (i = 0; i < loop_ub; i++) {
    Len_map->data[i] = 0.0;
  }

  emxInit_real_T(sp, &b_select, 2, &kj_emlrtRTEI, true);
  emxInit_real_T(sp, &r, 2, &mj_emlrtRTEI, true);
  emxInit_real_T(sp, &b_xyz2, 2, &gj_emlrtRTEI, true);
  c_xyz2[0] = xyz2->size[0];
  c_xyz2[1] = 1.0;
  st.site = &en_emlrtRSI;
  b_repmat(&st, xyz1, c_xyz2, b_select);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])xyz2->size, *(int32_T (*)[2])
    b_select->size, &qb_emlrtECI, sp);
  c_xyz2[0] = xyz2->size[0];
  c_xyz2[1] = 1.0;
  st.site = &fn_emlrtRSI;
  b_repmat(&st, Reso, c_xyz2, r);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])xyz2->size, *(int32_T (*)[2])r->size,
    &rb_emlrtECI, sp);
  i = b_xyz2->size[0] * b_xyz2->size[1];
  b_xyz2->size[0] = xyz2->size[0];
  b_xyz2->size[1] = 3;
  emxEnsureCapacity_real_T(sp, b_xyz2, i, &gj_emlrtRTEI);
  loop_ub = xyz2->size[0] * xyz2->size[1];
  for (i = 0; i < loop_ub; i++) {
    b_xyz2->data[i] = (xyz2->data[i] - b_select->data[i]) * r->data[i];
  }

  emxFree_real_T(&b_select);
  emxInit_real_T(sp, &LEN, 1, &lj_emlrtRTEI, true);
  st.site = &gn_emlrtRSI;
  power(&st, b_xyz2, r);
  st.site = &gn_emlrtRSI;
  g_sum(&st, r, LEN);
  st.site = &gn_emlrtRSI;
  b_sqrt(&st, LEN);
  d_xyz2[0] = xyz2->size[0];
  emlrtSubAssignSizeCheckR2012b(&d_xyz2[0], 1, &LEN->size[0], 1, &sb_emlrtECI,
    sp);
  loop_ub = LEN->size[0];
  emxFree_real_T(&b_xyz2);
  emxFree_real_T(&r);
  for (i = 0; i < loop_ub; i++) {
    Len_map->data[i] = LEN->data[i];
  }

  emxFree_real_T(&LEN);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

static void TS_AutoSegment_base(AutoSegmentStackData *SD, const emlrtStack *sp,
  emxArray_boolean_T *bwthindata, const real_T Reso[3], const emxArray_boolean_T
  *AddBP, emxArray_boolean_T *Output_Output, emxArray_boolean_T *Output_AddBP,
  emxArray_boolean_T *Output_Branch, emxArray_boolean_T *Output_BranchGroup,
  emxArray_boolean_T *Output_End, struct1_T Output_Pointdata[32768], real_T
  Output_ResolutionXYZ[3], emxArray_real_T *Output_BPmatrix)
{
  emxArray_boolean_T *OriginalBW;
  int32_T i;
  int32_T loop_ub;
  real_T SegP[6144];
  emxArray_boolean_T *b_bwthindata;
  static const char_T b_cv[36] = { 'A', 'n', 'a', 'l', 'y', 's', 'i', 's', ' ',
    'B', 'r', 'a', 'n', 'c', 'h', '-', 'p', 'o', 'i', 'n', 't', ' ', 'a', 'n',
    'd', ' ', 'E', 'n', 'd', '-', 'p', 'o', 'i', 'n', 't', ' ' };

  emxArray_boolean_T *BPcentroid;
  emxArray_boolean_T *BPgroup;
  emxArray_boolean_T *EndP;
  emxArray_boolean_T *FindNearestBP;
  int32_T end;
  int32_T n;
  emxArray_int32_T *ii;
  int32_T partialTrueCount;
  int32_T i1;
  emxArray_int32_T *varargout_4;
  emxArray_real_T *b_ii;
  int32_T BPcentroid_idx_0;
  emxArray_boolean_T b_BPcentroid;
  int32_T c_BPcentroid[1];
  real_T d_BPcentroid[3];
  emxArray_real_T *lenmap;
  emxArray_int32_T *varargout_6;
  emxArray_real_T *b_varargout_4;
  int32_T e_BPcentroid[1];
  emxArray_real_T *b_varargout_6;
  emxArray_real_T *LEN;
  emxArray_real_T *L_BPgroup;
  emxArray_real32_T *unusedU3;
  emxArray_uint32_T *DistInd;
  emxArray_int32_T *NewEy;
  emxArray_int32_T *NewEx;
  emxArray_int32_T *NewEz;
  emxArray_int32_T *r;
  emxArray_int32_T *r1;
  static const char_T cv1[51] = { ' ', ' ', ' ', '.', '.', '.', ' ', '1', 's',
    't', ' ', 'E', 'n', 'd', ' ', 'p', 'o', 'i', 'n', 't', ' ', 't', 'o', ' ',
    'a', ' ', 'B', 'r', 'a', 'n', 'c', 'h', 'p', 'o', 'i', 'n', 't', ' ', 'o',
    'r', ' ', 'a', ' ', 'E', 'n', 'd', 'p', 'o', 'i', 'n', 't' };

  int32_T f_BPcentroid[1];
  emxArray_real_T *ex;
  emxArray_real_T *ez;
  int32_T g_BPcentroid[1];
  int32_T nz;
  int32_T Pdata_count;
  emxArray_real_T *Fyxz;
  emxArray_real_T *BPxyz;
  emxArray_real_T *lenp;
  int32_T b_n;
  static const char_T cv2[26] = { ' ', ' ', ' ', '.', '.', '.', ' ', '2', 'n',
    'd', ' ', 'B', 'r', 'a', 'n', 'c', 'h', ' ', '-', ' ', 'B', 'r', 'a', 'n',
    'c', 'h' };

  real_T Y;
  real_T X;
  int32_T h_BPcentroid[1];
  real_T Z;
  real_T BranchPoint[6];
  int32_T i2;
  uint32_T c;
  boolean_T Go2Next;
  uint32_T qY;
  int32_T b_c[2];
  emxArray_boolean_T *r2;
  real_T bp1[3];
  emxArray_int32_T *r3;
  int32_T iv[2];
  real_T BPcentroid_ROI_tmp[3];
  emxArray_boolean_T *b_L_BPgroup;
  real_T b_BPcentroid_ROI_tmp[3];
  boolean_T x[2048];
  int32_T k;
  int32_T i3;
  real_T dv[6141];
  real_T dv1[6141];
  real_T TYPEnum;
  real_T dv2[2047];
  int32_T i4;
  int32_T i5;
  real_T d;
  real_T Y1;
  real_T b_lenp[3];
  emxArray_real_T *Nxyz;
  int32_T b_loop_ub;
  int32_T i6;
  int32_T c_loop_ub;
  int32_T maxval_tmp;
  int32_T b_maxval_tmp;
  int32_T c_maxval_tmp;
  boolean_T maxval;
  boolean_T b;
  boolean_T BPgroup_ROI[27];
  int32_T ii_data[27];
  int32_T ii_size[1];
  boolean_T ROI[27];
  int32_T b_ii_size[1];
  int32_T c_ii_size[1];
  real_T b_ii_data[27];
  int32_T varargout_5_data[27];
  int32_T varargout_5_size[1];
  int32_T varargout_6_data[27];
  int32_T varargout_6_size[1];
  int32_T b_varargout_5_size[1];
  real_T b_varargout_5_data[27];
  int32_T b_varargout_6_size[1];
  emxArray_real_T c_ii_data;
  real_T b_varargout_6_data[27];
  real_T b_ex;
  emxArray_real_T c_varargout_5_data;
  emxArray_real_T d_ii_data;
  boolean_T exitg1;
  emxArray_real_T e_ii_data;
  emxArray_real_T c_varargout_6_data;
  emxArray_real_T d_varargout_5_data;
  emxArray_real_T f_ii_data;
  emxArray_real_T e_varargout_5_data;
  emxArray_real_T d_varargout_6_data;
  int32_T C_size[2];
  emxArray_real_T f_varargout_5_data;
  emxArray_real_T e_varargout_6_data;
  real_T C_data[81];
  emxArray_real_T f_varargout_6_data;
  real_T C[2];
  int32_T b_C_size[2];
  emxArray_real_T b_C_data;
  real_T c_C_data[81];
  emxArray_real_T d_C_data;
  emxArray_real_T e_C_data;
  emxArray_real_T f_C_data;
  real_T X1;
  real_T Z1;
  real_T Lnum;
  int32_T i_BPcentroid[1];
  int32_T j_BPcentroid[1];
  int32_T k_BPcentroid[1];
  int32_T l_BPcentroid[1];
  emxArray_real_T g_ii_data;
  emxArray_real_T g_varargout_5_data;
  emxArray_real_T h_ii_data;
  emxArray_real_T g_varargout_6_data;
  emxArray_real_T h_varargout_5_data;
  emxArray_real_T h_varargout_6_data;
  emxArray_real_T g_C_data;
  emxArray_real_T h_C_data;
  int32_T m_BPcentroid[1];
  int32_T n_BPcentroid[1];
  emxArray_real_T i_ii_data;
  emxArray_real_T j_ii_data;
  emxArray_real_T i_varargout_5_data;
  emxArray_real_T j_varargout_5_data;
  emxArray_real_T i_varargout_6_data;
  emxArray_real_T j_varargout_6_data;
  emxArray_real_T i_C_data;
  emxArray_real_T j_C_data;
  int32_T o_BPcentroid[1];
  int32_T p_BPcentroid[1];
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack f_st;
  emlrtStack g_st;
  emlrtStack h_st;
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
  g_st.prev = &f_st;
  g_st.tls = f_st.tls;
  h_st.prev = &g_st;
  h_st.tls = g_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInit_boolean_T(sp, &OriginalBW, 3, &dh_emlrtRTEI, true);

  /*  Output = TS_AutoSegment1(skeleton_logicaldata,Resolution) */
  /*  0. Pre Processing */
  /*  1. End point to Branch or End Point */
  /*  2. Branch to Branch Point */
  /*   * Resolution need X:Y:Z = [1:1:1]!!! */
  /*  %  */
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[3])bwthindata->size, *(int32_T (*)[3])
    AddBP->size, &q_emlrtECI, sp);
  st.site = &qm_emlrtRSI;
  tic(&st);
  i = OriginalBW->size[0] * OriginalBW->size[1] * OriginalBW->size[2];
  OriginalBW->size[0] = bwthindata->size[0];
  OriginalBW->size[1] = bwthindata->size[1];
  OriginalBW->size[2] = bwthindata->size[2];
  emxEnsureCapacity_boolean_T(sp, OriginalBW, i, &dh_emlrtRTEI);
  loop_ub = bwthindata->size[0] * bwthindata->size[1] * bwthindata->size[2];
  for (i = 0; i < loop_ub; i++) {
    OriginalBW->data[i] = bwthindata->data[i];
  }

  /*  % PointXYZ is matrix, Type is 'End to Branch' or 'Branch to Branch' */
  /*  Pdata_base = struct('PointXYZ',[],'Type',[],'Length',[],'Branch',[]); %  point--->[Y X Z] */
  /*   point--->[Y X Z] */
  for (i = 0; i < 6144; i++) {
    SegP[i] = rtNaN;
    SD->u1.f2.s.PointXYZ[i] = rtNaN;
  }

  SD->u1.f2.s.Type = 0.0;
  SD->u1.f2.s.Length = 0.0;
  for (i = 0; i < 6; i++) {
    SD->u1.f2.s.Branch[i] = rtNaN;
  }

  for (i = 0; i < 32768; i++) {
    Output_Pointdata[i] = SD->u1.f2.s;
  }

  emxInit_boolean_T(sp, &b_bwthindata, 3, &eh_emlrtRTEI, true);

  /*  Analysis Branch-point and End-point  */
  st.site = &qn_emlrtRSI;
  disp(&st, emlrt_marshallOut(&st, b_cv), &b_emlrtMCI);
  i = b_bwthindata->size[0] * b_bwthindata->size[1] * b_bwthindata->size[2];
  b_bwthindata->size[0] = bwthindata->size[0];
  b_bwthindata->size[1] = bwthindata->size[1];
  b_bwthindata->size[2] = bwthindata->size[2];
  emxEnsureCapacity_boolean_T(sp, b_bwthindata, i, &eh_emlrtRTEI);
  loop_ub = bwthindata->size[0] * bwthindata->size[1] * bwthindata->size[2] - 1;
  for (i = 0; i <= loop_ub; i++) {
    b_bwthindata->data[i] = bwthindata->data[i];
  }

  emxInit_boolean_T(sp, &BPcentroid, 3, &oi_emlrtRTEI, true);
  emxInit_boolean_T(sp, &BPgroup, 3, &pi_emlrtRTEI, true);
  emxInit_boolean_T(sp, &EndP, 3, &qi_emlrtRTEI, true);
  emxInit_boolean_T(sp, &FindNearestBP, 3, &bi_emlrtRTEI, true);
  st.site = &pm_emlrtRSI;
  TS_skelmorph3d(&st, b_bwthindata, BPcentroid, FindNearestBP, BPgroup, EndP);
  end = bwthindata->size[0] * (bwthindata->size[1] * bwthindata->size[2]) - 1;
  n = 0;
  for (loop_ub = 0; loop_ub <= end; loop_ub++) {
    if (bwthindata->data[loop_ub] && AddBP->data[loop_ub]) {
      n++;
    }
  }

  emxInit_int32_T(sp, &ii, 1, &oc_emlrtRTEI, true);
  i = ii->size[0];
  ii->size[0] = n;
  emxEnsureCapacity_int32_T(sp, ii, i, &fh_emlrtRTEI);
  partialTrueCount = 0;
  for (loop_ub = 0; loop_ub <= end; loop_ub++) {
    if (bwthindata->data[loop_ub] && AddBP->data[loop_ub]) {
      ii->data[partialTrueCount] = loop_ub + 1;
      partialTrueCount++;
    }
  }

  loop_ub = ii->size[0] - 1;
  i = BPcentroid->size[0] * BPcentroid->size[1] * BPcentroid->size[2];
  for (i1 = 0; i1 <= loop_ub; i1++) {
    if ((ii->data[i1] < 1) || (ii->data[i1] > i)) {
      emlrtDynamicBoundsCheckR2012b(ii->data[i1], 1, i, &qg_emlrtBCI, sp);
    }

    BPcentroid->data[ii->data[i1] - 1] = true;
  }

  end = bwthindata->size[0] * (bwthindata->size[1] * bwthindata->size[2]) - 1;
  n = 0;
  for (loop_ub = 0; loop_ub <= end; loop_ub++) {
    if (bwthindata->data[loop_ub] && AddBP->data[loop_ub]) {
      n++;
    }
  }

  emxInit_int32_T(sp, &varargout_4, 1, &dj_emlrtRTEI, true);
  i = varargout_4->size[0];
  varargout_4->size[0] = n;
  emxEnsureCapacity_int32_T(sp, varargout_4, i, &fh_emlrtRTEI);
  partialTrueCount = 0;
  for (loop_ub = 0; loop_ub <= end; loop_ub++) {
    if (bwthindata->data[loop_ub] && AddBP->data[loop_ub]) {
      varargout_4->data[partialTrueCount] = loop_ub + 1;
      partialTrueCount++;
    }
  }

  loop_ub = varargout_4->size[0] - 1;
  i = EndP->size[0] * EndP->size[1] * EndP->size[2];
  for (i1 = 0; i1 <= loop_ub; i1++) {
    if ((varargout_4->data[i1] < 1) || (varargout_4->data[i1] > i)) {
      emlrtDynamicBoundsCheckR2012b(varargout_4->data[i1], 1, i, &rg_emlrtBCI,
        sp);
    }

    EndP->data[varargout_4->data[i1] - 1] = false;
  }

  /*  %% % term add . 2016.10.17 */
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[3])BPcentroid->size, *(int32_T (*)[3])
    BPgroup->size, &r_emlrtECI, sp);
  loop_ub = BPcentroid->size[0] * BPcentroid->size[1] * BPcentroid->size[2];
  i = BPgroup->size[0] * BPgroup->size[1] * BPgroup->size[2];
  BPgroup->size[0] = BPcentroid->size[0];
  BPgroup->size[1] = BPcentroid->size[1];
  BPgroup->size[2] = BPcentroid->size[2];
  emxEnsureCapacity_boolean_T(sp, BPgroup, i, &gh_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    BPgroup->data[i] = (BPcentroid->data[i] || BPgroup->data[i]);
  }

  emxInit_real_T(sp, &b_ii, 1, &lb_emlrtRTEI, true);

  /*  main process */
  st.site = &pn_emlrtRSI;
  disp(&st, emlrt_marshallOut(&st, b_cv), &c_emlrtMCI);
  st.site = &om_emlrtRSI;
  BPcentroid_idx_0 = BPcentroid->size[0] * BPcentroid->size[1] *
    BPcentroid->size[2];
  b_BPcentroid = *BPcentroid;
  c_BPcentroid[0] = BPcentroid_idx_0;
  b_BPcentroid.size = &c_BPcentroid[0];
  b_BPcentroid.numDimensions = 1;
  b_st.site = &cd_emlrtRSI;
  eml_find(&b_st, &b_BPcentroid, ii);
  st.site = &om_emlrtRSI;
  d_BPcentroid[0] = BPcentroid->size[0];
  d_BPcentroid[1] = BPcentroid->size[1];
  d_BPcentroid[2] = BPcentroid->size[2];
  i = b_ii->size[0];
  b_ii->size[0] = ii->size[0];
  emxEnsureCapacity_real_T(&st, b_ii, i, &lb_emlrtRTEI);
  loop_ub = ii->size[0];
  for (i = 0; i < loop_ub; i++) {
    b_ii->data[i] = ii->data[i];
  }

  emxInit_real_T(&st, &lenmap, 1, &vi_emlrtRTEI, true);
  emxInit_int32_T(&st, &varargout_6, 1, &fh_emlrtRTEI, true);
  b_st.site = &hd_emlrtRSI;
  ind2sub_indexClass(&b_st, d_BPcentroid, b_ii, varargout_4, ii, varargout_6);
  i = lenmap->size[0];
  lenmap->size[0] = ii->size[0];
  emxEnsureCapacity_real_T(&st, lenmap, i, &mb_emlrtRTEI);
  loop_ub = ii->size[0];
  for (i = 0; i < loop_ub; i++) {
    lenmap->data[i] = ii->data[i];
  }

  emxInit_real_T(&st, &b_varargout_4, 1, &nb_emlrtRTEI, true);

  /*  BP point infomation,[X Y Z Number Count] */
  st.site = &nm_emlrtRSI;
  BPcentroid_idx_0 = BPcentroid->size[0] * BPcentroid->size[1] *
    BPcentroid->size[2];
  b_BPcentroid = *BPcentroid;
  e_BPcentroid[0] = BPcentroid_idx_0;
  b_BPcentroid.size = &e_BPcentroid[0];
  b_BPcentroid.numDimensions = 1;
  b_st.site = &cd_emlrtRSI;
  eml_find(&b_st, &b_BPcentroid, ii);
  i = b_varargout_4->size[0];
  b_varargout_4->size[0] = varargout_4->size[0];
  emxEnsureCapacity_real_T(sp, b_varargout_4, i, &nb_emlrtRTEI);
  loop_ub = varargout_4->size[0];
  for (i = 0; i < loop_ub; i++) {
    b_varargout_4->data[i] = varargout_4->data[i];
  }

  emxInit_real_T(sp, &b_varargout_6, 1, &nb_emlrtRTEI, true);
  i = b_varargout_6->size[0];
  b_varargout_6->size[0] = varargout_6->size[0];
  emxEnsureCapacity_real_T(sp, b_varargout_6, i, &nb_emlrtRTEI);
  loop_ub = varargout_6->size[0];
  for (i = 0; i < loop_ub; i++) {
    b_varargout_6->data[i] = varargout_6->data[i];
  }

  i = b_ii->size[0];
  b_ii->size[0] = ii->size[0];
  emxEnsureCapacity_real_T(sp, b_ii, i, &lb_emlrtRTEI);
  loop_ub = ii->size[0];
  for (i = 0; i < loop_ub; i++) {
    b_ii->data[i] = ii->data[i];
  }

  emxInit_real_T(sp, &LEN, 1, &si_emlrtRTEI, true);
  i = LEN->size[0];
  LEN->size[0] = lenmap->size[0];
  emxEnsureCapacity_real_T(sp, LEN, i, &hh_emlrtRTEI);
  loop_ub = lenmap->size[0];
  for (i = 0; i < loop_ub; i++) {
    LEN->data[i] = 0.0;
  }

  st.site = &nm_emlrtRSI;
  c_cat(&st, lenmap, b_varargout_4, b_varargout_6, b_ii, LEN, Output_BPmatrix);

  /* clear  bpy bpx bpz */
  i = Output_Output->size[0] * Output_Output->size[1] * Output_Output->size[2];
  Output_Output->size[0] = bwthindata->size[0];
  Output_Output->size[1] = bwthindata->size[1];
  Output_Output->size[2] = bwthindata->size[2];
  emxEnsureCapacity_boolean_T(sp, Output_Output, i, &ih_emlrtRTEI);
  loop_ub = bwthindata->size[0] * bwthindata->size[1] * bwthindata->size[2];
  for (i = 0; i < loop_ub; i++) {
    Output_Output->data[i] = bwthindata->data[i];
  }

  /* �@Output.Input-->Output.Output�ɕύX�DTS_AutoSegment��Shaving��̍ŏISEG�D�̂��߁D */
  i = Output_AddBP->size[0] * Output_AddBP->size[1] * Output_AddBP->size[2];
  Output_AddBP->size[0] = bwthindata->size[0];
  Output_AddBP->size[1] = bwthindata->size[1];
  Output_AddBP->size[2] = bwthindata->size[2];
  emxEnsureCapacity_boolean_T(sp, Output_AddBP, i, &jh_emlrtRTEI);
  loop_ub = bwthindata->size[0] * bwthindata->size[1] * bwthindata->size[2];
  for (i = 0; i < loop_ub; i++) {
    Output_AddBP->data[i] = (bwthindata->data[i] && AddBP->data[i]);
  }

  i = Output_Branch->size[0] * Output_Branch->size[1] * Output_Branch->size[2];
  Output_Branch->size[0] = BPcentroid->size[0];
  Output_Branch->size[1] = BPcentroid->size[1];
  Output_Branch->size[2] = BPcentroid->size[2];
  emxEnsureCapacity_boolean_T(sp, Output_Branch, i, &kh_emlrtRTEI);
  loop_ub = BPcentroid->size[0] * BPcentroid->size[1] * BPcentroid->size[2];
  for (i = 0; i < loop_ub; i++) {
    Output_Branch->data[i] = BPcentroid->data[i];
  }

  i = Output_BranchGroup->size[0] * Output_BranchGroup->size[1] *
    Output_BranchGroup->size[2];
  Output_BranchGroup->size[0] = BPgroup->size[0];
  Output_BranchGroup->size[1] = BPgroup->size[1];
  Output_BranchGroup->size[2] = BPgroup->size[2];
  emxEnsureCapacity_boolean_T(sp, Output_BranchGroup, i, &lh_emlrtRTEI);
  loop_ub = BPgroup->size[0] * BPgroup->size[1] * BPgroup->size[2];
  for (i = 0; i < loop_ub; i++) {
    Output_BranchGroup->data[i] = BPgroup->data[i];
  }

  i = Output_End->size[0] * Output_End->size[1] * Output_End->size[2];
  Output_End->size[0] = EndP->size[0];
  Output_End->size[1] = EndP->size[1];
  Output_End->size[2] = EndP->size[2];
  emxEnsureCapacity_boolean_T(sp, Output_End, i, &mh_emlrtRTEI);
  loop_ub = EndP->size[0] * EndP->size[1] * EndP->size[2];
  for (i = 0; i < loop_ub; i++) {
    Output_End->data[i] = EndP->data[i];
  }

  Output_ResolutionXYZ[0] = Reso[0];
  Output_ResolutionXYZ[1] = Reso[1];
  Output_ResolutionXYZ[2] = Reso[2];
  i = b_bwthindata->size[0] * b_bwthindata->size[1] * b_bwthindata->size[2];
  b_bwthindata->size[0] = bwthindata->size[0];
  b_bwthindata->size[1] = bwthindata->size[1];
  b_bwthindata->size[2] = bwthindata->size[2];
  emxEnsureCapacity_boolean_T(sp, b_bwthindata, i, &nh_emlrtRTEI);
  loop_ub = bwthindata->size[0] * bwthindata->size[1] * bwthindata->size[2] - 1;
  for (i = 0; i <= loop_ub; i++) {
    b_bwthindata->data[i] = bwthindata->data[i];
  }

  st.site = &mm_emlrtRSI;
  padarray(&st, b_bwthindata, bwthindata);

  /*  For Crop;Nearest 26 point */
  /*   pointview(bwthindata,Reso,'figure') */
  i = b_bwthindata->size[0] * b_bwthindata->size[1] * b_bwthindata->size[2];
  b_bwthindata->size[0] = BPcentroid->size[0];
  b_bwthindata->size[1] = BPcentroid->size[1];
  b_bwthindata->size[2] = BPcentroid->size[2];
  emxEnsureCapacity_boolean_T(sp, b_bwthindata, i, &oh_emlrtRTEI);
  loop_ub = BPcentroid->size[0] * BPcentroid->size[1] * BPcentroid->size[2] - 1;
  for (i = 0; i <= loop_ub; i++) {
    b_bwthindata->data[i] = BPcentroid->data[i];
  }

  st.site = &lm_emlrtRSI;
  padarray(&st, b_bwthindata, BPcentroid);
  i = b_bwthindata->size[0] * b_bwthindata->size[1] * b_bwthindata->size[2];
  b_bwthindata->size[0] = BPgroup->size[0];
  b_bwthindata->size[1] = BPgroup->size[1];
  b_bwthindata->size[2] = BPgroup->size[2];
  emxEnsureCapacity_boolean_T(sp, b_bwthindata, i, &ph_emlrtRTEI);
  loop_ub = BPgroup->size[0] * BPgroup->size[1] * BPgroup->size[2] - 1;
  for (i = 0; i <= loop_ub; i++) {
    b_bwthindata->data[i] = BPgroup->data[i];
  }

  emxInit_real_T(sp, &L_BPgroup, 3, &ri_emlrtRTEI, true);
  emxInit_real32_T(sp, &unusedU3, 3, &fh_emlrtRTEI, true);
  emxInit_uint32_T(sp, &DistInd, 3, &fh_emlrtRTEI, true);
  st.site = &km_emlrtRSI;
  padarray(&st, b_bwthindata, BPgroup);
  st.site = &jm_emlrtRSI;
  bwdist(&st, BPcentroid, unusedU3, DistInd);

  /*  L_BPgroup = uint32(bwlabeln(BPcentroid,26)); */
  st.site = &im_emlrtRSI;
  TS_bwlabeln3D26(&st, BPcentroid, L_BPgroup);
  st.site = &hm_emlrtRSI;
  end = BPgroup->size[0] * (BPgroup->size[1] * BPgroup->size[2]) - 1;
  n = 0;
  emxFree_real32_T(&unusedU3);
  for (loop_ub = 0; loop_ub <= end; loop_ub++) {
    if (BPgroup->data[loop_ub]) {
      n++;
    }
  }

  emxInit_int32_T(sp, &NewEy, 1, &wi_emlrtRTEI, true);
  i = NewEy->size[0];
  NewEy->size[0] = n;
  emxEnsureCapacity_int32_T(sp, NewEy, i, &fh_emlrtRTEI);
  partialTrueCount = 0;
  for (loop_ub = 0; loop_ub <= end; loop_ub++) {
    if (BPgroup->data[loop_ub]) {
      NewEy->data[partialTrueCount] = loop_ub + 1;
      partialTrueCount++;
    }
  }

  partialTrueCount = DistInd->size[0] * DistInd->size[1] * DistInd->size[2];
  n = L_BPgroup->size[0] * L_BPgroup->size[1] * L_BPgroup->size[2];
  loop_ub = NewEy->size[0];
  for (i = 0; i < loop_ub; i++) {
    if ((NewEy->data[i] < 1) || (NewEy->data[i] > partialTrueCount)) {
      emlrtDynamicBoundsCheckR2012b(NewEy->data[i], 1, partialTrueCount,
        &sg_emlrtBCI, sp);
    }

    i1 = (int32_T)DistInd->data[NewEy->data[i] - 1];
    if ((i1 < 1) || (i1 > n)) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, n, &tg_emlrtBCI, sp);
    }
  }

  end = BPgroup->size[0] * (BPgroup->size[1] * BPgroup->size[2]) - 1;
  n = 0;
  for (loop_ub = 0; loop_ub <= end; loop_ub++) {
    if (BPgroup->data[loop_ub]) {
      n++;
    }
  }

  emxInit_int32_T(sp, &NewEx, 1, &xi_emlrtRTEI, true);
  i = NewEx->size[0];
  NewEx->size[0] = n;
  emxEnsureCapacity_int32_T(sp, NewEx, i, &fh_emlrtRTEI);
  partialTrueCount = 0;
  for (loop_ub = 0; loop_ub <= end; loop_ub++) {
    if (BPgroup->data[loop_ub]) {
      NewEx->data[partialTrueCount] = loop_ub + 1;
      partialTrueCount++;
    }
  }

  end = BPgroup->size[0] * (BPgroup->size[1] * BPgroup->size[2]) - 1;
  n = 0;
  for (loop_ub = 0; loop_ub <= end; loop_ub++) {
    if (BPgroup->data[loop_ub]) {
      n++;
    }
  }

  emxInit_int32_T(sp, &NewEz, 1, &xi_emlrtRTEI, true);
  i = NewEz->size[0];
  NewEz->size[0] = n;
  emxEnsureCapacity_int32_T(sp, NewEz, i, &fh_emlrtRTEI);
  partialTrueCount = 0;
  for (loop_ub = 0; loop_ub <= end; loop_ub++) {
    if (BPgroup->data[loop_ub]) {
      NewEz->data[partialTrueCount] = loop_ub + 1;
      partialTrueCount++;
    }
  }

  i = L_BPgroup->size[0] * L_BPgroup->size[1] * L_BPgroup->size[2];
  i1 = LEN->size[0];
  LEN->size[0] = NewEz->size[0];
  emxEnsureCapacity_real_T(sp, LEN, i1, &qh_emlrtRTEI);
  loop_ub = NewEz->size[0];
  for (i1 = 0; i1 < loop_ub; i1++) {
    LEN->data[i1] = L_BPgroup->data[(int32_T)DistInd->data[NewEz->data[i1] - 1]
      - 1];
  }

  emxFree_uint32_T(&DistInd);
  loop_ub = LEN->size[0];
  for (i1 = 0; i1 < loop_ub; i1++) {
    if ((NewEz->data[i1] < 1) || (NewEz->data[i1] > i)) {
      emlrtDynamicBoundsCheckR2012b(NewEz->data[i1], 1, i, &ug_emlrtBCI, sp);
    }

    L_BPgroup->data[NewEz->data[i1] - 1] = LEN->data[i1];
  }

  /* clear  DistInd */
  end = BPcentroid->size[0] * (BPcentroid->size[1] * BPcentroid->size[2]) - 1;
  n = 0;
  for (loop_ub = 0; loop_ub <= end; loop_ub++) {
    if (BPcentroid->data[loop_ub]) {
      n++;
    }
  }

  emxInit_int32_T(sp, &r, 1, &aj_emlrtRTEI, true);
  i = r->size[0];
  r->size[0] = n;
  emxEnsureCapacity_int32_T(sp, r, i, &fh_emlrtRTEI);
  partialTrueCount = 0;
  for (loop_ub = 0; loop_ub <= end; loop_ub++) {
    if (BPcentroid->data[loop_ub]) {
      r->data[partialTrueCount] = loop_ub + 1;
      partialTrueCount++;
    }
  }

  loop_ub = r->size[0] - 1;
  i = bwthindata->size[0] * bwthindata->size[1] * bwthindata->size[2];
  for (i1 = 0; i1 <= loop_ub; i1++) {
    if ((r->data[i1] < 1) || (r->data[i1] > i)) {
      emlrtDynamicBoundsCheckR2012b(r->data[i1], 1, i, &vg_emlrtBCI, sp);
    }

    bwthindata->data[r->data[i1] - 1] = false;
  }

  emxFree_int32_T(&r);

  /*  bwthindata --->����čs���A�Ȃ��Ȃ�����I�� */
  end = BPgroup->size[0] * (BPgroup->size[1] * BPgroup->size[2]) - 1;
  n = 0;
  for (loop_ub = 0; loop_ub <= end; loop_ub++) {
    if (BPgroup->data[loop_ub]) {
      n++;
    }
  }

  emxInit_int32_T(sp, &r1, 1, &bj_emlrtRTEI, true);
  i = r1->size[0];
  r1->size[0] = n;
  emxEnsureCapacity_int32_T(sp, r1, i, &fh_emlrtRTEI);
  partialTrueCount = 0;
  for (loop_ub = 0; loop_ub <= end; loop_ub++) {
    if (BPgroup->data[loop_ub]) {
      r1->data[partialTrueCount] = loop_ub + 1;
      partialTrueCount++;
    }
  }

  loop_ub = r1->size[0] - 1;
  i = bwthindata->size[0] * bwthindata->size[1] * bwthindata->size[2];
  for (i1 = 0; i1 <= loop_ub; i1++) {
    if ((r1->data[i1] < 1) || (r1->data[i1] > i)) {
      emlrtDynamicBoundsCheckR2012b(r1->data[i1], 1, i, &wg_emlrtBCI, sp);
    }

    bwthindata->data[r1->data[i1] - 1] = false;
  }

  emxFree_int32_T(&r1);
  i = b_bwthindata->size[0] * b_bwthindata->size[1] * b_bwthindata->size[2];
  b_bwthindata->size[0] = EndP->size[0];
  b_bwthindata->size[1] = EndP->size[1];
  b_bwthindata->size[2] = EndP->size[2];
  emxEnsureCapacity_boolean_T(sp, b_bwthindata, i, &rh_emlrtRTEI);
  loop_ub = EndP->size[0] * EndP->size[1] * EndP->size[2] - 1;
  for (i = 0; i <= loop_ub; i++) {
    b_bwthindata->data[i] = EndP->data[i];
  }

  st.site = &gm_emlrtRSI;
  padarray(&st, b_bwthindata, EndP);

  /*  End point to a Branchpoint or a Endpoint */
  st.site = &rn_emlrtRSI;
  disp(&st, b_emlrt_marshallOut(&st, cv1), &d_emlrtMCI);
  st.site = &fm_emlrtRSI;
  BPcentroid_idx_0 = EndP->size[0] * EndP->size[1] * EndP->size[2];
  b_BPcentroid = *EndP;
  f_BPcentroid[0] = BPcentroid_idx_0;
  b_BPcentroid.size = &f_BPcentroid[0];
  b_BPcentroid.numDimensions = 1;
  b_st.site = &cd_emlrtRSI;
  eml_find(&b_st, &b_BPcentroid, ii);
  st.site = &fm_emlrtRSI;
  d_BPcentroid[0] = EndP->size[0];
  d_BPcentroid[1] = EndP->size[1];
  d_BPcentroid[2] = EndP->size[2];
  i = b_ii->size[0];
  b_ii->size[0] = ii->size[0];
  emxEnsureCapacity_real_T(&st, b_ii, i, &lb_emlrtRTEI);
  loop_ub = ii->size[0];
  emxFree_boolean_T(&b_bwthindata);
  for (i = 0; i < loop_ub; i++) {
    b_ii->data[i] = ii->data[i];
  }

  b_st.site = &hd_emlrtRSI;
  ind2sub_indexClass(&b_st, d_BPcentroid, b_ii, varargout_4, ii, varargout_6);
  i = lenmap->size[0];
  lenmap->size[0] = varargout_4->size[0];
  emxEnsureCapacity_real_T(&st, lenmap, i, &mb_emlrtRTEI);
  loop_ub = varargout_4->size[0];
  for (i = 0; i < loop_ub; i++) {
    lenmap->data[i] = varargout_4->data[i];
  }

  emxInit_real_T(&st, &ex, 1, &fh_emlrtRTEI, true);
  i = ex->size[0];
  ex->size[0] = ii->size[0];
  emxEnsureCapacity_real_T(&st, ex, i, &mb_emlrtRTEI);
  loop_ub = ii->size[0];
  for (i = 0; i < loop_ub; i++) {
    ex->data[i] = ii->data[i];
  }

  emxInit_real_T(&st, &ez, 1, &fh_emlrtRTEI, true);
  i = ez->size[0];
  ez->size[0] = varargout_6->size[0];
  emxEnsureCapacity_real_T(&st, ez, i, &mb_emlrtRTEI);
  loop_ub = varargout_6->size[0];
  for (i = 0; i < loop_ub; i++) {
    ez->data[i] = varargout_6->data[i];
  }

  st.site = &em_emlrtRSI;
  b_st.site = &jg_emlrtRSI;
  BPcentroid_idx_0 = EndP->size[0] * EndP->size[1] * EndP->size[2];
  b_BPcentroid = *EndP;
  g_BPcentroid[0] = BPcentroid_idx_0;
  b_BPcentroid.size = &g_BPcentroid[0];
  b_BPcentroid.numDimensions = 1;
  c_st.site = &re_emlrtRSI;
  nz = b_combineVectorElements(&c_st, &b_BPcentroid);
  Pdata_count = 0;
  emxInit_real_T(sp, &Fyxz, 2, &ti_emlrtRTEI, true);
  emxInit_real_T(sp, &BPxyz, 2, &sh_emlrtRTEI, true);
  emxInit_real_T(sp, &lenp, 2, &yi_emlrtRTEI, true);
  for (b_n = 0; b_n < nz; b_n++) {
    /* length(ey) */
    i = (int32_T)(b_n + 1U);
    if ((i < 1) || (i > lenmap->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i, 1, lenmap->size[0], &xg_emlrtBCI, sp);
    }

    Y = lenmap->data[i - 1];
    if (i > ex->size[0]) {
      emlrtDynamicBoundsCheckR2012b(i, 1, ex->size[0], &yg_emlrtBCI, sp);
    }

    X = ex->data[i - 1];
    if (i > ez->size[0]) {
      emlrtDynamicBoundsCheckR2012b(i, 1, ez->size[0], &ah_emlrtBCI, sp);
    }

    Z = ez->data[i - 1];
    for (i = 0; i < 6; i++) {
      BranchPoint[i] = rtNaN;
    }

    /*  % End point check(End-End�͓�Ԗڂ�EndPoint�������Ă��܂����߁B) */
    i = (int32_T)lenmap->data[b_n];
    if ((i < 1) || (i > bwthindata->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i, 1, bwthindata->size[0], &bh_emlrtBCI, sp);
    }

    i1 = (int32_T)ex->data[b_n];
    if ((i1 < 1) || (i1 > bwthindata->size[1])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, bwthindata->size[1], &bh_emlrtBCI, sp);
    }

    i2 = (int32_T)ez->data[b_n];
    if ((i2 < 1) || (i2 > bwthindata->size[2])) {
      emlrtDynamicBoundsCheckR2012b(i2, 1, bwthindata->size[2], &bh_emlrtBCI, sp);
    }

    if (bwthindata->data[((i + bwthindata->size[0] * (i1 - 1)) +
                          bwthindata->size[0] * bwthindata->size[1] * (i2 - 1))
        - 1]) {
      c = 1U;
      Output_Pointdata[Pdata_count].Type = rtNaN;

      /*      Segment = struct('point',[]); */
      /*      Segment(c).point = double([X Y Z]-1); %% padarray���Ă��邽��-1 */
      SegP[0] = ex->data[b_n] - 1.0;
      SegP[2048] = lenmap->data[b_n] - 1.0;
      SegP[4096] = ez->data[b_n] - 1.0;
      if (i > bwthindata->size[0]) {
        emlrtDynamicBoundsCheckR2012b(i, 1, bwthindata->size[0], &ch_emlrtBCI,
          sp);
      }

      if (i1 > bwthindata->size[1]) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, bwthindata->size[1], &ch_emlrtBCI,
          sp);
      }

      if (i2 > bwthindata->size[2]) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, bwthindata->size[2], &ch_emlrtBCI,
          sp);
      }

      bwthindata->data[((i + bwthindata->size[0] * (i1 - 1)) + bwthindata->size
                        [0] * bwthindata->size[1] * (i2 - 1)) - 1] = false;
      Go2Next = true;
      while (Go2Next) {
        qY = c + 1U;
        if (qY < c) {
          qY = MAX_uint32_T;
        }

        c = qY;
        bp1[0] = Y + -1.0;
        BPcentroid_ROI_tmp[0] = X + -1.0;
        b_BPcentroid_ROI_tmp[0] = Z + -1.0;
        bp1[1] = Y;
        BPcentroid_ROI_tmp[1] = X;
        b_BPcentroid_ROI_tmp[1] = Z;
        bp1[2] = Y + 1.0;
        BPcentroid_ROI_tmp[2] = X + 1.0;
        b_BPcentroid_ROI_tmp[2] = Z + 1.0;
        i = (int32_T)(Y + -1.0);
        if ((i < 1) || (i > BPcentroid->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i, 1, BPcentroid->size[0], &wi_emlrtBCI,
            sp);
        }

        i1 = (int32_T)Y;
        if ((i1 < 1) || (i1 > BPcentroid->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, BPcentroid->size[0], &wi_emlrtBCI,
            sp);
        }

        i2 = (int32_T)(Y + 1.0);
        if ((i2 < 1) || (i2 > BPcentroid->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, BPcentroid->size[0], &wi_emlrtBCI,
            sp);
        }

        i3 = (int32_T)(X + -1.0);
        if ((i3 < 1) || (i3 > BPcentroid->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, BPcentroid->size[1], &xi_emlrtBCI,
            sp);
        }

        i4 = (int32_T)X;
        if ((i4 < 1) || (i4 > BPcentroid->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, BPcentroid->size[1], &xi_emlrtBCI,
            sp);
        }

        i5 = (int32_T)(X + 1.0);
        if ((i5 < 1) || (i5 > BPcentroid->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, BPcentroid->size[1], &xi_emlrtBCI,
            sp);
        }

        loop_ub = (int32_T)(Z + -1.0);
        if ((loop_ub < 1) || (loop_ub > BPcentroid->size[2])) {
          emlrtDynamicBoundsCheckR2012b(loop_ub, 1, BPcentroid->size[2],
            &yi_emlrtBCI, sp);
        }

        k = (int32_T)Z;
        if ((k < 1) || (k > BPcentroid->size[2])) {
          emlrtDynamicBoundsCheckR2012b(k, 1, BPcentroid->size[2], &yi_emlrtBCI,
            sp);
        }

        end = (int32_T)(Z + 1.0);
        if ((end < 1) || (end > BPcentroid->size[2])) {
          emlrtDynamicBoundsCheckR2012b(end, 1, BPcentroid->size[2],
            &yi_emlrtBCI, sp);
        }

        if (i > BPgroup->size[0]) {
          emlrtDynamicBoundsCheckR2012b(i, 1, BPgroup->size[0], &aj_emlrtBCI, sp);
        }

        if (i1 > BPgroup->size[0]) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, BPgroup->size[0], &aj_emlrtBCI,
            sp);
        }

        if (i2 > BPgroup->size[0]) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, BPgroup->size[0], &aj_emlrtBCI,
            sp);
        }

        if (i3 > BPgroup->size[1]) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, BPgroup->size[1], &bj_emlrtBCI,
            sp);
        }

        if (i4 > BPgroup->size[1]) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, BPgroup->size[1], &bj_emlrtBCI,
            sp);
        }

        if (i5 > BPgroup->size[1]) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, BPgroup->size[1], &bj_emlrtBCI,
            sp);
        }

        if (loop_ub > BPgroup->size[2]) {
          emlrtDynamicBoundsCheckR2012b(loop_ub, 1, BPgroup->size[2],
            &cj_emlrtBCI, sp);
        }

        if (k > BPgroup->size[2]) {
          emlrtDynamicBoundsCheckR2012b(k, 1, BPgroup->size[2], &cj_emlrtBCI, sp);
        }

        if (end > BPgroup->size[2]) {
          emlrtDynamicBoundsCheckR2012b(end, 1, BPgroup->size[2], &cj_emlrtBCI,
            sp);
        }

        if ((i1 < 1) || (i1 > bwthindata->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, bwthindata->size[0], &ih_emlrtBCI,
            sp);
        }

        if ((i4 < 1) || (i4 > bwthindata->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, bwthindata->size[1], &ih_emlrtBCI,
            sp);
        }

        if ((k < 1) || (k > bwthindata->size[2])) {
          emlrtDynamicBoundsCheckR2012b(k, 1, bwthindata->size[2], &ih_emlrtBCI,
            sp);
        }

        bwthindata->data[((i1 + bwthindata->size[0] * (i4 - 1)) +
                          bwthindata->size[0] * bwthindata->size[1] * (k - 1)) -
          1] = false;
        if (i > bwthindata->size[0]) {
          emlrtDynamicBoundsCheckR2012b(i, 1, bwthindata->size[0], &dj_emlrtBCI,
            sp);
        }

        if (i1 > bwthindata->size[0]) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, bwthindata->size[0], &dj_emlrtBCI,
            sp);
        }

        if (i2 > bwthindata->size[0]) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, bwthindata->size[0], &dj_emlrtBCI,
            sp);
        }

        if (i3 > bwthindata->size[1]) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, bwthindata->size[1], &ej_emlrtBCI,
            sp);
        }

        if (i4 > bwthindata->size[1]) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, bwthindata->size[1], &ej_emlrtBCI,
            sp);
        }

        if (i5 > bwthindata->size[1]) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, bwthindata->size[1], &ej_emlrtBCI,
            sp);
        }

        if (loop_ub > bwthindata->size[2]) {
          emlrtDynamicBoundsCheckR2012b(loop_ub, 1, bwthindata->size[2],
            &fj_emlrtBCI, sp);
        }

        if (k > bwthindata->size[2]) {
          emlrtDynamicBoundsCheckR2012b(k, 1, bwthindata->size[2], &fj_emlrtBCI,
            sp);
        }

        if (end > bwthindata->size[2]) {
          emlrtDynamicBoundsCheckR2012b(end, 1, bwthindata->size[2],
            &fj_emlrtBCI, sp);
        }

        b_lenp[0] = Y;
        b_lenp[1] = X;
        b_lenp[2] = Z;
        maxval_tmp = i - 1;
        b_maxval_tmp = i3 - 1;
        c_maxval_tmp = loop_ub - 1;
        maxval = BPcentroid->data[(maxval_tmp + BPcentroid->size[0] *
          b_maxval_tmp) + BPcentroid->size[0] * BPcentroid->size[1] *
          c_maxval_tmp];
        for (k = 0; k < 26; k++) {
          b = BPcentroid->data[(((int32_T)bp1[(k + 1) % 3] + BPcentroid->size[0]
            * ((int32_T)BPcentroid_ROI_tmp[(k + 1) / 3 % 3] - 1)) +
                                BPcentroid->size[0] * BPcentroid->size[1] *
                                ((int32_T)b_BPcentroid_ROI_tmp[(k + 1) / 9] - 1))
            - 1];
          maxval = (((int32_T)maxval < (int32_T)b) || maxval);
        }

        if (maxval) {
          st.site = &dm_emlrtRSI;
          for (i = 0; i < 3; i++) {
            end = (int32_T)b_BPcentroid_ROI_tmp[i] - 1;
            for (i3 = 0; i3 < 3; i3++) {
              partialTrueCount = (int32_T)BPcentroid_ROI_tmp[i3] - 1;
              loop_ub = 3 * i3 + 9 * i;
              BPgroup_ROI[loop_ub] = BPcentroid->data[(maxval_tmp +
                BPcentroid->size[0] * partialTrueCount) + BPcentroid->size[0] *
                BPcentroid->size[1] * end];
              BPgroup_ROI[loop_ub + 1] = BPcentroid->data[((i1 +
                BPcentroid->size[0] * partialTrueCount) + BPcentroid->size[0] *
                BPcentroid->size[1] * end) - 1];
              BPgroup_ROI[loop_ub + 2] = BPcentroid->data[((i2 +
                BPcentroid->size[0] * partialTrueCount) + BPcentroid->size[0] *
                BPcentroid->size[1] * end) - 1];
            }
          }

          b_st.site = &cd_emlrtRSI;
          b_eml_find(&b_st, BPgroup_ROI, ii_data, ii_size);
          st.site = &dm_emlrtRSI;
          b_ii_size[0] = ii_size[0];
          loop_ub = ii_size[0];
          for (i = 0; i < loop_ub; i++) {
            b_ii_data[i] = ii_data[i];
          }

          c_ii_size[0] = b_ii_size[0];
          b_st.site = &hd_emlrtRSI;
          b_ind2sub_indexClass(&b_st, b_ii_data, c_ii_size, ii_data, ii_size,
                               varargout_5_data, varargout_5_size,
                               varargout_6_data, varargout_6_size);
          b_ii_size[0] = ii_size[0];
          loop_ub = ii_size[0];
          for (i = 0; i < loop_ub; i++) {
            b_ii_data[i] = ((real_T)ii_data[i] + Y) - 2.0;
          }

          b_varargout_5_size[0] = varargout_5_size[0];
          loop_ub = varargout_5_size[0];
          for (i = 0; i < loop_ub; i++) {
            b_varargout_5_data[i] = ((real_T)varargout_5_data[i] + X) - 2.0;
          }

          b_varargout_6_size[0] = varargout_6_size[0];
          loop_ub = varargout_6_size[0];
          for (i = 0; i < loop_ub; i++) {
            b_varargout_6_data[i] = ((real_T)varargout_6_data[i] + Z) - 2.0;
          }

          d_ii_data.data = &b_ii_data[0];
          d_ii_data.size = &b_ii_size[0];
          d_ii_data.allocatedSize = 27;
          d_ii_data.numDimensions = 1;
          d_ii_data.canFreeData = false;
          d_varargout_5_data.data = &b_varargout_5_data[0];
          d_varargout_5_data.size = &b_varargout_5_size[0];
          d_varargout_5_data.allocatedSize = 27;
          d_varargout_5_data.numDimensions = 1;
          d_varargout_5_data.canFreeData = false;
          d_varargout_6_data.data = &b_varargout_6_data[0];
          d_varargout_6_data.size = &b_varargout_6_size[0];
          d_varargout_6_data.allocatedSize = 27;
          d_varargout_6_data.numDimensions = 1;
          d_varargout_6_data.canFreeData = false;
          st.site = &cm_emlrtRSI;
          b_cat(&st, &d_ii_data, &d_varargout_5_data, &d_varargout_6_data, lenp);
          C_size[0] = lenp->size[0];
          C_size[1] = 3;
          loop_ub = lenp->size[0] * lenp->size[1];
          for (i = 0; i < loop_ub; i++) {
            C_data[i] = lenp->data[i];
          }

          C[0] = C_size[0];
          C[1] = 1.0;
          st.site = &bm_emlrtRSI;
          b_repmat(&st, b_lenp, C, lenp);
          emlrtSizeEqCheckNDR2012b(C_size, *(int32_T (*)[2])lenp->size,
            &s_emlrtECI, sp);
          b_C_size[0] = C_size[0];
          b_C_size[1] = 3;
          loop_ub = C_size[0] * 3;
          for (i = 0; i < loop_ub; i++) {
            c_C_data[i] = C_data[i] - lenp->data[i];
          }

          d_C_data.data = &c_C_data[0];
          d_C_data.size = &b_C_size[0];
          d_C_data.allocatedSize = 81;
          d_C_data.numDimensions = 2;
          d_C_data.canFreeData = false;
          st.site = &am_emlrtRSI;
          power(&st, &d_C_data, lenp);
          st.site = &am_emlrtRSI;
          g_sum(&st, lenp, LEN);
          st.site = &yl_emlrtRSI;
          b_st.site = &rf_emlrtRSI;
          c_st.site = &sf_emlrtRSI;
          d_st.site = &tf_emlrtRSI;
          if (LEN->size[0] < 1) {
            emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
              "Coder:toolbox:eml_min_or_max_varDimZero",
              "Coder:toolbox:eml_min_or_max_varDimZero", 0);
          }

          e_st.site = &uf_emlrtRSI;
          n = LEN->size[0];
          if (LEN->size[0] <= 2) {
            if (LEN->size[0] == 1) {
              end = 1;
            } else if ((LEN->data[0] > LEN->data[1]) || (muDoubleScalarIsNaN
                        (LEN->data[0]) && (!muDoubleScalarIsNaN(LEN->data[1]))))
            {
              end = 2;
            } else {
              end = 1;
            }
          } else {
            f_st.site = &xd_emlrtRSI;
            if (!muDoubleScalarIsNaN(LEN->data[0])) {
              end = 1;
            } else {
              end = 0;
              g_st.site = &yd_emlrtRSI;
              if (LEN->size[0] > 2147483646) {
                h_st.site = &i_emlrtRSI;
                check_forloop_overflow_error(&h_st);
              }

              k = 2;
              exitg1 = false;
              while ((!exitg1) && (k <= LEN->size[0])) {
                if (!muDoubleScalarIsNaN(LEN->data[k - 1])) {
                  end = k;
                  exitg1 = true;
                } else {
                  k++;
                }
              }
            }

            if (end == 0) {
              end = 1;
            } else {
              f_st.site = &vd_emlrtRSI;
              b_ex = LEN->data[end - 1];
              loop_ub = end + 1;
              g_st.site = &wd_emlrtRSI;
              if ((end + 1 <= LEN->size[0]) && (LEN->size[0] > 2147483646)) {
                h_st.site = &i_emlrtRSI;
                check_forloop_overflow_error(&h_st);
              }

              for (k = loop_ub; k <= n; k++) {
                d = LEN->data[k - 1];
                if (b_ex > d) {
                  b_ex = d;
                  end = k;
                }
              }
            }
          }

          if ((end < 1) || (end > C_size[0])) {
            emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &nh_emlrtBCI, sp);
          }

          X = C_data[(end + C_size[0]) - 1];
          if (end > C_size[0]) {
            emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &oh_emlrtBCI, sp);
          }

          Y = C_data[end - 1];
          if (end > C_size[0]) {
            emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &ph_emlrtBCI, sp);
          }

          Z = C_data[(end + C_size[0] * 2) - 1];

          /*              Segment(c).point = double([X Y Z]-1); */
          if (((int32_T)qY < 1) || ((int32_T)qY > 2048)) {
            emlrtDynamicBoundsCheckR2012b((int32_T)qY, 1, 2048, &gf_emlrtBCI, sp);
          }

          /* clear  Ind LEN Lnum BPCy BPCx BPCz BPC                         */
          /*              TYPE = 'End to Branch'; */
          Output_Pointdata[Pdata_count].Type = 1.0;
          SegP[(int32_T)qY - 1] = X - 1.0;
          BranchPoint[0] = X - 1.0;
          SegP[(int32_T)qY + 2047] = Y - 1.0;
          BranchPoint[2] = Y - 1.0;
          SegP[(int32_T)qY + 4095] = Z - 1.0;
          BranchPoint[4] = Z - 1.0;
          Go2Next = false;
        } else {
          maxval = BPgroup->data[(maxval_tmp + BPgroup->size[0] * b_maxval_tmp)
            + BPgroup->size[0] * BPgroup->size[1] * c_maxval_tmp];
          for (k = 0; k < 26; k++) {
            b = BPgroup->data[(((int32_T)bp1[(k + 1) % 3] + BPgroup->size[0] *
                                ((int32_T)BPcentroid_ROI_tmp[(k + 1) / 3 % 3] -
                                 1)) + BPgroup->size[0] * BPgroup->size[1] *
                               ((int32_T)b_BPcentroid_ROI_tmp[(k + 1) / 9] - 1))
              - 1];
            maxval = (((int32_T)maxval < (int32_T)b) || maxval);
          }

          if (maxval) {
            st.site = &xl_emlrtRSI;
            for (i = 0; i < 3; i++) {
              end = (int32_T)b_BPcentroid_ROI_tmp[i] - 1;
              for (i3 = 0; i3 < 3; i3++) {
                partialTrueCount = (int32_T)BPcentroid_ROI_tmp[i3] - 1;
                loop_ub = 3 * i3 + 9 * i;
                BPgroup_ROI[loop_ub] = BPgroup->data[(maxval_tmp + BPgroup->
                  size[0] * partialTrueCount) + BPgroup->size[0] * BPgroup->
                  size[1] * end];
                BPgroup_ROI[loop_ub + 1] = BPgroup->data[((i1 + BPgroup->size[0]
                  * partialTrueCount) + BPgroup->size[0] * BPgroup->size[1] *
                  end) - 1];
                BPgroup_ROI[loop_ub + 2] = BPgroup->data[((i2 + BPgroup->size[0]
                  * partialTrueCount) + BPgroup->size[0] * BPgroup->size[1] *
                  end) - 1];
              }
            }

            b_st.site = &cd_emlrtRSI;
            b_eml_find(&b_st, BPgroup_ROI, ii_data, ii_size);
            st.site = &xl_emlrtRSI;
            b_ii_size[0] = ii_size[0];
            loop_ub = ii_size[0];
            for (i = 0; i < loop_ub; i++) {
              b_ii_data[i] = ii_data[i];
            }

            c_ii_size[0] = b_ii_size[0];
            b_st.site = &hd_emlrtRSI;
            b_ind2sub_indexClass(&b_st, b_ii_data, c_ii_size, ii_data, ii_size,
                                 varargout_5_data, varargout_5_size,
                                 varargout_6_data, varargout_6_size);
            b_ii_size[0] = ii_size[0];
            loop_ub = ii_size[0];
            for (i = 0; i < loop_ub; i++) {
              b_ii_data[i] = ((real_T)ii_data[i] + Y) - 2.0;
            }

            b_varargout_5_size[0] = varargout_5_size[0];
            loop_ub = varargout_5_size[0];
            for (i = 0; i < loop_ub; i++) {
              b_varargout_5_data[i] = ((real_T)varargout_5_data[i] + X) - 2.0;
            }

            b_varargout_6_size[0] = varargout_6_size[0];
            loop_ub = varargout_6_size[0];
            for (i = 0; i < loop_ub; i++) {
              b_varargout_6_data[i] = ((real_T)varargout_6_data[i] + Z) - 2.0;
            }

            e_ii_data.data = &b_ii_data[0];
            e_ii_data.size = &b_ii_size[0];
            e_ii_data.allocatedSize = 27;
            e_ii_data.numDimensions = 1;
            e_ii_data.canFreeData = false;
            e_varargout_5_data.data = &b_varargout_5_data[0];
            e_varargout_5_data.size = &b_varargout_5_size[0];
            e_varargout_5_data.allocatedSize = 27;
            e_varargout_5_data.numDimensions = 1;
            e_varargout_5_data.canFreeData = false;
            e_varargout_6_data.data = &b_varargout_6_data[0];
            e_varargout_6_data.size = &b_varargout_6_size[0];
            e_varargout_6_data.allocatedSize = 27;
            e_varargout_6_data.numDimensions = 1;
            e_varargout_6_data.canFreeData = false;
            st.site = &wl_emlrtRSI;
            b_cat(&st, &e_ii_data, &e_varargout_5_data, &e_varargout_6_data,
                  lenp);
            C_size[0] = lenp->size[0];
            C_size[1] = 3;
            loop_ub = lenp->size[0] * lenp->size[1];
            for (i = 0; i < loop_ub; i++) {
              C_data[i] = lenp->data[i];
            }

            C[0] = C_size[0];
            C[1] = 1.0;
            st.site = &vl_emlrtRSI;
            b_repmat(&st, b_lenp, C, lenp);
            emlrtSizeEqCheckNDR2012b(C_size, *(int32_T (*)[2])lenp->size,
              &t_emlrtECI, sp);
            b_C_size[0] = C_size[0];
            b_C_size[1] = 3;
            loop_ub = C_size[0] * 3;
            for (i = 0; i < loop_ub; i++) {
              c_C_data[i] = C_data[i] - lenp->data[i];
            }

            e_C_data.data = &c_C_data[0];
            e_C_data.size = &b_C_size[0];
            e_C_data.allocatedSize = 81;
            e_C_data.numDimensions = 2;
            e_C_data.canFreeData = false;
            st.site = &ul_emlrtRSI;
            power(&st, &e_C_data, lenp);
            st.site = &ul_emlrtRSI;
            g_sum(&st, lenp, LEN);
            st.site = &tl_emlrtRSI;
            b_st.site = &rf_emlrtRSI;
            c_st.site = &sf_emlrtRSI;
            d_st.site = &tf_emlrtRSI;
            if (LEN->size[0] < 1) {
              emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
                "Coder:toolbox:eml_min_or_max_varDimZero",
                "Coder:toolbox:eml_min_or_max_varDimZero", 0);
            }

            e_st.site = &uf_emlrtRSI;
            n = LEN->size[0];
            if (LEN->size[0] <= 2) {
              if (LEN->size[0] == 1) {
                end = 1;
              } else if ((LEN->data[0] > LEN->data[1]) || (muDoubleScalarIsNaN
                          (LEN->data[0]) && (!muDoubleScalarIsNaN(LEN->data[1]))))
              {
                end = 2;
              } else {
                end = 1;
              }
            } else {
              f_st.site = &xd_emlrtRSI;
              if (!muDoubleScalarIsNaN(LEN->data[0])) {
                end = 1;
              } else {
                end = 0;
                g_st.site = &yd_emlrtRSI;
                if (LEN->size[0] > 2147483646) {
                  h_st.site = &i_emlrtRSI;
                  check_forloop_overflow_error(&h_st);
                }

                k = 2;
                exitg1 = false;
                while ((!exitg1) && (k <= LEN->size[0])) {
                  if (!muDoubleScalarIsNaN(LEN->data[k - 1])) {
                    end = k;
                    exitg1 = true;
                  } else {
                    k++;
                  }
                }
              }

              if (end == 0) {
                end = 1;
              } else {
                f_st.site = &vd_emlrtRSI;
                b_ex = LEN->data[end - 1];
                loop_ub = end + 1;
                g_st.site = &wd_emlrtRSI;
                if ((end + 1 <= LEN->size[0]) && (LEN->size[0] > 2147483646)) {
                  h_st.site = &i_emlrtRSI;
                  check_forloop_overflow_error(&h_st);
                }

                for (k = loop_ub; k <= n; k++) {
                  d = LEN->data[k - 1];
                  if (b_ex > d) {
                    b_ex = d;
                    end = k;
                  }
                }
              }
            }

            if ((end < 1) || (end > C_size[0])) {
              emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &qh_emlrtBCI, sp);
            }

            X = C_data[(end + C_size[0]) - 1];
            if (end > C_size[0]) {
              emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &rh_emlrtBCI, sp);
            }

            Y = C_data[end - 1];
            if (end > C_size[0]) {
              emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &sh_emlrtBCI, sp);
            }

            Z = C_data[(end + C_size[0] * 2) - 1];

            /*              Segment(c).point = double([X Y Z]-1); */
            if (((int32_T)qY < 1) || ((int32_T)qY > 2048)) {
              emlrtDynamicBoundsCheckR2012b((int32_T)qY, 1, 2048, &hf_emlrtBCI,
                sp);
            }

            SegP[(int32_T)qY - 1] = X - 1.0;
            SegP[(int32_T)qY + 2047] = Y - 1.0;
            SegP[(int32_T)qY + 4095] = Z - 1.0;
            c = qY + 1U;
            i = (int32_T)Y;
            if ((i < 1) || (i > L_BPgroup->size[0])) {
              emlrtDynamicBoundsCheckR2012b(i, 1, L_BPgroup->size[0],
                &vh_emlrtBCI, sp);
            }

            i1 = (int32_T)X;
            if ((i1 < 1) || (i1 > L_BPgroup->size[1])) {
              emlrtDynamicBoundsCheckR2012b(i1, 1, L_BPgroup->size[1],
                &vh_emlrtBCI, sp);
            }

            i2 = (int32_T)Z;
            if ((i2 < 1) || (i2 > L_BPgroup->size[2])) {
              emlrtDynamicBoundsCheckR2012b(i2, 1, L_BPgroup->size[2],
                &vh_emlrtBCI, sp);
            }

            Lnum = L_BPgroup->data[((i + L_BPgroup->size[0] * (i1 - 1)) +
              L_BPgroup->size[0] * L_BPgroup->size[1] * (i2 - 1)) - 1];
            i = FindNearestBP->size[0] * FindNearestBP->size[1] *
              FindNearestBP->size[2];
            FindNearestBP->size[0] = L_BPgroup->size[0];
            FindNearestBP->size[1] = L_BPgroup->size[1];
            FindNearestBP->size[2] = L_BPgroup->size[2];
            emxEnsureCapacity_boolean_T(sp, FindNearestBP, i, &yh_emlrtRTEI);
            loop_ub = L_BPgroup->size[0] * L_BPgroup->size[1] * L_BPgroup->size
              [2];
            for (i = 0; i < loop_ub; i++) {
              FindNearestBP->data[i] = (L_BPgroup->data[i] == Lnum);
            }

            emlrtSizeEqCheckNDR2012b(*(int32_T (*)[3])BPcentroid->size,
              *(int32_T (*)[3])FindNearestBP->size, &u_emlrtECI, sp);
            loop_ub = BPcentroid->size[0] * BPcentroid->size[1] *
              BPcentroid->size[2];
            i = FindNearestBP->size[0] * FindNearestBP->size[1] *
              FindNearestBP->size[2];
            FindNearestBP->size[0] = BPcentroid->size[0];
            FindNearestBP->size[1] = BPcentroid->size[1];
            FindNearestBP->size[2] = BPcentroid->size[2];
            emxEnsureCapacity_boolean_T(sp, FindNearestBP, i, &bi_emlrtRTEI);
            for (i = 0; i < loop_ub; i++) {
              FindNearestBP->data[i] = (BPcentroid->data[i] &&
                FindNearestBP->data[i]);
            }

            st.site = &sl_emlrtRSI;
            BPcentroid_idx_0 = FindNearestBP->size[0] * FindNearestBP->size[1] *
              FindNearestBP->size[2];
            b_BPcentroid = *FindNearestBP;
            j_BPcentroid[0] = BPcentroid_idx_0;
            b_BPcentroid.size = &j_BPcentroid[0];
            b_BPcentroid.numDimensions = 1;
            b_st.site = &cd_emlrtRSI;
            eml_find(&b_st, &b_BPcentroid, ii);
            st.site = &sl_emlrtRSI;
            d_BPcentroid[0] = FindNearestBP->size[0];
            d_BPcentroid[1] = FindNearestBP->size[1];
            d_BPcentroid[2] = FindNearestBP->size[2];
            i = b_ii->size[0];
            b_ii->size[0] = ii->size[0];
            emxEnsureCapacity_real_T(&st, b_ii, i, &lb_emlrtRTEI);
            loop_ub = ii->size[0];
            for (i = 0; i < loop_ub; i++) {
              b_ii->data[i] = ii->data[i];
            }

            b_st.site = &hd_emlrtRSI;
            ind2sub_indexClass(&b_st, d_BPcentroid, b_ii, varargout_4, ii,
                               varargout_6);
            i = b_varargout_4->size[0];
            b_varargout_4->size[0] = varargout_4->size[0];
            emxEnsureCapacity_real_T(sp, b_varargout_4, i, &nb_emlrtRTEI);
            loop_ub = varargout_4->size[0];
            for (i = 0; i < loop_ub; i++) {
              b_varargout_4->data[i] = varargout_4->data[i];
            }

            i = LEN->size[0];
            LEN->size[0] = ii->size[0];
            emxEnsureCapacity_real_T(sp, LEN, i, &nb_emlrtRTEI);
            loop_ub = ii->size[0];
            for (i = 0; i < loop_ub; i++) {
              LEN->data[i] = ii->data[i];
            }

            i = b_varargout_6->size[0];
            b_varargout_6->size[0] = varargout_6->size[0];
            emxEnsureCapacity_real_T(sp, b_varargout_6, i, &nb_emlrtRTEI);
            loop_ub = varargout_6->size[0];
            for (i = 0; i < loop_ub; i++) {
              b_varargout_6->data[i] = varargout_6->data[i];
            }

            st.site = &rl_emlrtRSI;
            b_cat(&st, b_varargout_4, LEN, b_varargout_6, Fyxz);

            /*              try */
            if (Fyxz->size[0] > 1) {
              d_BPcentroid[0] = Y;
              d_BPcentroid[1] = X;
              d_BPcentroid[2] = Z;
              C[0] = (real_T)Fyxz->size[0] - 1.0;
              C[1] = 0.0;
              st.site = &ql_emlrtRSI;
              b_padarray(&st, d_BPcentroid, C, lenp);

              /*                  p = repmat([Y X Z],[size(Fyxz,1) 1]); */
              /*              catch err */
            } else {
              /*                  warning(err.message) */
              /*                  disp(['*****Current Pointdata Number is ' num2str(Pdata_count) '*****']) */
              /*                  disp('   1.1---> Find Nearest Branch Point(centroid)') */
              /*                  disp('**********************************************') */
              st.site = &pl_emlrtRSI;
              BPcentroid_idx_0 = BPcentroid->size[0] * BPcentroid->size[1] *
                BPcentroid->size[2];
              b_BPcentroid = *BPcentroid;
              l_BPcentroid[0] = BPcentroid_idx_0;
              b_BPcentroid.size = &l_BPcentroid[0];
              b_BPcentroid.numDimensions = 1;
              b_st.site = &cd_emlrtRSI;
              eml_find(&b_st, &b_BPcentroid, ii);
              st.site = &pl_emlrtRSI;
              d_BPcentroid[0] = BPcentroid->size[0];
              d_BPcentroid[1] = BPcentroid->size[1];
              d_BPcentroid[2] = BPcentroid->size[2];
              i = b_ii->size[0];
              b_ii->size[0] = ii->size[0];
              emxEnsureCapacity_real_T(&st, b_ii, i, &lb_emlrtRTEI);
              loop_ub = ii->size[0];
              for (i = 0; i < loop_ub; i++) {
                b_ii->data[i] = ii->data[i];
              }

              b_st.site = &hd_emlrtRSI;
              ind2sub_indexClass(&b_st, d_BPcentroid, b_ii, varargout_4, ii,
                                 varargout_6);
              i = b_varargout_4->size[0];
              b_varargout_4->size[0] = varargout_4->size[0];
              emxEnsureCapacity_real_T(sp, b_varargout_4, i, &nb_emlrtRTEI);
              loop_ub = varargout_4->size[0];
              for (i = 0; i < loop_ub; i++) {
                b_varargout_4->data[i] = varargout_4->data[i];
              }

              i = LEN->size[0];
              LEN->size[0] = ii->size[0];
              emxEnsureCapacity_real_T(sp, LEN, i, &nb_emlrtRTEI);
              loop_ub = ii->size[0];
              for (i = 0; i < loop_ub; i++) {
                LEN->data[i] = ii->data[i];
              }

              i = b_varargout_6->size[0];
              b_varargout_6->size[0] = varargout_6->size[0];
              emxEnsureCapacity_real_T(sp, b_varargout_6, i, &nb_emlrtRTEI);
              loop_ub = varargout_6->size[0];
              for (i = 0; i < loop_ub; i++) {
                b_varargout_6->data[i] = varargout_6->data[i];
              }

              st.site = &ol_emlrtRSI;
              b_cat(&st, b_varargout_4, LEN, b_varargout_6, Fyxz);
              d_BPcentroid[0] = Y;
              d_BPcentroid[1] = X;
              d_BPcentroid[2] = Z;
              C[0] = Fyxz->size[0];
              C[1] = 1.0;
              st.site = &nl_emlrtRSI;
              b_repmat(&st, d_BPcentroid, C, lenp);
            }

            emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])Fyxz->size, *(int32_T (*)
              [2])lenp->size, &v_emlrtECI, sp);
            i = BPxyz->size[0] * BPxyz->size[1];
            BPxyz->size[0] = Fyxz->size[0];
            BPxyz->size[1] = 3;
            emxEnsureCapacity_real_T(sp, BPxyz, i, &di_emlrtRTEI);
            loop_ub = Fyxz->size[0] * Fyxz->size[1];
            for (i = 0; i < loop_ub; i++) {
              BPxyz->data[i] = Fyxz->data[i] - lenp->data[i];
            }

            st.site = &ml_emlrtRSI;
            power(&st, BPxyz, lenp);
            st.site = &ml_emlrtRSI;
            g_sum(&st, lenp, LEN);
            st.site = &ll_emlrtRSI;
            b_st.site = &rf_emlrtRSI;
            c_st.site = &sf_emlrtRSI;
            d_st.site = &tf_emlrtRSI;
            if (LEN->size[0] < 1) {
              emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
                "Coder:toolbox:eml_min_or_max_varDimZero",
                "Coder:toolbox:eml_min_or_max_varDimZero", 0);
            }

            e_st.site = &uf_emlrtRSI;
            n = LEN->size[0];
            if (LEN->size[0] <= 2) {
              if (LEN->size[0] == 1) {
                end = 1;
              } else if ((LEN->data[0] > LEN->data[1]) || (muDoubleScalarIsNaN
                          (LEN->data[0]) && (!muDoubleScalarIsNaN(LEN->data[1]))))
              {
                end = 2;
              } else {
                end = 1;
              }
            } else {
              f_st.site = &xd_emlrtRSI;
              if (!muDoubleScalarIsNaN(LEN->data[0])) {
                end = 1;
              } else {
                end = 0;
                g_st.site = &yd_emlrtRSI;
                if (LEN->size[0] > 2147483646) {
                  h_st.site = &i_emlrtRSI;
                  check_forloop_overflow_error(&h_st);
                }

                k = 2;
                exitg1 = false;
                while ((!exitg1) && (k <= LEN->size[0])) {
                  if (!muDoubleScalarIsNaN(LEN->data[k - 1])) {
                    end = k;
                    exitg1 = true;
                  } else {
                    k++;
                  }
                }
              }

              if (end == 0) {
                end = 1;
              } else {
                f_st.site = &vd_emlrtRSI;
                b_ex = LEN->data[end - 1];
                loop_ub = end + 1;
                g_st.site = &wd_emlrtRSI;
                if ((end + 1 <= LEN->size[0]) && (LEN->size[0] > 2147483646)) {
                  h_st.site = &i_emlrtRSI;
                  check_forloop_overflow_error(&h_st);
                }

                for (k = loop_ub; k <= n; k++) {
                  d = LEN->data[k - 1];
                  if (b_ex > d) {
                    b_ex = d;
                    end = k;
                  }
                }
              }
            }

            if ((end < 1) || (end > Fyxz->size[0])) {
              emlrtDynamicBoundsCheckR2012b(end, 1, Fyxz->size[0], &hi_emlrtBCI,
                sp);
            }

            X = Fyxz->data[(end + Fyxz->size[0]) - 1];
            if (end > Fyxz->size[0]) {
              emlrtDynamicBoundsCheckR2012b(end, 1, Fyxz->size[0], &ii_emlrtBCI,
                sp);
            }

            Y = Fyxz->data[end - 1];
            if (end > Fyxz->size[0]) {
              emlrtDynamicBoundsCheckR2012b(end, 1, Fyxz->size[0], &ji_emlrtBCI,
                sp);
            }

            Z = Fyxz->data[(end + Fyxz->size[0] * 2) - 1];

            /*              Segment(c).point = double([X Y Z]-1); */
            if (((int32_T)c < 1) || ((int32_T)c > 2048)) {
              emlrtDynamicBoundsCheckR2012b((int32_T)c, 1, 2048, &if_emlrtBCI,
                sp);
            }

            /* clear  Fyxz Ind LEN p Fy Fx Fz FindNearestBP Lnum BPGy BPGx BPGz BPG */
            /*              TYPE = 'End to Branch'; */
            Output_Pointdata[Pdata_count].Type = 1.0;
            SegP[(int32_T)c - 1] = X - 1.0;
            BranchPoint[0] = X - 1.0;
            SegP[(int32_T)c + 2047] = Y - 1.0;
            BranchPoint[2] = Y - 1.0;
            SegP[(int32_T)c + 4095] = Z - 1.0;
            BranchPoint[4] = Z - 1.0;
            Go2Next = false;
          } else {
            maxval = bwthindata->data[(maxval_tmp + bwthindata->size[0] *
              b_maxval_tmp) + bwthindata->size[0] * bwthindata->size[1] *
              c_maxval_tmp];
            for (k = 0; k < 26; k++) {
              b = bwthindata->data[(((int32_T)bp1[(k + 1) % 3] +
                bwthindata->size[0] * ((int32_T)BPcentroid_ROI_tmp[(k + 1) / 3 %
                3] - 1)) + bwthindata->size[0] * bwthindata->size[1] * ((int32_T)
                b_BPcentroid_ROI_tmp[(k + 1) / 9] - 1)) - 1];
              maxval = (((int32_T)maxval < (int32_T)b) || maxval);
            }

            if (!maxval) {
              /*              TYPE = 'End to End'; */
              Output_Pointdata[Pdata_count].Type = 5.0;
              Go2Next = false;
            } else {
              st.site = &kl_emlrtRSI;
              for (i = 0; i < 3; i++) {
                end = (int32_T)b_BPcentroid_ROI_tmp[i] - 1;
                for (i3 = 0; i3 < 3; i3++) {
                  partialTrueCount = (int32_T)BPcentroid_ROI_tmp[i3] - 1;
                  loop_ub = 3 * i3 + 9 * i;
                  BPgroup_ROI[loop_ub] = bwthindata->data[(maxval_tmp +
                    bwthindata->size[0] * partialTrueCount) + bwthindata->size[0]
                    * bwthindata->size[1] * end];
                  BPgroup_ROI[loop_ub + 1] = bwthindata->data[((i1 +
                    bwthindata->size[0] * partialTrueCount) + bwthindata->size[0]
                    * bwthindata->size[1] * end) - 1];
                  BPgroup_ROI[loop_ub + 2] = bwthindata->data[((i2 +
                    bwthindata->size[0] * partialTrueCount) + bwthindata->size[0]
                    * bwthindata->size[1] * end) - 1];
                }
              }

              b_st.site = &cd_emlrtRSI;
              b_eml_find(&b_st, BPgroup_ROI, ii_data, ii_size);
              st.site = &kl_emlrtRSI;
              b_ii_size[0] = ii_size[0];
              loop_ub = ii_size[0];
              for (i = 0; i < loop_ub; i++) {
                b_ii_data[i] = ii_data[i];
              }

              c_ii_size[0] = b_ii_size[0];
              b_st.site = &hd_emlrtRSI;
              b_ind2sub_indexClass(&b_st, b_ii_data, c_ii_size, ii_data, ii_size,
                                   varargout_5_data, varargout_5_size,
                                   varargout_6_data, varargout_6_size);
              b_ii_size[0] = ii_size[0];
              loop_ub = ii_size[0];
              for (i = 0; i < loop_ub; i++) {
                b_ii_data[i] = ((real_T)ii_data[i] + Y) - 2.0;
              }

              b_varargout_5_size[0] = varargout_5_size[0];
              loop_ub = varargout_5_size[0];
              for (i = 0; i < loop_ub; i++) {
                b_varargout_5_data[i] = ((real_T)varargout_5_data[i] + X) - 2.0;
              }

              b_varargout_6_size[0] = varargout_6_size[0];
              loop_ub = varargout_6_size[0];
              for (i = 0; i < loop_ub; i++) {
                b_varargout_6_data[i] = ((real_T)varargout_6_data[i] + Z) - 2.0;
              }

              f_ii_data.data = &b_ii_data[0];
              f_ii_data.size = &b_ii_size[0];
              f_ii_data.allocatedSize = 27;
              f_ii_data.numDimensions = 1;
              f_ii_data.canFreeData = false;
              f_varargout_5_data.data = &b_varargout_5_data[0];
              f_varargout_5_data.size = &b_varargout_5_size[0];
              f_varargout_5_data.allocatedSize = 27;
              f_varargout_5_data.numDimensions = 1;
              f_varargout_5_data.canFreeData = false;
              f_varargout_6_data.data = &b_varargout_6_data[0];
              f_varargout_6_data.size = &b_varargout_6_size[0];
              f_varargout_6_data.allocatedSize = 27;
              f_varargout_6_data.numDimensions = 1;
              f_varargout_6_data.canFreeData = false;
              st.site = &jl_emlrtRSI;
              b_cat(&st, &f_ii_data, &f_varargout_5_data, &f_varargout_6_data,
                    lenp);
              C_size[0] = lenp->size[0];
              C_size[1] = 3;
              loop_ub = lenp->size[0] * lenp->size[1];
              for (i = 0; i < loop_ub; i++) {
                C_data[i] = lenp->data[i];
              }

              C[0] = C_size[0];
              C[1] = 1.0;
              st.site = &il_emlrtRSI;
              b_repmat(&st, b_lenp, C, lenp);
              emlrtSizeEqCheckNDR2012b(C_size, *(int32_T (*)[2])lenp->size,
                &w_emlrtECI, sp);
              b_C_size[0] = C_size[0];
              b_C_size[1] = 3;
              loop_ub = C_size[0] * 3;
              for (i = 0; i < loop_ub; i++) {
                c_C_data[i] = C_data[i] - lenp->data[i];
              }

              f_C_data.data = &c_C_data[0];
              f_C_data.size = &b_C_size[0];
              f_C_data.allocatedSize = 81;
              f_C_data.numDimensions = 2;
              f_C_data.canFreeData = false;
              st.site = &hl_emlrtRSI;
              power(&st, &f_C_data, lenp);
              st.site = &hl_emlrtRSI;
              g_sum(&st, lenp, LEN);
              st.site = &gl_emlrtRSI;
              b_st.site = &rf_emlrtRSI;
              c_st.site = &sf_emlrtRSI;
              d_st.site = &tf_emlrtRSI;
              if (LEN->size[0] < 1) {
                emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
                  "Coder:toolbox:eml_min_or_max_varDimZero",
                  "Coder:toolbox:eml_min_or_max_varDimZero", 0);
              }

              e_st.site = &uf_emlrtRSI;
              n = LEN->size[0];
              if (LEN->size[0] <= 2) {
                if (LEN->size[0] == 1) {
                  end = 1;
                } else if ((LEN->data[0] > LEN->data[1]) || (muDoubleScalarIsNaN
                            (LEN->data[0]) && (!muDoubleScalarIsNaN(LEN->data[1]))))
                {
                  end = 2;
                } else {
                  end = 1;
                }
              } else {
                f_st.site = &xd_emlrtRSI;
                if (!muDoubleScalarIsNaN(LEN->data[0])) {
                  end = 1;
                } else {
                  end = 0;
                  g_st.site = &yd_emlrtRSI;
                  if (LEN->size[0] > 2147483646) {
                    h_st.site = &i_emlrtRSI;
                    check_forloop_overflow_error(&h_st);
                  }

                  k = 2;
                  exitg1 = false;
                  while ((!exitg1) && (k <= LEN->size[0])) {
                    if (!muDoubleScalarIsNaN(LEN->data[k - 1])) {
                      end = k;
                      exitg1 = true;
                    } else {
                      k++;
                    }
                  }
                }

                if (end == 0) {
                  end = 1;
                } else {
                  f_st.site = &vd_emlrtRSI;
                  b_ex = LEN->data[end - 1];
                  loop_ub = end + 1;
                  g_st.site = &wd_emlrtRSI;
                  if ((end + 1 <= LEN->size[0]) && (LEN->size[0] > 2147483646))
                  {
                    h_st.site = &i_emlrtRSI;
                    check_forloop_overflow_error(&h_st);
                  }

                  for (k = loop_ub; k <= n; k++) {
                    d = LEN->data[k - 1];
                    if (b_ex > d) {
                      b_ex = d;
                      end = k;
                    }
                  }
                }
              }

              if ((end < 1) || (end > C_size[0])) {
                emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &th_emlrtBCI,
                  sp);
              }

              X = C_data[(end + C_size[0]) - 1];
              if (end > C_size[0]) {
                emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &uh_emlrtBCI,
                  sp);
              }

              Y = C_data[end - 1];
              if (end > C_size[0]) {
                emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &wh_emlrtBCI,
                  sp);
              }

              Z = C_data[(end + C_size[0] * 2) - 1];

              /*              Segment(c).point = double([X Y Z]-1); */
              if (((int32_T)qY < 1) || ((int32_T)qY > 2048)) {
                emlrtDynamicBoundsCheckR2012b((int32_T)qY, 1, 2048, &jf_emlrtBCI,
                  sp);
              }

              SegP[(int32_T)qY - 1] = X - 1.0;
              SegP[(int32_T)qY + 2047] = Y - 1.0;
              SegP[(int32_T)qY + 4095] = Z - 1.0;
              i = (int32_T)Y;
              if ((i < 1) || (i > bwthindata->size[0])) {
                emlrtDynamicBoundsCheckR2012b(i, 1, bwthindata->size[0],
                  &xh_emlrtBCI, sp);
              }

              i1 = (int32_T)X;
              if ((i1 < 1) || (i1 > bwthindata->size[1])) {
                emlrtDynamicBoundsCheckR2012b(i1, 1, bwthindata->size[1],
                  &xh_emlrtBCI, sp);
              }

              i2 = (int32_T)Z;
              if ((i2 < 1) || (i2 > bwthindata->size[2])) {
                emlrtDynamicBoundsCheckR2012b(i2, 1, bwthindata->size[2],
                  &xh_emlrtBCI, sp);
              }

              bwthindata->data[((i + bwthindata->size[0] * (i1 - 1)) +
                                bwthindata->size[0] * bwthindata->size[1] * (i2
                - 1)) - 1] = false;
              i = (int32_T)Y;
              if ((i < 1) || (i > EndP->size[0])) {
                emlrtDynamicBoundsCheckR2012b(i, 1, EndP->size[0], &yh_emlrtBCI,
                  sp);
              }

              i1 = (int32_T)X;
              if ((i1 < 1) || (i1 > EndP->size[1])) {
                emlrtDynamicBoundsCheckR2012b(i1, 1, EndP->size[1], &yh_emlrtBCI,
                  sp);
              }

              i2 = (int32_T)Z;
              if ((i2 < 1) || (i2 > EndP->size[2])) {
                emlrtDynamicBoundsCheckR2012b(i2, 1, EndP->size[2], &yh_emlrtBCI,
                  sp);
              }

              if (EndP->data[((i + EndP->size[0] * (i1 - 1)) + EndP->size[0] *
                              EndP->size[1] * (i2 - 1)) - 1]) {
                /*                  TYPE = 'End to End'; */
                Output_Pointdata[Pdata_count].Type = 5.0;
                Go2Next = false;
              }

              /* clear  Ind LEN Lnum Cy Cx Cz C */
            }
          }
        }

        /* clear  leny lenx lenz lenp LEN Index */
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(sp);
        }
      }

      /*      Point4Len = cat(1,Segment.point); */
      if (((int32_T)c < 1) || ((int32_T)c > 2048)) {
        emlrtDynamicBoundsCheckR2012b((int32_T)c, 1, 2048, &kf_emlrtBCI, sp);
      }

      b_c[0] = (int32_T)c;
      b_c[1] = 3;
      iv[0] = (int32_T)c;
      iv[1] = 3;
      emlrtSubAssignSizeCheckR2012b(&b_c[0], 2, &iv[0], 2, &x_emlrtECI, sp);
      loop_ub = (int32_T)c;
      for (i = 0; i < 3; i++) {
        for (i1 = 0; i1 < loop_ub; i1++) {
          i2 = Pdata_count + 1;
          if ((i2 < 1) || (i2 > 32768)) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, 32768, &fh_emlrtBCI, sp);
          }

          i3 = i1 + (i << 11);
          Output_Pointdata[i2 - 1].PointXYZ[i3] = SegP[i3];
        }
      }

      /*      Pdata(Pdata_count).PointXYZ = Point4Len; */
      /*  % Lenght by bilinear */
      for (i = 0; i < 2048; i++) {
        x[i] = !muDoubleScalarIsNaN(SegP[i]);
      }

      partialTrueCount = x[0];
      for (k = 0; k < 2047; k++) {
        partialTrueCount += x[k + 1];
      }

      if (partialTrueCount == 1) {
        Output_Pointdata[Pdata_count].Length = 0.0;
      } else {
        diff(SegP, dv);
        c_repmat(Reso, dv1);
        for (i = 0; i < 6141; i++) {
          dv1[i] *= dv[i];
        }

        b_power(dv1, dv);
        st.site = &fl_emlrtRSI;
        nansum(&st, dv, dv2);
        st.site = &fl_emlrtRSI;
        d_sqrt(&st, dv2);
        Output_Pointdata[Pdata_count].Length = b_nansum(dv2);
      }

      for (i = 0; i < 6144; i++) {
        SegP[i] = rtNaN;
      }

      for (i = 0; i < 6; i++) {
        Output_Pointdata[Pdata_count].Branch[i] = BranchPoint[i];
      }

      Pdata_count++;
    }

    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_boolean_T(&EndP);

  /*  disp(['End Point Num.:' num2str(n) ', Segment(bp-end) NUM.:' num2str(Pdata_count-1)]) */
  /*  Next Step */
  st.site = &sn_emlrtRSI;
  disp(&st, c_emlrt_marshallOut(&st, cv2), &e_emlrtMCI);
  st.site = &el_emlrtRSI;
  TS_skel2endpoint(&st, bwthindata, FindNearestBP);

  /*  2nd Segment Branch - Branch */
  st.site = &dl_emlrtRSI;
  BPcentroid_idx_0 = FindNearestBP->size[0] * FindNearestBP->size[1] *
    FindNearestBP->size[2];
  b_BPcentroid = *FindNearestBP;
  h_BPcentroid[0] = BPcentroid_idx_0;
  b_BPcentroid.size = &h_BPcentroid[0];
  b_BPcentroid.numDimensions = 1;
  b_st.site = &cd_emlrtRSI;
  eml_find(&b_st, &b_BPcentroid, ii);
  st.site = &dl_emlrtRSI;
  d_BPcentroid[0] = FindNearestBP->size[0];
  d_BPcentroid[1] = FindNearestBP->size[1];
  d_BPcentroid[2] = FindNearestBP->size[2];
  i = b_ii->size[0];
  b_ii->size[0] = ii->size[0];
  emxEnsureCapacity_real_T(&st, b_ii, i, &lb_emlrtRTEI);
  loop_ub = ii->size[0];
  for (i = 0; i < loop_ub; i++) {
    b_ii->data[i] = ii->data[i];
  }

  b_st.site = &hd_emlrtRSI;
  ind2sub_indexClass(&b_st, d_BPcentroid, b_ii, varargout_4, ii, varargout_6);
  i = NewEy->size[0];
  NewEy->size[0] = varargout_4->size[0];
  emxEnsureCapacity_int32_T(&st, NewEy, i, &mb_emlrtRTEI);
  loop_ub = varargout_4->size[0];
  for (i = 0; i < loop_ub; i++) {
    NewEy->data[i] = varargout_4->data[i];
  }

  i = NewEx->size[0];
  NewEx->size[0] = ii->size[0];
  emxEnsureCapacity_int32_T(&st, NewEx, i, &mb_emlrtRTEI);
  loop_ub = ii->size[0];
  for (i = 0; i < loop_ub; i++) {
    NewEx->data[i] = ii->data[i];
  }

  i = NewEz->size[0];
  NewEz->size[0] = varargout_6->size[0];
  emxEnsureCapacity_int32_T(&st, NewEz, i, &mb_emlrtRTEI);
  loop_ub = varargout_6->size[0];
  for (i = 0; i < loop_ub; i++) {
    NewEz->data[i] = varargout_6->data[i];
  }

  i = NewEy->size[0];
  emxInit_boolean_T(sp, &r2, 1, &fh_emlrtRTEI, true);
  emxInit_int32_T(sp, &r3, 1, &cj_emlrtRTEI, true);
  emxInit_boolean_T(sp, &b_L_BPgroup, 1, &th_emlrtRTEI, true);
  for (b_n = 0; b_n < i; b_n++) {
    i1 = b_n + 1;
    if ((i1 < 1) || (i1 > NewEy->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, NewEy->size[0], &dh_emlrtBCI, sp);
    }

    Y = NewEy->data[i1 - 1];
    i1 = b_n + 1;
    if ((i1 < 1) || (i1 > NewEx->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, NewEx->size[0], &eh_emlrtBCI, sp);
    }

    X = NewEx->data[i1 - 1];
    i1 = b_n + 1;
    if ((i1 < 1) || (i1 > NewEz->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, NewEz->size[0], &gh_emlrtBCI, sp);
    }

    Z = NewEz->data[i1 - 1];
    for (i1 = 0; i1 < 6; i1++) {
      BranchPoint[i1] = rtNaN;
    }

    /*      TYPE = 'Branch to Branch'; */
    TYPEnum = 0.0;

    /*  % End point check(End-End�͓�Ԗڂ�EndPoint�������Ă��܂����߁B) */
    if ((NewEy->data[b_n] < 1) || (NewEy->data[b_n] > bwthindata->size[0])) {
      emlrtDynamicBoundsCheckR2012b(NewEy->data[b_n], 1, bwthindata->size[0],
        &hh_emlrtBCI, sp);
    }

    if ((NewEx->data[b_n] < 1) || (NewEx->data[b_n] > bwthindata->size[1])) {
      emlrtDynamicBoundsCheckR2012b(NewEx->data[b_n], 1, bwthindata->size[1],
        &hh_emlrtBCI, sp);
    }

    if ((NewEz->data[b_n] < 1) || (NewEz->data[b_n] > bwthindata->size[2])) {
      emlrtDynamicBoundsCheckR2012b(NewEz->data[b_n], 1, bwthindata->size[2],
        &hh_emlrtBCI, sp);
    }

    if (bwthindata->data[((NewEy->data[b_n] + bwthindata->size[0] * (NewEx->
           data[b_n] - 1)) + bwthindata->size[0] * bwthindata->size[1] *
                          (NewEz->data[b_n] - 1)) - 1]) {
      /*      Segment = struct('point',[]); */
      /*     %% Find Nearest BPgroup */
      /*  3x3x3 crop */
      /* 11     BPcentroid_ROI = BPcentroid(Y-1:Y+1,X-1:X+1,Z-1:Z+1); */
      BPcentroid_ROI_tmp[0] = (real_T)NewEy->data[b_n] + -1.0;
      b_BPcentroid_ROI_tmp[0] = (real_T)NewEx->data[b_n] + -1.0;
      b_lenp[0] = (real_T)NewEz->data[b_n] + -1.0;
      BPcentroid_ROI_tmp[1] = NewEy->data[b_n];
      b_BPcentroid_ROI_tmp[1] = NewEx->data[b_n];
      b_lenp[1] = NewEz->data[b_n];
      BPcentroid_ROI_tmp[2] = (real_T)NewEy->data[b_n] + 1.0;
      b_BPcentroid_ROI_tmp[2] = (real_T)NewEx->data[b_n] + 1.0;
      b_lenp[2] = (real_T)NewEz->data[b_n] + 1.0;
      i1 = NewEy->data[b_n] + -1;
      if ((i1 < 1) || (i1 > BPgroup->size[0])) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, BPgroup->size[0], &gj_emlrtBCI, sp);
      }

      i2 = (int32_T)BPcentroid_ROI_tmp[1];
      if (((int32_T)BPcentroid_ROI_tmp[1] < 1) || ((int32_T)BPcentroid_ROI_tmp[1]
           > BPgroup->size[0])) {
        emlrtDynamicBoundsCheckR2012b((int32_T)BPcentroid_ROI_tmp[1], 1,
          BPgroup->size[0], &gj_emlrtBCI, sp);
      }

      i3 = (int32_T)BPcentroid_ROI_tmp[2];
      if ((i3 < 1) || (i3 > BPgroup->size[0])) {
        emlrtDynamicBoundsCheckR2012b(i3, 1, BPgroup->size[0], &gj_emlrtBCI, sp);
      }

      i4 = NewEx->data[b_n] + -1;
      if ((i4 < 1) || (i4 > BPgroup->size[1])) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, BPgroup->size[1], &hj_emlrtBCI, sp);
      }

      if (((int32_T)b_BPcentroid_ROI_tmp[1] < 1) || ((int32_T)
           b_BPcentroid_ROI_tmp[1] > BPgroup->size[1])) {
        emlrtDynamicBoundsCheckR2012b((int32_T)b_BPcentroid_ROI_tmp[1], 1,
          BPgroup->size[1], &hj_emlrtBCI, sp);
      }

      i5 = (int32_T)b_BPcentroid_ROI_tmp[2];
      if ((i5 < 1) || (i5 > BPgroup->size[1])) {
        emlrtDynamicBoundsCheckR2012b(i5, 1, BPgroup->size[1], &hj_emlrtBCI, sp);
      }

      i5 = NewEz->data[b_n] + -1;
      if ((i5 < 1) || (i5 > BPgroup->size[2])) {
        emlrtDynamicBoundsCheckR2012b(i5, 1, BPgroup->size[2], &ij_emlrtBCI, sp);
      }

      if (((int32_T)b_lenp[1] < 1) || ((int32_T)b_lenp[1] > BPgroup->size[2])) {
        emlrtDynamicBoundsCheckR2012b((int32_T)b_lenp[1], 1, BPgroup->size[2],
          &ij_emlrtBCI, sp);
      }

      loop_ub = (int32_T)b_lenp[2];
      if ((loop_ub < 1) || (loop_ub > BPgroup->size[2])) {
        emlrtDynamicBoundsCheckR2012b(loop_ub, 1, BPgroup->size[2], &ij_emlrtBCI,
          sp);
      }

      if ((NewEy->data[b_n] < 1) || (NewEy->data[b_n] > bwthindata->size[0])) {
        emlrtDynamicBoundsCheckR2012b(NewEy->data[b_n], 1, bwthindata->size[0],
          &kh_emlrtBCI, sp);
      }

      if ((NewEx->data[b_n] < 1) || (NewEx->data[b_n] > bwthindata->size[1])) {
        emlrtDynamicBoundsCheckR2012b(NewEx->data[b_n], 1, bwthindata->size[1],
          &kh_emlrtBCI, sp);
      }

      if ((NewEz->data[b_n] < 1) || (NewEz->data[b_n] > bwthindata->size[2])) {
        emlrtDynamicBoundsCheckR2012b(NewEz->data[b_n], 1, bwthindata->size[2],
          &kh_emlrtBCI, sp);
      }

      bwthindata->data[((NewEy->data[b_n] + bwthindata->size[0] * (NewEx->
        data[b_n] - 1)) + bwthindata->size[0] * bwthindata->size[1] *
                        (NewEz->data[b_n] - 1)) - 1] = false;
      for (loop_ub = 0; loop_ub < 3; loop_ub++) {
        k = (int32_T)b_lenp[loop_ub];
        for (end = 0; end < 3; end++) {
          if (i1 > bwthindata->size[0]) {
            emlrtDynamicBoundsCheckR2012b(i1, 1, bwthindata->size[0],
              &jj_emlrtBCI, sp);
          }

          partialTrueCount = (int32_T)b_BPcentroid_ROI_tmp[end];
          if ((partialTrueCount < 1) || (partialTrueCount > bwthindata->size[1]))
          {
            emlrtDynamicBoundsCheckR2012b(partialTrueCount, 1, bwthindata->size
              [1], &kj_emlrtBCI, sp);
          }

          if ((k < 1) || (k > bwthindata->size[2])) {
            emlrtDynamicBoundsCheckR2012b(k, 1, bwthindata->size[2],
              &lj_emlrtBCI, sp);
          }

          n = 3 * end + 9 * loop_ub;
          ROI[n] = bwthindata->data[((i1 + bwthindata->size[0] *
            (partialTrueCount - 1)) + bwthindata->size[0] * bwthindata->size[1] *
            (k - 1)) - 1];
          if (i2 > bwthindata->size[0]) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, bwthindata->size[0],
              &jj_emlrtBCI, sp);
          }

          if (partialTrueCount > bwthindata->size[1]) {
            emlrtDynamicBoundsCheckR2012b(partialTrueCount, 1, bwthindata->size
              [1], &kj_emlrtBCI, sp);
          }

          if (k > bwthindata->size[2]) {
            emlrtDynamicBoundsCheckR2012b(k, 1, bwthindata->size[2],
              &lj_emlrtBCI, sp);
          }

          ROI[n + 1] = bwthindata->data[((i2 + bwthindata->size[0] *
            (partialTrueCount - 1)) + bwthindata->size[0] * bwthindata->size[1] *
            (k - 1)) - 1];
          if (i3 > bwthindata->size[0]) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, bwthindata->size[0],
              &jj_emlrtBCI, sp);
          }

          if (partialTrueCount > bwthindata->size[1]) {
            emlrtDynamicBoundsCheckR2012b(partialTrueCount, 1, bwthindata->size
              [1], &kj_emlrtBCI, sp);
          }

          if (k > bwthindata->size[2]) {
            emlrtDynamicBoundsCheckR2012b(k, 1, bwthindata->size[2],
              &lj_emlrtBCI, sp);
          }

          ROI[n + 2] = bwthindata->data[((i3 + bwthindata->size[0] *
            (partialTrueCount - 1)) + bwthindata->size[0] * bwthindata->size[1] *
            (k - 1)) - 1];
        }
      }

      maxval_tmp = i1 - 1;
      b_maxval_tmp = i4 - 1;
      c_maxval_tmp = i5 - 1;
      maxval = BPgroup->data[(maxval_tmp + BPgroup->size[0] * b_maxval_tmp) +
        BPgroup->size[0] * BPgroup->size[1] * c_maxval_tmp];
      for (k = 0; k < 26; k++) {
        b = BPgroup->data[(((int32_T)BPcentroid_ROI_tmp[(k + 1) % 3] +
                            BPgroup->size[0] * ((int32_T)b_BPcentroid_ROI_tmp[(k
          + 1) / 3 % 3] - 1)) + BPgroup->size[0] * BPgroup->size[1] * ((int32_T)
          b_lenp[(k + 1) / 9] - 1)) - 1];
        maxval = (((int32_T)maxval < (int32_T)b) || maxval);
      }

      if (!maxval) {
        /*         %% Not Exist Near BPgroup */
        /*      Segment(1).point = double([X Y Z]-1); */
        SegP[0] = (real_T)NewEx->data[b_n] - 1.0;
        SegP[2048] = (real_T)NewEy->data[b_n] - 1.0;
        SegP[4096] = (real_T)NewEz->data[b_n] - 1.0;

        /*      TYPE = 'Point'; */
        TYPEnum = rtNaN;

        /*      disp(['*****Current Pointdata Number is ' num2str(Pdata_count) '*****']) */
        /*      warning(TYPE)     */
        /*      disp('  2.1 ---> Just Point!!') */
        /*      disp('**********************************************') */
        /* 11     Go2Next = false; */
      } else {
        /*     %% Nearest */
        st.site = &cl_emlrtRSI;
        for (i1 = 0; i1 < 3; i1++) {
          end = (int32_T)b_lenp[i1] - 1;
          for (i4 = 0; i4 < 3; i4++) {
            partialTrueCount = (int32_T)b_BPcentroid_ROI_tmp[i4] - 1;
            loop_ub = 3 * i4 + 9 * i1;
            BPgroup_ROI[loop_ub] = BPgroup->data[(maxval_tmp + BPgroup->size[0] *
              partialTrueCount) + BPgroup->size[0] * BPgroup->size[1] * end];
            BPgroup_ROI[loop_ub + 1] = BPgroup->data[((i2 + BPgroup->size[0] *
              partialTrueCount) + BPgroup->size[0] * BPgroup->size[1] * end) - 1];
            BPgroup_ROI[loop_ub + 2] = BPgroup->data[((i3 + BPgroup->size[0] *
              partialTrueCount) + BPgroup->size[0] * BPgroup->size[1] * end) - 1];
          }
        }

        b_st.site = &cd_emlrtRSI;
        b_eml_find(&b_st, BPgroup_ROI, ii_data, ii_size);
        st.site = &cl_emlrtRSI;
        loop_ub = ii_size[0];
        b_ii_size[0] = ii_size[0];
        for (i1 = 0; i1 < loop_ub; i1++) {
          b_ii_data[i1] = ii_data[i1];
        }

        c_ii_size[0] = b_ii_size[0];
        b_st.site = &hd_emlrtRSI;
        b_ind2sub_indexClass(&b_st, b_ii_data, c_ii_size, ii_data, ii_size,
                             varargout_5_data, varargout_5_size,
                             varargout_6_data, varargout_6_size);
        loop_ub = ii_size[0];
        b_ii_size[0] = ii_size[0];
        for (i1 = 0; i1 < loop_ub; i1++) {
          b_ii_data[i1] = ((real_T)ii_data[i1] + (real_T)NewEy->data[b_n]) - 2.0;
        }

        loop_ub = varargout_5_size[0];
        b_varargout_5_size[0] = varargout_5_size[0];
        for (i1 = 0; i1 < loop_ub; i1++) {
          b_varargout_5_data[i1] = ((real_T)varargout_5_data[i1] + (real_T)
            NewEx->data[b_n]) - 2.0;
        }

        loop_ub = varargout_6_size[0];
        b_varargout_6_size[0] = varargout_6_size[0];
        for (i1 = 0; i1 < loop_ub; i1++) {
          b_varargout_6_data[i1] = ((real_T)varargout_6_data[i1] + (real_T)
            NewEz->data[b_n]) - 2.0;
        }

        c_ii_data.data = &b_ii_data[0];
        c_ii_data.size = &b_ii_size[0];
        c_ii_data.allocatedSize = 27;
        c_ii_data.numDimensions = 1;
        c_ii_data.canFreeData = false;
        c_varargout_5_data.data = &b_varargout_5_data[0];
        c_varargout_5_data.size = &b_varargout_5_size[0];
        c_varargout_5_data.allocatedSize = 27;
        c_varargout_5_data.numDimensions = 1;
        c_varargout_5_data.canFreeData = false;
        c_varargout_6_data.data = &b_varargout_6_data[0];
        c_varargout_6_data.size = &b_varargout_6_size[0];
        c_varargout_6_data.allocatedSize = 27;
        c_varargout_6_data.numDimensions = 1;
        c_varargout_6_data.canFreeData = false;
        st.site = &bl_emlrtRSI;
        b_cat(&st, &c_ii_data, &c_varargout_5_data, &c_varargout_6_data, lenp);
        C_size[0] = lenp->size[0];
        C_size[1] = 3;
        loop_ub = lenp->size[0] * lenp->size[1];
        for (i1 = 0; i1 < loop_ub; i1++) {
          C_data[i1] = lenp->data[i1];
        }

        d_BPcentroid[0] = NewEy->data[b_n];
        d_BPcentroid[1] = NewEx->data[b_n];
        d_BPcentroid[2] = NewEz->data[b_n];
        C[0] = C_size[0];
        C[1] = 1.0;
        st.site = &al_emlrtRSI;
        b_repmat(&st, d_BPcentroid, C, lenp);
        emlrtSizeEqCheckNDR2012b(C_size, *(int32_T (*)[2])lenp->size,
          &y_emlrtECI, sp);
        b_C_size[0] = C_size[0];
        b_C_size[1] = 3;
        loop_ub = C_size[0] * 3;
        for (i1 = 0; i1 < loop_ub; i1++) {
          c_C_data[i1] = C_data[i1] - lenp->data[i1];
        }

        b_C_data.data = &c_C_data[0];
        b_C_data.size = &b_C_size[0];
        b_C_data.allocatedSize = 81;
        b_C_data.numDimensions = 2;
        b_C_data.canFreeData = false;
        st.site = &yk_emlrtRSI;
        power(&st, &b_C_data, lenp);
        st.site = &yk_emlrtRSI;
        g_sum(&st, lenp, LEN);
        st.site = &xk_emlrtRSI;
        b_st.site = &rf_emlrtRSI;
        c_st.site = &sf_emlrtRSI;
        d_st.site = &tf_emlrtRSI;
        if (LEN->size[0] < 1) {
          emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
            "Coder:toolbox:eml_min_or_max_varDimZero",
            "Coder:toolbox:eml_min_or_max_varDimZero", 0);
        }

        e_st.site = &uf_emlrtRSI;
        n = LEN->size[0];
        if (LEN->size[0] <= 2) {
          if (LEN->size[0] == 1) {
            end = 1;
          } else if ((LEN->data[0] > LEN->data[1]) || (muDoubleScalarIsNaN
                      (LEN->data[0]) && (!muDoubleScalarIsNaN(LEN->data[1])))) {
            end = 2;
          } else {
            end = 1;
          }
        } else {
          f_st.site = &xd_emlrtRSI;
          if (!muDoubleScalarIsNaN(LEN->data[0])) {
            end = 1;
          } else {
            end = 0;
            g_st.site = &yd_emlrtRSI;
            if (LEN->size[0] > 2147483646) {
              h_st.site = &i_emlrtRSI;
              check_forloop_overflow_error(&h_st);
            }

            k = 2;
            exitg1 = false;
            while ((!exitg1) && (k <= LEN->size[0])) {
              if (!muDoubleScalarIsNaN(LEN->data[k - 1])) {
                end = k;
                exitg1 = true;
              } else {
                k++;
              }
            }
          }

          if (end == 0) {
            end = 1;
          } else {
            f_st.site = &vd_emlrtRSI;
            b_ex = LEN->data[end - 1];
            loop_ub = end + 1;
            g_st.site = &wd_emlrtRSI;
            if ((end + 1 <= LEN->size[0]) && (LEN->size[0] > 2147483646)) {
              h_st.site = &i_emlrtRSI;
              check_forloop_overflow_error(&h_st);
            }

            for (k = loop_ub; k <= n; k++) {
              d = LEN->data[k - 1];
              if (b_ex > d) {
                b_ex = d;
                end = k;
              }
            }
          }
        }

        if ((end < 1) || (end > C_size[0])) {
          emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &ai_emlrtBCI, sp);
        }

        X1 = C_data[(end + C_size[0]) - 1];
        if (end > C_size[0]) {
          emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &bi_emlrtBCI, sp);
        }

        Y1 = C_data[end - 1];
        if (end > C_size[0]) {
          emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &ci_emlrtBCI, sp);
        }

        Z1 = C_data[(end + C_size[0] * 2) - 1];
        i1 = (int32_T)Y1;
        if ((i1 < 1) || (i1 > L_BPgroup->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, L_BPgroup->size[0], &di_emlrtBCI,
            sp);
        }

        i2 = (int32_T)X1;
        if ((i2 < 1) || (i2 > L_BPgroup->size[1])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, L_BPgroup->size[1], &di_emlrtBCI,
            sp);
        }

        i3 = (int32_T)Z1;
        if ((i3 < 1) || (i3 > L_BPgroup->size[2])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, L_BPgroup->size[2], &di_emlrtBCI,
            sp);
        }

        Lnum = L_BPgroup->data[((i1 + L_BPgroup->size[0] * (i2 - 1)) +
          L_BPgroup->size[0] * L_BPgroup->size[1] * (i3 - 1)) - 1];

        /*  BPgroup or BPpoint */
        if (i1 > BPcentroid->size[0]) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, BPcentroid->size[0], &ei_emlrtBCI,
            sp);
        }

        if (i2 > BPcentroid->size[1]) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, BPcentroid->size[1], &ei_emlrtBCI,
            sp);
        }

        if (i3 > BPcentroid->size[2]) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, BPcentroid->size[2], &ei_emlrtBCI,
            sp);
        }

        if (BPcentroid->data[((i1 + BPcentroid->size[0] * (i2 - 1)) +
                              BPcentroid->size[0] * BPcentroid->size[1] * (i3 -
              1)) - 1]) {
          /*          Segment(1).point = double([X1 Y1 Z1]-1); */
          /*          Segment(2).point = double([X Y Z]-1); */
          SegP[1] = (real_T)NewEx->data[b_n] - 1.0;
          SegP[2049] = (real_T)NewEy->data[b_n] - 1.0;
          SegP[4097] = (real_T)NewEz->data[b_n] - 1.0;
          SegP[0] = X1 - 1.0;
          BranchPoint[0] = X1 - 1.0;
          SegP[2048] = Y1 - 1.0;
          BranchPoint[2] = Y1 - 1.0;
          SegP[4096] = Z1 - 1.0;
          BranchPoint[4] = Z1 - 1.0;
          c = 3U;
        } else {
          /*  Find Nearest BPpoint(centorid)         */
          i1 = FindNearestBP->size[0] * FindNearestBP->size[1] *
            FindNearestBP->size[2];
          FindNearestBP->size[0] = L_BPgroup->size[0];
          FindNearestBP->size[1] = L_BPgroup->size[1];
          FindNearestBP->size[2] = L_BPgroup->size[2];
          emxEnsureCapacity_boolean_T(sp, FindNearestBP, i1, &wh_emlrtRTEI);
          loop_ub = L_BPgroup->size[0] * L_BPgroup->size[1] * L_BPgroup->size[2];
          for (i1 = 0; i1 < loop_ub; i1++) {
            FindNearestBP->data[i1] = (L_BPgroup->data[i1] == Lnum);
          }

          emlrtSizeEqCheckNDR2012b(*(int32_T (*)[3])BPcentroid->size, *(int32_T
            (*)[3])FindNearestBP->size, &ab_emlrtECI, sp);
          loop_ub = BPcentroid->size[0] * BPcentroid->size[1] * BPcentroid->
            size[2];
          i1 = FindNearestBP->size[0] * FindNearestBP->size[1] *
            FindNearestBP->size[2];
          FindNearestBP->size[0] = BPcentroid->size[0];
          FindNearestBP->size[1] = BPcentroid->size[1];
          FindNearestBP->size[2] = BPcentroid->size[2];
          emxEnsureCapacity_boolean_T(sp, FindNearestBP, i1, &xh_emlrtRTEI);
          for (i1 = 0; i1 < loop_ub; i1++) {
            FindNearestBP->data[i1] = (BPcentroid->data[i1] &&
              FindNearestBP->data[i1]);
          }

          st.site = &wk_emlrtRSI;
          BPcentroid_idx_0 = FindNearestBP->size[0] * FindNearestBP->size[1] *
            FindNearestBP->size[2];
          b_BPcentroid = *FindNearestBP;
          i_BPcentroid[0] = BPcentroid_idx_0;
          b_BPcentroid.size = &i_BPcentroid[0];
          b_BPcentroid.numDimensions = 1;
          b_st.site = &cd_emlrtRSI;
          eml_find(&b_st, &b_BPcentroid, ii);
          st.site = &wk_emlrtRSI;
          d_BPcentroid[0] = FindNearestBP->size[0];
          d_BPcentroid[1] = FindNearestBP->size[1];
          d_BPcentroid[2] = FindNearestBP->size[2];
          i1 = b_ii->size[0];
          b_ii->size[0] = ii->size[0];
          emxEnsureCapacity_real_T(&st, b_ii, i1, &lb_emlrtRTEI);
          loop_ub = ii->size[0];
          for (i1 = 0; i1 < loop_ub; i1++) {
            b_ii->data[i1] = ii->data[i1];
          }

          b_st.site = &hd_emlrtRSI;
          ind2sub_indexClass(&b_st, d_BPcentroid, b_ii, varargout_4, ii,
                             varargout_6);
          loop_ub = varargout_4->size[0];
          i1 = b_varargout_4->size[0];
          b_varargout_4->size[0] = varargout_4->size[0];
          emxEnsureCapacity_real_T(sp, b_varargout_4, i1, &nb_emlrtRTEI);
          for (i1 = 0; i1 < loop_ub; i1++) {
            b_varargout_4->data[i1] = varargout_4->data[i1];
          }

          i1 = LEN->size[0];
          LEN->size[0] = ii->size[0];
          emxEnsureCapacity_real_T(sp, LEN, i1, &nb_emlrtRTEI);
          loop_ub = ii->size[0];
          for (i1 = 0; i1 < loop_ub; i1++) {
            LEN->data[i1] = ii->data[i1];
          }

          loop_ub = varargout_6->size[0];
          i1 = b_varargout_6->size[0];
          b_varargout_6->size[0] = varargout_6->size[0];
          emxEnsureCapacity_real_T(sp, b_varargout_6, i1, &nb_emlrtRTEI);
          for (i1 = 0; i1 < loop_ub; i1++) {
            b_varargout_6->data[i1] = varargout_6->data[i1];
          }

          st.site = &vk_emlrtRSI;
          b_cat(&st, b_varargout_4, LEN, b_varargout_6, Fyxz);

          /*          try */
          if (Fyxz->size[0] > 1) {
            d_BPcentroid[0] = Y1;
            d_BPcentroid[1] = X1;
            d_BPcentroid[2] = Z1;
            C[0] = (real_T)Fyxz->size[0] - 1.0;
            C[1] = 0.0;
            st.site = &uk_emlrtRSI;
            b_padarray(&st, d_BPcentroid, C, lenp);

            /*              p = repmat([Y1 X1 Z1],[size(Fyxz,1) 1]); */
            /*          catch err */
          } else {
            /*              warning(err.message) */
            /*              disp(['*****Current Pointdata Number is ' num2str(Pdata_count) '.*****']) */
            /*              disp('   2.2---> Find Nearest Branch Point(centroid).') */
            /*              disp('**********************************************') */
            st.site = &tk_emlrtRSI;
            BPcentroid_idx_0 = BPcentroid->size[0] * BPcentroid->size[1] *
              BPcentroid->size[2];
            b_BPcentroid = *BPcentroid;
            k_BPcentroid[0] = BPcentroid_idx_0;
            b_BPcentroid.size = &k_BPcentroid[0];
            b_BPcentroid.numDimensions = 1;
            b_st.site = &cd_emlrtRSI;
            eml_find(&b_st, &b_BPcentroid, ii);
            st.site = &tk_emlrtRSI;
            d_BPcentroid[0] = BPcentroid->size[0];
            d_BPcentroid[1] = BPcentroid->size[1];
            d_BPcentroid[2] = BPcentroid->size[2];
            i1 = b_ii->size[0];
            b_ii->size[0] = ii->size[0];
            emxEnsureCapacity_real_T(&st, b_ii, i1, &lb_emlrtRTEI);
            loop_ub = ii->size[0];
            for (i1 = 0; i1 < loop_ub; i1++) {
              b_ii->data[i1] = ii->data[i1];
            }

            b_st.site = &hd_emlrtRSI;
            ind2sub_indexClass(&b_st, d_BPcentroid, b_ii, varargout_4, ii,
                               varargout_6);
            loop_ub = varargout_4->size[0];
            i1 = b_varargout_4->size[0];
            b_varargout_4->size[0] = varargout_4->size[0];
            emxEnsureCapacity_real_T(sp, b_varargout_4, i1, &nb_emlrtRTEI);
            for (i1 = 0; i1 < loop_ub; i1++) {
              b_varargout_4->data[i1] = varargout_4->data[i1];
            }

            i1 = LEN->size[0];
            LEN->size[0] = ii->size[0];
            emxEnsureCapacity_real_T(sp, LEN, i1, &nb_emlrtRTEI);
            loop_ub = ii->size[0];
            for (i1 = 0; i1 < loop_ub; i1++) {
              LEN->data[i1] = ii->data[i1];
            }

            loop_ub = varargout_6->size[0];
            i1 = b_varargout_6->size[0];
            b_varargout_6->size[0] = varargout_6->size[0];
            emxEnsureCapacity_real_T(sp, b_varargout_6, i1, &nb_emlrtRTEI);
            for (i1 = 0; i1 < loop_ub; i1++) {
              b_varargout_6->data[i1] = varargout_6->data[i1];
            }

            st.site = &sk_emlrtRSI;
            b_cat(&st, b_varargout_4, LEN, b_varargout_6, Fyxz);
            d_BPcentroid[0] = Y1;
            d_BPcentroid[1] = X1;
            d_BPcentroid[2] = Z1;
            C[0] = Fyxz->size[0];
            C[1] = 1.0;
            st.site = &rk_emlrtRSI;
            b_repmat(&st, d_BPcentroid, C, lenp);
          }

          emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])Fyxz->size, *(int32_T (*)[2])
            lenp->size, &bb_emlrtECI, sp);
          i1 = BPxyz->size[0] * BPxyz->size[1];
          BPxyz->size[0] = Fyxz->size[0];
          BPxyz->size[1] = 3;
          emxEnsureCapacity_real_T(sp, BPxyz, i1, &ci_emlrtRTEI);
          loop_ub = Fyxz->size[0] * Fyxz->size[1];
          for (i1 = 0; i1 < loop_ub; i1++) {
            BPxyz->data[i1] = Fyxz->data[i1] - lenp->data[i1];
          }

          st.site = &qk_emlrtRSI;
          power(&st, BPxyz, lenp);
          st.site = &qk_emlrtRSI;
          g_sum(&st, lenp, LEN);
          st.site = &pk_emlrtRSI;
          b_st.site = &rf_emlrtRSI;
          c_st.site = &sf_emlrtRSI;
          d_st.site = &tf_emlrtRSI;
          if (LEN->size[0] < 1) {
            emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
              "Coder:toolbox:eml_min_or_max_varDimZero",
              "Coder:toolbox:eml_min_or_max_varDimZero", 0);
          }

          e_st.site = &uf_emlrtRSI;
          n = LEN->size[0];
          if (LEN->size[0] <= 2) {
            if (LEN->size[0] == 1) {
              end = 1;
            } else if ((LEN->data[0] > LEN->data[1]) || (muDoubleScalarIsNaN
                        (LEN->data[0]) && (!muDoubleScalarIsNaN(LEN->data[1]))))
            {
              end = 2;
            } else {
              end = 1;
            }
          } else {
            f_st.site = &xd_emlrtRSI;
            if (!muDoubleScalarIsNaN(LEN->data[0])) {
              end = 1;
            } else {
              end = 0;
              g_st.site = &yd_emlrtRSI;
              if (LEN->size[0] > 2147483646) {
                h_st.site = &i_emlrtRSI;
                check_forloop_overflow_error(&h_st);
              }

              k = 2;
              exitg1 = false;
              while ((!exitg1) && (k <= LEN->size[0])) {
                if (!muDoubleScalarIsNaN(LEN->data[k - 1])) {
                  end = k;
                  exitg1 = true;
                } else {
                  k++;
                }
              }
            }

            if (end == 0) {
              end = 1;
            } else {
              f_st.site = &vd_emlrtRSI;
              b_ex = LEN->data[end - 1];
              loop_ub = end + 1;
              g_st.site = &wd_emlrtRSI;
              if ((end + 1 <= LEN->size[0]) && (LEN->size[0] > 2147483646)) {
                h_st.site = &i_emlrtRSI;
                check_forloop_overflow_error(&h_st);
              }

              for (k = loop_ub; k <= n; k++) {
                d = LEN->data[k - 1];
                if (b_ex > d) {
                  b_ex = d;
                  end = k;
                }
              }
            }
          }

          if ((end < 1) || (end > Fyxz->size[0])) {
            emlrtDynamicBoundsCheckR2012b(end, 1, Fyxz->size[0], &lf_emlrtBCI,
              sp);
          }

          if (end > Fyxz->size[0]) {
            emlrtDynamicBoundsCheckR2012b(end, 1, Fyxz->size[0], &mf_emlrtBCI,
              sp);
          }

          if (end > Fyxz->size[0]) {
            emlrtDynamicBoundsCheckR2012b(end, 1, Fyxz->size[0], &nf_emlrtBCI,
              sp);
          }

          /*          Segment(1).point = double([X2 Y2 Z2]-1); */
          /*          Segment(2).point = double([X1 Y1 Z1]-1); */
          /*          Segment(3).point = double([X Y Z]-1); */
          bp1[0] = Fyxz->data[(end + Fyxz->size[0]) - 1] - 1.0;
          bp1[1] = Fyxz->data[end - 1] - 1.0;
          bp1[2] = Fyxz->data[(end + Fyxz->size[0] * 2) - 1] - 1.0;
          SegP[1] = X1 - 1.0;
          SegP[2049] = Y1 - 1.0;
          SegP[4097] = Z1 - 1.0;
          SegP[2] = (real_T)NewEx->data[b_n] - 1.0;
          SegP[2050] = (real_T)NewEy->data[b_n] - 1.0;
          SegP[4098] = (real_T)NewEz->data[b_n] - 1.0;
          SegP[0] = bp1[0];
          BranchPoint[0] = bp1[0];
          SegP[2048] = bp1[1];
          BranchPoint[2] = bp1[1];
          SegP[4096] = bp1[2];
          BranchPoint[4] = bp1[2];
          c = 4U;
        }

        /* clear  Fyxz Ind LEN p Fy Fx Fz FindNearestBP X1 X2 Y1 Y2 Z1 Z2  */
        /* clear  BPGy BPGx BPGz BPG lenp */
        /*     %% Next point */
        /*  BPgroup or Normal point */
        i1 = FindNearestBP->size[0] * FindNearestBP->size[1] *
          FindNearestBP->size[2];
        FindNearestBP->size[0] = BPgroup->size[0];
        FindNearestBP->size[1] = BPgroup->size[1];
        FindNearestBP->size[2] = BPgroup->size[2];
        emxEnsureCapacity_boolean_T(sp, FindNearestBP, i1, &ai_emlrtRTEI);
        loop_ub = BPgroup->size[0] * BPgroup->size[1] * BPgroup->size[2];
        for (i1 = 0; i1 < loop_ub; i1++) {
          FindNearestBP->data[i1] = BPgroup->data[i1];
        }

        end = L_BPgroup->size[0] * (L_BPgroup->size[1] * L_BPgroup->size[2]) - 1;
        n = 0;
        for (loop_ub = 0; loop_ub <= end; loop_ub++) {
          if (L_BPgroup->data[loop_ub] == Lnum) {
            n++;
          }
        }

        i1 = r3->size[0];
        r3->size[0] = n;
        emxEnsureCapacity_int32_T(sp, r3, i1, &fh_emlrtRTEI);
        partialTrueCount = 0;
        for (loop_ub = 0; loop_ub <= end; loop_ub++) {
          if (L_BPgroup->data[loop_ub] == Lnum) {
            r3->data[partialTrueCount] = loop_ub + 1;
            partialTrueCount++;
          }
        }

        n = BPgroup->size[0] * BPgroup->size[1] * BPgroup->size[2];
        loop_ub = r3->size[0];
        for (i1 = 0; i1 < loop_ub; i1++) {
          if ((r3->data[i1] < 1) || (r3->data[i1] > n)) {
            emlrtDynamicBoundsCheckR2012b(r3->data[i1], 1, n, &fi_emlrtBCI, sp);
          }

          FindNearestBP->data[r3->data[i1] - 1] = false;
        }

        i1 = NewEy->data[b_n] + -1;
        i2 = NewEy->data[b_n];
        i3 = NewEy->data[b_n] + 1;
        for (i4 = 0; i4 < 3; i4++) {
          i5 = (NewEz->data[b_n] + i4) - 1;
          for (loop_ub = 0; loop_ub < 3; loop_ub++) {
            if ((i1 < 1) || (i1 > FindNearestBP->size[0])) {
              emlrtDynamicBoundsCheckR2012b(i1, 1, FindNearestBP->size[0],
                &mj_emlrtBCI, sp);
            }

            k = (NewEx->data[b_n] + loop_ub) - 1;
            if ((k < 1) || (k > FindNearestBP->size[1])) {
              emlrtDynamicBoundsCheckR2012b(k, 1, FindNearestBP->size[1],
                &nj_emlrtBCI, sp);
            }

            if ((i5 < 1) || (i5 > FindNearestBP->size[2])) {
              emlrtDynamicBoundsCheckR2012b(i5, 1, FindNearestBP->size[2],
                &oj_emlrtBCI, sp);
            }

            end = 3 * loop_ub + 9 * i4;
            BPgroup_ROI[end] = FindNearestBP->data[((i1 + FindNearestBP->size[0]
              * (k - 1)) + FindNearestBP->size[0] * FindNearestBP->size[1] * (i5
              - 1)) - 1];
            if ((i2 < 1) || (i2 > FindNearestBP->size[0])) {
              emlrtDynamicBoundsCheckR2012b(i2, 1, FindNearestBP->size[0],
                &mj_emlrtBCI, sp);
            }

            if (k > FindNearestBP->size[1]) {
              emlrtDynamicBoundsCheckR2012b(k, 1, FindNearestBP->size[1],
                &nj_emlrtBCI, sp);
            }

            if (i5 > FindNearestBP->size[2]) {
              emlrtDynamicBoundsCheckR2012b(i5, 1, FindNearestBP->size[2],
                &oj_emlrtBCI, sp);
            }

            BPgroup_ROI[end + 1] = FindNearestBP->data[((i2 +
              FindNearestBP->size[0] * (k - 1)) + FindNearestBP->size[0] *
              FindNearestBP->size[1] * (i5 - 1)) - 1];
            if ((i3 < 1) || (i3 > FindNearestBP->size[0])) {
              emlrtDynamicBoundsCheckR2012b(i3, 1, FindNearestBP->size[0],
                &mj_emlrtBCI, sp);
            }

            if (k > FindNearestBP->size[1]) {
              emlrtDynamicBoundsCheckR2012b(k, 1, FindNearestBP->size[1],
                &nj_emlrtBCI, sp);
            }

            if (i5 > FindNearestBP->size[2]) {
              emlrtDynamicBoundsCheckR2012b(i5, 1, FindNearestBP->size[2],
                &oj_emlrtBCI, sp);
            }

            BPgroup_ROI[end + 2] = FindNearestBP->data[((i3 +
              FindNearestBP->size[0] * (k - 1)) + FindNearestBP->size[0] *
              FindNearestBP->size[1] * (i5 - 1)) - 1];
          }
        }

        /*  Exis Next BPgroup */
        maxval = FindNearestBP->data[((NewEy->data[b_n] + FindNearestBP->size[0]
          * (NewEx->data[b_n] - 2)) + FindNearestBP->size[0] *
          FindNearestBP->size[1] * (NewEz->data[b_n] - 2)) - 2];
        for (k = 0; k < 26; k++) {
          b = FindNearestBP->data[((((k + 1) % 3 + NewEy->data[b_n]) +
            FindNearestBP->size[0] * (((k + 1) / 3 % 3 + NewEx->data[b_n]) - 2))
            + FindNearestBP->size[0] * FindNearestBP->size[1] * (((k + 1) / 9 +
            NewEz->data[b_n]) - 2)) - 2];
          maxval = (((int32_T)maxval < (int32_T)b) || maxval);
        }

        if (maxval) {
          st.site = &ok_emlrtRSI;
          b_st.site = &cd_emlrtRSI;
          b_eml_find(&b_st, BPgroup_ROI, ii_data, ii_size);
          st.site = &ok_emlrtRSI;
          loop_ub = ii_size[0];
          b_ii_size[0] = ii_size[0];
          for (i1 = 0; i1 < loop_ub; i1++) {
            b_ii_data[i1] = ii_data[i1];
          }

          c_ii_size[0] = b_ii_size[0];
          b_st.site = &hd_emlrtRSI;
          b_ind2sub_indexClass(&b_st, b_ii_data, c_ii_size, ii_data, ii_size,
                               varargout_5_data, varargout_5_size,
                               varargout_6_data, varargout_6_size);
          loop_ub = ii_size[0];
          b_ii_size[0] = ii_size[0];
          for (i1 = 0; i1 < loop_ub; i1++) {
            b_ii_data[i1] = ((real_T)ii_data[i1] + (real_T)NewEy->data[b_n]) -
              2.0;
          }

          loop_ub = varargout_5_size[0];
          b_varargout_5_size[0] = varargout_5_size[0];
          for (i1 = 0; i1 < loop_ub; i1++) {
            b_varargout_5_data[i1] = ((real_T)varargout_5_data[i1] + (real_T)
              NewEx->data[b_n]) - 2.0;
          }

          loop_ub = varargout_6_size[0];
          b_varargout_6_size[0] = varargout_6_size[0];
          for (i1 = 0; i1 < loop_ub; i1++) {
            b_varargout_6_data[i1] = ((real_T)varargout_6_data[i1] + (real_T)
              NewEz->data[b_n]) - 2.0;
          }

          g_ii_data.data = &b_ii_data[0];
          g_ii_data.size = &b_ii_size[0];
          g_ii_data.allocatedSize = 27;
          g_ii_data.numDimensions = 1;
          g_ii_data.canFreeData = false;
          g_varargout_5_data.data = &b_varargout_5_data[0];
          g_varargout_5_data.size = &b_varargout_5_size[0];
          g_varargout_5_data.allocatedSize = 27;
          g_varargout_5_data.numDimensions = 1;
          g_varargout_5_data.canFreeData = false;
          g_varargout_6_data.data = &b_varargout_6_data[0];
          g_varargout_6_data.size = &b_varargout_6_size[0];
          g_varargout_6_data.allocatedSize = 27;
          g_varargout_6_data.numDimensions = 1;
          g_varargout_6_data.canFreeData = false;
          st.site = &nk_emlrtRSI;
          b_cat(&st, &g_ii_data, &g_varargout_5_data, &g_varargout_6_data, lenp);
          C_size[0] = lenp->size[0];
          C_size[1] = 3;
          loop_ub = lenp->size[0] * lenp->size[1];
          for (i1 = 0; i1 < loop_ub; i1++) {
            C_data[i1] = lenp->data[i1];
          }

          d_BPcentroid[0] = NewEy->data[b_n];
          d_BPcentroid[1] = NewEx->data[b_n];
          d_BPcentroid[2] = NewEz->data[b_n];
          C[0] = C_size[0];
          C[1] = 1.0;
          st.site = &mk_emlrtRSI;
          b_repmat(&st, d_BPcentroid, C, lenp);
          emlrtSizeEqCheckNDR2012b(C_size, *(int32_T (*)[2])lenp->size,
            &cb_emlrtECI, sp);
          b_C_size[0] = C_size[0];
          b_C_size[1] = 3;
          loop_ub = C_size[0] * 3;
          for (i1 = 0; i1 < loop_ub; i1++) {
            c_C_data[i1] = C_data[i1] - lenp->data[i1];
          }

          g_C_data.data = &c_C_data[0];
          g_C_data.size = &b_C_size[0];
          g_C_data.allocatedSize = 81;
          g_C_data.numDimensions = 2;
          g_C_data.canFreeData = false;
          st.site = &lk_emlrtRSI;
          power(&st, &g_C_data, lenp);
          st.site = &lk_emlrtRSI;
          g_sum(&st, lenp, LEN);
          st.site = &kk_emlrtRSI;
          b_st.site = &rf_emlrtRSI;
          c_st.site = &sf_emlrtRSI;
          d_st.site = &tf_emlrtRSI;
          if (LEN->size[0] < 1) {
            emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
              "Coder:toolbox:eml_min_or_max_varDimZero",
              "Coder:toolbox:eml_min_or_max_varDimZero", 0);
          }

          e_st.site = &uf_emlrtRSI;
          n = LEN->size[0];
          if (LEN->size[0] <= 2) {
            if (LEN->size[0] == 1) {
              end = 1;
            } else if ((LEN->data[0] > LEN->data[1]) || (muDoubleScalarIsNaN
                        (LEN->data[0]) && (!muDoubleScalarIsNaN(LEN->data[1]))))
            {
              end = 2;
            } else {
              end = 1;
            }
          } else {
            f_st.site = &xd_emlrtRSI;
            if (!muDoubleScalarIsNaN(LEN->data[0])) {
              end = 1;
            } else {
              end = 0;
              g_st.site = &yd_emlrtRSI;
              if (LEN->size[0] > 2147483646) {
                h_st.site = &i_emlrtRSI;
                check_forloop_overflow_error(&h_st);
              }

              k = 2;
              exitg1 = false;
              while ((!exitg1) && (k <= LEN->size[0])) {
                if (!muDoubleScalarIsNaN(LEN->data[k - 1])) {
                  end = k;
                  exitg1 = true;
                } else {
                  k++;
                }
              }
            }

            if (end == 0) {
              end = 1;
            } else {
              f_st.site = &vd_emlrtRSI;
              b_ex = LEN->data[end - 1];
              loop_ub = end + 1;
              g_st.site = &wd_emlrtRSI;
              if ((end + 1 <= LEN->size[0]) && (LEN->size[0] > 2147483646)) {
                h_st.site = &i_emlrtRSI;
                check_forloop_overflow_error(&h_st);
              }

              for (k = loop_ub; k <= n; k++) {
                d = LEN->data[k - 1];
                if (b_ex > d) {
                  b_ex = d;
                  end = k;
                }
              }
            }
          }

          if ((end < 1) || (end > C_size[0])) {
            emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &ki_emlrtBCI, sp);
          }

          X1 = C_data[(end + C_size[0]) - 1];
          if (end > C_size[0]) {
            emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &li_emlrtBCI, sp);
          }

          Y1 = C_data[end - 1];
          if (end > C_size[0]) {
            emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &mi_emlrtBCI, sp);
          }

          Z1 = C_data[(end + C_size[0] * 2) - 1];
          i1 = (int32_T)Y1;
          if ((i1 < 1) || (i1 > BPcentroid->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i1, 1, BPcentroid->size[0],
              &ni_emlrtBCI, sp);
          }

          i2 = (int32_T)X1;
          if ((i2 < 1) || (i2 > BPcentroid->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, BPcentroid->size[1],
              &ni_emlrtBCI, sp);
          }

          i3 = (int32_T)Z1;
          if ((i3 < 1) || (i3 > BPcentroid->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, BPcentroid->size[2],
              &ni_emlrtBCI, sp);
          }

          if (BPcentroid->data[((i1 + BPcentroid->size[0] * (i2 - 1)) +
                                BPcentroid->size[0] * BPcentroid->size[1] * (i3
                - 1)) - 1]) {
            /*              Segment(c).point = double([X1 Y1 Z1]-1); */
            SegP[(int32_T)c - 1] = X1 - 1.0;
            BranchPoint[1] = X1 - 1.0;
            SegP[(int32_T)c + 2047] = Y1 - 1.0;
            BranchPoint[3] = Y1 - 1.0;
            SegP[(int32_T)c + 4095] = Z1 - 1.0;
            BranchPoint[5] = Z1 - 1.0;

            /* 11             Go2Next = false; */
          } else {
            /*  Find Nearest BPpoint(centorid)         */
            i1 = FindNearestBP->size[0] * FindNearestBP->size[1] *
              FindNearestBP->size[2];
            FindNearestBP->size[0] = L_BPgroup->size[0];
            FindNearestBP->size[1] = L_BPgroup->size[1];
            FindNearestBP->size[2] = L_BPgroup->size[2];
            emxEnsureCapacity_boolean_T(sp, FindNearestBP, i1, &ei_emlrtRTEI);
            loop_ub = L_BPgroup->size[0] * L_BPgroup->size[1] * L_BPgroup->size
              [2];
            for (i1 = 0; i1 < loop_ub; i1++) {
              FindNearestBP->data[i1] = (L_BPgroup->data[i1] == Lnum);
            }

            emlrtSizeEqCheckNDR2012b(*(int32_T (*)[3])BPcentroid->size,
              *(int32_T (*)[3])FindNearestBP->size, &db_emlrtECI, sp);
            loop_ub = BPcentroid->size[0] * BPcentroid->size[1] *
              BPcentroid->size[2];
            i1 = FindNearestBP->size[0] * FindNearestBP->size[1] *
              FindNearestBP->size[2];
            FindNearestBP->size[0] = BPcentroid->size[0];
            FindNearestBP->size[1] = BPcentroid->size[1];
            FindNearestBP->size[2] = BPcentroid->size[2];
            emxEnsureCapacity_boolean_T(sp, FindNearestBP, i1, &fi_emlrtRTEI);
            for (i1 = 0; i1 < loop_ub; i1++) {
              FindNearestBP->data[i1] = (BPcentroid->data[i1] &&
                FindNearestBP->data[i1]);
            }

            st.site = &jk_emlrtRSI;
            BPcentroid_idx_0 = FindNearestBP->size[0] * FindNearestBP->size[1] *
              FindNearestBP->size[2];
            b_BPcentroid = *FindNearestBP;
            m_BPcentroid[0] = BPcentroid_idx_0;
            b_BPcentroid.size = &m_BPcentroid[0];
            b_BPcentroid.numDimensions = 1;
            b_st.site = &cd_emlrtRSI;
            eml_find(&b_st, &b_BPcentroid, ii);
            st.site = &jk_emlrtRSI;
            d_BPcentroid[0] = FindNearestBP->size[0];
            d_BPcentroid[1] = FindNearestBP->size[1];
            d_BPcentroid[2] = FindNearestBP->size[2];
            i1 = b_ii->size[0];
            b_ii->size[0] = ii->size[0];
            emxEnsureCapacity_real_T(&st, b_ii, i1, &lb_emlrtRTEI);
            loop_ub = ii->size[0];
            for (i1 = 0; i1 < loop_ub; i1++) {
              b_ii->data[i1] = ii->data[i1];
            }

            b_st.site = &hd_emlrtRSI;
            ind2sub_indexClass(&b_st, d_BPcentroid, b_ii, varargout_4, ii,
                               varargout_6);
            loop_ub = varargout_4->size[0];
            i1 = b_varargout_4->size[0];
            b_varargout_4->size[0] = varargout_4->size[0];
            emxEnsureCapacity_real_T(sp, b_varargout_4, i1, &nb_emlrtRTEI);
            for (i1 = 0; i1 < loop_ub; i1++) {
              b_varargout_4->data[i1] = varargout_4->data[i1];
            }

            i1 = LEN->size[0];
            LEN->size[0] = ii->size[0];
            emxEnsureCapacity_real_T(sp, LEN, i1, &nb_emlrtRTEI);
            loop_ub = ii->size[0];
            for (i1 = 0; i1 < loop_ub; i1++) {
              LEN->data[i1] = ii->data[i1];
            }

            loop_ub = varargout_6->size[0];
            i1 = b_varargout_6->size[0];
            b_varargout_6->size[0] = varargout_6->size[0];
            emxEnsureCapacity_real_T(sp, b_varargout_6, i1, &nb_emlrtRTEI);
            for (i1 = 0; i1 < loop_ub; i1++) {
              b_varargout_6->data[i1] = varargout_6->data[i1];
            }

            st.site = &ik_emlrtRSI;
            b_cat(&st, b_varargout_4, LEN, b_varargout_6, Fyxz);
            d_BPcentroid[0] = Y1;
            d_BPcentroid[1] = X1;
            d_BPcentroid[2] = Z1;
            C[0] = Fyxz->size[0];
            C[1] = 1.0;
            st.site = &hk_emlrtRSI;
            b_repmat(&st, d_BPcentroid, C, lenp);
            emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])Fyxz->size, *(int32_T (*)
              [2])lenp->size, &eb_emlrtECI, sp);
            i1 = BPxyz->size[0] * BPxyz->size[1];
            BPxyz->size[0] = Fyxz->size[0];
            BPxyz->size[1] = 3;
            emxEnsureCapacity_real_T(sp, BPxyz, i1, &gi_emlrtRTEI);
            loop_ub = Fyxz->size[0] * Fyxz->size[1];
            for (i1 = 0; i1 < loop_ub; i1++) {
              BPxyz->data[i1] = Fyxz->data[i1] - lenp->data[i1];
            }

            st.site = &gk_emlrtRSI;
            power(&st, BPxyz, lenp);
            st.site = &gk_emlrtRSI;
            g_sum(&st, lenp, LEN);
            st.site = &fk_emlrtRSI;
            b_st.site = &rf_emlrtRSI;
            c_st.site = &sf_emlrtRSI;
            d_st.site = &tf_emlrtRSI;
            if (LEN->size[0] < 1) {
              emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
                "Coder:toolbox:eml_min_or_max_varDimZero",
                "Coder:toolbox:eml_min_or_max_varDimZero", 0);
            }

            e_st.site = &uf_emlrtRSI;
            n = LEN->size[0];
            if (LEN->size[0] <= 2) {
              if (LEN->size[0] == 1) {
                end = 1;
              } else if ((LEN->data[0] > LEN->data[1]) || (muDoubleScalarIsNaN
                          (LEN->data[0]) && (!muDoubleScalarIsNaN(LEN->data[1]))))
              {
                end = 2;
              } else {
                end = 1;
              }
            } else {
              f_st.site = &xd_emlrtRSI;
              if (!muDoubleScalarIsNaN(LEN->data[0])) {
                end = 1;
              } else {
                end = 0;
                g_st.site = &yd_emlrtRSI;
                if (LEN->size[0] > 2147483646) {
                  h_st.site = &i_emlrtRSI;
                  check_forloop_overflow_error(&h_st);
                }

                k = 2;
                exitg1 = false;
                while ((!exitg1) && (k <= LEN->size[0])) {
                  if (!muDoubleScalarIsNaN(LEN->data[k - 1])) {
                    end = k;
                    exitg1 = true;
                  } else {
                    k++;
                  }
                }
              }

              if (end == 0) {
                end = 1;
              } else {
                f_st.site = &vd_emlrtRSI;
                b_ex = LEN->data[end - 1];
                loop_ub = end + 1;
                g_st.site = &wd_emlrtRSI;
                if ((end + 1 <= LEN->size[0]) && (LEN->size[0] > 2147483646)) {
                  h_st.site = &i_emlrtRSI;
                  check_forloop_overflow_error(&h_st);
                }

                for (k = loop_ub; k <= n; k++) {
                  d = LEN->data[k - 1];
                  if (b_ex > d) {
                    b_ex = d;
                    end = k;
                  }
                }
              }
            }

            /*              try */
            /*              catch err */
            /*                  disp(err) */
            /* 111                 keyboard */
            /*              end */
            if ((end < 1) || (end > Fyxz->size[0])) {
              emlrtDynamicBoundsCheckR2012b(end, 1, Fyxz->size[0], &of_emlrtBCI,
                sp);
            }

            if (end > Fyxz->size[0]) {
              emlrtDynamicBoundsCheckR2012b(end, 1, Fyxz->size[0], &pf_emlrtBCI,
                sp);
            }

            if (end > Fyxz->size[0]) {
              emlrtDynamicBoundsCheckR2012b(end, 1, Fyxz->size[0], &qf_emlrtBCI,
                sp);
            }

            /*              Segment(c).point = double([X1 Y1 Z1]-1); */
            /*              Segment(c+1).point = double([X2 Y2 Z2]-1); */
            SegP[(int32_T)c - 1] = X1 - 1.0;
            SegP[(int32_T)c + 2047] = Y1 - 1.0;
            SegP[(int32_T)c + 4095] = Z1 - 1.0;
            bp1[0] = Fyxz->data[(end + Fyxz->size[0]) - 1] - 1.0;
            bp1[1] = Fyxz->data[end - 1] - 1.0;
            bp1[2] = Fyxz->data[(end + Fyxz->size[0] * 2) - 1] - 1.0;
            SegP[(int32_T)c] = bp1[0];
            BranchPoint[1] = bp1[0];
            SegP[(int32_T)c + 2048] = bp1[1];
            BranchPoint[3] = bp1[1];
            SegP[(int32_T)c + 4096] = bp1[2];
            BranchPoint[5] = bp1[2];

            /* 11             Go2Next = false; */
          }

          /* clear  Fyxz Ind LEN p Fy Fx Fz FindNearestBP X1 X2 Y1 Y2 Z1 Z2  */
          /* clear  BPGy BPGx BPGz BPG lenp */
          /*     %% No Exis Next BPgroup     */
        } else {
          maxval = bwthindata->data[(maxval_tmp + bwthindata->size[0] *
            b_maxval_tmp) + bwthindata->size[0] * bwthindata->size[1] *
            c_maxval_tmp];
          for (k = 0; k < 26; k++) {
            b = bwthindata->data[(((int32_T)BPcentroid_ROI_tmp[(k + 1) % 3] +
              bwthindata->size[0] * ((int32_T)b_BPcentroid_ROI_tmp[(k + 1) / 3 %
              3] - 1)) + bwthindata->size[0] * bwthindata->size[1] * ((int32_T)
              b_lenp[(k + 1) / 9] - 1)) - 1];
            maxval = (((int32_T)maxval < (int32_T)b) || maxval);
          }

          if (maxval) {
            Go2Next = true;
            while (Go2Next) {
              st.site = &ek_emlrtRSI;
              b_st.site = &cd_emlrtRSI;
              b_eml_find(&b_st, ROI, ii_data, ii_size);
              st.site = &ek_emlrtRSI;
              b_ii_size[0] = ii_size[0];
              loop_ub = ii_size[0];
              for (i1 = 0; i1 < loop_ub; i1++) {
                b_ii_data[i1] = ii_data[i1];
              }

              c_ii_size[0] = b_ii_size[0];
              b_st.site = &hd_emlrtRSI;
              b_ind2sub_indexClass(&b_st, b_ii_data, c_ii_size, ii_data, ii_size,
                                   varargout_5_data, varargout_5_size,
                                   varargout_6_data, varargout_6_size);
              b_ii_size[0] = ii_size[0];
              loop_ub = ii_size[0];
              for (i1 = 0; i1 < loop_ub; i1++) {
                b_ii_data[i1] = ((real_T)ii_data[i1] + Y) - 2.0;
              }

              b_varargout_5_size[0] = varargout_5_size[0];
              loop_ub = varargout_5_size[0];
              for (i1 = 0; i1 < loop_ub; i1++) {
                b_varargout_5_data[i1] = ((real_T)varargout_5_data[i1] + X) -
                  2.0;
              }

              b_varargout_6_size[0] = varargout_6_size[0];
              loop_ub = varargout_6_size[0];
              for (i1 = 0; i1 < loop_ub; i1++) {
                b_varargout_6_data[i1] = ((real_T)varargout_6_data[i1] + Z) -
                  2.0;
              }

              h_ii_data.data = &b_ii_data[0];
              h_ii_data.size = &b_ii_size[0];
              h_ii_data.allocatedSize = 27;
              h_ii_data.numDimensions = 1;
              h_ii_data.canFreeData = false;
              h_varargout_5_data.data = &b_varargout_5_data[0];
              h_varargout_5_data.size = &b_varargout_5_size[0];
              h_varargout_5_data.allocatedSize = 27;
              h_varargout_5_data.numDimensions = 1;
              h_varargout_5_data.canFreeData = false;
              h_varargout_6_data.data = &b_varargout_6_data[0];
              h_varargout_6_data.size = &b_varargout_6_size[0];
              h_varargout_6_data.allocatedSize = 27;
              h_varargout_6_data.numDimensions = 1;
              h_varargout_6_data.canFreeData = false;
              st.site = &dk_emlrtRSI;
              b_cat(&st, &h_ii_data, &h_varargout_5_data, &h_varargout_6_data,
                    lenp);
              C_size[0] = lenp->size[0];
              C_size[1] = 3;
              loop_ub = lenp->size[0] * lenp->size[1];
              for (i1 = 0; i1 < loop_ub; i1++) {
                C_data[i1] = lenp->data[i1];
              }

              /* clear  Ny Nx Nz */
              d_BPcentroid[0] = Y;
              d_BPcentroid[1] = X;
              d_BPcentroid[2] = Z;
              C[0] = C_size[0];
              C[1] = 1.0;
              st.site = &ck_emlrtRSI;
              b_repmat(&st, d_BPcentroid, C, lenp);
              emlrtSizeEqCheckNDR2012b(C_size, *(int32_T (*)[2])lenp->size,
                &fb_emlrtECI, sp);
              b_C_size[0] = C_size[0];
              b_C_size[1] = 3;
              loop_ub = C_size[0] * 3;
              for (i1 = 0; i1 < loop_ub; i1++) {
                c_C_data[i1] = C_data[i1] - lenp->data[i1];
              }

              h_C_data.data = &c_C_data[0];
              h_C_data.size = &b_C_size[0];
              h_C_data.allocatedSize = 81;
              h_C_data.numDimensions = 2;
              h_C_data.canFreeData = false;
              st.site = &bk_emlrtRSI;
              power(&st, &h_C_data, lenp);
              st.site = &bk_emlrtRSI;
              g_sum(&st, lenp, LEN);
              st.site = &ak_emlrtRSI;
              b_st.site = &rf_emlrtRSI;
              c_st.site = &sf_emlrtRSI;
              d_st.site = &tf_emlrtRSI;
              if (LEN->size[0] < 1) {
                emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
                  "Coder:toolbox:eml_min_or_max_varDimZero",
                  "Coder:toolbox:eml_min_or_max_varDimZero", 0);
              }

              e_st.site = &uf_emlrtRSI;
              n = LEN->size[0];
              if (LEN->size[0] <= 2) {
                if (LEN->size[0] == 1) {
                  end = 1;
                } else if ((LEN->data[0] > LEN->data[1]) || (muDoubleScalarIsNaN
                            (LEN->data[0]) && (!muDoubleScalarIsNaN(LEN->data[1]))))
                {
                  end = 2;
                } else {
                  end = 1;
                }
              } else {
                f_st.site = &xd_emlrtRSI;
                if (!muDoubleScalarIsNaN(LEN->data[0])) {
                  end = 1;
                } else {
                  end = 0;
                  g_st.site = &yd_emlrtRSI;
                  if (LEN->size[0] > 2147483646) {
                    h_st.site = &i_emlrtRSI;
                    check_forloop_overflow_error(&h_st);
                  }

                  k = 2;
                  exitg1 = false;
                  while ((!exitg1) && (k <= LEN->size[0])) {
                    if (!muDoubleScalarIsNaN(LEN->data[k - 1])) {
                      end = k;
                      exitg1 = true;
                    } else {
                      k++;
                    }
                  }
                }

                if (end == 0) {
                  end = 1;
                } else {
                  f_st.site = &vd_emlrtRSI;
                  b_ex = LEN->data[end - 1];
                  loop_ub = end + 1;
                  g_st.site = &wd_emlrtRSI;
                  if ((end + 1 <= LEN->size[0]) && (LEN->size[0] > 2147483646))
                  {
                    h_st.site = &i_emlrtRSI;
                    check_forloop_overflow_error(&h_st);
                  }

                  for (k = loop_ub; k <= n; k++) {
                    d = LEN->data[k - 1];
                    if (b_ex > d) {
                      b_ex = d;
                      end = k;
                    }
                  }
                }
              }

              /* ???             try */
              /*              catch err */
              /*                  disp(err) */
              /*                  NextPoint */
              /*                  lenp */
              /*                  [Y X Z] */
              /*                  ROI */
              /*                  error('debag') */
              /*              end */
              if ((end < 1) || (end > C_size[0])) {
                emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &oi_emlrtBCI,
                  sp);
              }

              X = C_data[(end + C_size[0]) - 1];
              if (end > C_size[0]) {
                emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &pi_emlrtBCI,
                  sp);
              }

              Y = C_data[end - 1];
              if (end > C_size[0]) {
                emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0], &qi_emlrtBCI,
                  sp);
              }

              Z = C_data[(end + C_size[0] * 2) - 1];

              /*              Segment(c).point = double([X Y Z]-1); */
              if (((int32_T)c < 1) || ((int32_T)c > 2048)) {
                emlrtDynamicBoundsCheckR2012b((int32_T)c, 1, 2048, &rf_emlrtBCI,
                  sp);
              }

              SegP[(int32_T)c - 1] = X - 1.0;
              SegP[(int32_T)c + 2047] = Y - 1.0;
              SegP[(int32_T)c + 4095] = Z - 1.0;
              i1 = (int32_T)Y;
              if ((i1 < 1) || (i1 > bwthindata->size[0])) {
                emlrtDynamicBoundsCheckR2012b(i1, 1, bwthindata->size[0],
                  &ri_emlrtBCI, sp);
              }

              i2 = (int32_T)X;
              if ((i2 < 1) || (i2 > bwthindata->size[1])) {
                emlrtDynamicBoundsCheckR2012b(i2, 1, bwthindata->size[1],
                  &ri_emlrtBCI, sp);
              }

              i3 = (int32_T)Z;
              if ((i3 < 1) || (i3 > bwthindata->size[2])) {
                emlrtDynamicBoundsCheckR2012b(i3, 1, bwthindata->size[2],
                  &ri_emlrtBCI, sp);
              }

              bwthindata->data[((i1 + bwthindata->size[0] * (i2 - 1)) +
                                bwthindata->size[0] * bwthindata->size[1] * (i3
                - 1)) - 1] = false;
              c++;

              /* clear  Ind LEN lenp NextPoint */
              /*  check Next */
              bp1[0] = Y + -1.0;
              BPcentroid_ROI_tmp[0] = X + -1.0;
              b_BPcentroid_ROI_tmp[0] = Z + -1.0;
              bp1[1] = Y;
              BPcentroid_ROI_tmp[1] = X;
              b_BPcentroid_ROI_tmp[1] = Z;
              bp1[2] = Y + 1.0;
              BPcentroid_ROI_tmp[2] = X + 1.0;
              b_BPcentroid_ROI_tmp[2] = Z + 1.0;
              i4 = (int32_T)(Y + -1.0);
              if ((i4 < 1) || (i4 > BPcentroid->size[0])) {
                emlrtDynamicBoundsCheckR2012b(i4, 1, BPcentroid->size[0],
                  &pj_emlrtBCI, sp);
              }

              if ((i1 < 1) || (i1 > BPcentroid->size[0])) {
                emlrtDynamicBoundsCheckR2012b(i1, 1, BPcentroid->size[0],
                  &pj_emlrtBCI, sp);
              }

              i5 = (int32_T)(Y + 1.0);
              if ((i5 < 1) || (i5 > BPcentroid->size[0])) {
                emlrtDynamicBoundsCheckR2012b(i5, 1, BPcentroid->size[0],
                  &pj_emlrtBCI, sp);
              }

              loop_ub = (int32_T)(X + -1.0);
              if ((loop_ub < 1) || (loop_ub > BPcentroid->size[1])) {
                emlrtDynamicBoundsCheckR2012b(loop_ub, 1, BPcentroid->size[1],
                  &qj_emlrtBCI, sp);
              }

              if ((i2 < 1) || (i2 > BPcentroid->size[1])) {
                emlrtDynamicBoundsCheckR2012b(i2, 1, BPcentroid->size[1],
                  &qj_emlrtBCI, sp);
              }

              k = (int32_T)(X + 1.0);
              if ((k < 1) || (k > BPcentroid->size[1])) {
                emlrtDynamicBoundsCheckR2012b(k, 1, BPcentroid->size[1],
                  &qj_emlrtBCI, sp);
              }

              end = (int32_T)(Z + -1.0);
              if ((end < 1) || (end > BPcentroid->size[2])) {
                emlrtDynamicBoundsCheckR2012b(end, 1, BPcentroid->size[2],
                  &rj_emlrtBCI, sp);
              }

              if ((i3 < 1) || (i3 > BPcentroid->size[2])) {
                emlrtDynamicBoundsCheckR2012b(i3, 1, BPcentroid->size[2],
                  &rj_emlrtBCI, sp);
              }

              partialTrueCount = (int32_T)(Z + 1.0);
              if ((partialTrueCount < 1) || (partialTrueCount > BPcentroid->
                   size[2])) {
                emlrtDynamicBoundsCheckR2012b(partialTrueCount, 1,
                  BPcentroid->size[2], &rj_emlrtBCI, sp);
              }

              if (i4 > BPgroup->size[0]) {
                emlrtDynamicBoundsCheckR2012b(i4, 1, BPgroup->size[0],
                  &sj_emlrtBCI, sp);
              }

              if (i1 > BPgroup->size[0]) {
                emlrtDynamicBoundsCheckR2012b(i1, 1, BPgroup->size[0],
                  &sj_emlrtBCI, sp);
              }

              if (i5 > BPgroup->size[0]) {
                emlrtDynamicBoundsCheckR2012b(i5, 1, BPgroup->size[0],
                  &sj_emlrtBCI, sp);
              }

              if (loop_ub > BPgroup->size[1]) {
                emlrtDynamicBoundsCheckR2012b(loop_ub, 1, BPgroup->size[1],
                  &tj_emlrtBCI, sp);
              }

              if (i2 > BPgroup->size[1]) {
                emlrtDynamicBoundsCheckR2012b(i2, 1, BPgroup->size[1],
                  &tj_emlrtBCI, sp);
              }

              if (k > BPgroup->size[1]) {
                emlrtDynamicBoundsCheckR2012b(k, 1, BPgroup->size[1],
                  &tj_emlrtBCI, sp);
              }

              if (end > BPgroup->size[2]) {
                emlrtDynamicBoundsCheckR2012b(end, 1, BPgroup->size[2],
                  &uj_emlrtBCI, sp);
              }

              if (i3 > BPgroup->size[2]) {
                emlrtDynamicBoundsCheckR2012b(i3, 1, BPgroup->size[2],
                  &uj_emlrtBCI, sp);
              }

              if (partialTrueCount > BPgroup->size[2]) {
                emlrtDynamicBoundsCheckR2012b(partialTrueCount, 1, BPgroup->
                  size[2], &uj_emlrtBCI, sp);
              }

              maxval_tmp = i4 - 1;
              b_maxval_tmp = loop_ub - 1;
              c_maxval_tmp = end - 1;
              maxval = BPgroup->data[(maxval_tmp + BPgroup->size[0] *
                b_maxval_tmp) + BPgroup->size[0] * BPgroup->size[1] *
                c_maxval_tmp];
              for (k = 0; k < 26; k++) {
                b = BPgroup->data[(((int32_T)bp1[(k + 1) % 3] + BPgroup->size[0]
                                    * ((int32_T)BPcentroid_ROI_tmp[(k + 1) / 3 %
                  3] - 1)) + BPgroup->size[0] * BPgroup->size[1] * ((int32_T)
                  b_BPcentroid_ROI_tmp[(k + 1) / 9] - 1)) - 1];
                maxval = (((int32_T)maxval < (int32_T)b) || maxval);
              }

              if (maxval) {
                maxval = BPcentroid->data[(maxval_tmp + BPcentroid->size[0] *
                  b_maxval_tmp) + BPcentroid->size[0] * BPcentroid->size[1] *
                  c_maxval_tmp];
                for (k = 0; k < 26; k++) {
                  b = BPcentroid->data[(((int32_T)bp1[(k + 1) % 3] +
                    BPcentroid->size[0] * ((int32_T)BPcentroid_ROI_tmp[(k + 1) /
                    3 % 3] - 1)) + BPcentroid->size[0] * BPcentroid->size[1] *
                                        ((int32_T)b_BPcentroid_ROI_tmp[(k + 1) /
                    9] - 1)) - 1];
                  maxval = (((int32_T)maxval < (int32_T)b) || maxval);
                }

                if (maxval) {
                  /*  to Branch point( centorid ) */
                  st.site = &yj_emlrtRSI;
                  for (i2 = 0; i2 < 3; i2++) {
                    end = (int32_T)b_BPcentroid_ROI_tmp[i2] - 1;
                    for (i3 = 0; i3 < 3; i3++) {
                      partialTrueCount = (int32_T)BPcentroid_ROI_tmp[i3] - 1;
                      loop_ub = 3 * i3 + 9 * i2;
                      BPgroup_ROI[loop_ub] = BPcentroid->data[(maxval_tmp +
                        BPcentroid->size[0] * partialTrueCount) +
                        BPcentroid->size[0] * BPcentroid->size[1] * end];
                      BPgroup_ROI[loop_ub + 1] = BPcentroid->data[((i1 +
                        BPcentroid->size[0] * partialTrueCount) +
                        BPcentroid->size[0] * BPcentroid->size[1] * end) - 1];
                      BPgroup_ROI[loop_ub + 2] = BPcentroid->data[((i5 +
                        BPcentroid->size[0] * partialTrueCount) +
                        BPcentroid->size[0] * BPcentroid->size[1] * end) - 1];
                    }
                  }

                  b_st.site = &cd_emlrtRSI;
                  b_eml_find(&b_st, BPgroup_ROI, ii_data, ii_size);
                  st.site = &yj_emlrtRSI;
                  b_ii_size[0] = ii_size[0];
                  loop_ub = ii_size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    b_ii_data[i1] = ii_data[i1];
                  }

                  c_ii_size[0] = b_ii_size[0];
                  b_st.site = &hd_emlrtRSI;
                  b_ind2sub_indexClass(&b_st, b_ii_data, c_ii_size, ii_data,
                                       ii_size, varargout_5_data,
                                       varargout_5_size, varargout_6_data,
                                       varargout_6_size);
                  b_ii_size[0] = ii_size[0];
                  loop_ub = ii_size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    b_ii_data[i1] = ((real_T)ii_data[i1] + Y) - 2.0;
                  }

                  b_varargout_5_size[0] = varargout_5_size[0];
                  loop_ub = varargout_5_size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    b_varargout_5_data[i1] = ((real_T)varargout_5_data[i1] + X)
                      - 2.0;
                  }

                  b_varargout_6_size[0] = varargout_6_size[0];
                  loop_ub = varargout_6_size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    b_varargout_6_data[i1] = ((real_T)varargout_6_data[i1] + Z)
                      - 2.0;
                  }

                  j_ii_data.data = &b_ii_data[0];
                  j_ii_data.size = &b_ii_size[0];
                  j_ii_data.allocatedSize = 27;
                  j_ii_data.numDimensions = 1;
                  j_ii_data.canFreeData = false;
                  j_varargout_5_data.data = &b_varargout_5_data[0];
                  j_varargout_5_data.size = &b_varargout_5_size[0];
                  j_varargout_5_data.allocatedSize = 27;
                  j_varargout_5_data.numDimensions = 1;
                  j_varargout_5_data.canFreeData = false;
                  j_varargout_6_data.data = &b_varargout_6_data[0];
                  j_varargout_6_data.size = &b_varargout_6_size[0];
                  j_varargout_6_data.allocatedSize = 27;
                  j_varargout_6_data.numDimensions = 1;
                  j_varargout_6_data.canFreeData = false;
                  st.site = &xj_emlrtRSI;
                  b_cat(&st, &j_ii_data, &j_varargout_5_data,
                        &j_varargout_6_data, lenp);
                  C_size[0] = lenp->size[0];
                  C_size[1] = 3;
                  loop_ub = lenp->size[0] * lenp->size[1];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    C_data[i1] = lenp->data[i1];
                  }

                  /* clear  BPGy BPGx BPGz */
                  d_BPcentroid[0] = Y;
                  d_BPcentroid[1] = X;
                  d_BPcentroid[2] = Z;
                  C[0] = C_size[0];
                  C[1] = 1.0;
                  st.site = &wj_emlrtRSI;
                  b_repmat(&st, d_BPcentroid, C, lenp);
                  emlrtSizeEqCheckNDR2012b(C_size, *(int32_T (*)[2])lenp->size,
                    &gb_emlrtECI, sp);
                  b_C_size[0] = C_size[0];
                  b_C_size[1] = 3;
                  loop_ub = C_size[0] * 3;
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    c_C_data[i1] = C_data[i1] - lenp->data[i1];
                  }

                  j_C_data.data = &c_C_data[0];
                  j_C_data.size = &b_C_size[0];
                  j_C_data.allocatedSize = 81;
                  j_C_data.numDimensions = 2;
                  j_C_data.canFreeData = false;
                  st.site = &vj_emlrtRSI;
                  power(&st, &j_C_data, lenp);
                  st.site = &vj_emlrtRSI;
                  g_sum(&st, lenp, LEN);
                  st.site = &uj_emlrtRSI;
                  b_st.site = &rf_emlrtRSI;
                  c_st.site = &sf_emlrtRSI;
                  d_st.site = &tf_emlrtRSI;
                  if (LEN->size[0] < 1) {
                    emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
                      "Coder:toolbox:eml_min_or_max_varDimZero",
                      "Coder:toolbox:eml_min_or_max_varDimZero", 0);
                  }

                  e_st.site = &uf_emlrtRSI;
                  n = LEN->size[0];
                  if (LEN->size[0] <= 2) {
                    if (LEN->size[0] == 1) {
                      end = 1;
                    } else if ((LEN->data[0] > LEN->data[1]) ||
                               (muDoubleScalarIsNaN(LEN->data[0]) &&
                                (!muDoubleScalarIsNaN(LEN->data[1])))) {
                      end = 2;
                    } else {
                      end = 1;
                    }
                  } else {
                    f_st.site = &xd_emlrtRSI;
                    if (!muDoubleScalarIsNaN(LEN->data[0])) {
                      end = 1;
                    } else {
                      end = 0;
                      g_st.site = &yd_emlrtRSI;
                      if (LEN->size[0] > 2147483646) {
                        h_st.site = &i_emlrtRSI;
                        check_forloop_overflow_error(&h_st);
                      }

                      k = 2;
                      exitg1 = false;
                      while ((!exitg1) && (k <= LEN->size[0])) {
                        if (!muDoubleScalarIsNaN(LEN->data[k - 1])) {
                          end = k;
                          exitg1 = true;
                        } else {
                          k++;
                        }
                      }
                    }

                    if (end == 0) {
                      end = 1;
                    } else {
                      f_st.site = &vd_emlrtRSI;
                      b_ex = LEN->data[end - 1];
                      loop_ub = end + 1;
                      g_st.site = &wd_emlrtRSI;
                      if ((end + 1 <= LEN->size[0]) && (LEN->size[0] >
                           2147483646)) {
                        h_st.site = &i_emlrtRSI;
                        check_forloop_overflow_error(&h_st);
                      }

                      for (k = loop_ub; k <= n; k++) {
                        d = LEN->data[k - 1];
                        if (b_ex > d) {
                          b_ex = d;
                          end = k;
                        }
                      }
                    }
                  }

                  if ((end < 1) || (end > C_size[0])) {
                    emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0],
                      &sf_emlrtBCI, sp);
                  }

                  if (end > C_size[0]) {
                    emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0],
                      &tf_emlrtBCI, sp);
                  }

                  if (end > C_size[0]) {
                    emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0],
                      &uf_emlrtBCI, sp);
                  }

                  /*                      Segment(c).point = double([X1 Y1 Z1]-1); */
                  if (((int32_T)c < 1) || ((int32_T)c > 2048)) {
                    emlrtDynamicBoundsCheckR2012b((int32_T)c, 1, 2048,
                      &vf_emlrtBCI, sp);
                  }

                  SegP[(int32_T)c - 1] = C_data[(end + C_size[0]) - 1] - 1.0;
                  BranchPoint[1] = C_data[(end + C_size[0]) - 1] - 1.0;
                  SegP[(int32_T)c + 2047] = C_data[end - 1] - 1.0;
                  BranchPoint[3] = C_data[end - 1] - 1.0;
                  SegP[(int32_T)c + 4095] = C_data[(end + C_size[0] * 2) - 1] -
                    1.0;
                  BranchPoint[5] = C_data[(end + C_size[0] * 2) - 1] - 1.0;
                  Go2Next = false;

                  /* clear  lenp LEN Ind X1 Y1 Z1 BPG */
                } else {
                  /*  to Branch group and Branch point( centorid ) */
                  st.site = &tj_emlrtRSI;
                  for (i2 = 0; i2 < 3; i2++) {
                    end = (int32_T)b_BPcentroid_ROI_tmp[i2] - 1;
                    for (i3 = 0; i3 < 3; i3++) {
                      partialTrueCount = (int32_T)BPcentroid_ROI_tmp[i3] - 1;
                      loop_ub = 3 * i3 + 9 * i2;
                      BPgroup_ROI[loop_ub] = BPgroup->data[(maxval_tmp +
                        BPgroup->size[0] * partialTrueCount) + BPgroup->size[0] *
                        BPgroup->size[1] * end];
                      BPgroup_ROI[loop_ub + 1] = BPgroup->data[((i1 +
                        BPgroup->size[0] * partialTrueCount) + BPgroup->size[0] *
                        BPgroup->size[1] * end) - 1];
                      BPgroup_ROI[loop_ub + 2] = BPgroup->data[((i5 +
                        BPgroup->size[0] * partialTrueCount) + BPgroup->size[0] *
                        BPgroup->size[1] * end) - 1];
                    }
                  }

                  b_st.site = &cd_emlrtRSI;
                  b_eml_find(&b_st, BPgroup_ROI, ii_data, ii_size);
                  st.site = &tj_emlrtRSI;
                  b_ii_size[0] = ii_size[0];
                  loop_ub = ii_size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    b_ii_data[i1] = ii_data[i1];
                  }

                  c_ii_size[0] = b_ii_size[0];
                  b_st.site = &hd_emlrtRSI;
                  b_ind2sub_indexClass(&b_st, b_ii_data, c_ii_size, ii_data,
                                       ii_size, varargout_5_data,
                                       varargout_5_size, varargout_6_data,
                                       varargout_6_size);
                  b_ii_size[0] = ii_size[0];
                  loop_ub = ii_size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    b_ii_data[i1] = ((real_T)ii_data[i1] + Y) - 2.0;
                  }

                  b_varargout_5_size[0] = varargout_5_size[0];
                  loop_ub = varargout_5_size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    b_varargout_5_data[i1] = ((real_T)varargout_5_data[i1] + X)
                      - 2.0;
                  }

                  b_varargout_6_size[0] = varargout_6_size[0];
                  loop_ub = varargout_6_size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    b_varargout_6_data[i1] = ((real_T)varargout_6_data[i1] + Z)
                      - 2.0;
                  }

                  i_ii_data.data = &b_ii_data[0];
                  i_ii_data.size = &b_ii_size[0];
                  i_ii_data.allocatedSize = 27;
                  i_ii_data.numDimensions = 1;
                  i_ii_data.canFreeData = false;
                  i_varargout_5_data.data = &b_varargout_5_data[0];
                  i_varargout_5_data.size = &b_varargout_5_size[0];
                  i_varargout_5_data.allocatedSize = 27;
                  i_varargout_5_data.numDimensions = 1;
                  i_varargout_5_data.canFreeData = false;
                  i_varargout_6_data.data = &b_varargout_6_data[0];
                  i_varargout_6_data.size = &b_varargout_6_size[0];
                  i_varargout_6_data.allocatedSize = 27;
                  i_varargout_6_data.numDimensions = 1;
                  i_varargout_6_data.canFreeData = false;
                  st.site = &sj_emlrtRSI;
                  b_cat(&st, &i_ii_data, &i_varargout_5_data,
                        &i_varargout_6_data, lenp);
                  C_size[0] = lenp->size[0];
                  C_size[1] = 3;
                  loop_ub = lenp->size[0] * lenp->size[1];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    C_data[i1] = lenp->data[i1];
                  }

                  /* clear  BPGy BPGx BPGz */
                  d_BPcentroid[0] = Y;
                  d_BPcentroid[1] = X;
                  d_BPcentroid[2] = Z;
                  C[0] = C_size[0];
                  C[1] = 1.0;
                  st.site = &rj_emlrtRSI;
                  b_repmat(&st, d_BPcentroid, C, lenp);
                  emlrtSizeEqCheckNDR2012b(C_size, *(int32_T (*)[2])lenp->size,
                    &hb_emlrtECI, sp);
                  b_C_size[0] = C_size[0];
                  b_C_size[1] = 3;
                  loop_ub = C_size[0] * 3;
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    c_C_data[i1] = C_data[i1] - lenp->data[i1];
                  }

                  i_C_data.data = &c_C_data[0];
                  i_C_data.size = &b_C_size[0];
                  i_C_data.allocatedSize = 81;
                  i_C_data.numDimensions = 2;
                  i_C_data.canFreeData = false;
                  st.site = &qj_emlrtRSI;
                  power(&st, &i_C_data, lenp);
                  st.site = &qj_emlrtRSI;
                  g_sum(&st, lenp, LEN);
                  st.site = &pj_emlrtRSI;
                  b_st.site = &rf_emlrtRSI;
                  c_st.site = &sf_emlrtRSI;
                  d_st.site = &tf_emlrtRSI;
                  if (LEN->size[0] < 1) {
                    emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
                      "Coder:toolbox:eml_min_or_max_varDimZero",
                      "Coder:toolbox:eml_min_or_max_varDimZero", 0);
                  }

                  e_st.site = &uf_emlrtRSI;
                  n = LEN->size[0];
                  if (LEN->size[0] <= 2) {
                    if (LEN->size[0] == 1) {
                      end = 1;
                    } else if ((LEN->data[0] > LEN->data[1]) ||
                               (muDoubleScalarIsNaN(LEN->data[0]) &&
                                (!muDoubleScalarIsNaN(LEN->data[1])))) {
                      end = 2;
                    } else {
                      end = 1;
                    }
                  } else {
                    f_st.site = &xd_emlrtRSI;
                    if (!muDoubleScalarIsNaN(LEN->data[0])) {
                      end = 1;
                    } else {
                      end = 0;
                      g_st.site = &yd_emlrtRSI;
                      if (LEN->size[0] > 2147483646) {
                        h_st.site = &i_emlrtRSI;
                        check_forloop_overflow_error(&h_st);
                      }

                      k = 2;
                      exitg1 = false;
                      while ((!exitg1) && (k <= LEN->size[0])) {
                        if (!muDoubleScalarIsNaN(LEN->data[k - 1])) {
                          end = k;
                          exitg1 = true;
                        } else {
                          k++;
                        }
                      }
                    }

                    if (end == 0) {
                      end = 1;
                    } else {
                      f_st.site = &vd_emlrtRSI;
                      b_ex = LEN->data[end - 1];
                      loop_ub = end + 1;
                      g_st.site = &wd_emlrtRSI;
                      if ((end + 1 <= LEN->size[0]) && (LEN->size[0] >
                           2147483646)) {
                        h_st.site = &i_emlrtRSI;
                        check_forloop_overflow_error(&h_st);
                      }

                      for (k = loop_ub; k <= n; k++) {
                        d = LEN->data[k - 1];
                        if (b_ex > d) {
                          b_ex = d;
                          end = k;
                        }
                      }
                    }
                  }

                  if ((end < 1) || (end > C_size[0])) {
                    emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0],
                      &si_emlrtBCI, sp);
                  }

                  X1 = C_data[(end + C_size[0]) - 1];
                  if (end > C_size[0]) {
                    emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0],
                      &ti_emlrtBCI, sp);
                  }

                  Y1 = C_data[end - 1];
                  if (end > C_size[0]) {
                    emlrtDynamicBoundsCheckR2012b(end, 1, C_size[0],
                      &ui_emlrtBCI, sp);
                  }

                  Z1 = C_data[(end + C_size[0] * 2) - 1];

                  /*                      Segment(c).point = double([X1 Y1 Z1]-1); */
                  if (((int32_T)c < 1) || ((int32_T)c > 2048)) {
                    emlrtDynamicBoundsCheckR2012b((int32_T)c, 1, 2048,
                      &wf_emlrtBCI, sp);
                  }

                  SegP[(int32_T)c - 1] = X1 - 1.0;
                  SegP[(int32_T)c + 2047] = Y1 - 1.0;
                  SegP[(int32_T)c + 4095] = Z1 - 1.0;
                  c++;

                  /* clear  BPG lenp LEN Ind */
                  i1 = (int32_T)Y1;
                  if ((i1 < 1) || (i1 > L_BPgroup->size[0])) {
                    emlrtDynamicBoundsCheckR2012b(i1, 1, L_BPgroup->size[0],
                      &vi_emlrtBCI, sp);
                  }

                  i2 = (int32_T)X1;
                  if ((i2 < 1) || (i2 > L_BPgroup->size[1])) {
                    emlrtDynamicBoundsCheckR2012b(i2, 1, L_BPgroup->size[1],
                      &vi_emlrtBCI, sp);
                  }

                  i3 = (int32_T)Z1;
                  if ((i3 < 1) || (i3 > L_BPgroup->size[2])) {
                    emlrtDynamicBoundsCheckR2012b(i3, 1, L_BPgroup->size[2],
                      &vi_emlrtBCI, sp);
                  }

                  Lnum = L_BPgroup->data[((i1 + L_BPgroup->size[0] * (i2 - 1)) +
                    L_BPgroup->size[0] * L_BPgroup->size[1] * (i3 - 1)) - 1];

                  /*  Find Nearest BPpoint(centorid)         */
                  i1 = FindNearestBP->size[0] * FindNearestBP->size[1] *
                    FindNearestBP->size[2];
                  FindNearestBP->size[0] = L_BPgroup->size[0];
                  FindNearestBP->size[1] = L_BPgroup->size[1];
                  FindNearestBP->size[2] = L_BPgroup->size[2];
                  emxEnsureCapacity_boolean_T(sp, FindNearestBP, i1,
                    &li_emlrtRTEI);
                  loop_ub = L_BPgroup->size[0] * L_BPgroup->size[1] *
                    L_BPgroup->size[2];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    FindNearestBP->data[i1] = (L_BPgroup->data[i1] == Lnum);
                  }

                  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[3])BPcentroid->size,
                    *(int32_T (*)[3])FindNearestBP->size, &ib_emlrtECI, sp);
                  loop_ub = BPcentroid->size[0] * BPcentroid->size[1] *
                    BPcentroid->size[2];
                  i1 = FindNearestBP->size[0] * FindNearestBP->size[1] *
                    FindNearestBP->size[2];
                  FindNearestBP->size[0] = BPcentroid->size[0];
                  FindNearestBP->size[1] = BPcentroid->size[1];
                  FindNearestBP->size[2] = BPcentroid->size[2];
                  emxEnsureCapacity_boolean_T(sp, FindNearestBP, i1,
                    &mi_emlrtRTEI);
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    FindNearestBP->data[i1] = (BPcentroid->data[i1] &&
                      FindNearestBP->data[i1]);
                  }

                  st.site = &oj_emlrtRSI;
                  BPcentroid_idx_0 = FindNearestBP->size[0] *
                    FindNearestBP->size[1] * FindNearestBP->size[2];
                  b_BPcentroid = *FindNearestBP;
                  o_BPcentroid[0] = BPcentroid_idx_0;
                  b_BPcentroid.size = &o_BPcentroid[0];
                  b_BPcentroid.numDimensions = 1;
                  b_st.site = &cd_emlrtRSI;
                  eml_find(&b_st, &b_BPcentroid, ii);
                  st.site = &oj_emlrtRSI;
                  d_BPcentroid[0] = FindNearestBP->size[0];
                  d_BPcentroid[1] = FindNearestBP->size[1];
                  d_BPcentroid[2] = FindNearestBP->size[2];
                  i1 = b_ii->size[0];
                  b_ii->size[0] = ii->size[0];
                  emxEnsureCapacity_real_T(&st, b_ii, i1, &lb_emlrtRTEI);
                  loop_ub = ii->size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    b_ii->data[i1] = ii->data[i1];
                  }

                  b_st.site = &hd_emlrtRSI;
                  ind2sub_indexClass(&b_st, d_BPcentroid, b_ii, varargout_4, ii,
                                     varargout_6);
                  i1 = b_varargout_4->size[0];
                  b_varargout_4->size[0] = varargout_4->size[0];
                  emxEnsureCapacity_real_T(sp, b_varargout_4, i1, &nb_emlrtRTEI);
                  loop_ub = varargout_4->size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    b_varargout_4->data[i1] = varargout_4->data[i1];
                  }

                  i1 = LEN->size[0];
                  LEN->size[0] = ii->size[0];
                  emxEnsureCapacity_real_T(sp, LEN, i1, &nb_emlrtRTEI);
                  loop_ub = ii->size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    LEN->data[i1] = ii->data[i1];
                  }

                  i1 = b_varargout_6->size[0];
                  b_varargout_6->size[0] = varargout_6->size[0];
                  emxEnsureCapacity_real_T(sp, b_varargout_6, i1, &nb_emlrtRTEI);
                  loop_ub = varargout_6->size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    b_varargout_6->data[i1] = varargout_6->data[i1];
                  }

                  st.site = &nj_emlrtRSI;
                  b_cat(&st, b_varargout_4, LEN, b_varargout_6, Fyxz);

                  /* clear  Fy Fx Fz FindNearestBP */
                  /*                      try */
                  if (Fyxz->size[0] > 1) {
                    d_BPcentroid[0] = Y1;
                    d_BPcentroid[1] = X1;
                    d_BPcentroid[2] = Z1;
                    C[0] = (real_T)Fyxz->size[0] - 1.0;
                    C[1] = 0.0;
                    st.site = &mj_emlrtRSI;
                    b_padarray(&st, d_BPcentroid, C, lenp);

                    /*                          p = repmat([Y1 X1 Z1],[size(Fyxz,1) 1]); */
                    /*                      catch err */
                  } else {
                    /*                          warning(err.message) */
                    /*                          disp(['*****Current Pointdata Number is ' num2str(Pdata_count) '*****']) */
                    /*                          disp('   2.3---> Find Nearest Branch Point(centroid)') */
                    /*                          disp('**********************************************') */
                    st.site = &lj_emlrtRSI;
                    BPcentroid_idx_0 = BPcentroid->size[0] * BPcentroid->size[1]
                      * BPcentroid->size[2];
                    b_BPcentroid = *BPcentroid;
                    p_BPcentroid[0] = BPcentroid_idx_0;
                    b_BPcentroid.size = &p_BPcentroid[0];
                    b_BPcentroid.numDimensions = 1;
                    b_st.site = &cd_emlrtRSI;
                    eml_find(&b_st, &b_BPcentroid, ii);
                    st.site = &lj_emlrtRSI;
                    d_BPcentroid[0] = BPcentroid->size[0];
                    d_BPcentroid[1] = BPcentroid->size[1];
                    d_BPcentroid[2] = BPcentroid->size[2];
                    i1 = b_ii->size[0];
                    b_ii->size[0] = ii->size[0];
                    emxEnsureCapacity_real_T(&st, b_ii, i1, &lb_emlrtRTEI);
                    loop_ub = ii->size[0];
                    for (i1 = 0; i1 < loop_ub; i1++) {
                      b_ii->data[i1] = ii->data[i1];
                    }

                    b_st.site = &hd_emlrtRSI;
                    ind2sub_indexClass(&b_st, d_BPcentroid, b_ii, varargout_4,
                                       ii, varargout_6);
                    i1 = b_varargout_4->size[0];
                    b_varargout_4->size[0] = varargout_4->size[0];
                    emxEnsureCapacity_real_T(sp, b_varargout_4, i1,
                      &nb_emlrtRTEI);
                    loop_ub = varargout_4->size[0];
                    for (i1 = 0; i1 < loop_ub; i1++) {
                      b_varargout_4->data[i1] = varargout_4->data[i1];
                    }

                    i1 = LEN->size[0];
                    LEN->size[0] = ii->size[0];
                    emxEnsureCapacity_real_T(sp, LEN, i1, &nb_emlrtRTEI);
                    loop_ub = ii->size[0];
                    for (i1 = 0; i1 < loop_ub; i1++) {
                      LEN->data[i1] = ii->data[i1];
                    }

                    i1 = b_varargout_6->size[0];
                    b_varargout_6->size[0] = varargout_6->size[0];
                    emxEnsureCapacity_real_T(sp, b_varargout_6, i1,
                      &nb_emlrtRTEI);
                    loop_ub = varargout_6->size[0];
                    for (i1 = 0; i1 < loop_ub; i1++) {
                      b_varargout_6->data[i1] = varargout_6->data[i1];
                    }

                    st.site = &kj_emlrtRSI;
                    b_cat(&st, b_varargout_4, LEN, b_varargout_6, Fyxz);
                    d_BPcentroid[0] = Y1;
                    d_BPcentroid[1] = X1;
                    d_BPcentroid[2] = Z1;
                    C[0] = Fyxz->size[0];
                    C[1] = 1.0;
                    st.site = &jj_emlrtRSI;
                    b_repmat(&st, d_BPcentroid, C, lenp);
                  }

                  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])Fyxz->size,
                    *(int32_T (*)[2])lenp->size, &jb_emlrtECI, sp);
                  i1 = BPxyz->size[0] * BPxyz->size[1];
                  BPxyz->size[0] = Fyxz->size[0];
                  BPxyz->size[1] = 3;
                  emxEnsureCapacity_real_T(sp, BPxyz, i1, &ni_emlrtRTEI);
                  loop_ub = Fyxz->size[0] * Fyxz->size[1];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    BPxyz->data[i1] = Fyxz->data[i1] - lenp->data[i1];
                  }

                  st.site = &ij_emlrtRSI;
                  power(&st, BPxyz, lenp);
                  st.site = &ij_emlrtRSI;
                  g_sum(&st, lenp, LEN);
                  st.site = &hj_emlrtRSI;
                  b_st.site = &rf_emlrtRSI;
                  c_st.site = &sf_emlrtRSI;
                  d_st.site = &tf_emlrtRSI;
                  if (LEN->size[0] < 1) {
                    emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
                      "Coder:toolbox:eml_min_or_max_varDimZero",
                      "Coder:toolbox:eml_min_or_max_varDimZero", 0);
                  }

                  e_st.site = &uf_emlrtRSI;
                  n = LEN->size[0];
                  if (LEN->size[0] <= 2) {
                    if (LEN->size[0] == 1) {
                      end = 1;
                    } else if ((LEN->data[0] > LEN->data[1]) ||
                               (muDoubleScalarIsNaN(LEN->data[0]) &&
                                (!muDoubleScalarIsNaN(LEN->data[1])))) {
                      end = 2;
                    } else {
                      end = 1;
                    }
                  } else {
                    f_st.site = &xd_emlrtRSI;
                    if (!muDoubleScalarIsNaN(LEN->data[0])) {
                      end = 1;
                    } else {
                      end = 0;
                      g_st.site = &yd_emlrtRSI;
                      if (LEN->size[0] > 2147483646) {
                        h_st.site = &i_emlrtRSI;
                        check_forloop_overflow_error(&h_st);
                      }

                      k = 2;
                      exitg1 = false;
                      while ((!exitg1) && (k <= LEN->size[0])) {
                        if (!muDoubleScalarIsNaN(LEN->data[k - 1])) {
                          end = k;
                          exitg1 = true;
                        } else {
                          k++;
                        }
                      }
                    }

                    if (end == 0) {
                      end = 1;
                    } else {
                      f_st.site = &vd_emlrtRSI;
                      b_ex = LEN->data[end - 1];
                      loop_ub = end + 1;
                      g_st.site = &wd_emlrtRSI;
                      if ((end + 1 <= LEN->size[0]) && (LEN->size[0] >
                           2147483646)) {
                        h_st.site = &i_emlrtRSI;
                        check_forloop_overflow_error(&h_st);
                      }

                      for (k = loop_ub; k <= n; k++) {
                        d = LEN->data[k - 1];
                        if (b_ex > d) {
                          b_ex = d;
                          end = k;
                        }
                      }
                    }
                  }

                  if ((end < 1) || (end > Fyxz->size[0])) {
                    emlrtDynamicBoundsCheckR2012b(end, 1, Fyxz->size[0],
                      &xf_emlrtBCI, sp);
                  }

                  if (end > Fyxz->size[0]) {
                    emlrtDynamicBoundsCheckR2012b(end, 1, Fyxz->size[0],
                      &yf_emlrtBCI, sp);
                  }

                  if (end > Fyxz->size[0]) {
                    emlrtDynamicBoundsCheckR2012b(end, 1, Fyxz->size[0],
                      &ag_emlrtBCI, sp);
                  }

                  /*                      Segment(c).point = double([X2 Y2 Z2]-1); */
                  bp1[0] = Fyxz->data[(end + Fyxz->size[0]) - 1] - 1.0;
                  bp1[1] = Fyxz->data[end - 1] - 1.0;
                  bp1[2] = Fyxz->data[(end + Fyxz->size[0] * 2) - 1] - 1.0;
                  if (((int32_T)c < 1) || ((int32_T)c > 2048)) {
                    emlrtDynamicBoundsCheckR2012b((int32_T)c, 1, 2048,
                      &bg_emlrtBCI, sp);
                  }

                  SegP[(int32_T)c - 1] = bp1[0];
                  BranchPoint[1] = bp1[0];
                  SegP[(int32_T)c + 2047] = bp1[1];
                  BranchPoint[3] = bp1[1];
                  SegP[(int32_T)c + 4095] = bp1[2];
                  BranchPoint[5] = bp1[2];
                  Go2Next = false;

                  /* clear  p LEN Ind X1 Y1 Z1 X2 Y2 Z1 */
                }
              } else {
                for (i2 = 0; i2 < 3; i2++) {
                  i3 = (int32_T)b_BPcentroid_ROI_tmp[i2];
                  for (loop_ub = 0; loop_ub < 3; loop_ub++) {
                    if (i4 > bwthindata->size[0]) {
                      emlrtDynamicBoundsCheckR2012b(i4, 1, bwthindata->size[0],
                        &vj_emlrtBCI, sp);
                    }

                    k = (int32_T)BPcentroid_ROI_tmp[loop_ub];
                    if ((k < 1) || (k > bwthindata->size[1])) {
                      emlrtDynamicBoundsCheckR2012b(k, 1, bwthindata->size[1],
                        &wj_emlrtBCI, sp);
                    }

                    if ((i3 < 1) || (i3 > bwthindata->size[2])) {
                      emlrtDynamicBoundsCheckR2012b(i3, 1, bwthindata->size[2],
                        &xj_emlrtBCI, sp);
                    }

                    n = 3 * loop_ub + 9 * i2;
                    ROI[n] = bwthindata->data[((i4 + bwthindata->size[0] * (k -
                      1)) + bwthindata->size[0] * bwthindata->size[1] * (i3 - 1))
                      - 1];
                    if (i1 > bwthindata->size[0]) {
                      emlrtDynamicBoundsCheckR2012b(i1, 1, bwthindata->size[0],
                        &vj_emlrtBCI, sp);
                    }

                    if (k > bwthindata->size[1]) {
                      emlrtDynamicBoundsCheckR2012b(k, 1, bwthindata->size[1],
                        &wj_emlrtBCI, sp);
                    }

                    if (i3 > bwthindata->size[2]) {
                      emlrtDynamicBoundsCheckR2012b(i3, 1, bwthindata->size[2],
                        &xj_emlrtBCI, sp);
                    }

                    ROI[n + 1] = bwthindata->data[((i1 + bwthindata->size[0] *
                      (k - 1)) + bwthindata->size[0] * bwthindata->size[1] * (i3
                      - 1)) - 1];
                    if (i5 > bwthindata->size[0]) {
                      emlrtDynamicBoundsCheckR2012b(i5, 1, bwthindata->size[0],
                        &vj_emlrtBCI, sp);
                    }

                    if (k > bwthindata->size[1]) {
                      emlrtDynamicBoundsCheckR2012b(k, 1, bwthindata->size[1],
                        &wj_emlrtBCI, sp);
                    }

                    if (i3 > bwthindata->size[2]) {
                      emlrtDynamicBoundsCheckR2012b(i3, 1, bwthindata->size[2],
                        &xj_emlrtBCI, sp);
                    }

                    ROI[n + 2] = bwthindata->data[((i5 + bwthindata->size[0] *
                      (k - 1)) + bwthindata->size[0] * bwthindata->size[1] * (i3
                      - 1)) - 1];
                  }
                }

                maxval = bwthindata->data[(maxval_tmp + bwthindata->size[0] *
                  b_maxval_tmp) + bwthindata->size[0] * bwthindata->size[1] *
                  c_maxval_tmp];
                for (k = 0; k < 26; k++) {
                  b = bwthindata->data[(((int32_T)bp1[(k + 1) % 3] +
                    bwthindata->size[0] * ((int32_T)BPcentroid_ROI_tmp[(k + 1) /
                    3 % 3] - 1)) + bwthindata->size[0] * bwthindata->size[1] *
                                        ((int32_T)b_BPcentroid_ROI_tmp[(k + 1) /
                    9] - 1)) - 1];
                  maxval = (((int32_T)maxval < (int32_T)b) || maxval);
                }

                if (!maxval) {
                  /*                      disp(['*****Current Pointdata Number is ' num2str(Pdata_count) '*****']) */
                  /*                      disp('   2.2---> Find Nearest Branch Point(centroid)') */
                  st.site = &gj_emlrtRSI;
                  BPcentroid_idx_0 = BPcentroid->size[0] * BPcentroid->size[1] *
                    BPcentroid->size[2];
                  b_BPcentroid = *BPcentroid;
                  n_BPcentroid[0] = BPcentroid_idx_0;
                  b_BPcentroid.size = &n_BPcentroid[0];
                  b_BPcentroid.numDimensions = 1;
                  b_st.site = &cd_emlrtRSI;
                  eml_find(&b_st, &b_BPcentroid, ii);
                  st.site = &gj_emlrtRSI;
                  d_BPcentroid[0] = BPcentroid->size[0];
                  d_BPcentroid[1] = BPcentroid->size[1];
                  d_BPcentroid[2] = BPcentroid->size[2];
                  i1 = b_ii->size[0];
                  b_ii->size[0] = ii->size[0];
                  emxEnsureCapacity_real_T(&st, b_ii, i1, &lb_emlrtRTEI);
                  loop_ub = ii->size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    b_ii->data[i1] = ii->data[i1];
                  }

                  b_st.site = &hd_emlrtRSI;
                  ind2sub_indexClass(&b_st, d_BPcentroid, b_ii, varargout_4, ii,
                                     varargout_6);
                  i1 = lenmap->size[0];
                  lenmap->size[0] = varargout_4->size[0];
                  emxEnsureCapacity_real_T(&st, lenmap, i1, &mb_emlrtRTEI);
                  loop_ub = varargout_4->size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    lenmap->data[i1] = varargout_4->data[i1];
                  }

                  i1 = ex->size[0];
                  ex->size[0] = ii->size[0];
                  emxEnsureCapacity_real_T(&st, ex, i1, &mb_emlrtRTEI);
                  loop_ub = ii->size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    ex->data[i1] = ii->data[i1];
                  }

                  i1 = ez->size[0];
                  ez->size[0] = varargout_6->size[0];
                  emxEnsureCapacity_real_T(&st, ez, i1, &mb_emlrtRTEI);
                  loop_ub = varargout_6->size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    ez->data[i1] = varargout_6->data[i1];
                  }

                  i1 = b_L_BPgroup->size[0];
                  b_L_BPgroup->size[0] = lenmap->size[0];
                  emxEnsureCapacity_boolean_T(sp, b_L_BPgroup, i1, &hi_emlrtRTEI);
                  loop_ub = lenmap->size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    b_L_BPgroup->data[i1] = (lenmap->data[i1] == BranchPoint[2]
                      + 1.0);
                  }

                  i1 = r2->size[0];
                  r2->size[0] = ex->size[0];
                  emxEnsureCapacity_boolean_T(sp, r2, i1, &ii_emlrtRTEI);
                  loop_ub = ex->size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    r2->data[i1] = (ex->data[i1] == BranchPoint[0] + 1.0);
                  }

                  if (b_L_BPgroup->size[0] != r2->size[0]) {
                    emlrtSizeEqCheck1DR2012b(b_L_BPgroup->size[0], r2->size[0],
                      &kb_emlrtECI, sp);
                  }

                  loop_ub = b_L_BPgroup->size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    b_L_BPgroup->data[i1] = (b_L_BPgroup->data[i1] && r2->
                      data[i1]);
                  }

                  i1 = r2->size[0];
                  r2->size[0] = ez->size[0];
                  emxEnsureCapacity_boolean_T(sp, r2, i1, &ji_emlrtRTEI);
                  loop_ub = ez->size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    r2->data[i1] = (ez->data[i1] == BranchPoint[4] + 1.0);
                  }

                  if (b_L_BPgroup->size[0] != r2->size[0]) {
                    emlrtSizeEqCheck1DR2012b(b_L_BPgroup->size[0], r2->size[0],
                      &lb_emlrtECI, sp);
                  }

                  st.site = &fj_emlrtRSI;
                  b_cat(&st, lenmap, ex, ez, Fyxz);
                  loop_ub = b_L_BPgroup->size[0];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    b_L_BPgroup->data[i1] = (b_L_BPgroup->data[i1] && r2->
                      data[i1]);
                  }

                  st.site = &ej_emlrtRSI;
                  nullAssignment(&st, Fyxz, b_L_BPgroup);
                  d_BPcentroid[0] = Y;
                  d_BPcentroid[1] = X;
                  d_BPcentroid[2] = Z;
                  C[0] = Fyxz->size[0];
                  C[1] = 1.0;
                  st.site = &dj_emlrtRSI;
                  b_repmat(&st, d_BPcentroid, C, lenp);
                  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])Fyxz->size,
                    *(int32_T (*)[2])lenp->size, &mb_emlrtECI, sp);
                  i1 = BPxyz->size[0] * BPxyz->size[1];
                  BPxyz->size[0] = Fyxz->size[0];
                  BPxyz->size[1] = 3;
                  emxEnsureCapacity_real_T(sp, BPxyz, i1, &ki_emlrtRTEI);
                  loop_ub = Fyxz->size[0] * Fyxz->size[1];
                  for (i1 = 0; i1 < loop_ub; i1++) {
                    BPxyz->data[i1] = Fyxz->data[i1] - lenp->data[i1];
                  }

                  st.site = &cj_emlrtRSI;
                  power(&st, BPxyz, lenp);
                  st.site = &cj_emlrtRSI;
                  g_sum(&st, lenp, LEN);
                  st.site = &bj_emlrtRSI;
                  b_st.site = &rf_emlrtRSI;
                  c_st.site = &sf_emlrtRSI;
                  d_st.site = &tf_emlrtRSI;
                  if (LEN->size[0] < 1) {
                    emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
                      "Coder:toolbox:eml_min_or_max_varDimZero",
                      "Coder:toolbox:eml_min_or_max_varDimZero", 0);
                  }

                  e_st.site = &uf_emlrtRSI;
                  n = LEN->size[0];
                  if (LEN->size[0] <= 2) {
                    if (LEN->size[0] == 1) {
                      end = 1;
                    } else if ((LEN->data[0] > LEN->data[1]) ||
                               (muDoubleScalarIsNaN(LEN->data[0]) &&
                                (!muDoubleScalarIsNaN(LEN->data[1])))) {
                      end = 2;
                    } else {
                      end = 1;
                    }
                  } else {
                    f_st.site = &xd_emlrtRSI;
                    if (!muDoubleScalarIsNaN(LEN->data[0])) {
                      end = 1;
                    } else {
                      end = 0;
                      g_st.site = &yd_emlrtRSI;
                      if (LEN->size[0] > 2147483646) {
                        h_st.site = &i_emlrtRSI;
                        check_forloop_overflow_error(&h_st);
                      }

                      k = 2;
                      exitg1 = false;
                      while ((!exitg1) && (k <= LEN->size[0])) {
                        if (!muDoubleScalarIsNaN(LEN->data[k - 1])) {
                          end = k;
                          exitg1 = true;
                        } else {
                          k++;
                        }
                      }
                    }

                    if (end == 0) {
                      end = 1;
                    } else {
                      f_st.site = &vd_emlrtRSI;
                      b_ex = LEN->data[end - 1];
                      loop_ub = end + 1;
                      g_st.site = &wd_emlrtRSI;
                      if ((end + 1 <= LEN->size[0]) && (LEN->size[0] >
                           2147483646)) {
                        h_st.site = &i_emlrtRSI;
                        check_forloop_overflow_error(&h_st);
                      }

                      for (k = loop_ub; k <= n; k++) {
                        d = LEN->data[k - 1];
                        if (b_ex > d) {
                          b_ex = d;
                          end = k;
                        }
                      }
                    }
                  }

                  if ((end < 1) || (end > Fyxz->size[0])) {
                    emlrtDynamicBoundsCheckR2012b(end, 1, Fyxz->size[0],
                      &cg_emlrtBCI, sp);
                  }

                  if (end > Fyxz->size[0]) {
                    emlrtDynamicBoundsCheckR2012b(end, 1, Fyxz->size[0],
                      &dg_emlrtBCI, sp);
                  }

                  if (end > Fyxz->size[0]) {
                    emlrtDynamicBoundsCheckR2012b(end, 1, Fyxz->size[0],
                      &eg_emlrtBCI, sp);
                  }

                  /*                          Segment(c).point = double([X2 Y2 Z2]-1); */
                  bp1[0] = Fyxz->data[(end + Fyxz->size[0]) - 1] - 1.0;
                  bp1[1] = Fyxz->data[end - 1] - 1.0;
                  bp1[2] = Fyxz->data[(end + Fyxz->size[0] * 2) - 1] - 1.0;
                  if (((int32_T)c < 1) || ((int32_T)c > 2048)) {
                    emlrtDynamicBoundsCheckR2012b((int32_T)c, 1, 2048,
                      &fg_emlrtBCI, sp);
                  }

                  SegP[(int32_T)c - 1] = bp1[0];
                  BranchPoint[1] = bp1[0];
                  SegP[(int32_T)c + 2047] = bp1[1];
                  BranchPoint[3] = bp1[1];
                  SegP[(int32_T)c + 4095] = bp1[2];
                  BranchPoint[5] = bp1[2];
                  Go2Next = false;

                  /* clear  p LEN Ind X1 Y1 Z1 X2 Y2 Z1 */
                }
              }

              /* clear  Fyxz Ind LEN p Fy Fx Fz FindNearestBP X1 X2 Y1 Y2 Z1 Z2  */
              /* clear  BPGy BPGx BPGz BPG lenp */
              if (*emlrtBreakCheckR2012bFlagVar != 0) {
                emlrtBreakCheckR2012b(sp);
              }
            }
          }
        }
      }

      /*     %% output Segment data */
      /*      Point4Len = cat(1,Segment.point); */
      for (i1 = 0; i1 < 2048; i1++) {
        x[i1] = !muDoubleScalarIsNaN(SegP[i1]);
      }

      nz = x[0];
      for (k = 0; k < 2047; k++) {
        nz += x[k + 1];
      }

      for (i1 = 0; i1 < 2048; i1++) {
        x[i1] = !muDoubleScalarIsNaN(SegP[i1]);
      }

      partialTrueCount = x[0];
      for (k = 0; k < 2047; k++) {
        partialTrueCount += x[k + 1];
      }

      if (1 > partialTrueCount) {
        loop_ub = 0;
        i1 = 0;
      } else {
        if ((nz < 1) || (nz > 2048)) {
          emlrtDynamicBoundsCheckR2012b(nz, 1, 2048, &gg_emlrtBCI, sp);
        }

        loop_ub = nz;
        i1 = nz;
      }

      iv[0] = i1;
      iv[1] = 3;
      b_c[0] = loop_ub;
      b_c[1] = 3;
      emlrtSubAssignSizeCheckR2012b(&iv[0], 2, &b_c[0], 2, &nb_emlrtECI, sp);
      for (i1 = 0; i1 < 3; i1++) {
        for (i2 = 0; i2 < loop_ub; i2++) {
          i3 = Pdata_count + 1;
          if ((i3 < 1) || (i3 > 32768)) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, 32768, &mh_emlrtBCI, sp);
          }

          i4 = i2 + (i1 << 11);
          Output_Pointdata[i3 - 1].PointXYZ[i4] = SegP[i4];
        }
      }

      /*  % Lenght by bilinear */
      if (nz == 1) {
        Output_Pointdata[Pdata_count].Length = 0.0;
      } else {
        diff(SegP, dv);
        c_repmat(Reso, dv1);
        for (i1 = 0; i1 < 6141; i1++) {
          dv1[i1] *= dv[i1];
        }

        b_power(dv1, dv);
        st.site = &aj_emlrtRSI;
        nansum(&st, dv, dv2);
        st.site = &aj_emlrtRSI;
        d_sqrt(&st, dv2);
        Output_Pointdata[Pdata_count].Length = b_nansum(dv2);
      }

      for (i1 = 0; i1 < 6144; i1++) {
        SegP[i1] = rtNaN;
      }

      Output_Pointdata[Pdata_count].Type = TYPEnum;
      for (i1 = 0; i1 < 6; i1++) {
        Output_Pointdata[Pdata_count].Branch[i1] = BranchPoint[i1];
      }

      Pdata_count++;

      /* clear  Segment Y X Z c Go2Next Point4Len LEN_reso */
    }

    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_int32_T(&r3);
  emxFree_boolean_T(&r2);
  emxFree_int32_T(&NewEz);
  emxFree_int32_T(&NewEx);
  emxFree_int32_T(&NewEy);
  emxFree_real_T(&ez);
  emxFree_real_T(&ex);
  emxFree_boolean_T(&FindNearestBP);
  emxFree_boolean_T(&BPgroup);
  emxFree_boolean_T(&BPcentroid);

  /*  Version Charly */
  /*  Find out Neighbor each BranchPoint */
  bp1[0] = OriginalBW->size[0];
  bp1[1] = OriginalBW->size[1];
  bp1[2] = OriginalBW->size[2];
  b_n = 0;
  while ((b_n < 32768) && (!muDoubleScalarIsNaN(Output_Pointdata[b_n].PointXYZ[0])))
  {
    k = 0;
    while ((k < 2048) && (!muDoubleScalarIsNaN(Output_Pointdata[b_n].PointXYZ[k])))
    {
      d = Output_Pointdata[b_n].PointXYZ[k + 2048];
      if (d != (int32_T)muDoubleScalarFloor(d)) {
        emlrtIntegerCheckR2012b(d, &l_emlrtDCI, sp);
      }

      i = (int32_T)d;
      if ((i < 1) || (i > OriginalBW->size[0])) {
        emlrtDynamicBoundsCheckR2012b(i, 1, OriginalBW->size[0], &jh_emlrtBCI,
          sp);
      }

      if (Output_Pointdata[b_n].PointXYZ[k] != (int32_T)muDoubleScalarFloor
          (Output_Pointdata[b_n].PointXYZ[k])) {
        emlrtIntegerCheckR2012b(Output_Pointdata[b_n].PointXYZ[k], &l_emlrtDCI,
          sp);
      }

      i1 = (int32_T)Output_Pointdata[b_n].PointXYZ[k];
      if ((i1 < 1) || (i1 > OriginalBW->size[1])) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, OriginalBW->size[1], &jh_emlrtBCI,
          sp);
      }

      d = Output_Pointdata[b_n].PointXYZ[k + 4096];
      if (d != (int32_T)muDoubleScalarFloor(d)) {
        emlrtIntegerCheckR2012b(d, &l_emlrtDCI, sp);
      }

      i2 = (int32_T)d;
      if ((i2 < 1) || (i2 > OriginalBW->size[2])) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, OriginalBW->size[2], &jh_emlrtBCI,
          sp);
      }

      OriginalBW->data[((i + OriginalBW->size[0] * (i1 - 1)) + OriginalBW->size
                        [0] * OriginalBW->size[1] * (i2 - 1)) - 1] = false;
      k++;
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(sp);
      }
    }

    b_n++;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  /* isempty(Pdata(n).PointXYZ) */
  /*  CC = bwconncomp(skel); */
  st.site = &yi_emlrtRSI;
  c_TS_bwlabeln3D26(&st, OriginalBW, L_BPgroup, &Y);
  loop_ub = Output_BPmatrix->size[0];
  i = BPxyz->size[0] * BPxyz->size[1];
  BPxyz->size[0] = Output_BPmatrix->size[0];
  BPxyz->size[1] = 3;
  emxEnsureCapacity_real_T(sp, BPxyz, i, &sh_emlrtRTEI);
  emxFree_boolean_T(&OriginalBW);
  for (i = 0; i < 3; i++) {
    for (i1 = 0; i1 < loop_ub; i1++) {
      BPxyz->data[i1 + BPxyz->size[0] * i] = Output_BPmatrix->data[i1 +
        Output_BPmatrix->size[0] * i];
    }

    d_BPcentroid[i] = 4.0 * Reso[i];
  }

  c_power(d_BPcentroid, BPcentroid_ROI_tmp);
  Y1 = (BPcentroid_ROI_tmp[0] + BPcentroid_ROI_tmp[1]) + BPcentroid_ROI_tmp[2];
  st.site = &xi_emlrtRSI;
  if (Y1 < 0.0) {
    emlrtErrorWithMessageIdR2018a(&st, &s_emlrtRTEI,
      "Coder:toolbox:ElFunDomainError", "Coder:toolbox:ElFunDomainError", 3, 4,
      4, "sqrt");
  }

  Y1 = muDoubleScalarSqrt(Y1);
  i = (int32_T)Y;
  emlrtForLoopVectorCheckR2012b(1.0, 1.0, Y, mxDOUBLE_CLASS, (int32_T)Y,
    &r_emlrtRTEI, sp);
  if (0 <= i - 1) {
    BPcentroid_idx_0 = L_BPgroup->size[0] * L_BPgroup->size[1] * L_BPgroup->
      size[2];
    b_loop_ub = BPcentroid_idx_0;
    i6 = Output_BPmatrix->size[0];
    c_loop_ub = BPxyz->size[0] * BPxyz->size[1];
  }

  emxInit_real_T(sp, &Nxyz, 2, &ui_emlrtRTEI, true);
  for (b_n = 0; b_n < i; b_n++) {
    st.site = &wi_emlrtRSI;
    i1 = b_L_BPgroup->size[0];
    b_L_BPgroup->size[0] = BPcentroid_idx_0;
    emxEnsureCapacity_boolean_T(&st, b_L_BPgroup, i1, &th_emlrtRTEI);
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      b_L_BPgroup->data[i1] = (L_BPgroup->data[i1] == (real_T)b_n + 1.0);
    }

    b_st.site = &cd_emlrtRSI;
    eml_find(&b_st, b_L_BPgroup, ii);
    st.site = &vi_emlrtRSI;
    i1 = b_ii->size[0];
    b_ii->size[0] = ii->size[0];
    emxEnsureCapacity_real_T(&st, b_ii, i1, &lb_emlrtRTEI);
    loop_ub = ii->size[0];
    for (i1 = 0; i1 < loop_ub; i1++) {
      b_ii->data[i1] = ii->data[i1];
    }

    b_st.site = &hd_emlrtRSI;
    ind2sub_indexClass(&b_st, bp1, b_ii, varargout_4, ii, varargout_6);
    i1 = LEN->size[0];
    LEN->size[0] = ii->size[0];
    emxEnsureCapacity_real_T(sp, LEN, i1, &nb_emlrtRTEI);
    loop_ub = ii->size[0];
    for (i1 = 0; i1 < loop_ub; i1++) {
      LEN->data[i1] = ii->data[i1];
    }

    loop_ub = varargout_4->size[0];
    i1 = b_varargout_4->size[0];
    b_varargout_4->size[0] = varargout_4->size[0];
    emxEnsureCapacity_real_T(sp, b_varargout_4, i1, &nb_emlrtRTEI);
    for (i1 = 0; i1 < loop_ub; i1++) {
      b_varargout_4->data[i1] = varargout_4->data[i1];
    }

    loop_ub = varargout_6->size[0];
    i1 = b_varargout_6->size[0];
    b_varargout_6->size[0] = varargout_6->size[0];
    emxEnsureCapacity_real_T(sp, b_varargout_6, i1, &nb_emlrtRTEI);
    for (i1 = 0; i1 < loop_ub; i1++) {
      b_varargout_6->data[i1] = varargout_6->data[i1];
    }

    st.site = &ui_emlrtRSI;
    b_cat(&st, LEN, b_varargout_4, b_varargout_6, lenp);
    i1 = Fyxz->size[0] * Fyxz->size[1];
    Fyxz->size[0] = lenp->size[0];
    Fyxz->size[1] = 3;
    emxEnsureCapacity_real_T(sp, Fyxz, i1, &uh_emlrtRTEI);
    loop_ub = lenp->size[0] * lenp->size[1] - 1;
    for (i1 = 0; i1 <= loop_ub; i1++) {
      Fyxz->data[i1] = lenp->data[i1];
    }

    st.site = &ti_emlrtRSI;
    sort_xyz(&st, Fyxz, Reso, Nxyz);
    if (1 > Nxyz->size[0]) {
      emlrtDynamicBoundsCheckR2012b(1, 1, Nxyz->size[0], &hg_emlrtBCI, sp);
    }

    d_BPcentroid[0] = Nxyz->data[0];
    d_BPcentroid[1] = Nxyz->data[Nxyz->size[0]];
    d_BPcentroid[2] = Nxyz->data[Nxyz->size[0] * 2];
    st.site = &si_emlrtRSI;
    GetEachLength(&st, d_BPcentroid, BPxyz, Reso, lenmap);
    st.site = &ri_emlrtRSI;
    b_st.site = &rf_emlrtRSI;
    c_st.site = &sf_emlrtRSI;
    d_st.site = &tf_emlrtRSI;
    if (lenmap->size[0] < 1) {
      emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
        "Coder:toolbox:eml_min_or_max_varDimZero",
        "Coder:toolbox:eml_min_or_max_varDimZero", 0);
    }

    e_st.site = &uf_emlrtRSI;
    n = lenmap->size[0];
    if (lenmap->size[0] <= 2) {
      if (lenmap->size[0] == 1) {
        b_ex = lenmap->data[0];
        end = 1;
      } else if ((lenmap->data[0] > lenmap->data[1]) || (muDoubleScalarIsNaN
                  (lenmap->data[0]) && (!muDoubleScalarIsNaN(lenmap->data[1]))))
      {
        b_ex = lenmap->data[1];
        end = 2;
      } else {
        b_ex = lenmap->data[0];
        end = 1;
      }
    } else {
      f_st.site = &xd_emlrtRSI;
      if (!muDoubleScalarIsNaN(lenmap->data[0])) {
        end = 1;
      } else {
        end = 0;
        g_st.site = &yd_emlrtRSI;
        if (lenmap->size[0] > 2147483646) {
          h_st.site = &i_emlrtRSI;
          check_forloop_overflow_error(&h_st);
        }

        k = 2;
        exitg1 = false;
        while ((!exitg1) && (k <= lenmap->size[0])) {
          if (!muDoubleScalarIsNaN(lenmap->data[k - 1])) {
            end = k;
            exitg1 = true;
          } else {
            k++;
          }
        }
      }

      if (end == 0) {
        b_ex = lenmap->data[0];
        end = 1;
      } else {
        f_st.site = &vd_emlrtRSI;
        b_ex = lenmap->data[end - 1];
        loop_ub = end + 1;
        g_st.site = &wd_emlrtRSI;
        if ((end + 1 <= lenmap->size[0]) && (lenmap->size[0] > 2147483646)) {
          h_st.site = &i_emlrtRSI;
          check_forloop_overflow_error(&h_st);
        }

        for (k = loop_ub; k <= n; k++) {
          d = lenmap->data[k - 1];
          if (b_ex > d) {
            b_ex = d;
            end = k;
          }
        }
      }
    }

    if ((end < 1) || (end > i6)) {
      emlrtDynamicBoundsCheckR2012b(end, 1, i6, &ig_emlrtBCI, sp);
    }

    i1 = lenp->size[0] * lenp->size[1];
    lenp->size[0] = BPxyz->size[0];
    lenp->size[1] = 3;
    emxEnsureCapacity_real_T(sp, lenp, i1, &vh_emlrtRTEI);
    for (i1 = 0; i1 < c_loop_ub; i1++) {
      lenp->data[i1] = BPxyz->data[i1];
    }

    st.site = &qi_emlrtRSI;
    b_nullAssignment(&st, lenp, end);
    if (Nxyz->size[0] < 1) {
      emlrtDynamicBoundsCheckR2012b(Nxyz->size[0], 1, Nxyz->size[0],
        &jg_emlrtBCI, sp);
    }

    d_BPcentroid[0] = Nxyz->data[Nxyz->size[0] - 1];
    d_BPcentroid[1] = Nxyz->data[(Nxyz->size[0] + Nxyz->size[0]) - 1];
    d_BPcentroid[2] = Nxyz->data[(Nxyz->size[0] + Nxyz->size[0] * 2) - 1];
    st.site = &pi_emlrtRSI;
    GetEachLength(&st, d_BPcentroid, lenp, Reso, lenmap);
    st.site = &oi_emlrtRSI;
    b_st.site = &rf_emlrtRSI;
    c_st.site = &sf_emlrtRSI;
    d_st.site = &tf_emlrtRSI;
    if (lenmap->size[0] < 1) {
      emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
        "Coder:toolbox:eml_min_or_max_varDimZero",
        "Coder:toolbox:eml_min_or_max_varDimZero", 0);
    }

    e_st.site = &uf_emlrtRSI;
    n = lenmap->size[0];
    if (lenmap->size[0] <= 2) {
      if (lenmap->size[0] == 1) {
        Y = lenmap->data[0];
        partialTrueCount = 1;
      } else if ((lenmap->data[0] > lenmap->data[1]) || (muDoubleScalarIsNaN
                  (lenmap->data[0]) && (!muDoubleScalarIsNaN(lenmap->data[1]))))
      {
        Y = lenmap->data[1];
        partialTrueCount = 2;
      } else {
        Y = lenmap->data[0];
        partialTrueCount = 1;
      }
    } else {
      f_st.site = &xd_emlrtRSI;
      if (!muDoubleScalarIsNaN(lenmap->data[0])) {
        partialTrueCount = 1;
      } else {
        partialTrueCount = 0;
        g_st.site = &yd_emlrtRSI;
        if (lenmap->size[0] > 2147483646) {
          h_st.site = &i_emlrtRSI;
          check_forloop_overflow_error(&h_st);
        }

        k = 2;
        exitg1 = false;
        while ((!exitg1) && (k <= lenmap->size[0])) {
          if (!muDoubleScalarIsNaN(lenmap->data[k - 1])) {
            partialTrueCount = k;
            exitg1 = true;
          } else {
            k++;
          }
        }
      }

      if (partialTrueCount == 0) {
        Y = lenmap->data[0];
        partialTrueCount = 1;
      } else {
        f_st.site = &vd_emlrtRSI;
        Y = lenmap->data[partialTrueCount - 1];
        loop_ub = partialTrueCount + 1;
        g_st.site = &wd_emlrtRSI;
        if ((partialTrueCount + 1 <= lenmap->size[0]) && (lenmap->size[0] >
             2147483646)) {
          h_st.site = &i_emlrtRSI;
          check_forloop_overflow_error(&h_st);
        }

        for (k = loop_ub; k <= n; k++) {
          d = lenmap->data[k - 1];
          if (Y > d) {
            Y = d;
            partialTrueCount = k;
          }
        }
      }
    }

    if ((partialTrueCount < 1) || (partialTrueCount > lenp->size[0])) {
      emlrtDynamicBoundsCheckR2012b(partialTrueCount, 1, lenp->size[0],
        &kg_emlrtBCI, sp);
    }

    st.site = &ni_emlrtRSI;
    d_cat(b_ex, Y, C);
    b_st.site = &qd_emlrtRSI;
    c_st.site = &rd_emlrtRSI;
    d_st.site = &sd_emlrtRSI;
    e_st.site = &td_emlrtRSI;
    f_st.site = &ud_emlrtRSI;
    if ((C[0] < C[1]) || (muDoubleScalarIsNaN(C[0]) && (!muDoubleScalarIsNaN(C[1]))))
    {
      Y = C[1];
    } else {
      Y = C[0];
    }

    if (Y1 > Y) {
      Y = BPxyz->data[end - 1];
      d_BPcentroid[0] = Y;
      X = lenp->data[partialTrueCount - 1];
      b_lenp[0] = X;
      Z = BPxyz->data[(end + BPxyz->size[0]) - 1];
      d_BPcentroid[1] = Z;
      Lnum = lenp->data[(partialTrueCount + lenp->size[0]) - 1];
      b_lenp[1] = Lnum;
      TYPEnum = BPxyz->data[(end + BPxyz->size[0] * 2) - 1];
      d_BPcentroid[2] = TYPEnum;
      X1 = lenp->data[(partialTrueCount + lenp->size[0] * 2) - 1];
      b_lenp[2] = X1;
      st.site = &mi_emlrtRSI;
      e_cat(&st, d_BPcentroid, Nxyz, b_lenp, Fyxz);
      if ((Fyxz->size[0] < 1) || (Fyxz->size[0] > 2048)) {
        emlrtDynamicBoundsCheckR2012b(Fyxz->size[0], 1, 2048, &lg_emlrtBCI, sp);
      }

      b_c[0] = Fyxz->size[0];
      b_c[1] = 3;
      emlrtSubAssignSizeCheckR2012b(&b_c[0], 2, &Fyxz->size[0], 2, &ob_emlrtECI,
        sp);
      loop_ub = Fyxz->size[0];
      for (i1 = 0; i1 < 3; i1++) {
        for (i2 = 0; i2 < loop_ub; i2++) {
          i3 = Pdata_count + 1;
          if ((i3 < 1) || (i3 > 32768)) {
            emlrtDynamicBoundsCheckR2012b(i3, 1, 32768, &gi_emlrtBCI, sp);
          }

          Output_Pointdata[i3 - 1].PointXYZ[i2 + (i1 << 11)] = Fyxz->data[i2 +
            Fyxz->size[0] * i1];
        }
      }

      st.site = &li_emlrtRSI;
      xyz2plen(&st, Fyxz, Reso, lenmap);
      st.site = &li_emlrtRSI;
      Output_Pointdata[Pdata_count].Length = c_nansum(&st, lenmap);
      Output_Pointdata[Pdata_count].Type = 0.0;

      /* 'Branch to Branch'; */
      d_BPcentroid[0] = Y;
      b_lenp[0] = X;
      d_BPcentroid[1] = Z;
      b_lenp[1] = Lnum;
      d_BPcentroid[2] = TYPEnum;
      b_lenp[2] = X1;
      f_cat(d_BPcentroid, b_lenp, Output_Pointdata[Pdata_count].Branch);
      Pdata_count++;
    }

    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_boolean_T(&b_L_BPgroup);
  emxFree_real_T(&b_varargout_6);
  emxFree_real_T(&b_varargout_4);
  emxFree_real_T(&b_ii);
  emxFree_int32_T(&varargout_4);
  emxFree_int32_T(&varargout_6);
  emxFree_int32_T(&ii);
  emxFree_real_T(&lenp);
  emxFree_real_T(&lenmap);
  emxFree_real_T(&Nxyz);
  emxFree_real_T(&BPxyz);
  emxFree_real_T(&Fyxz);
  emxFree_real_T(&LEN);
  emxFree_real_T(&L_BPgroup);

  /*  Delete empty  */
  /*  try */
  /*  Pdata(Pdata_count:end) = []; */
  /*  catch */
  /*  end */
  /*  BP point infomation,[X Y Z Number Count] */
  /*  Branch = cat(1,Pdata.Branch); */
  for (i = 0; i < 196608; i++) {
    SD->u1.f2.Branch[i] = rtNaN;
  }

  Y = 1.0;
  iv[1] = 3;
  b_c[1] = 3;
  for (b_n = 0; b_n < 32768; b_n++) {
    partialTrueCount = !muDoubleScalarIsNaN(Output_Pointdata[b_n].Branch[0]) +
      !muDoubleScalarIsNaN(Output_Pointdata[b_n].Branch[1]);
    if (1 > partialTrueCount) {
      loop_ub = 0;
    } else {
      if (partialTrueCount < 1) {
        emlrtDynamicBoundsCheckR2012b(0, 1, 2, &mg_emlrtBCI, sp);
      }

      loop_ub = partialTrueCount;
    }

    d = Y + (real_T)partialTrueCount;
    if (Y > d - 1.0) {
      i = 0;
      i1 = 0;
    } else {
      i = (int32_T)Y;
      if ((i < 1) || (i > 65536)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 65536, &og_emlrtBCI, sp);
      }

      i--;
      i1 = (int32_T)(d - 1.0);
      if ((i1 < 1) || (i1 > 65536)) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, 65536, &pg_emlrtBCI, sp);
      }
    }

    iv[0] = i1 - i;
    b_c[0] = loop_ub;
    emlrtSubAssignSizeCheckR2012b(&iv[0], 2, &b_c[0], 2, &pb_emlrtECI, sp);
    for (i1 = 0; i1 < 3; i1++) {
      for (i2 = 0; i2 < loop_ub; i2++) {
        SD->u1.f2.Branch[(i + i2) + (i1 << 16)] = Output_Pointdata[b_n]
          .Branch[i2 + (i1 << 1)];
      }
    }

    Y = d;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  i = Output_BPmatrix->size[0];
  for (b_n = 0; b_n < i; b_n++) {
    i1 = b_n + 1;
    if ((i1 < 1) || (i1 > Output_BPmatrix->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, Output_BPmatrix->size[0],
        &ng_emlrtBCI, sp);
    }

    Y = 0.0;
    k = 0;
    while ((k < 65536) && (!muDoubleScalarIsNaN(SD->u1.f2.Branch[k]))) {
      if ((SD->u1.f2.Branch[k] == Output_BPmatrix->data[b_n]) &&
          (SD->u1.f2.Branch[k + 65536] == Output_BPmatrix->data[b_n +
           Output_BPmatrix->size[0]]) && (SD->u1.f2.Branch[k + 131072] ==
           Output_BPmatrix->data[b_n + Output_BPmatrix->size[0] * 2])) {
        Y++;
      }

      k++;
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(sp);
      }
    }

    i1 = b_n + 1;
    if ((i1 < 1) || (i1 > Output_BPmatrix->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, Output_BPmatrix->size[0],
        &lh_emlrtBCI, sp);
    }

    Output_BPmatrix->data[(i1 + Output_BPmatrix->size[0] * 4) - 1] = Y;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

static const mxArray *b_emlrt_marshallOut(const emlrtStack *sp, const char_T u
  [51])
{
  const mxArray *y;
  const mxArray *m;
  static const int32_T iv[2] = { 1, 51 };

  y = NULL;
  m = emlrtCreateCharArray(2, iv);
  emlrtInitCharArrayR2013a(sp, 51, m, &u[0]);
  emlrtAssign(&y, m);
  return y;
}

static const mxArray *c_emlrt_marshallOut(const emlrtStack *sp, const char_T u
  [26])
{
  const mxArray *y;
  const mxArray *m;
  static const int32_T iv[2] = { 1, 26 };

  y = NULL;
  m = emlrtCreateCharArray(2, iv);
  emlrtInitCharArrayR2013a(sp, 26, m, &u[0]);
  emlrtAssign(&y, m);
  return y;
}

static const mxArray *emlrt_marshallOut(const emlrtStack *sp, const char_T u[36])
{
  const mxArray *y;
  const mxArray *m;
  static const int32_T iv[2] = { 1, 36 };

  y = NULL;
  m = emlrtCreateCharArray(2, iv);
  emlrtInitCharArrayR2013a(sp, 36, m, &u[0]);
  emlrtAssign(&y, m);
  return y;
}

static void sort_xyz(const emlrtStack *sp, emxArray_real_T *xyz, const real_T
                     Reso[3], emxArray_real_T *Nxyz)
{
  emxArray_real_T *lenmap;
  int32_T a;
  int32_T loop_ub;
  emxArray_real_T *b_select;
  emxArray_real_T *LEN;
  emxArray_real_T *r;
  emxArray_real_T *b_xyz;
  int32_T n;
  emxArray_real_T *LenVal;
  int32_T k;
  real_T beforP[3];
  real_T c_xyz[2];
  int32_T idx;
  real_T ex;
  boolean_T exitg1;
  int32_T b_lenmap[1];
  real_T Nxyz_tmp;
  real_T b_Nxyz_tmp;
  uint32_T c;
  emxArray_real_T *c_lenmap;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack f_st;
  emlrtStack g_st;
  emlrtStack h_st;
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
  g_st.prev = &f_st;
  g_st.tls = f_st.tls;
  h_st.prev = &g_st;
  h_st.tls = g_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  if (xyz->size[0] <= 2) {
    a = Nxyz->size[0] * Nxyz->size[1];
    Nxyz->size[0] = xyz->size[0];
    Nxyz->size[1] = 3;
    emxEnsureCapacity_real_T(sp, Nxyz, a, &ej_emlrtRTEI);
    loop_ub = xyz->size[0] * xyz->size[1];
    for (a = 0; a < loop_ub; a++) {
      Nxyz->data[a] = xyz->data[a];
    }
  } else {
    emxInit_real_T(sp, &lenmap, 2, &fj_emlrtRTEI, true);
    st.site = &wm_emlrtRSI;
    a = lenmap->size[0] * lenmap->size[1];
    lenmap->size[0] = xyz->size[0];
    lenmap->size[1] = xyz->size[0];
    emxEnsureCapacity_real_T(&st, lenmap, a, &fj_emlrtRTEI);
    loop_ub = xyz->size[0] * xyz->size[0];
    for (a = 0; a < loop_ub; a++) {
      lenmap->data[a] = 0.0;
    }

    a = xyz->size[0];
    emxInit_real_T(&st, &b_select, 2, &kj_emlrtRTEI, true);
    emxInit_real_T(&st, &LEN, 1, &lj_emlrtRTEI, true);
    emxInit_real_T(&st, &r, 2, &mj_emlrtRTEI, true);
    emxInit_real_T(&st, &b_xyz, 2, &gj_emlrtRTEI, true);
    for (n = 0; n < a; n++) {
      k = n + 1;
      if ((k < 1) || (k > xyz->size[0])) {
        emlrtDynamicBoundsCheckR2012b(k, 1, xyz->size[0], &ek_emlrtBCI, &st);
      }

      beforP[0] = xyz->data[n];
      beforP[1] = xyz->data[n + xyz->size[0]];
      beforP[2] = xyz->data[n + xyz->size[0] * 2];
      c_xyz[0] = xyz->size[0];
      c_xyz[1] = 1.0;
      b_st.site = &en_emlrtRSI;
      b_repmat(&b_st, beforP, c_xyz, b_select);
      emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])xyz->size, *(int32_T (*)[2])
        b_select->size, &qb_emlrtECI, &st);
      c_xyz[0] = xyz->size[0];
      c_xyz[1] = 1.0;
      b_st.site = &fn_emlrtRSI;
      b_repmat(&b_st, Reso, c_xyz, r);
      emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])xyz->size, *(int32_T (*)[2])
        r->size, &rb_emlrtECI, &st);
      k = b_xyz->size[0] * b_xyz->size[1];
      b_xyz->size[0] = xyz->size[0];
      b_xyz->size[1] = 3;
      emxEnsureCapacity_real_T(&st, b_xyz, k, &gj_emlrtRTEI);
      loop_ub = xyz->size[0] * xyz->size[1];
      for (k = 0; k < loop_ub; k++) {
        b_xyz->data[k] = (xyz->data[k] - b_select->data[k]) * r->data[k];
      }

      b_st.site = &gn_emlrtRSI;
      power(&b_st, b_xyz, r);
      b_st.site = &gn_emlrtRSI;
      g_sum(&b_st, r, LEN);
      b_st.site = &gn_emlrtRSI;
      b_sqrt(&b_st, LEN);
      k = n + 1;
      if ((k < 1) || (k > lenmap->size[1])) {
        emlrtDynamicBoundsCheckR2012b(k, 1, lenmap->size[1], &fk_emlrtBCI, &st);
      }

      b_lenmap[0] = lenmap->size[0];
      emlrtSubAssignSizeCheckR2012b(&b_lenmap[0], 1, &LEN->size[0], 1,
        &sb_emlrtECI, &st);
      loop_ub = LEN->size[0];
      for (k = 0; k < loop_ub; k++) {
        lenmap->data[k + lenmap->size[0] * n] = LEN->data[k];
      }

      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(&st);
      }
    }

    emxInit_real_T(&st, &LenVal, 2, &jj_emlrtRTEI, true);
    st.site = &xm_emlrtRSI;
    b_sum(&st, lenmap, LenVal);
    st.site = &ym_emlrtRSI;
    b_st.site = &lg_emlrtRSI;
    c_st.site = &sf_emlrtRSI;
    d_st.site = &tf_emlrtRSI;
    emxFree_real_T(&lenmap);
    if (LenVal->size[1] < 1) {
      emlrtErrorWithMessageIdR2018a(&d_st, &d_emlrtRTEI,
        "Coder:toolbox:eml_min_or_max_varDimZero",
        "Coder:toolbox:eml_min_or_max_varDimZero", 0);
    }

    e_st.site = &uf_emlrtRSI;
    n = LenVal->size[1];
    if (LenVal->size[1] <= 2) {
      if (LenVal->size[1] == 1) {
        idx = 1;
      } else if ((LenVal->data[0] < LenVal->data[1]) || (muDoubleScalarIsNaN
                  (LenVal->data[0]) && (!muDoubleScalarIsNaN(LenVal->data[1]))))
      {
        idx = 2;
      } else {
        idx = 1;
      }
    } else {
      f_st.site = &xd_emlrtRSI;
      if (!muDoubleScalarIsNaN(LenVal->data[0])) {
        idx = 1;
      } else {
        idx = 0;
        g_st.site = &yd_emlrtRSI;
        if (LenVal->size[1] > 2147483646) {
          h_st.site = &i_emlrtRSI;
          check_forloop_overflow_error(&h_st);
        }

        k = 2;
        exitg1 = false;
        while ((!exitg1) && (k <= LenVal->size[1])) {
          if (!muDoubleScalarIsNaN(LenVal->data[k - 1])) {
            idx = k;
            exitg1 = true;
          } else {
            k++;
          }
        }
      }

      if (idx == 0) {
        idx = 1;
      } else {
        f_st.site = &vd_emlrtRSI;
        ex = LenVal->data[idx - 1];
        a = idx + 1;
        g_st.site = &wd_emlrtRSI;
        if ((idx + 1 <= LenVal->size[1]) && (LenVal->size[1] > 2147483646)) {
          h_st.site = &i_emlrtRSI;
          check_forloop_overflow_error(&h_st);
        }

        for (k = a; k <= n; k++) {
          Nxyz_tmp = LenVal->data[k - 1];
          if (ex < Nxyz_tmp) {
            ex = Nxyz_tmp;
            idx = k;
          }
        }
      }
    }

    emxFree_real_T(&LenVal);
    a = Nxyz->size[0] * Nxyz->size[1];
    Nxyz->size[0] = xyz->size[0];
    Nxyz->size[1] = 3;
    emxEnsureCapacity_real_T(sp, Nxyz, a, &hj_emlrtRTEI);
    loop_ub = xyz->size[0] * xyz->size[1];
    for (a = 0; a < loop_ub; a++) {
      Nxyz->data[a] = xyz->data[a];
    }

    if ((idx < 1) || (idx > xyz->size[0])) {
      emlrtDynamicBoundsCheckR2012b(idx, 1, xyz->size[0], &yj_emlrtBCI, sp);
    }

    ex = xyz->data[idx - 1];
    Nxyz->data[0] = ex;
    Nxyz_tmp = xyz->data[(idx + xyz->size[0]) - 1];
    Nxyz->data[Nxyz->size[0]] = Nxyz_tmp;
    b_Nxyz_tmp = xyz->data[(idx + xyz->size[0] * 2) - 1];
    Nxyz->data[Nxyz->size[0] * 2] = b_Nxyz_tmp;
    if (idx > xyz->size[0]) {
      emlrtDynamicBoundsCheckR2012b(idx, 1, xyz->size[0], &ak_emlrtBCI, sp);
    }

    beforP[0] = ex;
    beforP[1] = Nxyz_tmp;
    beforP[2] = b_Nxyz_tmp;
    st.site = &an_emlrtRSI;
    b_nullAssignment(&st, xyz, idx);
    c = 2U;
    emxInit_real_T(sp, &c_lenmap, 1, &fj_emlrtRTEI, true);
    while (xyz->size[0] != 0) {
      st.site = &bn_emlrtRSI;
      a = c_lenmap->size[0];
      c_lenmap->size[0] = xyz->size[0];
      emxEnsureCapacity_real_T(&st, c_lenmap, a, &ij_emlrtRTEI);
      loop_ub = xyz->size[0];
      for (a = 0; a < loop_ub; a++) {
        c_lenmap->data[a] = 0.0;
      }

      c_xyz[0] = xyz->size[0];
      c_xyz[1] = 1.0;
      b_st.site = &en_emlrtRSI;
      b_repmat(&b_st, beforP, c_xyz, b_select);
      emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])xyz->size, *(int32_T (*)[2])
        b_select->size, &qb_emlrtECI, &st);
      c_xyz[0] = xyz->size[0];
      c_xyz[1] = 1.0;
      b_st.site = &fn_emlrtRSI;
      b_repmat(&b_st, Reso, c_xyz, r);
      emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])xyz->size, *(int32_T (*)[2])
        r->size, &rb_emlrtECI, &st);
      a = b_xyz->size[0] * b_xyz->size[1];
      b_xyz->size[0] = xyz->size[0];
      b_xyz->size[1] = 3;
      emxEnsureCapacity_real_T(&st, b_xyz, a, &gj_emlrtRTEI);
      loop_ub = xyz->size[0] * xyz->size[1];
      for (a = 0; a < loop_ub; a++) {
        b_xyz->data[a] = (xyz->data[a] - b_select->data[a]) * r->data[a];
      }

      b_st.site = &gn_emlrtRSI;
      power(&b_st, b_xyz, r);
      b_st.site = &gn_emlrtRSI;
      g_sum(&b_st, r, LEN);
      b_st.site = &gn_emlrtRSI;
      b_sqrt(&b_st, LEN);
      b_lenmap[0] = xyz->size[0];
      emlrtSubAssignSizeCheckR2012b(&b_lenmap[0], 1, &LEN->size[0], 1,
        &sb_emlrtECI, &st);
      loop_ub = LEN->size[0];
      for (a = 0; a < loop_ub; a++) {
        c_lenmap->data[a] = LEN->data[a];
      }

      st.site = &cn_emlrtRSI;
      b_st.site = &rf_emlrtRSI;
      c_st.site = &sf_emlrtRSI;
      d_st.site = &tf_emlrtRSI;
      e_st.site = &uf_emlrtRSI;
      n = c_lenmap->size[0];
      if (c_lenmap->size[0] <= 2) {
        if (c_lenmap->size[0] == 1) {
          idx = 1;
        } else if ((c_lenmap->data[0] > c_lenmap->data[1]) ||
                   (muDoubleScalarIsNaN(c_lenmap->data[0]) &&
                    (!muDoubleScalarIsNaN(c_lenmap->data[1])))) {
          idx = 2;
        } else {
          idx = 1;
        }
      } else {
        f_st.site = &xd_emlrtRSI;
        if (!muDoubleScalarIsNaN(c_lenmap->data[0])) {
          idx = 1;
        } else {
          idx = 0;
          g_st.site = &yd_emlrtRSI;
          if (c_lenmap->size[0] > 2147483646) {
            h_st.site = &i_emlrtRSI;
            check_forloop_overflow_error(&h_st);
          }

          k = 2;
          exitg1 = false;
          while ((!exitg1) && (k <= c_lenmap->size[0])) {
            if (!muDoubleScalarIsNaN(c_lenmap->data[k - 1])) {
              idx = k;
              exitg1 = true;
            } else {
              k++;
            }
          }
        }

        if (idx == 0) {
          idx = 1;
        } else {
          f_st.site = &vd_emlrtRSI;
          ex = c_lenmap->data[idx - 1];
          a = idx + 1;
          g_st.site = &wd_emlrtRSI;
          if ((idx + 1 <= c_lenmap->size[0]) && (c_lenmap->size[0] > 2147483646))
          {
            h_st.site = &i_emlrtRSI;
            check_forloop_overflow_error(&h_st);
          }

          for (k = a; k <= n; k++) {
            Nxyz_tmp = c_lenmap->data[k - 1];
            if (ex > Nxyz_tmp) {
              ex = Nxyz_tmp;
              idx = k;
            }
          }
        }
      }

      if ((idx < 1) || (idx > xyz->size[0])) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, xyz->size[0], &bk_emlrtBCI, sp);
      }

      if (((int32_T)c < 1) || ((int32_T)c > Nxyz->size[0])) {
        emlrtDynamicBoundsCheckR2012b((int32_T)c, 1, Nxyz->size[0], &dk_emlrtBCI,
          sp);
      }

      k = (int32_T)c - 1;
      ex = xyz->data[idx - 1];
      Nxyz->data[k] = ex;
      Nxyz_tmp = xyz->data[(idx + xyz->size[0]) - 1];
      Nxyz->data[k + Nxyz->size[0]] = Nxyz_tmp;
      b_Nxyz_tmp = xyz->data[(idx + xyz->size[0] * 2) - 1];
      Nxyz->data[k + Nxyz->size[0] * 2] = b_Nxyz_tmp;
      if (idx > xyz->size[0]) {
        emlrtDynamicBoundsCheckR2012b(idx, 1, xyz->size[0], &ck_emlrtBCI, sp);
      }

      beforP[0] = ex;
      beforP[1] = Nxyz_tmp;
      beforP[2] = b_Nxyz_tmp;
      st.site = &dn_emlrtRSI;
      b_nullAssignment(&st, xyz, idx);
      c++;
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(sp);
      }
    }

    emxFree_real_T(&b_xyz);
    emxFree_real_T(&r);
    emxFree_real_T(&LEN);
    emxFree_real_T(&b_select);
    emxFree_real_T(&c_lenmap);
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void AutoSegment(AutoSegmentStackData *SD, const emlrtStack *sp,
                 emxArray_boolean_T *skel, const real_T NewReso[3],
                 emxArray_boolean_T *AddBP, real_T cutlen, struct0_T *SEG)
{
  int32_T k;
  emxArray_boolean_T *skel2;
  emxArray_boolean_T *SEG_Input;
  uint32_T unnamed_idx_0;
  emxArray_boolean_T *skel1;
  uint32_T unnamed_idx_1;
  uint32_T unnamed_idx_2;
  int32_T vlen;
  real_T lnum;
  emxArray_real_T *SEG_BPmatrix;
  emxArray_boolean_T *expl_temp;
  emxArray_boolean_T *b_expl_temp;
  emxArray_boolean_T *c_expl_temp;
  emxArray_boolean_T *d_expl_temp;
  real_T e_expl_temp[3];
  int32_T exitg1;
  int32_T nz;
  int32_T b_nz;
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

  /*  SEG = TS_AutoSegment_loop(skel,NewReso,AddBP,cutlen) */
  /*  version 19Charly, a bag modiry.... true connection in b2b. */
  /*  version 19Delta (just name AutoSegment) is writen for mex c-code */
  /*     by Sugashi, 2019, 11, 17 */
  /*  */
  /*  other function  */
  /*  AtSEG_shaving */
  /*  AutoSegment_Pre */
  /*  AutoSegment(self) */
  /*  GetEachLength */
  /*  sort_xyz */
  /*  TS_AutoSegment_base */
  /*  TS_bwlabeln3D26 */
  /*  TS_bwlabeln3D26 > Labeling */
  /*  TS_bwlabeln3D26 > TS_bwlabeln_linux_c */
  /*  TS_Label2Centroid */
  /*  TS_Label2Centroid > vectGra */
  /*  TS_skel2endpoint */
  /*  TS_skel2endpoint > CreateSE */
  /*  TS_Skeleton3D_oldest */
  /*  TS_Skeleton3D_oldest > TS_find */
  /*  TS_skelmorph3d */
  /*  xyz2plen */
  k = 3;
  if (skel->size[2] == 1) {
    k = 2;
  }

  emxInit_boolean_T(sp, &skel2, 3, &eb_emlrtRTEI, true);
  emxInit_boolean_T(sp, &SEG_Input, 3, &fb_emlrtRTEI, true);
  if (k == 2) {
    unnamed_idx_0 = (uint32_T)skel->size[0];
    unnamed_idx_1 = (uint32_T)skel->size[1];
    unnamed_idx_2 = (uint32_T)skel->size[2];
    k = SEG_Input->size[0] * SEG_Input->size[1] * SEG_Input->size[2];
    SEG_Input->size[0] = (int32_T)unnamed_idx_0;
    SEG_Input->size[1] = (int32_T)unnamed_idx_1;
    SEG_Input->size[2] = (int32_T)unnamed_idx_2;
    emxEnsureCapacity_boolean_T(sp, SEG_Input, k, &w_emlrtRTEI);
    vlen = (int32_T)unnamed_idx_0 * (int32_T)unnamed_idx_1 * (int32_T)
      unnamed_idx_2;
    for (k = 0; k < vlen; k++) {
      SEG_Input->data[k] = false;
    }

    k = skel2->size[0] * skel2->size[1] * skel2->size[2];
    skel2->size[0] = skel->size[0];
    skel2->size[1] = skel->size[1];
    skel2->size[2] = skel->size[2];
    emxEnsureCapacity_boolean_T(sp, skel2, k, &y_emlrtRTEI);
    vlen = skel->size[0] * skel->size[1] * skel->size[2] - 1;
    for (k = 0; k <= vlen; k++) {
      skel2->data[k] = skel->data[k];
    }

    st.site = &emlrtRSI;
    cat(&st, skel2, SEG_Input, skel);
  }

  emxInit_boolean_T(sp, &skel1, 3, &v_emlrtRTEI, true);
  k = skel1->size[0] * skel1->size[1] * skel1->size[2];
  skel1->size[0] = skel->size[0];
  skel1->size[1] = skel->size[1];
  skel1->size[2] = skel->size[2];
  emxEnsureCapacity_boolean_T(sp, skel1, k, &v_emlrtRTEI);
  vlen = skel->size[0] * skel->size[1] * skel->size[2];
  for (k = 0; k < vlen; k++) {
    skel1->data[k] = skel->data[k];
  }

  if ((AddBP->size[0] == 0) || (AddBP->size[1] == 0) || (AddBP->size[2] == 0)) {
    unnamed_idx_0 = (uint32_T)skel->size[0];
    unnamed_idx_1 = (uint32_T)skel->size[1];
    unnamed_idx_2 = (uint32_T)skel->size[2];
    k = AddBP->size[0] * AddBP->size[1] * AddBP->size[2];
    AddBP->size[0] = (int32_T)unnamed_idx_0;
    AddBP->size[1] = (int32_T)unnamed_idx_1;
    AddBP->size[2] = (int32_T)unnamed_idx_2;
    emxEnsureCapacity_boolean_T(sp, AddBP, k, &x_emlrtRTEI);
    vlen = (int32_T)unnamed_idx_0 * (int32_T)unnamed_idx_1 * (int32_T)
      unnamed_idx_2;
    for (k = 0; k < vlen; k++) {
      AddBP->data[k] = false;
    }
  }

  lnum = 1.0;
  emxInit_real_T(sp, &SEG_BPmatrix, 2, &fb_emlrtRTEI, true);
  emxInit_boolean_T(sp, &expl_temp, 3, &gb_emlrtRTEI, true);
  emxInit_boolean_T(sp, &b_expl_temp, 3, &gb_emlrtRTEI, true);
  emxInit_boolean_T(sp, &c_expl_temp, 3, &gb_emlrtRTEI, true);
  emxInit_boolean_T(sp, &d_expl_temp, 3, &gb_emlrtRTEI, true);
  if (cutlen > 0.0) {
    k = skel2->size[0] * skel2->size[1] * skel2->size[2];
    skel2->size[0] = skel->size[0];
    skel2->size[1] = skel->size[1];
    skel2->size[2] = skel->size[2];
    emxEnsureCapacity_boolean_T(sp, skel2, k, &ab_emlrtRTEI);
    vlen = skel->size[0] * skel->size[1] * skel->size[2] - 1;
    for (k = 0; k <= vlen; k++) {
      skel2->data[k] = skel->data[k];
    }

    st.site = &b_emlrtRSI;
    AutoSegment_Pre(SD, &st, skel2, NewReso, AddBP, SEG_Input, expl_temp,
                    b_expl_temp, c_expl_temp, d_expl_temp, SD->f4.SEG_Pointdata,
                    e_expl_temp, SEG_BPmatrix);
    st.site = &c_emlrtRSI;
    AtSEG_shaving(SD, &st, SEG_Input, SD->f4.SEG_Pointdata, SEG_BPmatrix, cutlen,
                  skel2);
    do {
      exitg1 = 0;
      st.site = &d_emlrtRSI;
      b_st.site = &jg_emlrtRSI;
      c_st.site = &re_emlrtRSI;
      vlen = skel1->size[0] * skel1->size[1] * skel1->size[2];
      if (skel1->size[0] * skel1->size[1] * skel1->size[2] == 0) {
        nz = 0;
      } else {
        d_st.site = &se_emlrtRSI;
        nz = skel1->data[0];
        e_st.site = &ve_emlrtRSI;
        if ((2 <= skel1->size[0] * skel1->size[1] * skel1->size[2]) &&
            (skel1->size[0] * skel1->size[1] * skel1->size[2] > 2147483646)) {
          f_st.site = &i_emlrtRSI;
          check_forloop_overflow_error(&f_st);
        }

        for (k = 2; k <= vlen; k++) {
          nz += skel1->data[k - 1];
        }
      }

      st.site = &d_emlrtRSI;
      b_st.site = &jg_emlrtRSI;
      c_st.site = &re_emlrtRSI;
      vlen = skel2->size[0] * skel2->size[1] * skel2->size[2];
      if (skel2->size[0] * skel2->size[1] * skel2->size[2] == 0) {
        b_nz = 0;
      } else {
        d_st.site = &se_emlrtRSI;
        b_nz = skel2->data[0];
        e_st.site = &ve_emlrtRSI;
        if ((2 <= skel2->size[0] * skel2->size[1] * skel2->size[2]) &&
            (skel2->size[0] * skel2->size[1] * skel2->size[2] > 2147483646)) {
          f_st.site = &i_emlrtRSI;
          check_forloop_overflow_error(&f_st);
        }

        for (k = 2; k <= vlen; k++) {
          b_nz += skel2->data[k - 1];
        }
      }

      if (nz != b_nz) {
        /*          disp(['  Now Shaving... loop No. ' num2str(lnum)]) */
        k = skel1->size[0] * skel1->size[1] * skel1->size[2];
        skel1->size[0] = SEG_Input->size[0];
        skel1->size[1] = SEG_Input->size[1];
        skel1->size[2] = SEG_Input->size[2];
        emxEnsureCapacity_boolean_T(sp, skel1, k, &db_emlrtRTEI);
        vlen = SEG_Input->size[0] * SEG_Input->size[1] * SEG_Input->size[2];
        for (k = 0; k < vlen; k++) {
          skel1->data[k] = SEG_Input->data[k];
        }

        st.site = &e_emlrtRSI;
        AutoSegment_Pre(SD, &st, skel2, NewReso, AddBP, SEG_Input, expl_temp,
                        b_expl_temp, c_expl_temp, d_expl_temp,
                        SD->f4.SEG_Pointdata, e_expl_temp, SEG_BPmatrix);
        st.site = &f_emlrtRSI;
        AtSEG_shaving(SD, &st, SEG_Input, SD->f4.SEG_Pointdata, SEG_BPmatrix,
                      cutlen, skel2);
        lnum++;
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(sp);
        }
      } else {
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    /* clear  skel2 */
    /*  AddBP = false(size(skel)); */
    /*  SEG = TS_AutoSegment1st_New20161021(skel1,NewReso,AddBP); */
  }

  emxFree_boolean_T(&skel2);
  st.site = &g_emlrtRSI;
  TS_AutoSegment_base(SD, &st, skel1, NewReso, AddBP, SEG_Input, expl_temp,
                      b_expl_temp, c_expl_temp, d_expl_temp, SD->f4.t0_Pointdata,
                      e_expl_temp, SEG_BPmatrix);
  k = SEG->Output->size[0] * SEG->Output->size[1] * SEG->Output->size[2];
  SEG->Output->size[0] = SEG_Input->size[0];
  SEG->Output->size[1] = SEG_Input->size[1];
  SEG->Output->size[2] = SEG_Input->size[2];
  emxEnsureCapacity_boolean_T(sp, SEG->Output, k, &bb_emlrtRTEI);
  vlen = SEG_Input->size[0] * SEG_Input->size[1] * SEG_Input->size[2];
  emxFree_boolean_T(&skel1);
  for (k = 0; k < vlen; k++) {
    SEG->Output->data[k] = SEG_Input->data[k];
  }

  emxFree_boolean_T(&SEG_Input);
  k = SEG->AddBP->size[0] * SEG->AddBP->size[1] * SEG->AddBP->size[2];
  SEG->AddBP->size[0] = expl_temp->size[0];
  SEG->AddBP->size[1] = expl_temp->size[1];
  SEG->AddBP->size[2] = expl_temp->size[2];
  emxEnsureCapacity_boolean_T(sp, SEG->AddBP, k, &bb_emlrtRTEI);
  vlen = expl_temp->size[0] * expl_temp->size[1] * expl_temp->size[2];
  for (k = 0; k < vlen; k++) {
    SEG->AddBP->data[k] = expl_temp->data[k];
  }

  emxFree_boolean_T(&expl_temp);
  k = SEG->Branch->size[0] * SEG->Branch->size[1] * SEG->Branch->size[2];
  SEG->Branch->size[0] = b_expl_temp->size[0];
  SEG->Branch->size[1] = b_expl_temp->size[1];
  SEG->Branch->size[2] = b_expl_temp->size[2];
  emxEnsureCapacity_boolean_T(sp, SEG->Branch, k, &bb_emlrtRTEI);
  vlen = b_expl_temp->size[0] * b_expl_temp->size[1] * b_expl_temp->size[2];
  for (k = 0; k < vlen; k++) {
    SEG->Branch->data[k] = b_expl_temp->data[k];
  }

  emxFree_boolean_T(&b_expl_temp);
  k = SEG->BranchGroup->size[0] * SEG->BranchGroup->size[1] * SEG->
    BranchGroup->size[2];
  SEG->BranchGroup->size[0] = c_expl_temp->size[0];
  SEG->BranchGroup->size[1] = c_expl_temp->size[1];
  SEG->BranchGroup->size[2] = c_expl_temp->size[2];
  emxEnsureCapacity_boolean_T(sp, SEG->BranchGroup, k, &bb_emlrtRTEI);
  vlen = c_expl_temp->size[0] * c_expl_temp->size[1] * c_expl_temp->size[2];
  for (k = 0; k < vlen; k++) {
    SEG->BranchGroup->data[k] = c_expl_temp->data[k];
  }

  emxFree_boolean_T(&c_expl_temp);
  k = SEG->End->size[0] * SEG->End->size[1] * SEG->End->size[2];
  SEG->End->size[0] = d_expl_temp->size[0];
  SEG->End->size[1] = d_expl_temp->size[1];
  SEG->End->size[2] = d_expl_temp->size[2];
  emxEnsureCapacity_boolean_T(sp, SEG->End, k, &bb_emlrtRTEI);
  vlen = d_expl_temp->size[0] * d_expl_temp->size[1] * d_expl_temp->size[2];
  for (k = 0; k < vlen; k++) {
    SEG->End->data[k] = d_expl_temp->data[k];
  }

  emxFree_boolean_T(&d_expl_temp);
  memcpy(&SEG->Pointdata[0], &SD->f4.t0_Pointdata[0], 32768U * sizeof(struct1_T));
  SEG->ResolutionXYZ[0] = e_expl_temp[0];
  SEG->ResolutionXYZ[1] = e_expl_temp[1];
  SEG->ResolutionXYZ[2] = e_expl_temp[2];
  k = SEG->BPmatrix->size[0] * SEG->BPmatrix->size[1];
  SEG->BPmatrix->size[0] = SEG_BPmatrix->size[0];
  SEG->BPmatrix->size[1] = 5;
  emxEnsureCapacity_real_T(sp, SEG->BPmatrix, k, &bb_emlrtRTEI);
  vlen = SEG_BPmatrix->size[0] * SEG_BPmatrix->size[1];
  for (k = 0; k < vlen; k++) {
    SEG->BPmatrix->data[k] = SEG_BPmatrix->data[k];
  }

  emxFree_real_T(&SEG_BPmatrix);
  SEG->loopNum = lnum;
  SEG->cutlen = cutlen;
  k = SEG->Original->size[0] * SEG->Original->size[1] * SEG->Original->size[2];
  SEG->Original->size[0] = skel->size[0];
  SEG->Original->size[1] = skel->size[1];
  SEG->Original->size[2] = skel->size[2];
  emxEnsureCapacity_boolean_T(sp, SEG->Original, k, &cb_emlrtRTEI);
  vlen = skel->size[0] * skel->size[1] * skel->size[2];
  for (k = 0; k < vlen; k++) {
    SEG->Original->data[k] = skel->data[k];
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (AutoSegment.c) */

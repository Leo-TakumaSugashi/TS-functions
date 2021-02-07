/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * AtSEG_shaving.c
 *
 * Code generation for function 'AtSEG_shaving'
 *
 */

/* Include files */
#include "AtSEG_shaving.h"
#include "AutoSegment.h"
#include "AutoSegment_data.h"
#include "AutoSegment_emxutil.h"
#include "TS_Skeleton3D_oldest.h"
#include "TS_bwlabeln3D26.h"
#include "combineVectorElements.h"
#include "mwmathutil.h"
#include "padarray.h"
#include "rt_nonfinite.h"
#include "tic.h"

/* Variable Definitions */
static emlrtRSInfo bg_emlrtRSI = { 8,  /* lineNo */
  "AtSEG_shaving",                     /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m"/* pathName */
};

static emlrtRSInfo cg_emlrtRSI = { 56, /* lineNo */
  "AtSEG_shaving",                     /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m"/* pathName */
};

static emlrtRSInfo dg_emlrtRSI = { 57, /* lineNo */
  "AtSEG_shaving",                     /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m"/* pathName */
};

static emlrtRSInfo eg_emlrtRSI = { 85, /* lineNo */
  "AtSEG_shaving",                     /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m"/* pathName */
};

static emlrtRSInfo fg_emlrtRSI = { 93, /* lineNo */
  "AtSEG_shaving",                     /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m"/* pathName */
};

static emlrtRSInfo gg_emlrtRSI = { 123,/* lineNo */
  "AtSEG_shaving",                     /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m"/* pathName */
};

static emlrtRSInfo hg_emlrtRSI = { 125,/* lineNo */
  "AtSEG_shaving",                     /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m"/* pathName */
};

static emlrtRSInfo ig_emlrtRSI = { 139,/* lineNo */
  "AtSEG_shaving",                     /* fcnName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m"/* pathName */
};

static emlrtBCInfo od_emlrtBCI = { 1,  /* iFirst */
  10000,                               /* iLast */
  41,                                  /* lineNo */
  29,                                  /* colNo */
  "End2Branch_copy",                   /* aName */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo pd_emlrtBCI = { 1,  /* iFirst */
  10000,                               /* iLast */
  49,                                  /* lineNo */
  32,                                  /* colNo */
  "End2Branch_copy",                   /* aName */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo qd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  55,                                  /* lineNo */
  18,                                  /* colNo */
  "BPmatrix",                          /* aName */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo p_emlrtECI = { 2,   /* nDims */
  57,                                  /* lineNo */
  33,                                  /* colNo */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m"/* pName */
};

static emlrtBCInfo rd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  63,                                  /* lineNo */
  26,                                  /* colNo */
  "End2Branch_NUM",                    /* aName */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo sd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  67,                                  /* lineNo */
  23,                                  /* colNo */
  "BPmatrix",                          /* aName */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo td_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  139,                                 /* lineNo */
  49,                                  /* colNo */
  "bwthindata",                        /* aName */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ud_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  139,                                 /* lineNo */
  57,                                  /* colNo */
  "bwthindata",                        /* aName */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo vd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  139,                                 /* lineNo */
  65,                                  /* colNo */
  "bwthindata",                        /* aName */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo wd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  106,                                 /* lineNo */
  21,                                  /* colNo */
  "bwthindata",                        /* aName */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo f_emlrtDCI = { 106, /* lineNo */
  21,                                  /* colNo */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo xd_emlrtBCI = { 1,  /* iFirst */
  10000,                               /* iLast */
  77,                                  /* lineNo */
  25,                                  /* colNo */
  "Ind",                               /* aName */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  3                                    /* checkKind */
};

static emlrtDCInfo g_emlrtDCI = { 86,  /* lineNo */
  9,                                   /* colNo */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo yd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  57,                                  /* lineNo */
  5,                                   /* colNo */
  "End2Branch_NUM",                    /* aName */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ae_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  128,                                 /* lineNo */
  25,                                  /* colNo */
  "bwthindata",                        /* aName */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo h_emlrtDCI = { 128, /* lineNo */
  25,                                  /* colNo */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo be_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  122,                                 /* lineNo */
  42,                                  /* colNo */
  "bwthindata",                        /* aName */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo i_emlrtDCI = { 122, /* lineNo */
  42,                                  /* colNo */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo ce_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  122,                                 /* lineNo */
  50,                                  /* colNo */
  "bwthindata",                        /* aName */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo j_emlrtDCI = { 122, /* lineNo */
  50,                                  /* colNo */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo de_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  122,                                 /* lineNo */
  58,                                  /* colNo */
  "bwthindata",                        /* aName */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo k_emlrtDCI = { 122, /* lineNo */
  58,                                  /* colNo */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m",/* pName */
  1                                    /* checkKind */
};

static emlrtRTEInfo mf_emlrtRTEI = { 51,/* lineNo */
  1,                                   /* colNo */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m"/* pName */
};

static emlrtRTEInfo nf_emlrtRTEI = { 56,/* lineNo */
  5,                                   /* colNo */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m"/* pName */
};

static emlrtRTEInfo of_emlrtRTEI = { 139,/* lineNo */
  36,                                  /* colNo */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m"/* pName */
};

static emlrtRTEInfo pf_emlrtRTEI = { 17,/* lineNo */
  1,                                   /* colNo */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m"/* pName */
};

static emlrtRTEInfo qf_emlrtRTEI = { 55,/* lineNo */
  5,                                   /* colNo */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m"/* pName */
};

static emlrtRTEInfo rf_emlrtRTEI = { 56,/* lineNo */
  9,                                   /* colNo */
  "AtSEG_shaving",                     /* fName */
  "/Users/leo/Documents/TSfun20200103/77_AutoSEG_MEX/AtSEG_shaving.m"/* pName */
};

/* Function Definitions */
void AtSEG_shaving(AutoSegmentStackData *SD, const emlrtStack *sp, const
                   emxArray_boolean_T *Segmentdata_Input, const struct_T
                   Segmentdata_Pointdata[32768], const emxArray_real_T
                   *Segmentdata_BPmatrix, real_T Cutlen, emxArray_boolean_T
                   *Output_skel)
{
  int32_T i;
  int32_T c;
  int32_T n;
  boolean_T guard1 = false;
  emxArray_int32_T *End2Branch_NUM;
  int32_T loop_ub;
  emxArray_real_T *p;
  emxArray_real_T *r;
  int32_T i1;
  real_T b_Segmentdata_BPmatrix[3];
  emxArray_boolean_T *bwthindata;
  real_T dv[2];
  real_T Ind[10000];
  int32_T iv[2];
  int32_T i2;
  real_T d;
  int32_T k;
  int32_T i3;
  int32_T i4;
  int32_T p_size[2];
  emxArray_boolean_T *b_bwthindata;
  real_T ex;
  real_T maxval_tmp;
  int32_T nz;
  boolean_T p_data[30000];
  int32_T nz_data[10000];
  int32_T nz_size[1];
  boolean_T b_maxval_tmp;
  boolean_T maxval;
  boolean_T exitg1;
  boolean_T b;
  boolean_T ROI[27];
  real_T unusedU1[27];
  real_T NUMpre;
  boolean_T x_data[10000];
  real_T NUMaft;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);

  /*  Output = TS_AutoSegment2nd(Segmentdata,Cutlen) */
  /*  Segmentdata: */
  /*  �@End point ����Branch or End Point�܂ł̃Z�O�����g�ƒ����̌v�Z���� */
  /*  Cutlen�F */
  /*  �@�J�b�g�������q�Q�̒��� */
  /*  %  */
  st.site = &bg_emlrtRSI;
  tic(&st);

  /*   Input: [120x120x250 logical] */
  /*             Branch: [120x120x250 logical] */
  /*                End: [120x120x250 logical] */
  /*          Pointdata: [1x437 struct] */
  /*      ResolutionXYZ: [1.7878 1.7878 1.7878] */
  /*  Input */
  /*  Reso = Segmentdata.ResolutionXYZ; %% Resolution [X Y Z] */
  /*  BPcentroid = Segmentdata.Branch; */
  /*  [bpy,bpx,bpz] = ind2sub(size(BP),find(BP(:))); */
  /*  EndP = Segmentdata.End; */
  /*  OriginalBW = bwthindata; */
  /*  bwthindata --->����čs���A�Ȃ��Ȃ�����I�� */
  /* �@��������_����2�{�ȏ�endpoint�܂ŐL�тĂ�����̂������ */
  /*  �@��Ԓ������̂�Cutlen�ȉ��ł��c�������B�B�B */
  /*  End2Branch = []; */
  for (i = 0; i < 30000; i++) {
    SD->u1.f0.End2Branch_copy[i] = rtNaN;
  }

  /*  Pdata(1).DeleteTF = []; */
  for (i = 0; i < 32768; i++) {
    SD->u1.f0.DeleteTF[i] = rtNaN;
  }

  c = 0;
  for (n = 0; n < 32768; n++) {
    guard1 = false;
    switch ((int32_T)Segmentdata_Pointdata[n].Type) {
     case 1:
      guard1 = true;
      break;

     case 5:
      guard1 = true;
      break;
    }

    if (guard1) {
      /* {'End to Branch','End to End'}             */
      SD->u1.f0.DeleteTF[n] = 1.0;
      i = c + 1;
      if ((i < 1) || (i > 10000)) {
        emlrtDynamicBoundsCheckR2012b(i, 1, 10000, &od_emlrtBCI, sp);
      }

      SD->u1.f0.End2Branch_copy[c] = Segmentdata_Pointdata[n].Branch[0];
      SD->u1.f0.End2Branch_copy[c + 10000] = Segmentdata_Pointdata[n].Branch[1];
      SD->u1.f0.End2Branch_copy[c + 20000] = Segmentdata_Pointdata[n].Branch[2];
      c++;

      /*              End2Branch = cat(1,End2Branch,Pdata(n).Branch); */
      /*              Pdata(n).DeleteTF = true; */
      /* case 'Branch to Branch' */
    }

    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  /*  Branch = cat(1,Pdata.Branch); */
  if (1 > c) {
    c = 0;
  } else {
    if (c > 10000) {
      emlrtDynamicBoundsCheckR2012b(c, 1, 10000, &pd_emlrtBCI, sp);
    }
  }

  emxInit_int32_T(sp, &End2Branch_NUM, 1, &mf_emlrtRTEI, true);
  i = End2Branch_NUM->size[0];
  End2Branch_NUM->size[0] = Segmentdata_BPmatrix->size[0];
  emxEnsureCapacity_int32_T(sp, End2Branch_NUM, i, &mf_emlrtRTEI);
  loop_ub = Segmentdata_BPmatrix->size[0];
  for (i = 0; i < loop_ub; i++) {
    End2Branch_NUM->data[i] = 0;
  }

  /*  Caliculate End 2 Branch point's count.... */
  i = Segmentdata_BPmatrix->size[0];
  emxInit_real_T(sp, &p, 2, &qf_emlrtRTEI, true);
  emxInit_real_T(sp, &r, 2, &rf_emlrtRTEI, true);
  for (n = 0; n < i; n++) {
    i1 = n + 1;
    if ((i1 < 1) || (i1 > Segmentdata_BPmatrix->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, Segmentdata_BPmatrix->size[0],
        &qd_emlrtBCI, sp);
    }

    /*  [ X Y Z ] */
    b_Segmentdata_BPmatrix[0] = Segmentdata_BPmatrix->data[n];
    b_Segmentdata_BPmatrix[1] = Segmentdata_BPmatrix->data[n +
      Segmentdata_BPmatrix->size[0]];
    b_Segmentdata_BPmatrix[2] = Segmentdata_BPmatrix->data[n +
      Segmentdata_BPmatrix->size[0] * 2];
    dv[0] = (real_T)c - 1.0;
    dv[1] = 0.0;
    st.site = &cg_emlrtRSI;
    b_padarray(&st, b_Segmentdata_BPmatrix, dv, r);
    i1 = p->size[0] * p->size[1];
    p->size[0] = r->size[0];
    p->size[1] = 3;
    emxEnsureCapacity_real_T(sp, p, i1, &nf_emlrtRTEI);
    loop_ub = r->size[0] * r->size[1];
    for (i1 = 0; i1 < loop_ub; i1++) {
      p->data[i1] = r->data[i1];
    }

    iv[0] = c;
    iv[1] = 3;
    emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])p->size, iv, &p_emlrtECI, sp);
    st.site = &dg_emlrtRSI;
    loop_ub = p->size[0];
    p_size[0] = p->size[0];
    p_size[1] = 3;
    for (i1 = 0; i1 < 3; i1++) {
      for (i2 = 0; i2 < loop_ub; i2++) {
        p_data[i2 + p_size[0] * i1] = (p->data[i2 + p->size[0] * i1] ==
          SD->u1.f0.End2Branch_copy[i2 + 10000 * i1]);
      }
    }

    combineVectorElements(p_data, p_size, nz_data, nz_size);
    st.site = &dg_emlrtRSI;
    loop_ub = nz_size[0];
    for (i1 = 0; i1 < loop_ub; i1++) {
      x_data[i1] = (nz_data[i1] == 3);
    }

    if (nz_size[0] == 0) {
      nz = 0;
    } else {
      nz = x_data[0];
      for (k = 2; k <= loop_ub; k++) {
        nz += x_data[k - 1];
      }
    }

    i1 = n + 1;
    if ((i1 < 1) || (i1 > End2Branch_NUM->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, End2Branch_NUM->size[0], &yd_emlrtBCI,
        &st);
    }

    End2Branch_NUM->data[i1 - 1] = nz;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(&r);
  emxFree_real_T(&p);

  /* clear n PadSiz End2Branch */
  i = Segmentdata_BPmatrix->size[0];
  for (n = 0; n < i; n++) {
    i1 = n + 1;
    if ((i1 < 1) || (i1 > End2Branch_NUM->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, End2Branch_NUM->size[0], &rd_emlrtBCI,
        sp);
    }

    if (End2Branch_NUM->data[n] >= 2) {
      i1 = n + 1;
      if ((i1 < 1) || (i1 > Segmentdata_BPmatrix->size[0])) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, Segmentdata_BPmatrix->size[0],
          &sd_emlrtBCI, sp);
      }

      for (i1 = 0; i1 < 10000; i1++) {
        SD->u1.f0.LEN[i1] = rtNaN;
        Ind[i1] = rtNaN;
      }

      c = 1;

      /*          LEN = []; */
      /*          Ind = []; */
      for (loop_ub = 0; loop_ub < 32768; loop_ub++) {
        switch ((int32_T)Segmentdata_Pointdata[loop_ub].Type) {
         case 1:
          /* 'End to Branch' */
          if (((Segmentdata_Pointdata[loop_ub].Branch[0] ==
                Segmentdata_BPmatrix->data[n]) + (Segmentdata_Pointdata[loop_ub]
                .Branch[1] == Segmentdata_BPmatrix->data[n +
                Segmentdata_BPmatrix->size[0]])) +
              (Segmentdata_Pointdata[loop_ub].Branch[2] ==
               Segmentdata_BPmatrix->data[n + Segmentdata_BPmatrix->size[0] * 2])
              == 3) {
            if (c > 10000) {
              emlrtDynamicBoundsCheckR2012b(10001, 1, 10000, &xd_emlrtBCI, sp);
            }

            Ind[c - 1] = (real_T)loop_ub + 1.0;
            SD->u1.f0.LEN[c - 1] = Segmentdata_Pointdata[loop_ub].Length;
            c++;

            /*                          Ind = cat(1,Ind,n2); */
            /*                          LEN = cat(1,LEN,Pdata(n2).Length);                         */
          }
          break;
        }

        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(sp);
        }
      }

      st.site = &eg_emlrtRSI;
      if (!muDoubleScalarIsNaN(SD->u1.f0.LEN[0])) {
        nz = 1;
      } else {
        nz = 0;
        k = 2;
        exitg1 = false;
        while ((!exitg1) && (k < 10001)) {
          if (!muDoubleScalarIsNaN(SD->u1.f0.LEN[k - 1])) {
            nz = k;
            exitg1 = true;
          } else {
            k++;
          }
        }
      }

      if (nz == 0) {
        nz = 1;
      } else {
        ex = SD->u1.f0.LEN[nz - 1];
        i1 = nz + 1;
        for (k = i1; k < 10001; k++) {
          d = SD->u1.f0.LEN[k - 1];
          if (ex < d) {
            ex = d;
            nz = k;
          }
        }
      }

      d = Ind[nz - 1];
      i1 = (int32_T)d;
      if (d != i1) {
        emlrtIntegerCheckR2012b(Ind[nz - 1], &g_emlrtDCI, sp);
      }

      SD->u1.f0.DeleteTF[i1 - 1] = rtNaN;

      /*          Pdata(Ind(MaxIndex)).DeleteTF = false; */
      /* clear bp NUM LEN Ind n2 MaxIndex */
    }

    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_int32_T(&End2Branch_NUM);
  emxInit_boolean_T(sp, &bwthindata, 3, &pf_emlrtRTEI, true);

  /*  Delete */
  st.site = &fg_emlrtRSI;
  padarray(&st, Segmentdata_Input, bwthindata);
  for (n = 0; n < 32768; n++) {
    switch ((int32_T)Segmentdata_Pointdata[n].Type) {
     case 5:
      /* 'End to End' */
      if (!(Cutlen < Segmentdata_Pointdata[n].Length)) {
        loop_ub = 0;
        while ((loop_ub < 2048) && (!muDoubleScalarIsNaN(Segmentdata_Pointdata[n]
                 .PointXYZ[loop_ub]))) {
          d = Segmentdata_Pointdata[n].PointXYZ[loop_ub + 2048] + 1.0;
          if (d != (int32_T)muDoubleScalarFloor(d)) {
            emlrtIntegerCheckR2012b(d, &f_emlrtDCI, sp);
          }

          i = (int32_T)d;
          if ((i < 1) || (i > bwthindata->size[0])) {
            emlrtDynamicBoundsCheckR2012b(i, 1, bwthindata->size[0],
              &wd_emlrtBCI, sp);
          }

          if (Segmentdata_Pointdata[n].PointXYZ[loop_ub] + 1.0 != (int32_T)
              muDoubleScalarFloor(Segmentdata_Pointdata[n].PointXYZ[loop_ub] +
                                  1.0)) {
            emlrtIntegerCheckR2012b(Segmentdata_Pointdata[n].PointXYZ[loop_ub] +
              1.0, &f_emlrtDCI, sp);
          }

          i1 = (int32_T)(Segmentdata_Pointdata[n].PointXYZ[loop_ub] + 1.0);
          if ((i1 < 1) || (i1 > bwthindata->size[1])) {
            emlrtDynamicBoundsCheckR2012b(i1, 1, bwthindata->size[1],
              &wd_emlrtBCI, sp);
          }

          d = Segmentdata_Pointdata[n].PointXYZ[loop_ub + 4096] + 1.0;
          if (d != (int32_T)muDoubleScalarFloor(d)) {
            emlrtIntegerCheckR2012b(d, &f_emlrtDCI, sp);
          }

          i2 = (int32_T)d;
          if ((i2 < 1) || (i2 > bwthindata->size[2])) {
            emlrtDynamicBoundsCheckR2012b(i2, 1, bwthindata->size[2],
              &wd_emlrtBCI, sp);
          }

          bwthindata->data[((i + bwthindata->size[0] * (i1 - 1)) +
                            bwthindata->size[0] * bwthindata->size[1] * (i2 - 1))
            - 1] = false;
          loop_ub++;
          if (*emlrtBreakCheckR2012bFlagVar != 0) {
            emlrtBreakCheckR2012b(sp);
          }
        }
      }
      break;

     case 1:
      /* 'End to Branch' */
      if ((!(Cutlen < Segmentdata_Pointdata[n].Length)) && (SD->u1.f0.DeleteTF[n]
           == 1.0)) {
        /*  Pdata(n).DeleteTF */
        loop_ub = 0;
        while ((loop_ub < 2048) && (!muDoubleScalarIsNaN(Segmentdata_Pointdata[n]
                 .PointXYZ[loop_ub]))) {
          d = Segmentdata_Pointdata[n].PointXYZ[loop_ub + 2048] + 1.0;
          i = (int32_T)(d + -1.0);
          i1 = (int32_T)d;
          i2 = (int32_T)(d + 1.0);
          for (k = 0; k < 3; k++) {
            ex = (Segmentdata_Pointdata[n].PointXYZ[loop_ub + 4096] + 1.0) +
              ((real_T)k + -1.0);
            maxval_tmp = (int32_T)muDoubleScalarFloor(ex);
            i3 = (int32_T)ex;
            for (i4 = 0; i4 < 3; i4++) {
              if (d + -1.0 != (int32_T)muDoubleScalarFloor(d + -1.0)) {
                emlrtIntegerCheckR2012b(d + -1.0, &i_emlrtDCI, sp);
              }

              if ((i < 1) || (i > bwthindata->size[0])) {
                emlrtDynamicBoundsCheckR2012b(i, 1, bwthindata->size[0],
                  &be_emlrtBCI, sp);
              }

              NUMpre = (Segmentdata_Pointdata[n].PointXYZ[loop_ub] + 1.0) +
                ((real_T)i4 + -1.0);
              NUMaft = (int32_T)muDoubleScalarFloor(NUMpre);
              if (NUMpre != NUMaft) {
                emlrtIntegerCheckR2012b(NUMpre, &j_emlrtDCI, sp);
              }

              nz = (int32_T)NUMpre;
              if ((nz < 1) || (nz > bwthindata->size[1])) {
                emlrtDynamicBoundsCheckR2012b(nz, 1, bwthindata->size[1],
                  &ce_emlrtBCI, sp);
              }

              if (ex != maxval_tmp) {
                emlrtIntegerCheckR2012b(ex, &k_emlrtDCI, sp);
              }

              if ((i3 < 1) || (i3 > bwthindata->size[2])) {
                emlrtDynamicBoundsCheckR2012b(i3, 1, bwthindata->size[2],
                  &de_emlrtBCI, sp);
              }

              c = 3 * i4 + 9 * k;
              ROI[c] = bwthindata->data[((i + bwthindata->size[0] * (nz - 1)) +
                bwthindata->size[0] * bwthindata->size[1] * (i3 - 1)) - 1];
              if (d != (int32_T)muDoubleScalarFloor(d)) {
                emlrtIntegerCheckR2012b(d, &i_emlrtDCI, sp);
              }

              if ((i1 < 1) || (i1 > bwthindata->size[0])) {
                emlrtDynamicBoundsCheckR2012b(i1, 1, bwthindata->size[0],
                  &be_emlrtBCI, sp);
              }

              if (NUMpre != NUMaft) {
                emlrtIntegerCheckR2012b(NUMpre, &j_emlrtDCI, sp);
              }

              if ((nz < 1) || (nz > bwthindata->size[1])) {
                emlrtDynamicBoundsCheckR2012b(nz, 1, bwthindata->size[1],
                  &ce_emlrtBCI, sp);
              }

              if (ex != maxval_tmp) {
                emlrtIntegerCheckR2012b(ex, &k_emlrtDCI, sp);
              }

              if ((i3 < 1) || (i3 > bwthindata->size[2])) {
                emlrtDynamicBoundsCheckR2012b(i3, 1, bwthindata->size[2],
                  &de_emlrtBCI, sp);
              }

              ROI[c + 1] = bwthindata->data[((i1 + bwthindata->size[0] * (nz - 1))
                + bwthindata->size[0] * bwthindata->size[1] * (i3 - 1)) - 1];
              if (d + 1.0 != (int32_T)muDoubleScalarFloor(d + 1.0)) {
                emlrtIntegerCheckR2012b(d + 1.0, &i_emlrtDCI, sp);
              }

              if ((i2 < 1) || (i2 > bwthindata->size[0])) {
                emlrtDynamicBoundsCheckR2012b(i2, 1, bwthindata->size[0],
                  &be_emlrtBCI, sp);
              }

              if (NUMpre != NUMaft) {
                emlrtIntegerCheckR2012b(NUMpre, &j_emlrtDCI, sp);
              }

              if ((nz < 1) || (nz > bwthindata->size[1])) {
                emlrtDynamicBoundsCheckR2012b(nz, 1, bwthindata->size[1],
                  &ce_emlrtBCI, sp);
              }

              if (ex != maxval_tmp) {
                emlrtIntegerCheckR2012b(ex, &k_emlrtDCI, sp);
              }

              if ((i3 < 1) || (i3 > bwthindata->size[2])) {
                emlrtDynamicBoundsCheckR2012b(i3, 1, bwthindata->size[2],
                  &de_emlrtBCI, sp);
              }

              ROI[c + 2] = bwthindata->data[((i2 + bwthindata->size[0] * (nz - 1))
                + bwthindata->size[0] * bwthindata->size[1] * (i3 - 1)) - 1];
            }
          }

          st.site = &gg_emlrtRSI;
          ex = Segmentdata_Pointdata[n].PointXYZ[loop_ub + 2048] + 1.0;
          maxval_tmp = Segmentdata_Pointdata[n].PointXYZ[loop_ub + 4096] + 1.0;
          b_maxval_tmp = bwthindata->data[(((int32_T)(ex + -1.0) +
            bwthindata->size[0] * ((int32_T)((Segmentdata_Pointdata[n]
            .PointXYZ[loop_ub] + 1.0) + -1.0) - 1)) + bwthindata->size[0] *
            bwthindata->size[1] * ((int32_T)(maxval_tmp + -1.0) - 1)) - 1];
          maxval = b_maxval_tmp;
          for (k = 0; k < 26; k++) {
            b = bwthindata->data[(((int32_T)(ex + ((real_T)((k + 1) % 3) + -1.0))
              + bwthindata->size[0] * ((int32_T)((Segmentdata_Pointdata[n].
              PointXYZ[loop_ub] + 1.0) + ((real_T)((k + 1) / 3 % 3) + -1.0)) - 1))
                                  + bwthindata->size[0] * bwthindata->size[1] *
                                  ((int32_T)(maxval_tmp + ((real_T)((k + 1) / 9)
              + -1.0)) - 1)) - 1];
            maxval = (((int32_T)maxval < (int32_T)b) || maxval);
          }

          if (!maxval) {
            NUMpre = 0.0;
          } else {
            b_st.site = &id_emlrtRSI;
            TS_bwlabeln_linux_c(&b_st, ROI, unusedU1, &NUMpre);
          }

          ROI[13] = false;
          st.site = &hg_emlrtRSI;
          for (k = 0; k < 26; k++) {
            b_maxval_tmp = (((int32_T)b_maxval_tmp < (int32_T)ROI[k + 1]) ||
                            b_maxval_tmp);
          }

          if (!b_maxval_tmp) {
            NUMaft = 0.0;
          } else {
            b_st.site = &id_emlrtRSI;
            TS_bwlabeln_linux_c(&b_st, ROI, unusedU1, &NUMaft);
          }

          /*                     %% Check Deletable or Not */
          if (NUMpre == NUMaft) {
            if (ex != (int32_T)muDoubleScalarFloor(ex)) {
              emlrtIntegerCheckR2012b(ex, &h_emlrtDCI, sp);
            }

            i = (int32_T)ex;
            if ((i < 1) || (i > bwthindata->size[0])) {
              emlrtDynamicBoundsCheckR2012b(i, 1, bwthindata->size[0],
                &ae_emlrtBCI, sp);
            }

            if (Segmentdata_Pointdata[n].PointXYZ[loop_ub] + 1.0 != (int32_T)
                muDoubleScalarFloor(Segmentdata_Pointdata[n].PointXYZ[loop_ub] +
                 1.0)) {
              emlrtIntegerCheckR2012b(Segmentdata_Pointdata[n].PointXYZ[loop_ub]
                + 1.0, &h_emlrtDCI, sp);
            }

            i1 = (int32_T)(Segmentdata_Pointdata[n].PointXYZ[loop_ub] + 1.0);
            if ((i1 < 1) || (i1 > bwthindata->size[1])) {
              emlrtDynamicBoundsCheckR2012b(i1, 1, bwthindata->size[1],
                &ae_emlrtBCI, sp);
            }

            if (maxval_tmp != (int32_T)muDoubleScalarFloor(maxval_tmp)) {
              emlrtIntegerCheckR2012b(maxval_tmp, &h_emlrtDCI, sp);
            }

            i2 = (int32_T)maxval_tmp;
            if ((i2 < 1) || (i2 > bwthindata->size[2])) {
              emlrtDynamicBoundsCheckR2012b(i2, 1, bwthindata->size[2],
                &ae_emlrtBCI, sp);
            }

            bwthindata->data[((i + bwthindata->size[0] * (i1 - 1)) +
                              bwthindata->size[0] * bwthindata->size[1] * (i2 -
              1)) - 1] = false;
          }

          loop_ub++;
          if (*emlrtBreakCheckR2012bFlagVar != 0) {
            emlrtBreakCheckR2012b(sp);
          }
        }
      }
      break;

     case 0:
      /* 'Branch to Branch' */
      break;
    }

    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  /*  Re Skeletoning by TS_bwmoroph3d */
  if (2 > bwthindata->size[0] - 1) {
    i = 0;
    i1 = 0;
  } else {
    i = 1;
    i1 = bwthindata->size[0] - 1;
    if ((i1 < 1) || (i1 > bwthindata->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, bwthindata->size[0], &td_emlrtBCI, sp);
    }
  }

  if (2 > bwthindata->size[1] - 1) {
    i2 = 0;
    k = 0;
  } else {
    i2 = 1;
    k = bwthindata->size[1] - 1;
    if ((k < 1) || (k > bwthindata->size[1])) {
      emlrtDynamicBoundsCheckR2012b(k, 1, bwthindata->size[1], &ud_emlrtBCI, sp);
    }
  }

  if (2 > bwthindata->size[2] - 1) {
    i3 = 0;
    i4 = 0;
  } else {
    i3 = 1;
    i4 = bwthindata->size[2] - 1;
    if ((i4 < 1) || (i4 > bwthindata->size[2])) {
      emlrtDynamicBoundsCheckR2012b(i4, 1, bwthindata->size[2], &vd_emlrtBCI, sp);
    }
  }

  emxInit_boolean_T(sp, &b_bwthindata, 3, &of_emlrtRTEI, true);
  loop_ub = i1 - i;
  i1 = b_bwthindata->size[0] * b_bwthindata->size[1] * b_bwthindata->size[2];
  b_bwthindata->size[0] = loop_ub;
  nz = k - i2;
  b_bwthindata->size[1] = nz;
  c = i4 - i3;
  b_bwthindata->size[2] = c;
  emxEnsureCapacity_boolean_T(sp, b_bwthindata, i1, &of_emlrtRTEI);
  for (i1 = 0; i1 < c; i1++) {
    for (k = 0; k < nz; k++) {
      for (i4 = 0; i4 < loop_ub; i4++) {
        b_bwthindata->data[(i4 + b_bwthindata->size[0] * k) + b_bwthindata->
          size[0] * b_bwthindata->size[1] * i1] = bwthindata->data[((i + i4) +
          bwthindata->size[0] * (i2 + k)) + bwthindata->size[0] *
          bwthindata->size[1] * (i3 + i1)];
      }
    }
  }

  i = bwthindata->size[0] * bwthindata->size[1] * bwthindata->size[2];
  bwthindata->size[0] = b_bwthindata->size[0];
  bwthindata->size[1] = b_bwthindata->size[1];
  bwthindata->size[2] = b_bwthindata->size[2];
  emxEnsureCapacity_boolean_T(sp, bwthindata, i, &of_emlrtRTEI);
  loop_ub = b_bwthindata->size[2];
  for (i = 0; i < loop_ub; i++) {
    nz = b_bwthindata->size[1];
    for (i1 = 0; i1 < nz; i1++) {
      c = b_bwthindata->size[0];
      for (i2 = 0; i2 < c; i2++) {
        bwthindata->data[(i2 + bwthindata->size[0] * i1) + bwthindata->size[0] *
          bwthindata->size[1] * i] = b_bwthindata->data[(i2 + b_bwthindata->
          size[0] * i1) + b_bwthindata->size[0] * b_bwthindata->size[1] * i];
      }
    }
  }

  emxFree_boolean_T(&b_bwthindata);
  st.site = &ig_emlrtRSI;
  TS_Skeleton3D_oldest(&st, bwthindata, Output_skel);
  emxFree_boolean_T(&bwthindata);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (AtSEG_shaving.c) */

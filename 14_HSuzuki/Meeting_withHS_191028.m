SEG = TS_AutoSegment_v2019Charly(skel,NewReso,[],0);

Analysis Branch-point and End-point 
Analysis Branch-point and End-point 
   ... 1st End point to a Branchpoint or a Endpoint
End Point Num.:293, Segment(bp-end) NUM.:286
   ... 2nd Branch - Branch
SEG

SEG = 

  struct with fields:

           Output: [73×73×165 logical]
            AddBP: [73×73×165 logical]
           Branch: [73×73×165 logical]
      BranchGroup: [73×73×165 logical]
              End: [73×73×165 logical]
        Pointdata: [1×630 struct]
    ResolutionXYZ: [2.4695 2.4695 2.5000]
         BPmatrix: [296×5 double]
          loopNum: 1
           cutlen: 0
         Original: [73×73×165 logical]
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
SEG.Pointdata

ans = 

  1×630 struct array with fields:

    PointXYZ: [13×3 double]
        Type: 'End to Branch'
      Length: 37.4940
      Branch: [6 7 8]
    
========================================================================
S = Segment_Functions

S = 
  Segment_Functions with properties:
                     Segment: []
                 StartEndXYZ: [2×3×0 double]
                  MesureLine: @TS_Measure
        SupportManualMeasure: @TS_Measure_withCenter
                 Chase_Limit: 10
     Tracking_Distance_Limit: 10
         RFitting_WindowSize: 15
        RFitting_MaxDistance: 10
                   StraghtAS: 30
                 BsplineFunc: @HS_B_Spline_ver19Alpha
                  BsplineDim: 5
    BsplineFistDownSizeRatio: 0.3333
                      UpDate: '2019/10/26 Sugashi, Suzuki'
                    UserData: []
========================================================================
s_SEG = S.set_Segment(SEG)

s_SEG = 
  struct with fields:
            Output: [4397×1 double]
             AddBP: [0×1 double]
            Branch: [296×1 double]
       BranchGroup: [598×1 double]
               End: [293×1 double]
         Pointdata: [1×630 struct]
     ResolutionXYZ: [2.4695 2.4695 2.5000]
          BPmatrix: [296×5 double]
           loopNum: 1
            cutlen: 0
          Original: [4397×1 double]
    BranchPointXYZ: [296×3 double]
        Resampling: 0
              Size: [73 73 165]
         SegEditor: '/mnt/NAS/SSD/TSfun20191027/20_Development/Segment_Functions'
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _               
s_SEG.Pointdata(1)

ans = 
  struct with fields:
            PointXYZ: [13×3 double]
                Type: 'End to Branch'
              Length: 37.4940
              Branch: [6 7 8]
                  ID: 1
               Class: 'others'
            Diameter: [13×1 double]
              Signal: [13×1 double]
               Noise: [13×1 double]
               Theta: [13×1 double]
              NewXYZ: [13×1 double]
                MEMO: ' '
    OriginalPointXYZ: [13×3 double]       
    
    
    
========================================================================
========================================================================
ASEG = S.AddSpatialPhysicalQuantityj(SEG)
Segment_FunctionsInput check ....    Segment_Functions
Number of Segment (ID>0) : 630
... using parfor...
NumWorkers : 1
Elapsed time is 2.942544 seconds.
Calculate Minimum Vecter Parallelism 
Done...
Elapsed time is 3.575136 seconds.



ASEG = 
  struct with fields:
                   Output: [4397×1 double]
                    AddBP: [0×1 double]
                   Branch: [296×1 double]
              BranchGroup: [598×1 double]
                      End: [293×1 double]
                Pointdata: [1×630 struct]
            ResolutionXYZ: [2.4695 2.4695 2.5000]
                 BPmatrix: [296×5 double]
                  loopNum: 1
                   cutlen: 0
                 Original: [4397×1 double]
           BranchPointXYZ: [296×3 double]
               Resampling: 0
                     Size: [73 73 165]
                SegEditor: '/mnt/NAS/SSD/TSfun20191027/20_Development/Segment_Functions'
    SpatialPhysicEvalDate: '28-Oct-2019'
      RFitting_WindowSize: 15
     RFitting_MaxDistance: 10
                StraghtAS: 30
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _               
ASEG.Pointdata(1)

ans = 
  struct with fields:
                    PointXYZ: [13×3 double]
                        Type: 'End to Branch'
                      Length: 37.4940
                      Branch: [6 7 8]
                          ID: 1
                       Class: 'others'
                    Diameter: [13×1 double]
                      Signal: [13×1 double]
                       Noise: [13×1 double]
                       Theta: [13×1 double]
                      NewXYZ: [13×1 double]
                        MEMO: ' '
            OriginalPointXYZ: [13×3 double]
                   Enable_TF: 1
                     is_edge: 1
            DirectedDistance: 12.8851
              DirectedVector: [-3 6 7]
          Length_from_Branch: [13×1 double]
             SphereFitRadius: [13×1 double]
         SphereFitUnitVector: [13×3 double]
             SphereFitScalar: [13×1 double]
                 CurveNumber: 1
                   Curvature: 1.9099
               CurveMinimumR: 11.4764
               StraghtNumber: 0
       StraghtSumationLength: 0
        StraghtMaximumLength: 0
        StraghtMinimumLength: 0
            SignalMaximumGap: NaN
             NoiseMaximumGap: NaN
               SNRMaximumGap: NaN
          DiameterMaximumGap: NaN
           SignalDiffMeanABS: NaN
            NoiseDiffMeanABS: NaN
              SNRDiffMeanABS: NaN
         DiameterDiffMeanABS: NaN
                SignalDiffSD: NaN
                 NoiseDiffSD: NaN
                   SNRDiffSD: NaN
              DiameterDiffSD: NaN
       DistanceNearestEdgeXY: 0
        DistanceNearestEdgeZ: 0
    MinimumVecterParallelism: 0.0637






















                    
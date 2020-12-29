function [output,HIGEID] = TS_Shaving_Model_SEGID_v2019Alpha(SEG)

S = Segment_Functions;
load('K27D00_HIGE_DataSet.mat','HIGE_Model')
AddSpecialSEG = S.AddSpatialPhysicalQuantityj(SEG);

Length= cat(1,AddSpecialSEG.Pointdata.Length);
ID= abs(cat(1,AddSpecialSEG.Pointdata.ID));
% Enable_TF= double(cat(1,AddSpecialSEG.Pointdata.Enable_TF));
is_edge= cat(1,AddSpecialSEG.Pointdata.is_edge);
DirectedDistance= cat(1,AddSpecialSEG.Pointdata.DirectedDistance);
CurveNumber= cat(1,AddSpecialSEG.Pointdata.CurveNumber);
Curvature= cat(1,AddSpecialSEG.Pointdata.Curvature);
Curvature(isinf(Curvature)) = nan;
CurveMinimumR= cat(1,AddSpecialSEG.Pointdata.CurveMinimumR);
StraghtNumber= cat(1,AddSpecialSEG.Pointdata.StraghtNumber);
StraghtSumationLength= cat(1,AddSpecialSEG.Pointdata.StraghtSumationLength);
StraghtMaximumLength= cat(1,AddSpecialSEG.Pointdata.StraghtMaximumLength);
StraghtMinimumLength= cat(1,AddSpecialSEG.Pointdata.StraghtMinimumLength);
SignalMaximumGap= cat(1,AddSpecialSEG.Pointdata.SignalMaximumGap);
NoiseMaximumGap= cat(1,AddSpecialSEG.Pointdata.NoiseMaximumGap);
SNRMaximumGap= cat(1,AddSpecialSEG.Pointdata.SNRMaximumGap);
DiameterMaximumGap= cat(1,AddSpecialSEG.Pointdata.DiameterMaximumGap);
SignalDiffMeanABS= cat(1,AddSpecialSEG.Pointdata.SignalDiffMeanABS);
NoiseDiffMeanABS= cat(1,AddSpecialSEG.Pointdata.NoiseDiffMeanABS);
SNRDiffMeanABS= cat(1,AddSpecialSEG.Pointdata.SNRDiffMeanABS);
DiameterDiffMeanABS= cat(1,AddSpecialSEG.Pointdata.DiameterDiffMeanABS);
SignalDiffSD= cat(1,AddSpecialSEG.Pointdata.SignalDiffSD);
NoiseDiffSD= cat(1,AddSpecialSEG.Pointdata.NoiseDiffSD);
SNRDiffSD= cat(1,AddSpecialSEG.Pointdata.SNRDiffSD);
DiameterDiffSD= cat(1,AddSpecialSEG.Pointdata.DiameterDiffSD);
DistanceNearestEdgeXY= cat(1,AddSpecialSEG.Pointdata.DistanceNearestEdgeXY);
DistanceNearestEdgeZ= cat(1,AddSpecialSEG.Pointdata.DistanceNearestEdgeZ);
MinimumVecterParallelism= cat(1,AddSpecialSEG.Pointdata.MinimumVecterParallelism);
    


DataSetTable = table(...
    Length,DirectedDistance,...
    CurveNumber,Curvature,CurveMinimumR,StraghtNumber,StraghtSumationLength,...
    StraghtMaximumLength,StraghtMinimumLength,...
    SignalMaximumGap,NoiseMaximumGap,SNRMaximumGap,DiameterMaximumGap,...
    SignalDiffMeanABS,NoiseDiffMeanABS,SNRDiffMeanABS,DiameterDiffMeanABS,...
    SignalDiffSD,NoiseDiffSD,SNRDiffSD,DiameterDiffSD,...
    DistanceNearestEdgeXY,DistanceNearestEdgeZ,MinimumVecterParallelism);
cutIndex = or(ID<0,is_edge~=1);
DataSetTable(cutIndex,:) = [];
ID(cutIndex) = [];
TFmodel = HIGE_Model.predictFcn(DataSetTable);
S.Segment = SEG;
pdata = S.Segment.Pointdata;
catID = cat(1,pdata.ID);
HIGEID = catID(TFmodel);
output = ID(~TFmodel);
    

    
% % % % % %     
% % % % % % AddSpecialSEG = ADD_Special_K27D00_HIGE;
% % % % % % 
% % % % % % 
% % % % % % %                         Type= 'Branch to Branch'
% % % % % %                       Length= cat(1,AddSpecialSEG.Pointdata.Length);
% % % % % % %                       Branch= [12 185 3]
% % % % % %                           ID= cat(1,AddSpecialSEG.Pointdata.ID);
% % % % % % %                        Class= 'others'
% % % % % % %                     Diameter= [20Ã?1 single]
% % % % % % %                         MEMO= ' '
% % % % % % %                       Signal= [20Ã?1 single]
% % % % % % %                        Noise= [20Ã?1 single]
% % % % % % %                        Theta= [20Ã?1 single]
% % % % % % %                       NewXYZ= [20Ã?3 double]
% % % % % %                    Enable_TF= double(cat(1,AddSpecialSEG.Pointdata.Enable_TF));
% % % % % %                      is_edge= cat(1,AddSpecialSEG.Pointdata.is_edge);
% % % % % %             DirectedDistance= cat(1,AddSpecialSEG.Pointdata.DirectedDistance);
% % % % % % %               DirectedVector= [10 -19 2] 
% % % % % % %           Length_from_Branch= [20Ã?1 double]
% % % % % % %              SphereFitRadius= [20Ã?1 double]
% % % % % % %          SphereFitUnitVector= [20Ã?3 double]
% % % % % % %              SphereFitScalar= [20Ã?1 double]
% % % % % %                  CurveNumber= cat(1,AddSpecialSEG.Pointdata.CurveNumber);
% % % % % %                    Curvature= cat(1,AddSpecialSEG.Pointdata.Curvature);
% % % % % %                    Curvature(isinf(Curvature)) = nan;
% % % % % %                CurveMinimumR= cat(1,AddSpecialSEG.Pointdata.CurveMinimumR);
% % % % % %                StraghtNumber= cat(1,AddSpecialSEG.Pointdata.StraghtNumber);
% % % % % %        StraghtSumationLength= cat(1,AddSpecialSEG.Pointdata.StraghtSumationLength);
% % % % % %         StraghtMaximumLength= cat(1,AddSpecialSEG.Pointdata.StraghtMaximumLength);
% % % % % %         StraghtMinimumLength= cat(1,AddSpecialSEG.Pointdata.StraghtMinimumLength);
% % % % % %             SignalMaximumGap= cat(1,AddSpecialSEG.Pointdata.SignalMaximumGap);
% % % % % %              NoiseMaximumGap= cat(1,AddSpecialSEG.Pointdata.NoiseMaximumGap);
% % % % % %                SNRMaximumGap= cat(1,AddSpecialSEG.Pointdata.SNRMaximumGap);
% % % % % %           DiameterMaximumGap= cat(1,AddSpecialSEG.Pointdata.DiameterMaximumGap);
% % % % % %            SignalDiffMeanABS= cat(1,AddSpecialSEG.Pointdata.SignalDiffMeanABS);
% % % % % %             NoiseDiffMeanABS= cat(1,AddSpecialSEG.Pointdata.NoiseDiffMeanABS);
% % % % % %               SNRDiffMeanABS= cat(1,AddSpecialSEG.Pointdata.SNRDiffMeanABS);
% % % % % %          DiameterDiffMeanABS= cat(1,AddSpecialSEG.Pointdata.DiameterDiffMeanABS);
% % % % % %                 SignalDiffSD= cat(1,AddSpecialSEG.Pointdata.SignalDiffSD);
% % % % % %                  NoiseDiffSD= cat(1,AddSpecialSEG.Pointdata.NoiseDiffSD);
% % % % % %                    SNRDiffSD= cat(1,AddSpecialSEG.Pointdata.SNRDiffSD);
% % % % % %               DiameterDiffSD= cat(1,AddSpecialSEG.Pointdata.DiameterDiffSD);
% % % % % %        DistanceNearestEdgeXY= cat(1,AddSpecialSEG.Pointdata.DistanceNearestEdgeXY);
% % % % % %         DistanceNearestEdgeZ= cat(1,AddSpecialSEG.Pointdata.DistanceNearestEdgeZ);
% % % % % %     MinimumVecterParallelism= cat(1,AddSpecialSEG.Pointdata.MinimumVecterParallelism);
% % % % % %     
% % % % % %     HumanChecked = cat(1,EditSEG4_DataSet.Pointdata.ID)>0;
% % % % % %     
% % % % % %     DataSet_HIGE = table(...
% % % % % %         ID,Length,Enable_TF,is_edge,DirectedDistance,...
% % % % % %         CurveNumber,Curvature,CurveMinimumR,StraghtNumber,StraghtSumationLength,...
% % % % % %         StraghtMaximumLength,StraghtMinimumLength,...
% % % % % %         SignalMaximumGap,NoiseMaximumGap,SNRMaximumGap,DiameterMaximumGap,...
% % % % % %         SignalDiffMeanABS,NoiseDiffMeanABS,SNRDiffMeanABS,DiameterDiffMeanABS,...
% % % % % %         SignalDiffSD,NoiseDiffSD,SNRDiffSD,DiameterDiffSD,...
% % % % % %         DistanceNearestEdgeXY,DistanceNearestEdgeZ,MinimumVecterParallelism,...
% % % % % %         HumanChecked);
% % % % % %     DataSet_HIGE_B2E = DataSet_HIGE;
% % % % % %     DataSet_HIGE_B2E(is_edge~=1,:) = [];
% % % % % %     
% % % % % %     save('/mnt/NAS/SSD/TSfun20190906/20_Development/K27D00_HIGE_DataSet.mat','DataSet_HIGE')
% % % % % %     save('/mnt/NAS/SSD/TSfun20190906/20_Development/K27D00_HIGE_DataSet.mat','trained_HIGE_Model','-append')
% % % % % %         
% % % % % %     save('/mnt/NAS/SSD/TSfun20190906/20_Development/K27D00_HIGE_DataSet.mat','DataSet_HIGE_B2E','HIGE_Model','-append')
        
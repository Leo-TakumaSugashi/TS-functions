function output = TS_SEG2TissueFig(SEG,RotMovStretchData,Sind,SindReso)
% Sind is 1st(controll) data position of Surface
% SindReso is also, too.
% 
% prototype,,,,just, need, speed output...
try
%% Initialize
Depth_Step = [-Inf, 50:100:850];
Depth_Label = [{'Surface'},num2cell(100:100:800)];
Tissue_Step = [0:10:30, Inf];
Tissue_Label = [num2cell(0:10:20),{'30 um'}];
Ves = zeros(1,length(Depth_Step)-1);
TissueArea = zeros(length(Tissue_Step)-1,length(Depth_Step)-1);
Color = [ones(1,3)*.2; flip(gray(4),1)];

XYArea_cut = 20; % um

%% set up 
S = Segment_Functions;
S.Segment = SEG;
ModSEG = S.ModifySEG();
DiamImage = TS_SEG2DiamImage_v2019b(ModSEG);
Reco = TS_Diam2ReconstBW_parfor(DiamImage,mean(ModSEG.ResolutionXYZ));
PReco = padarray(Reco,ones(1,3),true);
DistImage = bwdist(PReco);
DistImage = DistImage(2:end-1,2:end-1,2:end-1);

%% offset Zdata
FOV = (ModSEG.Size-1) .*ModSEG.ResolutionXYZ;
zdata = 1:size(DistImage,3); %% zdata and AdjZdata are index
xdata = 1:size(DistImage,2);
xind = and(XYArea_cut< xdata,xdata < FOV(1)-XYArea_cut); 
ydata = 1:size(DistImage,1);
yind = and(XYArea_cut< ydata,ydata < FOV(2)-XYArea_cut);
if ~isempty(RotMovStretchData)    
    Center = FOV/2;
    xyz = cat(2,repmat(Center(1:2),[size(DistImage,3),1]),zdata');
    XYZ = S.xyz2RotMoveStretch(xyz,RotMovStretchData,Center);
    AdjZdata = XYZ(:,3);
else
    AdjZdata = zdata';
end

Depth = (-1) * (AdjZdata - ((Sind-1).*SindReso(3)) );
for k = 1:length(Depth_Step)-1
    zind = and(Depth_Step(k)>Depth,Depth<=Depth_Step(k+1));
%     adjzind = AdjZdata(zind);
%     ind = max(round(min(adjzind)),1):min(round(max(adjzind)),size(DistImage,3));
    if sum(zind)==0
        continue
    end
    Varea = DistImage(yind,xind,zind);
    N = numel(Varea);
    Ves(1,k) = sum(Varea(:)==0)/N;
    for n = 1:length(Tissue_Step)-1
        BW = and(Tissue_Step(n)<Varea,Varea<=Tissue_Step(n+1));
        TissueArea(n,k) = sum(BW(:))/N;
    end
end
Matrix = cat(1,Ves,TissueArea);
figure,
Handles = bar(Matrix'*100,'stacked');
axh = gca;
axh.XTickLabel = Depth_Label;
axh.XTickLabelRotation = 60;
for n = 1:5
   Handles(n).FaceColor = Color(n,:);
end
lh = legend({'Vasculature','  0 \mum ~','10 \mum ~','20 \mum ~','30 \mum ~'});


%%
% [Diam,EstVolume] = Get_EstimateVolume(~,SEG,RotMovStretchData,Drange)


cutID = cat(1,SEG.Pointdata.ID);
Pdata = SEG.Pointdata(cutID>0);
Diam = nan(length(Pdata),1);
EstVolume = Diam;
SegmentDepth = Diam;
for n = 1:length(Pdata)
    Diameter = Pdata(n).Diameter;
    R = nanmean(Diameter)/2;
    Diam(n) = R*2;
    EstVolume(n) = Pdata(n).Length * pi*(R^2);
    if ~isempty(RotMovStretchData)    
%         Center = FOV/2;
        xyz = mean(Pdata(n).PointXYZ,1);
        XYZ = S.xyz2RotMoveStretch(xyz,RotMovStretchData,Center);
    else
        XYZ = mean(Pdata(n).PointXYZ,1);
    end    
    SegmentDepth(n) = (-1) * (XYZ(1,3) - ((Sind-1).*SindReso(3)) );
end

DiamStep = [0 4:2:12 Inf];
DiamStepinput = 4:2:14;
X = nan(1,length(DiamStep)-1);
DepthRange = [0 400];
DepthTF = and(DepthRange(1)>=SegmentDepth,SegmentDepth<=DepthRange(2));
for n = 1:length(X)
    ind = and(DiamStep(n)>=Diam,Diam<DiamStep(n+1));
    X(n) = sum(EstVolume(and(ind,DepthTF)));
end
[x,y] = TS_bar2patch(X,DiamStepinput);
% p = patch(x,y,ones(1,3)*0.5);

figure,p = patch(x,y,ones(1,3)*0.5);
axh = gca;
axh.XTick = 2:2:14;
xlim([2 14])
xlabel('Diameter [\mum]')
ylabel('Estimated Volume [\mum^3]')


catch err
    keyboard
end

%% output
output.InputSEG = SEG;
output.RotMovData = RotMovStretchData;
output.AdjustedZData = AdjZdata;
output.ReconstractImage = Reco;
output.Depth_Step = Depth_Step;
output.Depth_Label = Depth_Label;
output.Vasculature = Ves;
output.Tissue = TissueArea;
output.Tissue_Label = Tissue_Label;
output.bar_handle = Handles;
output.SegmentDiameter = Diam;
output.SegmentEstVolume = EstVolume;
output.SegmentDepth = SegmentDepth;
output.VolumeHistDepthRange = DepthRange;
output.VolumeHistXbin = DiamStep;
output.VolumeHist = X;














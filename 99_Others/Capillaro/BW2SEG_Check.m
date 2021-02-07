Parent =  '/mnt/NAS/Share12/Share2/Capillaliy_Of_fingertip/Experimentdata/181125/'
FindDir = dir([Parent '*mae.avi'])
SaveDir =  ['/mnt/NAS/Share2/Capillaliy_Of_fingertip/'...
    'SpatialPhysicalQuantityJ_20191106/Binalize_Test'];
if isempty(dir(SaveDir))
    mkdir(SaveDir)
else
    error('ExistingDirectory...')
end
%%
data(1:length(FindDir)) = struct('Name',[],'DeconvImage',[],'BW',[],'SEG',[]);
for ii = 1:length(FindDir)
%%Script for Analysis Capillaro 4D Image data
CapFun = Capillaro_MatFunctions;
V = Sugashi_ReconstructGroup;
% load Movie
% FULLPATH = CapFun.UIGetVideoPath();
FULLPATH = [Parent FindDir(ii).name];
Name = FindDir(ii).name(1:end-4);

% Setting up Start and Duration 
if true
    %% if u need change start time, and Duration,
    CapFun.StartTime = 0;
    CapFun.GetDuration = 10;
end
% load Video data to mat
[Vi,vdata] = CapFun.LoadVideo(FULLPATH,0);
CapFun.VideoData = Vi;
CapFun.VideoInfomation = vdata;
CapFun.XYSize = [vdata.Width vdata.Height];
CapFun.FOV = (CapFun.XYSize-1).*[  0.6836    0.6836 ];
vdata %% this is last frame infomation.
Reso = [CapFun.Resolution 0]

%% Blind Deconv
Image = cat(4,CapFun.VideoData(1).cdata);
TimeInd = cat(2,CapFun.VideoData.CurrentTime);
DImage = CapFun.Blind_Deconv(Image);

%% Adjust Contrast 
AdjImage = CapFun.AdjustContrast(DImage);
CapFun.AdjImage = AdjImage;
%% Gray Image
CapFun.GrayImage = imcomplement(DImage(:,:,2,:));

%% Binalization 
slice_im = DImage(:,:,2,CapFun.ReferenceSliceInd) ;
slice_im = TSmedfilt2(slice_im,[5 5]);
% Sslice_im = TS_ShadingImage(slice_im,CapFun.Resolution);
slice_im = imcomplement(slice_im);
BWBlockSiz = round(CapFun.XYSize/50); %% 100 pix squared,roi
EdgeIndex = true(size(slice_im));
EdgeSize = 30;
EdgeIndex(EdgeSize+1:end-EdgeSize,EdgeSize+1:end-EdgeSize) = false;
slice_im(EdgeIndex) = mode(slice_im(~EdgeIndex));
slice_im = double(slice_im);
slice_im = slice_im - min(slice_im(:));
slice_im = slice_im./max(slice_im(:));
[slice_bw,level] = TS_im2bw_block(slice_im,BWBlockSiz);
slice_bw(EdgeIndex) = false;
% closing, 
close_se = strel('disk',2,0);
slice_bw_processed = imclose(slice_bw,close_se);
open_se = strel('disk',5,0);
slice_bw_processed = imopen(slice_bw_processed,open_se);
skel = bwskel(slice_bw_processed);
% R = slice_bw;R(or(skel,slice_bw_processed)) = false;
% B = slice_bw_processed;B(skel) = false;
% fgh = figure;
% imagescReso(rgbproj(cat(3,R,skel,B)),Reso),clear R B
% saveas(fgh,[SaveDir filesep 'FIG_' Name '_bw.fig'])
% saveas(fgh,[SaveDir filesep 'FIG_' Name '_bw.tif'])
% close(fgh)
%% Segmentation
FirstCutLength = 30;
SEG = TS_AutoSegment_v2019Charly(skel,CapFun.Resolution,[],FirstCutLength);
% x = rgbproj(  DImage(:,:,:,CapFun.ReferenceSliceInd)   );
% fgh = figure;
% imagescReso(x,Reso),hold on
% V.SEGview_Limit(gca,SEG,'Length')
% view(2)
% saveas(fgh,[SaveDir filesep 'FIG_' Name '_length.fig'])
% saveas(fgh,[SaveDir filesep 'FIG_' Name '_length.tif'])
%% 

NewSEG = TS_AutoAnalysisDiam_SEG_v2019Elza(slice_im,Reso,'fwhm',SEG);

%% Summary
data(ii).Name = Name;
data(ii).DeconvImage = DImage(:,:,:,CapFun.ReferenceSliceInd);
data(ii).BW = slice_bw_processed;
data(ii).SEG = NewSEG;


end

%% picup top 20 ?
% Length * SNR
Im(1:length(data)) = struct('cdata',[],'colormap',[]);
fgh = figure('Position',[10 10 512 768/2]);
axh = axes('Posi',[0 0 1 1]);
colormap(jet(256))
SNRMaximum = 10;
LenMaximum = 50;
PicupLen = 20; %% top of 20 is looked for.
CurveMiniRNormal = 5;
CurveMinRMinimum = 1;
for n = 1:length(data)    
    imagescReso(axh,data(n).DeconvImage,Reso);
    hold on,axis off
    SEG = data(n).SEG;
    SEG.Size(3) = 1;
    SEG = S.AddSpatialPhysicalQuantity_Capillaro(SEG,'-f');
    SEG = CapFun.Add_IndexOf_Left_Right_Curve(SEG);
    Pdata = SEG.Pointdata;
    LenS = cat(1,Pdata.Length);
    [~,idx] = sort(LenS,'descend');
    for k = 1:length(Pdata)
        Len = Pdata(k).Length;
        if Len >=LenS(idx(PicupLen))            
            CurveInd = Pdata(k).LeftCurveRight_Label ==0;
            disp(sum(CurveInd))
            xyz = Pdata(k).PointXYZ;
            CurveLen = sum(S.xyz2plen(xyz(CurveInd,:),SEG.ResolutionXYZ));
            Signal = Pdata(k).Signal;
            Noise = Pdata(k).Noise;            
            SNR = Signal./Noise;
            SNR = max(SNR);
        else
            SNR = 0;
            CurveLen = 0;
        end
        Pdata(k).ExtractedFactor1 = SNR;
        Pdata(k).ExtractedFactor2 = CurveLen;
% % %         
% % %         Signal = Pdata(k).Signal;
% % %         Noise = Pdata(k).Noise;
% % %         Len = Pdata(k).Length;
% % %         Di = Pdata(k).DirectedDistance;        
% % %         CurvFacter = (Len - Di).\Len;% normalized factor
% % %         Len = min(Len,LenMaximum);
% % %         Len = Len ./LenMaximum;% normalized factor        
% % %         SNR = min(Signal./Noise,SNRMaximum);        
% % %         SNR = SNR ./ SNRMaximum;% normalized factor
% % %         CurveMinR = Pdata(k).CurveMinimumR;
% % %         CurveMinR(isnan(CurveMinR)) = Inf;
% % %         CurveMinR = max(CurveMinR,CurveMinRMinimum);
% % %         CurveMinR = 1./abs(CurveMiniRNormal - CurveMinR);% normalized factor
% % %         
% % %         Pdata(k).ExtractedFactor = ...
% % %             (CurvFacter+1)*(Len+1)*(SNR+1)*(CurveMinR+1);
    end
    Ex1 = cat(1,Pdata.ExtractedFactor1);
    Ex2 = cat(1,Pdata.ExtractedFactor1);
    [~,idx1] = sort(Ex1,'descend');
    [~,idx2] = sort(Ex2,'descend');
    [~,OverAll] = sort(idx1.*idx2);
    for k = 1:length(Pdata)
        Pdata(k).OverAllFactor = 1/min(OverAll(k),PicupLen);
    end
    
    SEG.Pointdata = Pdata;
    data(n).MSEG  = SEG;
%     p = V.SEGview_Limit(gca,SEG,'ExtractedFactor2');
    p = V.SEGview_Limit(gca,SEG,'OverAllFactor');
    p.LineWidth = 3;
    view(2)
    caxis([1/20 1])
    Im(n) = getframe(fgh);
    clear Pdata k Signal Noise Len SNR Di CurveFacter CurveMinR SEG p
    cla(axh)
end
clear xyz idx1 idx2 idx a b fgh axh ans LenS Ex1 Ex2


%% set up
Parent =...
    '/mnt/NAS/Share2/Capillaliy_Of_fingertip/SpatialPhysicalQuantityJ_20191106/Deconv_TrakingParticle';
FindDir = dir([Parent filesep 'BlindDeconv*.mat']);



%% Slice Reposition
for ii = 1:length(FindDir)
% load Movie
% FULLPATH = CapFun.UIGetVideoPath();
FULLPATH = [Parent filesep FindDir(ii).name];
% % % Name = FindDir(ii).name(1:end-4);
% % % % Setting up Start and Duration 
% % % %% change start time, and Duration,
% % % CapFun.StartTime = 0;
% % % CapFun.GetDuration = 10;
% % % % MSEG = data(ii).MSEG;
% % % % load Video data to mat
% % % [Vi,vdata] = CapFun.LoadVideo(FULLPATH);
% % % Image = cat(4,Vi.cdata);
% % % CapFun.XYSize = [vdata.Width vdata.Height];
% % % CapFun.FOV
% % % Reso = CapFun.Resolution
% % % DImage = CapFun.Blind_Deconv(Image,'green');
load(FULLPATH,'Image','DImage')

% OverAllFactor = cat(1,MSEG.Pointdata.OverAllFactor);
% [~,idx] = sort(OverAllFactor,'descend');
EdgeSize = 50;
Xlim = [EdgeSize+1, CapFun.XYSize(1)-EdgeSize];
Ylim = [EdgeSize+1, CapFun.XYSize(2)-EdgeSize];
P = detectSURFFeatures(DImage(:,:,1));
OverAllFactor = cat(1,P.Location);
TFx = and(OverAllFactor(:,1)>Xlim(1),Xlim(2)>OverAllFactor(:,1));
TFy = and(OverAllFactor(:,2)>Ylim(1),Ylim(2)>OverAllFactor(:,2));
TF = and(TFx,TFy);
OverAllFactor = OverAllFactor(TF,:);

% 
% OutOfArea = true(size(DImage(:,:,1,1)));
% OutOfArea(EdgeSize+1:end-EdgeSize,EdgeSize+1:end-EdgeSize) = false;

TOP10 = min(size(OverAllFactor,1), 10);
ROIsiz = ceil(100 ./ Reso +1); %% 100 um rectangle.
ROIx = 1:ROIsiz(1); ROIx = ROIx - ceil((ROIx-1)/2);
ROIy = 1:ROIsiz(2); ROIy = ROIy - ceil((ROIy-1)/2);
ShiftXY = nan(size(DImage,4),2,TOP10);
for n = 1:TOP10
%     xyz = MSEG.Pointdata(idx(n)).PointXYZ;
%     [~,Ytop] = min(xyz(:,2));
%     Center = xyz(Ytop,1:2);
    Center = round(OverAllFactor(n,:));
    xdata = ROIx+Center(1);
    xdata(xdata<1) = [];xdata(xdata>CapFun.XYSize(1)) = [];
    ydata = ROIy+Center(2);
    ydata(ydata<1) = [];ydata(ydata>CapFun.XYSize(2)) = [];    
    ROI = DImage(ydata,xdata,:);
    ShiftXY(:,:,n) = CapFun.RepositXY(ROI);
end
% outZero = ShiftXY;
% outZero(outZero==0) = nan;
% outZero = mode(outZero,3);
% outZero(isnan(outZero)) = 0;
RDImage = CapFun.RepositXYImage(DImage,mean(ShiftXY,3));


end
%%



%% Diameter
Ma = 0;
for n = 1:42
    D = cat(1,data(n).SEG.Pointdata.Diameter);
    data(n).Diameter = D;
    Ma = max(Ma,length(D));
end
for n = 1:42
    D = data(n).Diameter;
    D = padarray(D,[Ma-length(D), 0],nan,'post');
    data(n).PadDiameter = D;
end













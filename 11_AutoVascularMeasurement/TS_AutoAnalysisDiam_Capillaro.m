function [output,ppdata] = TS_AutoAnalysisDiam_Capillaro(fImage,inReso,SEG)
%  NewSEG = TS_AutoAnalysisDiam_Capillaro(fImage,inReso,SEG)
% fImage        : just medianfiltered raw-Image
% Reso          : Resolution(X,Y,Z) as Input of "fImage", % um/pix.
% % ThresholdType : {fwhm only}*
% SEG           : output of TS_AutoSegment_loop
% 
% Compensation by SNR (this value is for PMT or Photon Count ver. Image)
% th = TS_GetThreshold_sp5(S,N);
% th = TS_GetThreshold_sp8(S);
%
% ROI as rotate line profile is defined below length as default.
% Len = [70 100]; % um , 1st is xy-plane. 2nd is z-axis length.
%  
%  see alo so , Sugashi_AutoAnalysisDiam, TS_AutoSegment_loop, Segment_Functions
% TS_AutoAnalysisDiam_AddAdjPreFWHM_perSlice  Group...
% 
% 
% Editor log. 
% Add, Threshold Type to fwhm(threhsold =0.5), 2019.06.14 ,Sugashi
% change parfor input... 
% 
% version v2019c is lower memory usage, higher perfomance parallel computing.
%  2019.07.05, by Sugashi
% 
% version v2019delta has 2 more function,
%     1st, Correspoinding for 4-D (Time Data),
%     2nd, Noise is considered on circle area (diameter = 100 um )
%     and, modify SNR threshold (2 dB)
%   2019.08.10. by Sugashi,
% 
% edit Th as sp5, 2019/Oct.31 ~ Nov.1st ,b y sugashi
% edit for capillaro , 2019/Nov.13 ,by sugashi
     
    

%% for Time Data
if and( size(fImage,3) == 1, size(fImage,4) > 1)
    for k = 1:size(fImage,4)
        outputSlice = TS_AutoAnalysisDiam_Capillaro(...
            squeeze(fImage(:,:,:,k)),inReso,SEG);        
        if k == 1
            output = outputSlice;
        else
            output(k).Pointdata = outputSlice.Pointdata;
        end
        output(k).SliceInfo = k;
    end
    ppdata = [];
    return
end



%% Main (for 3D or 2D)
global Len Reso NoiseArea block_siz
Reso = inReso;

%%
fprintf('Starting ... ')
fprintf(mfilename)
fprintf('\n')
S = Segment_Functions;
SEG = S.set_Segment(SEG);
Number = cat(1,SEG.Pointdata.ID);
Number = Number(Number>0);    
Number = S.ID2Index(Number,cat(1,SEG.Pointdata.ID));
Number(isnan(Number)) = [];

siz = size(fImage);
% siz(3) = size(fImage,3);
SNRth = 2; % [dB]
Len = 70  %200]; % Rotation Line Profile Length , Checking Axis Z Line Length
NoiseArea = 100; % [um]
NoiseArea = (NoiseArea/Reso(1) +1 ) /2; % [pixels radius]
block_siz = [10 8];
PenetLenTh = 100;


%% set up xyz data
Pdata = SEG.Pointdata;
xyz = double(cat(1,Pdata(Number).PointXYZ));
SEGRESO = SEG.ResolutionXYZ;
xyz = (xyz-1) .* SEGRESO;
xyz = (xyz ./ Reso) + 1;
indY = xyz(:,2);
indX = xyz(:,1);
indZ = xyz(:,3);

%% setup Norm Theta
Vec = cat(1,SEG.Pointdata(Number).SphereFitUnitVector);
Theta = S.UnitVector2Theta(Vec,repmat([1 0 0],[length(Vec),1]));
NTheta = Theta + pi/2;

%% check xyz size
if or(min(indX)<1,max(indX)>size(fImage,2))
    warning('Input SEG Index Size over(less) than fImage (X-axis).')
elseif or(min(indY)<1,max(indY)>size(fImage,1))
    warning('Input SEG Index Size over(less) than fImage (Y-axis).')
end

%% Analysis
TIME = tic;
ppdata(1:length(indY)) = ...
    struct('XYZ',[],'Signal',[],'Noise',[],'Theta',[],'ThCorrectedWidth',[],...
    'PixelsDiameter',[],'Type',[],'NewXYZ',[]);
%% Add Pre FWHM
% This Process is to denoising in Near 3 point from center point
close_siz = round(3 / Reso(1));
close_siz = close_siz + double(eq(floor(close_siz/2),ceil(close_siz/2)));
se = ones(close_siz,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SfImage = imfilter(single(fImage),ones(3,3,3)/27,'symmetric');
[meshX,meshY,meshZ] = meshgrid(1:siz(2),1:siz(1),1);
[Xp,Yp,theta] = TS_GetLinePro2mesh(fImage(:,:,1),[0 0],Len(1),Reso);

%% Each Step
PoolObj = gcp;
if isempty(PoolObj)
    PoolObj = parpool;
end
NumWorker = PoolObj.NumWorkers;
MaxNumel = max(numel( Xp )*2,prod(siz(1:2)));
SingleByte = 4;
MaximumUsableMemorySize = TS_checkmem('double')  - 2*2^30; % Gibi Bytes
EachStep = floor(MaximumUsableMemorySize / ( MaxNumel  * SingleByte * NumWorker^2 ));
EachStep = EachStep * NumWorker;
EachStep = max(EachStep,NumWorker);
% EachStep = NumWorker;


%% Main 
fImage = single(fImage);
%% Analysis Signal
Signals = struct('Xq',[],'Yq',[],'Zq',[]);
fprintf(' Analysis Signal (Createing mesh.)....')
parfor n = 1:length(indZ)
    x=indX(n);y=indY(n);
    [Xq,Yq] = GetSignalMesh(x,y,siz);
    Signals(n).Xq = Xq(:);
    Signals(n).Yq = Yq(:);
end
Xq = cat(2,Signals.Xq);
Yq = cat(2,Signals.Yq);
Shori = interp2(fImage,Xq,Yq,'bilinear');
Shori = nanmean(Shori,1);
clear Signals Xq Yq Zq
fprintf(' Done\n')
%% Analysis Noise and Measure Diameter
fprintf('    Analysis Noise and Normalized')
fprintf(['   Numeric : ' num2str(length(indZ)) ', EachStep : ' num2str(EachStep) '\n'])
NewStep = 1:EachStep:length(indZ);
zdata = 1:length(indZ);
cpIndY = indY;
cpIndX = indX;
cpIndZ = indZ;
cpSignal = Shori;
TS_WaiteProgress(0)
for k = 1:length(NewStep)
    StepIndex = and(zdata >= NewStep(k) , zdata < NewStep(k) + EachStep);
    indY = cpIndY(StepIndex);
    indX = cpIndX(StepIndex);
    indZ = cpIndZ(StepIndex);
    Signal = cpSignal(StepIndex);
    theta = NTheta(StepIndex);
    if isempty(indZ)
        continue
    end       
    SliceImage(1:length(indZ)) = struct('Xq',[],'Yq',[],'Noise',[]);
    
    %% abount noise calc.
    ydata = round(linspace(1,size(fImage,1)+1,block_siz(1)*2+2));
    xdata = round(linspace(1,size(fImage,2)+1,block_siz(2)*2+2));
    level = zeros(block_siz*2);
    for ny = 1:length(ydata)-2
        for nx = 1:length(xdata)-2
            yidx = ydata(ny):(ydata(ny+2) - 1);
            xidx = xdata(nx):(xdata(nx+2) - 1);
            im = fImage(yidx,xidx);
            level(ny,nx) = TS_GetBackgroundValue(im);
        end
    end
    level = imresize(level,size(fImage));    
    Noise = interp2(level,indX,indY);
    parfor n = 1:length(indZ)
        x=indX(n);y=indY(n);
        [Xp,Yp] = TS_GetLinePro2mesh(fImage,[0 0],Len(1),Reso,theta(n));
        SliceImage(n).Xq = Xp + x;
        SliceImage(n).Yq = Yp + y;                        
    end    
    Xq = cat(2,SliceImage.Xq);
    Yq = cat(2,SliceImage.Yq);    
    parImage = interp2(fImage,Xq,Yq,'bilinear');
    clear SliceImage
    parpdata(1:length(indZ)) = struct('XYZ',[],'Theta',[],...
        'Signal',[],'Noise',[],'ThCorrectedWidth',[],'PixelsDiameter',[],...
        'Type',[],'NewXYZ',[]);
    parfor n = 1:length(indZ)              
        S = double(Signal(n));
        N = double(Noise(n));        
        %% getiing vpmatrix
        L = parImage(:,n);
        L = (L-N)/(S-N)
        parImage(:,n) = L;
    end
    th = 0.5;
    %% Add Pre FWHM
    % This Process is to denoising in Near 3 point from center point
    % pre_vpmatrix = vpmatrix;
    vpmatrix = parImage;
    vpmatrix(round(size(vpmatrix,1)/2),:) = 1;
    L = bwlabel(vpmatrix>th,8);
    CenterLabel = L(round(size(vpmatrix,1)/2),1);
    bw_vp = L==CenterLabel;
    % % This process is to analys High Noise data ,but High SNR is not neccaaary
    bw_vp = imclose(bw_vp,se);
    bw_vp = imerode(bw_vp,ones(3,1)); %
    vpmatrix(bw_vp) =  max(vpmatrix(bw_vp),th); %
    fwhm = TS_FWHM2019(vpmatrix,th);
    DiffFWHM = diff(fwhm,[],2);   
    
    parfor n = 1:length(indZ)
        %% output NEW Position
        x=indX(n);y=indY(n);z=indZ(n);        
        newx = Xq(:,n);
        newy = Yq(:,n);
        newind = fwhm(n,:);
        newind = mean(newind);        
        newx = interp1(newx,newind,'linear');
        newy = interp1(newy,newind,'linear');
        newz = z;    
        %% output for parpdata    
        parpdata(n).XYZ = [x y z];
        parpdata(n).Theta = theta(n);
        parpdata(n).Signal = single(Signal(n));
        parpdata(n).Noise = single(Noise(n));
        parpdata(n).ThCorrectedWidth = fwhm(n,:);
        parpdata(n).PixelsDiameter = DiffFWHM(n,:);
        parpdata(n).NewXYZ = [newx newy newz]; 
    end
   
   %% Witing pdata
    pind = find(StepIndex);
    for n = 1:length(pind)
        ppdata(pind(n)).XYZ = parpdata(n).XYZ;
        ppdata(pind(n)).Theta = parpdata(n).Theta;
        ppdata(pind(n)).Signal = parpdata(n).Signal;
        ppdata(pind(n)).Noise =  parpdata(n).Noise;
        ppdata(pind(n)).ThCorrectedWidth = parpdata(n).ThCorrectedWidth;
        ppdata(pind(n)).PixelsDiameter = parpdata(n).PixelsDiameter;        
        ppdata(pind(n)).NewXYZ = parpdata(n).NewXYZ;        
    end
%     clear parImage parpdata Noise Signal parZdata
    TS_WaiteProgress(k/length(NewStep))
end
%% reshape output data to SEG structure.
fprintf('\n  Reshape output data to SEG structure...')
c = 1;
for Nind = 1:length(Number)
    xyz = SEG.Pointdata(Number(Nind)).PointXYZ;
    Signal = zeros(size(xyz,1),1,'like',single(1));    
    Noise = Signal;
    Diameter = Signal;
    Theta = Signal;
    NewXYZ = double(cat(2,Signal,Signal,Signal));    
    for k = 1:size(xyz,1)
        Signal(k) = ppdata(c).Signal;
        Noise(k) = ppdata(c).Noise;
        Diameter(k) = ppdata(c).PixelsDiameter * Reso(1);
        Theta(k) = ppdata(c).Theta;
        NewXYZ(k,:) = ppdata(c).NewXYZ;
        c = c +1;
    end
    SEG.Pointdata(Number(Nind)).Signal = Signal;
    SEG.Pointdata(Number(Nind)).Noise = Noise;
    SEG.Pointdata(Number(Nind)).Diameter = Diameter;
    SEG.Pointdata(Number(Nind)).Theta = Theta;
    NewXYZ = (NewXYZ -1 ) .* Reso;
    NewXYZ = (NewXYZ ./ SEGRESO ) + 1;
    SEG.Pointdata(Number(Nind)).NewXYZ = NewXYZ;
end
fprintf('Done.\n')
output = SEG;
output.DiameterAnalysisTime = toc(TIME);
toc(TIME)
fprintf('\n')
end


function [X,Y] = GetSignalMesh(x,y,siz)
    X = x-1 : x + 1;
    X(X<1) = -1;
    X(X>siz(2)) = siz(2)+1;
    Y = y-1 : y + 1;
    Y(Y<1) = -1;
    Y(Y>siz(1)) = siz(1)+1;
    [X,Y] = meshgrid(X,Y);
end

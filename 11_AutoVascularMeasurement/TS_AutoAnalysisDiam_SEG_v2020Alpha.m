function [output,ppdata] = TS_AutoAnalysisDiam_SEG_v2020Alpha(fImage,inReso,ThresholdType,SEG,varargin)
% SEG = TS_AutoAnalysisDiam_SEG(fImage,Reso,ThresholdType,SEG,{ID})
% fImage        : just medianfiltered raw-Image
% Reso          : Resolution(X,Y,Z) as Input of "fImage", % um/pix.
% ThresholdType : {sp5, sp8, photo count, pmt, ..}*
% SEG           : output of TS_AutoSegment_loop
% (ID)          : you can chose ID(s) of Segment, see also Segment_Functions
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
% vFalcon had been changed Noise ( TS_GetBackgroundValue_GaussianFit)
%
% version 2020 Alpha released 2020,4th Apr.
% Function of getting Background value back to TS_GetBackgroundValue
% And Time cose data(2D x Time data) has matrix in SEG.Pointdata.
% like n x m matrix mean that n is number of Point XYZ, m is Num. Time Slice 
% BTW, NewPointdata has 3rd axis as Time data...
    

%% for Time Data
if and( size(fImage,3) == 1, size(fImage,4) > 1)
    StartTic = tic;
    for k = 1:size(fImage,4)
        outputSlice = TS_AutoAnalysisDiam_SEG_v2020Alpha(...
            squeeze(fImage(:,:,:,k)),inReso,ThresholdType,SEG,varargin{:});        
        if k == 1
            output = outputSlice;
        else
            for nn = 1:length(output.Pointdata)
                output.Pointdata(nn).Signal = ...
                    cat(2,output.Pointdata(nn).Signal,...
                    outputSlice.Pointdata(nn).Signal);
                output.Pointdata(nn).Noise = ...
                    cat(2,output.Pointdata(nn).Noise,...
                    outputSlice.Pointdata(nn).Noise);
                output.Pointdata(nn).Diameter = ...
                    cat(2,output.Pointdata(nn).Diameter,...
                    outputSlice.Pointdata(nn).Diameter);
                output.Pointdata(nn).Theta = ...
                    cat(2,output.Pointdata(nn).Theta,...
                    outputSlice.Pointdata(nn).Theta);
                output.Pointdata(nn).NewXYZ = ...
                    cat(3,output.Pointdata(nn).NewXYZ,...
                    outputSlice.Pointdata(nn).NewXYZ);                
            end            
        end        
    end
    ppdata = [];
    output.DiameterAnalysisTime = toc(StartTic);
    return
end



%% Main (for 3D or 2D)
global Len Reso NoiseArea
Reso = inReso;

%%
fprintf('Starting ... ')
fprintf(mfilename)
fprintf('\n')
S = Segment_Functions;
SEG = S.set_Segment(SEG);
if nargin ==5
    Number = varargin{1};    
else
    Number = cat(1,SEG.Pointdata.ID);
    Number = Number(Number>0);    
end
Number = S.ID2Index(Number,cat(1,SEG.Pointdata.ID));
Number(isnan(Number)) = [];
if ~max(strcmpi({'sp5','sp8','fwhm'},ThresholdType))
    warning(   mfilename('fullpath') )
    error('Input Threshold Type is Member of {"sp5"(=PMT), or "sp8"(=Photo Count)}')
end
siz = size(fImage);
siz(3) = size(fImage,3);
SNRth = 2; % [dB]
Len = [70 200]; % Rotation Line Profile Length , Checking Axis Z Line Length
NoiseArea = 100; % [um]
NoiseArea = (NoiseArea/Reso(1) +1 ) /2; % [pixels radius]
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
%% check xyz size
if or(min(indX)<1,max(indX)>size(fImage,2))
    warning('Input SEG Index Size over(less) than fImage (X-axis).')
elseif or(min(indY)<1,max(indY)>size(fImage,1))
    warning('Input SEG Index Size over(less) than fImage (Y-axis).')
elseif or(min(indZ)<1,max(indZ)>size(fImage,3))
    warning('Input SEG Index Size over(less) than fImage (Z-axis).')
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
EachStep = EachStep * NumWorker/4;
EachStep = max(EachStep,NumWorker);
% EachStep = NumWorker;


%% Main 
fImage = single(fImage);
%% Analysis Signal
Signals = struct('Xq',[],'Yq',[],'Zq',[]);
fprintf(' Analysis Signal (Createing mesh.)....')
parfor n = 1:length(indZ)
    x=indX(n);y=indY(n);z=indZ(n);
    [Xq,Yq,Zq] = GetSignalMesh(x,y,z,siz);
    Signals(n).Xq = Xq(:);
    Signals(n).Yq = Yq(:);
    Signals(n).Zq = Zq(:);
end
Xq = cat(2,Signals.Xq);
Yq = cat(2,Signals.Yq);
Zq = cat(2,Signals.Zq);
if siz(3)>1
    Shori = interp3(fImage,Xq,Yq,Zq,'bilinear');
else
    Shori = interp2(fImage,Xq,Yq,'bilinear');
end
Shori = nanmean(Shori,1);
clear Signals Xq Yq Zq
fprintf(' Done\n')
%% Analysis Noise and Measure Diameter
fprintf('    Analysis Noise and Measure Diameter')
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
    if isempty(indZ)
        continue
    end
    SliceImage(1:length(indZ)) = struct('Xq',[],'Yq',[],'Zq',[]);
    parfor n = 1:length(indZ)
        SliceImage(n).Xq = meshX;
        SliceImage(n).Yq = meshY;
        SliceImage(n).Zq =  repmat(indZ(n),size(meshZ));
    end
    Xq = cat(3,SliceImage.Xq);
    Yq = cat(3,SliceImage.Yq);
    Zq = cat(3,SliceImage.Zq);
    if siz(3) > 1
        parImage = interp3(fImage,Xq,Yq,Zq, 'bilinear');
    else
        parImage = interp2(fImage,Xq,Yq, 'bilinear');
    end
    clear SliceImage Xq Yq Zq
    SliceImage(1:length(indZ)) = struct('Xq',[],'Yq',[],'Zq',[],'Noise',[]);
    parfor n = 1:length(indZ)
        x=indX(n);y=indY(n);z=indZ(n);        
        SliceImage(n).Xq = Xp + x;
        SliceImage(n).Yq = Yp + y;
        SliceImage(n).Zq = repmat(z,size(Xp));
        im = parImage(:,:,n);
        rX = meshX - x;
        rY = meshY - y;
        rArea = sqrt(rX.^2 + rY.^2) <=NoiseArea;        
        im = im(rArea);
        N = TS_GetBackgroundValue(im);
%         N = TS_GetBackgroundValue_GaussianFit(im);
        SliceImage(n).Noise = single(N);
    end    
    Xq = cat(3,SliceImage.Xq);
    Yq = cat(3,SliceImage.Yq);
    Zq = cat(3,SliceImage.Zq);
    Noise = cat(2,SliceImage.Noise);
    if siz(3)>1
        parImage = interp3(fImage,Xq,Yq,Zq, 'bilinear');
    else
        parImage = interp2(fImage,Xq,Yq,'bilinear');
    end
    clear Xq Yq Zq SliceImage
    
    parpdata(1:length(indZ)) = struct('XYZ',[],'Theta',[],...
        'Signal',[],'Noise',[],'ThCorrectedWidth',[],'PixelsDiameter',[],...
        'Type',[],'NewXYZ',[]);
    parfor n = 1:length(indZ)
        x=indX(n);y=indY(n);z=indZ(n);        
        S = double(Signal(n));
        N = double(Noise(n));
        fwhm = zeros(length(theta),2);
        %% getiing vpmatrix
        vpmatrix = parImage(:,:,n);
        vpmatrix = double(vpmatrix);
        vpmatrix = (vpmatrix-N)/(S-N);
        vpmatrix = max(vpmatrix,0);        
                
        if strcmpi(ThresholdType,'sp5')
%             th = TS_GetThreshold_sp5(S,N);        
            th = TS_GetThreshold_sp5_v2019(S,N);        
        elseif strcmpi(ThresholdType,'sp8')
            th = TS_GetThreshold_sp8(S);
        elseif strcmpi(ThresholdType,'fwhm')
            th = 0.5;
        else
            error('Input Threshold Type UNKNOW.')
        end        
        %% Add Pre FWHM
        % This Process is to denoising in Near 3 point from center point
        % pre_vpmatrix = vpmatrix;
        vpmatrix(round(size(vpmatrix,1)/2),:) = 1;
        L = bwlabel(vpmatrix>th,8);
        CenterLabel = L(round(size(vpmatrix,1)/2),1);
        TF = and( CenterLabel>0, SNRth < 10*log10(S/N));
        if TF
            bw_vp = L==CenterLabel;
            % % This process is to analys High Noise data ,but High SNR is not neccaaary
            bw_vp = imclose(bw_vp,se);
            bw_vp = imerode(bw_vp,ones(3,1)); %

            vpmatrix(bw_vp) =  max(vpmatrix(bw_vp),th); %
            fwhm = TS_FWHM2019(vpmatrix,th);
%             for kk = 1:length(theta)
%                 Lp = double(vpmatrix(:,kk));
%                 fwhm(kk,:) = TS_FWHM2016(Lp,th,'type','fwhm','Center',floor(length(Lp)/2));
%             end        
            DiffFWHM = diff(fwhm,[],2);
            [PixDiam,Ind] = min(DiffFWHM);
            Ind = Ind(1);

            %% output NEW Position
            vpX = Xp + x;
            vpY = Yp + y;
            newx = vpX(:,Ind);
            newy = vpY(:,Ind);
            newind = mean(fwhm(Ind,:));
            newx = interp1(newx,newind,'linear');
            newy = interp1(newy,newind,'linear');
            newz = z;    
            %% output for parpdata    
            parpdata(n).XYZ = [x y z];
            parpdata(n).Theta = theta(Ind);
            parpdata(n).Signal = single(S);
            parpdata(n).Noise = single(N);
            parpdata(n).ThCorrectedWidth = fwhm;
            parpdata(n).PixelsDiameter = PixDiam;
            parpdata(n).NewXYZ = [newx newy newz];        
        else
            %% output for parpdata    
            parpdata(n).XYZ = [x y z];
            parpdata(n).Theta = nan;
            parpdata(n).Signal = single(S);
            parpdata(n).Noise = single(N);
            parpdata(n).ThCorrectedWidth = fwhm;
            parpdata(n).PixelsDiameter = nan;
            parpdata(n).NewXYZ = [x y z];        
        end
    end
    

    %% Calculate Suggestion Z --> will be delete processing
    if siz(3)>1        
        for n = 1:length(indZ)
            z = indZ(n);
            parpdata(n).NewXYZ(3) = z;
            parpdata(n).Type = 'others';
        end
    else
        for n = 1:length(indZ)
            parpdata(n).Type = 'others';
        end
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
        ppdata(pind(n)).Type = parpdata(n).Type;
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


function [X,Y,Z] = GetSignalMesh(x,y,z,siz)
    X = x-1 : x + 1;
    X(X<1) = -1;
    X(X>siz(2)) = siz(2)+1;
    Y = y-1 : y + 1;
    Y(Y<1) = -1;
    Y(Y>siz(1)) = siz(1)+1;
    Z = z-1 : z + 1;
    Z(Z<1) = -1;
    Z(Z>siz(3)) = siz(3)+1;
    [X,Y,Z] = meshgrid(X,Y,Z);
end
function [X,Y,Z] = GetAxisZMesh(x,y,z,siz,PixLen)
    X = x-1 : x + 1;
    X(X<1) = -1;
    X(X>siz(2)) = siz(2)+1;
    Y = y-1 : y + 1;
    Y(Y<1) = -1;
    Y(Y>siz(1)) = siz(1)+1;
    Z = z-PixLen/2 : z + PixLen/2;
    % Z(Z<1) = [];
    % Z(Z>siz(3)) = [];
    [X,Y,Z] = meshgrid(X,Y,Z);
    num1 = size(X,1) * size(X,2);
    num2 = size(X,3);
    X = reshape(X,num1,num2);
    Y = reshape(Y,num1,num2);
    Z = reshape(Z,num1,num2);
end

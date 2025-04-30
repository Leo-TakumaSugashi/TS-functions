function [output,ppdata] = TS_AutoAnalysisDiam_SEG_v2020Charliy(...
    fImage,inReso,ThresholdType,SEG,varargin)
% SEG = TS_AutoAnalysisDiam_SEG(fImage,Reso,ThresholdType,SEG,{Options...})
%  Option are like below,,
% SEG = TS_AutoAnalysisDiam_SEG(...,'ID','all',...
%                              'SNRLim',3,'SNRUnit','a.u.',...
%                              'LineLenth',40,...
%                              'NoiseType','Slice',...
%                              'MeasureType','All',...
%                              'Progressbar','off',...
%                              'ForceParfor','on');
% 
% fImage        : just medianfiltered raw-Image
% Reso          : Resolution(X,Y,Z) as Input of "fImage", % um/pix.
% ThresholdType : {sp5, sp8, photo count, pmt, ..}*
% SEG           : output of TS_AutoSegment_loop and
%                  **Segment_Function.set_Segment(SEG,'f')
% 
% Options.... default
%             ID = '>0'; %% must Be ">0",'all',or numeric
%             Progressbar ='on'; %% on or off
%             SNRLim = 2; %%
%             SNRUnit = 'dB'; %% dB or a.u., will be calicualte
%             LineLength = 70; % Numeric,[um],
%             NoiseType = 'Eachpoint'; 
%                    EachPoint, Slice(if siz(3)==1), Numeric(==Constant)
%             MeasureType = 'LineRot'; 
%                           {'LineRot','NormLine','Elliptic','Hybrid','Speed','All'}
%                            Hybrid =='LineRot&Elliptic', Speed =='NormLine&Elliptic'
%             ForceParfor = 'on'; %% on or off
%             MaximumStep = 512; % Numeric,
%  
% Compensation by SNR (this value is for PMT or Photon Count ver. Image)
% th = TS_GetThreshold_sp5_v2019(S,N);
% th = TS_GetThreshold_sp8(S);
%
% ROI as rotate line profile is defined below length as default.
% Len = 70 ; % um , is xy-plane.
%  
%  see alo so , Sugashi_AutoAnalysisDiam, TS_AutoSEG_mex, Segment_Functions
% TS_AutoAnalysisDiam_AddAdjPreFWHM_perSlice  Group...

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
% And Time scope data(2D x Time data) has matrix in SEG.Pointdata.
% like n x m matrix mean that n is number of Point XYZ, m is Num. Time Slice 
% BTW, NewPointdata has 3rd axis as Time data...
%
% version 2020 Beta released 2020,19-29th Apr. by leo Sugashi Takuma
% In addition to the usual Input, the option was given to the User. 
% And, the measurement method by the normal line and the ellipse 
% approximation are added for speeding up.
% Ilustration. One said he disliked interpolation that it's making data.
% I could not think it. It just predicts from the observation data.
% Depending on the imaging conditions that take into account the frequency
% of measurement and PSF, there would be no way to make it unless aliasing caused it. 
% When I created a viewer for 3D with an analysis program suitable for 3D measurement, 
% then someone should adapt it to slice 4D data? 
% The Viewer is supposed to spit out Error. Should you speed it up? 
% What should I do if the conditions change? '
% I didn't come to get PhD to write a GENERAL PURPOSE program.
TIME = tic; %%edit 2020.08.11 Kusaka
siz = size(fImage,1:5);
if siz(5)>1
    error('Input Image has channels data(Dim 5 has more 1).')
end

%% for Volume and Time Data
if siz(3)>1 && siz(4)>1
    StartTic = tic;
    for k = 1:size(fImage,4)
        outputSlice = feval(mfilename,...
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
                output.Pointdata(nn).LineRotDiameter = ...
                    cat(2,output.Pointdata(nn).LineRotDiameter,...
                    outputSlice.Pointdata(nn).LineRotDiameter);
                output.Pointdata(nn).NormDiameter = ...
                    cat(2,output.Pointdata(nn).NormDiameter,...
                    outputSlice.Pointdata(nn).NormDiameter);
                output.Pointdata(nn).EllipticDiameter = ...
                    cat(2,output.Pointdata(nn).EllipticDiameter,...
                    outputSlice.Pointdata(nn).EllipticDiameter);
                
                output.Pointdata(nn).NewXYZ = ...
                    cat(3,output.Pointdata(nn).NewXYZ,...
                    outputSlice.Pointdata(nn).NewXYZ);                
                output.Pointdata(nn).NewXYZrot = ...
                    cat(3,output.Pointdata(nn).NewXYZrot,...
                    outputSlice.Pointdata(nn).NewXYZrot);                
                output.Pointdata(nn).NewXYZnor = ...
                    cat(3,output.Pointdata(nn).NewXYZnor,...
                    outputSlice.Pointdata(nn).NewXYZnor);                
                output.Pointdata(nn).NewXYZell = ...
                    cat(3,output.Pointdata(nn).NewXYZell,...
                    outputSlice.Pointdata(nn).NewXYZell);                
            end            
        end        
    end
    ppdata = [];
    output.DiameterAnalysisTime = toc(StartTic);
    return
end


%% input check 
if length(inReso)~=3
    error('Input Resolution Must be 3 length vector.')
end
Option = input_param(varargin{:});
function Option = input_param(varargin)
    %% default
    Option.ID = '>0'; %% must Be ">0",'all',or numeric
    Option.Progressbar ='on'; %% on or off
    Option.SNRLim = 2; %%[dB]
    Option.SNRUnit = 'dB'; %% if unit is [a.u.], will be calicualte
    Option.SNRLim_dB = []; %% program usage.
    Option.LineLength = 70;
    Option.NoiseType = 'Eachpoint'; %% mustBE EachPoint, Slice(if siz(3)==1), Numeric(==Constant)
    Option.NoiseArea = 100; % um, diameter
    Option.Noise = [];  %% program usage.
    TypeMustBe = {'LineRot','NormLine','Elliptic','Hybrid','LineRot&Elliptic','Speed','NormLine&Elliptic','All'};
    Option.MeasureType = 'LineRot'; 
    Option.ForceParfor = 'on'; %% on or off
    Option.MaximumStep = 512;
    %% input check
    for ni = 1:2:nargin
        switch lower(varargin{ni})
            case 'id'
                Option.ID = varargin{ni+1};
            case 'linelength'
                Option.LineLength = varargin{ni+1};
            case 'noisearea'
                Option.NoiseArea = varargin{ni+1};
            case {'progressbar','progress'}
                Option.Progressbar = varargin{ni+1};
                if ~max(strcmp(Option.Progressbar,{'on','off'}))
                    error('input option "Progressbar" is not correct')
                end
            case {'snrlim','lim','snr limit'}
                Option.SNRLim = varargin{ni+1};
                if ~isnumeric(Option.SNRLim)
                    error('input option "SNR Limit" is not correct( was not numetic)')
                end
            case {'snrunit','snr unit'}
                Option.SNRUnit = varargin{ni+1};
                if ~max(strcmp(Option.SNRUnit,{'dB','a.u.','[a.u.]'}))
                    error('input option "SNR Units" is not correct')
                end
            case {'noisetype','noise type'}
                Option.NoiseType = varargin{ni+1};
                if isnumeric(Option.NoiseType)
                    Option.NoiseType = 'Numeric';
                    Option.Noise = varargin{ni+1};
                end
%                 if
%                 ~or(max(strcmp(Option.NoiseType,{'EachPoint','Slice'})),isnumeric(Option.NoiseType))
%                 Edit 2020.08.11 Kusaka
                 if ~or(max(strcmp(Option.NoiseType,{'EachPoint','Slice'})),strcmpi(Option.NoiseType,'Numeric'))
                    error('input option "SNR Units" is not correct')
                end                
            case 'measuretype'
                Option.MeasureType = varargin{ni+1};
                if ~max(strcmp(Option.MeasureType,TypeMustBe))
                    error('Input Measure Type was not Correct.')
                end
            case 'forceparfor'
                Option.ForceParfor = varargin{ni+1}; %% on or off
            case 'maximumstep'                
                Option.MaximumStep = varargin{ni+1};
                if ~isnumeric(Option.MaximumStep)
                    error('Input of MaximumStep Option has to be NUMERIC')
                end
            otherwise
                error('input param has not correct. pls contact to Sugashi.')
        end
    end
    if strcmp('dB',Option.SNRUnit)
        Option.SNRLim_dB = Option.SNRLim;
    else
        Option.SNRLim_dB = 10*log10(Option.SNRLim);
    end
end

%% Main (for 3D or 4D)
global Len Reso NoiseArea
Reso = inReso;

%% start up
if strcmp(Option.Progressbar,'on')
    fprintf('Starting ... ')
    fprintf(mfilename)
    fprintf('\n')
end
%% ID check
Sf = Segment_Functions;
%%%%%  SEG = Sf.set_Segment(SEG);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(Option.ID,'>0')
    Number = cat(1,SEG.Pointdata.ID);
    Number = Number(Number>0);
elseif strcmp(Option.ID,'all')
    Number = cat(1,SEG.Pointdata.ID);
else
    Number = Option.ID;
end
Number = Sf.ID2Index(Number,cat(1,SEG.Pointdata.ID));
Number(isnan(Number)) = [];
%% method check
if ~max(strcmpi({'sp5','sp8','fwhm'},ThresholdType))
    warning(   mfilename('fullpath') )
    error('Input Threshold Type is Member of {"sp5"(=PMT), or "sp8"(=Photo Count)}')
end
%% each option( SNR limit, Line Length, Noise Area)
SNRth = Option.SNRLim_dB; % [dB]
Len = Option.LineLength; % Rotation Line Profile Length , Checking Axis Z Line Length
NoiseArea = Option.NoiseArea; % [um]
NoiseArea = (NoiseArea/Reso(1) +1 ) /2; % [pixels radius]
CropSize = ones(1,2)*(round(Len/Reso(1)/2)*2+1);

%% Add Pre FWHM
% This Process is to denoising in Near 3 point from center point
close_siz = round(3 / Reso(1));
close_siz = close_siz + double(eq(floor(close_siz/2),ceil(close_siz/2)));
se = ones(close_siz,3);
%% setup Noise Are and LineRotation Method 
[meshX,meshY,meshZ] = meshgrid(1:siz(2),1:siz(1),1);
[Xp,Yp,theta] = TS_GetLinePro2mesh(fImage(:,:,1),[0 0],Len,Reso);
LenEllipticNum = ceil(Len/Reso(1));
if ~IsOdd(LenEllipticNum)
    LenEllipticNum = LenEllipticNum + 1;
end
EllipticRad = floor(LenEllipticNum/2);
[Xe,Ye] = meshgrid(-EllipticRad:EllipticRad,-EllipticRad:EllipticRad);
CropCenter = [EllipticRad+1,EllipticRad+1];
Length_Limit = 2; %% um, to use limit elliptic analysis
%% set up parfor
PoolObj = gcp('nocreate');
if isempty(PoolObj) && strcmp(Option.ForceParfor,'on')
    PoolObj = parpool;
    NumWorker = PoolObj.NumWorkers;
else
    NumWorker = 1;
end
MaxNumel = max(numel( Xp )*2,prod(siz(1:2)));
SingleByte = 4;
MaximumUsableMemorySize = TS_checkmem('double')  - 2*2^30; % Gibi Bytes
EachStep = floor(MaximumUsableMemorySize / ( MaxNumel  * SingleByte * NumWorker^2 ));
EachStep = EachStep * NumWorker/4;
%  This value shoud be adjusted for ur server %%%%%%%%%%%%%%%%%%%%%%%%%%%%
EachStep = min(EachStep,Option.MaximumStep);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EachStep = max(EachStep,4);
%% class change for interpolation
fImage = single(fImage);

%% New version has input size = [n,m,z,1] or [n,m,1,t]
for n = 1:length(SEG.Pointdata)
    xyz = SEG.Pointdata(n).PointXYZ;
    len = size(xyz,1);
    Normal =  nan(len,siz(4),'like',single(1));
    pxyz =  nan(len,3,siz(4),'like',single(1));
    SEG.Pointdata(n).Signal =Normal;
    SEG.Pointdata(n).Noise = Normal;
    SEG.Pointdata(n).Diameter = Normal;%%%%%%%%%%%%%%%%
    SEG.Pointdata(n).LineRotDiameter = Normal;
    SEG.Pointdata(n).NormDiameter = Normal;
    SEG.Pointdata(n).EllipticDiameter = Normal;
    SEG.Pointdata(n).Theta = Normal;
    SEG.Pointdata(n).NewXYZ = pxyz;
    SEG.Pointdata(n).NewXYZrot = pxyz;
    SEG.Pointdata(n).NewXYZnor = pxyz;
    SEG.Pointdata(n).NewXYZell = pxyz;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Volume %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if siz(3)>1
    %% set up xyz data
    Pdata = SEG.Pointdata;
    xyz = double(cat(1,Pdata(Number).PointXYZ));
    SEGRESO = SEG.ResolutionXYZ;
    xyz = (xyz-1) .* SEGRESO; %% real size
    xyz = (xyz ./ Reso) + 1;  %% input fImage size
    indY = xyz(:,2);
    indX = xyz(:,1);
    indZ = xyz(:,3);
    NormThetaXY = cat(1,Pdata(Number).NormThetaXY);
    AnalysisShoudBeElliptic = cat(1,Pdata(Number).AnalysisShoudBeElliptic);
    %% check xyz size
    if or(min(indX)<1,max(indX)>size(fImage,2))
        warning('Input SEG Index Size over(less) than fImage (X-axis).')
    elseif or(min(indY)<1,max(indY)>size(fImage,1))
        warning('Input SEG Index Size over(less) than fImage (Y-axis).')
    elseif or(min(indZ)<1,max(indZ)>size(fImage,3))
        warning('Input SEG Index Size over(less) than fImage (Z-axis).')
    end
    %% set up piese point data
    TIME = tic;
    clear ppdata
    ppdata(1:length(indY)) = ...
        struct('XYZ',[],'Signal',[],'Noise',[],'Theta',[],...
        'LineRotDiameter',[],'NormDiameter',[],'EllipticDiameter',[],'Type',[],...
        'NewXYZrot',[],'NewXYZnor',[],'NewXYZell',[]); 
    %% Analysis Signal
    Signals = struct('Xq',[],'Yq',[],'Zq',[]);
    if strcmp(Option.Progressbar,'on')
        fprintf(' Analysis Signal (Createing mesh.)....')
    end
    parfor n = 1:length(indZ)
        [Xq,Yq,Zq] = GetSignalMesh(indX(n),indY(n),indZ(n),siz); %% interp make nan if outside index. u shoud do this step.
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
    if strcmp(Option.Progressbar,'on')
        fprintf(' Done\n')
    end
%% Analysis Noise and Measure Diameter
    if strcmp(Option.Progressbar,'on')
        fprintf('    Analysis Noise and Measure Diameter')
        fprintf(['   Numeric : ' num2str(length(indZ)) ', EachStep : ' num2str(EachStep) '\n'])
        TS_WaiteProgress(0)
    end
    NewStep = 1:EachStep:length(indZ);
    zdata = 1:length(indZ);
    cpIndY = indY;
    cpIndX = indX;
    cpIndZ = indZ;
    cpSignal = Shori;
    cpNormThetaXY = NormThetaXY;
    cpAnalysisShoudBeElliptic = AnalysisShoudBeElliptic;
    cpLineRotTF = cpAnalysisShoudBeElliptic;
    cpNormTF = cpAnalysisShoudBeElliptic;
    switch Option.MeasureType
        case 'LineRot'
            cpAnalysisShoudBeElliptic(:) = false;
            cpLineRotTF(:) = true;
            cpNormTF(:) = false;
        case 'NormLine'
            cpAnalysisShoudBeElliptic(:) = false;
            cpLineRotTF(:) = false;
            cpNormTF(:) = true;
        case 'Elliptic'
            cpAnalysisShoudBeElliptic(:) = true;
            cpLineRotTF(:) = false;
            cpNormTF(:) = false;
        case 'Hybrid'
            %cpAnalysisShoudBeElliptic(:) = false;
            cpLineRotTF(:) = ~cpAnalysisShoudBeElliptic;
            cpNormTF(:) = false;
        case 'Speed'
            %cpAnalysisShoudBeElliptic(:) = false;
            cpLineRotTF(:) = false;
            cpNormTF(:) = ~cpAnalysisShoudBeElliptic;
        case 'All'
            cpAnalysisShoudBeElliptic(:) = true;
            cpLineRotTF(:) = true;
            cpNormTF(:) = true;
        otherwise
            error('input Mesure Type is not correct')
    end
    
    for k = 1:length(NewStep)
        StepIndex = and(zdata >= NewStep(k) , zdata < NewStep(k) + EachStep);
        indY = cpIndY(StepIndex);
        indX = cpIndX(StepIndex);
        indZ = cpIndZ(StepIndex);
        Signal = cpSignal(StepIndex);
        Norm  = cpNormThetaXY(StepIndex);
        EllipticTF = cpAnalysisShoudBeElliptic(StepIndex);
        LineRotTF = cpLineRotTF(StepIndex);
        NormTF = cpNormTF(StepIndex);
        if isempty(indZ)
            continue
        end
        
        %% Interpolation numeric z dim, Matrix with each point in Dimmention 3 
        % Analysis Noise
        if ~strcmp(Option.NoiseType,'Numeric')
             SliceImage(1:length(indZ)) = struct('Xq',[],'Yq',[],'Zq',[]);
            parfor n = 1:length(indZ)
                SliceImage(n).Xq = meshX;
                SliceImage(n).Yq = meshY;
                SliceImage(n).Zq =  repmat(indZ(n),size(meshZ));
            end
            Xq = cat(3,SliceImage.Xq);
            Yq = cat(3,SliceImage.Yq);
            Zq = cat(3,SliceImage.Zq);
            parImage = interp3(fImage,Xq,Yq,Zq, 'bilinear');
            clear SliceImage Xq Yq Zq
            SliceImage(1:length(indZ)) = struct('Noise',[]);
            parfor n = 1:length(indZ)  
                im = parImage(:,:,n);
                rX = meshX - indX(n);
                rY = meshY - indY(n);
                rArea = sqrt(rX.^2 + rY.^2) <=NoiseArea;        
                im = im(rArea);
                currentN = TS_GetBackgroundValue(im);
                SliceImage(n).Noise = single(currentN);
            end    
            Noise = cat(2,SliceImage.Noise);
            clear SliceImage
        else
            Noise = repmat(Option.Noise,[1 length(indZ)]);
        end
        %% Defain Threshold
        CorrectedThreshold = nan(length(indZ),1);                
        if strcmpi(ThresholdType,'sp5')
            for n = 1:length(indZ)
                CorrectedThreshold(n) = TS_GetThreshold_sp5_v2019(...
                    Signal(n),Noise(n));
            end
        elseif strcmpi(ThresholdType,'sp8')
            for n = 1:length(indZ)
                CorrectedThreshold(n) = TS_GetThreshold_sp8(...
                    Signal(n));
            end
        elseif strcmpi(ThresholdType,'fwhm')
            CorrectedThreshold(:) = 0.5;
        end
        %% Analysis Limit
        SNR = Signal./max(Noise,1);
        SNRTF = SNRth <= 10*log10(SNR);
            
        %% . set up All Measure Type %%%%%%%%%%%%%%%%%%%%%%%%%%
        clear parpdata
        parpdata(1:length(indZ)) = struct('XYZ',[],'Theta',[],...
            'Signal',[],'Noise',[],'ThCorrectedWidth',[],...
            'LineRotDiameter',[],'NormDiameter',[],'EllipticDiameter',[],...
            'Type',[],'NewXYZrot',[],'NewXYZnor',[],'NewXYZell',[]);
        for n = 1:length(indZ)
            parpdata(n).Signal = Signal(n);
            parpdata(n).Noise = Noise(n);
            parpdata(n).XYZ = [indX(n), indY(n), indZ(n)];
        end
        %% For Rotation Line
        if max(strcmp(Option.MeasureType,{'LineRot','Hybrid','All'}))
            SliceImage(1:sum(LineRotTF)) = struct('Xq',[],'Yq',[],'Zq',[]);
            LineRotInd = find(LineRotTF);
            LineRotDiameter = nan(1,length(LineRotInd));
            LineRotTheta = LineRotDiameter;
            LineRotNewXYZ = nan(length(LineRotInd),3);
            %% make matrix for parfor
            parfor n = 1:length(LineRotInd)
                SliceImage(n).Xq = Xp + indX(LineRotInd(n));
                SliceImage(n).Yq = Yp + indY(LineRotInd(n));
                SliceImage(n).Zq = repmat(indZ(LineRotInd(n)),size(Xp));
            end
            Xq = cat(3,SliceImage.Xq);
            Yq = cat(3,SliceImage.Yq);
            Zq = cat(3,SliceImage.Zq);
            parImage = interp3(fImage,Xq,Yq,Zq, 'bilinear');
            clear Xq Yq Zq SliceImage      
            %% main for rotation line profile to Width
            parfor n = 1:length(LineRotInd)
                nS = double(Signal(n));
                nN = double(Noise(n));
                fwhm = zeros(length(theta),2);
                %% Normalize vpmatrix
                vpmatrix = parImage(:,:,n);
                vpmatrix = double(vpmatrix);
                vpmatrix = (vpmatrix-nN)/(nS-nN);
                vpmatrix = max(vpmatrix,0);
                % This Process is to denoising in Near 3 point from center point
                % pre_vpmatrix = vpmatrix;
                vpmatrix(round(size(vpmatrix,1)/2),:) = 1;
                L = bwlabel(vpmatrix>CorrectedThreshold(n),8);
                CenterLabel = L(round(size(vpmatrix,1)/2),1);
                TF = and( CenterLabel>0, SNRth < 10*log10(nS/nN));
                if TF
                    bw_vp = L==CenterLabel;
                    % % This process is to analys High Noise data ,but High SNR is not neccaaary
                    bw_vp = imclose(bw_vp,se);
                    bw_vp = imerode(bw_vp,ones(3,1)); %
                    vpmatrix(bw_vp) =  max(vpmatrix(bw_vp),CorrectedThreshold(n)); %
                    fwhm = TS_FWHM2019(vpmatrix,CorrectedThreshold(n));
                    RotWidth = diff(fwhm,[],2);
                    [PixDiam,Ind] = min(RotWidth);
                    Ind = Ind(1);
                    %% output NEW Position
                    vpX = Xp + indX(n);
                    vpY = Yp + indY(n);
                    newx = vpX(:,Ind);
                    newy = vpY(:,Ind);
                    newind = mean(fwhm(Ind,:));
                    newx = interp1(newx,newind,'linear');
                    newy = interp1(newy,newind,'linear');
                    newz = indZ(n);    
                    %% output for parpdata                        
                    LineRotTheta(n) = theta(Ind);                    
                    LineRotDiameter(n) = PixDiam;
                    LineRotNewXYZ(n,:) = [newx newy newz];
                end
            end
            %% output
            for n = 1:length(LineRotInd)
                parpdata(LineRotInd(n)).Theta = LineRotTheta(n);
                parpdata(LineRotInd(n)).LineRotDiameter = LineRotDiameter(n);
                parpdata(LineRotInd(n)).NewXYZrot = LineRotNewXYZ(n,:);        
            end    
        end
        %% For Norm Line
        if max(strcmp(Option.MeasureType,{'NormLine','Speed','All'}))            
            SliceImage(1:sum(NormTF)) = struct('Xq',[],'Yq',[],'Zq',[]);            
            NormInd = find(NormTF);
            
            NormDiameter = nan(1,length(NormInd));
            parfor n = 1:length(NormInd)
                [Xp,Yp] = Sf.GetThetaIndex(...
                    [indX(NormInd(n)),indY(NormInd(n)),indZ(NormInd(n))],...
                    Norm(NormInd(n)),Len,Reso(1));
                SliceImage(n).Xq = Xp(:);
                SliceImage(n).Yq = Yp(:);
                SliceImage(n).Zq = repmat(indZ(n),size(Xp(:)));
            end
            Xq = cat(2,SliceImage.Xq);
            Yq = cat(2,SliceImage.Yq);
            Zq = cat(2,SliceImage.Zq);
            parImage = interp3(fImage,Xq,Yq,Zq, 'bilinear');
            clear Zq SliceImage       
            
            %% normalize and Get Threshold
            for n = 1:length(NormInd)                                
                %% Normalize vpmatrix
                Sl = Signal(NormInd(n));
                Nl = Noise(NormInd(n));
                Line = parImage(:,n);
                Line = double(Line);
                Line = (Line-Nl)/(Sl-Nl);
                Line = max(Line,0);
                parImage(:,n) = single(Line);
            end
            
            % This Process is to denoising in Near 3 point from center point
            % pre_vpmatrix = vpmatrix;
            if ~isempty(NormInd)
                parImage(ceil(size(parImage,1)/2),1) = 1;            
                fwhm = TS_FWHM2019(parImage,CorrectedThreshold);
                DiffFWHM = diff(fwhm,[],2);
            end
            for n = 1:length(NormInd)
                if SNRTF(NormInd(n))
                    %% output NEW Position
                    vpX = Xq(:,n) + indX(NormInd(n));
                    vpY = Yq(:,n) + indY(NormInd(n));
                    newx = vpX;
                    newy = vpY;
                    newind = DiffFWHM(n);
                    newx = interp1(newx,newind,'linear');
                    newy = interp1(newy,newind,'linear');
                    newz = indZ(n);    
                    %% output for parpdata
                    parpdata(NormInd(n)).NormDiameter = DiffFWHM(n);
                    parpdata(n).NewXYZnor = [newx newy newz];        
                else
                    %% output for parpdata
                    parpdata(NormInd(n)).NormDiameter = nan;
                    parpdata(n).NewXYZnor = [indX(n), indY(n), indZ(n)];        
                end
            end       
        end
        %% For Elliptic Analysis
        if max(strcmp(Option.MeasureType,{'Elliptic','Hybrid','Speed','All'}))
            clear SliceImage
            SliceImage(1:sum(EllipticTF)) = struct('Xq',[],'Yq',[],'Zq',[]);
            EllipticInd = find(EllipticTF);
            EllipticDiameter = nan(1,length(EllipticInd));
            NewXYZell = nan(length(EllipticInd),3);
            parfor n = 1:length(EllipticInd)                
                SliceImage(n).Xq = Xe+indX(EllipticInd(n));
                SliceImage(n).Yq = Ye+indY(EllipticInd(n));
                SliceImage(n).Zq = repmat(indZ(EllipticInd(n)),size(Xe));
            end
            Xq = cat(3,SliceImage.Xq);
            Yq = cat(3,SliceImage.Yq);
            Zq = cat(3,SliceImage.Zq);
            parImage = interp3(fImage,Xq,Yq,Zq, 'bilinear');
            clear Xq Yq Zq SliceImage       
            %% bainalize and Elliptic Analysis
            for n = 1:size(parImage,3)
                im = parImage(:,:,n);
                im = (im- Noise(EllipticInd(n)))/...
                    (Signal(EllipticInd(n))-Noise(EllipticInd(n)));                
                bw = im >=CorrectedThreshold(EllipticInd(n));
                bw = imclose(bw,se);
                [BW,~] = FindNearestObj(bw,CropCenter,Reso,Length_Limit);
                s = regionprops(BW,'Centroid','MinorAxisLength','MajorAxisLength','Area');
                    
                TF = SNRTF(EllipticInd(n)) && length(s)==1;
                if TF
                    Ediam = s.MinorAxisLength;
                    newx = indX(EllipticInd(n)) + (s.Centroid(1)-CropCenter(2));
                    newy = indY(EllipticInd(n)) + (s.Centroid(2)-CropCenter(1));
                    newz = indZ(EllipticInd(n));
                    EllipticDiameter(n)= Ediam;                    
                    NewXYZell(n,:) = [newx newy newz];
                else                    
                end
            end
            for n = 1:length(EllipticInd)
                parpdata(EllipticInd(n)).EllipticDiameter = EllipticDiameter(n);
                parpdata(EllipticInd(n)).NewXYZell = NewXYZell(n,:);
            end
        end
       %% Witing pdata
        pind = find(StepIndex);
        for n = 1:length(pind)
            ppdata(pind(n)).XYZ = parpdata(n).XYZ;
            ppdata(pind(n)).Signal = parpdata(n).Signal;
            ppdata(pind(n)).Noise =  parpdata(n).Noise;
            ppdata(pind(n)).Theta = parpdata(n).Theta;
            ppdata(pind(n)).LineRotDiameter = parpdata(n).LineRotDiameter;
            ppdata(pind(n)).NormDiameter = parpdata(n).NormDiameter;
            ppdata(pind(n)).EllipticDiameter = parpdata(n).EllipticDiameter;
            ppdata(pind(n)).Type = parpdata(n).Type;
            ppdata(pind(n)).NewXYZrot = parpdata(n).NewXYZrot;
            ppdata(pind(n)).NewXYZnor = parpdata(n).NewXYZnor;
            ppdata(pind(n)).NewXYZell = parpdata(n).NewXYZell;
        end
        if strcmp(Option.Progressbar,'on')
            TS_WaiteProgress(k/length(NewStep))
        end
    end
    %% reshape output data to SEG structure.
    if strcmp(Option.Progressbar,'on')
        fprintf('\n  Reshape output data to SEG structure...')
    end
    c = 1;
    for Nind = 1:length(Number)
        xyz = SEG.Pointdata(Number(Nind)).PointXYZ;
        Signal = zeros(size(xyz,1),1,'like',single(1));    
        Noise = Signal;
        LineRotDiameter = Signal;
        NormDiameter = Signal;
        EllipticDiameter = Signal;
        Theta = Signal;
        NewXYZrot = double(cat(2,Signal,Signal,Signal));    
        NewXYZnor = NewXYZrot;
        NewXYZell = NewXYZrot;
        for k = 1:size(xyz,1)
            Signal(k) = EmptyCheck(ppdata(c).Signal,1);
            Noise(k) = EmptyCheck(ppdata(c).Noise,1);
            LineRotDiameter(k) = EmptyCheck(ppdata(c).LineRotDiameter * Reso(1) ,1);
            NormDiameter(k) = EmptyCheck(ppdata(c).NormDiameter * Reso(1),1);
            EllipticDiameter(k) = EmptyCheck(ppdata(c).EllipticDiameter * Reso(1),1);
            Theta(k) = EmptyCheck(ppdata(c).Theta,1);
            NewXYZrot(k,:) = EmptyCheck(ppdata(c).NewXYZrot,3);
            NewXYZnor(k,:) = EmptyCheck(ppdata(c).NewXYZnor,3);
            NewXYZell(k,:) = EmptyCheck(ppdata(c).NewXYZell,3);
            c = c +1;
        end
        SEG.Pointdata(Number(Nind)).Signal = single(Signal);
        SEG.Pointdata(Number(Nind)).Noise = single(Noise);
        SEG.Pointdata(Number(Nind)).Diameter = single(LineRotDiameter);%%%%%%%%%%%%%%%%
        SEG.Pointdata(Number(Nind)).LineRotDiameter = single(LineRotDiameter);
        SEG.Pointdata(Number(Nind)).NormDiameter = single(NormDiameter);
        SEG.Pointdata(Number(Nind)).EllipticDiameter = single(EllipticDiameter);
        SEG.Pointdata(Number(Nind)).Theta = single(Theta);
        NewXYZrot = (NewXYZrot -1 ) .* Reso;
        NewXYZrot = (NewXYZrot ./ SEGRESO ) + 1;
        NewXYZnor = (NewXYZnor -1 ) .* Reso;
        NewXYZnor = (NewXYZnor ./ SEGRESO ) + 1;
        NewXYZell = (NewXYZell -1 ) .* Reso;
        NewXYZell = (NewXYZell ./ SEGRESO ) + 1;
        SEG.Pointdata(Number(Nind)).NewXYZ = single(NewXYZrot);
        SEG.Pointdata(Number(Nind)).NewXYZrot = single(NewXYZrot);
        SEG.Pointdata(Number(Nind)).NewXYZnor = single(NewXYZnor);
        SEG.Pointdata(Number(Nind)).NewXYZell = single(NewXYZell);
    end
elseif siz(4)>1
    %% set up xyz data
    Pdata = SEG.Pointdata;
    xyz = double(cat(1,Pdata(Number).PointXYZ));
    SEGRESO = SEG.ResolutionXYZ;
    xyz = (xyz-1) .* SEGRESO; %% real size
    xyz = (xyz ./ Reso) + 1;  %% input fImage size
    indY = xyz(:,2);
    indX = xyz(:,1);
    indZ = ones(size(indY));
    NormThetaXY = cat(1,Pdata(Number).NormThetaXY);
    AnalysisShoudBeElliptic = cat(1,Pdata(Number).AnalysisShoudBeElliptic);
    %% check xyz size
    if or(min(indX)<1,max(indX)>size(fImage,2))
        warning('Input SEG Index Size over(less) than fImage (X-axis).')
    elseif or(min(indY)<1,max(indY)>size(fImage,1))
        warning('Input SEG Index Size over(less) than fImage (Y-axis).')
    end
    %% set up piese point data
    TIME = tic;
    clear ppdata
    ppdata(1:length(indY)) = ...
        struct('XYZ',[],'Signal',[],'Noise',[],'Theta',[],...
        'LineRotDiameter',[],'NormDiameter',[],'EllipticDiameter',[],'Type',[],...
        'NewXYZrot',[],'NewXYZnor',[],'NewXYZell',[]); 
    %% Analysis Signal
    Signals = struct('Xq',[],'Yq',[]);
    if strcmp(Option.Progressbar,'on')
        fprintf(' Analysis Signal (Createing mesh.)....')
    end
    parfor n = 1:length(indZ)
        [Xq,Yq,~] = GetSignalMesh(indX(n),indY(n),indZ(n),siz); %% interp make nan if outside index. u shoud do this step.
        Signals(n).Xq = Xq(:);
        Signals(n).Yq = Yq(:);
    end
    Xq = cat(2,Signals.Xq);
    Yq = cat(2,Signals.Yq);
    Shori = nan(length(indY),siz(4));
    parfor k = 1:siz(4)
        ShoriSlice = interp2(fImage(:,:,:,k),Xq,Yq,'bilinear');
        ss = nanmean(ShoriSlice,1);
        Shori(:,k) = ss(:);
    end
    clear Signals Xq Yq Zq ss ShoriSlice
    if strcmp(Option.Progressbar,'on')
        fprintf(' Done\n')
    end
%% Analysis Noise and Measure Diameter
    if strcmp(Option.Progressbar,'on')
        fprintf('    Analysis Noise and Measure Diameter')
        fprintf(['   Numeric : ' num2str(length(indZ)) ', EachStep : ' num2str(EachStep) '\n'])
        TS_WaiteProgress(0)
    end
    NewStep = 1:EachStep:length(indZ);
    cpIndY = indY;
    cpIndX = indX;
    cpIndZ = indZ;
    cpSignal = Shori;
    cpNormThetaXY = NormThetaXY;
    cpAnalysisShoudBeElliptic = AnalysisShoudBeElliptic;
    cpLineRotTF = cpAnalysisShoudBeElliptic;
    cpNormTF = cpAnalysisShoudBeElliptic;
    switch Option.MeasureType
        case 'LineRot'
            cpAnalysisShoudBeElliptic(:) = false;
            cpLineRotTF(:) = true;
            cpNormTF(:) = false;
        case 'NormLine'
            cpAnalysisShoudBeElliptic(:) = false;
            cpLineRotTF(:) = false;
            cpNormTF(:) = true;
        case 'Elliptic'
            cpAnalysisShoudBeElliptic(:) = true;
            cpLineRotTF(:) = false;
            cpNormTF(:) = false;
        case 'Hybrid'
            %cpAnalysisShoudBeElliptic(:) = false;
            cpLineRotTF(:) = ~cpAnalysisShoudBeElliptic;
            cpNormTF(:) = false;
        case 'Speed'
            %cpAnalysisShoudBeElliptic(:) = false;
            cpLineRotTF(:) = false;
            cpNormTF(:) = ~cpAnalysisShoudBeElliptic;
        case 'All'
            cpAnalysisShoudBeElliptic(:) = true;
            cpLineRotTF(:) = true;
            cpNormTF(:) = true;
        otherwise
            error('input Mesure Type is not correct')
    end
    
    for k = 1:siz(4) %length(NewStep)
        indY = cpIndY;
        indX = cpIndX;
        indZ = cpIndZ;
        Signal = cpSignal(:,k);
        Norm  = cpNormThetaXY;
        EllipticTF = cpAnalysisShoudBeElliptic;
        LineRotTF = cpLineRotTF;
        NormTF = cpNormTF;
        %% Interpolation numeric z dim, Matrix with each point in Dimmention 3 
        % Analysis Noise
        if ~strcmp(Option.NoiseType,'Numeric')
            SliceImage(1:length(indZ)) = struct('Noise',[]);
            pIm = fImage(:,:,:,k);
            parfor n = 1:length(indZ)  
                im = pIm;
                rX = meshX - indX(n);
                rY = meshY - indY(n);
                rArea = sqrt(rX.^2 + rY.^2) <=NoiseArea;        
                im = im(rArea);
                currentN = TS_GetBackgroundValue(im);
                SliceImage(n).Noise = single(currentN);
            end    
            Noise = cat(1,SliceImage.Noise);
            clear SliceImage
        else
            Noise = repmat(Option.Noise,[length(indZ),1]);
        end
        %% Defain Threshold
        CorrectedThreshold = nan(length(indZ),1);                
        if strcmpi(ThresholdType,'sp5')
            for n = 1:length(indZ)
                CorrectedThreshold(n) = TS_GetThreshold_sp5_v2019(...
                    Signal(n),Noise(n));
            end
        elseif strcmpi(ThresholdType,'sp8')
            for n = 1:length(indZ)
                CorrectedThreshold(n) = TS_GetThreshold_sp8(...
                    Signal(n),Noise(n));
            end
        elseif strcmpi(ThresholdType,'fwhm')
            CorrectedThreshold(:) = 0.5;
        end
        %% Analysis Limit
        SNR = Signal./max(Noise,1);
        SNRTF = SNRth <= 10*log10(SNR);
            
        %% . set up All Measure Type %%%%%%%%%%%%%%%%%%%%%%%%%%
        clear parpdata
        parpdata(1:length(indZ)) = struct('XYZ',[],'Theta',[],...
            'Signal',[],'Noise',[],'ThCorrectedWidth',[],...
            'LineRotDiameter',[],'NormDiameter',[],'EllipticDiameter',[],...
            'Type',[],'NewXYZrot',[],'NewXYZnor',[],'NewXYZell',[]);
        for n = 1:length(indZ)
            parpdata(n).Signal = Signal(n);
            parpdata(n).Noise = Noise(n);
            parpdata(n).XYZ = [indX(n), indY(n), indZ(n)];
        end
        %% For Rotation Line
        if max(strcmp(Option.MeasureType,{'LineRot','Hybrid','All'}))
            SliceImage(1:sum(LineRotTF)) = struct('Xq',[],'Yq',[],'Zq',[]);
            LineRotInd = find(LineRotTF);
            LineRotDiameter = nan(1,length(LineRotInd));
            LineRotTheta = LineRotDiameter;
            LineRotNewXYZ = nan(length(LineRotInd),3);
            %% make matrix for parfor
            parfor n = 1:length(LineRotInd)
                SliceImage(n).Xq = Xp + indX(LineRotInd(n));
                SliceImage(n).Yq = Yp + indY(LineRotInd(n));
            end
            Xq = cat(3,SliceImage.Xq);
            Yq = cat(3,SliceImage.Yq);
            parImage = interp2(fImage(:,:,:,k),Xq,Yq, 'bilinear');
            clear Xq Yq Zq SliceImage      
            %% main for rotation line profile to Width
            parfor n = 1:length(LineRotInd)
                nS = double(Signal(n));
                nN = double(Noise(n));
                fwhm = zeros(length(theta),2);
                %% Normalize vpmatrix
                vpmatrix = parImage(:,:,n);
                vpmatrix = double(vpmatrix);
                vpmatrix = (vpmatrix-nN)/(nS-nN);
                vpmatrix = max(vpmatrix,0);
                % This Process is to denoising in Near 3 point from center point
                % pre_vpmatrix = vpmatrix;
                vpmatrix(round(size(vpmatrix,1)/2),:) = 1;
                L = bwlabel(vpmatrix>CorrectedThreshold(n),8);
                CenterLabel = L(round(size(vpmatrix,1)/2),1);
                TF = and( CenterLabel>0, SNRth < 10*log10(nS/nN));
                if TF
                    bw_vp = L==CenterLabel;
                    % % This process is to analys High Noise data ,but High SNR is not neccaaary
                    bw_vp = imclose(bw_vp,se);
                    bw_vp = imerode(bw_vp,ones(3,1)); %
                    vpmatrix(bw_vp) =  max(vpmatrix(bw_vp),CorrectedThreshold(n)); %
                    fwhm = TS_FWHM2019(vpmatrix,CorrectedThreshold(n));
                    RotWidth = diff(fwhm,[],2);
                    [PixDiam,Ind] = min(RotWidth);
                    Ind = Ind(1);
                    %% output NEW Position
                    vpX = Xp + indX(n);
                    vpY = Yp + indY(n);
                    newx = vpX(:,Ind);
                    newy = vpY(:,Ind);
                    newind = mean(fwhm(Ind,:));
                    newx = interp1(newx,newind,'linear');
                    newy = interp1(newy,newind,'linear');
                    newz = indZ(n);    
                    %% output for parpdata                        
                    LineRotTheta(n) = theta(Ind);                    
                    LineRotDiameter(n) = PixDiam;
                    LineRotNewXYZ(n,:) = [newx newy newz];
                end
            end
            %% output
            for n = 1:length(LineRotInd)
                parpdata(LineRotInd(n)).Theta = LineRotTheta(n);
                parpdata(LineRotInd(n)).LineRotDiameter = LineRotDiameter(n);
                parpdata(LineRotInd(n)).NewXYZrot = LineRotNewXYZ(n,:);        
            end    
        end
        %% For Norm Line
        if max(strcmp(Option.MeasureType,{'NormLine','Speed','All'}))            
            SliceImage(1:sum(NormTF)) = struct('Xq',[],'Yq',[],'Zq',[]);            
            NormInd = find(NormTF);
            
            NormDiameter = nan(1,length(NormInd));
            parfor n = 1:length(NormInd)
                [Xp,Yp] = Sf.GetThetaIndex(...
                    [indX(NormInd(n)),indY(NormInd(n)),indZ(NormInd(n))],...
                    Norm(NormInd(n)),Len,Reso(1));
                SliceImage(n).Xq = Xp(:);
                SliceImage(n).Yq = Yp(:);
            end
            Xq = cat(2,SliceImage.Xq);
            Yq = cat(2,SliceImage.Yq);
            parImage = interp2(fImage(:,:,:,k),Xq,Yq, 'bilinear');
            clear Zq SliceImage       
            
            %% normalize and Get Threshold
            for n = 1:length(NormInd)                                
                %% Normalize vpmatrix
                Sl = Signal(NormInd(n));
                Nl = Noise(NormInd(n));
                Line = parImage(:,n);
                Line = double(Line);
                Line = (Line-Nl)/(Sl-Nl);
                Line = max(Line,0);
                parImage(:,n) = single(Line);
            end
            
            % This Process is to denoising in Near 3 point from center point
            % pre_vpmatrix = vpmatrix;
            if ~isempty(NormInd)
                parImage(ceil(size(parImage,1)/2),1) = 1;            
                fwhm = TS_FWHM2019(parImage,CorrectedThreshold);
                DiffFWHM = diff(fwhm,[],2);
            end
            for n = 1:length(NormInd)
                if SNRTF(NormInd(n))
                    %% output NEW Position
                    vpX = Xq(:,n) + indX(NormInd(n));
                    vpY = Yq(:,n) + indY(NormInd(n));
                    newx = vpX;
                    newy = vpY;
                    newind = DiffFWHM(n);
                    newx = interp1(newx,newind,'linear');
                    newy = interp1(newy,newind,'linear');
                    newz = indZ(n);    
                    %% output for parpdata
                    parpdata(NormInd(n)).NormDiameter = DiffFWHM(n);
                    parpdata(n).NewXYZnor = [newx newy newz];        
                else
                    %% output for parpdata
                    parpdata(NormInd(n)).NormDiameter = nan;
                    parpdata(n).NewXYZnor = [indX(n), indY(n), indZ(n)];        
                end
            end       
        end
        %% For Elliptic Analysis
        if max(strcmp(Option.MeasureType,{'Elliptic','Hybrid','Speed','All'}))
            clear SliceImage
            SliceImage(1:sum(EllipticTF)) = struct('Xq',[],'Yq',[],'Zq',[]);
            EllipticInd = find(EllipticTF);
            EllipticDiameter = nan(1,length(EllipticInd));
            NewXYZell = nan(length(EllipticInd),3);
            parfor n = 1:length(EllipticInd)                
                SliceImage(n).Xq = Xe+indX(EllipticInd(n));
                SliceImage(n).Yq = Ye+indY(EllipticInd(n));
            end
            Xq = cat(3,SliceImage.Xq);
            Yq = cat(3,SliceImage.Yq);
            parImage = interp2(fImage(:,:,:,k),Xq,Yq, 'bilinear');
            clear Xq Yq Zq SliceImage       
            %% bainalize and Elliptic Analysis
            for n = 1:size(parImage,3)
                im = parImage(:,:,n);
                im = (im- Noise(EllipticInd(n)))/...
                    (Signal(EllipticInd(n))-Noise(EllipticInd(n)));                
                bw = im >=CorrectedThreshold(EllipticInd(n));
                bw = imclose(bw,se);
                [BW,~] = FindNearestObj(bw,CropCenter,Reso,Length_Limit);
                s = regionprops(BW,'Centroid','MinorAxisLength','MajorAxisLength','Area');
                    
                TF = SNRTF(EllipticInd(n)) && length(s)==1;
                if TF
                    Ediam = s.MinorAxisLength;
                    newx = indX(EllipticInd(n)) + (s.Centroid(1)-CropCenter(2));
                    newy = indY(EllipticInd(n)) + (s.Centroid(2)-CropCenter(1));
                    newz = indZ(EllipticInd(n));
                    EllipticDiameter(n)= Ediam;                    
                    NewXYZell(n,:) = [newx newy newz];
                else                    
                end
            end
            for n = 1:length(EllipticInd)
                parpdata(EllipticInd(n)).EllipticDiameter = EllipticDiameter(n);
                parpdata(EllipticInd(n)).NewXYZell = NewXYZell(n,:);
            end
        end
       %% Witing pdata
       c = 1;
       for Nind = 1:length(Number)
           xyz = SEG.Pointdata(Number(Nind)).PointXYZ;
           Signal = zeros(size(xyz,1),1,'like',single(1));    
           Noise = Signal;
           LineRotDiameter = Signal;
           NormDiameter = Signal;
           EllipticDiameter = Signal;
           Theta = Signal;
           NewXYZrot = double(cat(2,Signal,Signal,Signal));    
           NewXYZnor = NewXYZrot;
           NewXYZell = NewXYZrot;
           for kt = 1:size(xyz,1)
               Signal(kt) = EmptyCheck(parpdata(c).Signal,1);
               Noise(kt) = EmptyCheck(parpdata(c).Noise,1);
               LineRotDiameter(kt) = EmptyCheck(parpdata(c).LineRotDiameter * Reso(1) ,1);
               NormDiameter(kt) = EmptyCheck(parpdata(c).NormDiameter * Reso(1),1);
               EllipticDiameter(kt) = EmptyCheck(parpdata(c).EllipticDiameter * Reso(1),1);
               Theta(kt) = EmptyCheck(parpdata(c).Theta,1);
               NewXYZrot(kt,:) = EmptyCheck(parpdata(c).NewXYZrot,3);
               NewXYZnor(kt,:) = EmptyCheck(parpdata(c).NewXYZnor,3);
               NewXYZell(kt,:) = EmptyCheck(parpdata(c).NewXYZell,3);
               c = c +1;
           end
           SEG.Pointdata(Number(Nind)).Signal(:,k) = single(Signal);
           SEG.Pointdata(Number(Nind)).Noise(:,k) = single(Noise);
           SEG.Pointdata(Number(Nind)).Diameter(:,k) = single(LineRotDiameter);%%%%%%%%%%%%%%%%
           SEG.Pointdata(Number(Nind)).LineRotDiameter(:,k) = single(LineRotDiameter);
           SEG.Pointdata(Number(Nind)).NormDiameter(:,k) = single(NormDiameter);
           SEG.Pointdata(Number(Nind)).EllipticDiameter(:,k) = single(EllipticDiameter);
           SEG.Pointdata(Number(Nind)).Theta(:,k) = single(Theta);
           NewXYZrot = (NewXYZrot -1 ) .* Reso;
           NewXYZrot = (NewXYZrot ./ SEGRESO ) + 1;
           NewXYZnor = (NewXYZnor -1 ) .* Reso;
           NewXYZnor = (NewXYZnor ./ SEGRESO ) + 1;
           NewXYZell = (NewXYZell -1 ) .* Reso;
           NewXYZell = (NewXYZell ./ SEGRESO ) + 1;
           SEG.Pointdata(Number(Nind)).NewXYZ(:,:,k) = single(NewXYZrot);
           SEG.Pointdata(Number(Nind)).NewXYZrot(:,:,k) = single(NewXYZrot);
           SEG.Pointdata(Number(Nind)).NewXYZnor(:,:,k) = single(NewXYZnor);
           SEG.Pointdata(Number(Nind)).NewXYZell(:,:,k) = single(NewXYZell);
       end
       if strcmp(Option.Progressbar,'on')
           TS_WaiteProgress(k/siz(4))
       end
    end
elseif ismatrix(fImage)
        %% set up xy data
    Pdata = SEG.Pointdata;
    xyz = double(cat(1,Pdata(Number).PointXYZ));
    SEGRESO = SEG.ResolutionXYZ;
    xyz = (xyz-1) .* SEGRESO; %% real size
    xyz = (xyz ./ Reso) + 1;  %% input fImage size
    indY = xyz(:,2);
    indX = xyz(:,1);
    indZ = ones(size(indY));
    NormThetaXY = cat(1,Pdata(Number).NormThetaXY);
    AnalysisShoudBeElliptic = cat(1,Pdata(Number).AnalysisShoudBeElliptic);
    %% check xy size
    if or(min(indX)<1,max(indX)>size(fImage,2))
        warning('Input SEG Index Size over(less) than fImage (X-axis).')
    elseif or(min(indY)<1,max(indY)>size(fImage,1))
        warning('Input SEG Index Size over(less) than fImage (Y-axis).')
    end
    %% set up piese point data
    TIME = tic;
    clear ppdata
    ppdata(1:length(indY)) = ...
        struct('XYZ',[],'Signal',[],'Noise',[],'Theta',[],...
        'LineRotDiameter',[],'NormDiameter',[],'EllipticDiameter',[],'Type',[],...
        'NewXYZrot',[],'NewXYZnor',[],'NewXYZell',[]); 
    %% Analysis Signal
    Signals = struct('Xq',[],'Yq',[]);
    if strcmp(Option.Progressbar,'on')
        fprintf(' Analysis Signal (Createing mesh.)....')
    end
    parfor n = 1:length(indZ)
        [Xq,Yq,~] = GetSignalMesh(indX(n),indY(n),indZ(n),siz); %% interp make nan if outside index. u shoud do this step.
        Signals(n).Xq = Xq(:);
        Signals(n).Yq = Yq(:);
    end
    Xq = cat(2,Signals.Xq);
    Yq = cat(2,Signals.Yq);
    Shori = nan(length(indY),siz(4));
    parfor k = 1:siz(4)
        ShoriSlice = interp2(fImage(:,:,:,k),Xq,Yq,'bilinear');
        ss = nanmean(ShoriSlice,1);
        Shori(:,k) = ss(:);
    end
    clear Signals Xq Yq Zq ss ShoriSlice
    if strcmp(Option.Progressbar,'on')
        fprintf(' Done\n')
    end
%% Analysis Noise and Measure Diameter
    if strcmp(Option.Progressbar,'on')
        fprintf('    Analysis Noise and Measure Diameter')
        fprintf(['   Numeric : ' num2str(length(indZ)) ', EachStep : ' num2str(EachStep) '\n'])
        TS_WaiteProgress(0)
    end
    NewStep = 1:EachStep:length(indZ);
    cpIndY = indY;
    cpIndX = indX;
    cpIndZ = indZ;
    cpSignal = Shori;
    cpNormThetaXY = NormThetaXY;
    cpAnalysisShoudBeElliptic = AnalysisShoudBeElliptic;
    cpLineRotTF = cpAnalysisShoudBeElliptic;
    cpNormTF = cpAnalysisShoudBeElliptic;
    switch Option.MeasureType
        case 'LineRot'
            cpAnalysisShoudBeElliptic(:) = false;
            cpLineRotTF(:) = true;
            cpNormTF(:) = false;
        case 'NormLine'
            cpAnalysisShoudBeElliptic(:) = false;
            cpLineRotTF(:) = false;
            cpNormTF(:) = true;
        case 'Elliptic'
            cpAnalysisShoudBeElliptic(:) = true;
            cpLineRotTF(:) = false;
            cpNormTF(:) = false;
        case 'Hybrid'
            %cpAnalysisShoudBeElliptic(:) = false;
            cpLineRotTF(:) = ~cpAnalysisShoudBeElliptic;
            cpNormTF(:) = false;
        case 'Speed'
            %cpAnalysisShoudBeElliptic(:) = false;
            cpLineRotTF(:) = false;
            cpNormTF(:) = ~cpAnalysisShoudBeElliptic;
        case 'All'
            cpAnalysisShoudBeElliptic(:) = true;
            cpLineRotTF(:) = true;
            cpNormTF(:) = true;
        otherwise
            error('input Mesure Type is not correct')
    end
    
    for k = 1:siz(4) %length(NewStep)
        indY = cpIndY;
        indX = cpIndX;
        indZ = cpIndZ;
        Signal = cpSignal(:,k);
        Norm  = cpNormThetaXY;
        EllipticTF = cpAnalysisShoudBeElliptic;
        LineRotTF = cpLineRotTF;
        NormTF = cpNormTF;
        %% Interpolation numeric z dim, Matrix with each point in Dimmention 3 
        % Analysis Noise
        if ~strcmp(Option.NoiseType,'Numeric')
            SliceImage(1:length(indZ)) = struct('Noise',[]);
            pIm = fImage(:,:,:,k);
            parfor n = 1:length(indZ)  
                im = pIm;
                rX = meshX - indX(n);
                rY = meshY - indY(n);
                rArea = sqrt(rX.^2 + rY.^2) <=NoiseArea;        
                im = im(rArea);
                currentN = TS_GetBackgroundValue(im);
                SliceImage(n).Noise = single(currentN);
            end    
            Noise = cat(1,SliceImage.Noise);
            clear SliceImage
        else
            Noise = repmat(Option.Noise,[length(indZ),1]);
        end
        %% Defain Threshold
        CorrectedThreshold = nan(length(indZ),1);                
        if strcmpi(ThresholdType,'sp5')
            for n = 1:length(indZ)
                CorrectedThreshold(n) = TS_GetThreshold_sp5_v2019(...
                    Signal(n),Noise(n));
            end
        elseif strcmpi(ThresholdType,'sp8')
            for n = 1:length(indZ)
                CorrectedThreshold(n) = TS_GetThreshold_sp8(...
                    Signal(n),Noise(n));
            end
        elseif strcmpi(ThresholdType,'fwhm')
            CorrectedThreshold(:) = 0.5;
        end
        %% Analysis Limit
        SNR = Signal./max(Noise,1);
        SNRTF = SNRth <= 10*log10(SNR);
            
        %% . set up All Measure Type %%%%%%%%%%%%%%%%%%%%%%%%%%
        clear parpdata
        parpdata(1:length(indZ)) = struct('XYZ',[],'Theta',[],...
            'Signal',[],'Noise',[],'ThCorrectedWidth',[],...
            'LineRotDiameter',[],'NormDiameter',[],'EllipticDiameter',[],...
            'Type',[],'NewXYZrot',[],'NewXYZnor',[],'NewXYZell',[]);
        for n = 1:length(indZ)
            parpdata(n).Signal = Signal(n);
            parpdata(n).Noise = Noise(n);
            parpdata(n).XYZ = [indX(n), indY(n), indZ(n)];
        end
        %% For Rotation Line
        if max(strcmp(Option.MeasureType,{'LineRot','Hybrid','All'}))
            SliceImage(1:sum(LineRotTF)) = struct('Xq',[],'Yq',[],'Zq',[]);
            LineRotInd = find(LineRotTF);
            LineRotDiameter = nan(1,length(LineRotInd));
            LineRotTheta = LineRotDiameter;
            LineRotNewXYZ = nan(length(LineRotInd),3);
            %% make matrix for parfor
            parfor n = 1:length(LineRotInd)
                SliceImage(n).Xq = Xp + indX(LineRotInd(n));
                SliceImage(n).Yq = Yp + indY(LineRotInd(n));
            end
            Xq = cat(3,SliceImage.Xq);
            Yq = cat(3,SliceImage.Yq);
            parImage = interp2(fImage(:,:,:,k),Xq,Yq, 'bilinear');
            clear Xq Yq Zq SliceImage      
            %% main for rotation line profile to Width
            parfor n = 1:length(LineRotInd)
                nS = double(Signal(n));
                nN = double(Noise(n));
                fwhm = zeros(length(theta),2);
                %% Normalize vpmatrix
                vpmatrix = parImage(:,:,n);
                vpmatrix = double(vpmatrix);
                vpmatrix = (vpmatrix-nN)/(nS-nN);
                vpmatrix = max(vpmatrix,0);
                % This Process is to denoising in Near 3 point from center point
                % pre_vpmatrix = vpmatrix;
                vpmatrix(round(size(vpmatrix,1)/2),:) = 1;
                L = bwlabel(vpmatrix>CorrectedThreshold(n),8);
                CenterLabel = L(round(size(vpmatrix,1)/2),1);
                TF = and( CenterLabel>0, SNRth < 10*log10(nS/nN));
                if TF
                    bw_vp = L==CenterLabel;
                    % % This process is to analys High Noise data ,but High SNR is not neccaaary
                    bw_vp = imclose(bw_vp,se);
                    bw_vp = imerode(bw_vp,ones(3,1)); %
                    vpmatrix(bw_vp) =  max(vpmatrix(bw_vp),CorrectedThreshold(n)); %
                    fwhm = TS_FWHM2019(vpmatrix,CorrectedThreshold(n));
                    RotWidth = diff(fwhm,[],2);
                    [PixDiam,Ind] = min(RotWidth);
                    Ind = Ind(1);
                    %% output NEW Position
                    vpX = Xp + indX(n);
                    vpY = Yp + indY(n);
                    newx = vpX(:,Ind);
                    newy = vpY(:,Ind);
                    newind = mean(fwhm(Ind,:));
                    newx = interp1(newx,newind,'linear');
                    newy = interp1(newy,newind,'linear');
                    newz = indZ(n);    
                    %% output for parpdata                        
                    LineRotTheta(n) = theta(Ind);                    
                    LineRotDiameter(n) = PixDiam;
                    LineRotNewXYZ(n,:) = [newx newy newz];
                end
            end
            %% output
            for n = 1:length(LineRotInd)
                parpdata(LineRotInd(n)).Theta = LineRotTheta(n);
                parpdata(LineRotInd(n)).LineRotDiameter = LineRotDiameter(n);
                parpdata(LineRotInd(n)).NewXYZrot = LineRotNewXYZ(n,:);        
            end    
        end
        %% For Norm Line
        if max(strcmp(Option.MeasureType,{'NormLine','Speed','All'}))            
            SliceImage(1:sum(NormTF)) = struct('Xq',[],'Yq',[],'Zq',[]);            
            NormInd = find(NormTF);
            
            NormDiameter = nan(1,length(NormInd));
            parfor n = 1:length(NormInd)
                [Xp,Yp] = Sf.GetThetaIndex(...
                    [indX(NormInd(n)),indY(NormInd(n)),indZ(NormInd(n))],...
                    Norm(NormInd(n)),Len,Reso(1));
                SliceImage(n).Xq = Xp(:);
                SliceImage(n).Yq = Yp(:);
            end
            Xq = cat(2,SliceImage.Xq);
            Yq = cat(2,SliceImage.Yq);
            parImage = interp2(fImage(:,:,:,k),Xq,Yq, 'bilinear');
            clear Zq SliceImage       
            
            %% normalize and Get Threshold
            for n = 1:length(NormInd)                                
                %% Normalize vpmatrix
                Sl = Signal(NormInd(n));
                Nl = Noise(NormInd(n));
                Line = parImage(:,n);
                Line = double(Line);
                Line = (Line-Nl)/(Sl-Nl);
                Line = max(Line,0);
                parImage(:,n) = single(Line);
            end
            
            % This Process is to denoising in Near 3 point from center point
            % pre_vpmatrix = vpmatrix;
            if ~isempty(NormInd)
                parImage(ceil(size(parImage,1)/2),1) = 1;            
                fwhm = TS_FWHM2019(parImage,CorrectedThreshold);
                DiffFWHM = diff(fwhm,[],2);
            end
            for n = 1:length(NormInd)
                if SNRTF(NormInd(n))
                    %% output NEW Position
                    vpX = Xq(:,n) + indX(NormInd(n));
                    vpY = Yq(:,n) + indY(NormInd(n));
                    newx = vpX;
                    newy = vpY;
                    newind = DiffFWHM(n);
                    newx = interp1(newx,newind,'linear');
                    newy = interp1(newy,newind,'linear');
                    newz = indZ(n);    
                    %% output for parpdata
                    parpdata(NormInd(n)).NormDiameter = DiffFWHM(n);
                    parpdata(n).NewXYZnor = [newx newy newz];        
                else
                    %% output for parpdata
                    parpdata(NormInd(n)).NormDiameter = nan;
                    parpdata(n).NewXYZnor = [indX(n), indY(n), indZ(n)];        
                end
            end       
        end
        %% For Elliptic Analysis
        if max(strcmp(Option.MeasureType,{'Elliptic','Hybrid','Speed','All'}))
            clear SliceImage
            SliceImage(1:sum(EllipticTF)) = struct('Xq',[],'Yq',[],'Zq',[]);
            EllipticInd = find(EllipticTF);
            EllipticDiameter = nan(1,length(EllipticInd));
            NewXYZell = nan(length(EllipticInd),3);
            parfor n = 1:length(EllipticInd)                
                SliceImage(n).Xq = Xe+indX(EllipticInd(n));
                SliceImage(n).Yq = Ye+indY(EllipticInd(n));
            end
            Xq = cat(3,SliceImage.Xq);
            Yq = cat(3,SliceImage.Yq);
            parImage = interp2(fImage(:,:,:,k),Xq,Yq, 'bilinear');
            clear Xq Yq Zq SliceImage       
            %% bainalize and Elliptic Analysis
            for n = 1:size(parImage,3)
                im = parImage(:,:,n);
                im = (im- Noise(EllipticInd(n)))/...
                    (Signal(EllipticInd(n))-Noise(EllipticInd(n)));  
                bw = im >=CorrectedThreshold(EllipticInd(n));
                bw = imclose(bw,se);
                [BW,~] = FindNearestObj(bw,CropCenter,Reso,Length_Limit);
                s = regionprops(BW,'Centroid','MinorAxisLength','MajorAxisLength','Area');
                    
                TF = SNRTF(EllipticInd(n)) && length(s)==1;
                if TF
                    Ediam = s.MinorAxisLength;
                    newx = indX(EllipticInd(n)) + (s.Centroid(1)-CropCenter(2));
                    newy = indY(EllipticInd(n)) + (s.Centroid(2)-CropCenter(1));
                    newz = indZ(EllipticInd(n));
                    EllipticDiameter(n)= Ediam;                    
                    NewXYZell(n,:) = [newx newy newz];
                else                    
                end
            end
            for n = 1:length(EllipticInd)
                parpdata(EllipticInd(n)).EllipticDiameter = EllipticDiameter(n);
                parpdata(EllipticInd(n)).NewXYZell = NewXYZell(n,:);
            end
        end
       %% Witing pdata
       c = 1;
       for Nind = 1:length(Number)
           xyz = SEG.Pointdata(Number(Nind)).PointXYZ;
           Signal = zeros(size(xyz,1),1,'like',single(1));    
           Noise = Signal;
           LineRotDiameter = Signal;
           NormDiameter = Signal;
           EllipticDiameter = Signal;
           Theta = Signal;
           NewXYZrot = double(cat(2,Signal,Signal,Signal));    
           NewXYZnor = NewXYZrot;
           NewXYZell = NewXYZrot;
           for kt = 1:size(xyz,1)
               Signal(kt) = EmptyCheck(parpdata(c).Signal,1);
               Noise(kt) = EmptyCheck(parpdata(c).Noise,1);
               LineRotDiameter(kt) = EmptyCheck(parpdata(c).LineRotDiameter * Reso(1) ,1);
               NormDiameter(kt) = EmptyCheck(parpdata(c).NormDiameter * Reso(1),1);
               EllipticDiameter(kt) = EmptyCheck(parpdata(c).EllipticDiameter * Reso(1),1);
               Theta(kt) = EmptyCheck(parpdata(c).Theta,1);
               NewXYZrot(kt,:) = EmptyCheck(parpdata(c).NewXYZrot,3);
               NewXYZnor(kt,:) = EmptyCheck(parpdata(c).NewXYZnor,3);
               NewXYZell(kt,:) = EmptyCheck(parpdata(c).NewXYZell,3);
               c = c +1;
           end
           SEG.Pointdata(Number(Nind)).Signal(:,k) = single(Signal);
           SEG.Pointdata(Number(Nind)).Noise(:,k) = single(Noise);
           SEG.Pointdata(Number(Nind)).Diameter(:,k) = single(LineRotDiameter);%%%%%%%%%%%%%%%%
           SEG.Pointdata(Number(Nind)).LineRotDiameter(:,k) = single(LineRotDiameter);
           SEG.Pointdata(Number(Nind)).NormDiameter(:,k) = single(NormDiameter);
           SEG.Pointdata(Number(Nind)).EllipticDiameter(:,k) = single(EllipticDiameter);
           SEG.Pointdata(Number(Nind)).Theta(:,k) = single(Theta);
           NewXYZrot = (NewXYZrot -1 ) .* Reso;
           NewXYZrot = (NewXYZrot ./ SEGRESO ) + 1;
           NewXYZnor = (NewXYZnor -1 ) .* Reso;
           NewXYZnor = (NewXYZnor ./ SEGRESO ) + 1;
           NewXYZell = (NewXYZell -1 ) .* Reso;
           NewXYZell = (NewXYZell ./ SEGRESO ) + 1;
           SEG.Pointdata(Number(Nind)).NewXYZ(:,:,k) = single(NewXYZrot);
           SEG.Pointdata(Number(Nind)).NewXYZrot(:,:,k) = single(NewXYZrot);
           SEG.Pointdata(Number(Nind)).NewXYZnor(:,:,k) = single(NewXYZnor);
           SEG.Pointdata(Number(Nind)).NewXYZell(:,:,k) = single(NewXYZell);
       end
       if strcmp(Option.Progressbar,'on')
           TS_WaiteProgress(k/siz(4))
       end
    end
end
output = SEG;
output.DiameterAnalysisTime = toc(TIME);
if strcmp(Option.Progressbar,'on')
    fprintf('Done.\n')
    toc(TIME)
    fprintf('\n')
end
end

function A = EmptyCheck(B,num)
if isempty(B)
    A = nan(1,num);
else
    A = B;
end
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

function  [BW,Centroid] = FindNearestObj(bw,Center,Reso,Length_Limit)
if max(bw(:)) == false
    BW = bw;
    Centroid = nan(1,3);
    return
end
S = Segment_Functions;
CC = bwconncomp(bw);
minLen = zeros(1,CC.NumObjects);
s = regionprops(CC,'Centroid');
for n = 1:CC.NumObjects
    [y,x,z] = ind2sub(size(bw,1:3),CC.PixelIdxList{n});
    
    Len = S.GetEachLength([Center,1],cat(2,x(:),y(:),z(:)),Reso);
   
    minLen(n) = min(Len);
end
[MinimumLength,IndexCC] = min(minLen);
BW = false(CC.ImageSize);
if MinimumLength > Length_Limit    
    Centroid = nan(1,3);
else                
    Centroid = s(IndexCC).Centroid;
    BW(CC.PixelIdxList{IndexCC}) = true;
end
end

       






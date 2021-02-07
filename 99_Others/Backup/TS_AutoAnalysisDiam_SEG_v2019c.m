function [output,ppdata] = TS_AutoAnalysisDiam_SEG_v2019c(fImage,inReso,ThresholdType,SEG,varargin)
% SEG = TS_AutoAnalysisDiam_SEG(fImage,Reso,ThresholdType,SEG,{ID})
% fImage = Resize_fImage;
% Len = [70 100]; % um 
% Reso = Resolution % um/pix.
% Threshold Type = {sp5, sp8, photo count, pmt, ..}*
% SEG = TS_AutoSegment_loop...
% Number .... SEG.Pointdata.ID (s)
% 
% add Compensation by SNR (this value is for PMT ver. Image)
% th = TS_GetThreshold_sp5(S,N);
%  
%  see alo so , Sugashi_AutoAnalysisDiam
% TS_AutoAnalysisDiam_AddAdjPreFWHM_perSlice  Group...
% 
% 
% Editor log. 
% Add, Threshold Type to fwhm(threhsold =0.5), 2019.06.14 ,Sugashi
% change parfor input... 
% 
% version v2019c is lower memory usage, higher perfomance parallel computing.
%  2019.07.05, by Sugashi


global Len Reso
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

if ~max(strcmpi({'sp5','sp8'},ThresholdType))
    warning(   mfilename('fullpath') )
    error('Input Threshold Type is Member of {"sp5"(=PMT), or "sp8"(=Photo Count)}')
end
siz = size(fImage);
% SNRth = 2; % [dB]
Len = [70 200]; % Rotation Line Profile Length , Checking Axis Z Line Length
PenetLenTh = 100;
PoolObj = gcp;
if isempty(PoolObj)    
    PoolObj = parpool;
end
NumWorker = PoolObj.NumWorkers;
SingleByte = 4;
MaximumUsableMemorySize = 10 * 2^30; % Giga Bytes
EachStep = floor(MaximumUsableMemorySize / ( prod(siz(1:2)) * SingleByte * NumWorker ));
EachStep = max(EachStep,NumWorker*5);
% EachStep = NumWorker;

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
Shori = interp3(fImage,Xq,Yq,Zq,'bilinear');
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
    parImage = interp3(fImage,Xq,Yq,Zq, 'bilinear');
    clear SliceImage Xq Yq Zq
    SliceImage(1:length(indZ)) = struct('Xq',[],'Yq',[],'Zq',[],'Noise',[]);
    parfor n = 1:length(indZ)
        x=indX(n);y=indY(n);z=indZ(n);        
        SliceImage(n).Xq = Xp + x;
        SliceImage(n).Yq = Yp + y;
        SliceImage(n).Zq = repmat(z,size(Xp));
        im = parImage(:,:,n);        
        N = TS_GetBackgroundValue(im(and( im>min(im(:)), im < max(im(:))  )));
        SliceImage(n).Noise = single(N);
    end    
    Xq = cat(3,SliceImage.Xq);
    Yq = cat(3,SliceImage.Yq);
    Zq = cat(3,SliceImage.Zq);
    Noise = cat(2,SliceImage.Noise);
    parImage = interp3(fImage,Xq,Yq,Zq, 'bilinear');
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
            th = TS_GetThreshold_sp5(S,N);        
        elseif strcmpi(ThresholdType,'sp8')
            th = TS_GetThreshold_sp8(S);
        elseif strcmpi(ThresholdType,'fwhm')
            th = 0.5;
        else
            error('Input Threshold Type UNKNOW.')
        end
        
        %% Add Pre FWHM
        % This Process is to denoising in Near 3 point from center point
        vpmatrix(round(size(vpmatrix,1)/2),:) = 1;
        L = bwlabel(vpmatrix>th,8);%% 
        TF = L(round(size(vpmatrix,1)/2),1);
        if TF > 0
            bw_vp = L==L(round(size(vpmatrix,1)/2),1);
            % % This process is to analys High Noise data ,but High SNR is not neccaaary
            bw_vp = imclose(bw_vp,se);
            bw_vp = imerode(bw_vp,ones(3,1)); %
            % % FWHM == 0.5, This value is needed more Harlf(0.5) value;        

            vpmatrix(bw_vp) =  th; %

            for kk = 1:length(theta)
                Lp = double(vpmatrix(:,kk));
                fwhm(kk,:) = TS_FWHM2016(Lp,th,'type','fwhm','Center',floor(length(Lp)/2));
            end        
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
            parpdata(n).XYZ = [x y z];
            parpdata(n).Theta = nan;
            parpdata(n).Signal = single(S);
            parpdata(n).Noise = single(N);
            parpdata(n).ThCorrectedWidth = fwhm;
            parpdata(n).PixelsDiameter = nan;
            parpdata(n).NewXYZ = [x y z];
        end
    end
    

    %% Calculate Suggestion Z
    parZdata(1:length(indZ)) = struct('Xq',[],'Yq',[],'Zq',[]);
    parfor n = 1:length(indZ)
        x=indX(n);y=indY(n);z=indZ(n);        
        [X,Y,Z] = GetAxisZMesh(x,y,z,siz,Len(2)/Reso(3));
        parZdata(n).Xq = X;
        parZdata(n).Yq = Y;
        parZdata(n).Zq = Z;        
    end
    Xq = cat(2,parZdata.Xq);
    Yq = cat(2,parZdata.Yq);
    Zq = cat(2,parZdata.Zq);
    parZImage = interp3(fImage,Xq,Yq,Zq,'bilinear');
    parfor n = 1:length(indZ)
        LineZ = parZImage(:,n);
        LineZ(isnan(LineZ)) = 0;
        LineZ = (LineZ - Noise(n)) / (Signal(n) -Noise(n));
        WidthPoint = TS_FWHM2016(LineZ,0.5,'type','fwhm','Center',floor(length(LineZ)/2));
        WidthZ = diff(WidthPoint) * Reso(3);
        if or(isnan(WidthZ) , WidthZ > PenetLenTh)
            Type = 'Penet';
            z = indZ(n);
        else
            Type = 'others';
            WidthZ_center = mean(WidthPoint);
            z = interp1(parZdata(n).Zq(1,:),WidthZ_center);
        end
        parpdata(n).NewXYZ(3) = z;
        parpdata(n).Type = Type;
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


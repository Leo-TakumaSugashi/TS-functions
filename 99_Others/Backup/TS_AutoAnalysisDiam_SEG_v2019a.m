function output = TS_AutoAnalysisDiam_SEG_v2019a(fImage,Reso,ThresholdType,SEG,varargin)
% SEG = TS_AutoAnalysisDiam_SEG(fImage,Reso,ThresholdType,SEG,Number)
% fImage = Resize_fImage;
% Len = [70 100]; % um 
% Reso = Resolution % um/pix.
% Threshold Type = {sp5, sp8, photo count, pmt, ..}*
% SEG = TS_AutoSegment_loop...
% Number .... SEG.Pointdata(Number)
% 
% add Compensation by SNR (this value is for PMT ver. Image)
% th = TS_GetThreshold_sp5(S,N);
%  
%  see alo so , Sugashi_AutoAnalysisDiam
% TS_AutoAnalysisDiam_AddAdjPreFWHM_perSlice  Group...


% Editor log. 
% Add, Threshold Type to fwhm(threhsold =0.5), 2019.06.14 ,Sugashi
%%

if nargin ==5
    Number = varargin{1};
else
    Number = 1:length(SEG.Pointdata);
end

if ~max(strcmpi({'sp5','sp8'},ThresholdType))
    warning(   mfilename('fullpath') )
    error('Input Threshold Type is Member of {"sp5"(=PMT), or "sp8"(=Photo Count)}')
end
siz = size(fImage);
SNRth = 2; % [dB]
Len = [70 200]; % Rotation Line Profile Length , Checking Axis Z Line Length
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
    error('Input SEG Index Size over(less) than fImage (X-axis).')
elseif or(min(indY)<1,max(indY)>size(fImage,1))
    error('Input SEG Index Size over(less) than fImage (Y-axis).')
elseif or(min(indZ)<1,max(indZ)>size(fImage,3))
    error('Input SEG Index Size over(less) than fImage (Z-axis).')
end


%% Analysis
TIME = tic;
ppdata(1:length(indY)) = ...
    struct('XYZ',[],'Signal',[],'Noise',[],'Theta',[],'FWHM',[],...
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
fprintf(1,['Numeric : ' num2str(length(indY))])
parfor n = 1:length(indY)
    x=indX(n);y=indY(n);z=indZ(n);
    [Xq,Yq,Zq] = GetSignalMesh(x,y,z,siz);
    S = interp3(fImage,Xq,Yq,Zq,'bilinear');
    S = mean(S(:));
    im = interp3(fImage,meshX,meshY,repmat(z,size(meshZ)), 'bilinear');
    N = TS_GetBackgroundValue(im);
    N = max(N,1);
%     SNR = log10(S / N ) * 10;
    %% check Plane XY    
    vpX = Xp + x;
    vpY = Yp + y;
    vpmatrix = interp2(im,vpX,vpY,'bilinear');
    fwhm = zeros(length(theta),2);
    vpmatrix = double(vpmatrix);
    vpmatrix = (vpmatrix-N)/(S-N);
    vpmatrix = max(vpmatrix,0);
    %% Add Pre FWHM
    % This Process is to denoising in Near 3 point from center point
    % pre_vpmatrix = vpmatrix;
    vpmatrix(round(size(vpmatrix,1)/2),:) = 1;
    % bw_vp =TS_GetMaxArea(vpmatrix>0.5); %% 2016.11.12 .old, ver.
    L = bwlabel(vpmatrix>0.5,8);%% 2016.11.14 .New, ver.
    bw_vp = L==L(round(size(vpmatrix,1)/2),1);
    % % This process is to analys High Noise data ,but High SNR is not neccaaary
    bw_vp = imclose(bw_vp,se);
    bw_vp = imerode(bw_vp,ones(3,1)); %
    % % FWHM == 0.5, This value is needed more Harlf(0.5) value;
%     vpmatrix(bw_vp) =  0.6; %
    if strcmpi(ThresholdType,'sp5')
        th = TS_GetThreshold_sp5(S,N);        
    elseif strcmpi(ThresholdType,'sp8')
        th = TS_GetThreshold_sp8(S);
    elseif strcmpi(ThresholdType,'fwhm')
        th = 0.5;
    else
        error('Input Threshold Type UNKNOW.')
    end
    vpmatrix(bw_vp) =  th; %
    
    for k = 1:length(theta)
        Lp = double(vpmatrix(:,k));
        fwhm(k,:) = TS_FWHM2016(Lp,th,'type','fwhm','Center',floor(length(Lp)/2));
    end
    DiffFWHM = diff(fwhm,1,2);
    [PixDiam,Ind] = min(DiffFWHM);

    %% output NEW Position
    newx = vpX(:,Ind);
    newy = vpY(:,Ind);
    newind = mean(fwhm(Ind,:));
    newx = interp1(newx,newind,'linear');
    newy = interp1(newy,newind,'linear');

    %% check Axis Z 
    [X,Y,Z] = GetAxisZMesh(x,y,z,siz,Len(2)/Reso(3));
    LineZ = single(mean( interp3(fImage,X,Y,Z,'bilinear') ,1));
    LineZ(isnan(LineZ)) = 0;
    LineZ = (LineZ - N) / (S -N);
    WidthPoint = TS_FWHM2016(LineZ,0.5,'type','fwhm','Center',floor(length(LineZ)/2));
    WidthZ = diff(WidthPoint) * Reso(3);
    if or(isnan(WidthZ) , WidthZ > PenetLenTh)
        Type = 'Penet';
    else
        Type = 'others';
        WidthZ_center = mean(WidthPoint);
        z = interp1(Z(1,:),WidthZ_center);
    end
    newz = z;
    ppdata(n).XYZ = [x y z];
    ppdata(n).Theta = theta(Ind);
    ppdata(n).Signal = single(S);
    ppdata(n).Noise = single(N);
    ppdata(n).FWHM = fwhm;
    ppdata(n).PixelsDiameter = PixDiam;
    ppdata(n).Type = Type;
    ppdata(n).NewXYZ = [newx newy newz];
end

c = 1;
for N = 1:length(Number)
    xyz = SEG.Pointdata(Number(N)).PointXYZ;
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
    SEG.Pointdata(Number(N)).Signal = Signal;
    SEG.Pointdata(Number(N)).Noise = Noise;
    SEG.Pointdata(Number(N)).Diameter = Diameter;
    SEG.Pointdata(Number(N)).Theta = Theta;
    NewXYZ = (NewXYZ -1 ) .* Reso;
    NewXYZ = (NewXYZ ./ SEGRESO ) + 1;
    SEG.Pointdata(Number(N)).NewXYZ = NewXYZ;
end
output = SEG;
end


function [X,Y,Z] = GetSignalMesh(x,y,z,siz)
    X = x-1 : x + 1;
    X(X<1) = [];
    X(X>siz(2)) = [];
    Y = y-1 : y + 1;
    Y(Y<1) = [];
    Y(Y>siz(1)) = [];
    Z = z-1 : z + 1;
    Z(Z<1) = [];
    Z(Z>siz(3)) = [];
    [X,Y,Z] = meshgrid(X,Y,Z);
end
function [X,Y,Z] = GetAxisZMesh(x,y,z,siz,PixLen)
    X = x-1 : x + 1;
    X(X<1) = [];
    X(X>siz(2)) = [];
    Y = y-1 : y + 1;
    Y(Y<1) = [];
    Y(Y>siz(1)) = [];
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


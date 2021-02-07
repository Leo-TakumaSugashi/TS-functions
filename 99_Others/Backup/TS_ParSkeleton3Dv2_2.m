function output = TS_ParSkeleton3Dv2_2(fImage,NewReso)
% output = TS_ParSkeleton3Dv4(fImage,NewReso)
% fImage = filtered Image;
% Reso = Resolution % [x y(=x), z]um/pix.
% 
% Len = ; % um
% 
% xdata = 1:size(fImage,2);
% ydata = 1:size(fImage,1);
% zdata = 1:size(fImage,3);

%% Initialize

Len = [70 200];
siz = size(fImage);
P = 0.002;
SNRth = 2; % [dB]
PenetLenTh = 50; % [um]

[indY,indX,indZ] = TS_DefStartP(siz,P);
output.InputImage = fImage;
output.ROI_Len = Len;
output.Size = siz;
output.Start_Point_Raitio = P;
output.SNR_Threshold = SNRth;
output.Penet_Detect_Threshold = PenetLenTh;

%% Analysis
TIME = tic;
% [indY,indX,indZ] = ind2sub(size(skel),find(skel(:)));
% wh = waitbar(0,'Wait... Diamter Analysis');
ppdata(1:length(indY)) = ...
    struct('XYZ',[],'Signal',[],'Noise',[],'Theta',[],'FWHM',[],...
    'PixelsDiameter',[],'Type',[],'NewXYZ',[]);
useTF = true(1,length(indY));
%% Add Pre FWHM
% This Process is to denoising in Near 3 point from center point
close_siz = round(3 / NewReso(1));
close_siz = close_siz + double(eq(floor(close_siz/2),ceil(close_siz/2)));
se = ones(close_siz,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SfImage = imfilter(single(fImage),ones(3,3,3)/27,'symmetric');
[meshX,meshY,meshZ] = meshgrid(1:siz(2),1:siz(1),1);
[Xp,Yp,theta] = TS_GetLinePro2mesh(fImage(:,:,1),[0 0],Len(1),NewReso);

%% MAIN
fImage = single(fImage);
parfor n = 1:length(indY)
    
    x=indX(n);y=indY(n);z=indZ(n);
    [Xq,Yq,Zq] = GetSignalMesh(x,y,z,siz);
    S = interp3(fImage,Xq,Yq,Zq,'bilinear');
    S = mean(S(:));
    im = interp3(fImage,meshX,meshY,repmat(z,size(meshZ)), 'bilinear');
    N = TS_GetBackgroundValue(im);
    N = max(N,1);
    SNR = log10(S / N ) * 10;
    if SNR < SNRth
        useTF(n) = false;
        nowtf = useTF;
        len = round(sum(~nowtf) / numel(nowtf) * 100 );
        disp(['... Progress : ' num2str(len) ' %'])
        ppdata(n).XYZ = [x y z];
        ppdata(n).Theta = nan;
        ppdata(n).Signal = single(S);
        ppdata(n).Noise = single(N);
        ppdata(n).FWHM = nan;
        ppdata(n).PixelsDiameter = nan;
        ppdata(n).NewXYZ = nan;
    else
    %% check Axis Z 
        [X,Y,Z] = GetAxisZMesh(x,y,z,siz,Len(2)/NewReso(3));
        LineZ = single(mean( interp3(fImage,X,Y,Z,'bilinear') ,1));
        LineZ(isnan(LineZ)) = 0;
        LineZ = (LineZ - N) / (S -N);
        WidthPoint = TS_FWHM2016(LineZ,0.5,'type','fwhm','Center',floor(length(LineZ)/2));
        WidthZ = diff(WidthPoint) * NewReso(3);
%         fgh = figure;
%         plot(LineZ,'o-')
%         hold on
%         plot(WidthPoint,[1 1]*0.5,'rx-.','MarkerSize',12)
%         waitfor(fgh)
        if or(isnan(WidthZ) , WidthZ > PenetLenTh)
            Type = 'Penet';
        else
            Type = 'others';
            WidthZ_center = mean(WidthPoint);
            z = interp1(Z(1,:),WidthZ_center);
        end
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
        vpmatrix(bw_vp) =  0.6; %
        for k = 1:length(theta)
            Lp = double(vpmatrix(:,k));
            fwhm(k,:) = TS_FWHM2016(Lp,0.5,'type','fwhm','Center',floor(length(Lp)/2));
        end
        DiffFWHM = diff(fwhm,1,2);
        [PixDiam,Ind] = min(DiffFWHM);
        newx = vpX(:,Ind);
        newy = vpY(:,Ind);
        newind = mean(fwhm(Ind,:));
        newx = interp1(newx,newind,'linear');
        newy = interp1(newy,newind,'linear');
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
end
ppdata(~useTF) = [];
output.Pointdata = ppdata;
output.theta = theta;
output.Reso = NewReso;
output.Len = Len;
output.Analysis_Time = toc(TIME);
disp(['    ' mfilename ' ...'...
    num2str(toc(TIME)/3600) ' [h]'])

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






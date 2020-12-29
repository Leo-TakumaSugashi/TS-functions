function output = TS_AutoAnalysisDiam_AddAdjPreFWHM(fImage,skel,NewReso,Len)
% output = TS_AutoAnalysisDiam_proto(fImage,skel,Reso,Len)
% fImage = Resize_fImage;
% Len = ; % um 
% Reso = Resolution % um/pix.


xdata = 1:size(fImage,2);
ydata = 1:size(fImage,1);
zdata = 1:size(fImage,3);

%% Analysis
TIME = tic;
[indY,indX,indZ] = ind2sub(size(skel),find(skel(:)));
% wh = waitbar(0,'Wait... Diamter Analysis');
ppdata(1:length(indY)) = ...
    struct('XYZ',[],'Signal',[],'Noise',[],'Theta',[],'FWHM',[],'Diameter',[]);
%% Add Pre FWHM
% This Process is to denoising in Near 3 point from center point
close_siz = round(3 / NewReso(1));
close_siz = close_siz + double(eq(floor(close_siz/2),ceil(close_siz/2)));
se = ones(close_siz,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% MAIN
parfor n = 1:length(indY)
% xyz = SEG.Pointdata(n).PointXYZ;
xyz = [indX(n) indY(n) indZ(n)];
im = squeeze(fImage(:,:,xyz(3)));
Center = xyz(1:2);
% [vpmatrix,theta,Cropim,Cropbw] = ...
%         TS_GetLinePro2Matrix(im,Center,Len,NewReso(1));
[vpmatrix,theta,~,~] = ...
        TS_GetLinePro2Matrix_v2(im,Center,Len,NewReso(1));
fwhm = zeros(length(theta),2);
xind = and(xdata>=xyz(1)-1,xdata<=xyz(1)+1);
yind = and(ydata>=xyz(2)-1,ydata<=xyz(2)+1);    
zind = and(zdata>=xyz(3)-1,zdata<=xyz(3)+1);    
S = double(fImage(yind,xind,zind));
S = mean(S(:));
% % Add Getting Back Ground Value. 
%  Main process is smoothing histogram.
N = TS_GetBackgroundValue(double(im(and(im>0,im<S))));
if or(isempty(N),isnan(N))
    N = 0;
end
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

% fgh = figure;
% axes('Posi',[0 0 .5 1])
% imagesc(pre_vpmatrix);
% axes('Posi',[0.5 0 .5 1])
% imagesc(rgbproj(cat(3,bw_vp,pre_vpmatrix>=0.5)));
% waitfor(fgh)
% ppdata(n).crop = cropim;
% ppdata(n).vpmatrix = vpmatrix;
% ppdata(n).Prevpmatrix = pre_vpmatrix;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k = 1:length(theta)
    Lp = double(vpmatrix(:,k));
    fwhm(k,:) = TS_FWHM2016(Lp,0.5,'type','fwhm','Center',round(length(Lp)/2));
end
DiffFWHM = diff(fwhm,1,2) * NewReso(1);
[~,Ind] = min(DiffFWHM);
ppdata(n).XYZ = xyz;
ppdata(n).Theta = theta(Ind);
ppdata(n).Signal = S;
ppdata(n).Noise = N;
ppdata(n).FWHM = fwhm;
ppdata(n).Diameter = DiffFWHM(Ind);
end
im = squeeze(fImage(:,:,1));
Center = round(size(im)/2);
Center(1:2) = flip(Center(1:2));
[~,theta,~,~] = ...
        TS_GetLinePro2Matrix_v2(im,Center,50,NewReso(1));
output.Pointdata = ppdata;
output.theta = theta;
output.Reso = NewReso;
output.Len = Len;
output.Analysis_Time = toc(TIME);
toc(TIME)



   
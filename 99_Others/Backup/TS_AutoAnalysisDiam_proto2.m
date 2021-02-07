function output = TS_AutoAnalysisDiam_proto2(fImage,skel,NewReso)




Len = 20; % um �э׌��ǂ悤�ɐݒ�B
xdata = 1:size(fImage,2);
ydata = 1:size(fImage,1);
zdata = 1:size(fImage,3);

%% Analysis
TIME = tic;
[indY,indX,indZ] = ind2sub(size(skel),find(skel(:)));
% siz = size(fImage);
DiamInd = zeros(length(indZ),1);
Theta = DiamInd;
FWHMmatrix = zeros(length(indZ),2);


parfor n = 1:length(indZ)
    disp(num2str(n))
% xyz = SEG.Pointdata(n).PointXYZ;
xyz = [indX(n) indY(n) indZ(n)];
im = squeeze(fImage(:,:,indZ(n)));
Center = [indX(n) indY(n)];
% [vpmatrix,theta,Cropim,Cropbw] = ...
%         TS_GetLinePro2Matrix(im,Center,Len,NewReso(1));
[vpmatrix,theta,~,~] = ...
        TS_GetLinePro2Matrix(im,Center,Len,NewReso(1));
fwhm = zeros(length(theta),2);
xind = and(xdata>=xyz(1)-1,xdata<=xyz(1)+1);
yind = and(ydata>=xyz(2)-1,ydata<=xyz(2)+1);    
zind = and(zdata>=xyz(3)-1,zdata<=xyz(3)+1);    
S = double(fImage(yind,xind,zind));
S = mean(S(:));
N = double(mode(im(and(im>0,im<S))));
if isempty(N)
    N = 0;
end
vpmatrix = double(vpmatrix);
vpmatrix = (vpmatrix-N)/(S-N);
for k = 1:length(theta)
    Lp = double(vpmatrix(:,k));
    fwhm(k,:) = TS_FWHM2016(Lp,0.5);
end
DiffFWHM = diff(fwhm,1,2) * NewReso(1);
[~,Ind] = min(DiffFWHM);

DiamInd(n,1) = DiffFWHM(Ind);
Theta(n,1) = theta(Ind(1));
FWHMmatrix(n,:) = fwhm(Ind,:);
% ppdata(n).XYZ = xyz;
% ppdata(n).Theta = theta(Ind);
% ppdata(n).Signal = S;
% ppdata(n).Noise = N;
% ppdata(n).FWHM = fwhm;
% ppdata(n).Diameter = DiffFWHM(Ind);
% clear fh Ind DiffFWHM fwhm Lp k N S im Center vpmatrix Cropim Cropbw 

end
toc(TIME)
output.DiamInd = DiamInd;
output.Theta = Theta;
output.FWHMmatrix = FWHMmatrix;
output.XYZ = cat(2,indX,indY,indZ);
output.AnalysisTime = toc(TIME);

% im = squeeze(fImage(:,:,1));
% Center = [50 50];
% [~,theta,~,~] = ...
%         TS_GetLinePro2Matrix(im,Center,Len,NewReso(1));

% output.Pointdata = ppdata;
% output.theta = theta;
% output.Reso = NewReso;
% output.Len = Len;




   
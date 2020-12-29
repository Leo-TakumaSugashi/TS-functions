function output = TS_AutoAnalysisDiam_proto_for(fImage,skel,NewReso,Len)
% output = TS_AutoAnalysisDiam_proto_for(fImage,skel,Reso,Len)
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
for n = 1:length(indY)
% xyz = SEG.Pointdata(n).PointXYZ;
xyz = [indX(n) indY(n) indZ(n)];
im = squeeze(fImage(:,:,xyz(3)));
Center = xyz(1:2);
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
vpmatrix = max(vpmatrix,0);
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
[~,theta,~,~] = ...
        TS_GetLinePro2Matrix(im,Center,50,NewReso(1));
output.Pointdata = ppdata;
output.theta = theta;
output.Reso = NewReso;
output.Len = Len;
output.Analysis_Time = toc(TIME);
toc(TIME)




   
function [PenetDiamImage,DiamImage,bw,skel] = TS_PenetDiamAnalysis(Image,Reso)
%% this func is for sp5 (PMT)
% [PenetDiamImage,bw,skel] = TS_PenetDiamAnalysis(Image,Reso)

%% Initialize
objsiz = [10 10 50];
Aspect_TH = 2.5;
Area_TH = 1.2;
opening_Reso = 1; %% um/pix. using High speed mode
CsizX = 30; %% Radius of Cropsize
CsizY = 30; %% Radius of Cropsize [um]

%% 1st max = 255, min == 0, perslice
adjImage = TS_Image2uint8(Image);
siz = size(adjImage);
%% opening 
% % high speed mode

% [RImage,NewReso] = TS_EqualReso3d_parfor(adjImage,Reso,opening_Reso);
% se = TS_strel(objsiz,NewReso,'cylinder');
% % se = TS_strel(objsiz,NewReso,'ball');
% oRImage = imopen(RImage,se);
% oRImage = TS_imresize3d(oRImage,siz);

% % % normal speed
oRImage = TS_imopen_parfor(adjImage,TS_strel(objsiz,Reso,'cylinder'));

%% Binarize
bw = oRImage > max(oRImage(:))*0.2;

%% set output format
PenetDiamImage = nan(siz,'like',single(1));
skel = false(siz);

%% main function 
xdata = 1:size(Image,2);
ydata = 1:size(Image,1);
% zdata = 1:size(Image,3);
xwin = round(CsizX/Reso(1)); %% Cropsize X
 xwin = xwin + (ceil(xwin/2)==floor(xwin/2));
ywin = round(CsizY/Reso(2)); %% Crop size Y
 ywin = ywin + (ceil(ywin/2)==floor(ywin/2));
wh = waitbar(0,'wait');
whlen = size(bw,3);
for n = 1:size(bw,3)
    bws = bw(:,:,n);
    if max(bws(:))==0
        continue
    end
    im = Image(:,:,n);
     s = regionprops(bws,'Centroid','MinorAxisLength','MajorAxisLength','Area');
    for sn = 1:length(s)
        TF = and((s(sn).MajorAxisLength/s(sn).MinorAxisLength)<=Aspect_TH,...
            ((s(sn).MajorAxisLength*s(sn).MinorAxisLength)/4 * pi)/s(sn).Area < Area_TH);
        if TF
              
        x = round(s(sn).Centroid(1));
        y = round(s(sn).Centroid(2));
        skel(y,x,n) = true;
        
        xind = and(xdata>x-xwin,xdata<x+xwin);
        yind = and(ydata>y-ywin,ydata<y+ywin);
        
        cim = double(im(yind,xind));
        S = sort(cim(:),'descend');
        S = mean(S(1:round(length(S)*0.05)));
        N = double(TS_GetBackgroundValue(im));
        N = max(N,1);
        Threshold = TS_EllipticFittingThreshold(S,N);
        
        exbw = cim >= Threshold;       
        exbw = TS_GetMaxArea(exbw);        
        checkEdge = exbw;
        checkEdge(2:end-1,2:end-1) = 0;
        if max(checkEdge(:))==1
            continue
        end
        exbw = TS_EllipticFittingWatershed_proto(exbw,...
            min(s(sn).MinorAxisLength*Reso(1),4),Reso(1));
        if max(exbw(:)) == 1
            Diam = regionprops(exbw,'Centroid','MinorAxisLength','MajorAxisLength','Area');
            PenetDiamImage(y,x,n) = Diam.MinorAxisLength*Reso(1);
        end
        end
        clear x y
    end
    waitbar(n/whlen,wh,['wait...' num2str(n) '/' num2str(whlen)])
    
end

close(wh)


%% New eddition 
NewSkel = skel;
NewSkel(PenetDiamImage>0) = false;
output = TS_AutoAnalysisDiam_sp5(Image,NewSkel,Reso,100);
[DiamImage,SNRImage] = TS_MeasDiam2DiamImage(NewSkel,output.Pointdata);
DiamImage(SNRImage<2) = nan;
DiamImage = max(cat(4,PenetDiamImage,DiamImage),[],4);




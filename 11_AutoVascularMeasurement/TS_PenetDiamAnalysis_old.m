function [PenetDiamImage,bw] = TS_PenetDiamAnalysis_old(Image,Reso)

objsiz = [10 10 50];
Aspect_TH = 2.5;
Area_TH = 1.2;
OutputReso = 1; %% um/pix.

adjImage = TS_AdjImage(Image);
siz = size(adjImage);
[RImage,NewReso] = TS_EqualReso3d_parfor(adjImage,Reso,OutputReso);
se = TS_strel(objsiz,NewReso,'cylinder');
oRImage = imopen(RImage,se);
oRImage = TS_imresize3d(oRImage,siz);
bw = oRImage > max(oRImage(:))*0.2;
PenetDiamImage = zeros(siz,'like',single(1));

xdata = 1:size(Image,2);
ydata = 1:size(Image,1);
% zdata = 1:size(Image,3);
xwin = round(30/Reso(1));
 xwin = xwin + (ceil(xwin/2)==floor(xwin/2));
ywin = round(30/Reso(2));
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
        
        xind = and(xdata>x-xwin,xdata<x+xwin);
        yind = and(ydata>y-ywin,ydata<y+ywin);
        sx = find(xind);
        sx = sx(1);
        sy = find(yind);
        sy = sy(1);
        cim = double(im(yind,xind));
        S = sort(cim(:),'descend');
        S = mean(S(1:round(length(S)*0.05)));
        N = double(TS_GetBackgroundValue(im));
        exbw = (cim-N)/(S -N) >= 0.5;       
        exbw = TS_GetMaxArea(exbw);        
        checkEdge = exbw;
        checkEdge(2:end-1,2:end-1) = 0;
        if max(checkEdge(:))==1
            continue
        end
        exbw = TS_EllipticFittingWatershed_proto(exbw,...
            min(s(sn).MinorAxisLength*Reso(1),4),Reso(1));
        Diam = regionprops(exbw,'Centroid','MinorAxisLength','MajorAxisLength','Area');
%         TF = and((Diam.MajorAxisLength/Diam.MinorAxisLength)<=Aspect_TH,...
%             ((Diam.MajorAxisLength*Diam.MinorAxisLength)/4 * pi)/Diam.Area < Area_TH);
%         if ~TF
%             continue
%         end
        sx = round(sx-1 + Diam.Centroid(1));
        sy = round(sy-1 + Diam.Centroid(2));
        PenetDiamImage(sy,sx,n) = Diam.MinorAxisLength*Reso(1);
        end
        clear x y
    end
    waitbar(n/whlen,wh,['wait...' num2str(n) '/' num2str(whlen)])
    
end

close(wh)
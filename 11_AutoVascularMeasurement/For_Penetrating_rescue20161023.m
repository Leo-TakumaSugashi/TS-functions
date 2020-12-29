
Enhansed = TS_EnhancedImage(Image,Reso);

mfImage = TSmedfilt2(Image,[5 5]);
h = fspecial('gaussian',7,4/(2*sqrt(2*log(2))));
mfImage = imfilter(mfImage,h,'symmetric');

%% for Penetrating
tic
[LREnhansed,LNewReso] = TS_resize2d(Enhansed,Reso,[128 128]);
toc
bw = TS_ExtractionObj2Mask(LREnhansed,[4 4 4],LNewReso,'ball');
skel = TS_Skeleton3D(bw);
% DLREnhansed = TS_deconv_proto_gammaLog(LREnhansed,LNewReso);

oEnhansed = padarray(LREnhansed,[0 0 1],0);
se = TS_strel([10 10 50],LNewReso,'cylinder');
oEnhansed = imopen(oEnhansed,se);
oEnhansed(:,:,[1 size(oEnhansed,3)]) = [];
bw = TS_ExtractionObj2Mask(oEnhansed,[4 4 4],LNewReso,'ball');

%% manual Input
SurfaceInd = 67;
Aspect_TH = 2.5;
Area_TH = 1.2;

Centroid = false(size(bw));
for n = 1:size(bw,3)
    sbw = bw(:,:,n);
    s = regionprops(sbw,'Centroid','MinorAxisLength','MajorAxisLength','Area');
    for sn = 1:length(s)
        TF = and((s(sn).MajorAxisLength/s(sn).MinorAxisLength)<=Aspect_TH,...
            ((s(sn).MajorAxisLength*s(sn).MinorAxisLength)/4 * pi)/s(sn).Area < Area_TH);
        if TF
        x = s(sn).Centroid(1);
        y = s(sn).Centroid(2);
        Centroid(round(y),round(x),n) = true;
        end
        clear x y
    end
    clear sbw s sn
end

Pbw = bw;
Pbw(:,:,SurfaceInd:end) = false;
for n = flip(SurfaceInd:size(bw,3))
    sbw = bw(:,:,n);
    scen = Centroid(:,:,n);
    [L,~] = bwlabel(sbw,8);
    Ind = L(scen);
    Ind(Ind==0) = [];
    for nn = 1:length(Ind)
        Pbw(:,:,n) = or(Pbw(:,:,n),L==Ind(nn));
    end
    clear Ind L NUM sbw scen nn
end

LPbw = bwlabeln(Pbw,26);
sPbw = Pbw(:,:,SurfaceInd);
sLPbw = LPbw(:,:,SurfaceInd);
[h,x] = hist(sLPbw(sPbw),0:max(sLPbw(sPbw)));
NUM_Ind = x(h>0);
Pbw = false(size(Pbw));
for n = 1:length(NUM_Ind)
    Pbw = or(Pbw,LPbw==NUM_Ind(n));
end

% % Branch
Branch = skel;
Branch(Pbw) = false;
Branch = and(Branch,imdilate(Pbw,ones(3)));


%% 
% 
% figure,
% p = patch(isosurface(padarray(ReductMask,[1 1 1],0),0),'EdgeColor','none','FaceColor','g');
% daspect(ones(1,3))
% alpha(0.2)
% axis tight
% view(3)
% hold on
% p(3) = pointview(padarray(Branch,ones(1,3)*2,0),ones(1,3));
% 
% p(3) = patch(isosurface(padarray(and(Pbw,bw),[1 1 1],0),0),'EdgeColor','none','FaceColor','g');
% alpha(p(3),0.2)
% % oEnhansed = TS_resize2d(oEnhansed,LNewReso,[size(Image,1) size(Image,2)]);
% 
% %% BW
% pTH = 0.2;
% pbw = false(size(Image));
% for n = 1:size(Image,3)
%     im = single(oEnhansed(:,:,n));
%     S = max(im(:));
%     M = mode(im(and(im>0,im<S*0.95)));
%     im = (im -M) ./(S - M);
%     pbw(:,:,n) = im >= pTH;
%     clear im S M 
% end
%     
    
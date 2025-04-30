function output = TS_ExtraPenet_rescue(Image,Enhansed,Reso)

%% manual Input
% SurfaceInd = 67;
Aspect_TH = 2.5;
Area_TH = 1.2;
Surface_TH = 20; % unit %
ctex = clock;
ctex = [num2str(ctex(1)) '_' num2str(ctex(2)) '_' num2str(ctex(3))...
    '_' num2str(ctex(4)) '_' num2str(ctex(5))];

%% main flow
% Enhansed = TS_EnhancedImage(Image,Reso);

mfImage = TSmedfilt2(Image,[5 5]);
h = fspecial('gaussian',7,4/(2*sqrt(2*log(2))));
mfImage = imfilter(mfImage,h,'symmetric');

%% for Penetrating
tic
[LREnhansed,LNewReso] = TS_resize2d(Enhansed,Reso,[128 128]);
toc
BW = TS_ExtractionObj2Mask(LREnhansed,[4 4 4],LNewReso,'ball');
skel = TS_Skeleton3D(BW);
% DLREnhansed = TS_deconv_proto_gammaLog(LREnhansed,LNewReso);

oEnhansed = padarray(LREnhansed,[0 0 1],0);
se = TS_strel([10 10 50],LNewReso,'cylinder');
oEnhansed = imopen(oEnhansed,se);
oEnhansed(:,:,[1 size(oEnhansed,3)]) = [];
bw = TS_ExtractionObj2Mask(oEnhansed,[4 4 4],LNewReso,'ball');

%% **** surface Index
[V,fgh] = TS_EachDepthVolumeHist(bw,Reso(3),Reso(3));
surf_ind = find(V.Hist>Surface_TH);
SurfaceInd = size(Image,3) - surf_ind(end);
saveas(fgh,['Volume_FIG' ctex '.fig'],'fig')
close(fgh)


%% Separate Penet or Surface Bold Vascular
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
sPbw = Pbw(:,:,SurfaceInd:end);
sLPbw = LPbw(:,:,SurfaceInd:end);
[h,x] = hist(sLPbw(sPbw),0:max(sLPbw(sPbw)));
NUM_Ind = x(h>0);
Pbw = false(size(Pbw));
for n = 1:length(NUM_Ind)
    Pbw = or(Pbw,LPbw==NUM_Ind(n));
end

%% Branch
Branch = skel;
Branch(Pbw) = false;
Branch = and(Branch,imdilate(Pbw,ones(3)));

%% output
output.InputImage = Image;
output.InputResolution = Reso;
output.mfImage = mfImage;
output.Enhansed = Enhansed;
output.Resize_size = size(LREnhansed);
output.Resize_Resolution = LNewReso;
output.Surface_Threshold = Surface_TH;
output.Surface_Index = SurfaceInd;
output.Resize_BW = BW;
output.Resize_skel = skel;
output.open_Resize_Enhansed = oEnhansed;
output.Pre_Penet_Mask = bw;
output.Penet_Mask = Pbw;
output.Branch_Mask = Branch;
%% 
% 
fgh = figure;
p = patch(isosurface(padarray(Pbw,[1 1 1],0),0),'EdgeColor','none','FaceColor','g');
daspect(ones(1,3))
alpha(0.2)
axis tight
view(3)
hold on
p(2) = pointview(padarray(and(Centroid,Pbw),ones(1,3)*2,0),ones(1,3));
p(3) = pointview(padarray(Branch,ones(1,3)*2,0),ones(1,3));
p(3).Marker = 'p';
legend('Penetrating Mask','Centroid','Branch Point')
saveas(fgh,['Penet_FIG' ctex '.fig'],'fig')
close(fgh)
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
    
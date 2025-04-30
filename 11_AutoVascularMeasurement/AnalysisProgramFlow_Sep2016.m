
Image = Original_Image;
% clear Original_Image;
mImage = TSmedfilt2(Image,[3 3]);
se = fspecial('gaussian',7,1.8);
% figure,imagesc(se)
mfImage = imfilter(mImage,se,'symmetric');
[RmfImage,NewReso] = TS_EqualReso3d(mfImage,Reso,1);
RImage = TS_EqualReso3d(Image,Reso,1);
ObjSiz = [4 4 1]; %% um
bw = TS_ExtractionObj2Mask(RmfImage,ObjSiz,NewReso,'disk');

%% Check
% SNR = TS_GetSNVolumedata(RmfImage,NewReso(3),bw,'figure');
    fv = isosurface(flip(bw,3),0);
    figure,p = patch(fv,'EdgeColor','none','FaceColor',[1 0 0]);
    view(3),daspect(ones(1,3))
    axis tight
    grid on
    set(gca,'Ydir','reverse','Zdir','reverse')
    camh = camlight;
    reducepatch(p,.5)
    fvc = isocaps(flip(bw,3),0);
    hold on
    p(2) = patch(fvc,'EdgeColor','none','FaceColor',[1 0 0]);
    

% set(1,'Paperposition',[.6 .6 15 20])
% saveas(1,'ManualAnalysisedWholeBWpatch_001.tif','tif')

%% 解析対象を絞る
    fv = isosurface(flip(bw(:,:,end-199:end),3),0);
    figure,p = patch(fv,'EdgeColor','none','FaceColor',[1 0 0]);
    view(3),daspect(ones(1,3))
    axis tight
    grid on
    set(gca,'Ydir','reverse','Zdir','reverse')
    camh = camlight;
    reducepatch(p,.5)
    fvc = isocaps(flip(bw(:,:,end-199:end),3),0);
    hold on
    p(2) = patch(fvc,'EdgeColor','none','FaceColor',[1 0 0]);
% set(1,'Paperposition',[.6 .6 15 15])
% saveas(1,'ForAnalysisBWpatch_000.tif','tif')
% saveas(1,'ForAnalysisBWpatch_000.fig','fig')
%%
BW = flip(bw,3);
BW(:,:,201:end) = [];
BW(37,20:30,end-2:end) = false;
[L,NUM] = bwlabeln(BW,26);
s = regionprops(L,'Area');
s = cat(1,s.Area);
[~,Ind] = max(s);
BW = L == Ind;
BW = flip(BW,3);
clear L Ind NUM

%% Check
    fv = isosurface(flip(BW,3),0);
    figure,p = patch(fv,'EdgeColor','none','FaceColor',[1 0 0]);
    view(3),daspect(ones(1,3))
    axis tight
    grid on
    set(gca,'Ydir','reverse','Zdir','reverse')
    camh = camlight;
    reducepatch(p,.5)
    fvc = isocaps(flip(BW,3),0);
    hold on
    p(2) = patch(fvc,'EdgeColor','none','FaceColor',[1 0 0]);
%% making
BW(111,166:191,47:62) = false;
[L,NUM] = bwlabeln(BW,26);
BW = L == 2;clear L NUM

%% 解析対象を絞り込んだ。phantom Image
Obj_RmfImage = RmfImage(:,:,end-199:end);
Obj_RImage = RImage(:,:,end-199:end);
% save phantomImageBW BW Obj_RmfImage
% set(2,'PaperPosition',[.6 .6 12 12])
% saveas(2,'ForAnalysisBWpatch_010.tif','tif')
% saveas(2,'ForAnalysisBWpatch_010.fig','fig')

%% skeletoning
skel = Skeleton3D(BW);
skel2 = TS_bwmorph3d(skel,'thin');
 pointview(skel2,NewReso,'figure')
 view(3)
%  set(3,'PaperPosition',[.6 .6 12 12])
%  saveas(3,'ForAnalysisSkelPointview_011.tif','tif')
%  saveas(3,'ForAnalysisSkelPointview_011.fig','fig')

 
SEG1 = TS_AutoSegment1st(skel2,NewReso);
CutLen = 10;
SEG2 = TS_AutoSegment2nd(SEG1,CutLen);
SEG3 = TS_AutoSegment2nd(SEG2,CutLen);
SEG4 = TS_AutoSegment2nd(SEG3,CutLen);
%  set(4,'PaperPosition',[.6 .6 33 21])
%  saveas(4,'ForAnalysisSegmented_013.tif','tif')
handle = Segmentview(SEG4,1);
set(handle.txh,'FontWeight','demi')
view(3)
% set(1,'PaperPosition',[.6 .6 20 20])
% saveas(1,'ForAnalysisSegmented_014.tif','tif')



%% measure diameter
num = length(SEG4.Pointdata);
pointDist = 2;
CropDist = 15;
 %% check
n = 36;
    xyz = SEG4.Pointdata(n).PointXYZ;
    cropbw = false(size(BW));
    for k = 1:size(xyz,1)
        cropbw(round(xyz(k,2)),round(xyz(k,1)),round(xyz(k,3))) = true;
    end
    Pointbw = bwdist(cropbw) <=pointDist; 
    cropbw = bwdist(cropbw) <=CropDist;
    disp(['No. ' num2str(n) '  ..Axis Z [' num2str(min(xyz(:,3))) ' ' num2str(max(xyz(:,3))) ']'])
    disp(['Length : ' num2str(sum(xyz2plen(xyz,NewReso)))])
    xyztviewer2016_proto(...
        cat(5,uint16(cropbw).*Obj_RImage,uint16(Pointbw).*Obj_RImage))
%% 手動でROIを終えたら。。
wh = warndlg('Save ROI ??');
waitfor(wh)
ROI = getappdata(gcf,'NowROIdata');
xyz_len = zeros(1,4);
for k = 1:length(ROI)
    p = getPosition(ROI(k).handle);
    dep = double(ROI(k).Depth);
    p = cat(2,p,[dep;dep]);
    len = sum(xyz2plen(p,NewReso));
    xyz_len(k,:) = [mean(p,1) len];
    clear p dep len
end
disp(['No. ' num2str(n)])
% disp(num2str(xyz_len))
xlswrite('output_byHand.xlsx',xyz_len,n)















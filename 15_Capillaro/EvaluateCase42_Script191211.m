% % For evaluation of case 42 , just script
Pd = '/mnt/NAS/SSD/TSfun20191210/15_Capillaro';
ObjD =  '/mnt/NAS/Share2/Capillaliy_Of_fingertip/Experimentdata/181125';
SaveDir = '/mnt/NAS/Share2/Capillaliy_Of_fingertip/Summary_Case42';
% DataSet =  '/mnt/NAS/Share2/Capillaliy_Of_fingertip/CapDataset_20191125/labelsTr';
DataSet = '/mnt/NAS/Share2/Capillaliy_Of_fingertip/Summary_Case42/01_Sugashi_TrueBWimages';
% Data = dir([DataSet '/Cap_*.mat']);
Data = load([DataSet  '/Case_42_True_20191212.mat']);
if ~exist(SaveDir,'dir')
    mkdir(SaveDir)
end
Fdir = dir([ObjD '/*mae.avi'])
for n = 1:length(Fdir)
    x = Fdir(n).name(1:end-7);
    Fdir(n).ID = str2double(x);
end
[~,ind] = sort(cat(1,Fdir.ID));
Fdir = Fdir(ind);
clear ind x 
%%
CapFun = Capillaro_MatFunctions;
for n = 1:length(Fdir)
    [Vi,vdata]=CapFun.LoadVideo([ObjD '/' Fdir(n).name],0);
    Fdir(n).cdata = Vi(1).cdata;
    TS_WaiteProgress(n/length(Fdir))
end
clear Vi vdata ind
X = TS_montage(cat(4,Fdir.cdata),6,20,[.5 .5 .5]);
imwrite(X,[SaveDir '/Case42_Montage.tif'])
clear X
save([SaveDir '/FirstSliceImage.mat'],'Fdir')

%% load True
for n = 1:length(Fdir)
%     clear cropLabel
%     try 
%         load([Data(n).folder '/' Data(n).name])
%         bw = cropLabel;
%     catch 
%         bw = false(size(Fdir(n).cdata,1),size(Fdir(n).cdata,2));
%     end
    bw = Data.data(n).bw(:,:,1)>200;
    Fdir(n).TrueLabel = bw;
    clear cropLabel bw
end
X = cat(4,Fdir.TrueLabel);
X = uint8(repmat(X,[1 1 3]))*255;
X = TS_montage(X,6,20,[.5 .5 .5]);
imwrite(X,[SaveDir '/Case42_MontageTrue.tif'])
figure,imagesc(X),axis image
clear X

%% skel to SEG
Reso = [0.6836  0.6836  0];
for n = 1:length(Fdir)
    bw = Fdir(n).TrueLabel;
    bw = bwareaopen(~bw,10);
    skel = bwskel(~bw);
    if max(skel(:))
        Fdir(n).SEG = TS_AutoSEG_mex(skel,Reso,[],20);
        Fdir(n).SEGinput = ~bw;
    else
        Fdir(n).SEG = [];
        Fdir(n).SEGinput = ~bw;
    end
    clear bw skel
end

fgh = figure;
axh = TS_subplot(gcf,[6 7],0.001);
FOV = size(Fdir(n).TrueLabel,[2 1]).*Reso(1:2);
for n = 1:length(Fdir)
    aaa = SEGview(axh(n),Fdir(n).SEG);
    ph(n) = aaa{1};clear aaa
    ph(n).Marker = '.';
    ph(n).MarkerSize = 8;
    xlim(axh(n),[0 FOV(1)])
    ylim(axh(n),[0 FOV(2)])
end

for n = 1:42
    axh(n).XTickLabel = '';
    axh(n).YTickLabel = '';
end
saveas(fgh,[SaveDir '/SEGview.fig']);
saveas(fgh,[SaveDir '/SEGview.tif']);

%% Add Spatial Evaluations
Sf = Segment_Functions;
Sf.RFitting_WindowSize = [0.5:0.5:20];
ResampleReso = 0.5;
for n = 1:length(Fdir)
    SEG = Fdir(n).SEG;
    if isempty(SEG)
        Fdir(n).MSEG = [];
    else
        SEG = Sf.SmoothingSEG(SEG,ResampleReso,[1 1 1]);
        SEG = Sf.AddSpatialPhysicalQuantity_Capillaro(SEG,'-f');
        Fdir(n).MSEG = SEG;
    end
    clear SEG
end


%% plot Strat num vs Windww size
fgh = figure;
axh = TS_subplot(fgh,[2 2],0.05);
for n = 1:length(Fdir)
    SEG = Fdir(n).MSEG;
    if isempty(SEG)
        continue
    end
    Snum = cat(2,SEG.Pointdata.StraghtNumber);
    Snum = sum(Snum,2);
    Snum = Snum./length(SEG.Pointdata);
    plot(axh(1),Sf.RFitting_WindowSize*2,Snum,'-','Color',[.5 .5 .5]);
    hold(axh(1),'on')
   
    Snum = cat(2,SEG.Pointdata.StraghtMaximumLength);
    Snum = nanmean(Snum,2);
%     Snum = Snum./length(SEG.Pointdata);
    plot(axh(2),Sf.RFitting_WindowSize*2,Snum,'-','Color',[.5 .5 .5]);
    hold(axh(2),'on')
   
    Snum = cat(2,SEG.Pointdata.StraghtSumationLength);
    Snum = sum(Snum,2)./sum(cat(1,SEG.Pointdata.Length));
    plot(axh(3),Sf.RFitting_WindowSize*2,Snum,'-','Color',[.5 .5 .5]);
    hold(axh(3),'on')
    
    Snum = cat(2,SEG.Pointdata.CurveMinimumR);
    Snum = nanmin(Snum,Sf.StraghtAS);
    Snum = nanmean(Snum,2);
    plot(axh(4),Sf.RFitting_WindowSize*2,Snum,'-','Color',[.5 .5 .5]);
    hold(axh(4),'on')
end
saveas(fgh,[SaveDir '/4Param_forWindowsize.fig'])
saveas(fgh,[SaveDir '/4Param_forWindowsize.tif'])

%%

for n = 1:length(axh(1).Children)
    Var1(n,:) = axh(1).Children(n).YData;
    Var2(n,:) = axh(2).Children(n).YData;
    Var3(n,:) = axh(3).Children(n).YData; 
    Var4(n,:) = axh(4).Children(n).YData; 
end
v1 = std(Var1,[],1);v1 = v1';
v2 = std(Var2,[],1);v2 = v2';
v3 = std(Var3,[],1);v3 = v3';
v4 = std(Var4,[],1);v4 = v4';
fgh = figure;
a = TS_subplot(gcf,[2 2],0.05);
plot(a(1),Sf.RFitting_WindowSize*2,v1,'Color',[.3 .3 .3]);
plot(a(2),Sf.RFitting_WindowSize*2,v2,'Color',[.3 .3 .3]);
plot(a(3),Sf.RFitting_WindowSize*2,v3,'Color',[.3 .3 .3]);
plot(a(4),Sf.RFitting_WindowSize*2,v4,'Color',[.3 .3 .3]);
saveas(fgh,[SaveDir '/4Param_forWindowsize_SD.fig'])
saveas(fgh,[SaveDir '/4Param_forWindowsize_SD.tif'])

%% [B,BINT,R,RINT] = regress(Y,X)
Y = Sf.RFitting_WindowSize*2;
Y = Y';
X = [ones(size(v1)), v1 v3 v4];
[B,BINT,R,RINT] = regress(Y,X)

fgh = figure;
p = plot(Y,R.^2,'k-');
p.LineWidth = 3;
saveas(fgh,[SaveDir '/Determin_forWindowsize.fig'])
saveas(fgh,[SaveDir '/Determin_forWindowsize.tif'])


%% R-maping
for n = 1:length(Fdir)
    SEG = Fdir(n).MSEG;
    Rs = [];
    for k = 1:length(SEG.Pointdata)
        rs = squeeze(SEG.Pointdata(k).SphereFitRadius)';
        Rs = [Rs rs nan(size(rs,1),1)];
    end
    Len = sum(cat(1,SEG.Pointdata.Length));
    Fdir(n).Rmaps = flip(Rs,1);
    c = 1;
    Rsave = Rs;
    for L = 1:40
        Rs = Rsave(1:L,:);
        r = sum(and(Rs(:)>0,Rs(:)<Sf.StraghtAS));
        s = sum(Sf.StraghtAS<=Rs(:));
        A(:,:,c) = [r s];
        c = c + 1;
    end
    Fdir(n).NormalizedSumation_RandS = A./Len;
    Fdir(n).Sumation_RandS = A ;
    clear Len r s Rs SEG Rsave c L A
end

%%
fgh = figure;
r = cat(1,Fdir.NormalizedSumation_RandS);
n = 1;
p = plot(r(:,1,n),r(:,2,n),'*k');
hold on
Markers = '*oxs^dph';
for n = 2:size(r,3)
    p(n) = plot(r(:,1,n),r(:,2,n),[Markers(n) 'k']);
end
legend('less WS 40um','30um','20um','10um')
saveas(fgh,[SaveDir '/NormalizedSumation_RadvsStr.fig'])
saveas(fgh,[SaveDir '/NormalizedSumation_RadvsStr.tif'])
%%
fgh = figure;
r = cat(1,Fdir.Sumation_RandS);
n = 1;
p = plot(r(:,1,n),r(:,2,n),'*k');
hold on
Markers = '*oxs^dph';
for n = 2:size(r,3)
    p(n) = plot(r(:,1,n),r(:,2,n),[Markers(n) 'k']);
end
legend('less WS 40um','30um','20um','10um')
saveas(fgh,[SaveDir '/JustSumation_RadvsStr.fig'])
saveas(fgh,[SaveDir '/JustSumation_RadvsStr.tif'])

%% class
fgh = figure;
axh = TS_subplot(fgh,[2 1],0.1);
r = cat(1,Fdir.Sumation_RandS);
r = squeeze(std(r,[],1));
Y = Sf.RFitting_WindowSize*2;
p(1) = plot(axh(1),Y,r(1,:),'+');
p(2) = plot(axh(2),Y,r(2,:),'o');
saveas(fgh,[SaveDir '/JustSumation_RadvsStr_SD.fig'])
saveas(fgh,[SaveDir '/JustSumation_RadvsStr_SD.tif'])
%% regress
Y = Sf.RFitting_WindowSize*2;
Y = Y';
X = [ones(size(r,2),1), r(1,:)' r(2,:)'];
[B,BINT,R,RINT] = regress(Y,X)

fgh = figure;
plot(Y,R.^2,'-k','LineWidth',3)




%% Evaluate Binalize
%% vs FFT of Kusaka
KusakaDir = '/mnt/NAS/Share2/Capillaliy_Of_fingertip/kusaka/bggrayim';
Kdir = dir([KusakaDir '/*mae'])
for n = 1:length(Kdir)
    x = Kdir(n).name(1:end-3);
    Kdir(n).ID = str2double(x);
end
[~,ind] = sort(cat(1,Kdir.ID));
Kdir = Kdir(ind);
clear ind x 
%%
for n = 1:length(Kdir)
    x = load([KusakaDir '/' Kdir(n).name '/Zim_NotMask.mat'],...
        'LFAmpImage','HFAmpImage');    
    Kdir(n).LFA = x.LFAmpImage;
    Kdir(n).HFA = x.HFAmpImage;
    clear x
end
%%
X1 = cat(4,Kdir.LFA);
X2 = cat(4,Kdir.HFA);
X = X1./X2;
BW = uint8(X);
for n =1:size(X,4)
    x = X(:,:,:,n);
    Outlines = or(x==0,isnan(x));
    ClimArea = X(:,:,:,n);
    ClimArea = ClimArea(~isnan(ClimArea));
    SD = nanstd(ClimArea(:));
    Ave = nanmean(ClimArea(:));
    Clim = [Ave-2*SD Ave+2*SD];
    x = (x-Clim(1))./diff(Clim);
    x = max(x,0);
    x = min(x,1);
    level = graythresh(x(~isnan(x)));
    x = min(x*255,255);
    X(:,:,:,n) = x;
    bw = x > Ave;
    if sum(bw(~Outlines))/numel(bw(~Outlines)) >0.5
        bw = ~bw;
    end
    bw(Outlines) = false;
    BW(:,:,:,n) = uint8(bw)*255;
    clear x ClimArea SD Ave Clim
end
XX = X;    
X = repmat(X,[1 1 3]);
X = TS_montage(X,6,20,[.5 .5 .5]);
Figure,imagesc(X),axis image
% imwrite(X,[SaveDir '/FFT_Ratio_montage2.tif'])
BWX = squeeze(BW);
BW = repmat(BW,[1 1 3]);
BW = TS_montage(BW,6,20,[.5 .5 .5]);
Figure,imagesc(BW),axis image
% imwrite(BW,[SaveDir '/FFT_Ratio_montage2BW.tif'])

%% Eval
R = cat(3,Fdir.TrueLabel);
Ev = TS_EvalBinalize(R,BWX)

%% spacial otsu BW
bw = Fdir(1).cdata(:,:,2);
BW = repmat(false(size(bw)),[1 1 length(Fdir)]);
for n =1:length(Fdir)
    bw = Fdir(n).cdata(:,:,2);
    bw = abs(single(bw)-255);
    bw = TS_im2bw_block_v2019a(bw,[8,10]);   
    BW(:,:,n) = bw;
   
end
BWX = squeeze(BW);
BW = repmat(permute(uint8(BWX)*255,[1 2 4 3]),[1 1 3]);
BW = TS_montage(BW,6,20,[.5 .5 .5]);
Figure,imagesc(BW),axis image
imwrite(BW,[SaveDir '/BWblock_montage2BW.tif'])

%% Eval
R = cat(3,Fdir.TrueLabel);
Ev = TS_EvalBinalize(R,BWX)

%% Unet
load('trainedUNetValid-13-Dec-2019-20-20-51-Epoch-10.mat')
for n = 1:42
    if n <= 36
        Fdir(n).UnetResult = [];
    else
        bw = CapFun.ExtractCapillaries_unet_proto(net,Fdir(n).cdata);
        Fdir(n).UnetResult = bw;
    end
end


%% histogram of Curve
fgh = figure;
axh = TS_subplot(fgh,[6 7],.001);
MaxH = 0;
MaxLen = 0;
for n = 1:length(Fdir)
    Rmap = Fdir(n).Rmaps;
    MaxLen = max(MaxLen,size(Rmap,2));
    [h,x]=hist(Rmap(and(~isnan(Rmap),Rmap<30)),0:30);
    MaxH = max(MaxH,max(h));
    h = h./max(h);
    bh(n) = bar(axh(n),x,h);
    bh(n).BarWidth = 1;
    axh(n).XTickLabel = '';
    axh(n).YTickLabel = '';
    axh(n).YLim = [0 1.1];
    axh(n).XLim = [0 30];
    clear h x Rmap
end
saveas(fgh,[SaveDir '/NormalizedHistogram_Rmaps.fig'])
saveas(fgh,[SaveDir '/NormalizedHistogram_Rmaps.tif'])
%%
fgh = figure;
axh = TS_subplot(fgh,[6 7],.001);
for n = 1:length(Fdir)
    Rmap = Fdir(n).Rmaps;
    MaxLen = max(MaxLen,size(Rmap,2));
    [h,x]=hist(Rmap(and(~isnan(Rmap),Rmap<30)),0:30);
   
    bh(n) = bar(axh(n),x,h);
    bh(n).BarWidth = 1;
    axh(n).XTickLabel = '';
    axh(n).YTickLabel = '';
    axh(n).YLim = [0 MaxH];
    axh(n).XLim = [0 30];
    clear h x Rmap
end
saveas(fgh,[SaveDir '/Histogram_Rmaps.fig'])
saveas(fgh,[SaveDir '/Histogram_Rmaps.tif'])
%% Padding
for n = 1:length(Fdir)
    Rmap = Fdir(n).Rmaps;
    Rmap = padarray(Rmap,[0 MaxLen-size(Rmap,2)],nan,'post');
    Fdir(n).PaddingRmaps = Rmap;
    clear Rmap
end
X = cat(1,Fdir.PaddingRmaps);

figure,imagesc(X),
caxis([0 30])
colormap(cat(1,[0 0 0],flip(GetColorChannels(28),1),[.5 .5 .5]))
Map = colormap;
X = min(X,30);
X = uint8(X);
imwrite(X,Map,[SaveDir '/Padding_Rmaps.tif'])





















 
%%Script for Analysis Capillaro 4D Image data

CapFun = Capillaro_MatFunctions;
V = Sugashi_ReconstructGroup;
% load Movie name
FULLPATH = CapFun.UIGetVideoPath();
TIME = tic;
% load Video data to mat
[Vi,vdata] = CapFun.LoadVideo(FULLPATH);
CapFun.VideoData = Vi;
CapFun.VideoInfomation = vdata;
CapFun.XYSize = [vdata.Width vdata.Height];
disp('load Vidieo')
toc(TIME)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%check Resolution %%%%%%%
CapFun.FOV = (CapFun.XYSize-1).*[  0.6836    0.6836 ];         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vdata %% this is last frame infomation.
Reso = [CapFun.Resolution 0]
clear Vi vdata
%% Blind Deconv
tic
Image = cat(4,CapFun.VideoData.cdata);
TimeInd = cat(2,CapFun.VideoData.CurrentTime);
if false
    CapFun.InputPSF_KernelSize = 13;
    CapFun.InputPSF_Sigma = 3;
    CapFun.InputPSF_VerticalCoef = 0.0002;
end
DImage = CapFun.Blind_Deconv(Image,'green');

disp('Deconv.')
toc

%% Reposition
toc
if false
    ShiftXY = CapFun.TSXCORR2(DImage);
elseif true
    ShiftXY = CapFun.DetectFeatures2ROI_RepositXY(DImage);
    RDImage = CapFun.ShiftXY2RepositImage(DImage,ShiftXY);
    RImage = CapFun.ShiftXY2RepositImage(Image,ShiftXY);
elseif false
    TForm = CapFun.EstimateGeometricTransformation(DImage);
    RDImage = CapFun.TformTranslation(TForm,DImage);
elseif false
    TForm = CapFun.DetectSURFFeaturesReposit(DImage);
    RDImage = CapFun.TformTranslation(TForm,DImage);
end
disp('Reposition')
toc

%% Binalization from original Image
tic
% slice_im = squeeze(nanmean(RImage(:,:,1,CapFun.BWReferenceInd),4));
% [skel,RGB] = CapFun.Slice2skel(slice_im);
% figure,imagesc(RGB),axis image off
%% Binalization from Deconv Image
% slice_im = squeeze(nanmean(RDImage(:,:,1,CapFun.BWReferenceInd),4));
slice_im = squeeze(nanmean(RDImage(:,:,:,CapFun.BWReferenceInd),4));
[skel,RGB] = CapFun.Slice2skel(uint8(slice_im));
figure,imagesc(RGB),axis image off
disp('BW and skeleton')
toc

%% Segmentation
tic
SEG = CapFun.Skel2Segment(skel);
toc
%% using spatial infomation including Diameter??
im = single(squeeze(nanmean(RDImage(:,:,1,1:10),4)));
% im = single(squeeze(nanmean(RDImage(:,:,:,CapFun.ReferenceSliceInd),4)));
im = abs(im - max(im(:)));
im = TS_Circmedfilt(im,round(2/Reso(1)));
NewSEG = TS_AutoAnalysisDiam_Capillaro(im,Reso,SEG)
% NewSEG = TS_AutoAnalysisDiam_SEG_v2019Elza(imcomplement(slice_im),Reso,'fwhm',SEG)

%% AutoSelect Segment
tic
RMSEG = CapFun.AutoSelectSEG(NewSEG);
disp('Auto Select Segment')
toc
%% check
im = TS_AdjImage(imcomplement(DImage(:,:,:,1)));
% im = TS_AdjImage(abs(slice_im*255/max(slice_im(:))-255));
figure,imagescReso(ind2rgb(im,gray(256)),Reso),hold on
p = V.SEGview_Limit(gca,RMSEG,'SNR');
p.LineWidth = 2;
p.Marker = '.';
view(2)
% set(gca,'Posi',[0 0 1 1])
colormap(cat(1,[.5 .5 .5],jet(256)))
%% check
% im = TS_AdjImage(imcomplement(DImage(:,:,:,1)));
% figure,imagescReso(ind2rgb(im,gray(256)),Reso),hold on
im = Image(:,:,:,1);
figure,imagescReso(im,Reso),hold on
p = V.SEGview_Limit(gca,NewSEG,'Diameter');
p.LineWidth = 2;
p.Marker = '.';
view(2)
% p = V.SEGview_Limit_text(gca,RMSEG);
% for n = 1:length(p)
%     p(n).Color = 'w';
% end
% set(gca,'Posi',[0 0 1 1])
p = colorbar;
p.Label.String = 'Diameter [\mum]';
colormap(cat(1,[.5 .5 .5],jet(256)))
%% Counter / mm
im = TS_AdjImage(imcomplement(DImage(:,:,:,1)));
im = Image(:,:,:,1);
% [NUM,ID_sorted] = CapFun.AutoSegmentCounter(NewSEG,ind2rgb(im,gray(256)));

[NUM,ID_sorted,Y,X] = CapFun.AutoSegmentCounter(NewSEG,im);

ph = findobj('Type','Line','Parent',gca);
txh = findobj('Type','text','Parent',gca);
UnitNum = NUM / prod(CapFun.FOV(2)/1000)

%%

[data,CC] = CapFun.EvaluateSpatialShape(NewSEG);
toc(TIME)


%% Velocity
FPS = 30;
M2SEG = CapFun.Output_Velocity_proto(NewSEG,RDImage,FPS);


%% figure
fgh = CapFun.OutputFig;
axh(1) = axes('Position',[.01 .75 .48 .22]);
imagesc(axh(1),CapFun.VideoData(1).cdata)
axis(axh(1),'image')
axis(axh(1),'off')
title('Input Raw Image')

axh(2) = axes('Position',[.51 .75 .48 .22]);
R = max(RGB,[],3);
G = false(NewSEG.Size);
G(NewSEG.Output) = true;
G = imdilate(G,ones(3));
G(~R) = true;
R = cat(3,~R,G,~R);
imagescReso(axh(2),R,Reso);
axis(axh(2),'image')
axis(axh(2),'off')
hold(axh(2),'on')
title(axh(2),'Extracted Cap. by U-net')

axh(3) = axes('Position',[.01 .50 .48 .22]);
im = CapFun.AdjustContrast(CapFun.VideoData(1).cdata);
imagescReso(axh(3),im,Reso)
axis(axh(3),'image')
axis(axh(3),'off')
hold(axh(3),'on')
ph = plot(axh(3),Y,X,'o:','LineWidth',2);
title(axh(3),'Number / mm')


axh(4) = axes('Position',[.51 .50 .48 .22]);
ph = V.SEGview_Limit(axh(4),NewSEG,'Diameter');
ph.LineWidth = 3;
ph.Marker = '.';
axh(4).XLim = axh(3).XLim;
axh(4).YLim = axh(3).YLim;
view(2)
ph = colorbar(axh(4),'southoutside');
ph.Position = [0.6 0.46 0.3 0.014];
ph.FontSize = 15;
ph.Label.String ='Diameter [\mum]';
colormap(kjet)
% uih = uitable(fgh,'Position',[ 43   388   433   300]);



axh(5) = axes('Position',[.51 .15 .48 .22]);
ph = V.SEGview_Limit(axh(4),SEG,'Diameter');
ph.LineWidth = 3;
ph.Marker = '.';
axh(4).XLim = axh(3).XLim;
axh(4).YLim = axh(3).YLim;
view(2)
ph = colorbar(axh(4),'southoutside');
ph.Position = [0.6 0.46 0.3 0.014];
ph.FontSize = 15;
ph.Label.String ='Diameter [\mum]';
colormap(kjet)




uih = uitable(fgh,'Position',[ 43   8   200   300]);
uih.ColumnWidth = {200,190};
set(uih,'Data',CC)

uih(2) = uicontrol(fgh,...
    'Style','text',...
    'Position',[ 43   330   433   30],...
    'String',['Number of Cap. :' num2str(UnitNum,'%.1f') '/mm'],...
    'FontSize',15);

MedD = nanmedian(cat(1,SEG.Pointdata.Diameter));
Ages = load('Case42_MedD2Age.mat');
PredictAge = polyval(Ages.Val,MedD);

uih(3) = uicontrol(fgh,...
    'Style','text',...
    'Position',[3   290   630   30],...
    'String',['Median Diameter: ' num2str(MedD,'%.1f') ' um ...' ...
    'Predict Ur Age is ' num2str(PredictAge,'%.1f')],...
    'FontSize',15);

%%
print(fgh)




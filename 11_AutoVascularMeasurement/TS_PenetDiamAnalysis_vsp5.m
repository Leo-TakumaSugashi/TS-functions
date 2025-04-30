function [SEG_bold,BoldDiamImage,PenetDiamImage,cbw,PSNRImage,SNRImage] = TS_PenetDiamAnalysis_vsp5(RmfImage,REnhansed,NewReso)
%% this func is for sp5 (PMT)
% [PenetDiamImage,bw,skel] = TS_PenetDiamAnalysis_vsp5(Image,Reso)

% editor's log...
% 2017 06 16 , sugashi,
%     SNによるかいせき結果のOupputoを制限。
% 　2017.06.23
%     根本的にプログラム修正。。。
%     ×オープニングによる穿通のみの抽出
%     ⇒オープニングによる太い血管の抽出
%     ●オープニング後、最大値の20%で二値化
%     ×スライスごとに、中心点を算出
%     ⇒細線化による中心点算出と、ひげ除去、
%     これにより、今までのセグメントプログラムが適応できる。！！
%     add⇒点ごとに、楕円近似できるものから計算、
%       それ以外は、LineProfile半周分から径を算出
%     ?ReSegment（太いものを親）


%   'objsiz = [10 10 15]'
%     'se = TS_strel(objsiz,NewReso,'ball')'
%     'adjImage = TS_Image2uint8(RmfImage);'
%     'tic;oRmfImage = imopen(adjImage,se);toc'
%     '経過時間は 48.956238 秒です。'
%     'bw = oRImage > max(oRImage(:))*0.2;'
%     'skel = Skeleton3D(skel);'
%     'SEG_check = TS_AutoSegment_loop(skel,NewReso,[],20);'
%     'save NewOpeningKernel_check2016619 se adjImage NewReso oRmfImage objsiz bw skel SEG_check -v7.3'

% Input Image is neseccery isotropic resolution
Resolution_isotropic_Limit = 0.03;
check_Reso = round(NewReso * 100) / 100;
TF = zeros(1,length(NewReso)-1);
for n = 1:length(TF)
    TF(n) = abs(check_Reso(n+1) - check_Reso(1));
end
if max(TF) > Resolution_isotropic_Limit
    error('Input Resolution is not isotropic? you need check it.')
end
clear Resolution_isotropic_Limit TF check_Reso

%% Initialize
siz = size(RmfImage);
objsiz = [10 10 10];
    se = strel('ball',round(objsiz(1)/NewReso(1)/2),...
            round(objsiz(3)/NewReso(3)/2 ),0 );
Extraction_Th = 0.2;
close_kernel = 70; %% um
    close_kernel = ones(1,1,round(close_kernel / NewReso(3)) + 1);
HoleSize = 10; %% um    
cutlen = 20; %% um

CsizX = 35; %% Radius of Cropsize
CsizY = 35; %% Radius of Cropsize [um]

Aspect_TH = 2.5;
Area_TH = 1.2;

SNRlimit = 10^0.2; %% this mean is 10*log10(SNR) == 2, = snr of limt 


%% Extraction Bold Vessels
disp('Analysis Bold Vessels... imopen')
oRImage = imopen(REnhansed,se);
bw = oRImage > max(oRImage(:)) * Extraction_Th;
disp('Analysis Bold Vessels... imclose')
cbw = imclose(bw,close_kernel);
disp('Analysis Bold Vessels... pre Skeleton process')
cbw = TS_PreSkeleton_v2017(cbw,NewReso,HoleSize);

%% center line and Segment(includng shaving)
disp('Analysis Bold Vessels... skeleton')
skel = Skeleton3D(cbw);
disp('Analysis Bold Vessels... segmentation')
SEG_bold = TS_AutoSegment_loop(skel,NewReso,[],cutlen);
skel = SEG_bold.Output;

%% main function
disp('Analysis Bold Vessels... Ellips Fitting')
[indY,indX,indZ] = ind2sub(size(skel),find(skel(:)));
PenetDiamImage = nan(siz,'like',single(1));
PSNRImage = PenetDiamImage;

%% 1st. Ellips fitting (or NOT)
xdata = 1:size(RmfImage,2);
ydata = 1:size(RmfImage,1);
% zdata = 1:size(Image,3);
xwin = round(CsizX/NewReso(1)); %% Cropsize X
 xwin = xwin + (ceil(xwin/2)==floor(xwin/2));
ywin = round(CsizY/NewReso(2)); %% Crop size Y
 ywin = ywin + (ceil(ywin/2)==floor(ywin/2));
wh = waitbar(0,'Plese wait...');
wh.HandleVisibility = 'on';
wh.CloseRequestFcn = '';

for n = 1:length(indY)
    x = indX(n);
    y = indY(n);
    z = indZ(n);
    bws = cbw(:,:,z);
    L = bwlabel(bws);
    bws = L == (L(y,x));
    if max(bws(:)) == 0
        continue
    end
    s = regionprops(bws,'Centroid','MinorAxisLength','MajorAxisLength','Area');
    
    TF = and((s.MajorAxisLength/s.MinorAxisLength)<=Aspect_TH,...
            ((s.MajorAxisLength*s.MinorAxisLength)/4 * pi)/s.Area < Area_TH);
    
    if ~TF %% if TF is true, This Point should caluculate by Ellips fitting
        continue
    end        
    im = RmfImage(:,:,z);        
        xind = and(xdata>x-xwin,xdata<x+xwin);
        yind = and(ydata>y-ywin,ydata<y+ywin);
% % Crop image %%%%
    cim = double(im(yind,xind));
% % Get SNR for Ellips fitting
    S = sort(cim(:),'descend');
    S = mean(S(1:round(length(S)*0.05)));
    N = double(TS_GetBackgroundValue(im));
    N = max(N,1);
    
    if S/N < SNRlimit 
        continue
    end
    
    Threshold = TS_EllipticFittingThreshold(S,N);
    PSNRImage(y,x,z) = S/ N;
    
    % % extraction from in bw (if crop image has some object, Needs)
    exbw = cim >= Threshold;       
        exbw = TS_GetMaxArea(exbw);        
        %  check edge,
        checkEdge = exbw;
        checkEdge(2:end-1,2:end-1) = 0;
        if max(checkEdge(:))==1
            continue
        end

    % % Ellips Fitting    
    exbw = TS_EllipticFittingWatershed_proto(exbw,...
            min(s.MinorAxisLength*NewReso(1),4),NewReso(1));
    if max(exbw(:)) == 1
        Diam = regionprops(exbw,'Centroid','MinorAxisLength','MajorAxisLength','Area');        
        PenetDiamImage(y,x,z) = Diam.MinorAxisLength*NewReso(1);
    end
    waitbar(n/length(indY),wh,['Ellips fitting(Wait...' num2str(n) '/' num2str(length(indY)) ])
end

delete(wh)

%% 2nd. Get Line Profile  
disp('Analysis Bold Vessels... NOT Ellips Fitting')
NewSkel = skel;
NewSkel(PenetDiamImage>0) = false;
output = TS_AutoAnalysisDiam_sp5(RmfImage,NewSkel,NewReso,100);
[BoldDiamImage,SNRImage] = TS_MeasDiam2DiamImage(NewSkel,output.Pointdata);
BoldDiamImage(SNRImage<2) = nan;
BoldDiamImage = max(cat(4,PenetDiamImage,BoldDiamImage),[],4);



%% Original program ...
% % % %     before , v2 , TS_PenetDiamAnalysis
% % % %% Initialize
% % % objsiz = [10 10 50];
% % % Aspect_TH = 2.5;
% % % Area_TH = 1.2;
% % % opening_Reso = 1; %% um/pix. using High speed mode
% % % CsizX = 30; %% Radius of Cropsize
% % % CsizY = 30; %% Radius of Cropsize [um]
% % % SNRlimit = 10^0.2; %% this mean is 10*log10(SNR) == 2, = snr of limt 
% % % 
% % % 
% % % %% 1st max = 255, min == 0, perslice
% % % adjImage = TS_Image2uint8(Image);
% % % siz = size(adjImage);
% % % %% opening 
% % % % % high speed mode
% % % 
% % % % [RImage,NewReso] = TS_EqualReso3d_parfor(adjImage,Reso,opening_Reso);
% % % % se = TS_strel(objsiz,NewReso,'cylinder');
% % % % % se = TS_strel(objsiz,NewReso,'ball');
% % % % oRImage = imopen(RImage,se);
% % % % oRImage = TS_imresize3d(oRImage,siz);
% % % 
% % % % % % normal speed
% % % oRImage = TS_imopen_parfor(adjImage,TS_strel(objsiz,Reso,'cylinder'));
% % % 
% % % %% Binarize
% % % bw = oRImage > max(oRImage(:))*0.2;
% % % 
% % % %% set output format
% % % PenetDiamImage = nan(siz,'like',single(1));
% % % PSNRImage = PenetDiamImage;
% % % skel = false(siz);
% % % 
% % % %% main function 
% % % xdata = 1:size(Image,2);
% % % ydata = 1:size(Image,1);
% % % % zdata = 1:size(Image,3);
% % % xwin = round(CsizX/Reso(1)); %% Cropsize X
% % %  xwin = xwin + (ceil(xwin/2)==floor(xwin/2));
% % % ywin = round(CsizY/Reso(2)); %% Crop size Y
% % %  ywin = ywin + (ceil(ywin/2)==floor(ywin/2));
% % % wh = waitbar(0,'wait');
% % % whlen = size(bw,3);
% % % for n = 1:size(bw,3)
% % %     bws = bw(:,:,n);
% % %     if max(bws(:))==0
% % %         continue
% % %     end
% % %     im = Image(:,:,n);
% % %      s = regionprops(bws,'Centroid','MinorAxisLength','MajorAxisLength','Area');
% % %     for sn = 1:length(s)
% % %         TF = and((s(sn).MajorAxisLength/s(sn).MinorAxisLength)<=Aspect_TH,...
% % %             ((s(sn).MajorAxisLength*s(sn).MinorAxisLength)/4 * pi)/s(sn).Area < Area_TH);
% % %         if TF
% % %               
% % %         x = round(s(sn).Centroid(1));
% % %         y = round(s(sn).Centroid(2));
% % %         skel(y,x,n) = true;
% % %         
% % %         xind = and(xdata>x-xwin,xdata<x+xwin);
% % %         yind = and(ydata>y-ywin,ydata<y+ywin);
% % %         
% % %         cim = double(im(yind,xind));
% % %         S = sort(cim(:),'descend');
% % %         S = mean(S(1:round(length(S)*0.05)));
% % %         N = double(TS_GetBackgroundValue(im));
% % %         N = max(N,1);
% % %         Threshold = TS_EllipticFittingThreshold(S,N);
% % %         PSNRImage(y,x,n) = S/ N;
% % %         exbw = cim >= Threshold;       
% % %         exbw = TS_GetMaxArea(exbw);        
% % %         checkEdge = exbw;
% % %         checkEdge(2:end-1,2:end-1) = 0;
% % %         if max(checkEdge(:))==1
% % %             continue
% % %         end
% % %         exbw = TS_EllipticFittingWatershed_proto(exbw,...
% % %             min(s(sn).MinorAxisLength*Reso(1),4),Reso(1));
% % %         if max(exbw(:)) == 1
% % %             Diam = regionprops(exbw,'Centroid','MinorAxisLength','MajorAxisLength','Area');
% % %             PenetDiamImage(y,x,n) = Diam.MinorAxisLength*Reso(1);
% % %         end
% % %         end
% % %         clear x y
% % %     end
% % %     waitbar(n/whlen,wh,['wait...' num2str(n) '/' num2str(whlen)])
% % %     
% % % end
% % % 
% % % close(wh)
% % % 
% % % 
% % % %% New eddition 
% % % NewSkel = skel;
% % % NewSkel(PenetDiamImage>0) = false;
% % % output = TS_AutoAnalysisDiam_sp5(Image,NewSkel,Reso,100);
% % % [DiamImage,SNRImage] = TS_MeasDiam2DiamImage(NewSkel,output.Pointdata);
% % % DiamImage(SNRImage<2) = nan;
% % % DiamImage = max(cat(4,PenetDiamImage,DiamImage),[],4);
% % % 
% % % 
% % % 

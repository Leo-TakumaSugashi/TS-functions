function output = JM_YFPdensity_kmeans_v0sugashi(Image,Reso,zStep,expdate,promoter,Locno,varargin)
% output = JM_YFPdensity_kmeans_v0(Image,Reso,zStep,expdate,promoter,Locno,mouseNumber)
% Image Channesl need 2
%      1 : YFP
%      2 : Vessels
% MUST Resolution X==Y
% expdate = '20190628'; % input experiment date
% promoter = 'PVChR2';
% Locno = '03'; %input location number
% mouseNumber = 5789;
% mouseNumber = 0; default
% 
% Editor s log...
% Create by Juri, Murata, 2019,09,03, supported sugashi

%% input check 

if ndims(Image) ~= 5
    error('Input Image is NOT FiVE dimmenssions')
end
if ~isvector(zStep)
    error('Input zStep data is NOT vector data.')
end
if size(Image,3) ~= length(zStep)
    error('Input Image depth size n zStep is not equal')
end

Reso = Reso(1:2);
if Reso(1) ~= Reso(2)
    error('input Resolution X and Y is not equal.')
end

mouseNumber = 'NoNumber';
if nargin == 7
    mouseNumber = varargin{1};
    if isinteger( mouseNumber )
        mouseNumber = num2str(mouseNumber);
    end
end

[~,ExName] = TS_ClockDisp;
% ExName = [date x(9:end)];
% ExName(ExName == '-') = [];
if nargin == 8
    ExName = varargin{2};
    if ~ischar(ExName)
        error('Input Extra Name must BE "Char" class.')
    end
end

if ~ischar(expdate) || ~ischar(promoter) || ~ischar(Locno) || ~ischar(mouseNumber)
    error('Input character string is not correct...')
end
%% Initialization

siz = size(Image);
Kmeans_Clastering_Number = 10;
BinalizeClass = [3 4 5 6 7];
MedSize = [3 3];
CircleMed = min(round(2/Reso(1)),5);
% sigma = round(r/4); % 1/4 of image size; Old (Takeda Version)
sigma_base_size = 250;% [um]
sigma = round(sigma_base_size ./ Reso(1)) ;

vessels_threshold_radius = 1; % unit : um
vessels_threshold_radius_pixels = vessels_threshold_radius / Reso(1);
SizeFilterPixels =round((vessels_threshold_radius_pixels^2)*pi );

vessels_dilate_size = 5;
vessels_dilate_pixels_size = round(vessels_dilate_size / Reso(1));
vessels_dilate_se = strel('disk',vessels_dilate_pixels_size,0);
%% Setup Output
output.Original = Image;
output.Resolution = Reso;
output.zStep = zStep;
output.Experiment_date = expdate;
output.Promoter = promoter;
output.Locations = Locno;
output.MouseNumber = mouseNumber;
output.Kmeans_Classtering_Number = Kmeans_Clastering_Number;
output.BinalizeClass = BinalizeClass;
output.MedSize =  MedSize;
output.CircleMed = CircleMed;
% sigma = round(r/4); % 1/4 of image size; Old (Takeda.H. Verssion)
output.Shading_sigma_base_size = [num2str(sigma_base_size) ' um'];% [um]
output.vessesl_sizefilter_radius =[ num2str(vessels_threshold_radius) ' um'];
output.vessesl_dilate_size =[ num2str(vessels_dilate_size) ' um'];
%% main
%% Adjust Contrast n Denoising (pre-processing)
ShadingImage = TH_shadingcorr(mean(Image,4),sigma); 
VesselsMedShading = TS_Circmedfilt(ShadingImage(:,:,:,:,2),CircleMed);
ShadingImage = TSmedfilt2(ShadingImage,MedSize);

output.ShadingImage = ShadingImage;
output.Shading4VessMed = VesselsMedShading;
%% Classtaling (Kmeans)
Ves = zeros(siz(1:3),'like',uint8(1));
Ves2 = Ves;
YFP = Ves;
for n  = 1:siz(3)
    [~,vesselkmeansim] = kmeans(uint16(ShadingImage(:,:,n,:,2)),Kmeans_Clastering_Number);
    [~,yfpkmeansim] = kmeans(uint16(ShadingImage(:,:,n,:,1)),Kmeans_Clastering_Number);
    [~,vkim] = kmeans(uint16(VesselsMedShading(:,:,n,:)),Kmeans_Clastering_Number);  
    Ves(:,:,n) = squeeze(vesselkmeansim);
    YFP(:,:,n) = squeeze(yfpkmeansim);    
    Ves2(:,:,n) = squeeze(vkim);    
end
output.VesselsKmeans = Ves;
output.YFPKmeans = YFP;
output.CircleMedVesselsKmeans = Ves2;
%% Binalization 
for n = 1:length(BinalizeClass)
    %% BW
    VesBW = Ves >= BinalizeClass(n);
    Ves2BW = Ves2 >= BinalizeClass(n);
    YFPBW = YFP >= BinalizeClass(n);
    
    output.BWData(n).ClassThreshold = BinalizeClass(n);
    output.BWData(n).ClassThreshold_info =...
        ['Kmeans Image >= ' num2str(BinalizeClass(n))];
    output.BWData(n).MaskVessels = VesBW;
    output.BWData(n).MaskCircleMedVessels = Ves2BW;
    output.BWData(n).MaskYFP = YFPBW;
    
    %% Analysis
    %% Each slice Area    
    output.BWData(n).zStep = zStep;
    output.BWData(n).AreaUnit = 'um^2';
    output.BWData(n).AreaVessels = ...
        reshape(sum(sum(VesBW,1),2),1,[]) * (Reso(2)^2);
    output.BWData(n).AreaCircleMedVessels = ...
        reshape(sum(sum(Ves2BW,1),2),1,[]) * (Reso(2)^2);
    output.BWData(n).AreaYFP = ...
        reshape(sum(sum(YFPBW,1),2),1,[])* (Reso(2)^2);
    %% Technical selecting YFP...
    %% dilate vessels minus YFP
    fprintf('Circled Median & Shading Image will bw used as Vessels Mask \n')
    SizeFilVes = VesBW;
    ExtractYFP = YFPBW;    
    YFP_Sumation = zeros(1,size(Image,3));
    YFP_Object_Number = zeros(1,size(Image,3));    
    for k = 1:size(Image,3)
        ves_sl = Ves2BW(:,:,k);
        yfp_sl = YFPBW(:,:,k);        
        
       %% size filter
        ves_sl_open = bwareaopen(ves_sl,SizeFilterPixels);
                
       %% imdilate (vessels)
        ves_sl_open_dilate = imdilate(...
            ves_sl_open,vessels_dilate_se);
       %% Extract YFP object
        extract_yfp_slice = and(yfp_sl, ~ves_sl_open_dilate);
        [~,Num] = bwlabel(extract_yfp_slice);
        
        SizeFilVes(:,:,k) = ves_sl_open;
        ExtractYFP(:,:,k) = extract_yfp_slice;
        YFP_Sumation(k) = sum(extract_yfp_slice(:)) * (Reso(1)^2);
        YFP_Object_Number(k) = Num;
    end
    output.BWData(n).Size_Filtered_VesselsMask = SizeFilVes;
    output.BWData(n).ExtractYFP = ExtractYFP;
    output.BWData(n).ExtractYFP_Summation = YFP_Sumation;
    output.BWData(n).ExtractYFP_ObjectNumber = YFP_Object_Number;
end
return
%% save data to NewFolder % 
%% Create New Directory & Check Name
NewDirName = ['ExDay' expdate '_' promoter '_Loc' Locno '_' mouseNumber '_' ExName];
DirCheck = dir(NewDirName);
while ~isempty(DirCheck)
    error(' Upps... It alredy has been exist..')
end
mkdir(NewDirName)
%% save mat data as dirname
eval([NewDirName ' = output;']);
save([NewDirName filesep 'Result.mat'],NewDirName)
%% make xls tables and save
A = [];
for n = 1:length(output.BWData)
    X = output.BWData(n);
    zstep = num2cell(X.zStep');
    AreaV = num2cell(X.AreaVessels');
    AreaV2 = num2cell(X.AreaCircleMedVessels');
    AreaYFP = num2cell(X.AreaYFP');
    ExYFP_S = num2cell(X.ExtractYFP_Summation');
    ExYFP_ObjNum = num2cell(X.ExtractYFP_ObjectNumber');
    AvS = num2cell(  (X.ExtractYFP_Summation./X.AreaCircleMedVessels)'  );
    
    STR0 = {'BW Threshold',X.ClassThreshold_info,'','','','',''};
    STR1 = {'Depth','Vessles(Area1)','Vessles(Area2)','YFP(Area)','Extract YFP Area(um2)','Extract YFP Number','AvS'};
    a = cat(2,zstep,AreaV,AreaV2,AreaYFP,ExYFP_S,ExYFP_ObjNum,AvS);    
    A = cat(2,A, cat(1,STR0,STR1,flip(a,1)),cell(size(Image,3)+2,1));
end
save([NewDirName filesep 'XLSData.mat'],'A')
writetable(cell2table(A),[NewDirName filesep 'XLSData.csv'])
% xlswrite([NewDirName filesep 'XLSData.xlsx'],A)
clear STR0 STR1 X zstep AreaV AreaV2 ExYFP_ObjNum ExYFP_S
%% Save Images
AveImage = mean(Image,4);
AdjAveImage = TS_AdjImage(AveImage);
%% Original to Kmeans
fprintf('Save Images...')
for n = 1:size(Image,3)
    %% original, Shading
    im = rgbproj(flip(squeeze(AveImage(:,:,n,:,:)),3));
    imwrite(im,[NewDirName filesep 'IM1_OriginalMean4Dim_d' num2str(zStep(n)) 'um.tif'])
    
    im = rgbproj(flip(squeeze(AdjAveImage(:,:,n,:,:)),3));
    imwrite(im,[NewDirName filesep 'IM2_ContAdj_d' num2str(zStep(n)) 'um.tif'])
    
    im = double(ShadingImage(:,:,n,:,1));
    im = im - min(im(:));
    im = im /max(im(:));
    im = uint8(im*255);
    map = ColormapGreen(256);
    imwrite(im,map,[NewDirName filesep ...
        'IM3yfp_ShadingMed' num2str(MedSize(1)) '_d' num2str(zStep(n)) 'um.tif'])
    
    im = double(ShadingImage(:,:,n,:,2));
    im = im - min(im(:));
    im = im /max(im(:));
    im = uint8(im*255);
    map = ColormapRed(256);
    imwrite(im,map,[NewDirName filesep ...
        'IM3ves_ShadingMed' num2str(MedSize(1)) '_d' num2str(zStep(n)) 'um.tif'])
    
    im = double(VesselsMedShading(:,:,n,:,1));
    im = im - min(im(:));
    im = im /max(im(:));
    im = uint8(im*255);
    map = ColormapRed(256);
    imwrite(im,map,[NewDirName filesep ...
        'IM3ves_ShadingCircleMedR' num2str(CircleMed(1)) 'um_d' num2str(zStep(n)) 'um.tif'])
       
    %% Kmeans
    %% Kmeans Map
    fgh = figure('Posi',[0 0 100 500],'Visible','off');
    axh = axes('Posi',[0.1 0.1 .7 .8],'visible','off');
    cmh = colorbar;
    axis(axh,'off')
    colormap(kjet(Kmeans_Clastering_Number))
    cmh.Position(3) = 0.3;
    cmh.FontSize = 12;
    cmh.Ticks = 0:Kmeans_Clastering_Number;
    caxis([0 Kmeans_Clastering_Number])
    saveas(fgh,[NewDirName filesep 'KmeansColormap.tif'])
    close(fgh)
    
    %% Kmeans Clastering images
    map = kjet(Kmeans_Clastering_Number);
    im = Ves(:,:,n) - 1;
    imwrite(im,map,[NewDirName filesep ...
        'IM4_Kmeans_Ves_d' num2str(zStep(n)) 'um.tif'])
    
    im = Ves2(:,:,n) -1;    
    imwrite(im,map,[NewDirName filesep ...
        'IM4_Kmeans_Ves2_CircleMedtype_d' num2str(zStep(n)) 'um.tif'])
    
    im = YFP(:,:,n)-1;    
    imwrite(im,map,[NewDirName filesep ...
        'IM4_Kmeans_YFP_d' num2str(zStep(n)) 'um.tif'])
    clear im map
end
%% BW data
TS_WaiteProgress(0)
MarkerSize = 8;
FontSize = 12;

for n =  1:length(output.BWData)
    X  = output.BWData(n);
    for k = 1:size(Image,3)
        im = X.MaskVessels(:,:,k);
        map = ColormapRed(2);
        imwrite(im,map,[NewDirName filesep ...
            'IM5_ClassTh' num2str(X.ClassThreshold) '_MaskVessels' num2str(zStep(k)) 'um.tif'])
        im = X.MaskCircleMedVessels(:,:,k);
        map = ColormapRed(2);
        imwrite(im,map,[NewDirName filesep ...
            'IM5_ClassTh' num2str(X.ClassThreshold) '_MaskCircleMedVessels' num2str(zStep(k)) 'um.tif'])
        im = X.MaskYFP(:,:,k);
        map = ColormapGreen(2);
        imwrite(im,map,[NewDirName filesep ...
            'IM5_ClassTh' num2str(X.ClassThreshold) '_MaskYFP' num2str(zStep(k)) 'um.tif'])
        
        im = X.Size_Filtered_VesselsMask(:,:,k);
        map = ColormapRed(2);
        imwrite(im,map,[NewDirName filesep ...
            'IM6_ClassTh' num2str(X.ClassThreshold) '_SizeFilteredVesselsMask' num2str(zStep(k)) 'um.tif'])
        im = X.ExtractYFP(:,:,k);
        map = ColormapGreen(2);
        imwrite(im,map,[NewDirName filesep ...
            'IM6_ClassTh' num2str(X.ClassThreshold) '_ExtractedYFP' num2str(zStep(k)) 'um.tif'])
        
        im = rgbproj(cat(3,X.Size_Filtered_VesselsMask(:,:,k),X.ExtractYFP(:,:,k)));        
        imwrite(im,[NewDirName filesep ...
            'IM7_ClassTh' num2str(X.ClassThreshold) '_ExtractedYFPnVes' num2str(zStep(k)) 'um.tif'])        
        
        fgh = figure('Posi',[0 0 size(Image,2) size(Image,1)],...
            'visible','off');
        axh = axes(fgh,'Posi',[0 0 1 1],'visible','off');
        imagesc(axh,im)
        axis(axh,'image')
        axis(axh,'off')
        hold(axh,'on')
        s = regionprops(X.ExtractYFP(:,:,k),'Area','Centroid');
        for objn = 1:length(s)
            xy = s(objn).Centroid;
            plot(xy(1),xy(2),'*w','MarkerSize',MarkerSize)
            text(xy(1)+5,xy(2)-5,num2str(objn),...
                'Color',[1 1 1],'FontSize',FontSize)
        end
        saveas(axh,[NewDirName filesep ...
            'IM7_ClassTh' num2str(X.ClassThreshold) ...
            '_ExtractedYFPnVes_Marker' num2str(zStep(k)) 'um.tif'])
%         saveas(fgh,[NewDirName filesep ...
%             'IM7_ClassTh' num2str(X.ClassThreshold) ...
%             '_ExtractedYFPnVes_Marker' num2str(zStep(k)) 'um.fig'])
        close(fgh)
    end
    TS_WaiteProgress(n/length(output.BWData))
end
end









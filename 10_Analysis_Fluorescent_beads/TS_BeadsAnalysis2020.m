function data = TS_BeadsAnalysis2020(Cropdata,LoadName,ActualSize,varargin)
%% help 
% data = TS_BeadsAnalysis(Cropdata,LoadName,ActualSize,varargin)
% data = TS_BeadsAnalysis(Cropdata,LoadName,ActualSize,CheckType,SurfaceIndex[um])
% 
% Cropdata     : = TS_BeadsCrop(...) or TS_centroid2Crop
% ActualSize   : unit[um]
% LaodName     : {|'fImage'|,'Image'}.
% checkON type : {true,"false"}
% see also , TS_BeadsCrop OR TS_BeadsCrop2017

% edit 2020. 12.22 by Sugashi T.

Reso = Cropdata(1).Resolution;

if nargin>=4
    checkON = varargin{1};
else
    checkON = false;
end
if nargin>=5
    Surf = varargin{2};
else
    Surf = input('Surface Index is [um]?: ');
end

if ~isscalar(Surf)
    error('input surface is NOT Scalar')
else
    Surf = -abs(Surf/Reso(3));
end

ActualSize

%       centroidXYZ: [301.4486 1.0100e+03 2.9200] もともとの画像のCentroid情報
%     CenterOfImage: [75.4486 75.0176 2.9200]　　Cropした後のCentorid情報
%             Image: [89×150×127 uint8]　　　　Crop　Image
%            fImage: [89×150×127 single]　　　Fuiltered　Image　
%                                              、see also TS_BeadCrop
%                       %% Median = TSmedfilt2(Image,[3 3]);
%                       %% gaussian filter ,se = fspecial('gaussian',7,1.8);
%            Enable: 1                          使用するか否か。
%        Resolution: [0.0401 0.0401 0.4000]　　解像度（Y,X、Z)

data(1:length(Cropdata)) = struct('Signal',[],'Noise',[]);
% Reso = [.0401 .0401 .4]
wh = waitbar(0,'Wait...');
set(wh,'Name',mfilename)
for n = 1:length(Cropdata)
    D = eval(['Cropdata(n).' LoadName ';']);
    xdata = 1:size(D,2);
    ydata = 1:size(D,1);
    zdata = 1:size(D,3);
        
    Center = round(Cropdata(n).CenterOfImage);
    
    Lz = squeeze(D(Center(2),Center(1),:));
    Lx = squeeze(D(Center(2),:,Center(3)));
    Ly = squeeze(D(:,Center(1),Center(3)));
    data(n).LineX = Lx;
    data(n).LineY = Ly;
    data(n).LineZ = Lz;
    
    
    xdata = and(xdata >= Center(1) -1 , xdata <= Center(1) + 1);
    ydata = and(ydata >= Center(2) -1 , ydata <= Center(2) + 1);
    zdata = and(zdata >= Center(3) -1 , zdata <= Center(3) + 1);

    
    S = D(ydata,xdata,zdata);
    S = mean(S(:));
%     im = D(:,:,Center(3));
%     N = double(mode(round(im(im>0))));    
    N = double(TS_GetBackgroundValue(D));
    
    
    % % Normalize
    Diff = S - N;
    Lx = (double(Lx) - N)/Diff;
    Ly = (double(Ly) - N)/Diff;
    Lz = (double(Lz) - N)/Diff;
    fwhm = TS_FWHM2016(Lx,0.5,'Center',Center(1));
        data(n).FWHM_X = abs(diff(fwhm)) * Reso(1);
    fwhm = TS_FWHM2016(Ly,0.5,'Center',Center(2));
        data(n).FWHM_Y = abs(diff(fwhm)) * Reso(2);    
    fwhm = TS_FWHM2016(Lz,0.5,'Center',Center(3));
        data(n).FWHM_Z = abs(diff(fwhm)) * Reso(3);
        
    data(n).Signal = S;
    data(n).Noise = N;
    %% Find Threshld
    if ~isempty(ActualSize)
        thx = TS_FindActualThreshld(Lx,ActualSize,Center(1),Reso(1));        
        thy = TS_FindActualThreshld(Ly,ActualSize,Center(2),Reso(2));    
        thz = TS_FindActualThreshld(Lz,ActualSize,Center(3),Reso(3));
    else
        thx = nan;
        thy = nan;
        thz = nan;
    end
    data(n).Actual_ThresholdX = thx;    
    data(n).Actual_ThresholdY = thy;
    data(n).Actual_ThresholdZ = thz;
    DepthIndex = Cropdata(n).centroidXYZ(3);
    data(n).Depth_um = abs(Surf-DepthIndex)*Reso(3);
    waitbar(n/length(Cropdata),wh,['Wait...' num2str(n) '/' num2str(length(Cropdata))])
end
close(wh)
%% Figure
TS_BeadsAnalysis_OutputFigure(Surf,data,Cropdata,checkON)
return

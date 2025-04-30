function H = TS_SegmentEditor(Name,Image,Reso,SEG,varargin)
% H = TS_SegmentEditor(Name,Image,Reso,SEG)
% This Function will be use for testing program....
% see also ...
% Sugashi_GUI_support
% Sugashi_Segment_v1p5
% Sugashi_Segment_v???
clc
H = Sugashi_Segment_v1p61;
H.Name = Name;
H.Image = Image;
H.Resolution = Reso;
H.PreSEG = SEG;
H.SEGview_Type = 'class';
%%
% mImage = TSmedfilt2(Image,[5 5]);
% h = fspecial('gaussian',7,4/(2*sqrt(2*log(2))));
% mfImage = imfilter(gpuArray(single(mImage)),h,'symmetric');
% mfImage = gather(mfImage);
% reset(gpuDevice)
% mfImage = TS_GaussianFilt3D_GPU(mImage,Reso,[3 3 7]);
% data.Name = 'Filtered_med3x3_gausian2D';
data.Name = 'Enhanced';
if nargin>4
    VImage = varargin{1};
else
    VImage = Image;
end
if nargin >5
    VReso = varargin{2};
else
    VReso = Reso;
end

data.Image = VImage;
data.Resolution = VReso;
H.ImageProcessed = data;
H.VolumeViewCurrentDataName = data.Name;
H = H.segeditor();
if ispc
    WinOnTop(gcf);
end
% H.segtracker
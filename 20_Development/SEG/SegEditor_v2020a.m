function varargout = SegEditor_v2020a(Image,Reso,SEG,varargin)
% varargout = SegEditor_v2020a(Image,Reso,SEG,varargin)
% 
% This Function/GUI must make you visible comfusing Segment-data
% outputed from TS_AutoSEG_mex/TS_AutoAnalysisDiam_SEG_v2020Alpha
% (reference latest version)
% 
%   SegEditor_v2020a(Image,Reso,SEG)
%   SegEditor_v2020a(Image,Reso,SEG,AdjImage,AdjReso)
%   H = SegEditor_v2020a(Image,Reso,SEG...)
% 
% if 3D volume data
%     Input:
%         Image    : 3D volume data/Image
%         Reso     : Resolution of each (X,Y,Z) axis corresponding to "Image". 
%                    !! but recommend X == Y axis resolution. Didn't debag yet.
%         SEG      : outptu of TS_AutoSEG_mex from volume skeleton data
%                    or it has already measured diameters from TS_AutoAnalysis..
%         AdjImage : 3D volume data/Image
%         AdjReso  : Resolution of each (X,Y,Z) axis corresponding to "AdjImage". 
%                    if your computer has little bit poor GPU,
%                    it is smoother/easier to view 3D volume renderring
%                    because using berow basic matlab function.
%                    * patch
%                    * isosurface
%                    * reducepatch
% 
% if 4D Time scopic data/Image (*must be size(Image,3) ==1)
%     Input:
%         Image    : 4D time scopic data/Image
%                      * Actually, if Dimmention 5 is color channels.
%                        you can see color image with SEGdata.
%                        see also... rgbproj
%         Reso     : Resolution of each (X,Y,[1],T) axis corresponding to "Image". 
%                    !! but recommend X == Y axis resolution. Didn't debag yet.
%         SEG      : outptu of TS_AutoSEG_mex from volume skeleton data
%                    or it has already measured diameters from TS_AutoAnalysis..
%         AdjImage : * don't read this input
%         AdjReso  : * don't read this input
% 
% fi
% 
%     Output :
%             H  : Handles data
%             
% 
% see also ...
% LeoTS_Segment_GUI_v0p1
% Sugashi_GUI_support
% rgbproj
% SEGview
% Sugashi_ReconstructGroup
% WinOnTop (from matlab central)
%
% edit By Leo Sugashi Takuma. 2020 5th Apr.
fprintf('\n\n')
fprintf('==== ==== ==== ==== Starting Segment Editor ver.2020a ==== ==== ====\n')
if islogical(Image)
    Image = uint8(Image);
end
if length(Reso)<3
    Reso(3) = 1;
    Reso(4) = 1;
elseif length(Reso)<4
    Reso(4) = 1;
end

H = LeoTS_Segment_GUI_v0p1;
H.Name = mfilename;
H.Image = Image;
if size(Image,4)>1
    H.ViewerType = 'Slice only';
end

H.Resolution = Reso;
H.PreSEG = SEG;
H.SEGview_Type = 'Diameter';
%%
% mImage = TSmedfilt2(Image,[5 5]);
% h = fspecial('gaussian',7,4/(2*sqrt(2*log(2))));
% mfImage = imfilter(gpuArray(single(mImage)),h,'symmetric');
% mfImage = gather(mfImage);
% reset(gpuDevice)
% mfImage = TS_GaussianFilt3D_GPU(mImage,Reso,[3 3 7]);
% data.Name = 'Filtered_med3x3_gausian2D';
data.Name = 'Enhanced';
if nargin>=4
    VImage = varargin{1};
    VReso = varargin{2};
else
    VImage = Image;
    VReso = Reso;
end

data.Image = VImage;
data.Resolution = VReso;
H.ImageProcessed = data;
H.VolumeViewCurrentDataName = data.Name;
H = H.segeditor();
% if ispc
%     WinOnTop(gcf);
% end

if nargout==1
    varargout{1} = H;
end
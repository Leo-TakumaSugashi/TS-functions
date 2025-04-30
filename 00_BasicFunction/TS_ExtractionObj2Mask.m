function [bw,mfImage,varargout] = TS_ExtractionObj2Mask(Image,ObjSize,Reso,type)
% output:
%  [ 1 bw(logical),  
%    2  FilteredImage(single), Gaussian and Median
%     3  AdjImage(uint8),
%      4  openning_Image(uint8)
%       5  AdjustedImageAfterOpening(uint8)] = ...
%           TS_ExtractionObjMask(Image,ObjSize,Reso,type)
% ********* ObjSize(1) == ObjSize(2) && Reso(1) == Reso(2) **********
% Opening_kernel_coef = 0.8; Defolt
% GaussFil_sigma_coef = 0.5;
% Threshold_afopen = 0.15;  Defolt
% Input type
%     case 'disk'
%     case 'ball'
%     case 'cylinder'
%     otherwise
%         error('This type is Not Correct')
%     ObjSize : X Y Z  unit mum
%     Reso    : X Y Z Resolution unit mum/pixels

Opening_kernel_coef = 0.8;
GaussFil_sigma_coef = 0.5;
Threshold_afopen = 0.15;

%% opening kernel
switch type
    case 'disk'
        okse = strel('disk',floor(ObjSize(1)/Reso(1)/2 * Opening_kernel_coef),0);
    case 'ball'
        okse = strel('ball',floor(ObjSize(1)/Reso(1)/2 * Opening_kernel_coef),...
            floor(ObjSize(3)/Reso(3)/2 * Opening_kernel_coef),0 );
    case 'cylinder'
        pre_R = round(ObjSize(1)/Reso(1)/2);
        pre_se = false(pre_R * 2 + 1);
        pre_se(pre_R+1,pre_R+1) = true;
        pre_se = bwdist(pre_se) <= pre_R;
        okse = repmat(pre_se,1,1,round(ObjSize(3)/Reso(3)/2)*2+1);
    otherwise
        error('This type is Not Correct')
end

%% gaussian filter
se = fspecial('gaussian',floor(ObjSize(1)/Reso(1)/2*GaussFil_sigma_coef)*6+1,...
    ObjSize(1)/Reso(1)/(2*sqrt(2*log(2)))*GaussFil_sigma_coef);

fImage = imfilter(single(Image),se,'symmetric');


%% Median
mfImage = TSmedfilt2(fImage,[3 3]);


%% Adjust Image each slice
% AdjImage = TS_AdjImage4beads(mfImage,Reso,'figure');
% AdjImage = TS_AdjImage4beads(mfImage,Reso);
AdjImage = TS_AdjImage(mfImage,Reso);


%% Opening
oImage = imopen(AdjImage,okse);

%% Create Mask
% D = TS_AdjImage(oImage,Reso,'figure');
D = TS_AdjImage(oImage,Reso);

bw = D >= max(D(:))*Threshold_afopen;

if nargout>2, varargout{1} = AdjImage;end
if nargout>3, varargout{2} = oImage;end
if nargout>4, varargout{3} = D;end

function A = rgbproj_v2(Image,data)
% A = rgbproj_v2(Image,data)
% This function is for N channels data.
% see also ..
%   GetColorChannels, makemap, gammafilter
%             Map = cat(1,data.Color);
%             Gamma = cat(1,data.Gamma);
%             CLim = cat(1,data.CLim);
% Example, 
%      D = load('mri');
%      D = double(squeeze(D.D(:,:,:,[1 5 27])));
%      D = uint8(D / max(D(:)) * 255);
%      cdata.CLim = cat(1,[0 100], [0 255] ,[0 255]);
%      cdata.Color = GetColorChannels(size(D,3));
%      cdata.Gamma = [1 2 0.2]';
%      rgb = rgbproj(D,cdata);
%      figure,imagesc(rgb),axis image

%% Editor's Log
%  2017 4 16 ,by Takuma SUGASHI
%      edit inputtype
%      add gammafilter, channel's map
%  2019 01 21 ,by Sugashi
%      edit Channels data, Gamma data, Clim data
%
% 2020,4, 18,  By Leo Takuma SUGASHI
%      edit if input is logical data.


Image = squeeze(Image);
[Image,Info] = inputcheck_rgbproj(Image,data);
siz = size(Image);
num = size(Image,3);



A = zeros(siz(1),siz(2),3,num,'like',uint8(1));
Map = Info.map;
Gamma = double(Info.Gamma );
CLim = sort(double(Info.CLim) ,2);
for n = 1:num
    if islogical(Image)
        im = double(squeeze(Image(:,:,n)));
        A(:,:,:,n) = ind2rgb8(uint8(im*255),Makemap(Map(n,:),Gamma(n)));
    else
        im = double(squeeze(Image(:,:,n)));
        im = max((im - CLim(n,1)),0);
        im = min(im ./ (CLim(n,2) - CLim(n,1)),1);
        A(:,:,:,n) = ind2rgb8(uint8(im*255),Makemap(Map(n,:),Gamma(n)));
    end
    
end    
A = squeeze(max(A,[],4));


function [Image,Info] = inputcheck_rgbproj(Image,data)
num = size(Image,3);
if ndims(Image)>3
    error([mfilename ' : Input Dimenssion is NOT Correct.!!'])
end

try
    Map = cat(1,data.Color);
        if 1 == size(Map,1),Map = repmat(Map,[num 1]);end
    Gamma = cat(1,data.Gamma);
        if 1 == length(Gamma), Gamma = repmat(Gamma,[num 1]);end
    CLim = cat(1,data.CLim);
        if 1 == size(CLim,1), CLim = repmat(CLim,[num 1]);end
catch err
    error(err)    
end

Info.map = Map;
Info.Gamma = Gamma;
Info.CLim = CLim;




















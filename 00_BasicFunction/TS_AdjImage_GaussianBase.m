function [output,S,N] = TS_AdjImage_GaussianBase(Image)
% [output,Signal,Noise] = TS_AdjustImage(Image)
% input:Image 3Dimage --> Input is enable ndims...
% 
%  Signal and Noise...
% output:Adjusted Image by Signal and Noise Ratio (class : uint8)
%        [Noise,~] = TS_GetbackgroundValue_GaussianFit(each slice)
%        Signal is Average of top 95%   
%      edit ... 2019. 11, 29
%          bw = imbinarize(im,graythrersh(im));
%          N = mode(im(and(im>0,bw)));

%% ndims check
reshapeTF = false;
if ndims(Image)>3
    siz = size(Image);
    [y,x,~] = size(Image);
    Image = reshape(Image,y,x,[]);
    reshapeTF = true;
end
output = zeros(size(Image),'Like',uint8(1));
siz_z = size(Image,3);
S = zeros(siz_z,1);
N = zeros(siz_z,1);
   
%% Analysis S and N;
fprintf('Analysis S and N by GaussianFitting 8 term.\n')
ParObj = gcp('nocreate');
if isempty(ParObj)
    TS_WaiteProgress(0)
else
    fprintf([mfilename '...using parfor'])
end
parfor n = 1:siz_z
    im = Image(:,:,n);
    [bg,top] = TS_GetBackgroundValue_GaussianFit(im);
    sort_slice = sort(im(:));
    p = floor( length(sort_slice)*0.95);
    p = max(p,1);
    S(n) = nanmean(sort_slice(p:end));
%     S(n) = top;
    N(n) = bg;
    if isempty(ParObj)
        TS_WaiteProgress((siz_z - n+1)/siz_z)
    end
end
fprintf('..\nDone..Next. Contrast Adjusment.\n')
%% Adjust Image for S
fprintf('Contrast Adjusment process..\n')
parfor n = 1:siz_z
    im = double(Image(:,:,n));
    im = uint8((im-N(n))/(S(n) - N(n)) * 255);
    output(:,:,n) = im;
    if isempty(ParObj)
        TS_WaiteProgress((siz_z-n+1)/siz_z)
    end
end
if reshapeTF
    output = reshape(output,siz);
    S = reshape(S,[1 1 siz(3:end)]);
    N = reshape(N,[1 1 siz(3:end)]);
end


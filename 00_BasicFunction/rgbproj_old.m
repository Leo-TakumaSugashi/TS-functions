function A = rgbproj_old(Image,varargin)
% This function is for N channels data.
%  see also. .. .
%   GetColorChannels, makemap
% 
% Example.
%     D = load('mri');
%     D = double(squeeze(D.D));
%     D = uint8(D / max(D(:)) * 255);
%     ch = [1 5 9 10 15 27];
%     rgb = rgbproj(D(:,:,ch));
%     figure,imagesc(rgb),axis image,
%     caxis([1 size(D,3)])
%     colormap(GetColorChannels(length(ch)))
%     colorbar

Image = squeeze(Image);

siz = size(Image);

if length(siz)<3
    A = Image;
    return
elseif length(siz)>3
    error('Input is Not 3 Dim.')
end

num = siz(3);

A = zeros(siz(1),siz(2),3,siz(3),'like',uint8(1));
MaxMap = GetColorChannels(num);
if ~strcmpi(class(Image),'uint8')
    Image = double(Image);
    Image = uint8(Image / max(Image(:)) * 255);
elseif max(Image(:))~=255 
    Image = double(Image);
    Image = uint8(Image / max(Image(:)) * 255);
end
%% Normalied TF

if or(strcmpi(varargin,'Normalize'),strcmpi(varargin,'auto'))
    nTF = true;
else
    nTF = false;
end

for n = 1:num
    im = single(squeeze(Image(:,:,n)));
    %% Add normalized 
    if nTF
    im = im - min(im(:));
%     im = im - TS_GetBackgroundValue(im(:));
%     im = im - mode(im(:));
    im = uint8(im/max(im(:))*255);
    end
    % % % % % % % % % % % % %% 
    if max(im(:))==0
        continue
    end
    A(:,:,:,n) = ind2rgb8(im,makemap(MaxMap(n,:)));
end
A = squeeze(max(A,[],4));
    
function A = TSmedfilt2(im,Ksiz,varargin)
% A = TSmedfilt2(im,Ksiz,varargin)
% medfilt2 �̒[�̌v�Z���
%  if ndims>2,  only xy-plane processed
% help padarray
% 
%  Exapmple
% im = imread('cameraman.tif');
% normal_med = medfilt2(im,[31 31]);
% ts_med = TSmedfilt2(im,[31 31]);
% figure,
% subplot(1,2,1)
% imagesc(normal_med),axis image
% subplot(1,2,2)
% imagesc(ts_med),axis image
% impixelinfo



if nargin>2
    Type = varargin{1};
else
    Type = 'symmetric';
end



pad_siz = [floor(Ksiz(1)/2) floor(Ksiz(2)/2)];
imsiz = size(im);
if ~ismatrix(im)
    im = reshape(im,[imsiz(1) imsiz(2) prod(imsiz(3:end))]);
end
    
im = padarray(im,pad_siz,Type);
A = zeros(size(im),'like',feval(class(im),1));
% % add parfor 2016.11.10
% % edit parpool setting. 2019.05.28
pcj = gcp('nocreate');
if isempty(pcj)
    for n = 1:size(im,3)
        A(:,:,n) = medfilt2(im(:,:,n),Ksiz);
    end
else
    parfor n = 1:size(im,3)
        A(:,:,n) = medfilt2(im(:,:,n),Ksiz);
    end
end
A = A(pad_siz(1)+1:pad_siz(1)+imsiz(1),...
    pad_siz(2)+1:pad_siz(2)+imsiz(2),:);

if ~ismatrix(im)
    A = reshape(A,imsiz);
end
function A = TS_Circmedfilt(im,Rad)
% A = TSmedfilt2(im,Ksiz,varargin)
% medfilt2 ‚Ì’[‚ÌŒvŽZ‰ñ”ð
%   & circle kernel size meddian filter
% help TS_Circmedfilt2d
% 
%  Exapmple
% im = imread('cameraman.tif');
% normal_med = medfilt2(im,[31 31]);
% ts_med = TS_Circmedfilt(im,[31 31]);
% figure,
% subplot(1,2,1)
% imagesc(normal_med),axis image
% subplot(1,2,2)
% imagesc(ts_med),axis image
% impixelinfo

    
imsiz = size(im);
if ~ismatrix(im)
    im = reshape(im,[imsiz(1) imsiz(2) prod(imsiz(3:end))]);
end

A = zeros(size(im),'like',im(1));
% wh = waitbar(0,'wait..');
% set(wh,'name',mfilename)
% TS_WaiteProgress(0)
for n = 1:size(im,3)
    A(:,:,n) = TS_Circmedfilt2d(im(:,:,n),Rad);
%     waitbar(n/size(im,3),wh)
%     TS_WaiteProgress(n/size(im,3))
end
% close(wh)

if ~ismatrix(im)
    A = reshape(A,imsiz);
end
function A = TS_Circmedfilt(im,Rad)
fprintf('This function will be delete. \n')
warning('Current version "TS_Circmedfilt2d" ... ')

    
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
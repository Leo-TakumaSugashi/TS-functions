function A = TS_GammaFilt(Image,r)

if r == 1
    A = Image;
    return
end


if ndims(Image)<2
    disp('Input dim < 2 ??')
    error('Input is Not Correct')
end
siz = size(Image);
Image = reshape(Image,siz(1),siz(2),[]);
A = zeros(size(Image),'like',uint8(1));
if size(Image,3) > 100
parfor n = 1:size(Image,3)
    im = single(Image(:,:,n));
    im = im / max(im(:));
    im = im .^r;
    A(:,:,n) = uint8(im / max(im(:)) * 255 );       
end
else    
for n = 1:size(Image,3)
    im = single(Image(:,:,n));
    im = im / max(im(:));
    im = im .^r;
    A(:,:,n) = uint8(im / max(im(:)) * 255 );
end
end
A = reshape(A,siz);
end
function output = NH_CircleAve(Image,DistPix)

Image = squeeze(Image);
if ndims(Image) ~=3
    error('input matrix size is NOT Correc')
end

h = false(DistPix*2+1);
h(DistPix+1,DistPix+1) = true;
h = bwdist(h)<=DistPix;
h = double(h) ./sum(h(:));
output = zeros(size(Image),'like',single(1));
parfor n = 1:size(Image,3)
    output(:,:,n) = imfilter(Image(:,:,n),h,'symmetric');    
end



function [outputImage,shift_siz] = TS_AutoRepositSlice_v2019Alpha(A,Image)
%  base program is below...
% [shift_siz,(val),(Corr_max)] = TS_SliceReposition(A,B)
% Output is shift of B that has moved relation to the reference A. 
% shift_siz = [y x]
% see also TS_Shift2pad_vEachSlice
% 
% edit 2016. 11 11
% 
% edit 2019 09 11, add subpixels. by sugashi.. prototype . just try..

if ~ismatrix(A)
    error('Input data is not Matrix.')
end
orisiz = size(Image);
if min(size(A) == orisiz(1:2)) == false
    error('Input size is A =~ B...')
end

if length(orisiz) >3
    Image = reshape(Image,orisiz(1),orisiz(2),[]);
end
%% initialize
ExpandVal = 10;
A = imresize(A,ExpandVal);
siz = (size(A)-1)/2;
nA = single(A);
nA = (nA - min(nA(:))) / (max(nA(:)) - min(nA(:)));
shift_siz = zeros(size(Image,3),2);
outputImage = zeros(size(Image),'like',Image(1));
parfor k = 1:size(Image,3)
    B = imresize(Image(:,:,k),ExpandVal);
    nB = single(B);
    nB = (nB - min(nB(:))) / (max(nB(:)) - min(nB(:)));
    D = ifftshift(ifft2(fft2(nA).*conj(fft2(nB))));
    [~,Ind] = max(D(:));
    [y,x] = ind2sub(size(D),Ind);
    shift_s = round([y x] - siz -1.1) / ExpandVal;
    outputImage(:,:,k) = imtranslate(...
        Image(:,:,k),shift_s,...
        'FillValues',0);
    shift_siz(k,:) = shift_s;
end

if length(orisiz) >3
    outputImage = reshape(outputImage,orisiz);    
end


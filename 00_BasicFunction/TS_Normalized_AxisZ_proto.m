function OutPut = TS_Normalized_AxisZ_proto(Image)

siz = size(Image);
Image = reshape(Image,[siz(1) siz(2) prod(siz(3:end))]);

OutPut = zeros(size(Image),'like',uint8(1));
for n = 1:size(Image,3)
im = double(Image(:,:,n));
N = mode(im(and(im>0,im<max(im(:))))); %% (0,max)�Ԃ̍ŕp�l�v�Z�p
im = im - N;
S = max(im(:)); %% Signla�͍ő�l��K�p
im = uint8(im/S*255);
OutPut(:,:,n) = im;
end

OutPut = reshape(OutPut,siz);
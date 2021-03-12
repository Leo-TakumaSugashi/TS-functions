function bw = TS_MGSoma2bw(Image,Reso)

Gim1 = TS_GaussianFilt3D_GPU(Image,Reso,[3 3 5]);
Image = uint8(Image);
N = zeros(size(Gim1,3),1);
S = N;
for n = 1:length(N)
    im = Gim1(:,:,n);
    N(n) = TS_GetBackgroundValue(im);
    S(n) = max(im(:));
    im =  (im-N(n))./(S(n)-N(n))*255;
    Image(:,:,n) = im;
end

%% opening
se = strel('disk',5,0);
oImage = imopen(Image,se);

bw = false(size(Image));
for n = 1:size(bw,3)
    im = oImage(:,:,n);
    N = double(TS_GetBackgroundValue(im));
    S = double(max(im(:)));
    im = double(im);
    im = (im-N)./(S-N);
    im = uint8(im*255);
    bw(:,:,n) = imbinarize(im);
end
keyboard
x = zeros(1,size(bw,3));
for n = 1:length(x)
    x(n) = sum(bw(:,:,n),'all');
end

TF = x > 1.2e4;
bw(:,:,TF) = 0;

% keyboard
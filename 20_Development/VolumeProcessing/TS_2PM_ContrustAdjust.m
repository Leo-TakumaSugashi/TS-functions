function  Image = TS_2PM_ContrustAdjust(data,Reso)


data = single(data);
data(data ==0) = nan;
[~,S,N] = TS_AdjImage(data);
SNR = (S-N)./N;
Deep = 10*log10(SNR) < 0;
Deep(end-30:end) = false;
im1 = TS_GaussianFilt3D_GPU(data,Reso(1:3),[2 2 3]);
im2 = TS_GaussianFilt3D_GPU(data,Reso(1:3),[10 10 3],3);

im1 = im1(:,:,~Deep);
im2 = im2(:,:,Deep);

%% Shading
% for n = 1:size(im1,3)
%     im = im1(:,:,n);
%     im1(:,:,n) = im ./max(im(:));
% end
% Dv = TS_GaussianFilt2D_GPU(im1,Reso(1:2),[250 250]);
% im1 = im1./Dv;
% keyboard
%%
% LowSNR = zeros(size(im2),'single');
parfor n = 1:size(im2,3)
    im2(:,:,n) = SliceContrustAdjsut_normal(im2(:,:,n),Reso)
%     im2(:,:,n) = SliceContrustAdjust(im2(:,:,n),Reso(1:2));
end


parfor n = 1:size(im1,3)
    im1(:,:,n) = SliceContrustAdjsut_normal(im1(:,:,n),Reso)
%     im = im1(:,:,n);
% %     M = mode(round(im(:)));
%     M = TS_GetBackgroundValue(im);
%     im = max(im - M,0);
%     im = imtophat(im,se);
%     im1(:,:,n) = uint8(im./max(im(:)) *255);
end




Image = zeros(size(data),'uint8');
Image(:,:,~Deep) = im1;
Image(:,:,Deep) = im2;
% Image(:,:,Deep) = LowSNR;



end

function Image = SliceContrustAdjust(D,Reso)
siz = round(200./Reso(1)); %400 um
PadSiz = ceil(siz/2);
D = padarray(D,[PadSiz, PadSiz],'symmetric');
tophat_R = round(10/Reso(1)); % 20 um
D = double(D);
ystep = linspace(1,size(D,1)-siz,round(size(D,1)/siz)*2);
ystep = uint16([ystep,size(D,1)+1]);
xstep = linspace(1,size(D,2)-siz,round(size(D,2)/siz)*2);
xstep = uint16([xstep,size(D,2)+1]);


N = zeros(length(ystep)-1,length(xstep)-1);
S = N;

for n = 1:length(ystep)-1
    yind = ystep(n):(ystep(n+1)-1);
    for k = 1:length(xstep)-1
        xind = xstep(n):(xstep(n+1)-1);
        im = D(yind,xind);
        [Noise,ExS] = TS_GetBackgroundValue(im(im>0));
        N(n,k) = Noise;
        S(n,k) = max(im(:))-Noise;
    end
end

Noise = imresize(N,[size(D,1),size(D,2)]);
Signal = imresize(S,[size(D,1),size(D,2)]);
Signal(Signal <1) = 1;
Image = max(D - Noise,0);
% Image =  uint8(Image ./Signal * 64);
Image = imtophat(Image,strel('disk',tophat_R,0));
Image = uint8(Image./max(Image(:))*255);
Image = Image(PadSiz+1:end-PadSiz,PadSiz+1:end-PadSiz);
end


function Image = SliceContrustAdjsut_normal(im,Reso)
tophat_R = round(40/Reso(1)); % 50 um
se = strel('disk',tophat_R,0);
M = TS_GetBackgroundValue(im);
im = max(im - M,0);
im = imtophat(im,se);
Image = uint8(im./max(im(:)) *255);
end


function AdjImage = TS_AdjImage4MicroGlia(Image,Reso)

siz = size(Image);
if siz(4)~=1
    error('Input is NOT Correct')
end

if siz(5)~=2
    error('Input is NOT Correct')
end
T = tic;
VImage = Image(:,:,:,1,1);
GImage = Image(:,:,:,1,2);


%% For Vessels
VesselsSize = [4 4 1]; %% um
[~,~,~,~,AVImage] = TS_ExtractionObj2Mask(VImage,VesselsSize,Reso,'disk');


%% For Micro Glia
whos GImage
AAGImage = zeros(size(GImage),'like',uint8(1));
% keyboard
for n = 1:size(GImage,3)
    AAGImage(:,:,n) = TS_ExtractionMinorObj_v2(GImage(:,:,n),Reso);
end
clear GImage
SmogSiz = [20 20 1]; %% um
[~,~,~,oim,~] = TS_ExtractionObj2Mask(AAGImage,SmogSiz,Reso,'disk');
AGImage = TS_AdjImage(AAGImage - oim);

%% output
AdjImage = cat(5,AVImage,AGImage);
toc(T)
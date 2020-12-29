function SEG = JM_AnalysisDiameter_xyt(Image,Reso)
if numel(Reso)==2
    Reso(3) = 1;
end
%% denoising
fImage = imfilter(single(Image),fspecial('gaussian',7,1.8),'symmetric');
mfImage = TSmedfilt2(fImage,[5 5]);
%% binarize
block_size = ones(1,2) * round(50/Reso(1));
SliceIm = squeeze(nanmean(mfImage,4));

BW = TS_im2bw_block_v2019a(SliceIm,block_size);
%% pre-processing
BW = imfill(BW,'holes');
BW = imclose(BW,strel('disk',2,0));
%% skelton
skel = bwskel(BW);
%% segment

output = TS_AutoSEG_mex(skel,Reso,[],10);
%% measurment
SEG = TS_AutoAnalysisDiam_SEG_v2020Alpha(mfImage,Reso,'sp8',output);

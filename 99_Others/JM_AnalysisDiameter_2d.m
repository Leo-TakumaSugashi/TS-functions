function SEG = JM_AnalysisDiameter_2d(Image,Reso)
if ~ismatrix(Image)
    error('not matrix')
end
if numel(Reso)==2
    Reso(3) = 1;
end
%% denoising
mfImage = TSmedfilt2(Image,[5 5]);
%% binarize
block_size = ones(1,2) * round(50/Reso(1));
BW = TS_im2bw_block_v2019a(mfImage,block_size);
%% pre-processing
BW = imfill(BW,'holes');
BW = imclose(BW,strel('disk',2,0));
%% skelton
skel = bwskel(BW);
%% segment
output = TS_AutoSEG_mex(skel,Reso,[],10);
%% measurment
SEG = TS_AutoAnalysisDiam_SEG_v2020Alpha(mfImage,Reso,'sp8',output);

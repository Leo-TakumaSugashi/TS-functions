
function [cbw,NewReso] = TS_2PMImage2BW_v0(Image,Reso)
% [cbw,NewReso] = TS_2PMImage2BW_v0(Image,Reso)


Time_st = tic;
%% Denoising
% By experience, about 1-2 um diameter Capirally will be extracted because
% of 1 um radius circle kernel median filter.
MedSizRadius = max(min(round(1 / Reso(1)),3),1); %
mfImage = TS_Circmedfilt2d(Image,MedSizRadius);
clear Image
Emphasized = TS_2PM_VascularFilter_v2019a(mfImage,Reso);


%% Resize Image (Isotropic resolution)
EImage = Emphasized.EfImage;
ResizeReso = Reso(1);
[RmfImage,NewReso] = TS_EqualReso3d_2017(mfImage,Reso,ResizeReso);
 REmphasized       = TS_EqualReso3d_2017(EImage,Reso,ResizeReso); 
 Remphasized_Penet = TS_EqualReso3d_2017(Emphasized.fImage,Reso,ResizeReso);

 %% Pre Skeleton 1
 % %% TS_PreSkeleton_v2019_sp8 is also sp5 
bw = TS_PreSkeleton_v2019_sp8(REmphasized,Remphasized_Penet,NewReso); 
clear Image EImage Emphasized 

%% Pre Skeleton 2
Radius = 3;
BoldTh = Radius / NewReso(1);
sesiz = repmat(round(BoldTh*2)+1,1,3);
SE = false(sesiz);
SE(round(BoldTh)+1,round(BoldTh)+1,round(BoldTh)+1) = true;
se = bwdist(SE)<= Radius;
tic,
try %% try GPGPU
    gbw = gpuArray(bw);
    gcbw = imclose(gbw,se);
    cbw = gather(gcbw);
catch err
    warning(err.message)
    cbw = imclose(bw,se);
end
try
    reset(gpuDevice)
catch err
    warning(err.message)
end
cbw = imfill(cbw,'holes');



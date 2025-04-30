function outImage = TS_Enhance_MG_v0(Image,Reso)
% outImage = TS_Enhance_MG_v0(Image,Reso)
% Input 
%     Image : Observed Micro gria and Blood Vascular Image,
%                 channels 1 (size(Image,5)) : Vascular
%                 channels 2                 : Micro Glia
%     Reso  : Reosolution [X Y Z]
% Output
%     outImage : Adjust Contrast Image... 

%% check Input
if size(Image,5) ~=2
    error('Input Image is NOT Correct...')
end

if ~isvector(Reso)
    error('Input Resolution is NOT Correct')
end

%% main function...
A = TS_GaussianFilt(Image(:,:,:,:,1),Reso(1:3),[2 2 1]);
adjA = TS_AdjImage(A);

G = TS_GaussianFilt(Image(:,:,:,:,2),Reso(1:3),[1 1 1]);
adjG = TS_HistgramLogScaler(G,'mode');

outImage = cat(5,adjA,adjG);


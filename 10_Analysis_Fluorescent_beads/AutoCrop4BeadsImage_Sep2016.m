% Image = data.Lif_111215_10um_4.Image;

BeadSize = 10;
Reso = [455.88/1023 455.88/1023 580.94/588];
Opening_kernel_coef = 0.8;
Threshold_afopen = 0.2;
Vert = 30; %% unit um
Hori = 30; %% unit um
Depth = 50; %% unit um
% % 

%% Median
% %% Circle kernel's median filter
% mImage = TS_Circmedfilt(Image,2);
mImage = TSmedfilt2(Image,[5 5]);

%% gaussian filter
se = fspecial('gaussian',7,1);
mfImage = imfilter(mImage,se,'symmetric');

%% Adjust Image each slice
[AdjImage,S,S2,N] = TS_AdjImage4beads(mfImage);

%% opening
% se = strel('disk',floor(BeadSize/Reso(1)/2 * Opening_kernel_coef),0);
se = strel('ball',floor(BeadSize/Reso(1)/2 * Opening_kernel_coef),...
    floor(BeadSize/Reso(3)/2 * Opening_kernel_coef),0 );
oImage = imopen(AdjImage,se);

%% Binalize for bw and Caluculate Centoroid
D = TS_AdjImage4beads(oImage);
bw = D >= max(D(:))*Threshold_afopen;
% % closing
se = ones(1,3);
se = reshape(se,1,1,[]);
bw = imclose(bw,se);

% % centroid
[L,NUM] = bwlabeln(bw,26);
if NUM<2^8
    L = uint8(L);
elseif NUM < 2^16
    L = uint16(L);
end
Cent = regionprops(L,'Centroid');

%% Crop to Structure 
Cropdata = TS_centroid2Crop(Image,mfImage,[Hori Vert Depth],Reso,Cent);
    
%% Check figure
[Cropdata,NewCropdata] = TS_CropdataEnableCheck(Cropdata);
    
    
    







function [BW,bw] = TS_PreSkeleton_v2017(EnhancedImage,Reso,varargin)

% [BW,bw] = TS_PreSkeleton_v2017(Image(bw),Reso,ObjSiz)
% Input 
%     Image(bw) : if input is NOT logical,
%         bw = TS_ExtractionObj2Mask(EnhancedImage,ObjSiz,Reso,'ball');
%         so, logical data is Recomended
%     Reso     :  Resolution of X Y Z (um/ vox.)
% Output 
%     BW       : For Pre- Skeleton data
%     bw       : Input or Extracted Mask
% 
% This Function is included TS_AtVasMes....
%     see all so TS_AtVasMeas_Flow... ,TS_ExtractionObj2Mask


%% Input check and Initialize
if nargin ==3
    HoleSiz_Radi = varargin{1};
else
    HoleSiz_Radi = 10; %% um
end
HoleSiz =round( (HoleSiz_Radi/Reso(1))*(HoleSiz_Radi/Reso(2))*pi );
HoleSiz_volume =round( (HoleSiz_Radi/Reso(1)) * ...
                (HoleSiz_Radi/Reso(2)) * ...
                (HoleSiz_Radi/Reso(3)) * 4/3 *pi );
% this is for Vascular Mesurement Value
if ~islogical(EnhancedImage)
    ObjSiz = [4 4 4]; %% um
    bw = TS_ExtractionObj2Mask(EnhancedImage,ObjSiz,Reso,'ball');
else
    bw = EnhancedImage;
end


%% main func.
BW = bw;
% % at 1st,for  each slice 
for n = 1:size(bw,3)
    im = bw(:,:,n);
    im = imfill(im,'holes');
    BW(:,:,n) = im;clear im
end

% % if large hole(s) is NOT necessary fill.So check hole size. and return
bw_areaopen = and(~bw,BW);
for n = 1:size(bw,3)
    im = bw_areaopen(:,:,n);
    im = bwareaopen(im,HoleSiz);
    slice_bw = BW(:,:,n);
    slice_bw(im) = false;    
    BW(:,:,n) = slice_bw;clear im slice_bw
end

%% Remove small object.
BW = bwareaopen(BW,HoleSiz_volume,26);


%% fill for 3D volume
BW = imfill(BW,'holes');

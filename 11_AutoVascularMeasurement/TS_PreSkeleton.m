function [BW,bw] = TS_PreSkeleton(EnhancedImage,Reso)
% This Function is included TS_AtVasMes....
%     see all so TS_AtVasMeas_Flow




HoleSiz_Radi = 10; %% um
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


%%
BW = bw;
for n = 1:size(bw,3)
    im = bw(:,:,n);
    im = imfill(im,'hole');
    BW(:,:,n) = im;clear im
end


bw_areaopen = and(~bw,BW);
for n = 1:size(bw,3)
    im = bw_areaopen(:,:,n);
    im = bwareaopen(im,HoleSiz);
    slice_bw = BW(:,:,n);
    slice_bw(im) = false;    
    BW(:,:,n) = slice_bw;clear im slice_bw
end

 BW = bwareaopen(BW,HoleSiz_volume,26);



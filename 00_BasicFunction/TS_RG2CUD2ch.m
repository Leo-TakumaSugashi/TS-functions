function Image = TS_RG2CUD2ch(Input)
% Red and Green image to Color Universal desine 2ch image converter 
Image = Input;
Image(:,:,3) = max(Image(:,:,1),Image(:,:,3));
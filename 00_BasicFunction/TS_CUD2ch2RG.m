function Image = TS_CUD2ch2RG(Input)
% Color Universal desine 2ch image to Red and Green image converter 
Image = Input;
Image(:,:,3) = Image(:,:,3) * 0.1;


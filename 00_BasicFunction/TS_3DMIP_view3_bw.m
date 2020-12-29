function A = TS_3DMIP_view3_bw(Image,Reso,theta,fai)

Image = imrotate(Image,theta);

% siz = size(Image);
% Asiz = siz .* Reso;
resiz_val = Reso(3) / Reso(1);
Image = flip(Image,1);
Image = flip(Image,3);
Image = permute(Image,[3 2 1 4 5]);
Image = imresize(Image,[ceil(size(Image,1)*resiz_val) size(Image,2)]);


%% fai add 2016/11/10
Image = permute(Image,[1 3 2 4 5]);
Image = imrotate(Image,fai);
Image = permute(Image,[1 3 2 4 5]);
%% For logical data
Intensity = size(Image,3):-1:1;
Intensity = uint8(Intensity/max(Intensity) * 255);
Image = uint8(Image);
for n = 1:size(Image,3)
    im = Image(:,:,n,:,:);
    Image(:,:,n,:,:) = im * Intensity(n);
end

A = max(Image,[],3);
return

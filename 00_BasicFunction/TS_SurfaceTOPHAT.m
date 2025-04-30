function A = TS_SurfaceTOPHAT(Image,Reso)

if ndims(Image)~=3
    error('Input is NOT 3 Dim.');
end
TIME = tic;
SurfNoiseSiz = [50 50 1];

[oImage,NewReso] = TS_resize2d_Reso(Image,Reso,[2 2 1]);
 disp(['Resize for Opening. : ' num2str(size(oImage))])
se = TS_strel(SurfNoiseSiz,NewReso,'disk');
parfor n = 1:size(oImage,3)
oImage(:,:,n) = imopen(oImage(:,:,n),se);
end
oImage = TS_resize2d(oImage,NewReso,[size(Image,1) size(Image,2)]);
oImage = feval(class(Image),oImage);
disp([' Analysis Time : ' num2str(toc(TIME)) ' sec.'])

A = Image - oImage;

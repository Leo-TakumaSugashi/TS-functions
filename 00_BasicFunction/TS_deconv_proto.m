function output = TS_deconv_proto(Image,Reso)
% output = TS_deconv_proto(Image,Reso)
%  Input ,,,
%    Image is 3D Image
%    Reso = [X Y Z] unit(um/Pix.)
%  Ouput Deconvoluted Image

if ismatrix(Image)
    error('Input Dim. is NOT 3')
end
siz = size(Image);
Image = reshape(Image,siz(1),siz(2),prod(siz(3:end)));
Image = permute(Image,[1 3 2]);

% PSFum = [0 0 5]; %% um

PSFum = [5 4]; %% um(Only Axis Z)
psf(1:2) = struct('L',[]);
for n = 1:2
sigma = PSFum(n)./Reso(3)/(2*sqrt(2*log(2)));

% PSF = Gaussian3D(sigma,ceil(sigma*5));
wind_coef = 7;

Wind_siz = round(sigma*wind_coef); 
OddOREven = floor(Wind_siz/2) == ceil(Wind_siz/2);
Wind_siz = Wind_siz + double(OddOREven);
   clear OddOREven
z = -ceil(Wind_siz/2):ceil(Wind_siz/2);
PSF =  exp(-(z.^2/(2*(sigma.^2))));
   clear z
PSF = reshape(PSF./sum(PSF(:)),[1 length(PSF)]);
clear Wind_siz wind_coef sigma 
psf(n).L = PSF;
end
L1 = psf(1).L;
L2 = psf(2).L;
L1 = L1/max(L1);
L2 = L2/max(L2);
[~,pksind1] = findpeaks(L1);
[~,pksind2] = findpeaks(L2);
PSF = cat(2,L1(1:pksind1),L2(pksind2+1:end));
fgh = figure;
plot(PSF),
title(['PSF model[left right] = [' num2str(PSFum) '], um'])
drawnow,
PSF = PSF/sum(PSF);


PSF_siz = size(PSF);
Pad_siz = floor(PSF_siz./2);
dImage = padarray(Image,Pad_siz,'symmetric');

%% Main Func. (deconvlucy)
Time= tic;
parfor n = 1:size(dImage,3)
dImage(:,:,n) = deconvlucy(dImage(:,:,n),PSF);
end
Time = toc(Time);
disp(['*** Analysis Time... ' num2str(Time) ' sec. ***'])
disp([ '    '  mfilename('fullpath')])
dImage = dImage(Pad_siz(1)+1:end-Pad_siz(1),...
               Pad_siz(2)+1:end-Pad_siz(2),:); 
dImage = permute(dImage,[1 3 2]);
dImage = reshape(dImage,siz);

%% output
output = dImage;
try
    close(fgh)
catch err
    err
end
    




function output = TS_deconv_proto_gammaLog(Image,Reso)
% output = TS_deconv_proto(Image,Reso)
%  Input ,,,
%    Image is 3D Image
%    Reso = [X Y Z] unit(um/Pix.)
%  Ouput Deconvoluted Image

if ndims(Image) ~=3
    error('Input Dim. is NOT 3')
end

% PSFum = [0 0 5]; %% um
PSFum = 50; %% um(Only Axis Z)
sigma = PSFum./Reso(3)/(2*sqrt(2*log(2)));

% PSF = Gaussian3D(sigma,ceil(sigma*5));
wind_coef = 7;

Wind_siz = round(sigma*wind_coef); 
OddOREven = floor(Wind_siz/2) == ceil(Wind_siz/2);
Wind_siz = Wind_siz + double(OddOREven);
   clear OddOREven
z = -ceil(Wind_siz/2):ceil(Wind_siz/2);
PSF =  exp(-(z.^2/(2*(sigma.^2))));
PSF = (log10(PSF*9+1));
   clear z
PSF = reshape(PSF./sum(PSF(:)),[1 1 length(PSF)]);

PSF_siz = size(PSF);
Pad_siz = floor(PSF_siz./2);
dImage = padarray(Image,Pad_siz,'replicate');

%% Main Func. (deconvlucy)
Time= tic;
for n = 1:size(dImage,1)
    for m = 1:size(dImage,2)
        dImage(n,m,:) = deconvlucy(dImage(n,m,:),PSF);
    end
end
Time = toc(Time);
disp(['*** Analysis Time... ' num2str(Time) ' sec. ***'])
disp([ '    '  mfilename('fullpath')])


%% output
output = dImage(Pad_siz(1)+1:end-Pad_siz(1),...
               Pad_siz(2)+1:end-Pad_siz(2),...
               Pad_siz(3)+1:end-Pad_siz(3));
    




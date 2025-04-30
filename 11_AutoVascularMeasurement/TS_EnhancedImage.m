function output = TS_EnhancedImage(Image,Reso)

if ndims(Image)~=3
    error('input is not 3 Dim')
end
if and(~isvector(Reso),length(Reso)~=3)
    error('Input Resolution is NOT Correct.')
end

if Reso(1) ~= Reso(2)
    error('input Resolution X and Y is NOT equal')
end

TIME = tic;
%% pre opening
Objsiz = 4; % um
% sigma = Objsiz./Reso/(2*sqrt(2*log(2)));
% Gauss = Gaussian3D(sigma,sigma*3);
% disp(' Gaussian Filter 3D')
% fImage = imfilter(single(Image),Gauss,'symmetric');
disp(' Gaussian 3D , Processing')
% fImage = feval(class(Image),TS_GaussianFilt3D_parfor(Image,Reso,repmat(Objsiz,[1 3])));
fImage = TS_GaussianFilt3D_parfor(Image,Reso,repmat(Objsiz,[1 3]));
 toc(TIME)
disp(' Gamma Processing')
LogfImage = TS_HistgramLogScaler(fImage,'min');
 toc(TIME)
disp('Adjust Image')
AdjLogfImage = TS_AdjImage(LogfImage);
 toc(TIME)
 disp('Shadding')
EImage = zeros(size(Image),'like',AdjLogfImage);
parfor n = 1:size(Image,3)
    EImage(:,:,n) = TS_ShadingImage(AdjLogfImage(:,:,n),Reso);
end
% SAdjLogfImage = TS_ShadingImage(AdjLogfImage,Reso);
% output = SAdjLogfImage;
output.fImage = fImage;
output.GammfImage = LogfImage;
output.EmhaGammfImage = EImage;
toc(TIME)
return


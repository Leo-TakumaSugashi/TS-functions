function output = TS_2PM_VascularFilter_v2019a(Image,Reso)
% output = TS_2PM_VascularFilter_v2019a(Image,Reso)


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
%% 3D Gaussian
Objsiz_cap = [4 4 10]; % um for cap.
Objsiz_P = [20 20 10]; % um for Bold Vascular,
% sigma = Objsiz./Reso/(2*sqrt(2*log(2)));
% Gauss = Gaussian3D(sigma,sigma*3);
% disp(' Gaussian Filter 3D')
% fImage = imfilter(single(Image),Gauss,'symmetric');
disp(' Gaussian 3D , Processing (Cap.)')
try 
    fImage1 = TS_GaussianFilt3D_GPU(Image,Reso,Objsiz_cap);
catch err
    disp(err.message)
    if ~isempty(gcp('nocreate'))
        fImage1 = TS_GaussianFilt3D_parfor(Image,Reso,Objsiz_cap);
%           fImage1 = TS_GaussianFilt3D_GPU(Image,Reso,Objsiz_cap);
    else
        fImage1 = TS_GaussianFilt3D(Image,Reso,Objsiz_cap);
    end
end

disp(' Gaussian 3D , Processing (Penetorating.)')
try 
    fImage2 = TS_GaussianFilt3D_GPU(Image,Reso,Objsiz_P);
catch err
    disp(err.message)
    if ~isempty(gcp('nocreate'))
        fImage2 = TS_GaussianFilt3D_parfor(Image,Reso,Objsiz_P);
%         fImage2 = TS_GaussianFilt3D_GPU(Image,Reso,Objsiz_P);
    else
        fImage2 = TS_GaussianFilt3D(Image,Reso,Objsiz_P);
%         fImage2 = TS_GaussianFilt3D_GPU(Image,Reso,Objsiz_P);
    end
end
fImage = max(fImage1,fImage2);
clear fImage1 fImage2
 toc(TIME)
% disp('uint8 Image')
% fImage8 = TS_Image2uint8(fImage);
%  toc(TIME)
%% 2D Shadding
disp('  Shadding , Processing...')
% fsiz e = 255;
fsize = 255;
f = fspecial('gaussian',[fsize fsize]*2,round(fsize/2));
EImage = zeros(size(Image),'like',fImage(1));
try
    gpuObj = gpuDevice;
    SingleByteSize = 4; %% or Should consider for Double class byte size = 8;
    TotalUseVariableNum = 5 * 3; %% *3 mean for avoiding "Out of memory"
    siz_xy = size(Image,1) * size(Image,2);
    Zstep = (gpuObj.AvailableMemory/TotalUseVariableNum/SingleByteSize)/siz_xy;
    Zstep = max(floor(Zstep),1);    
    fprintf('GPGPU for Shading...')
    zdata = 1:size(Image,3);    
    TS_WaiteProgress(0)
    for n = 1:ceil(size(Image,3)/Zstep)
        zid = and(zdata>=(n-1)*Zstep+1, zdata < n*Zstep+1);
        gpuim = gpuArray(  single(fImage(:,:,zid)));
        im = imfilter(gpuim,f,'symmetric');
        Ave = mean(reshape(im,siz_xy,[]),2);
        Div = gpuArray(zeros(size(gpuim),'like',single(1)));
        for k = 1:size(gpuim,3)
            Div(:,:,k) = im(:,:,k) / Ave(k);
        end
        imA = gather(gpuim./Div);
        reset(gpuObj)
        EImage(:,:,zid) = imA;
        TS_WaiteProgress(n/ceil(size(Image,3)/Zstep))
    end
catch err
    disp(err.message)
    if ~isempty(gcp('nocreate'))  
        parfor n = 1:size(Image,3)
            im = imfilter(single(fImage(:,:,n)),f,'symmetric');
            Ave = mean(im(:));
            Div = im/Ave;
            EImage(:,:,n) = single(fImage(:,:,n))./Div;
        end
    else
        TS_WaiteProgress(0)
        for n = 1:size(Image,3)
            im = imfilter(single(fImage(:,:,n)),f,'symmetric');
            Ave = mean(im(:));
            Div = im/Ave;
            EImage(:,:,n) = single(fImage(:,:,n))./Div;
            TS_WaiteProgress(n/size(Image,3))
        end
    end
end

%% Normalize
for n = 1:size(Image,3)
    im = EImage(:,:,n);
    a = max(im(:));
    b = min(im(:));
    EImage(:,:,n) = (im - b) / (a - b);
end

% SAdjLogfImage = TS_ShadingImage(AdjLogfImage,Reso);
% output = SAdjLogfImage;
output.fImage = fImage;
output.EfImage = EImage;
toc(TIME)
return


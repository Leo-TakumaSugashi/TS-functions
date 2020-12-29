function [outputImage,varargout] = TS_MexicanHatFilt(Image,Reso,varargin)
%  [outputImage,varargout] = TS_MexicanHatFilt(Image,Reso,varargin)
% Input :
%     Image : 3D or 2D image
%     Reso : Resolution (X,Y,Z) , X == Y,
%     varargin : []
% output :
%     outputImage : Filtered Image
%     varagin{1} : Kernel
% 
% This Func. is Extraction(Enhansement) of Cell Process.(Ex. Astrosyte, Microgria)

%  edit, add
%   GPU analysis on
%   Memory check on
%   Parfor on
%   2019, Sep. 25th ,by Sugashi

 tic
if ndims(Image) >3
    error('Input Dim. of Image is NOT COrrect')
end

if numel(size(Image)) ~= numel(Reso)
    error('Input Numels is Not Correct')
end

if Reso(1) ~= Reso(2) 
    error('Resolution X Y is NOT Equal')
end

Image = single(Image);
%% Main Func.
RecomResoXY = 0.05;
siz = size(Image);
%% Make Filter Kernels
    para1 = 1.6; % unit [um]
    para2 = 0.8; % unit [um]
    sigma1 = para1 / min(RecomResoXY,Reso(1)) / (2*sqrt(2*log(2)));
    sigma2 = para2 / min(RecomResoXY,Reso(1)) / (2*sqrt(2*log(2))); 
    kernel_siz = round(sigma1 * 6);
    h0 = fspecial('average',kernel_siz);
    h1 = fspecial('gaussian',kernel_siz,sigma1);
    h2 = fspecial('gaussian',kernel_siz,sigma2);
    H2 = h0 - h1*6 + h2*6;
%% Resize check
NewSiz = siz(1:2);
Resize_check = false;
if Reso(1) > RecomResoXY
    Resize_check = true;
    val = 0.05\Reso(1);
    NewSiz = round(siz(1:2) * val);
end 
%% Mexican Hat Filter
outputImage = Image;
%% check GPU
try
    GPUobj = gpuDevice;
catch err
    GPUobj = [];
end
try
    if isempty(GPUobj)
        error('none gpuDevice');
    end
    %% memory check
    Numels = NewSiz * size(Image,3);
    double_bytes = 8;
    Coef = 4;
    if (Numels*double_bytes*Coef) > TS_checkmem('double')
        error('Need more server memory to use GPGPU, as current script...')
    end
    %% core function 
%     GPUloop = 6;
%     im = imresize(Image,NewSiz);
%     im = TS_fevalimprocessing3D_GPU('imfilter',1,GPUloop,im,H2,'symmetric');
%     if Resize_check
%         outputImage = imresize(im,siz(1:2));
%     else
%         outputImage = im;
%     end
%     GPUobj = gpuDevice;
    single_byte = 4;
    coef = 5;
    znum = max(floor( GPUobj.AvailableMemory/(prod(NewSiz)*single_byte*coef) ), 1);
    zdata = 1:size(Image,3);
    
    for n = 1:znum:size(Image,3)
        zid = and(n<=zdata,zdata<n+znum-1);
        im = imresize( ...
            gpuArray( single( Image(:,:,zid) ) ),...
            NewSiz);
        im = gather( imfilter( im, gpuArray(H2) ,'symmetric') );
        reset(GPUobj)
        if Resize_check
            im = imresize(im,siz(1:2));
        end
        outputImage(:,:,zid) = im;
    end
catch err
    if ~isempty(GPUobj)
        reset(GPUobj)
    end
    disp(err.message)
    parfor n = 1:size(Image,3)
        im = imresize(Image(:,:,n),NewSiz);
        im = imfilter(im,H2,'symmetric');
        if Resize_check
            im = imresize(im,siz(1:2));
        end
        outputImage(:,:,n) = im;
    end
end

if nargout>1
    varargout{1} = H2;
end

toc




 
function output = TS_GaussianFilt3D(Image,Reso,ObjSize)
%% output = TS_GaussianFilt(Image,Reso,ObjSize)
% output : single
% Input  : 1 Image
%          2 Reso(X,Y,Z) um/pix.
%          3 ObjSize(X,Y,Z) um
GaussFil_sigma_coef = 1;
Kernel_Coef = 5;
sigma_array = [ObjSize(2)/Reso(2)/(2*sqrt(2*log(2)))*GaussFil_sigma_coef ...
    ObjSize(1)/Reso(1)/(2*sqrt(2*log(2)))*GaussFil_sigma_coef ...
    ObjSize(3)/Reso(3)/(2*sqrt(2*log(2)))*GaussFil_sigma_coef];
K = ceil(sigma_array*Kernel_Coef*5);
K = K + double(ceil(K/2)==floor(K/2));
G = Gaussian3D(sigma_array,K);

try 
%     output = imgaussfilt3(gpuArray(single(Image)),sigma_array,'Padding','symmetric');
    output = imgaussfilt3(single(Image),sigma_array,'Padding','symmetric');
%     output = gather(output);
%     reset(gpuDevice)
catch err
    disp(err)
    output = imfilter(single(Image),G,'symmetric');
end

function [output,G,z_pw] = TS_GaussianFilt3D_parfor(Image,Reso,ObjSize)
%% output = TS_GaussianFilt(Image,Reso,ObjSize)
% output : single
% Input  : 1 Image
%          2 Reso(X,Y,Z) um/pix.
%          3 ObjSize(X,Y,Z) um
if ndims(Image)>5
    error('Input is NOT Correct')
end
    
GaussFil_sigma_coef = 1;
Kernel_Coef = 2;
sigma_array = [ObjSize(2)/Reso(2)/(2*sqrt(2*log(2)))*GaussFil_sigma_coef ...
    ObjSize(1)/Reso(1)/(2*sqrt(2*log(2)))*GaussFil_sigma_coef ...
    ObjSize(3)/Reso(3)/(2*sqrt(2*log(2)))*GaussFil_sigma_coef];
K = ceil(sigma_array*Kernel_Coef);
K = K + double(ceil(K/2)==floor(K/2));
G = Gaussian3D(sigma_array,K);

%% For parfor
poj = gcp;
NumW = poj.NumWorkers;
if size(Image,3) < NumW*2
    output = imfilter(single(Image),G,'symmetric');
    return
end



Pad_siz = ceil(size(G,3)/2);
% z_siz = round(size(Image,3)/8 + Pad_siz*2);
siz = size(Image);
% pImage = zeros([siz(1:2) z_siz 8],'like',single(1));
z_pw = round(linspace(1,size(Image,3),NumW+1));
% output = []
pw_data(1:NumW) = struct('Image',[],'Index',[]);
for n = 1:NumW
    zdata = z_pw(n)-Pad_siz:z_pw(n+1)+Pad_siz;    
    zdata = zdata(and(zdata>0, zdata<=siz(3)));
    pw_data(n).Image = Image(:,:,zdata,:,:);
    pw_data(n).Index = zdata;
    pw_data(n).cut_Ind = and(zdata>=z_pw(n),zdata<=z_pw(n+1)-1);
    if n ==NumW
        pw_data(n).cut_Ind = and(zdata>=z_pw(n),zdata<=z_pw(n+1));
    end
end

parfor n = 1:NumW
    im = single(pw_data(n).Image);
    pw_data(n).Image = imfilter(im,G,'symmetric');
end 
outputImage = [];
% size(outputImage)
for n = 1:NumW
    cat_Image = pw_data(n).Image(:,:,pw_data(n).cut_Ind,:,:);
%     size(cat_Image)
    outputImage = cat(3,outputImage,cat_Image);
end
% outputImage = cat(3,outputImage,pw_data(end).Image(:,:,Pad_siz+1:end));
output = outputImage;
% output = imfilter(single(Image),G,'symmetric');

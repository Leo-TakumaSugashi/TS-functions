function output = TS_GaussianFilt(Image,Reso,ObjSize)
%% output = TS_GaussianFilt(Image,Reso,ObjSize)
% output : single
% Input  : 1 Image
%          2 Reso um/pix.
%          3 ObjSize um

GaussFil_sigma_coef = 1;
se = fspecial('gaussian',floor(ObjSize(1)/Reso(1)/2*GaussFil_sigma_coef)*6+1,...
    ObjSize(1)/Reso(1)/(2*sqrt(2*log(2)))*GaussFil_sigma_coef);

Xdata = 1:size(se,2);
Xdata = (Xdata -1 ) *Reso(1);
Ydata = 1:size(se,1);
Ydata = (Ydata -1 ) *Reso(2);
% fgh = figure;
% imagesc(se,'Xdata',Xdata,'Ydata',Ydata),axis image,grid on
% drawnow
siz = size(Image);
if length(siz) > 3
    Image = reshape(Image,siz(1),siz(2),prod(siz(3:end)));
end

output = zeros(size(Image),'like',single(1));
parfor n = 1:size(Image,3)
output(:,:,n) = imfilter(single(Image(:,:,n)),se,'symmetric');
end
% close(fgh)
% drawnow

if length(siz) > 3
    output = reshape(output,siz);
end

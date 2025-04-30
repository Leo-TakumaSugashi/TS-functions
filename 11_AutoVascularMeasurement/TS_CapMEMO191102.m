








%%
KernelSiz = 31;
InGamma = 4; %% must bw less than 7 
VerticalCoef = 0.0001;
% Image = zeros([size(im) length(v)],'like',im(1));
Reso = [1 1];
ydata = 1:size(InPSF,1); %% pix. size,
ydata = (ydata-1).*Reso(2); %% real size,
ycoef = ydata *VerticalCoef;
ycoef = repmat(ycoef(:),[1 size(InPSF,2)]);
ycoef =  ycoef - nanmin(ycoef(:));
% ycoef = ycoef./nansum(ycoef(:));
ycoef(isnan(ycoef)) = 0;

InPSF = fspecial('gaussian',KernelSiz,InGamma);
InPSF = InPSF+ycoef/2 ;
tic
[J,P] = deconvblind(imcomplement( wiener2(im,[5 5]) ),InPSF);
toc 

figure('Posi',[10 10 1900 980]),
axes('Position',[0 0 1 1])
imagesc(cat(2,imcomplement(im),J)),axis image

%%
v = -5:1:5;
for n = 1:length(v)
InPSF = fspecial('gaussian',KernelSiz,InGamma);
ydata = 1:size(InPSF,1); %% pix. size,
ydata = (ydata-1).*Reso(2); %% real size,
VerticalCoef = v(n);
ycoef = ydata *VerticalCoef;
ycoef = repmat(ycoef(:),[1 size(InPSF,2)]);
ycoef =  ycoef - nanmin(ycoef(:));
% ycoef = ycoef./nansum(ycoef(:));
ycoef(isnan(ycoef)) = 0;
InPSF = InPSF+ycoef;
clear ydata ycoef

% figure,imagesc(InPSF),axis image
% %%

tic
[J,P] = deconvblind(im,InPSF);
toc
% figure,imagesc(cat(2,im,J)),axis image
Image(:,:,n) = J;
end
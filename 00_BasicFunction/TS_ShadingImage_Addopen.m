function [New_output,Divisor,output] = TS_ShadingImage_Addopen(Image,Reso)

%% Shading
%% % Original Script Edited by Takeda
% f = fspecial('gaussian',[80 80],40);    %‘‹‚Íxysize‚Ì1/4
% for n = 1:size(Image,3)
% a(:,:,n) = imfilter(double(Image(:,:,n)),f,'replicate');
% end
% for n = 1:size(Image,3)
% a2 = mean(mean(a(:,:,n)));
% a3(:,:,n) = a(:,:,n)/a2;
% Image2(:,:,n) = double(Image(:,:,n))./a3(:,:,n);
% end
ObjSize = 30;
OpenObjSize = 5;
sigma_coef = 8;
Kernel_coef = 2;
Div_coef = 5;
Fil_term = 'symmetric';
% Fil_term = 'replicate';
Time = tic;

siz = size(Image);

if ~ismatrix(Image)
    Image = reshape(Image,siz(1),siz(2),prod(siz(3:end)));
end

%% Calculation Divsor (gaussian filter) --> class 'single'
sigma = ObjSize(1)/Reso(1)/(2*sqrt(2*log(2)));
ForShad_sigma = sigma * sigma_coef;
Kernel_siz = floor(ForShad_sigma * 2 * Kernel_coef) + 1;
fs_gauss = fspecial('gaussian',Kernel_siz,ForShad_sigma);
  fgh = figure('Color','w');centerfig(fgh)
  imagesc(fs_gauss,'xdata',(1:size(fs_gauss,2)-1)*Reso(1),...
      'Ydata',(1:size(fs_gauss,1)-1)*Reso(2)),axis image
  xlabel('Horizon Gauss.f. size [\mum]')
  ylabel('Verticle Gauss.f size [\mum]')
  title('Calculation Divsor (Gaussian filter)')
  drawnow

%% Add opening
[~,~,~,oImage] = ...
    TS_ExtractionObj2Mask(Image,repmat(OpenObjSize,[1 3]),Reso,'disk');
oImage = single(oImage);
oImage = feval(class(Image), oImage/max(oImage(:)) * single(max(Image(:))));

% %% Object ‚ð@TOPHAT‚Åˆê’U”²‚«Žæ‚éB..
% TopHat_Image =   max(Image - oImage , 0 ) ;
% TopHat_Image =   single(Image) - single(oImage) ;
% TopHat_Image =  TopHat_Image - min(TopHat_Image(:));
%     figure,imagesc(TopHat_Image),axis image,title('TopHat')
% oImage = feval(class(Image), oImage/max(oImage(:)) * single(max(Image(:))));

%% making Divisor
% Divisor = imfilter(single(Image),fs_gauss,Fil_term);
% Divisor = imfilter(single(TopHat_Image),fs_gauss,Fil_term);
%%% Enable %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Divisor = imfilter(single(oImage),fs_gauss,Fil_term);%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Divisor = imfilter(single(TopHat_Image),fs_gauss);
close(fgh)

wh = waitbar(0,'Shading ....');
for n = 1:size(Image,3)
    AveDiv_slice = Divisor(:,:,n);
%     AveDiv = TSmean(AveDiv_slice(:),1);
    AveDiv = max(AveDiv_slice(:));
    Div_slice = Divisor(:,:,n) / AveDiv;
    Div_slice = Div_slice / max(Div_slice(:));
    Divisor(:,:,n) = Div_slice;
    waitbar(n/size(Image,3),wh)
end

waitbar(0,wh,'Div.Coef ...')
Divisor = Divisor.^Div_coef;
output = single(Image) ./ Divisor;
% 
% figure,imagesc(AveDiv_slice),title('Filtered'),colorbar,impixelinfo ,axis image
%  figure,imagesc(Divisor(:,:,end).\1),title(['(1/Divisor)^' num2str(Div_coef)]),colorbar,impixelinfo ,axis image
%  figure,imagesc(oImage(:,:,end)),title('opend image'),colorbar,impixelinfo,axis image
%  figure,imagesc(Image(:,:,end)),title('Input'),colorbar,impixelinfo,axis image
%  figure,imagesc(output(:,:,end)),title('output'),colorbar,impixelinfo,axis image

%% Maximum Intensity proj
Class = class(Image);
New_output = zeros(size(Image),'like',Image);
waitbar(0,wh,'Compensation....')
for n = 1:size(Image,3)
    Ori_im = single(squeeze(Image(:,:,n)));
    output_im = output(:,:,n);
    im = feval(Class,cat(4,output_im./max(output_im(:))*max(Ori_im(:)),Ori_im));
    New_output(:,:,n) = max(im,[],4);
    waitbar(n/size(Image,3),wh)
end
close(wh)


if length(siz)>2
    New_output = reshape(New_output,siz);
end

Time = toc(Time);
disp(['Analysis time : ' num2str(Time) ' sec.   /' mfilename])

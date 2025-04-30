function output = TS_Reposition_humandata(base,Image,CropSiz,skel,varargin)
% output = TS_Reposition_humandata(base,Image,CropSiz,Edge(skel),varargin)
%  input ;
%     base : base image(2D)
%     Image : object Image (3D or 2D)
%     CropSiz : [Y X], Cropsize [pix.]
%     Edge(skel) : Caluculation Point (logical data)
%     varargin{1} : Resize Value (default is 5)
%  output
%      output.Output      : Reposited Image (single)
%      output.Original    : Original Image(input)
%      output.Base        : base(input)
%      output.CropSize    : CropSiz(input)
%      output.EdgePoint   : Edge(skel) (input)
%      output.ResizeValue : Resize Value(default is 5)
%      output.Interp_Vx   : help griddata or scatteredInterpolant
%      output.Interp_Vy   : help griddata or scatteredInterpolant
% This Func. is Prototype...
%     edit by Sugashi , 2017, 2. 4
%     additional by Sugashi, 2017, 3, 10

narginchk(4,5)
if nargin==4
    value = 5; %% this is resize value;
else
    value = varargin{1};
end
if or(~isscalar(value),value<2)
    error('input Resize Value is Not Correct')
end

half_CS = CropSiz /2;

siz = size(Image);
if length(siz) == 2
    siz(3) = 1;
end

[X,Y] = meshgrid(1:size(Image,2),1:size(Image,1));
ydata = 1:size(Image,1);
xdata = 1:size(Image,2);
vpx = nan(size(Image),'like',single(1));
vpy = vpx;
[skel_y,skel_x] = find(skel);
wh = waitbar(0,'Wait...');
set(wh,'Name',mfilename);
for nz = 1:size(Image,3)
    slice_im = Image(:,:,nz);    
    Shift = zeros(length(skel_y),2);
    parfor n = 1:length(skel_y)
        yidx = and(ydata>=skel_y(n) - half_CS(1) ,ydata < skel_y(n)+ half_CS(1));
        xidx = and(xdata>=skel_x(n) - half_CS(2) ,xdata < skel_x(n) + half_CS(2));
        base_crop = imresize( base(yidx,xidx), value);
        slice_crop =imresize( slice_im(yidx,xidx), value);
        s = SliceReposition(base_crop,slice_crop);
        s = s / value;
        Shift(n,:) = s;        
    end
    for n = 1:length(skel_y)
        vpy(skel_y(n),skel_x(n),nz) = Y(skel_y(n),skel_x(n)) + Shift(n,1);
        vpx(skel_y(n),skel_x(n),nz) = X(skel_y(n),skel_x(n)) + Shift(n,2);
    end
    waitbar(nz/siz(3),wh,...
        ['Wait...slice(' num2str(nz) '/' num2str(siz(3)) ')'])        
end
close(wh)
% clear Shift s slice_crop base_crop yidx xidx n slice_im nz wh ydata xdata

vpImage = zeros(size(Image),'like',single(1));
% wh = waitbar(0,'Wait...');
parfor n = 1:size(Image,3)
vpx_n = vpx(:,:,n);
vpy_n = vpy(:,:,n);
xi = griddata(skel_x,skel_y,double(vpx_n(skel)),X,Y);
yi = griddata(skel_x,skel_y,double(vpy_n(skel)),X,Y);
xi(isnan(xi)) = X(isnan(xi));
yi(isnan(yi)) = Y(isnan(yi));
vpImage(:,:,n) = interp2(single(Image(:,:,n)),xi,yi);
%     waitbar(n/size(Image,3),wh,['Wait... ' num2str(n) '/' num2str(size(Image,3))])
end

output.Output    = vpImage;
output.Original  = Image;
output.Base      = base;
output.CropSize  = CropSiz;
output.EdgePoint = skel;
output.ResizeValue = value;
output.Interp_Vx = vpx;
output.Interp_Vy = vpy;


function [shift_siz,val] = SliceReposition(A,B)
% [shift_siz,(val),(Corr_max)] = TS_SliceReposition(A,B)
% Output is shift of B that has moved relation to the reference A. 
% shift_siz = [y x]
%% edit 2016. 11 11
% Original program is TS_SliceReposition
siz = (size(A)-1)/2;
nA = single(A);
nA = (nA - min(nA(:))) / (max(nA(:)) - min(nA(:)));
nB = single(B);
nB = (nB - min(nB(:))) / (max(nB(:)) - min(nB(:)));

D = ifftshift(ifft2(fft2(nA).*conj(fft2(nB))));
[val1,Ind1] = max(D(:));
Ind = Ind1;
val = val1;
[y,x] = ind2sub(size(D),Ind);
shift_siz = round([y x] - siz -1.1);





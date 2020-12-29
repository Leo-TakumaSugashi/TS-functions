function [bw,level] = TS_im2bw_block_old(Image,block_siz,varargin)

if ~ismatrix(Image)
    error('Input Image is NOT 2D image')
end

if ~isvector(block_siz)
    error('input Block size is NOT 2 numels vector')
end


%% pre processing(Normalize)
Image = single(Image);
Image = Image - min(Image(:));
Image = Image / max(Image(:));
siz_Image = size(Image);

%% block process
%% graythresh (Otsu Method)
level = zeros(siz_Image);
ydata = 1:siz_Image(1);
xdata = 1:siz_Image(2);
hlf_bs = block_siz/2;
wh = waitbar(0,'Wait...');
set(wh,'Name',mfilename)
for ny = 1:siz_Image(1)
    parfor nx = 1:siz_Image(2)
        yidx = and(ydata>=ny - hlf_bs(1),ydata < ny + hlf_bs(1));
        xidx = and(xdata>=nx - hlf_bs(2),xdata < nx + hlf_bs(2));
        im = Image(yidx,xidx);
        level(ny,nx) = graythresh(im);        
    end
    waitbar(ny/siz_Image(1),wh,['Wait...' num2str(ny) '/' num2str(siz_Image(1))])
end
close(wh)
bw = Image >= level;


    
    







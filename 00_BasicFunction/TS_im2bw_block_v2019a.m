function [bw,level] = TS_im2bw_block_v2019a(Image,block_siz,varargin)

% block_siz = [ Y X ]

if ~ismatrix(Image)

    siz = size(Image);
    Image = reshape(Image,siz(1),siz(2),[]);
    bw = false(size(Image));
    level = zeros(size(Image));
    if isempty(gcp('nocreate'))
        TS_WaiteProgress(0)
        for n = 1:size(Image,3)
            [sb,sl] = TS_im2bw_block_v2019a(Image(:,:,n),block_siz,varargin);
            bw(:,:,n) = sb;
            level(:,:,n) = sl;
            TS_WaiteProgress(n/size(Image,3))
        end
    else
        parfor n = 1:size(Image,3)
            [sb,sl] = TS_im2bw_block_v2019a(Image(:,:,n),block_siz,varargin);
            bw(:,:,n) = sb;
            level(:,:,n) = sl;
        end
    end
    bw = reshape(bw,siz);
    level = reshape(level,siz);    
    return
%     error('Input Image is NOT 2D image')
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
F = @(x) graythresh(x.data(:));
level = blockproc(Image,block_siz,F,...
    'PadPartialBlocks',true,'PadMethod','symmetric',...
    'DisplayWaitbar',false,...
    'BorderSize',floor(block_siz/2),'TrimBorder',false);
% 
% ydata = round(linspace(1,size(Image,1)+1,block_siz(1)*2+2));
% xdata = round(linspace(1,size(Image,2)+1,block_siz(2)*2+2));
% level = zeros(block_siz*2);
% for ny = 1:length(ydata)-2
%     for nx = 1:length(xdata)-2
%         yidx = ydata(ny):(ydata(ny+2) - 1);
%         xidx = xdata(nx):(xdata(nx+2) - 1);
%         im = Image(yidx,xidx);
%         level(ny,nx) = graythresh(im(im>0));
%     end
% end

%% binalization
% level = TS_resize2d(level,ones(1,2),siz_Image);
level = imresize(level,siz_Image,'bilinear');
bw = Image >= level;
end



    
    







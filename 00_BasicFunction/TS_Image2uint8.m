function output = TS_Image2uint8(Image,varargin)
% output = TS_Image2uint8(Image)
%   main function
%     im = single(Image(:,:,n));
%     Maximum = max(im(:));
%     if Maximum > 255        
%         im = im/Maximum * 255;
%     end
%     output = uint8(im);
% 
% edit 2016 11 21

TF = strcmpi(class(Image),'uint8');
if TF
    output = Image;
    return
end

if nargin>1
    if strcmpi(varargin{:},'all') %% edit 2016 11 21
        output = single(Image);
        output = uint8(output/max(output(:)) * 255);
    end
    return
    
else
    siz = size(Image);
    if length(siz)>2
        Image = reshape(Image,siz(1),siz(2),prod(siz(3:end)));
    end

    output = zeros(size(Image),'like',uint8(1));
    % wh = waitbar(0,'Image to uint8 class...');

    TF = max(strcmpi(class(Image),{'double','single'}));
    for n = 1:size(Image,3)
        im = single(Image(:,:,n));
        im = im - min(im(:));
        Maximum = max(im(:));
        if or(Maximum > 255 , TF )
            im = im/Maximum * 255;
        end
        output(:,:,n) = uint8(im);    
    %     waitbar(n/size(Image,3),wh)
    end

    if length(siz)>2
        output = reshape(output,siz);
    end
    % close(wh)
    % drawnow
end


function output = TS_HistgramLogScaler(Image,varargin)
% output = TS_HistgramLogScaler(Image,Off-setType)
% Off set Type {'min'}, 'std', 'mode','mean'

if nargin>1
    Type = varargin{1};
else
    Type = 'min';
end


siz = size(Image);
if length(siz)>2
    Image = reshape(Image,siz(1),siz(2),prod(siz(3:end)));
end

output = zeros(size(Image),'like',uint8(1));
  
parfor n = 1:size(Image,3)
    im = single(Image(:,:,n));
    if ~isempty(im(im>0))
        im = im - feval(Type,im(im>0));
        im = max(im,0);
        im = im/max(im(:));
        im = log10(im*9+1);
    end
    output(:,:,n) = uint8(im*255);
end

if length(siz)>2
    output = reshape(output,siz);
end
% close(wh)
% drawnow

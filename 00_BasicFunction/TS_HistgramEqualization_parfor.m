function  NewImage = TS_HistgramEqualization_parfor(Image)


val = 255; %% uint8

if ismatrix(Image)
    
% CLASS = class(Image);
if max(Image(:))>val
    Image = single(Image);
    Image = Image - min(Image(:));
    Image = round(Image / max(Image(:)) * val);
end

histgram = hist(double(Image(:)),0:val);
histgram = histgram(:);
cumhist = cumsum(histgram,1);
trans = round(val/numel(Image) * cumhist);
NewImage = trans(Image+1);
NewImage = uint8(NewImage);
else
    siz = size(Image);
    Image = reshape(Image,siz(1),siz(2),[]);
    NewImage = zeros(size(Image),'like',uint8(2));
    parfor n = 1:size(Image,3)
        NewImage(:,:,n) = TS_HistgramEqualization_parfor(Image(:,:,n));
    end
    NewImage = reshape(NewImage,siz);
end

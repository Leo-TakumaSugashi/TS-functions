function Image = TH_shadingcorr(IM,fsize)

Image = zeros(size(IM),'single');
f = fspecial('gaussian',[fsize fsize],fsize/2);                             %ƒÐ‚Í‘‹size‚Ì1/2
if length(size(IM))<5
    for n = 1:size(IM,3)
        a = imfilter(single(IM(:,:,n)),f,'symmetric');
        a2 = mean(a(:));
        a3 = a/a2;
        Image(:,:,n) = single(IM(:,:,n))./a3;
    end
elseif length(size(IM))==5
    for n = 1:size(IM,3)
        a = imfilter(single(IM(:,:,n,:,2)),f,'symmetric');
        a2 = mean(a(:));
        a3 = a/a2;
        Image(:,:,n,:,1) = single(IM(:,:,n,:,1))./a3;
        Image(:,:,n,:,2) = single(IM(:,:,n,:,2))./a3;
    end
    
end
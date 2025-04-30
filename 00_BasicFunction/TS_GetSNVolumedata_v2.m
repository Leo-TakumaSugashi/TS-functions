function SNR = TS_GetSNVolumedata_v2(Image)

SignalRatio = 0.05;
S = zeros(1,size(Image,3));
N = S;
Min = S;
Max = S;
Ave = S;
parfor n = 1:size(Image,3)
    im = Image(:,:,n);
    Max(n) = max(im(:));
    Min(n) = min(im(:));
    Ave(n) = mean(im(:));
    N(n) = TS_GetBackgroundValue(im);
    im = sort(im(:),'descend');
    S(n) = mean(im(1:round(length(im)*SignalRatio)));
    
end
SNR.Signal = S;
SNR.Noise = N;
SNR.Maximum = Max;
SNR.Minimum = Min;
SNR.Average = Ave;
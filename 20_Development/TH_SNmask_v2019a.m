
function  [Mask,SN] = TH_SNmask_v2019a(image1,rate)
% [Mask,SN ] = TH_SNmask_v2019a(Image,Threshold)
% Original is TS_SNmask...
%     edit 2019.06.28 by Sugashi
if ndims(image1)>3
    error('Input image1 must be less than 4 dimmention')
end

if ~isinteger(image1)
    Maximum = max(image1(:));
    a = round(image1 / Maximum * 255);
    image1 = (a / 255 * Maximum);
    %%%%% Original Corde %%%%%%%%% 
%     R = 10; %% Original is 10,
%     a = image1;
%     a = a*R;
%     a = round(a);
%     a = a/R;
%     image1 = a;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
end



% SN = size(1,size(image1,3));
Mask = false(size(image1));
SN = nan(2,size(image1,3));
sigsize = round(length(a)*0.05); %% maximum to 95% will be meaned for signal.


if islogical(image1)
    Mask = image1;
    return
end

%% Main
if ~isempty(gcp('nocreate'))
    parfor n = 1:size(image1,3)
        image2d = image1(:,:,n);
        a = sort(image2d(:),'descend');
        Signal = mean(a(1:sigsize));
        Noise = mode(image2d(and(image2d>min(image2d(:)),image2d<max(image2d(:)))));
        level = (Signal-Noise)*(rate) + Noise;
        Mask(:,:,n) = image1(:,:,n) > level;
        SN(:,n) = [Signal ; Noise];
    end
else
    fprintf(mfilename)
    TS_WaiteProgress(0)
    for n = 1:size(image1,3)
        image2d = image1(:,:,n);
        a = sort(image2d(:),'descend');
        Signal = mean(a(1:sigsize));
        Noise = mode(image2d(and(image2d>min(image2d(:)),image2d<max(image2d(:)))));
        level = (Signal-Noise)*(rate) + Noise;
        Mask(:,:,n) = image1(:,:,n) > level;
        SN(:,n) = [Signal ;Noise];
        TS_WaiteProgress(n/size(image1,3))
    end
end

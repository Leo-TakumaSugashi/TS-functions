function [OnSkelImage,Output] = TS_WeightedCentroid_onSkeleton(skel,bw,Image,Reso)
% [OnSkelImage,Output] = TS_IntensityCentroid(skel,bw,Image,Reso)
% for Kurihara data, 
% Input 
%     skel : skeleton image(2D)
%     bw   : logical data (4D or 3D, ndims(squeeze(skel)) == 3 , or 2 )
%     Image : Original( or Intensity) Image (4D)
%      * size(bw) == size(Image)
%     Reso : Resolution (X ,Y ) , veclor data, 2 number of metric
% Output
%     OnSkelImage : Number of BW about WeightedCentroid at Each Slice 
%     Output      : for Editor data,
%         Output.WeitedCentroid_YX : result of regioprops('WeightedCentroid')
%         Output.OnSkeletonImage   : EachSliec OnSkeleton Image
% 
% edit by Sugashi, 2017 05 19
        
%% input check
if ~ismatrix(skel)
    error('Input skeleton image is NOT 2D')
end
OriginalSiz = size(bw);

bw = squeeze(bw);
Image = squeeze(Image);
siz_bw = size(bw);
siz_Image = size(Image);
if length(siz_bw)>3
    error('Input bw  ; Dimmension Error')
end
if length(siz_Image)>3
    error('Input Image  ; Dimmension Error')
end

%% Initicalize
[y,x] = find(skel);
xy_skel = cat(2,x(:),y(:));
Output(1:size(bw,3)) = struct('WeightedCentroid_YX',[],'OnSkeletonImage',[]);

OnSkelImage = zeros(size(bw),'like',uint8(1)); %% class is uint8


%% main process
for n = 1:size(bw,3) %% Enable 'parfor'
    OnSkel = OnSkelImage(:,:,n);
    sb = bw(:,:,n);
    im = Image(:,:,n);
    stat = regionprops(sb,im,'WeightedCentroid');
    xy = cat(1,stat.WeightedCentroid);
        Output(n).WeightedCentroid_YX = xy;
    lenmap = TS_EachLengthMap2(xy_skel,xy,Reso);
    for k = 1:size(lenmap,1)
        [~,idx] = min(lenmap(k,:));
        idx = idx(1);
        x = xy_skel(idx,1);
        y = xy_skel(idx,2);
        OnSkel(y,x) = OnSkel(y,x) + 1;
    end
    OnSkelImage(:,:,n) = OnSkel;
        Output(n).OnSkeletonImage = OnSkel;
end

OnSkelImage = reshape(OnSkelImage,OriginalSiz);




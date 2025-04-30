function [outA,Ref,sh] = TS_XYreposi4YK(Image)
% [outputA,Ref_Image,shiftmatrix] = TS_XYreposi4YK(Image)
% input Image need 4 dim. and 3dimmention is just a slice.
%  edit by Sugashi ,2016. 11.29

if ismatrix(squeeze(Image))
    disp('  ')
    disp('  (Need 3 more Dim.)')
    error('Input Dim. is Not Correct')    
end

if size(Image,3) ~= 1
    error('Dim(3) Need schalar')
end

%% Make Ref. Image
Ref = max(Image,[],5);
Ref = squeeze(nanmean(Ref,4));

%% Main Func
outA = Image;
sh = zeros(size(Image,4),2); %% sh is Shiftmatrix(Y,X)
Image = squeeze(max(Image,[],5));
parfor n = 1:size(outA,4)
    s = TS_SliceReposition(Ref,Image(:,:,n));
    sh(n,:) = s;
end

for n = 1:size(outA,4)
    [~,B] = TS_Shift2pad_vEachSlice(...
        outA(:,:,:,n,:),...
        outA(:,:,:,n,:),...
        sh(n,:),'crop');
    outA(:,:,:,n,:) = B;
end







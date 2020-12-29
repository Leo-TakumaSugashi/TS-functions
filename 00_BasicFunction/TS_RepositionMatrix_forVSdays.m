function outB = TS_RepositionMatrix_forVSdays(A,B,shift_matrix,FlexRatio,Surface_Shift)
siz_depth = size(B,3);

outB = zeros(size(B),'like',B);

for n = 1:siz_depth
    [~,IM2] = TS_Shift2padreposi(B(:,:,n),B(:,:,n),...
        shift_matrix(n,:),'crop');
    outB(:,:,n,:,:) = IM2;   
end
clear IM2 B shift_matrix
whos outB
outB =  TS_imresize3d(outB,...
    [size(outB,1) size(outB,2) round(size(outB,3)/FlexRatio)],...
    'nearest');
if Surface_Shift>0
    outB = padarray(outB,[0 0 Surface_Shift],0,'post');
elseif Surface_Shift<0
    outB(:,:,end-Surface_Shift:end) = [];
end

if size(A,3)>size(outB,3)
    outB = padarray(outB,[0 0 size(A,3)-size(outB,3)],0,'pre');
elseif size(A,3)<size(outB,3)
    outB = outB(:,:,end-size(A,3)+1:end);
end

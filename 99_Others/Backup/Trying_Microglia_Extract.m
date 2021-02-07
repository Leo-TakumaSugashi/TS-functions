


objsiz = [4 4 8];
G = Image(:,:,:,:,2);
gG = TS_GaussianFilt3D_GPU(G,Reso,objsiz);
AdjgG = TS_AdjImage4beads(gG);

MaximumRad = 20;
AreaThreshold = prod(repmat(MaximumRad,[1 2])./Reso(1:2))  *pi;
SizeFilter3dim = round(3/4*prod([2 2 3]./Reso));

level = graythresh(single(AdjgG(:))/255);
bw1 = AdjgG > level*255;
se = TS_strel(objsiz,Reso,'disk');
StartLoopNUM = 5;
bw2 =TS_fevalimprocessing3D_GPU('imclose',1,StartLoopNUM,uint8(bw1)*255,se);


bw3 = bw2;
fprintf('bw size fileter...')
TS_WaiteProgress(0)
for n = 1:size(bw3,3)
    Slicebw = bw1(:,:,n);
    SlicebwNOT = bwareaopen(Slicebw,round(AreaThreshold));
    bw3(:,:,n) = and(Slicebw,~SlicebwNOT);
    TS_WaiteProgress(n/size(bw3,3))
end

bw4 = imopen(bw3,true(1,1,3));
bw5 = bwareaopen(bw4,SizeFilter3dim);
bw6 = imfill(bw5,'hole');
% bw7 = padarray(bw6,[1 1 1],false);
% D = bwdist(~bw7);
% D = D(2:end-1,2:end-1,2:end-1);
% D = -D;
% D(~bw6) = Inf;
% L = watershed(D);
% s = regionprops(L,'Area','Centroid');
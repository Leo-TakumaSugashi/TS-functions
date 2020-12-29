function Imageset = TS_Skel2Crop4DeepLearning(skel,Image,Len)

CropSiz = Len + (floor(Len/2)==ceil(Len/2));
PadR = floor(CropSiz/2);
skel = padarray(skel,[PadR PadR],0);
Image = padarray(Image,[PadR PadR],0);
[y,x,z] = ind2sub(size(skel),find(skel(:)));
Imageset(1:length(y)) = struct('Label',[],'Image',[],'Center',[]);

xind = 1:size(Image,2);
yind = 1:size(Image,1);
wh = waitbar(0,'Please wait...');
for n = 1:length(y)
    im = Image(:,:,z(n));
    xcrop = and(xind>=x(n)-Len/2,xind<=x(n)+Len/2);
    ycrop = and(yind>=y(n)-Len/2,yind<=y(n)+Len/2);    
    Imageset(n).Image = im(ycrop,xcrop);
    waitbar(n/length(y),wh,['Please wait...' num2str(n) '/' num2str(length(y))])
end
close(wh)





%% MEMO
% cd \\TS-QVHL1D2\usbdisk3\Sugashi\10_Since2016\20_Matlab
% load('MG30_Loc3_Original_TOPHAT.mat', 'Image')
% load('MG30_Loc3_NewSkeleton.mat', 'skel3D')
% sum(skel3D)
% clc
% sum(skel3D(:))
% a = rand(size(skel3D))>0.99;
% b = and(a,skel3D);
% sum(b(:))
% edit TS_centroid2Crop.m
% load('MG30_Loc3_ResizData.mat', 'RmfImage')
% clear Image
% Image = TS_Image2uint8(RmfImage);
% TS_3dmipviewer(Image)
% x = false(size(a));
% x(200,200,200) = 1;
% Imageset = TS_Skel2Crop4DeepLearning(x,Image,Len);
% Len = 70;
% Imageset = TS_Skel2Crop4DeepLearning(x,Image,Len);
% figure,imagesc(Imageset(1).Image)
% Imageset = TS_Skel2Crop4DeepLearning(b,Image,Len);
% figure,imagesc(Imageset(1).Image)
% x
% clc
% clc
% clear x
% x = cat(3,Imageset.Image);
% TS_3dslider(x)
% cd ..
% mkdir('deeplearning')
% mkdir('Imageset')
% for n = 1:length(Imageset)
% imwrite(Imageset(n).Image,gray(256),['im' num2str(n) '.tif']);
% end
% for n = 1:length(Imageset)
% imwrite(TS_Image2uint8(single(Imageset(n).Image)),gray(256),['im' num2str(n) '.tif']);
% end
% help trainAutoencoder
% X
% X = abalone_dataset;
% figure,imagesc(X)
% figure,(gcf)
% figure(gcf)
% clear X
% X = cell(length(Imageset),1);
% for n = 1:length(X)
% X{n} = Imageset(n).Image;
% end
% whos X
% autoenc
% autoenc = trainAutoencoder(X,hiddenSize,...
% 'L2WeightRegularization',0.001,...
% 'SparsityRegularization',4,...
% 'sparsityProportion',0.05,...
% edit
% hiddenSize = 25;
% autoenc = trainAutoencoder(X,hiddenSize,...
% 'L2WeightRegularization',0.001,...
% 'SparsityRegularization',4,...
% 'sparsityProportion',0.05,...
% 'DecoderTransferFunction','purelin','useGPU',true);
% autoenc
% figure,imagesdc(autoenc.EncoderWeights)
% figure,imagesc(autoenc.EncoderWeights)
% view(autoenc)
% feat1 = encode(autoenc,X);
% hiddenSize2 = 10;
% autoenc2 = trainAutoencoder(feat1,hiddenSize2,...
% 'L2WeightRegularization',0.001,...
% 'SparsityRegularization',4,...
% 'sparsityProportion',0.05,...
% 'DecoderTransferFunction','purelin','useGPU',true);
% view(autoenc2)
% fead2 = encode(autoenc2,feat1)
% clc
% whos x
% clear x
% t
% [x,t] = digittrain_dataset;
% edit Autoencoder.m
% feat2 = encode(autoenc2,feat1);
% figure,plot(fead2')
% figure,imagesc(fead2)
% [x,t] = digittest_dataset;
% [x,t] = digitTestCellArrayData;
% whos x t
% class(t)
% clear x t
% net = trainSoftmaxLayer(X,feat2);
% net = trainSoftmaxLayer(X{1},feat2);
% net = trainSoftmaxLayer(single(X{1}),feat2);
% net = trainSoftmaxLayer(feat1,feat2);
% view(net)
% hiddenSizeT = 5;
% autoencT = trainAutoencoder(feat2,hiddenSizeT,...
% 'L2WeightRegularization',0.001,...
% 'SparsityRegularization',4,...
% 'sparsityProportion',0.05,...
% 'DecoderTransferFunction','purelin','useGPU',true);
% tfeat = encode(autoencT,feat2);
% net = trainSoftmaxLayer(feat2,tfeat);
% Y = net(X);
% Y = net(feat1);
% Y = net(feat2);
% plotconfusion(tfeat,Y)
% whos Y
% Y(:,1)
% Y(:,2)
% whos x
% x = cat(3,Imageset.Image);
% [~,Ind] = max(Y,[],1);
% figure,plot(Ind)
% TS_3dslider(x(:,:,Ind==1))
% TS_3dslider(x(:,:,Ind==2))
% TS_3dslider(x(:,:,Ind==3))
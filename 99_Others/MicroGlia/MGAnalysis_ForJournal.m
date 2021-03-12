%% for Figure1(a)
for n = 1:length(Ind)
    data = load(TS_ConvertNAS(cData{Ind(n),2}));
    Image = data.(cData{Ind(n),3});
    clear data
    Image = TSmedfilt2(Image,[3 3]);
    Glia = TS_GammaFilt(Image(:,:,:,:,2),0.3);
    Vas = TS_AdjImage(Image(:,:,:,1,1));
    TS_3dslider(cat(4,Vas,Glia))
    clear Image Glia Vas
end

%% 
for n = 1:7
    set(n,'Position',get(1,'Position'))
    data(n).Figure = getframe(n);
    data(n).Image = getimage(findobj('Parent',n,'Type','axes'));
end
%% imwrite
for n = 1:7
    Name = cData{Ind(n),3};
    Name = [TS_num2strNUMEL(n,2),'_' Name];
    im = data(n).Image;    
%     img = im(:,:,2);
%     img = img - TS_GetBackgroundValue(img);
%     img = TS_GammaFilt(img,0.6);
%     img = imtophat(img,strel('disk',100,0));
%     img = single(img - min(img(:)));
%     img = uint8(img./max(img(:))*255);
%     im(:,:,2) = img;
%     figure,imagesc(im)
    imwrite(im(:,:,2),[Name '_gray.tif'])
    imwrite(im,[Name '_CUD.tif'])
    imwrite(TS_CUD2ch2RG(im),[Name '_RG.tif'])
end










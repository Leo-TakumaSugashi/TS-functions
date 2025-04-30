function outputimage = TS_imopen_parfor(Image,se)
% outputimage = TS_imopen_parfor(Image,se)
% see all so TS_imageprocessing_forpallarelcomputingdata

pcoj = gcp;
NumW = pcoj.NumWorkers;
pw_data = TS_imageprocessing_forpallarelcomputingdata(Image,se,NumW);

parfor n = 1:NumW
    im = pw_data(n).Image;
    pw_data(n).Image = imopen(im,se); 
end

outputimage = [];
for n = 1:NumW
    cat_Image = pw_data(n).Image(:,:,pw_data(n).cut_Ind,:,:);
    outputimage = cat(3,outputimage,cat_Image);
end
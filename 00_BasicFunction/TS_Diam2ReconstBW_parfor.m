function A = TS_Diam2ReconstBW_parfor(DiamImage,Reso)


oh = parcluster ;
Num = oh.NumWorkers;

zind = linspace(1,size(DiamImage,3)+1,Num+1);
zdata = 1:size(DiamImage,3);
data(1:Num) = struct('Image',[],'bw',[]);
for n = 1:Num
    z = and(zdata >= zind(n) , zdata< zind(n+1));
    Image = DiamImage;
    Image(:,:,~z) = nan;
    data(n).Image = Image;
end
clear Image z DiamImage

parfor n = 1:Num
    data(n).bw = TS_Diam2ReconstBW(...
        data(n).Image,Reso);
    data(n).Image = [];
    disp(['Finish ... ' num2str(n) '/' num2str(Num)])
end

bw = cat(4,data.bw);
A = squeeze(max(bw,[],4));

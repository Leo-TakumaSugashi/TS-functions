function pw_data = TS_imageprocessing_forpallarelcomputingdata(Image,G,NumW,varargin)
% pw_data = TS_imageprocessing_forpallarelcomputingdata(Image,G,NumW)
% Input 
%     Image : ndims(Image) <=5
%     G      : kernel
%     NumW   : object of parpool, numworkers
% Output
%     pw_data : piece wise structdata
%             .Image    is croped Image
%             .Index    is zindex used crop.
%             .cut_Ind  is recommend Index of Usage in cropped Image.
%              
% ---- option ----
% pw_data = TS_imageprocessing_forpallarelcomputingdata(Image,G,NumW,'noImage')
% Output
%     pw_data : piece wise data
%             .Image : []    ===> safe memory
% 
% Example.
% pw_data = TS_imageprocessing_forpallarelcomputingdata(Image,G,NumW)
% ~~~ main process ~~~
% parfor n = 1:NumW
%     im = single(pw_data(n).Image);
%     pw_data(n).Image = ????(im,G);
%                  ex. imfilter, imopen, imclose
%                     imtophat...u can some function for pallarel computing
% end 
% outputImage = [];
% for n = 1:NumW
%     cat_Image = pw_data(n).Image(:,:,pw_data(n).cut_Ind,:,:);
%     outputImage = cat(3,outputImage,cat_Image);
% end
% 
% Edit, by Sugashi,
% modify -option, 2019 09 22
OPT = true;
if nargin ==4
    if strcmpi(varargin{1},'noimage')
        OPT = false;
    end
end

if size(G,3)==1
    Pad_siz = 0;
else
    Pad_siz = ceil(size(G,3)/2);
end
% z_siz = round(size(Image,3)/8 + Pad_siz*2);
siz = size(Image);
% pImage = zeros([siz(1:2) z_siz 8],'like',single(1));
z_pw = round(linspace(1,size(Image,3),NumW+1));
% output = []
pw_data(1:NumW) = struct('Image',[],'Index',[],'cut_Ind',[]);
for n = 1:NumW
    zdata = z_pw(n)-Pad_siz:z_pw(n+1)+Pad_siz;    
    zdata = zdata(and(zdata>0, zdata<=siz(3)));
    if OPT
        pw_data(n).Image = Image(:,:,zdata,:,:);
    end
    pw_data(n).Index = zdata;
    pw_data(n).cut_Ind = and(zdata>=z_pw(n),zdata<=z_pw(n+1)-1);
    if n ==NumW
        pw_data(n).cut_Ind = and(zdata>=z_pw(n),zdata<=z_pw(n+1));
    end
end

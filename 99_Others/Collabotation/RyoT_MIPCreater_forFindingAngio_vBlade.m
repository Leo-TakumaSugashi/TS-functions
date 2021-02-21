function [CatData,ObjSind] = RyoT_MIPCreater_forFindingAngio_vBlade(...
    Image1,Image2,Reso,RotMovStretchData,Sind,SaveDir)
%% make SaveDir
if or(ndims(Image1)~=3,ndims(Image2)~=3)
    error('input data must BE 3 D')
end
if or(length(Reso) ~=3,~isvector(Reso))
    error('Input Resolution Must BE [X Y Z] vector')
end
if ~exist(SaveDir,'dir')
    mkdir(SaveDir)
end
%% Contrast Adjust and Gamma param.
Medsiz = [5 5];
GaussianSiz = [3 3];
Gamma = 0.6;
LoopNum = 2;
CLASS = class(Image1);
%% rgbproj param.
cdata.CLim = cat(1,[0 255],[0 255]);
cdata.Color = cat(1,[1 .1 0],[0 1 0]);
cdata.Gamma = repmat(Gamma,[2 1]);
%% motage param
HorizenNum = 3;
GapRatio = 0.05;
GapColor = [.8 .8 .8];
%% Depth Step param
Margin = 10;
DepthStep =[-Inf 0 50 100:100:800];
DepthLabel = {'Surface'};
for n = 2:length(DepthStep)-1
    DepthLabel{n} = [TS_num2strNUMEL(DepthStep(n),3) 'to' ...
        TS_num2strNUMEL(DepthStep(n+1),3) 'um'];
end
%     '000to050um';'050to150um';'150to250um';'250to350um';
%     '350to450um';'450to550um';'550to650um';'650to750um'};

%% Contrast Adjust and Gamma
RImage1 = TSmedfilt2(Image1,Medsiz);
RImage1 = TS_GaussianFilt2D_GPU(RImage1,Reso,GaussianSiz,LoopNum);
% RImage1 = TS_AdjImage(RImage1);
RImage1 = TS_AdjImage_GaussianBase(RImage1);
RImage2 = TSmedfilt2(Image2,Medsiz);
RImage2 = TS_GaussianFilt2D_GPU(RImage2,Reso,GaussianSiz,LoopNum);
% RImage2 = TS_AdjImage(RImage2);
RImage2 = TS_AdjImage_GaussianBase(RImage2);
%% Rotate & Shift & interp. Image
S = Segment_Functions;
RImage2 = S.Image2RotMovStretch(RImage2,Reso,RotMovStretchData);
RImage2 = feval(class(RImage1),RImage2);
%% length check
siz1 = size(RImage1,3);
siz2 = size(RImage2,3);
Center = (size(RImage1,[1 2 3])-1).*Reso(1:3); Center = Center /2;
Sxyz = [0 0 (Sind-1)*Reso(3)];
ObjSxyz = S.xyz2RotMoveStretch(Sxyz,RotMovStretchData,Center);
ObjSind = ObjSxyz(3)/Reso(3) + 1;
if siz1>siz2
    RImage2 = padarray(RImage2,[0 0 siz1-siz2],0,'post');
elseif siz1 < siz2
    RImage1 = padarray(RImage1,[0 0 siz2-siz1],0,'post');
    Sind = Sind -(siz2-siz1);
end

%% Depth Setup
zdata =0:size(RImage1,3)-1;
zdata = zdata - Sind;
% zdata = flip(zdata,2);
zdata = -1*zdata;
DepthIndex =zdata*Reso(3);
%% MIP and Save
CatData(1:length(DepthStep)-1) = struct('Image',[],'DepthLabel',[]);
for n = 1:length(DepthStep)-1
    zind = and(DepthStep(n)-Margin<=DepthIndex,DepthIndex<DepthStep(n+1)+Margin);
    
    im1 = max(RImage1(:,:,zind),[],3);
    im2 = max(RImage2(:,:,zind),[],3);
    if isempty(im1)
        im1 = zeros(size(RImage1,[1 2]),class(RImage1));
    end
    if isempty(im2) 
        im2 = zeros(size(RImage2,[1 2]),class(RImage2));
    end
%     im1 = TS_AdjImage(im1);
%     im2 = TS_AdjImage(im2);
    im = rgbproj(cat(3,im1,im2),cdata);
    CatData(n).Image = im;
    CatData(n).DepthLabel = DepthLabel{n};
    CatData(n).zind = zind;
%     try
%         imwrite(im,[SaveDir filesep DepthLabel{n} '.tif'])
%     catch err
%         keyboard
%     end
end
try
    Cd = pwd;
    cd(SaveDir)
    for n = 1:length(CatData)
        im = CatData(n).Image;
        if isempty(im)
            continue
        end
        imwrite(im,['Depth_' DepthLabel{n} '.tif'])
    end
    X = cat(4,CatData.Image);
    im = TS_montage(X,HorizenNum,ceil(length(CatData(1).Image)*GapRatio),GapColor);
    imwrite(im,'Montage.tif')    
    cd(Cd)
catch err
    keyboard
end

end
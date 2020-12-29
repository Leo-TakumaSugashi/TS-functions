function [skel_Surf,skel_Penet] = TS_Bold2SP(Bold,SurfaceInd)
% SurfaceInd = size(Bold,3) - 100;

% cBold = imclose(Bold,ones(3,3,3));
%% **********Pafor ****************
se = ones(3,3,3);
Pad_siz = ceil(3/2);
poj = gcp;
pwNum = poj.NumWorkers;
siz = size(Bold);
% pImage = zeros([siz(1:2) z_siz 8],'like',single(1));
z_pw = round(linspace(1,size(Bold,3),pwNum+1));
% output = []
pw_data = struct('Image',[],'Index',[]);
for n = 1:pwNum
    zdata = z_pw(n)-Pad_siz:z_pw(n+1)+Pad_siz;    
    zdata = zdata(and(zdata>0, zdata<=siz(3)));
    pw_data(n).Image = Bold(:,:,zdata);
    pw_data(n).Index = zdata;
    pw_data(n).cut_Ind = and(zdata>=z_pw(n),zdata<=z_pw(n+1)-1);
    if n ==pwNum
        pw_data(n).cut_Ind = and(zdata>=z_pw(n),zdata<=z_pw(n+1));
    end
end

parfor n = 1:pwNum
    im = logical(pw_data(n).Image);
    pw_data(n).Image = imclose(im,se);
end 
outputImage = [];
% size(outputImage)
for n = 1:pwNum
    cat_Image = pw_data(n).Image(:,:,pw_data(n).cut_Ind);
%     size(cat_Image)
    outputImage = cat(3,outputImage,cat_Image);
end
% **********Pafor **************** End
cBold = outputImage;
%%

[L_Bold,Max_L] = bwlabeln(cBold,26);
if Max_L<2^16
    L_Bold = uint16(L_Bold);
end
L_Surface = L_Bold(:,:,SurfaceInd:end);
[h,x] = hist(L_Surface(L_Surface>0),0:Max_L);
Num_Ind = x(h>0);
%   clear L_Surface Max_L
tic
skel_SP = false(size(Bold));
for n = 1:length(Num_Ind)  
    skel_SP(L_Bold==Num_Ind(n)) = true;     
end
toc

skel_Surf = skel_SP;
skel_Surf(:,:,1:SurfaceInd-1) = false;
skel_Penet = skel_SP;
skel_Penet(:,:,SurfaceInd:end) = false;

% figure,pointview(skel_Surf,ones(1,3))
% hold on
% p = pointview(skel_Penet,ones(1,3));

%% delay processing ....
% % [R_bw,Preso] = TS_EqualReso3d()
% % se = TS_strel([10 10 50],NewReso,'cylinder');
% % tic
% % P_BW2 = imopen(padarray(BW(:,:,end-100:end),[0 0 1],0),se);
% % P_BW2(:,:,[1 size(P_BW2,3)]) = [];
% % toc








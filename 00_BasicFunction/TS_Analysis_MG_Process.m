%% Original Program...
% % \\TS-QVHL1D2\shere\MNTI\MN_Program\MN_culcharafixth170104

% function [P_num,result,vcon,ths,thn,thre] = MN_culcharafixth160626(Im,Ims,tit,N,ss)
% Input is ...
%     Im = [] : Image of Glia Image(3D)
%     Ims0
%     Reso  = []l]
%     
% output is ..
%     tit, title
%     'result' ; struct('Plength',[],'Area',[])
%             eace Process Length and Whole Area (sumation)
%     'P_num', Shole 分析の結果、6um以降、●刻みの項点数
%     'P_numM',代表的な交点の数
%     'ThinIm', 細線化結果（３D)
%     'fin',領域8分割
%     'fin2'　細線化8分割,
%     'SIm',soma　Image
%     'FIm2',Filtered　Image ２D
%     'Vol'　soma Volume,
%     'Area', Soma Area(断面積）
%     'lp',　円近似の径
%     'MaxRVal', 細胞領域の最大距離
%     'MaxPlen'　突起の最大距離
%     
% ss = 0.6;
% ex = ss/0.2;%ssはステップサイズ,元々ss0.2μｍで除去するオブジェクトのサイズなどを決めていたため0.2で
% Reso(1) = 0.2;

function output = TS_Analysis_MG_Process(Cropdata)
%% see also TS_centroid2Crop
tic
if length(Cropdata) > 1
    error('inputCropdata is number of metric error')
end

%% threshold by yuki
Fx =@(s) (s .*0.02 +50).*s *0.01;
%% %% Initicalize
Signal_Analysis_Limit = 1;
Im = Cropdata.Image;
Reso = Cropdata.Resolution;
Center = Cropdata.CenterOfImage;
output = Cropdata;
if ~strcmpi(class(Im),'uint8')
    error('Input Class Is NOT uint8')
end

output.InputImage = 'Image';
% output.Resolution = Reso;
output.Input_Center_Position = Center;
output.Dummy = [];

%% 突起二値化＆細線化
% Im = imclose(Im,ones(3,3,3));
%% Mexican Hat Filter

FIm = TS_MexicanHatFilt(Im,Reso);

output.FilteredImage = FIm;

%% Binarize
signal_coef = 0.05;
bg = MN_mode(FIm(:),100);
sg = sort(FIm(:),'descend');
sg = mean(sg(1:round(length(sg)*signal_coef)));
thn = bg+(sg-bg)*0.5;
BW = FIm> thn;
clear thn sg bg signal_coef

output.BinarizedImage = BW;


%% 細胞体重心
% イメージ（3D)の中で、細胞が複数あることを考慮し、
% 画像中心に一番近いオブジェクトを選定することに変更
% Center = size(Im) /2;
Soma_siz = 4; % [um]

% % openning and BW of soma
se = strel('ball',round(Soma_siz/Reso(1)/2),round(Soma_siz/Reso(3)/2),0);
Im_soma =  imopen(Im,se);
level = graythresh(max(Im_soma,[],3));

% Noise = MN_mode(Im_soma,round(max(Im_soma(:))));
BW_soma = Im_soma > (255*level) ;
clear Noise

L = bwlabeln(BW_soma);
% Center of Sorma(Nearest of Image's center)
s = regionprops(L,'Centroid');
s = cat(1,s.Centroid);
Center = repmat(Center,[size(s,1), 1]);
Len = sqrt(  sum((Center - s).^2 , 2) );
[~,Idx] = min(Len);


Soma_Center = s(Idx,:);
Soma_Select_BW = L == Idx;

% % Correct Binary
xdata = 1:size(Im,2);
ydata = 1:size(Im,1);
zdata = 1:size(Im,3);
xind = and(xdata>=Soma_Center(1)-1,xdata<=Soma_Center(1)+1);
yind = and(ydata>=Soma_Center(2)-1,ydata<=Soma_Center(2)+1);
zind = and(zdata>=Soma_Center(3)-1,zdata<=Soma_Center(3)+1);
GIm = TS_GaussianFilt(Im,Reso,[1 1 1]);
Signal = GIm(yind,xind,zind);
Signal = mean(Signal(:));
Threshold = Fx(Signal);

bw = GIm > Threshold;
if Signal < Signal_Analysis_Limit
    Threshold = Inf;
    bw = false(size(GIm));
    bw(round(Soma_Center(2)),...
        round(Soma_Center(1)),...
        round(Soma_Center(3))) = true;
end


L = bwlabeln(bw);
s = regionprops(L,'Centroid');
s = cat(1,s.Centroid);
Len = sum((s - repmat(Soma_Center,[size(s,1) 1])).^2 , 2);
[~,Idx] = min(Len);
bw =  L == Idx;
Soma_SectionalArea_Image = bw(:,:,round(Soma_Center(3)));
Soma_SectionalArea = sum(Soma_SectionalArea_Image(:)) * Reso(1)^2;

output.Soma_open_Image = Im_soma;
output.Soma_open_BW = BW_soma;
output.Soma_open_Select_BW = Soma_Select_BW;
output.Soma_Center = Soma_Center;
output.Soma_Signal = Signal;
output.Threshold = Threshold;
output.Soma_BW = bw;
output.Soma_SectionalArea_Image = Soma_SectionalArea_Image;
output.Soma_SectionalArea = Soma_SectionalArea;
output.Soma_SectionalAreaUnit = 'um^2';

% Vol = Soma_Select_BW ;
% Vol = and(BW_soma,Voronoi_Area);
Vol = sum(bw(:)) * prod(Reso);
% SIm = Im_soma;
% SIm(~Voronoi_Area) = 0;

output.Soma_Volume = Vol;
output.Soma_VolumeUnit = 'um^3';


%% Area Open and output skeleton MIP data
% % FIm2 = bwareaopen(FIm2,9,8);%% ???????
% BW = bwareaopen(BW,round(3^4/ex)); %%% ?????? What purpouse


ThinIm = TS_Skeleton_2017(BW);
output.Skeleton = ThinIm;

ThinLabel = bwlabeln(ThinIm);
Lnum = ThinLabel(Soma_Select_BW);
Lnum(Lnum==0) = [];
[h,x] = hist(Lnum,1:max(Lnum));
x(h==0) = [];
choice = false(size(ThinIm));


for n = 1:length(x)
    choice = or(choice,ThinLabel==x(n));
end

ThinIm = choice;
Tmip = squeeze(max(ThinIm,[],3));

output.Skeleton_Select = ThinIm;
output.Skeleton_Select_MIP = Tmip;



%% TS program --> MN
ct = round(Soma_Center);



%% distance

base = zeros(size(Tmip));
base(ct(2),ct(1)) = 1;
base = bwdist(base);
Thindist = base .* single(Tmip);   
output.Skeleton2D_dist = Thindist;
    
%% Sholl分析様子    
%% 本数測定
Cir = base;

for n=6:2:80
Cir(Cir>=n*1/Reso(1)&Cir<n*1/Reso(1)+1) = 1; 
end
Cir(Cir>1)=0;
Cir(Cir<1)=0;
C = imfuse(Thindist>0,Cir,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
% figure,imshow(C)
% saveas(gcf,[tit,'ShollImThin'],'tif')
% saveas(gcf,[tit,'ShollImThin'],'fig')
% close
P_num = zeros([2 40]);
m = 1;
for n=6:2:80
ring = Thindist>=n*1/Reso(1)&Thindist<n*1/Reso(1)+1;%8.33は2μm相当のpixelサイズ,1.74はルート3を超える値 
ringlbl = bwlabel(ring,8);
P_num(1,m) = n; 
% ProsNum(2,n) = max(kyulbl(:));
P_num(2,m) = max(ringlbl(:));
clear ring ringlbl
m = m+1;
end
P_numM = [P_num(2,6) P_num(2,9) P_num(2,18)];

output.Sholl_Analysis.image = C;
output.Sholl_Analysis.P_num = P_num;
output.Sholl_Analysis.P_numM = P_numM;

%% Dived Segment Number
Segment_Num = 20;
L = MN_DivideArea(Segment_Num,Soma_Center(1:2),[size(Im,1) size(Im,2)]);
L_Len = L .*single(max(ThinIm,[],3));
% L_Area = L.*single(NRIm2);

Theta = linspace(0,2*pi,Segment_Num+1);
Theta(end) = [];
% Each_Area = zeros(Segment_Num,1);
Each_Length = zeros(Segment_Num,1);
Each_MaxLength = zeros(Segment_Num,1);
% Each_Density = Each_Area;
for n = 1:Segment_Num
%     Each_Area(n) = sum(L_Area(:) == n)* Reso(1)^2;
    Each_Length(n) = sum(L_Len(:)==n) * Reso(1);
    Each_MaxLength(n) = max(Thindist(L==n));
end
% Each_Density = Each_Length ./Each_Area ;

% figure,plot(Theta,Each_Area),
% hold on
% plot(Theta,Each_Length)
% plot(Theta,Each_Density)
output.SegmentAnalysis.Label = uint8(L);
output.SegmentAnalysis.Label_Skeleton2D = L_Len;
% output.SegmentAnalysis.Label_ProcessArea = L_Area;
output.SegmentAnalysis.Theta = Theta;
% output.SegmentAnalysis.Each_Area = Each_Area;
output.SegmentAnalysis.Each_Length = Each_Length;
output.SegmentAnalysis.Each_MaxLength = Each_MaxLength;
% output.SegmentAnalysis.Each_Density = Each_Density;
output.SegmentAnalysis.Units = 'rad. and um';

output = rmfield(output,'BinarizedImage');
output = rmfield(output,'Soma_open_Image');
output = rmfield(output,'Soma_open_BW');
output = rmfield(output,'Soma_open_Select_BW');

%% Sugashi Analysis



%% Toc
toc
%%
%     %重心と重心から一番遠い点が軸となるように回転
%     base = zeros(size(NRIm2));
%     base(round(ct(1)),round(ct(2)))=1;
%     bdist = bwdist(base);
%     rdist = bdist.*double(NRIm2);
%     data = rdist;
%     clear base bdist rdist
%     if ct(1)>round(size(data,1)/2)
%         out = padarray(data,abs([2 * ct(1) - size(data,1) , 0]),'post');
%         Tmip2 = padarray(Tmip,abs([2 * ct(1) - size(Tmip,1) , 0]),'post');
%     else
%         out = padarray(data,abs([size(data,1) - 2 * ct(1) , 0]),'pre');
%         Tmip2 = padarray(Tmip,abs([size(Tmip,1) - 2 * ct(1) , 0]),'pre');
%     end
%     if ct(2)>round(size(out,2)/2)
%         out = padarray(out,abs([0 , 2 * ct(2) - size(out,2)]),'post');
%         Tmip2 = padarray(Tmip2,abs([0 , 2 * ct(2) - size(Tmip2,2)]),'post');
%     else
%         out = padarray(out,abs([0 , size(out,2) - 2 * ct(2)]),'pre');
%         Tmip2 = padarray(Tmip2,abs([0 , size(Tmip2,2) - 2 * ct(2)]),'pre');
%     end
% %     out = zeros(size(data)*1.5+1);
% %     rl = size(data)*1.5+1;
% %     xrange = (rl(1)-1)*0.5-round(ct(1))+2:(rl(1)-1)*0.5-round(ct(1))+size(data,1)+1;
% %     yrange = (rl(1)-1)*0.5-round(ct(2))+2:(rl(1)-1)*0.5-round(ct(2))+size(data,1)+1;
% %     out(xrange,yrange)=data;
%     fpos = out>=max(out(:));
%     MaxRVal = max(out(:)) * Reso(1); 
%     [y,x] = find(fpos);
%     Zx = x - round(size(out,2)/2);%絶対座標に変換 
%     Zy = - (y - round(size(out,2)/2));
% %     Zx = (y-(rl(1)-1)*0.5-1);%絶対座標に変換 
% %     Zy = -(x-(rl(1)-1)*0.5-1);
%     theta = atan(Zy/Zx)/pi()*180;
%     if Zx < 0
%        theta = theta + 180; 
%     end
%     sym1 = imrotate(out,-theta+90);
%     sym = sym1>0;
%     sym = imfill(sym,'holes');
% %     Tmip2 = zeros(size(data)*1.5+1);
% %     Tmip2(xrange,yrange)=Tmip;
%     Tmip = imrotate(Tmip2,-theta+90);
%     ctf = round([(size(sym,1)-1)/2+1,(size(sym,1)-1)/2+1]);
%     clear data Tmip2 sym1 
% %領域８分割    
% S = size(sym);
% Are = zeros([S(1),S(2)]);
% for x = 1:S(2)
% for y = 1:S(1)
%     y1 = -(y-ctf(1));
%     x1 = x-ctf(2);
%     if (y1>=tan(3/8*pi)*x1)&&(y1>tan(5/8*pi)*x1)
% %     if (x<40)
%         Are(y,x) = 1;
%     end
% end
% end
% 
% for x = 1:S(2)
% for y = 1:S(1)
%     y1 = -(y-ctf(1));
%     x1 = x-ctf(2);
%     if (y1<=tan(5/8*pi)*x1)&&(y1>tan(7/8*pi)*x1)
% %     if (x<40)
%         Are(y,x) = 8;
%     end
% end
% end
% 
% 
% 
% for x = 1:S(2)
% for y = 1:S(1)
%     y1 = -(y-ctf(1));
%     x1 = x-ctf(2);
%     if (y1<=tan(7/8*pi)*x1)&&(y1>tan(9/8*pi)*x1)
% %     if (x<40)
%         Are(y,x) = 7;
%     end
% end
% end
% 
% for x = 1:S(2)
% for y = 1:S(1)
%     y1 = -(y-ctf(1));
%     x1 = x-ctf(2);
%     if (y1<=tan(9/8*pi)*x1)&&(y1>tan(11/8*pi)*x1)
% %     if (x<40)
%         Are(y,x) = 6;
%     end
% end
% end
% 
% for x = 1:S(2)
% for y = 1:S(1)
%     y1 = -(y-ctf(1));
%     x1 = x-ctf(2);
%     if (y1<=tan(11/8*pi)*x1)&&(y1<tan(13/8*pi)*x1)
% %     if (x<40)
%         Are(y,x) = 5;
%     end
% end
% end
% 
% for x = 1:S(2)
% for y = 1:S(1)
%     y1 = -(y-ctf(1));
%     x1 = x-ctf(2);
%     if (y1>=tan(13/8*pi)*x1)&&(y1<tan(15/8*pi)*x1)
% %     if (x<40)
%         Are(y,x) = 4;
%     end
% end
% end
% 
% for x = 1:S(2)
% for y = 1:S(1)
%     y1 = -(y-ctf(1));
%     x1 = x-ctf(2);
%     if (y1>=tan(15/8*pi)*x1)&&(y1<tan(1/8*pi)*x1)
% %     if (x<40)
%         Are(y,x) = 3;
%     end
% end
% end
% 
% for x = 1:S(2)
% for y = 1:S(1)
%     y1 = -(y-ctf(1));
%     x1 = x-ctf(2);
%     if (y1>=tan(1/8*pi)*x1)&&(y1<tan(3/8*pi)*x1)
% %     if (x<40)
%         Are(y,x) = 2;
%     end
% end
% end
% fin = double(Are).*double(sym);
% fin2 = double(Tmip).*fin;
% for n = 1:max(fin(:))
%     pl = fin2 == n;
%     result(n).Plength = sum(pl(:))*(Reso(1)^2);
%     area = fin == n;
%     result(n).Area = sum(area(:))*Reso(1);
% end
%   
% clear sym pl area Are
% 
%     map = [0,0,0;...%1
%     1,0,0;...%2
%     0/255,255/255,0/255;...%5
%     180/255,30/255,255/255;...%4
%     255/255,255/255,0/255;...%7
%     255/255,0,255/255;...%3
%     171/255,255/255,127/255;...%6
%     0/255,200/255,255/255;...%5
%     255/255,165/255,0/255;];%9
%     Area2 = SIm(:,:,round(ct(3)));
%     Areaf = bwmorph(Area2,'remove');
%     [cx,cy] = find(Areaf);
%     [a,b,r,RealRadius] = MN_CircleFit170204(cx,cy,Reso(1));
%     figure,imshow(Ims(:,:,round(ct(3)))),axis image off,colormap(jet)
%     saveas(gcf,[tit,'細胞体断面'],'tif')
%     saveas(gcf,[tit,'細胞体断面'],'fig')
%     close
%     Area = bwarea(Area2) * Reso(1)^2;
%     ly = RealRadius;
%     lx = RealRadius;
%     lz = sum(squeeze(SIm(round(ct(1)),round(ct(2)),:)));
%     lp = [lx,ly,lz*ss];
%     vcon.Vol = Vol;
%     vcon.Area = Area;
%     vcon.lp = lp;
%     figure,imshow(fin + 1),axis image off,colormap(map)
%     saveas(gcf,[tit,'領域'],'tif')
%     saveas(gcf,[tit,'領域'],'fig')
%     close
%     figure,imshow(fin2 + 1),axis image off,colormap(map)
%     saveas(gcf,[tit,'細線化'],'tif')
%     saveas(gcf,[tit,'細線化'],'fig')
%     close
%     save([tit,'ConRes'],'result','P_num','P_numM','ThinIm','fin','fin2','SIm','FIm2','Vol','Area','lp','MaxRVal','MaxPlen')
%     clear result
% % end



% % % % % function [P_num,result,vcon,ths,thn,thre] = MN_culcharafixth160626(Im,Ims,tit,N,ss)
% % % % ss = 0.6;
% % % % ex = ss/0.2;%ssはステップサイズ,元々ss0.2μｍで除去するオブジェクトのサイズなどを決めていたため0.2で
% % % % Reso(1) = 0.2;
% % % %    
% % % %     %突起二値化＆細線化
% % % %     para1 = 24; % 遮断s
% % % %     para2 = 12; % 通過
% % % %     h0 = fspecial('average',100);
% % % %     h1 = fspecial('gaussian',100,para1/2.35);
% % % %     h2 = fspecial('gaussian',100,para2/2.35);
% % % %     H2 = h0 - h1*6 + h2*6;
% % % %     Iml = imresize(Im,'scale',3);
% % % % %     Iml = Im;
% % % %     FIm = zeros(size(Iml));
% % % %     for n = 1:size(Iml,3)
% % % %         FIm(:,:,n) = imfilter(single(Iml(:,:,n)),H2,'symmetric');
% % % %     %     FI2 = imclose(FI,strel('disk',round(para2/Reso)));
% % % %     end
% % % %     clear Iml
% % % %     FIm = imresize(FIm,'scale',1/3);
% % % %     bg = MN_mode(FIm(:),100);
% % % %     sv = sort(FIm(:),'descend');
% % % %     sg = mean(sv(1:round(length(sv)*0.05)));
% % % %     FIm2 = FIm>=bg+(sg-bg)*0.5;
% % % %     thn = bg+(sg-bg)*0.5;
% % % %     FIm2 = bwareaopen(FIm2,9,8);
% % % %     FIm2 = bwareaopen(FIm2,round(3^4/ex));
% % % %     ThinIm = TS_bwmorph3d(FIm2,'thin');%v8への変更を検討
% % % %     ThinIm = bwlabeln(ThinIm,26);
% % % %     ThinIm = ThinIm == mode(ThinIm(ThinIm>0));
% % % %     clear thin10 thin2 thin FIm
% % % %     Tmip = max(ThinIm,[],3);
% % % %     %突起領域抽出
% % % %     Im2 = Im;
% % % %     % Im2 = medfilt3(Im,[3 3 3]);
% % % %     SE = strel('disk',3);
% % % %     for n = 1:size(Im2,3)
% % % %         Im2(:,:,n) = imclose(Im2(:,:,n),SE);
% % % %     end    
% % % %     % Im2 = smooth3(Im2);
% % % %     bg = MN_mode(Im2(:),100);
% % % %     sg = max(Im2(:));
% % % %     NRIm = Im2>=bg+(sg-bg)*0.05;
% % % %     thre = bg+(sg-bg)*0.05;
% % % %     NRIm = bwareaopen(NRIm,round(2000/ex));
% % % %     NRIm2 = max(NRIm,[],3);
% % % %     NRIm2 = imfill(NRIm2,'holes');
% % % %     % 他のオブジェクト除去
% % % % %        NRIm2 = bwlabeln(NRIm2,8);
% % % % %        frame = zeros(size(NRIm2));
% % % % %        frame(1,:) = 1;frame(end,:) = 1;frame(:,1) = 1;frame(:,end) = 1;
% % % % %        test = NRIm2.*frame;
% % % % %        test(test==0) = [];
% % % % %        if isempty(test) == 0
% % % % %        pmode = mode(test(:));
% % % % %        if bwarea(test==mode(test(:))) > 30
% % % % %           NRIm2(NRIm2==mode(test(:))) = 0; 
% % % % %        end
% % % % %        end
% % % % %        NRIm2 = NRIm2>0;
% % % %        NRIm2 = bwlabeln(NRIm2,8);
% % % %        NRIm2 = NRIm2 == mode(NRIm2(NRIm2>0));
% % % %     %細胞体重心
% % % %     SE = strel('disk',3);
% % % %     Ims2 = medfilt3(Ims,[3 3 3]);
% % % %     for n = 1:size(Ims2,3)
% % % %         Ims2(:,:,n) = imclose(Ims2(:,:,n),SE);
% % % %     end
% % % %     Ims2 = smooth3(Ims2);
% % % %     bg = MN_mode(Ims2(:),100);
% % % %     sg = max(Ims2(:));
% % % %     SIm = Ims2>=bg+(sg-bg)*0.2;
% % % %     ths = bg+(sg-bg)*0.2;
% % % %     SIm = bwareaopen(SIm,round(2000/ex));
% % % %     %注目細胞体選別
% % % %     NRIm = bwlabeln(NRIm,26);
% % % %     NRIm = NRIm == mode(NRIm(NRIm>0));
% % % %     [x,y,z] = MN_find3(NRIm);
% % % %     ctn = round([mean(x),mean(y),mean(z)]);
% % % %     NRdist = zeros(size(SIm));
% % % %     NRdist(ctn(1),ctn(2),ctn(3)) = 1;
% % % %     NRdist = bwdist(NRdist);
% % % %     LSIm = bwlabeln(SIm,26);
% % % %     NRSdist = single(NRdist) .* single(SIm);
% % % %     [y,x,z] = MN_find3(NRSdist==min(NRSdist(NRSdist>0)));
% % % %     SIm = LSIm == LSIm(round(mean(y)),round(mean(x)),round(mean(z)));
% % % % %     LSIm1 = LSIm;
% % % % %     LSIm1(LSIm1==0) = [];
% % % % %     SIm = LSIm == mode(LSIm1);
% % % % %     clear LSIm LSIm1
% % % %     [x,y,z] = MN_find3(SIm);
% % % %     ct = [mean(x),mean(y),mean(z)];
% % % %     ct = round(ct);
% % % %     Vol = sum(SIm(:))*Reso(1)^2*ss;
% % % %     MN_3DIm(SIm)
% % % %     daspect([1,1,1/3])
% % % %     xlim([ct(2)-40 ct(2)+40])
% % % %     ylim([ct(1)-40 ct(1)+40])
% % % %     zlim([ct(3)-20 ct(3)+20])
% % % %     saveas(gcf,[tit,'細胞体3D'],'tif')
% % % %     saveas(gcf,[tit,'細胞体3D'],'fig')
% % % %     close
% % % %     clear NRIm 
% % % %     base = zeros(size(Tmip));
% % % %     base(ct(1),ct(2)) = 1;
% % % %     base = bwdist(base);
% % % %     RangeTmip = Tmip .* NRIm2;
% % % %     Thindist = base .* single(RangeTmip);   
% % % %     clear base
% % % %     MaxPlen = max(Thindist(:));
% % % %     %% 本数測定
% % % % Cir = base;
% % % % % Sholl分析様子
% % % % for n=6:2:80
% % % % Cir(Cir>=n*1/Reso(1)&Cir<n*1/Reso(1)+1) = 1; 
% % % % end
% % % % Cir(Cir>1)=0;
% % % % Cir(Cir<1)=0;
% % % % C = imfuse(Thindist>0,Cir,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
% % % % figure,imshow(C)
% % % % saveas(gcf,[tit,'ShollImThin'],'tif')
% % % % saveas(gcf,[tit,'ShollImThin'],'fig')
% % % % close
% % % % P_num = zeros([2 40]);
% % % % m = 1;
% % % % for n=6:2:80
% % % % ring = Thindist>=n*1/Reso(1)&Thindist<n*1/Reso(1)+1;%8.33は2μm相当のpixelサイズ,1.74はルート3を超える値 
% % % % ringlbl = bwlabel(ring,8);
% % % % P_num(1,m) = n; 
% % % % % ProsNum(2,n) = max(kyulbl(:));
% % % % P_num(2,m) = max(ringlbl(:));
% % % % clear ring ringlbl
% % % % m = m+1;
% % % % end
% % % % P_numM = [P_num(2,6) P_num(2,9) P_num(2,18)];
% % % % %%
% % % %     %重心と重心から一番遠い点が軸となるように回転
% % % %     base = zeros(size(NRIm2));
% % % %     base(round(ct(1)),round(ct(2)))=1;
% % % %     bdist = bwdist(base);
% % % %     rdist = bdist.*double(NRIm2);
% % % %     data = rdist;
% % % %     clear base bdist rdist
% % % %     if ct(1)>round(size(data,1)/2)
% % % %         out = padarray(data,[2 * ct(1) - size(data,1) , 0],'post');
% % % %         Tmip2 = padarray(Tmip,[2 * ct(1) - size(Tmip,1) , 0],'post');
% % % %     else
% % % %         out = padarray(data,[size(data,1) - 2 * ct(1) , 0],'pre');
% % % %         Tmip2 = padarray(Tmip,[size(Tmip,1) - 2 * ct(1) , 0],'pre');
% % % %     end
% % % %     if ct(2)>round(size(out,2)/2)
% % % %         out = padarray(out,[0 , 2 * ct(2) - size(out,2)],'post');
% % % %         Tmip2 = padarray(Tmip2,[0 , 2 * ct(2) - size(Tmip2,2)],'post');
% % % %     else
% % % %         out = padarray(out,[0 , size(out,2) - 2 * ct(2)],'pre');
% % % %         Tmip2 = padarray(Tmip2,[0 , size(Tmip2,2) - 2 * ct(2)],'pre');
% % % %     end
% % % % %     out = zeros(size(data)*1.5+1);
% % % % %     rl = size(data)*1.5+1;
% % % % %     xrange = (rl(1)-1)*0.5-round(ct(1))+2:(rl(1)-1)*0.5-round(ct(1))+size(data,1)+1;
% % % % %     yrange = (rl(1)-1)*0.5-round(ct(2))+2:(rl(1)-1)*0.5-round(ct(2))+size(data,1)+1;
% % % % %     out(xrange,yrange)=data;
% % % %     fpos = out>=max(out(:));
% % % %     MaxRVal = max(out(:)) * Reso(1); 
% % % %     [y,x] = find(fpos);
% % % %     Zx = x - round(size(out,2)/2);%絶対座標に変換 
% % % %     Zy = - (y - round(size(out,2)/2));
% % % % %     Zx = (y-(rl(1)-1)*0.5-1);%絶対座標に変換 
% % % % %     Zy = -(x-(rl(1)-1)*0.5-1);
% % % %     theta = atan(Zy/Zx)/pi()*180;
% % % %     if Zx < 0
% % % %        theta = theta + 180; 
% % % %     end
% % % %     sym1 = imrotate(out,-theta+90);
% % % %     sym = sym1>0;
% % % %     sym = imfill(sym,'holes');
% % % % %     Tmip2 = zeros(size(data)*1.5+1);
% % % % %     Tmip2(xrange,yrange)=Tmip;
% % % %     Tmip = imrotate(Tmip2,-theta+90);
% % % %     ctf = round([(size(sym,1)-1)/2+1,(size(sym,1)-1)/2+1]);
% % % %     clear data Tmip2 sym1 
% % % % %領域８分割    
% % % % S = size(sym);
% % % % Are = zeros([S(1),S(2)]);
% % % % for x = 1:S(2)
% % % % for y = 1:S(1)
% % % %     y1 = -(y-ctf(1));
% % % %     x1 = x-ctf(2);
% % % %     if (y1>=tan(3/8*pi)*x1)&&(y1>tan(5/8*pi)*x1)
% % % % %     if (x<40)
% % % %         Are(y,x) = 1;
% % % %     end
% % % % end
% % % % end
% % % % 
% % % % for x = 1:S(2)
% % % % for y = 1:S(1)
% % % %     y1 = -(y-ctf(1));
% % % %     x1 = x-ctf(2);
% % % %     if (y1<=tan(5/8*pi)*x1)&&(y1>tan(7/8*pi)*x1)
% % % % %     if (x<40)
% % % %         Are(y,x) = 8;
% % % %     end
% % % % end
% % % % end
% % % % 
% % % % 
% % % % 
% % % % for x = 1:S(2)
% % % % for y = 1:S(1)
% % % %     y1 = -(y-ctf(1));
% % % %     x1 = x-ctf(2);
% % % %     if (y1<=tan(7/8*pi)*x1)&&(y1>tan(9/8*pi)*x1)
% % % % %     if (x<40)
% % % %         Are(y,x) = 7;
% % % %     end
% % % % end
% % % % end
% % % % 
% % % % for x = 1:S(2)
% % % % for y = 1:S(1)
% % % %     y1 = -(y-ctf(1));
% % % %     x1 = x-ctf(2);
% % % %     if (y1<=tan(9/8*pi)*x1)&&(y1>tan(11/8*pi)*x1)
% % % % %     if (x<40)
% % % %         Are(y,x) = 6;
% % % %     end
% % % % end
% % % % end
% % % % 
% % % % for x = 1:S(2)
% % % % for y = 1:S(1)
% % % %     y1 = -(y-ctf(1));
% % % %     x1 = x-ctf(2);
% % % %     if (y1<=tan(11/8*pi)*x1)&&(y1<tan(13/8*pi)*x1)
% % % % %     if (x<40)
% % % %         Are(y,x) = 5;
% % % %     end
% % % % end
% % % % end
% % % % 
% % % % for x = 1:S(2)
% % % % for y = 1:S(1)
% % % %     y1 = -(y-ctf(1));
% % % %     x1 = x-ctf(2);
% % % %     if (y1>=tan(13/8*pi)*x1)&&(y1<tan(15/8*pi)*x1)
% % % % %     if (x<40)
% % % %         Are(y,x) = 4;
% % % %     end
% % % % end
% % % % end
% % % % 
% % % % for x = 1:S(2)
% % % % for y = 1:S(1)
% % % %     y1 = -(y-ctf(1));
% % % %     x1 = x-ctf(2);
% % % %     if (y1>=tan(15/8*pi)*x1)&&(y1<tan(1/8*pi)*x1)
% % % % %     if (x<40)
% % % %         Are(y,x) = 3;
% % % %     end
% % % % end
% % % % end
% % % % 
% % % % for x = 1:S(2)
% % % % for y = 1:S(1)
% % % %     y1 = -(y-ctf(1));
% % % %     x1 = x-ctf(2);
% % % %     if (y1>=tan(1/8*pi)*x1)&&(y1<tan(3/8*pi)*x1)
% % % % %     if (x<40)
% % % %         Are(y,x) = 2;
% % % %     end
% % % % end
% % % % end
% % % % fin = double(Are).*double(sym);
% % % % fin2 = double(Tmip).*fin;
% % % % for n = 1:max(fin(:))
% % % %     pl = fin2 == n;
% % % %     result(n).Plength = sum(pl(:))*(Reso(1)^2);
% % % %     area = fin == n;
% % % %     result(n).Area = sum(area(:))*Reso(1);
% % % % end
% % % %   
% % % % clear sym pl area Are
% % % % 
% % % %     map = [0,0,0;...%1
% % % %     1,0,0;...%2
% % % %     0/255,255/255,0/255;...%5
% % % %     180/255,30/255,255/255;...%4
% % % %     255/255,255/255,0/255;...%7
% % % %     255/255,0,255/255;...%3
% % % %     171/255,255/255,127/255;...%6
% % % %     0/255,200/255,255/255;...%5
% % % %     255/255,165/255,0/255;];%9
% % % %     Area2 = SIm(:,:,round(ct(3)));
% % % %     Areaf = bwmorph(Area2,'remove');
% % % %     [cx,cy] = find(Areaf);
% % % %     [a,b,r,RealRadius] = MN_CircleFit170204(cx,cy,Reso(1));
% % % %     figure,imshow(Ims(:,:,round(ct(3)))),axis image off,colormap(jet)
% % % %     saveas(gcf,[tit,'細胞体断面'],'tif')
% % % %     saveas(gcf,[tit,'細胞体断面'],'fig')
% % % %     close
% % % %     Area = bwarea(Area2) * Reso(1)^2;
% % % %     ly = RealRadius;
% % % %     lx = RealRadius;
% % % %     lz = sum(squeeze(SIm(round(ct(1)),round(ct(2)),:)));
% % % %     lp = [lx,ly,lz*ss];
% % % %     vcon.Vol = Vol;
% % % %     vcon.Area = Area;
% % % %     vcon.lp = lp;
% % % %     figure,imshow(fin + 1),axis image off,colormap(map)
% % % %     saveas(gcf,[tit,'領域'],'tif')
% % % %     saveas(gcf,[tit,'領域'],'fig')
% % % %     close
% % % %     figure,imshow(fin2 + 1),axis image off,colormap(map)
% % % %     saveas(gcf,[tit,'細線化'],'tif')
% % % %     saveas(gcf,[tit,'細線化'],'fig')
% % % %     close
% % % %     save([tit,'ConRes'],'result','P_num','P_numM','ThinIm','fin','fin2','SIm','FIm2','Vol','Area','lp','MaxRVal','MaxPlen')
% % % %     clear result
% % % % % end
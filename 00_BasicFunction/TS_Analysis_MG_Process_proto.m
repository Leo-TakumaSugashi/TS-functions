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
%     'P_num', Shole ���͂̌��ʁA6um�ȍ~�A�����݂̍��_��
%     'P_numM',��\�I�Ȍ�_�̐�
%     'ThinIm', �א������ʁi�RD)
%     'fin',�̈�8����
%     'fin2'�@�א���8����,
%     'SIm',soma�@Image
%     'FIm2',Filtered�@Image �QD
%     'Vol'�@soma Volume,
%     'Area', Soma Area(�f�ʐρj
%     'lp',�@�~�ߎ��̌a
%     'MaxRVal', �זE�̈�̍ő勗��
%     'MaxPlen'�@�ˋN�̍ő勗��
%     
% ss = 0.6;
% ex = ss/0.2;%ss�̓X�e�b�v�T�C�Y,���Xss0.2�ʂ��ŏ�������I�u�W�F�N�g�̃T�C�Y�Ȃǂ����߂Ă�������0.2��
% Reso(1) = 0.2;

function output = TS_Analysis_MG_Process_proto(Im,Reso,Center,BWpointImage)
tic
output.InputImage = Im;
output.Resolution = Reso;
output.Original_Position = Center;
output.Dummy = [];

%% �ˋN��l�����א���
Im = imclose(Im,ones(3,3,3));
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

%% Area Open and output skeleton MIP data
% % FIm2 = bwareaopen(FIm2,9,8);%% ???????
% BW = bwareaopen(BW,round(3^4/ex)); %%% ?????? What purpouse

% ThinIm = TS_bwmorph3d(BW,'thin');%v8�ւ̕ύX������
ThinIm = TS_Skeleton3D_v8(BW);
output.Skeleton = ThinIm;

 % %Ceneter �ɋ߂����݂̂̂��g�p�A
 BWpointImage = imdilate(uint8(BWpointImage),TS_strel([5 5 8],Reso(1:3),'ball'));
 BWpointImage = bwlabeln(BWpointImage>0);
 [~,Label] = TS_ErosionImage(BWpointImage>0,ThinIm);
 rCenter = round(Center);
 choice_label = BWpointImage(rCenter(2),rCenter(1),rCenter(3));
 
 ThinIm = Label ==choice_label;
 figure,imagesc(max(Label,[],3)),axis image
 figure,imagesc(max(ThinIm,[],3)),axis image
% ThinIm = bwlabeln(ThinIm,26);
% ThinIm = ThinIm == mode(ThinIm(ThinIm>0));

Tmip = max(ThinIm,[],3);

output.Skeleton_Select = ThinIm;
output.Skeleton_Select_MIP = Tmip;


%% �ˋN�̈撊�o
% % Im2 = Im;
% % % Im2 = medfilt3(Im,[3 3 3]);
% % % SE = strel('disk',3);
% % SE = strel('ball',3,3,0);
% % Im2 = imclose(Im2,SE);
% % % Im2 = smooth3(Im2);
% % bg = MN_mode(Im2(:),100);
% % sg = double(max(Im2(:)));
% % thre = bg+(sg-bg)*0.05;
% % NRIm = Im2 >= thre;
% % clear bg sg thre SE
% % 
% % output.ProcessArea = NRIm;
       
%% �זE�̏d�S
% �C���[�W�i3D)�̒��ŁA�זE���������邱�Ƃ��l�����A
% �摜���S�Ɉ�ԋ߂��I�u�W�F�N�g��I�肷�邱�ƂɕύX
% Center = size(Im) /2;
Soma_siz = 4; % [um]

% % openning and BW of soma
se = strel('ball',round(Soma_siz/Reso(1)/2),round(Soma_siz/Reso(3)/2),0);
Im_soma =  imopen(Im,se);
Noise = MN_mode(Im_soma,round(max(Im_soma(:))));
BW_soma = Im_soma- Noise > 0;
clear Noise

L = bwlabeln(BW_soma);
% Center of Sorma(Nearest of Image's center)
s = regionprops(L,'Centroid');
s = cat(1,s.Centroid);
Center = repmat(Center,[size(s,1), 1]);
Len = sqrt(  sum((Center - s).^2 , 2) );
[~,Idx] = min(Len);
Soma_Center = s(Idx,:);
Soma_Select_BW = L == L(rCenter(2),rCenter(1),rCenter(3));
Soma_SectionalArea_Image = Soma_Select_BW(:,:,round(Soma_Center(3)));
Soma_SectionalArea = sum(Soma_SectionalArea_Image(:)) * R(1)^2;

output.Soma_open_Image = Im_soma;
output.Soma_BW = BW_soma;
output.Soma_Center = Soma_Center;
output.Soma_SectionalArea_Image = Soma_SectionalArea_Image;
output.Soma_SectionalArea = Soma_SectionalArea;

% Voronoi
[Resize_BW_soma,NewReso] = TS_EqualReso3d_parfor(BW_soma,Reso,Reso(1));
[~,Idx] = bwdist(Resize_BW_soma);
L = bwlabeln(Resize_BW_soma);
Voronoi_Segment = L;
Voronoi_Segment(~Resize_BW_soma) = L(Idx(~Resize_BW_soma));
cxyz = round([Soma_Center(1:2) Soma_Center(3)*(Reso(3)/Reso(1))]);
Voronoi_Area = ...
    Voronoi_Segment == Voronoi_Segment(cxyz(2),cxyz(1),cxyz(3));
clear s Idx Len Center L dummy Idx L Voronoi_Segment cxyz
Voronoi_Area = TS_imresize3d(Voronoi_Area,size(Im));

output.Voronoi_ROI = Voronoi_Area;
% Extraction soma


%% areaopne�A�����߁A�ő�ʐς̂��̂��擾
NRIm = bwareaopen(NRIm,round(2000/3));%% ??????
NRIm2 = NRIm;
NRIm2(~Voronoi_Area) = 0;
NRIm2 = max(NRIm2,[],3);
NRIm2 = imfill(NRIm2,'holes');
NRIm2 = bwlabeln(NRIm2,8);
NRIm2 = NRIm2 == mode(NRIm2(NRIm2>0));

output.ProcessArea_2D = NRIm2;


%% TS program --> MN
ct = round(Soma_Center);
Vol = and(BW_soma,Voronoi_Area);
Vol = sum(Vol(:)) * prod(Reso);
SIm = Im_soma;
SIm(~Voronoi_Area) = 0;

output.Soma_Volume = Vol;

%% Nitta Program ???
% % % SE = strel('disk',3);
% % % Ims2 = medfilt3(Ims,[3 3 3]);
% % % Ims2 = imclose(Ims2,SE);
% % % Ims2 = smooth3(Ims2);
% % % 
% % % bg = MN_mode(Ims2(:),100);
% % % sg = max(Ims2(:));
% % % ths = bg+(sg-bg)*0.2;
% % % SIm = Ims2 >= ths;
% % % SIm = bwareaopen(SIm,round(2000/ex));
% % % 
% % % % ���ڍזE�̑I��
% % % NRIm = bwlabeln(NRIm,26);
% % % NRIm = NRIm == mode(NRIm(NRIm>0));
% % % [x,y,z] = MN_find3(NRIm);
% % % ctn = round([mean(x),mean(y),mean(z)]);
% % % NRdist = zeros(size(SIm));
% % % NRdist(ctn(1),ctn(2),ctn(3)) = 1;
% % % NRdist = bwdist(NRdist);
% % % LSIm = bwlabeln(SIm,26);
% % % NRSdist = single(NRdist) .* single(SIm);
% % % [y,x,z] = MN_find3(NRSdist==min(NRSdist(NRSdist>0)));
% % % SIm = LSIm == LSIm(round(mean(y)),round(mean(x)),round(mean(z)));
% % % %     LSIm1 = LSIm;
% % % %     LSIm1(LSIm1==0) = [];
% % % %     SIm = LSIm == mode(LSIm1);
% % % %     clear LSIm LSIm1
% % % [x,y,z] = MN_find3(SIm);
% % % ct = [mean(x),mean(y),mean(z)];
% % % ct = round(ct);
% % % 
% % % % % Volume
% % % Vol = sum(SIm(:))*Reso(1)^2*ss;
% % % 
% % % 
% % % % MN_3DIm(SIm)
% % % % daspect([1,1,1/3])
% % % % xlim([ct(2)-40 ct(2)+40])
% % % % ylim([ct(1)-40 ct(1)+40])
% % % % zlim([ct(3)-20 ct(3)+20])
% % % %     saveas(gcf,[tit,'�זE��3D'],'tif')
% % % %     saveas(gcf,[tit,'�זE��3D'],'fig')
% % % %     close
% % % %     clear NRIm 

%% 
base = zeros(size(Tmip));
base(ct(1),ct(2)) = 1;
base = bwdist(base);
RangeTmip = Tmip .* NRIm2;
%  %% Eucrid distance from Center of Soma
Thindist = base .* single(RangeTmip);   
%     clear base
% % 
MaxPlen = max(Thindist(:));

output.Skeleton2D_dist = Thindist;
    
%% Sholl���͗l�q    
%% �{������
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
ring = Thindist>=n*1/Reso(1)&Thindist<n*1/Reso(1)+1;%8.33��2��m������pixel�T�C�Y,1.74�̓��[�g3�𒴂���l 
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
L_Area = L.*single(NRIm2);

Theta = linspace(0,pi,Segment_Num+1);
Theta(end) = [];
Each_Area = zeros(Segment_Num,1);
Each_Length = Each_Area;
% Each_Density = Each_Area;
for n = 1:Segment_Num
    Each_Area(n) = sum(L_Area(:) == n)* Reso(1)^2;
    Each_Length(n) = sum(L_Len(:)==n) * Reso(1);
end
Each_Density = Each_Length ./Each_Area ;

% figure,plot(Theta,Each_Area),
% hold on
% plot(Theta,Each_Length)
% plot(Theta,Each_Density)
output.SegmentAnalysis.Label = uint8(L);
output.SegmentAnalysis.Label_Skeleton2D = L_Len;
output.SegmentAnalysis.Label_ProcessArea = L_Area;
output.SegmentAnalysis.Theta = Theta;
output.SegmentAnalysis.Each_Area = Each_Area;
output.SegmentAnalysis.Each_Length = Each_Length;
output.SegmentAnalysis.Each_Density = Each_Density;
output.SegmentAnalysis.Units = 'rad. and um';

%% Toc
toc
%%
%     %�d�S�Əd�S�����ԉ����_�����ƂȂ�悤�ɉ�]
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
%     Zx = x - round(size(out,2)/2);%��΍��W�ɕϊ� 
%     Zy = - (y - round(size(out,2)/2));
% %     Zx = (y-(rl(1)-1)*0.5-1);%��΍��W�ɕϊ� 
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
% %�̈�W����    
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
%     saveas(gcf,[tit,'�זE�̒f��'],'tif')
%     saveas(gcf,[tit,'�זE�̒f��'],'fig')
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
%     saveas(gcf,[tit,'�̈�'],'tif')
%     saveas(gcf,[tit,'�̈�'],'fig')
%     close
%     figure,imshow(fin2 + 1),axis image off,colormap(map)
%     saveas(gcf,[tit,'�א���'],'tif')
%     saveas(gcf,[tit,'�א���'],'fig')
%     close
%     save([tit,'ConRes'],'result','P_num','P_numM','ThinIm','fin','fin2','SIm','FIm2','Vol','Area','lp','MaxRVal','MaxPlen')
%     clear result
% % end



% % % % % function [P_num,result,vcon,ths,thn,thre] = MN_culcharafixth160626(Im,Ims,tit,N,ss)
% % % % ss = 0.6;
% % % % ex = ss/0.2;%ss�̓X�e�b�v�T�C�Y,���Xss0.2�ʂ��ŏ�������I�u�W�F�N�g�̃T�C�Y�Ȃǂ����߂Ă�������0.2��
% % % % Reso(1) = 0.2;
% % % %    
% % % %     %�ˋN��l�����א���
% % % %     para1 = 24; % �Ւfs
% % % %     para2 = 12; % �ʉ�
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
% % % %     ThinIm = TS_bwmorph3d(FIm2,'thin');%v8�ւ̕ύX������
% % % %     ThinIm = bwlabeln(ThinIm,26);
% % % %     ThinIm = ThinIm == mode(ThinIm(ThinIm>0));
% % % %     clear thin10 thin2 thin FIm
% % % %     Tmip = max(ThinIm,[],3);
% % % %     %�ˋN�̈撊�o
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
% % % %     % ���̃I�u�W�F�N�g����
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
% % % %     %�זE�̏d�S
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
% % % %     %���ڍזE�̑I��
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
% % % %     saveas(gcf,[tit,'�זE��3D'],'tif')
% % % %     saveas(gcf,[tit,'�זE��3D'],'fig')
% % % %     close
% % % %     clear NRIm 
% % % %     base = zeros(size(Tmip));
% % % %     base(ct(1),ct(2)) = 1;
% % % %     base = bwdist(base);
% % % %     RangeTmip = Tmip .* NRIm2;
% % % %     Thindist = base .* single(RangeTmip);   
% % % %     clear base
% % % %     MaxPlen = max(Thindist(:));
% % % %     %% �{������
% % % % Cir = base;
% % % % % Sholl���͗l�q
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
% % % % ring = Thindist>=n*1/Reso(1)&Thindist<n*1/Reso(1)+1;%8.33��2��m������pixel�T�C�Y,1.74�̓��[�g3�𒴂���l 
% % % % ringlbl = bwlabel(ring,8);
% % % % P_num(1,m) = n; 
% % % % % ProsNum(2,n) = max(kyulbl(:));
% % % % P_num(2,m) = max(ringlbl(:));
% % % % clear ring ringlbl
% % % % m = m+1;
% % % % end
% % % % P_numM = [P_num(2,6) P_num(2,9) P_num(2,18)];
% % % % %%
% % % %     %�d�S�Əd�S�����ԉ����_�����ƂȂ�悤�ɉ�]
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
% % % %     Zx = x - round(size(out,2)/2);%��΍��W�ɕϊ� 
% % % %     Zy = - (y - round(size(out,2)/2));
% % % % %     Zx = (y-(rl(1)-1)*0.5-1);%��΍��W�ɕϊ� 
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
% % % % %�̈�W����    
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
% % % %     saveas(gcf,[tit,'�זE�̒f��'],'tif')
% % % %     saveas(gcf,[tit,'�זE�̒f��'],'fig')
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
% % % %     saveas(gcf,[tit,'�̈�'],'tif')
% % % %     saveas(gcf,[tit,'�̈�'],'fig')
% % % %     close
% % % %     figure,imshow(fin2 + 1),axis image off,colormap(map)
% % % %     saveas(gcf,[tit,'�א���'],'tif')
% % % %     saveas(gcf,[tit,'�א���'],'fig')
% % % %     close
% % % %     save([tit,'ConRes'],'result','P_num','P_numM','ThinIm','fin','fin2','SIm','FIm2','Vol','Area','lp','MaxRVal','MaxPlen')
% % % %     clear result
% % % % % end
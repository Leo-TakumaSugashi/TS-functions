
%% make data by seg2array
seg = SEG.Pointdata;

yx = [];
yz = [];
yxz = [];
for n = 1:1%size(seg,1)
   for m = 1:size(seg(n).PointXYZ,1)
    p = seg(n).PointXYZ(m,:);
       yx(m,:) = [p(2),p(1)];
       yz(m,:) = [p(2),p(3)];
       yxz(m,:) = [p(1),p(2),p(3)];
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SEG = Base_SEG_v2_d;
%%%%%%%%%%%%%%%%%%%%%%%%
%% 

imsize = [256 256 128];


seg = SEG.Pointdata;

% %% Original Ver
% tic
% Data = struct('yxz',[],'s',[],'io',[]);
% Skel = zeros(imsize);
% figure,
% hold on
% for n = 1:size(seg,2)
% yx = [];
% yz = [];
% yxz = [];
%    for m = 1:size(seg(n).PointXYZ,1)
%     p = seg(n).PointXYZ(m,:);
%        yx(m,:) = [p(2),p(1)];
%        yz(m,:) = [p(2),p(3)];
%        yxz(m,:) = [p(2),p(1),p(3)];
%    end
%    Data(n).yxz = yxz;
%    siz = size(yxz,1);
%    try
%    Data(n).io = 1;
%    [S_test] = HS_B_Spline(yxz,10,siz);
%    catch
%    Data(n).io = 0;
%    [S_test] = yxz;
%    end
%    Data(n).s = S_test;
%    for l = 1:size(yxz,1)
%    Skel(yxz(l,1),yxz(l,2),yxz(l,3)) = 1;
%    end
%    plot3(S_test(:,1),S_test(:,2),S_test(:,3));
%    FFT = fft(S_test);
%    Data(n).fft_a = FFT;
%    FFT = fft(yxz);
%    Data(n).fft_b = FFT;
% end
% toc
% 
% Skel_A = logical(Skel);
% Skel_B = HS_SEG2Skel(seg,imsize);
% Deff = logical(Skel_A) - logical(Skel_B);
% ev = [min(Deff(:)),max(Deff(:))];
% if and(ev(1)==0,ev(2)==0)
% disp('success !')
% end
% % TS_3dslider(Skel_A),colormap('jet')
% % Edge = edge(BW);
% 
% tic
% figure,
% hold on
% for n = 1:size(seg,2)
%    S_test = Data(n).s;
%    plot3(S_test(:,1),S_test(:,2),S_test(:,3));
% end
% toc


%% Saving Branch Point XYZ Ver

tic
Data = struct('yxz',[],'s',[],'io',[]);
Skel = zeros(imsize);
figure,
hold on
for n = 1:size(seg,2)
yx = [];
yz = [];
yxz = [];
   for m = 1:size(seg(n).PointXYZ,1)
    p = seg(n).PointXYZ(m,:);
       yx(m,:) = [p(2),p(1)];
       yz(m,:) = [p(2),p(3)];
       yxz(m,:) = [p(2),p(1),p(3)];
   end
   Data(n).yxz = yxz;
   siz = size(yxz,1);
   try
   Data(n).io = 1;
   [S_test] = HS_B_Spline(yxz,5,siz/3);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   [S_test] = HS_B_Spline(S_test,5,siz*2);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
%    S_test(1,:) = yxz(1,:);
%    S_test(end,:) = yxz(end,:);
   
   catch
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% small segment???
   Data(n).io = 0;
%    [S_test] = yxz;
   [S_test] = HS_B_Spline(yxz,0,siz/3,[],'Bezier');
   [S_test] = HS_B_Spline(S_test,0,siz*2,[],'Bezier');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   end
   Data(n).s = S_test;
   for l = 1:size(S_test,1)
   Skel(round(S_test(l,1)),round(S_test(l,2)),round(S_test(l,3))) = 1;
   end

   plot3(S_test(:,1),S_test(:,2),S_test(:,3));
   FFT = fft(S_test);
   Data(n).fft_a = FFT;
   FFT = fft(yxz);
   Data(n).fft_b = FFT;
end
toc

Skel_A = logical(Skel);
Skel_B = HS_SEG2Skel(seg,imsize);
Deff = logical(Skel_A) - logical(Skel_B);
ev = [min(Deff(:)),max(Deff(:))];
if and(ev(1)==0,ev(2)==0)
disp('success !')
end


tic
figure,
hold on
for n = 1:size(seg,2)
   S_test = Data(n).s;
   plot3(S_test(:,1),S_test(:,2),S_test(:,3),'r');
end
toc

% before b-spline
tic
% figure,
hold on
for n = 1:size(seg,2)
   S_test = Data(n).yxz;
   plot3(S_test(:,1),S_test(:,2),S_test(:,3),'b');
end
toc


Skel1 = zeros(imsize);
Skel2 = zeros(imsize);
figure,
hold on
for n = 1:size(seg,2)
   S_test = Data(n).s;
   for i = 1:size(S_test,1)
   Skel1(round(S_test(i,1)),round(S_test(i,2)),round(S_test(i,3))) = 1;
   end
end
toc

tic
% figure,
hold on
for n = 1:size(seg,2)
   S_test = Data(n).yxz;
   for i = 1:size(S_test,1)
   Skel2(round(S_test(i,1)),round(S_test(i,2)),round(S_test(i,3))) = 1;
   end
end
toc
figure,pointview(logical(Skel1))
pointview(logical(Skel2))

TS_3dslider(cat(5,base_vessel,Skel1))

TS_3dslider(cat(5,base_vessel,Skel2))


BSEG = SEG;
BSEG.Pointdata = [];
for i = 1:size(Data,2)
BSEG.Pointdata(i).PointXYZ = [Data(i).s(:,2),Data(i).s(:,1),Data(i).s(:,3)];
BSEG.Pointdata(i).Type = SEG.Pointdata(i).Type;
BSEG.Pointdata(i).Length = SEG.Pointdata(i).Length;
BSEG.Pointdata(i).Branch = SEG.Pointdata(i).Branch;
end

BSEG = HS_add_vector2SEG(BSEG,[1,1,1.58]);
%SEG = HS_add_vector2SEG(SEG,[1,1,1.58]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 
% 
% %% 
% 
% 
% 
% [S_test] = HS_B_Spline(yxz,5,100);
% 
% figure,plot3(S_test(:,1),S_test(:,2),S_test(:,3));
% hold on
% scatter3(S_test(:,1),S_test(:,2),S_test(:,3))
% plot3(yxz(:,1),yxz(:,2),yxz(:,3));
% 
% 
% [S_test] = HS_B_Spline(S_test,5,50);
% plot3(S_test(:,1),S_test(:,2),S_test(:,3)), hold off
% 
% 
% [S_yx] = HS_B_Spline(yx,5,100);
% figure,
% plot(S_yx(:,1),S_yx(:,2))
% hold on 
% plot(yx(:,1),yx(:,2))
% 
% 
% [S_yz] = HS_B_Spline(yz,5,100);
% figure,
% plot(S_yz(:,1),S_yz(:,2))
% hold on 
% plot(yz(:,1),yz(:,2))
% 
% S_yxz = [S_yx,S_yz(:,2)];
% 
% 
% figure,
% plot3(S_yxz(:,1),S_yxz(:,2),S_yxz(:,3))
% hold on
% plot3(yxz(:,1),yxz(:,2),yxz(:,3))
% 
% 
% 
% 
% %% Make Data
% tic
% Data = struct('yxz',[]);
% figure,
% hold on
% for n = 1:size(seg,2)
% yx = [];
% yz = [];
% yxz = [];
%    for m = 1:size(seg(n).PointXYZ,1)
%     p = seg(n).PointXYZ(m,:);
%        yx(m,:) = [p(2),p(1)];
%        yz(m,:) = [p(2),p(3)];
%        yxz(m,:) = [p(1),p(2),p(3)];
%    end
%    Data(n).yxz = yxz;
%    siz = size(yxz,1);
%    try
%    [S_test] = HS_B_Spline(yxz,10,siz*3);
%    catch
%    [S_test] = yxz;
%    end
%    
%    plot3(S_test(:,1),S_test(:,2),S_test(:,3));
% end
% toc
% 
% tic
% Data = struct('yxz',[]);
% figure,
% hold on
% for n = 1:size(seg,2)
% yx = [];
% yz = [];
% yxz = [];
%    for m = 1:size(seg(n).PointXYZ,1)
%     p = seg(n).PointXYZ(m,:);
%        yx(m,:) = [p(2),p(1)];
%        yz(m,:) = [p(2),p(3)];
%        yxz(m,:) = [p(1),p(2),p(3)];
%    end
%    [S_test] = yxz;
%    plot3(S_test(:,1),S_test(:,2),S_test(:,3));
% end
% toc
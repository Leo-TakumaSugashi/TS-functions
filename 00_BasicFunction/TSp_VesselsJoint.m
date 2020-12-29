%% Help
% １．径の概略計算(bwdist)による，セグメントの方法を考察中．．．'16.06.17
% ２．BranchPointとJointによるセグメントの立案'16.07.07
% ３．１．２．のfunciont化--->TSp_VesselsJoint/Takuma Sugashi's program
% bw・・・二値化イメージ
% Thin・・・細線化イメージ
% ※OutDataはBallsize分ｘｙｚに大きくなるように開発初期に決めているため，
% 　カットが必要

% % load('E:\Sugashi\2016_06June\20160617\testimage_K27day00_Median7x7.mat')
% % Image = imresize(Image,[512 512]);
% % figure,imagesc(Image);
% % axis image
% % colormap(gray)
% % 
% % %% Only Bold Blood Vessels
% % Th_Len = 10;% ??umで閾値設定のフィルターを作成
% % Reso = 455.88/255;
% % Len = round(10/Reso); % Th_Len um以上の径を対象とするフィルター
% % h = fspecial('gaussian',Len*5,Len);
% % % figure,surf(h) %フィルターの確認
% % mImage = imfilter(Image,h);
% % 
% % figure,imagesc(mImage),axis image,colormap(gray) % フィルターImageの確認
% % 
% % bw = mImage > max(mImage(:))*0.5;
% % figure,imagesc(bw),colormap(gray),axis image

%% Set Up Data
bw = TestBW;  % xyzに均等な解像度で！！
Thin = TestThin; %　Thin = skelton3D(bw)などでも可．細線化データでよい．
Reso = [455.88/255 455.88/255 805/161]; % um/Pixels

%% 大まかな径情報の取得
Diam_1st = double(Thin) .* bwdist(~bw);

%% Set up Out data for 3D remodeling
% % % Maximum = max(Diam_1st(:));
% % % siz = uint32(2*round(Maximum) + 1);
% % % if ismatrix(bw)
% % %     OutData = zeros([uint32(size(bw))+siz siz]);
% % % elseif  ndims(bw) == 3
% % %     OutData = zeros(uint32(size(bw))+siz);
% % % else
% % %     error('Dimenssion should be 2 or 3')
% % % end
% % % 
% % % %% （中心に１を置き，Bwdistにてballの二値データを作成→置き換える）
% % % BallBox = zeros(siz,siz,siz);
% % % Center = uint16(round(Maximum));
% % % BallBox(Center,Center,Center) = 1;
% % % BallBox = bwdist(logical(BallBox));
% % % 
% % % % main　function
% % % [y,x,z] = ind2sub(size(bw),find(Thin(:)));
% % % tic
% % % for n = 1:length(y)
% % %     Th = Diam_1st(y(n),x(n),z(n));
% % % %     Ball = BallBox.*(~(BallBox>Th)); % BallBox take a value 0 to Maximum in the range Th.
% % %     Ball = double(BallBox<=Th)*Th;
% % %     OutData(y(n):y(n)+siz-1,x(n):x(n)+siz-1,z(n):z(n)+siz-1) = ...
% % %         max(cat(4,OutData(y(n):y(n)+siz-1,x(n):x(n)+siz-1,z(n):z(n)+siz-1),Ball),[],4);
% % % end
% % % t = toc;
% % % disp('Time of Crealting OutData is...')
% % % disp(['      ' num2str(t) 'sec. (Numel=' num2str(sum(Thin(:))) ')'])
% % % clear x y z n Th Ball Center Ball Box t 

%% セグメントの考案（Branch Point and Joint!!)　　16.07.07
se = ones(3,3,3);
BP = imfilter(double(Thin),se);
BP = and(Thin,BP>3); % Output Branch Point 
disp(['Number of branch point is expected less than ' num2str(sum(BP(:))) ' points.'])

%% set up JointData
Maximum = max(Diam_1st(:));
siz = uint32(2*round(Maximum) + 1);
if ismatrix(bw)
    JointData = zeros([uint32(size(bw))+siz siz]);
elseif  ndims(bw) == 3
    JointData = zeros(uint32(size(bw))+siz);
else
    error('Dimenssion should be 2 or 3')
end

% % （中心に１を置き，Bwdistにてballの二値データを作成→置き換える）
BallBox = zeros(siz,siz,siz);
Center = uint16(round(Maximum));
BallBox(Center,Center,Center) = 1;
BallBox = bwdist(logical(BallBox));

%% Joint main　function
[y,x,z] = ind2sub(size(BP),find(BP(:)));
for n = 1:length(y)
    Th = Diam_1st(y(n),x(n),z(n));
%     Ball = BallBox.*(~(BallBox>Th)); % BallBox take a value 0 to Maximum in the range Th.
    Ball = double(BallBox<=Th)*Th;
    JointData(y(n):y(n)+siz-1,x(n):x(n)+siz-1,z(n):z(n)+siz-1) = ...
        max(cat(4,JointData(y(n):y(n)+siz-1,x(n):x(n)+siz-1,z(n):z(n)+siz-1),Ball),[],4);
%     disp(num2str(n))
end
clear x y z n Th Ball Center Ball Box

%% Labeling of Joint Point
% at 1st, Labeling of Joint Data(for 2D data)
JointImage = JointData(siz/2-1:size(JointData,1)-siz/2-1,...
    siz/2-1:size(JointData,2)-siz/2-1,siz/2-1:size(JointData,3)-siz/2-1);
% % Joint ImgaeのMinimum（0以上）から精査
Counter = 0;
LabelData = zeros(size(JointImage));
while ~isempty(min(JointImage(JointImage>0)))
    Minimum = min(JointImage(JointImage>0));
    [L,num] = bwlabeln(JointImage==Minimum,26);
    L(L>0) = L(L>0) + Counter; %カウンター分ラベル部分を加算
    LabelData = LabelData + L; %ラベルの追加
    Counter = Counter + num;  % カウンターの加算
    JointImage(JointImage<=Minimum) = 0;
end
% % [LabelData,Counter] = New_bwlabeln(JointImage,26);

%% 2nd, LabelData and BP　のラベルのみを残す
JointLabelData_BP = LabelData .* BP;
JointPoint = zeros(size(JointImage));
JointArea =  zeros(size(JointImage));
Counter_2 = 0;
for n = 1:max(LabelData(:))
    bw_BP_LabelData = BP .* LabelData == n;
   
    if max(bw_BP_LabelData(:))==1
        Counter_2 = Counter_2 + 1;
        JointPoint = JointPoint + double(bw_BP_LabelData) .* Counter_2;
        JointArea = JointArea + double(LabelData==n) .* Counter_2;
    end
end
% % 結果の確かめ
figure,
fv_JointArea = isosurface(uint8(JointArea>0),.5,JointArea);
ph_JointArea = patch(fv_JointArea,'edgeColor','none','faceColor','interp');

colormap(jet)
colorbar
view(3)
daspect([1 1 1])
% hold on 
% [y,x,z] = ind2sub(size(Thin),find(Thin(:)));
% plh = plot3(x,y,z,'.w','MarkerSize',3);
% NewlabelingData の数字打ち込み
% Centroid = regionprops(JointArea,'Centroid');
% XY = cat(1,Centroid.Centroid);
% for n = 1:size(XY,1)
%     txh(n) = text(XY(n,1),XY(n,2)-25,num2str(n),...
%         'FontSize',10,...
%         'BackGroundColor','w');
% end
    

% 
% [y,x] = find(BP);
% for n = 1:length(y)
    
    
    
    
    





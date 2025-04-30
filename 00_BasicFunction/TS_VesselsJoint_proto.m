function JointArea = TS_VesselsJoint_proto(bw,Thin)
%% Help
%  (Labeling of Joint Area) = TS_VesselsJoint_proto(bw)
% BranchPointとJointによるセグメントの立案'16.07.07
%  上記funciont化--->TSp_VesselsJoint/Takuma Sugashi's program
% bw・・・二値化イメージ
% Thinning Function is Skeleton3D
% 
% 
% load('E:\Sugashi\skeleton3d\testvol.mat')
% tic
% JointArea = TS_VesselsJoint_proto(testvol,Skeleton3D(bw));
% toc
% figure,
% fv_JointArea = isosurface(uint8(JointArea>0),.5,JointArea);
% fvc_JointArea = isocaps(uint8(JointArea>0),.5);
% ph_JointArea = patch(fv_JointArea,'edgeColor','none','faceColor','interp');
% phc_JointArea = patch(fvc_JointArea,'edgeColor','none','faceColor',[.8 .8 .8]);
% colormap(jet)
% colorbar
% view(3)
% daspect([1 1 1])
% toc

%% Set Up Data
% bw = TestBW;  % xyzに均等な解像度で！！
% Thin = Skeleton3D(bw); %　Thin = skelton3D(bw)などでも可．細線化データでよい．
% Reso = [455.88/255 455.88/255 805/161]; % um/Pixels

%% 大まかな径情報の取得
Diam_1st = double(Thin) .* bwdist(~bw);

%% セグメントの考案（Branch Point and Joint!!)　　16.07.07
se = ones(3,3,3);
BP = imfilter(uint8(Thin),se);
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
BallBox = zeros(siz,siz,siz);siz
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
% JointLabelData_BP = LabelData .* BP;
% JointPoint = zeros(size(JointImage));
JointArea =  zeros(size(JointImage));
Counter_2 = 0;
for n = 1:max(LabelData(:))
    bw_BP_LabelData = BP .* LabelData == n;
   
    if max(bw_BP_LabelData(:))==1
        Counter_2 = Counter_2 + 1;
%         JointPoint = JointPoint + double(bw_BP_LabelData) .* Counter_2;
        JointArea = JointArea + double(LabelData==n) .* Counter_2;
    end
end




function WholeImage = TS_Margin_MG48_Resize(Rloc1,Rloc2,Rloc3,Rloc4)
% siz =
%          515         551        1133
%          511         516        1125
%          514         513        1109
%          512         512        1149

if max(strcmpi('logical',{class(Rloc1);class(Rloc2);class(Rloc3);class(Rloc4)}))
for n = 1:4
 eval(['Rloc' num2str(n) ' = uint8(Rloc' num2str(n) ');'])
end
end


%% Loc2 & Loc1
[Image1,Image2] = TS_PaddingImage1and2(Rloc1,Rloc2);

DepthAdj = 23;
Image1 = Image1(:,:,1:end-DepthAdj,:,:);
Image2 = Image2(:,:,DepthAdj+1:end,:,:);

shift = [5 -453];
shift = repmat(shift,[size(Image1,3) 1]);
[a,b] = TS_Shift2pad_vEachSlice(Image1,Image2,shift);
a = single(a);
a(a==0) = nan;
b = single(b);
b(b==0) = nan;
Image21 = nanmax(cat(6,a,b),[],6);
Image21 = feval(class(Image1),Image21);
% xyztviewer2016_proto(Image21)

%% Loc 3 & 4
[Image1,Image2] = TS_PaddingImage1and2(Rloc3,Rloc4);
% TS_DepthAdjGUI(Image1(:,:,:,:,1),Image2(:,:,:,:,1))
Image1 = padarray(Image1,[0 450],0,'post');
Image2 = padarray(Image2,[0 450],0,'pre');

Image1 = padarray(Image1,[0 0 49],0,'post');
Image2 = padarray(Image2,[0 0 49],0,'pre');

% Slice = 285;
% Base = cat(4,a(:,:,Slice,:,1)*5,b(:,:,Slice,:,1));
% xyRePosit_v2016(Base)


shift = [-8 45]; % [-10 50]
shift = repmat(shift,[size(Image1,3) 1]);
[a,b] = TS_Shift2pad_vEachSlice(Image1,Image2,shift);
% [a,b] = TS_Shift2pad_vEachSlice(Image1(:,:,969),Image2(:,:,969),shift);
% figure('posi',[10 10 1000 800]),imagesc(max(cat(4,a,b),[],4))
a = single(a);
a(a==0) = nan;
b = single(b);
b(b==0) = nan;
Image34 = nanmax(cat(6,a,b),[],6);
Image34 = feval(class(Image1),Image34);
clear a b shift Image1 Image2

%% Location All
Image34(:,:,end-40:end) = [];
Image34(:,:,1:57) = [];

[Image1,Image2] = TS_PaddingImage1and2(Image34,Image21);
% TS_DepthAdjGUI(GetCh(Image1,1),GetCh(Image2,1))
Image1 = padarray(Image1,[0 0 4],0,'post');
Image2 = padarray(Image2,[0 0 4],0,'pre');

%% manual adjust 
% for n = 400:800
% shift = [508  0]; z1 = 1051 - n; z2 = 1055 - n;
% [a,b] = TS_Shift2pad_vEachSlice(Image1(:,:,z1),Image2(:,:,z2),shift);
% % figure('posi',[10 10 1200 800]),imagesc(rgbproj_old(cat(3,a,b),'auto')),axis image
% imh.CData = (rgbproj_old(cat(3,a,b),'auto'));
% drawnow, 
% end
%%


shift = [508 0];
shift = repmat(shift,[size(Image1,3) 1]);
[a,b] = TS_Shift2pad_vEachSlice(Image1,Image2,shift);
% xyztviewer2016_proto(cat(5,a,b))


WholeImage = max(cat(4,a,b),[],4);
% idx_a = max(max(max(a,[],5),[],3)>0,[],2);
% idx_b = max(max(max(b,[],5),[],3)>0,[],2);
% idx = and(idx_a,idx_b);
% a = single(a(idx,:,:));
% b = single(b(idx,:,:));
% a(a==0) = nan; 
% b(b==0) = nan;
% WholeImage(idx,:,:) = feval(...
%     class(WholeImage),...
%     nanmean(cat(4,a,b),4));


load MarginCutData_MG48_Resize idx
% idx = max(max(WholeImage,[],3),[],2)==0; 
WholeImage(idx,:,:,:,:) = [];


WholeImage(:,:,1:13,:,:) = [];

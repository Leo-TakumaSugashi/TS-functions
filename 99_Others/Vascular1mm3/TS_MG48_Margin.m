function WholeImage = TS_Margin_MG48(Loc1,Loc2,Loc3,Loc4)
% WholeImage = TS_Margin_MG48(Loc1,Loc2,Loc3,Loc4)
% 
% Position Informatino
%  3 4 
%  2 1
% % % % % edit by sugashi , 2017/2/28
if and(...
        and(islogical(Loc1),islogical(Loc2)),...
        and(islogical(Loc3),islogical(Loc4)))
    Loc1 = uint8(Loc1);
    Loc2 = uint8(Loc2);
    Loc3 = uint8(Loc3);
    Loc4 = uint8(Loc4);
    warning('Input data is LCGICAL , so class was checnged to uint8')
end


%% Loc2 & Loc1
[Image1,Image2] = TS_PaddingImage1and2(Loc1,Loc2);
clear Loc1 Loc2
DepthAdj = 5;
Image1 = Image1(:,:,1:end-DepthAdj,:,:);
Image2 = Image2(:,:,DepthAdj+1:end,:,:);

shift = [10 -905];
shift = repmat(shift,[size(Image1,3) 1]);
[a,b] = TS_Shift2pad_vEachSlice(Image1,Image2,shift);
a = single(a);
a(a==0) = nan;
b = single(b);
b(b==0) = nan;
Image21 = nanmean(cat(6,a,b),6);
% if ~islogical(Image1)
    Image21 = feval(class(Image1),Image21);
% else
%     Image21(isnan(Image21)) = 0;
%     Image21 = logical(Image21);
% end

% xyztviewer2016_proto(Image21)

%% Loc 3 & 4
[Image1,Image2] = TS_PaddingImage1and2(Loc3,Loc4);
clear Loc3 Loc4
% TS_DepthAdjGUI(Image1(:,:,:,:,1),Image2(:,:,:,:,1))
Image1 = padarray(Image1,[0 900],0,'post');
Image2 = padarray(Image2,[0 900],0,'pre');

Image1 = padarray(Image1,[0 0 14],0,'post');
Image2 = padarray(Image2,[0 0 14],0,'pre');

% Slice = 285;
% Base = cat(4,a(:,:,Slice,:,1)*5,b(:,:,Slice,:,1));
% xyRePosit_v2016(Base)


shift = [-20 100];
shift = repmat(shift,[size(Image1,3) 1]);
[a,b] = TS_Shift2pad_vEachSlice(Image1,Image2,shift);
a = single(a);
a(a==0) = nan;
b = single(b);
b(b==0) = nan;
Image34 = nanmean(cat(6,a,b),6);

% if ~islogical(Image1)
    Image34 = feval(class(Image1),Image34);
% else
%     Image34(isnan(Image34)) = 0;
%     Image34 = logical(Image34);
% end
clear a b shift Image1 Image2

%% Location All
[Image1,Image2] = TS_PaddingImage1and2(Image34,Image21);
clear Image34 Image21
% TS_DepthAdjGUI(GetCh(Image1,1),GetCh(Image2,1))
Image1 = padarray(Image1,[0 0 12],0,'pre');
Image2 = padarray(Image2,[0 0 12],0,'post');



shift = [1015 12];
shift = repmat(shift,[size(Image1,3) 1]);
[a,b] = TS_Shift2pad_vEachSlice(Image1,Image2,shift);
% xyztviewer2016_proto(cat(5,a,b))
idx_a = max(max(max(a,[],5),[],3)>0,[],2);
idx_b = max(max(max(b,[],5),[],3)>0,[],2);
idx = and(idx_a,idx_b);

WholeImage = max(cat(4,a,b),[],4);
a = single(a(idx,:,:));
b = single(b(idx,:,:));
% if ~islogical(WholeImage)
    a(a==0) = nan; 
    b(b==0) = nan;
% end
WholeImage(idx,:,:) = feval(...
    class(WholeImage),...
    nanmean(cat(4,a,b),4));
clear a b idx_a idx_b idx Image1 Image2 shift 

WholeImage(:,:,1:22,:,:) = [];

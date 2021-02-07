function output = TS_K27_Mergin_Reso04456(Loc1,Loc2,Loc3,Loc4)

%% Reposition Each by hand
% for n = 1:4
%     eval(['im' num2str(n) ' = data(n).NorImage_vG;'])
% end
%  each size
%  1024  1024   1804
%  1024  1024   1804
%  1024  1024   1804
%  1024  1024   1804

% Location info.
% 2 1
% 3 4

cbw1 = padarray(Loc1,[0 0 39],0,'post');clear Loc1
cbw2 = padarray(Loc2,[0 0 39],0,'post');clear Loc2
cbw3 = padarray(Loc3,[0 0 39],0,'post');clear Loc3
cbw4 = padarray(Loc4,[0 0 39],0,'post');clear Loc4


%% Loc 1 & 2
% % MIPn = 30;
% % x1 = squeeze(max(cbw2(:,end-MIPn:end,:),[],2));
% % x2 = squeeze(max(cbw1(:,1:MIPn,:),[],2));
% % sh12 = TS_SliceReposition(x1,x2)
% 1 & 2 -->  15 10
sh12 = [15 10];
% % figure,imagesc(rgbproj(cat(4,x1,x2)))

%% Shift
Z12 = abs(sh12(2));
if sh12(2)<0
    cbw1 = padarray(cbw1(:,:,Z12+1:end),[0 0 Z12],'post');
elseif sh12(2) >0
    cbw1 = padarray(cbw1(:,:,1:end-Z12),[0 0 Z12],'pre');
end

Y12 = abs(sh12(1));
if sh12(1)<0
    cbw1 = padarray(cbw1,[Y12 0 0],'post');
    cbw2 = padarray(cbw2,[Y12 0 0],'pre');
elseif sh12(1) >0
    cbw1 = padarray(cbw1,[Y12 0 0],'pre');
    cbw2 = padarray(cbw2,[Y12 0 0],'post');
end
% x1 = squeeze(max(cbw2(:,end-MIPn:end,:),[],2));
% x2 = squeeze(max(cbw1(:,1:MIPn,:),[],2));
% figure,imagesc(rgbproj(cat(4,x1,x2)))

%% Manual (1)
Shift12 = 1011;
% ind = round(linspace(1,size(cbw2,3),15));
% ind([1 end]) = [];
% X1 = padarray(cbw2(:,:,ind),[0 Shift12 0],'post');
% X2 = padarray(cbw1(:,:,ind),[0 Shift12 0],'pre');
% TS_3dslider(cat(5,X1,X2))

%% merge 2 1
X1 = padarray(cbw2,[0 Shift12 0],'post');
X2 = padarray(cbw1,[0 Shift12 0],'pre');
IM12 = max(X1,X2);
clear cbw1 cbw2 X1 X2

%% Loc 4 & 3
% MIPn = 2;
% x1 = squeeze(max(cbw3(:,end-MIPn:end,:),[],2));
% x2 = squeeze(max(cbw4(:,1:MIPn,:),[],2));
% sh34 = TS_SliceReposition(x1,x2)
% % 1 & 2 -->  14 0
% figure,imagesc(rgbproj(cat(4,x1,x2)))
sh34 = [14 0];

%% Shift
Z12 = abs(sh34(2));
if sh34(2)<0
    cbw4 = padarray(cbw4(:,:,Z12+1:end),[0 0 Z12],'post');
elseif sh34(2) >0
    cbw4 = padarray(cbw4(:,:,1:end-Z12),[0 0 Z12],'pre');
end

Y12 = abs(sh34(1));
if sh34(1)<0
    cbw4 = padarray(cbw4,[Y12 0 0],'post');
    cbw3 = padarray(cbw3,[Y12 0 0],'pre');
elseif sh34(1) >0
    cbw4 = padarray(cbw4,[Y12 0 0],'pre');
    cbw3 = padarray(cbw3,[Y12 0 0],'post');
end
% x1 = squeeze(max(cbw3(:,end-MIPn:end,:),[],2));
% x2 = squeeze(max(cbw4(:,1:MIPn,:),[],2));
% figure,imagesc(rgbproj(cat(4,x1,x2)))


%% Manual (2)
Shift34 = 1029;
% ind = round(linspace(1,size(cbw3,3),20));
% ind([1 end]) = [];
% 
% X1 = padarray(cbw3(:,:,ind),[0 Shift34 0],'post');
% X2 = padarray(cbw4(:,:,ind),[0 Shift34 0],'pre');
% TS_3dslider(cat(5,X1,X2))


%% %%%%%%%%%%%%%% Interp. %%%%%%%%%%%%%%%%%%%%%%
a = Shift34 - size(cbw3,2) + 4;
Vol = cat(2,cbw3(:,end-1:end,:),cbw4(:,1:2,:));
ydata = (1:size(Vol,1))';
xdata = [1 2 a-1 a];
zdata = reshape(1:size(Vol,3),1,1,[]);
[X,Y,Z] = meshgrid(xdata,ydata,zdata);
xv = 1:a;
[xv,Yv,Zv] = meshgrid(xv,ydata,zdata);
Vq = interp3(X,Y,Z,single(Vol),xv,Yv,Zv);
clear X Y Z xdata ydata zdata xv Yv Zv Vol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% interp check
% % size(X2(:,1025:1029,:))
% % size(Vq(:,3:end-2,ind))
% X2(:,size(cbw4,2)+1:size(cbw4,2)+5,:) = Vq(:,3:end-2,ind);
% TS_3dslider(cat(5,X1,X2))
%% 
X1 = padarray(cbw3,[0 Shift34 0],'post');
X2 = padarray(cbw4,[0 Shift34 0],'pre');
X2(:,size(cbw4,2)+1:size(cbw4,2)+5,:) = Vq(:,3:end-2,:);
IM43 = max(X1,X2);
clear X1 X2 cbw3 cbw4
%% vertical set up
Diffv = size(IM12,2) - size(IM43,2);
if Diffv > 0
    IM43 = padarray(IM43,[0 abs(Diffv) 0],'post');
elseif Diffv < 0
    IM12 = padarray(IM12,[0 abs(Diffv) 0],'post');
end

%% verticle
% MIPn = 20;
% x1 = squeeze(max(IM12(end-MIPn:end,:,:),[],1));
% x2 = squeeze(max(IM43(1:MIPn+1,:,:),[],1));
% shV = TS_SliceReposition(x1,x2);
% %  -10 3
% figure,imagesc(rgbproj(cat(4,x1,x2)))


shV = [-10 3];
%% Shift
Z1234 = abs(shV(2));
if shV(2)<0
    IM43 = padarray(IM43(:,:,Z1234+1:end),[0 0 Z1234],'post');
elseif shV(2) >0
    IM43 = padarray(IM43(:,:,1:end-Z1234),[0 0 Z1234],'pre');
end

Y1234 = abs(shV(1));
if shV(1)<0
    IM43 = padarray(IM43,[0 Y1234 0],'post');
    IM12 = padarray(IM12,[0 Y1234 0],'pre');
elseif shV(1) >0
    IM43 = padarray(IM43,[0 Y1234 0],'pre');
    IM12 = padarray(IM12,[0 Y1234 0],'post');
end
% % x1 = squeeze(max(IM12(end-MIPn:end,:,:),[],1));
% % x2 = squeeze(max(IM43(1:MIPn,:,:),[],1));
% % figure,imagesc(rgbproj(cat(4,x1,x2)))


%% manual (3)
Shift1234 = 1016;
Diffy = size(IM12,1) - size(IM43,1);

% 
% ind = round(linspace(1,size(IM12,3),20));
% ind([1 end]) = [];
% % 
% if Diffy >=0
%     X1 = padarray(IM12(:,:,ind),[Shift1234-Diffy  0  0],'post');
%     X2 = padarray(IM43(:,:,ind),[Shift1234  0  0],'pre');
% else
%     X1 = padarray(IM12(:,:,ind),[Shift1234+abs(Diffy)  0  0],'post');
%     X2 = padarray(IM43(:,:,ind),[Shift1234  0  0],'pre');
% end
% TS_3dslider(cat(5,X1,X2))

%% output
if Diffy >=0
    X1 = padarray(IM12,[Shift1234-Diffy  0  0],'post');
    X2 = padarray(IM43,[Shift1234  0  0],'pre');
else
    X1 = padarray(IM12,[Shift1234+abs(Diffy)  0  0],'post');
    X2 = padarray(IM43,[Shift1234  0  0],'pre');
end
output = max(X1,X2);
% clear X1 X2 IM12 IM43



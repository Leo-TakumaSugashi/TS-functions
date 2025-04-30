function output = TS_MG30_OriginalReposi(im1,im2,im3,im4)
%% Reposition Each by hand
% for n = 1:4
%     eval(['im' num2str(n) ' = data(n).NorImage_vG;'])
% end
%  each size
%  1024  1024   460
%  1024  1024   469
%  1024  1024   463
%  1024  1024   470
im2 = im2(:,:,10:end,:,:);
im3 = im3(:,:,4:end,:,:);
im4 = im4(:,:,11:end,:,:);
load(TS_ConvertOurNAS(['\\192.168.2.120\Share6\00_Sugashi\10_Since2016\20_Matlab'...
    '\12_Matlab_data\MG30_AllLocation\Making_1mm3_2nd\OriginalSizeShift']))
%% Loc 1 & 2
% MIPn = 20;
% x1 = squeeze(max(im1(:,end-MIPn:end,:),[],2));
% x2 = squeeze(max(im2(:,1:MIPn,:),[],2));
% sh = TS_SliceReposition(x1,x2)
% 1 & 2 -->  14    -7
im2 = padarray(im2(:,:,8:end,:,:),[0 0 7],0,'post');

% MIPn = 50;
% Shift = zeros(size(im1,3),2);
% for n = 1:size(im1,3)
%     x1 = squeeze(im1(:,end-MIPn:end,n));
%     x2 = squeeze(im2(:,1:MIPn+1,n));
%     sh = TS_SliceReposition(x1,x2);
%     Shift(n,:) = sh;clear sh x1 x2
% end
% 
% figure,plot(Shift)
% x = 150:400;
% f1 = polyfit(x',Shift(x,1),1)
% f2 = polyfit(x',Shift(x,2),1)
% hold on
% x = 1:size(im1,3);
% plot(polyval(f1,x),'k')
% plot(polyval(f2,x),'k')
% NewShift12 = cat(2,polyval(f1,x'),polyval(f2,x')+ 1024 - MIPn);

[IM1,IM2] = TS_Shift2pad_vEachSlice(im1,im2,NewShift12); % %  Thes Funct has Bag....
% save OriginalSizeShift NewShift12
IM12 = max(cat(4,IM1,IM2),[],4);

clear IM1 IM2

%% Loc 4 & 3
% MIPn = 50;
% x1 = squeeze(max(im4(:,end-MIPn:end,:),[],2));
% x2 = squeeze(max(im3(:,1:MIPn+1,:),[],2));
% sh = TS_SliceReposition(x1,x2)
%   0   -12
im3 = padarray(im3(:,:,13:end,:,:),[0 0 12],0,'post');
% 
% MIPn = 50;
% Shift = zeros(size(im1,3),2);
% for n = 1:size(im1,3)
%     x1 = squeeze(im4(:,end-MIPn:end,n));
%     x2 = squeeze(im3(:,1:MIPn+1,n));
%     sh = TS_SliceReposition(x1,x2);
%     Shift(n,:) = sh;clear sh x1 x2
% end
% figure,plot(Shift)
% x = 112:430;
% f1 = polyfit(x',Shift(x,1),1)
% f2 = polyfit(x',Shift(x,2),1)
% f2(1) = -11/298
% f2(2) = -13 + 11*103/298;
% hold on
% x = 1:size(im1,3);
% plot(polyval(f1,x),'k')
% plot(polyval(f2,x),'k')
% NewShift43 = cat(2,polyval(f1,x'),polyval(f2,x')+ 1024 - MIPn);
[IM4,IM3] = TS_Shift2pad_vEachSlice(im4,im3,NewShift43); 
% save OriginalSizeShift NewShift43 -append
IM43 = max(cat(4,IM4,IM3),[],4);
clear IM4 IM3

IM43 = padarray(IM43,[0 21 0],0,'pre');

%% verticle
% MIPn = 100;
% x1 = squeeze(max(IM12(end-MIPn:end,:,:),[],1));
% x2 = squeeze(max(IM43(1:MIPn+1,:,:),[],1));
% sh = TS_SliceReposition(x1,x2)
%  14     2
IM12 = padarray(IM12(:,:,3:end,:,:),[0 0 2],0,'post');
IM12 = padarray(IM12,[0 14 0],0,'post');
IM43 = padarray(IM43,[0 14 0],0,'pre');

% MIPn = 100;
% Shift = zeros(size(IM12,3),2);
% for n = 1:size(IM12,3)
%     x1 = squeeze(IM12(end-MIPn:end,:,n));
%     x2 = squeeze(IM43(1:MIPn+1,:,n));
%     sh = TS_SliceReposition(x1,x2);
%     Shift(n,:) = sh;clear sh x1 x2
% end
% figure,plot(Shift)
% x = 112:430;
% f1 = polyfit(x',Shift(x,1),1);
% hold on
% x = 1:size(IM12,3);
% plot(polyval(f1,x),'k')
% NewShift1243 = cat(2,polyval(f1,x')+ size(IM12,1) - MIPn,zeros(size(IM12,3),1));
% save OriginalSizeShift NewShift1243 -append
IM43 = padarray(IM43,[(size(IM12,1) - size(IM43,1)) 0 0],0,'post');
[IMtop,IMbottom] = TS_Shift2pad_vEachSlice(IM12,IM43,NewShift1243); 
output = max(cat(4,IMtop,IMbottom),[],4);
output(1994:end,:,:,:,:) = [];




%% Reposition Each by hand
% for n = 1:4
%     eval(['im' num2str(n) ' = data(n).NorImage_vG;'])
% end
%  each size
%  1024  1024   2310
%  1024  1024   2356
%  1024  1024   2325
%  1024  1024   2361
[cbw1,NewReso] = TS_EqualReso3d_2017(adj1,Reso,Reso(1));
cbw2 = TS_EqualReso3d_2017(adj2,Reso,Reso(1));
cbw3 = TS_EqualReso3d_2017(adj3,Reso,Reso(1));
cbw4 = TS_EqualReso3d_2017(adj4,Reso,Reso(1)); 


cbw1;
cbw2 = cbw2(:,:,47:end,:,:);
cbw3 = cbw3(:,:,16:end,:,:);
cbw4 = cbw4(:,:,52:end,:,:);
% load(TS_ConvertOurNAS(['\\192.168.2.120\Share6\00_Sugashi\10_Since2016\20_Matlab'...
%     '\12_Matlab_data\MG30_AllLocation\Making_1mm3_2nd\OriginalSizeShift']))
%% Loc 1 & 2
% MIPn = 20;
% x1 = squeeze(max(cbw1(:,end-MIPn:end,:),[],2));
% x2 = squeeze(max(cbw2(:,1:MIPn,:),[],2));
% figure,imagesc(rgbproj(cat(3,x1,x2)))
% sh = TS_SliceReposition(x1,x2)
% 1 & 2 -->  13   -38
sh = [8 -38];
%% Shift (paddarray)
Z = abs(sh(2));
if sh(2) <0
    cbw2 = padarray(cbw2(:,:,Z+1:end,:,:),[0 0 Z],0,'post');
elseif sh(2) >0
    cbw2 = padarray(cbw2(:,:,1:end-Z,:,:),[0 0 Z],0,'pre');
end

Y = abs(sh(1));
if sh(1) <0
    cbw1 = padarray(cbw1,[Y 0 0],0,'pre');
    cbw2 = padarray(cbw2,[Y 0 0],0,'post');
elseif sh(1) >0
    cbw1 = padarray(cbw1,[Y 0 0],0,'post');
    cbw2 = padarray(cbw2,[Y 0 0],0,'pre');
end

ReposiInfo.Shift_Loc12 = sh;
clear sh x1 x2 Z Y MIPn

% % check 
% x1 = squeeze(max(cbw1(:,end-MIPn:end,:),[],2));
% x2 = squeeze(max(cbw2(:,1:MIPn,:),[],2));
% figure,imagesc(rgbproj(cat(3,x1,x2)))

% size(cbw1)
% size(cbw2)

%% Manual (1)
Loc2_ShiftX = 978;
% ind = round(linspace(1,size(cbw1,3),10));
% X0 = padarray(cbw1(:,:,ind,1,1),[0 Loc2_ShiftX 0],0,'post');
% X1 = padarray(cbw2(:,:,ind,1,1),[0 Loc2_ShiftX 0],0,'pre');


% TS_3dslider(cat(5,X0,X1))
% TS_imline

%% check
X0 = padarray(cbw1,[0 Loc2_ShiftX 0],0,'post');
X1 = padarray(cbw2,[0 Loc2_ShiftX 0],0,'pre');
TS_3dslider(max(X0,X1))
%% memory clear 
cbw12 = max(X0,X1);
ReposiInfo.Loc2_ShiftX = Loc2_ShiftX;
clear X0 X1 cbw1 cbw2 Loc2_ShiftX
size(cbw12)

%% Loc 4 & 3
% MIPn = 50;
% x1 = squeeze(max(cbw4(:,end-MIPn:end,:),[],2));
% x2 = squeeze(max(cbw3(:,1:MIPn+1,:),[],2));
% sh34 = TS_SliceReposition(x1,x2)
% figure,imagesc(rgbproj(cat(3,x1,x2)))
sh34 = [0 -64];
%   1   -64
%% Shift (paddarray)
Z34 = abs(sh34(2));
if sh34(2) <0
    cbw3 = padarray(cbw3(:,:,Z34+1:end,:,:),[0 0 Z34],0,'post');
elseif sh34(2) >0
    cbw3 = padarray(cbw3(:,:,1:end-Z34,:,:),[0 0 Z34],0,'pre');
end

Y34 = abs(sh34(1));
if sh34(1) <0
    cbw4 = padarray(cbw4,[Y34 0 0],0,'pre');
    cbw3 = padarray(cbw3,[Y34 0 0],0,'post');
elseif sh34(1) >0
    cbw4 = padarray(cbw4,[Y34 0 0],0,'post');
    cbw3 = padarray(cbw3,[Y34 0 0],0,'pre');
end
ReposiInfo.Shift_Loc34 = sh34;
clear sh34 Z34 Y34
% % check 
% x1 = squeeze(max(cbw4(:,end-MIPn:end,:),[],2));
% x2 = squeeze(max(cbw3(:,1:MIPn,:),[],2));
% figure,imagesc(rgbproj(cat(3,x1,x2)))
% 
% size(cbw3)
% size(cbw4)

%% Manual (2)
Loc4_ShiftX = 955;
% ind = round(linspace(1,size(cbw4,3),10));
% X0 = padarray(cbw4(:,:,ind,1,1),[0 Loc4_ShiftX 0],0,'post');
% X1 = padarray(cbw3(:,:,ind,1,1),[0 Loc4_ShiftX 0],0,'pre');


% TS_3dslider(cat(5,X0,X1))
% set(gcf,'posi',[59         242        2578        1663])
% centerfig(gcf)

%% check
X0 = padarray(cbw4,[0 Loc4_ShiftX 0],0,'post');
X1 = padarray(cbw3,[0 Loc4_ShiftX 0],0,'pre');
% TS_3dslider(cat(5,X0,X1))
% set(gcf,'posi',[59         242        2578        1663])
% centerfig(gcf)

%% memory clear 
cbw43 = max(X0,X1);
ReposiInfo.Loc4_ShiftX = Loc4_ShiftX;
clear X0 X1 cbw4 cbw3 Loc4_ShiftX
size(cbw43)


%% Size fitt (padarray)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
size(cbw12,2)
size(cbw43,2)
PadSiz = size(cbw12,2) - size(cbw43,2);
pm = sign(PadSiz);
if pm >0
    cbw43 = padarray(cbw43,[0 abs(PadSiz) 0 ],0,'post');
elseif pm <0
    cbw12 = padarray(cbw12,[0 abs(PadSiz) 0 ],0,'post');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
size(cbw12)
size(cbw43)


%% verticle
% MIPn = 60;
% x1 = squeeze(max(cbw12(end-MIPn:end,:,:),[],1));
% x2 = squeeze(max(cbw43(1:MIPn+1,:,:),[],1));
% shV = TS_SliceReposition(x1,x2)
% figure,imagesc(rgbproj(cat(3,x1,x2)))
% set(gcf,'posi',[59  42 863 1578 ])
shV = [35 12];
%  36    7
%% vertical padding
Zv = abs(shV(2));
if shV(2) <0
    cbw43 = padarray(cbw43(:,:,Zv+1:end,:,:),[0 0 Zv],0,'post');
elseif shV(2) >0
    cbw43 = padarray(cbw43(:,:,1:end-Zv,:,:),[0 0 Zv],0,'pre');
end

Yv = abs(shV(1));
if shV(1) <0
    cbw12 = padarray(cbw12,[0 Yv 0],0,'pre');
    cbw43 = padarray(cbw43,[0 Yv 0],0,'post');
elseif shV(1) >0
    cbw12 = padarray(cbw12,[0 Yv 0],0,'post');
    cbw43 = padarray(cbw43,[0 Yv 0],0,'pre');
end

ReposiInfo.Shift_Vertical = shV;
clear shV x1 x2 Zv Yv

% % check 
% x1 = squeeze(max(cbw12(end-MIPn:end,:,:),[],1));
% x2 = squeeze(max(cbw43(1:MIPn,:,:),[],1));
% figure,imagesc(rgbproj(cat(3,x1,x2)))
% set(gcf,'posi',[59  42 863 1578 ])
% size(cbw12)
% size(cbw43)


%% Manual (3)
V_ShiftX = 957;
% diff_V = (size(cbw12,1) - size(cbw43,1))
% ind = round(linspace(1,size(cbw12,3),10));
% if diff_V>=0
%     X0 = padarray(cbw12(:,:,ind,1,1),[V_ShiftX-diff_V 0 0],0,'post');
%     X1 = padarray(cbw43(:,:,ind,1,1),[V_ShiftX        0 0],0,'pre');
% else    
%     X0 = padarray(cbw12(:,:,ind,1,1),[V_ShiftX        0 0],0,'post');
%     X1 = padarray(cbw43(:,:,ind,1,1),[V_ShiftX-diff_V 0 0],0,'pre');
% end
% 
% 
% TS_3dslider(max(X0,X1))
% set(gcf,'posi',[59  42 1900 1900])
% centerfig(gcf)


%% check
if diff_V>=0
    X0 = padarray(cbw12,[V_ShiftX-diff_V 0 0],0,'post');
    X1 = padarray(cbw43,[V_ShiftX        0 0],0,'pre');
else    
    X0 = padarray(cbw12,[V_ShiftX        0 0],0,'post');
    X1 = padarray(cbw43,[V_ShiftX-diff_V 0 0],0,'pre');
end
TS_3dslider(max(X0,X1))
set(gcf,'posi',[59  42 1900 1900])
centerfig(gcf)

%% output
output = max(X0,X1);
ReposiInfo.Vertical_ShiftY  = V_ShiftX;
clear X0 X1 PadSiz MIPn ind diff_V cbw12 cbw43


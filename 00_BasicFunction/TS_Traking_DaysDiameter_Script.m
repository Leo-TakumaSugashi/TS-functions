% % % day compare
% % % str = 'day07SP';
% % % skel = skel_SP;
% % % [DiamImage,SNRImage] = TS_MeasDiam2DiamImage(skel,output_SP.Pointdata);
% % % eval(['DiamImage_' str '_ori = DiamImage;'])
% % % eval(['SNRImage_' str '_ori = SNRImage;'])
% % % figure,hist(DiamImage(DiamImage>0))
% % % clear DiamImage SNRImage 
% % % 
% % % eval(['p = pointview_Color(skel,DiamImage_' str '_ori,NewReso,''figure'' );'])
%% Make Depth Index...
% depht , Control, Comp1, Comp2, Comp3,...
%     like this...
XLS =
  804×5 の cell 配列
    [777]    [  1]    [     NaN]    [     NaN]    [     NaN]
    [776]    [  2]    [     NaN]    [     NaN]    [     NaN]
    [775]    [  3]    [     NaN]    [     NaN]    [     NaN]
    [774]    [  4]    [     NaN]    [     NaN]    [     NaN]
    [773]    [  5]    [     NaN]    [     NaN]    [     NaN]
~~~~~
surf[  0]    [778]    [766.3750]    [766.1111]    [760.9730]
    [ -1]    [779]    [767.6000]    [767.2222]    [762.0541]
    [ -2]    [780]    [768.8250]    [768.3333]    [763.1351]
    [ -3]    [781]    [770.0500]    [769.4444]    [764.2162]
    [ -4]    [782]    [771.2750]    [770.5556]    [765.2973]
    [ -5]    [783]    [772.5000]    [771.6667]    [766.3784]

%% load Depth data
Name = 'DepthIndex_K9_Loc4'
load(Name,'XLS')
xls = cell2mat(XLS);
Depth = xls(:,1);
X0 = xls(:,2);
Y1 = xls(:,3);
Y2 = xls(:,4);
Y3 = xls(:,5);


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%making all posi 用 Scrip%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Depth change(DiamImage)
savename = 'K9_all_posi.mat'

load('K9D00Loc4.mat', 'SEG')%% Original (Control SEG data')
load('K9D00Loc4.mat', 'NewDiamImage')
DiamImage = NewDiamImage;
load('K9D07Loc4.mat', 'NewDiamImage')
DiamImage07 = TS_DepthReposi(X0,Y1,NewDiamImage);
load('K9D14Loc4.mat', 'NewDiamImage')
DiamImage14 = TS_DepthReposi(X0,Y2,NewDiamImage);
load('K9D21Loc4.mat', 'NewDiamImage')
DiamImage21 = TS_DepthReposi(X0,Y3,NewDiamImage);

clear NewDiamImage


%% create shiftmatrix(load)
load('K9D00Loc4.mat', 'NewReso')
load('K9D00Loc4.mat', 'RmfImage')
objsiz = [4 4 7];
adj0 = TS_AdjImage(TS_GaussianFilt3D_parfor(RmfImage,NewReso,objsiz));
load('K9D07Loc4.mat', 'RmfImage')
adj1 = TS_AdjImage(TS_GaussianFilt3D_parfor(RmfImage,NewReso,objsiz));
adj1 = TS_DepthReposi(X0,Y1,adj1);
load('K9D14Loc4.mat', 'RmfImage')
adj2 = TS_AdjImage(TS_GaussianFilt3D_parfor(RmfImage,NewReso,objsiz));
adj2 = TS_DepthReposi(X0,Y2,adj2);
load('K9D21Loc4.mat', 'RmfImage')
adj3 = TS_AdjImage(TS_GaussianFilt3D_parfor(RmfImage,NewReso,objsiz));
adj3 = TS_DepthReposi(X0,Y3,adj3);
clear RmfImage

%%  create shiftmatrix(Calculate)
sh0 = zeros(size(adj0,3),2);
for n = 1:3
    sh = sh0;
    eval(['Comp = adj' num2str(n) ';'])
    for k = 1:size(adj0,3)
        im = Comp(:,:,k);
        if max(im(:)) == 0
            continue
        end
        s = TS_SliceReposition(adj0(:,:,k),im);
        sh(k,:) = s;
    end    
    eval(['sh' num2str(n) '= sh;'])
    clear s im k Comp
end

%% 確認
for n = 1:4
    figure,plot(eval(['sh' num2str(n)]))
end

%% adjImage 2 reposit
for n= 1:3
    Comp = eval(['adj' num2str(n) ';']);
    sh = eval(['sh' num2str(n) ';']);
    for k = 1:size(adj0,3)
        s = sh(k,:);
        im = Comp(:,:,k);
        [~,im] = TS_Shift2pad_vEachSlice(im,im,s,'crop');
        Comp(:,:,k) = im;        
    end
    eval(['Radj' num2str(n) ' = Comp;']);
    clear Comp    
end

TS_3dslider(cat(5,adj0,Radj3))



%% savename check
DIRDATA = dir('*.mat');
checkTF = false(1,length(DIRDATA));
for n = 1:length(checkTF)
    checkTF(n) = strcmpi(DIRDATA(n).name,savename);
end
if max(checkTF)
    clear savename
    error('Exis same savename')
else
    disp( '    Save Name check : : OK!!')
    clear checkTF DIRDATA n
end

%%
save(savename,'XLS','sh0','sh1','sh2','sh3','savename','-v7.3')


%% DiamImage 2 reposit
str = {'07','14','21'}
for n= 1:3
    Comp = eval(['DiamImage' str{n} ';']);
    sh = eval(['sh' num2str(n) ';']);
    for k = 1:size(adj0,3)
        s = sh(k,:);
        im = Comp(:,:,k);
        [~,im] = TS_Shift2pad_vEachSlice(im,im,s,'crop');
        Comp(:,:,k) = im;        
    end
    eval(['DiamImage' str{n} ' = Comp;']);
    clear Comp    
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SKEL = day00's skeleton data
% X = RePosited DiamImage 位置合わせ
SEG00 = TS_SEGandDiam(SEG,DiamImage);
save(savename,'SEG00','-append')
save(savename,'DiamImage','-append')
SKEL = SEG.Output;
for n = 1:length(str)
    disp(['SKEL 2 Diame (Traccking data....) ' num2str(n) '/' num2str(length(str))])
    inD =  eval(['DiamImage' str{n} ';']);
    [outD,PointNumber] = RyoH_skel2diam(SKEL,inD);
    seg = TS_SEGandDiam(SEG,outD);
    eval(['DiamImage' str{n} ' = outD;']);
    eval(['SEG' str{n} ' = seg;']);
    clear inD outD PointNumber
    save(savename,['SEG' num2str(str{n})],['DiamImage' num2str(str{n})] ,'-append')
end

%% 毛細血管の追跡評価用
N = {'00','07','14','21'}
N{1}
for n = 1:length(N)
    seg = eval(['SEG' N{n}]);
    for k = 1:length(seg.Pointdata)
        usediam = seg.Pointdata(k).Diameter;
        seg.Pointdata(k).use = nanmean(usediam(usediam>0));
    end
    data(n).N = N{n};
    D = cat(1,seg.Pointdata.use);
    data(n).Diameter = D;
    eval(['SEG' num2str(N{n}) '= seg;'])
    clear D seg usediam
end

D = cat(2,data.Diameter);
Ind = and(D(:,1) > 2,D (:,1)<8);
save(savename,'data','D','Ind' ,'-append')
disp('Number of Analysis segment point')
sum(~isnan(D(Ind,:)),1)

%%
figname = input('Figure Name input : ' );
figure('Name',figname)
X = {'0w','1w','2w','3w'}
boxplot(D(Ind,:),X)
ylabel('Average of Diameter per 1 segment')
title(['median: ' num2str(round(nanmedian(D(Ind,:),1) * 10) /10) ' \mum'])
saveas(gcf,[figname '.fig'])
saveas(gcf,[figname '.tif'])





















%% 以下　Referance

%%
% ch = gco;
% ch.Label.String = 'Diameter [\mum]';
checkTF = dir(['DiamImage_Original_' str '.mat']);
if isempty(checkTF)
saveas(gcf,['DiamImage_' str '_pointviewColor.fig'])
saveas(gcf,['DiamImage_' str '_pointviewColor.tif'])

save(['DiamImage_Original_' str '.mat'],['DiamImage_' str '_ori'],['SNRImage_' str '_ori'])
else
    error('Input Name Is Not Correct')
end
%%
clear ,close all hidden

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SKEL = day00's skeleton data
% X = RePosited DiamImage 位置合わせ
[DiamImage07,PointNumber07] = RyoH_skel2diam(SKEL,DiamImage07);

%%
% SEG = day00's SEG data 
SEG00 = TS_SEGandDiam(SEG,DiamImage);
SEG07 = TS_SEGandDiam(SEG,DiamImage07);
SEG14 = TS_SEGandDiam(SEG,DiamImage14);
SEG21 = TS_SEGandDiam(SEG,DiamImage21);

%% Diam is Average of Each Segmented Vessels
DiamAveImage00 = TS_SEG2DiamAveImage(SEG00);
DiamAveImage07 = TS_SEG2DiamAveImage(SEG07);
DiamAveImage14 = TS_SEG2DiamAveImage(SEG14);
DiamAveImage21 = TS_SEG2DiamAveImage(SEG21);

% save DiamAveImage DiamAveImage00 DiamAveImage07 DiamAveImage14 DiamAveImage21

%% Reconst
Reso = 1;
Reco00 = TS_Diam2Reconst(DiamAveImage00,Reso);
Reco07 = TS_Diam2Reconst(DiamAveImage07,Reso);
Reco14 = TS_Diam2Reconst(DiamAveImage14,Reso);
Reco21 = TS_Diam2Reconst(DiamAveImage21,Reso);

% save ReconstructEachDaycomp Reco00 Reco07 Reco14 Reco21

%% Reconst 2 isosurface
xdata = 0:size(Reco00,2)+1;
ydata = 0:size(Reco00,1)+1;
zdata = flip(0:size(Reco00,3)+1);
%% 
Reco = Reco21;
TitleSTR = 'Day 21';
fv = isosurface(xdata,ydata,zdata,padarray(Reco,ones(1,3),0),0,...
     imdilate(padarray(Reco,ones(1,3),0),ones(3,3,3)));
figure('Posi',[100 100 500 900])
 p = patch(fv,'EdgeColor','none');
  p.FaceColor = 'interp';
 set(gca,'Ydir','reverse','Zdir','reverse',...
     'posi',[.1 .2 .8 .75])
 daspect(ones(1,3))
 view(3)
 axis tight
 colormap(jet)
  ch = colorbar('Location','Southoutside','position',[.1 .1 .8 .03]);
  ch.Label.String = 'Diameter [\mum]';
 title(TitleSTR)
 clear Reco TitleSTR
 caxis([2 20])
 
%%
DiamMatrix = nan(length(SEG00.Pointdata),4);
STDMatrix = DiamMatrix;
for n = 1:size(DiamMatrix,1)
    DiamMatrix(n,1) = TSmean(SEG00.Pointdata(n).Diameter);
    DiamMatrix(n,2) = TSmean(SEG07.Pointdata(n).Diameter);
    DiamMatrix(n,3) = TSmean(SEG14.Pointdata(n).Diameter);
    DiamMatrix(n,4) = TSmean(SEG21.Pointdata(n).Diameter);
    STDMatrix(n,1) = TSstd(SEG00.Pointdata(n).Diameter);
    STDMatrix(n,2) = TSstd(SEG07.Pointdata(n).Diameter);
    STDMatrix(n,3) = TSstd(SEG14.Pointdata(n).Diameter);
    STDMatrix(n,4) = TSstd(SEG21.Pointdata(n).Diameter);
end


%% vs Each SEGment 

[S,Ind] = sort(DiamMatrix(:,1));
sDiamMatrix(:,1) = S;
sDiamMatrix(:,2) = DiamMatrix(Ind,2);
sDiamMatrix(:,3) = DiamMatrix(Ind,3);
sDiamMatrix(:,4) = DiamMatrix(Ind,4);
for n = 1:4
sSTDMatrix(:,n) = STDMatrix(Ind,n);
end

% save EachSegmentdata SEG00 SEG07 SEG14 SEG21 sDiamMatrix sSTDMatrix
%% 
figure,imagesc(sDiamMatrix)
%%
figure,
n = 1;
sDiamMatrix = M;
Ind = M(:,1)>=8;
sDiamMatrix(~Ind,:) = [];
v = sDiamMatrix(n,:);
DayVec =  [0:7:21];
plot(DayVec,v,'Color',ones(1,3)*0.8);
hold on
for n = 2:size(sDiamMatrix,1)
    v = sDiamMatrix(n,:);
    plot(DayVec,v,'Color',ones(1,3)*0.8);
end
% plot(DayVec,TSmean(sDiamMatrix,1),'Color','k')
SD = TSstd(sDiamMatrix(:,1),1) ;
for n = 2:4
    SD = [SD TSstd(sDiamMatrix(:,n),1)] ;
end


eh = errorbar(DayVec,TSmean(sDiamMatrix,1),SD);
eh.Color = ones(1,3)*0.2;
eh.LineWidth = 2;
xlim([-1 22])
ylim([0 21])
xlabel('Day')
ylabel('Diameter [\mum]')
set(gca,'Posi',[.1 .18 .85 .8])


%% original script
edit TS_Traking_DaysDiameter_Script


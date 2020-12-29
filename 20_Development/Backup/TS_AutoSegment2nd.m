function Output = TS_AutoSegment2nd(Segmentdata,Cutlen)
% Output = TS_AutoSegment2nd(Segmentdata,Cutlen)
% Segmentdata:
% 　End point からBranch or End Pointまでのセグメントと長さの計算結果
% Cutlen：
% 　カットしたいヒゲの長さ
% % 
tic
%  Input: [120x120x250 logical]
%            Branch: [120x120x250 logical]
%               End: [120x120x250 logical]
%         Pointdata: [1x437 struct]
%     ResolutionXYZ: [1.7878 1.7878 1.7878]

%% Input
Reso = Segmentdata.ResolutionXYZ; %% Resolution [X Y Z]
bwthindata = Segmentdata.Input;
BPcentroid = Segmentdata.Branch;
% [bpy,bpx,bpz] = ind2sub(size(BP),find(BP(:)));
EndP = Segmentdata.End;
Pdata = Segmentdata.Pointdata;

OriginalBW = bwthindata;

%% bwthindata --->削って行き、なくなったら終了
%%　同じ分岐点から2本以上endpointまで伸びているものがあれば
% 　一番長いものはCutlen以下でも残したい。。。
End2Branch = [];
Pdata(1).DeleteTF = [];
for n = 1:length(Pdata)
    switch Pdata(n).Type
        case 'End to Branch'
            End2Branch = cat(1,End2Branch,Pdata(n).Branch);
            Pdata(n).DeleteTF = true;
        case 'Branch to Branch'
    end
end
% Branch = cat(1,Pdata.Branch);
BPmatrix = Segmentdata.BPmatrix;
End2Branch_NUM = zeros(size(BPmatrix,1),1);
%% Caliculate End 2 Branch point's count....
PadSiz = size(End2Branch,1) - 1;
for n = 1:size(BPmatrix,1)
    p = BPmatrix(n,1:3); % [ X Y Z ]
    p = padarray(p,[PadSiz 0],'symmetric','pre');
    End2Branch_NUM(n) = sum(sum(p==End2Branch,2)==3,1);
end
clear n PadSiz End2Branch


for n = 1:size(BPmatrix,1)
    NUM = End2Branch_NUM(n);
    if NUM<2
        continue
    else
        bp = BPmatrix(n,1:3);
        LEN = [];
        Ind = [];
        for n2 = 1:length(Pdata)
            switch Pdata(n2).Type
                case 'End to Branch'
                    if sum(Pdata(n2).Branch == bp)==3
                        Ind = cat(1,Ind,n2);
                        LEN = cat(1,LEN,Pdata(n2).Length);                        
                    end
            end
        end
        [~,MaxIndex] = max(LEN);
        Pdata(Ind(MaxIndex)).DeleteTF = false;
    end
    clear bp NUM LEN Ind n2 MaxIndex
end

%% Delete
bwthindata = padarray(bwthindata,[1 1 1],false);
for n = 1:length(Pdata)
    switch Pdata(n).Type
        case 'End to End'
            if Cutlen<Pdata(n).Length
                continue
            end
            xyz = Pdata(n).PointXYZ + 1;
            bwthindata(xyz(:,2),xyz(:,1),xyz(:,3)) = false;
            clear xyz
        case 'End to Branch'
            if Cutlen<Pdata(n).Length
                continue
            end            
            if Pdata(n).DeleteTF
                xyz = Pdata(n).PointXYZ;
                for n2 = 1:size(xyz,1)
                    x = xyz(n2,1) + 1;
                    y = xyz(n2,2) + 1;
                    z = xyz(n2,3) + 1;
                    ROI = bwthindata(y-1:y+1,x-1:x+1,z-1:z+1);
                    s = bwconncomp(ROI,26);
                    NUMpre = s.NumObjects;
                    ROI(2,2,2) = false;
                    s = bwconncomp(ROI,26);
                    NUMaft = s.NumObjects;
                    %% Check Deletable or Not
                    if NUMpre==NUMaft
                        bwthindata(y,x,z) = false;
                    end
                    clear x y z ROI s NUMpre NUMaft
                end
                clear xyz
            end            
        case 'Branch to Branch'
    end
end

%% Re Skeletoning by TS_bwmoroph3d
bwthindata = TS_bwmorph3d(bwthindata,'thin');

%% Re AutoSegment
Output = [];
% Output = TS_AutoSegment1st(bwthindata(2:end-1,2:end-1,2:end-1),Reso);
Output = TS_AutoSegment1st_proto(bwthindata(2:end-1,2:end-1,2:end-1),Reso);
Output.CutLength = Cutlen;
Output.Original = OriginalBW;

return


%% Check in Figure
bwthindata(BPcentroid) = true;
Output.NewSkeleton = bwthindata;
fgh = figure('Position',[100 50 600 900],...
    'PaperPosition',[.6 .6 12 20],...
    'InvertHardcopy','off','Color','w');
axes('Position',[.08 .05 .9 .9])
% % Cut point
CP = and(OriginalBW,~bwthindata);
[y,x,z] = ind2sub(size(CP),find(CP(:)));
plh(1) = plot3((x-1)*Reso(1),(y-1)*Reso(2),(z-1)*Reso(3),'g.');
hold on
axh = gca;
[y,x,z] = ind2sub(size(bwthindata),find(bwthindata(:)));
plh(2) = plot3((x-1)*Reso(1),(y-1)*Reso(2),(z-1)*Reso(3),'b.');
legend('Cut Point','Residue','Location','NorthOutside')
title(['Cut Lenght : ' num2str(Cutlen) '\mum'])
daspect(ones(1,3))
box on,axis tight,grid on
set(axh,'Ydir','reverse')
drawnow
% close(fgh)

clear Branch CP EndP LEN Ind NUM Num TF axh bp fgh n plh
Output = [];
return

%% 2nd Segment
bwthindata(BP) = true;
    pointview(bwthindata,Reso);
    [y,x,z] = ind2sub(size(BP),find(BP(:)));
    plot3((x-1)*Reso(1),(y-1)*Reso(2),(z-1)*Reso(3),'go');
    clear x y z 
bwthindata(BP) = false;
bwthindata = padarray(bwthindata,[1 1 1],false);
BP = padarray(BP,[1 1 1],0);
    [y,x,z] = ind2sub(size(BP),find(BP(:)));
    plot3((x-2)*Reso(1),(y-2)*Reso(2),(z-2)*Reso(3),'rx');
    clear x y z 


NewEndP = TS_bwmorph3d(bwthindata,'endpoint');
 % Start point is NewEnd point
[ey,ex,ez] = ind2sub(size(NewEndP),find(NewEndP(:)));
wh = waitbar(0,'Wait for ...');
set(wh,'Name','Calculate ''Auto Segment 2nd...''')
Resi = sum(bwthindata(:)); % for waitbar
BP_index = uint32(1);
% B.P.-NextPointが以下を超えるとBPとのつながりを認めない。。
NextLen_th = sqrt((max(Reso)*2)^2*3);

[y,x,z] = ind2sub(size(bwthindata),find(bwthindata(:)));
xyz = cat(2,x,y,z) - 1; %% bwthindataは1つ分padarrayしている。
clear x y z

c_Pdata = uint32(length(Pdata) + 1);


%% Debag
plh = pointview(bwthindata,Reso);
[BPy,BPx,BPz] = ind2sub(size(BP),find(BP(:)));
plh(2) = plot3((BPx-2)*Reso(1),(BPy-2)*Reso(2),(BPz-2)*Reso(3),'ro');
plh(3) = plot3((ex-2)*Reso(1),(ey-2)*Reso(2),(ez-2)*Reso(3),'g*');

% return

while ~isempty(xyz)
    %% Find Start of Branch point
    start_bp = BPmatrix(BP_index,1:3);
    Len_start_bp = padarray(start_bp,[size(xyz,1)-1 0],'symmetric','pre');
    DiffLen = (xyz - Len_start_bp).* padarray(Reso,[size(xyz,1)-1 0],'symmetric','pre');
    LEN = sqrt(sum(DiffLen.^2,2));clear Len_start_bp DiffLen
    [LEN_min,Ind] = min(LEN);
    Ind = Ind(1); %% 複数を懸念
%     disp(num2str(size(xyz,1))) %%%%%%%%%%% debag
%     disp(num2str(c_Pdata))
    t = toc;
    if t > 20
        disp(['BP_ROI:' num2str(max(BP_ROI(:)))])
%         figure,plot(LEN)
%         LEN_min
%         NextLen_th
%         whos
        break
    end
    if LEN_min <= NextLen_th
        Go2Next = true;
        c = uint32(1);
        Segment = struct('point',[]);
        Segment(c).point = start_bp;
        c = c + 1;
        X = xyz(Ind,1);
        Y = xyz(Ind,2);
        Z = xyz(Ind,3);
        Segment(c).point = [X Y Z];
        CropBP = BP;
        CropBP(start_bp(2)+1,start_bp(1)+1,start_bp(3)+1) = false;
        while Go2Next
            c = c + 1;            
            BP_ROI = CropBP(Y:Y+2,X:X+2,Z:Z+2);
            % % 26近傍に近くにB.Pがあるかどうか
            if max(BP_ROI(:))                
                [Ny,Nx,Nz] = ind2sub(size(BP_ROI),find(BP_ROI(:)));
                X = X + Nx(1) -1;%% length(Nx) > 1だとerrorであるが。
                Y = Y + Ny(1) -1;
                Z = Z + Nz(1) -1;
                Segment(c).point = [X Y Z];
                TYPE = 'Branch to Branch';
                Go2Next = false;
                clear Ny Nx Nz
            else
                NextPoint = cat(1,xyz,BPmatrix(:,1:3));
                p = [X Y Z];
                p = padarray(p,[size(NextPoint,1)-1 0],'symmetric','pre');
                SegLen = sum((NextPoint - p).^2,2);
                [~,SegInd] = min(SegLen);
                SegInd = SegInd(1);
                X = NextPoint(SegInd,1);
                Y = NextPoint(SegInd,2);
                Z = NextPoint(SegInd,3);
                Segment(c).point = [X Y Z];
                bwthindata(Y,X,Z) = false;
                if SegInd>size(xyz,1) %% B.P 参照のため
                    Go2Next = false;
                    TYPE = 'Branch to Branch';
                else
                    xyz(SegInd,:) = [];
                    Go2Next = true;
                end
                clear p SegLen SegInd Padsiz NextPoint
            end
        end
        Point4Len = cat(1,Segment.point);
        plh(length(plh)+1) = plot3(...
            (Point4Len(:,1)-0)*Reso(1),...
            (Point4Len(:,2)-0)*Reso(2),...
            (Point4Len(:,3)-0)*Reso(3),'r-',...
            'Linewidth',2);
        for roop_n = 1:5
            set(plh(end),'visible','off')
            pause(.1)
            set(plh(end),'visible','on')
            pause(.1)
        end
        
        Pdata(c_Pdata).PointXYZ = Point4Len;
        % % Lenght by bilinear 
        LEN_reso = diff(Point4Len,1) .* ...
            padarray(Reso,[size(Point4Len,1)-2 0],'symmetric','pre');
        Pdata(c_Pdata).Length = sum(sqrt(sum(LEN_reso.^2,2)),1);
        Pdata(c_Pdata).Type = TYPE;
        c_Pdata = c_Pdata + 1;
        S = size(xyz,1);
        waitbar((Resi-S)/Resi,wh,['Wait...Numel:' num2str(S) '/' num2str(Resi)])
        clear Segment Y X Z c Go2Next Point4Len LEN_reso S     
    else
        BPmatrix(BP_index,5) = BPmatrix(BP_index,5)+ 1; 
        BP_index = BP_index+ 1;
        if size(BPmatrix,1)<BP_index
            break
        end
    end    
end
close(wh)
Output.Pointdata = Pdata;
Output.bwthindata = bwthindata;
Output.plh = plh;
toc
return
%% Check figure
% skeleton data
[y,x,z] = ind2sub(size(OriginalBW),find(OriginalBW(:)));
fgh = figure;
% plot3((x-1)*Reso(1),(y-1)*Reso,(z-1)*Reso,'g.')
plh(1) = plot3((x-1)*Reso(1),(y-1)*Reso(2),(z-1)*Reso(3),'g.');
hold on
axh = gca;
% BranchPoint data
[y,x,z] = ind2sub(size(BP),find(BP(:)));
plh(2) = plot3((x-2)*Reso(1),(y-2)*Reso(2),(z-2)*Reso(3),'r>');
% EndPoint data
[y,x,z] = ind2sub(size(EndP),find(EndP(:)));
plh(3) = plot3((x-2)*Reso(1),(y-2)*Reso(2),(z-2)*Reso(3),'bo');
set(axh(1),'Ydir','reverse')
setappdata(fgh,'OriginalPlotH',plh)
uih(1) = uicontrol('Style','checkbox',...
    'unit','normalized',...
    'Position',[.01 .96 .12 .04],...
    'String','Skeleton Point',...
    'Callback',@Callback_visible,...
    'userdata',plh(1));
uih(2) = uicontrol('Style','checkbox',...
    'unit','normalized',...
    'Position',[.14 .96 .12 .04],...
    'String','Branch Point',...
    'Callback',@Callback_visible,...
    'userdata',plh(2));
uih(3) = uicontrol('Style','checkbox',...
    'unit','normalized',...
    'Position',[.27 .96 .12 .04],...
    'String','End Point',...
    'Callback',@Callback_visible,...
    'userdata',plh(3));
set(uih,'Value',1)

% End to NextPoint
LEN = cat(1,Pdata.Length);
Cmap = jet(round(max(LEN)));
colormap(Cmap)
set(axh(1),'Clim',[0 max(LEN)])
SegPlh = zeros(length(Pdata),1);
for n = 1:length(Pdata)
    xyz = cat(1,Pdata(n).PointXYZ);
    len_ind = round(Pdata(n).Length);
    SegPlh(n) = plot3((xyz(:,1)-1)*Reso(1),...
        (xyz(:,2)-1)*Reso(2),...
        (xyz(:,3)-1)*Reso(3),'Color',Cmap(len_ind,:));
end
colorbar
axis tight
grid on
box on
daspect([1 1 1])

%% add Histglam of Length
clear LEN
LEN = cat(1,Pdata.Length);
[h,x] = hist(LEN,256);
set(axh,'Position',[.05 .05 .4 .9])
set(fgh,'Position',[100 100 1000 600])
axh(2) = axes('Position',[.6 .15 .38 .8]);
bar(x,h,'BarWidth',1)
ylabel('Frequency')
xlabel('Length [\mum]')
grid on

setappdata(fgh,'axh',axh)
setappdata(fgh,'data',Output)

%% output time
toc
disp(['  ...Analysis by ' mfilename ])
set(fgh,'Color','w',...
    'InvertHardcopy','off',...
    'PaperPosition',[.6 .6 16 10])

end

function Callback_visible(oh,~)
val = get(oh,'Value');
if val==1
    set(get(oh,'Userdata'),'Visible','on')
else
    set(get(oh,'Userdata'),'Visible','off')
end
end


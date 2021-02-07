function Output = TS_AutoSegment1st_old(bwthindata,varargin)
% Output = TS_AutoSegment1(skeleton_logicaldata,Resolution)
% End point からBranch or End Pointまでのセグメントと長さの計算
% （長さの計算上、ResolutionはX:Y:Z = 1:1:1;となるようにしたい。。。）
% % 


if nargin>1
    Reso = varargin{1};
else
    Reso = [1 1 1]; %% Resolution [X Y Z]
end

tic
OriginalBW = bwthindata;

% % PointXYZ is matrix, Type is 'End to Branch' or 'Branch to Branch'
Pdata = struct('PointXYZ',[],'Type',[],'Length',[],'Branch',[]); %  point--->[Y X Z]

%% Analysis Branch-point and End-point 
[BP,BP2] = TS_bwmorph3d(bwthindata,'branchpoint','view');
[bpy,bpx,bpz] = ind2sub(size(BP),find(BP(:)));
 % BP point infomation,[X Y Z Number Count]
 BPmatrix = cat(2,bpx,bpy,bpz,find(BP(:)),zeros(size(bpx))); 
 clear bpy bpx bpz
EndP = TS_bwmorph3d(bwthindata,'endpoint','none');
Output.Input = bwthindata;
Output.Branch = BP;
Output.End = EndP;
Output.Pointdata = [];
Output.ResolutionXYZ = Reso;

bwthindata = padarray(bwthindata,[1 1 1],0); %% For Crop;Nearest 26 point
bwthindata(BP) = false; %% bwthindata --->削って行き、なくなったら終了  
BP = padarray(BP,[1 1 1],0);
EndP = padarray(EndP,[1 1 1],0);
[lenBPy,lenBPx,lenBPz] = ind2sub(size(BP),find(BP(:)));
%% End point to a Branchpoint or a Endpoint
[ey,ex,ez] = ind2sub(size(EndP),find(EndP(:)));
wh = waitbar(0,'Wait for ...');
set(wh,'Name','Calculate End 2 End or Branch')
for n = 1:length(ey)
    Y = ey(n);
    X = ex(n);
    Z = ez(n);
    BranchPoint = nan(1,3);
    % % End point check(End-Endは二番目のEndPointを消してしまうため。)
    if not(bwthindata(Y,X,Z))
        continue
    end
    c = uint32(1);
    Segment = struct('point',[]);
    Segment(c).point = double([X Y Z]-1);
    bwthindata(Y,X,Z) = false;
    Go2Next = true;    
    while Go2Next
        c = c + 1;
        BP_ROI = BP(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
        lenp = [Y X Z];
        if max(BP_ROI(:))
            BPyxz = cat(2,lenBPy,lenBPx,lenBPz);
            leny = lenBPy;
            lenx = lenBPx;
            lenz = lenBPz;
            lenp = padarray(lenp,[length(leny)-1 0],'symmetric','pre');
            LEN = sum((BPyxz - lenp).^2,2);
        else
            [leny,lenx,lenz] = ind2sub(size(bwthindata),find(bwthindata(:)));
            leny = cat(1,leny,lenBPy);
            lenx = cat(1,lenx,lenBPx);
            lenz = cat(1,lenz,lenBPz);
            lenp = padarray(lenp,[length(leny)-1 0],'symmetric','pre');
            LEN = sum((cat(2,leny,lenx,lenz) - lenp).^2,2);
        end
        [~,Index] = min(LEN);
        % % Next point
        Y = leny(Index);
        X = lenx(Index);
        Z = lenz(Index);
        Segment(c).point = double([X Y Z]-1);
        if BP(Y,X,Z)
            TYPE = 'End to Branch';
            BranchPoint = [X Y Z] - 1;
            Go2Next = false;
        elseif EndP(Y,X,Z)
            TYPE = 'End to End';
            Go2Next = false;
        else
            bwthindata(Y,X,Z) = false;
            Go2Next = true;
        end
        clear leny lenx lenz lenp LEN Index
    end
    Point4Len = cat(1,Segment.point);
    Pdata(n).PointXYZ = Point4Len;
    % % Lenght by bilinear 
    LEN_reso = diff(Point4Len,1) .* ...
        padarray(Reso,[size(Point4Len,1)-2 0],'symmetric','pre');
    Pdata(n).Length = sum(sqrt(sum(LEN_reso.^2,2)),1);
    Pdata(n).Type = TYPE;
    Pdata(n).Branch = BranchPoint;
    
    waitbar(n/length(ey),wh,['Wait...' num2str(n) '/' num2str(length(ey))])
    clear Segment Y X Z c Go2Next Point4Len LEN_reso
end
close(wh)

% BP point infomation,[X Y Z Number Count]
Branch = cat(1,Pdata.Branch);
for n = 1:size(BPmatrix,1)
    p = BPmatrix(n,1:3);
    p = padarray(p,[size(Branch,1)-1 0],'symmetric','pre');
    Count = sum(sum(Branch==p,2)==3);
    BPmatrix(n,5) = Count;
end

Output.Pointdata = Pdata;
Output.BPmatrix = BPmatrix;
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

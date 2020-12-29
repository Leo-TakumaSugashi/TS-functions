function AddSkel = TS_SEGview_AorV(SEG,figThreshold,Surface,Type)

% 動脈と静脈を分けるためのプログラム
% SEGdim = TS_SEGandDiam(SEG,NewDiamImage);
% Input は　SEGdim、　基本　Type はAverageDiameter、
% Srfaceは表面の０となるIndex.
% figThreshold = 10; %% cap. の閾値

LineWidth = 2;
Unit = '\mum';

% Initiialize
AddSkel = false(size(SEG.Original));
Surface

handles.figure = figure('Posi',[1 1 930 450]);
centerfig(handles.figure)

siz = size(SEG.Original);

%% length to plot(3D)

handles.axh = axes('Posi',[.05 .15 .45 .8]);
handles.axh.NextPlot = 'add';
handles.axh.YDir = 'reverse';

% Len = cat(1,SEG.Pointdata.Length);
 eval(['Len = cat(1,SEG.Pointdata.' Type ' );'])

MaximumLen = max(Len);
handles.axh.CLim = [0 MaximumLen];
map = jet(round(MaximumLen));
handles.figure.Colormap = map;

Reso = SEG.ResolutionXYZ;
ph = nan(length(Len),1);
txh = ph;
for n = 1:length(SEG.Pointdata)
    xyz = SEG.Pointdata(n).PointXYZ;
    if or(Len(n) < figThreshold,isnan(Len(n)))
        continue
    end
    Index = sub2ind(siz,xyz(:,2),xyz(:,1),xyz(:,3));
    AddSkel(Index) = true;
    
    
    switch lower(Unit)
        case {'pix.','pix','pixels'}
        otherwise
            xyz = xyz-1;
            xyz = xyz .*repmat(Reso,[size(xyz,1) 1]);
    end
    
    
    
   
    ph(n) = plot3(xyz(:,1),xyz(:,2),xyz(:,3),...
        'LineStyle','-',...
        'LineWidth',LineWidth,...
        'Marker','none',...
        'Color',map(round(Len(n)),:));
   
    xyz = mean(xyz,1);
    txh(n) = text(xyz(1),xyz(2),xyz(3),num2str(n));
end

AddSkel(SEG.BranchGroup) = true;
AddSkel = bwareaopen(AddSkel,9);
AddSkel(:,:,Surface+1:end) = false;
% 
[L,NUM] = bwlabeln(AddSkel);
Sind = L(:,:,Surface);

% pointview_Color(AddSkel,L,Reso,'figure')








ph(isnan(ph)) = [];
txh(isnan(txh)) = [];
xlim([1 siz(2)])
ylim([1 siz(1)])
zlim([1 siz(3)])
daspect(ones(1,3))
view(3)
handles.plot = ph;
handles.Colorbar = colorbar('Location','SouthOutside');
handles.Colorbar.Label.String = [Type ' [' Unit ']'];
handles.text = txh;

handles.uicontrol_textON = uicontrol(...
    'Style','checkbox',...
    'Position',[5 430 60 20],...
    'String','Text',...
    'Value',1,...
    'Callback',@callback_textON,...
    'Userdata',txh);
handles.uicontrol_textON.Units = 'normalized';

%% Histgram
Type_seg = cell(length(SEG.Pointdata),1);
for n = 1:length(SEG.Pointdata)
    Type_seg{n} = SEG.Pointdata(n).Type;
end
End_Index = or(strcmpi(Type_seg,'End to End'),strcmpi(Type_seg,'End to Branch'));
Other_Index = ~End_Index;

[End_h,End_x] = hist(Len(End_Index),10);
[eX,eY] = TS_bar2patch(End_h,End_x);
[Other_h,Other_x] = hist(Len(Other_Index),10);
[bX,bY] = TS_bar2patch(Other_h,Other_x);
% [h,x] = hist(Len,10);
handles.axes2 = axes('Posi',[.6 .15 .35 .8]);
% handles.histbar = bar(x,h,'hist');
handles.HistPatch_InEnd = patch(eX,eY,[0 0 1]);
    alpha(handles.HistPatch_InEnd,0.7)
handles.HistPatch_InBranch = patch(bX,bY,[0 1 0]);
    alpha(handles.HistPatch_InBranch,0.7)
handles.Legend = legend('In End.' , 'In Branch');
handles.xlabel = xlabel( [ Type ' [' Unit ']']);
handles.ylabel = ylabel('Number of Segment');

setappdata(handles.figure,'handles',handles)
setappdata(handles.figure,'SEG',SEG)

clear ph xyz Reso map MaximumLen Len


function callback_textON(oh,~)
handles = getappdata(oh.Parent,'handles');
txh = get(oh,'Userdata');
xyz = zeros(length(txh),3);
for n = 1:length(txh)
    xyz(n,:) = get(txh(n),'Position');
end
Zlim = zlim(handles.axh);
Ylim = ylim(handles.axh);
Xlim = xlim(handles.axh);
if oh.Value
    set(txh,'Visible','on')
    for n = 1:length(txh)
        TF = [and(Zlim(1)<xyz(n,3),Zlim(2)>xyz(n,3)) ;
            and(Ylim(1)<xyz(n,2),Ylim(2)>xyz(n,2)) ;
            and(Xlim(1)<xyz(n,1),Xlim(2)>xyz(n,1))]; 
        if ~min(TF)
            set(txh(n),'Visible','off')
        end
    end
else
    set(txh,'Visible','off')
%     for n = 1:length(txh)
%         txh(n).Visible = 'off';
%     end
end










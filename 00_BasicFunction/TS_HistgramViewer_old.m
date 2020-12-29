function TS_HistgramViewer_old(data)
%% TS_3dHistgramViewerClim(Image)
% 
% <For example...>
% D = load('mri.mat','D');
% TS_3dHistgramViewerClim(squeeze(D))

%% Calucurate Histgram
% BitNum = 256;  %%　諧調数
% Class = 'uint8';
MaximumFreq = 5000;
bar_color = 'b';
Fsiz = 10.5;
FaceAlpha = .5;
% 
% Maximum = zeros(size(data,3),1);
% Minimum = zeros(size(data,3),1);
% HistMap = struct('Hist',[],'HistCenter',[],'BitNum',[],'Clim',[]);
% 
%  wh = waitbar(0,'Wait...');
 
 
 Maximum = [];
Minimum = [];
HistMap = struct('Hist',[],'BitNum',[]);
[~,~,Z,T,CH] = size(data);
 wh = waitbar(0,'Wait...');
 c = 0;
for n_ch = 1:CH
for n_t = 1:T
for n_z = 1:size(data,3)
    im = double(squeeze(data(:,:,n_z,n_t,n_ch)));
    Minimum = min([min(im(:)) Minimum]);
    Maximum = max([max(im(:)) Maximum] );
    BitNum = max(im(:)) - min(im(:)) + 1;
    if BitNum<2
        BitNum = 256;
    end
%     disp(['Now Slice(z)= ' num2str(n) ', BitNum.:' num2str(BitNum)])
    [h,x] = hist(im(:),BitNum);
    c = c+ 1;
    HistMap(c).Hist = h;
    HistMap(c).HistCenter = x;
    HistMap(c).BitNum = BitNum;
    HistMap(c).ActualMin = min(im(:));
    HistMap(c).ActualMax = max(im(:));
    HistMap(c).Clim = [min(im(:)) max(im(:))];
    HistMap(c).Depth = n_z;
    HistMap(c).Time = n_t;
    HistMap(c).Channels = n_ch;
     waitbar(c/(Z*T*CH),wh,'wait...')
    clear im h BitNum
end
end
end
% figure,plot(1:size(data,3),cat(1,HistMap.BitNum),'o:')
% title('Bitsize')
% ylabel('Bit Number')
% xlabel('Slice[axis z]')
close(wh)

%% fgh and Axes
fgh = figure('Posi',[36  307  877  479],...
    'toolbar','figure',...
    'Menubar','None',...
    'Name','xyzt Histgram Viewer',...
    'PaperPosition',[.6 .3 21.9 11.97],...
    'Color','w',...
    'Resize','off',...
    'DeleteFcn',@Parent_DeleteFcn);
% for Image
axh1 = axes('Unit','Normalized',...
    'Position',[0.01 0.08 0.47 0.84]);
imh = imagesc(data(:,:,1,1,1));
axis(axh1,'image','off')
colormap(gray)

ClimTexth = uicontrol('Style','text',...
    'Units','Normalized',...
    'Position',[0.01 0.94 0.05 0.04],...
    'String','Clim :',...
    'Fontsize',Fsiz);
ClimMinh = uicontrol('Style','Edit',...
    'Units','Normalized',...
    'Position',[0.06 0.94 0.04 0.04],...
    'String','0',...
    'Fontsize',Fsiz);
ClimMaxh = uicontrol('Style','Edit',...
    'Units','Normalized',...
    'Position',[0.10 0.94 0.04 0.04],...
    'String',Maximum,...
    'Fontsize',Fsiz);
ClimApplyh = uicontrol('Style','pushbutton',...
    'Units','Normalized',...
    'Position',[0.14 0.94 0.04 0.04],...
    'String','Apply',...
    'Callback',@Callback_ClimAplly,...
    'Fontsize',Fsiz);

setappdata(fgh,'ClimMinh',ClimMinh)
setappdata(fgh,'ClimMaxh',ClimMaxh)
setappdata(fgh,'ClimTextH',[ClimTexth ClimMinh ClimMaxh ClimApplyh])

% % Clim Global Apply 
ClimGlobalApplyh = uicontrol('Style','pushbutton',...
    'Units','Normalized',...
    'Position',[0.19 0.94 0.06 0.05],...
    'String','Global2z',...
    'Callback',@Callback_ClimGlobalAplly,...
    'Fontsize',Fsiz);
setappdata(fgh,'ClimGlobalApplyh',ClimGlobalApplyh)

% % Clim Reset Apply 
ClimResetApplyh = uicontrol('Style','pushbutton',...
    'Units','Normalized',...
    'Position',[0.25 0.94 0.06 0.05],...
    'String','Reset',...
    'Callback',@Callback_ClimReset,...
    'Fontsize',Fsiz);

% % AddPoint
AddPointApplyh = uicontrol('Style','pushbutton',...
    'Units','Normalized',...
    'Position',[0.32 0.94 0.08 0.05],...
    'String','Clim Interp.',...
    'Callback',@Callback_AddPoint,...
    'Fontsize',Fsiz);
setappdata(fgh,'Children',[])

%% Normalize 
Normalizedh = uicontrol('Style','pushbutton',...
    'Units','Normalized',...
    'Position',[0.41 0.94 0.09 0.06],...
    'String','Normalize',...
    'Callback',@Callback_Normalize,...
    'Fontsize',Fsiz);


%% for Histgram
axh2 = axes('Unit','Normalized',...
    'Position',[0.58 0.15 0.35 0.75]);
box on
% bh = bar(HistMap(1).HistCenter,HistMap(1).Hist,bar_color);
% set(bh,'BarWidth',1)
ColorMap = GetColorChannels(CH);

bh = zeros(1,CH);
for n = 1:CH
    Ind = sub2ind([1 1 Z T CH],1,1,1,1,n);
    [x,y] = Bar2patchdata(HistMap(Ind).HistCenter,HistMap(Ind).Hist);
    bh(n) = patch('Parent',axh2,'Xdata',x(:),'Ydata',y(:),...
        'FaceColor',ColorMap(n,:),...
        'EdgeColor','none'); %% Type Patch
%     bh(n) = plot(x(:),y(:),...
%         'Parent',axh2,'Color',ColorMap(n,:));
    hold on
end
hold off
alpha(bh,FaceAlpha)
set(bh,'visible','off')
set(bh(1),'visible','on')


grid on
X = HistMap(1).HistCenter;
set(axh2,'Xlim',[-diff(X(1:2))+X(1) X(end)+diff(X(1:2))],'Ylim',[0 MaximumFreq],...
    'YLimMode','manual','XLimMode','manual') %% Normal scals
% set(axh2,'Xlim',[-diff(X(1:2))+X(1) X(end)+diff(X(1:2))],'Ylim',[0 MaximumFreq],...
%     'YLimMode','manual','XLimMode','manual',...
%     'YScale','log') %% log scals
ylabel(axh2,'Frequency')
xlabel(axh2,'Intensity')


uitx_Ylim = uicontrol('Style','Edit',... 
    'Units','Normalized',...
    'Position',[0.58 0.945 0.07 0.05],...
    'String',num2str(MaximumFreq));
uico = uicontrol('Style','pushbutton',...
    'Units','Normalized',...
    'Position',[0.66 0.94 0.04 0.04],...
    'String','Aplly',...
    'Callback',@Callback_Ylim);
uitx_MaxMin = uicontrol('Style','text',...
    'Units','Normalized',...
    'Position',[0.72 0.94 0.25 0.06],...
    'String',['Global Intensity. Min:' num2str(Minimum(end)) '   Max:' num2str(Maximum(end))],...
    'Fontsize',Fsiz);
%% Clim add
HistMaximum = MaximumFreq;
% for n_z = 1:length(HistMap)
%     HistMaximum = max([HistMap(n_z).Hist HistMaximum]);
% end
set(axh2,'Ylim',[0 HistMaximum])
set(uitx_Ylim,'String',HistMaximum)
Climdata(1:CH) = struct('Handle',[]);
for n = 1:CH
Climh = imrect(axh2,[X(1) -HistMaximum*0.1 (X(end)-X(1)) HistMaximum*1.2]) ; %% Rectanglの上と下はサチラセル
% Climh = imrect(axh2,[X(1) .1 (X(end)-X(1)) HistMaximum*1.2]) ; %% For log Scale
setColor(Climh,ColorMap(n,:));
ch = get(Climh,'Children');
a = [1 2 3 4 6 10];
% 1  Line     (maxx miny corner marker)
% 2  Line     (maxx maxy corner marker)
% 3  Line     (minx maxy corner marker)
% 4  Line     (minx miny corner marker)
% 5  Line     (miny top line)
% 6  Line     (miny side marker)
% 7  Line     (maxx top line)
% 8  Line     (maxx side marker)
% 9  Line     (maxy top line)
% 10 Line     (maxy side marker)
% 11 Line     (minx top line)
% 12 Line     (minx side marker)
% 13 Patch    (patch)
% 14 Line     (wing line)
% 15 Line     (bottom line)
set(ch(a),'Visible','off')
ch(13).HitTest = 'off';
addNewPositionCallback(Climh,@(p) PositionConstrainFcn_Clim);
Climdata(n).Handle = Climh;
set(Climh,'Visible','off')
clear Climh ch a 
end
set(Climdata(1).Handle,'Visible','on')

%% Setappdata
setappdata(fgh,'uitx_MaxMin',uitx_MaxMin)
setappdata(fgh,'Maximum',Maximum)
setappdata(fgh,'Minimum',Minimum)
setappdata(fgh,'Ylim_text',uitx_Ylim)
setappdata(fgh,'BarH',bh)
setappdata(fgh,'HistMap',HistMap)
setappdata(fgh,'Axes',[axh1 axh2]);
setappdata(fgh,'Climh',Climdata)
%% display
setappdata(fgh,'imh',imh);
setappdata(fgh,'data',data);
slh = [];
%% Axis Z
    slh(1) = uicontrol('Style','slider',...
        'Unit','Normalized',...
        'BackgroundColor',[0.5 0.5 0.5],...
        'Position',[0 0 .5 0.04],...
        'Value',0,...
        'Callback',@Callback_slider,...
        'Userdata',Z-1);
    txh(1) = uicontrol('Style','text',...
        'unit','Normalized',...
        'Position',[0 0.04 0.08 0.03],...
        'String','Z: 1');
    setappdata(fgh,'txh',txh);
%% Axis T
    slh(2) = uicontrol('Style','slider',...
        'Unit','Normalized',...
        'BackgroundColor',[0.5 0.5 0.5],...
        'Position',[.55 0 .25 0.04],...
        'Value',0,...
        'Callback',@Callback_slider,...
        'Userdata',T-1);
    txh(2) = uicontrol('Style','text',...
        'unit','Normalized',...
        'Position',[0.55 0.04 0.08 0.03],...
        'String','T: 1');
%% Axis CH
    slh(3) = uicontrol(...
        'Unit','Normalized',...
        'BackgroundColor',[0.8 0.8 0.8],...
        'Position',[.82 0 .16 0.05],...
        'Callback',@Callback_channels,...
        'Userdata',1,...
        'String','Ch: 1');
    guidata(slh(3),CH)
    
 %% slider visible
    
set([slh txh],'visible','off')
if Z>1,set([slh(1) txh(1)],'visible','on','SliderStep',[1/(Z-1) 10/(Z-1)]),end
if T>1,set([slh(2) txh(2)],'visible','on','SliderStep',[1/(T-1) 10/(T-1)]),end
if CH>1 set(slh(3),'Visible','on'),end

 %% slider and text handle setup
setappdata(fgh,'slh',slh)
setappdata(fgh,'txh',txh);
end

%% Callback 
 %% Callback Channels
  % Callback slider
function Callback_channels(oh,~)
maxCH = guidata(oh);
fgh = get(oh,'Parent');
bh = getappdata(fgh,'BarH');
Climdata = getappdata(fgh,'Climh');

DataName = cell(maxCH,1);
for n=1:maxCH,DataName{n} = num2str(n);   end
[CH,ok] = listdlg('PromptString','Select Channels',...
    'SelectionMode','multiple','ListString',DataName);
if ok
    set(oh,'Userdata',CH,...
        'String',['Ch :' num2str(CH)])
end

set(bh,'Visible','off');
set(bh(CH),'visible','on');

for n = 1:maxCH , set(Climdata(n).Handle,'visible','off');end
for n = 1:length(CH) , set(Climdata(CH(n)).Handle,'visible','on');end

%% Channels > 1 --> ClimtextH visible to 'off'
if length(CH) > 1
    set(getappdata(fgh,'ClimTextH'),'visible','off')
    set(getappdata(fgh,'ClimGlobalApplyh'),'visible','off')
    
else
    set(getappdata(fgh,'ClimTextH'),'visible','on')
    set(getappdata(fgh,'ClimGlobalApplyh'),'visible','on')
end


Callback_slider(oh)
end

 %% Callback Slider
    %% ResetImage
function Callback_slider(oh,~)
fgh = get(oh,'Parent');
data = getappdata(fgh,'data');
imh = getappdata(fgh,'imh');
slh = getappdata(fgh,'slh');
txh = getappdata(fgh,'txh');

NowSlice = uint16(round(get(slh(1),'Value')*get(slh(1),'Userdata'))+1);
NowTime = uint16(round(get(slh(2),'Value')*get(slh(2),'Userdata'))+1);
NowChannels = uint16(get(slh(3),'Userdata'));
Z = get(slh(1),'Userdata') + 1;
T = get(slh(2),'Userdata') + 1;
CH = guidata(slh(3));

set(txh(1),'String',['Z: ' num2str(NowSlice)])
set(txh(2),'String',['T: ' num2str(NowTime)])

% Histgram
uitx_MaxMin = getappdata(fgh,'uitx_MaxMin');
Maximum = getappdata(fgh,'Maximum');
Minimum = getappdata(fgh,'Minimum');
bh = getappdata(fgh,'BarH');
HistMap = getappdata(fgh,'HistMap');
axh = getappdata(fgh,'Axes');

% Clim Chenge
Climdata = getappdata(fgh,'Climh');
torgb = zeros(size(data,1),size(data,2),CH,'Like',uint8(1));
for n = 1:CH
    Ind(n) = sub2ind([1 1 Z T CH],1,1,NowSlice,NowTime,n);
    [x,y] = Bar2patchdata(HistMap(Ind(n)).HistCenter,HistMap(Ind(n)).Hist);
    set(bh(n),'Ydata',y(:),'Xdata',x(:))
    %% imrect chenge
    H = Climdata(n).Handle;
    Posi = getPosition(H);    
    NowClim = HistMap(Ind(n)).Clim;
    Posi(1) = NowClim(1);
    Posi(3) = abs(diff(NowClim));
    setPosition(H,Posi);
    
    %% Image Clim Chnege        
    im = squeeze(double(data(:,:,NowSlice,NowTime,n)));
    im = im - NowClim(1);
    im = uint8(im/(abs(diff(NowClim))) * 255);
    torgb(:,:,n) = im;    
end
RestImage(fgh)
end

%% RestImage
function varargout =  RestImage(fgh)
data = getappdata(fgh,'data');
imh = getappdata(fgh,'imh');
slh = getappdata(fgh,'slh');
HistMap = getappdata(fgh,'HistMap');
axh = getappdata(fgh,'Axes');
NowSlice = uint16(round(get(slh(1),'Value')*get(slh(1),'Userdata'))+1);
NowTime = uint16(round(get(slh(2),'Value')*get(slh(2),'Userdata'))+1);
NowChannels = uint16(get(slh(3),'Userdata'));
Z = get(slh(1),'Userdata') + 1;
T = get(slh(2),'Userdata') + 1;
CH = guidata(slh(3));

Ind = zeros(CH,1);
torgb = zeros(size(data,1),size(data,2),CH,'Like',uint8(1));
for n = 1:CH
    Ind(n) = sub2ind([1 1 Z T CH],1,1,NowSlice,NowTime,n);
    Clim = HistMap(Ind(n)).Clim;
    im = double(data(:,:,NowSlice,NowTime,n));
    im = im - Clim(1);
    im = uint8(im/(Clim(2) - Clim(1)) * 255);
    torgb(:,:,n) = im;clear im
end
if length(NowChannels) == 1
    Image = squeeze(data(:,:,NowSlice,NowTime,NowChannels));
    Ind = Ind(NowChannels);
    X = HistMap(Ind).HistCenter;
    set(axh(2),'Xlim',[-diff(X(1:2))+X(1) X(end)+diff(X(1:2))])
else
    Ind = false(1,CH);Ind(NowChannels) = true;
    torgb(:,:,~Ind) = 0; 
    Image = squeeze(torgb);
    Ind = Ind(NowChannels);
    Min = [];Max = [];
    for n = 1:length(Ind)
        X = HistMap(Ind(n)).HistCenter;
        Min = min([Min -diff(X(1:2))+X(1)]);
        Max = max([Max  X(end)+diff(X(1:2))]);
    end, clear X
    set(axh(2),'Xlim',[Min Max])
end

%% Updata Image
set(imh,'cdata',rgbproj_old(Image));
if nargout==1
    varargout{1} = rgbproj_old(Image);
end

end

 %% Callback Ylim aplly
function Callback_Ylim(oh,~)
fgh = get(oh,'Parent');
uitx_Ylim = getappdata(fgh,'Ylim_text');
Ylim = str2double(get(uitx_Ylim,'String'));
axh = getappdata(fgh,'Axes');
set(axh(2),'Ylim',[0 Ylim])
% Clim Ylimit
Climh = getappdata(fgh,'Climh');
for n = 1:length(Climh)
    Posi = getPosition(Climh(n).Handle);
    Posi(2) = -Ylim*0.1; %% YScale normal
%     Posi(2) = 1; %% YScale log
    Posi(4) = Ylim*1.1 + abs(Posi(2));
    setPosition(Climh(n).Handle,Posi)
end

end

 %% Position ConstrainFcn 
   %% Reset Image
function PositionConstrainFcn_Clim
fgh = gcf;
slh = getappdata(fgh,'slh');
data = getappdata(fgh,'data');
axh = getappdata(fgh,'Axes');
ClimMinh = getappdata(fgh,'ClimMinh');
ClimMaxh = getappdata(fgh,'ClimMaxh');

HistMap = getappdata(fgh,'HistMap');
% znum = size(data,3);
% if isempty(slh)
%     NowSlice = uint8(1);
% else
%     NowSlice = uint16(round(get(slh,'Value')*(znum-1))+1);
% end
% NowSlice = uint16(round(get(slh(1),'Value')*get(slh(1),'Userdata'))+1);
NowSlice = uint16(round(get(slh(1),'Value')*get(slh(1),'Userdata'))+1);
NowTime = uint16(round(get(slh(2),'Value')*get(slh(2),'Userdata'))+1);
NowChannels = uint16(get(slh(3),'Userdata'));
Z = get(slh(1),'Userdata') + 1;
T = get(slh(2),'Userdata') + 1;
CH = guidata(slh(3));
% Image = data(:,:,NowSlice,NowTime,CH);
Climdata = getappdata(fgh,'Climh');
for n = 1:CH
    Ind = sub2ind([1 1 Z T CH],1,1,NowSlice,NowTime,n);
    Posi = getPosition(Climdata(n).Handle);
    SetClim = [Posi(1) Posi(1)+Posi(3)];    
    HistMap(Ind).Clim = SetClim;
end

if length(NowChannels) == 1
    Ind = sub2ind([1 1 Z T CH],1,1,NowSlice,NowTime,NowChannels);
    set(axh(1),'Clim',HistMap(Ind).Clim)
    % % Text 
    set(ClimMinh,'String',HistMap(Ind).Clim(1))
    set(ClimMaxh,'String',HistMap(Ind).Clim(2))
else
%     set(axh(1),'Clim',[1 NowChannels])
end
setappdata(fgh,'HistMap',HistMap);
RestImage(fgh)
end

 %% Callback Clim Apply
function Callback_ClimAplly(oh,~)
fgh = get(oh,'Parent');
slh = getappdata(fgh,'slh');
NowChannels = uint16(get(slh(3),'Userdata'));
Climh = getappdata(fgh,'Climh');

ClimMinh = getappdata(fgh,'ClimMinh');
ClimMaxh = getappdata(fgh,'ClimMaxh');
Posi = getPosition(Climh(NowChannels).Handle);
Posi(1) = str2double(get(ClimMinh,'String'));
Posi(3) = str2double(get(ClimMaxh,'String')) - Posi(1);
setPosition(Climh(NowChannels).Handle,Posi)
end

 %% Callback Clim Global aplly
function Callback_ClimGlobalAplly(oh,~)
Callback_ClimAplly(oh)
fgh = get(oh,'Parent');
slh = getappdata(fgh,'slh');
NowSlice = uint16(round(get(slh(1),'Value')*get(slh(1),'Userdata'))+1);
NowTime = uint16(round(get(slh(2),'Value')*get(slh(2),'Userdata'))+1);
NowChannels = uint16(get(slh(3),'Userdata'));
Z = get(slh(1),'Userdata') + 1;
T = get(slh(2),'Userdata') + 1;
CH = guidata(slh(3));
HistMap = getappdata(fgh,'HistMap');
Ind = sub2ind([1 1 Z T CH],1,1,NowSlice,NowTime,NowChannels);
NowClim = HistMap(Ind).Clim;

Ind = sub2ind([1 1 Z T CH],ones(Z,1),ones(Z,1),(1:Z)',...
    ones(Z,1)*double(NowTime),ones(Z,1)*double(NowChannels));
for n = 1:length(Ind)
    HistMap(Ind(n)).Clim = NowClim;
end

setappdata(fgh,'HistMap',HistMap)
end

 %% Reset Clim
function Callback_ClimReset(oh,~)
fgh = get(oh,'Parent');
HistMap = getappdata(fgh,'HistMap');
for n = 1:length(HistMap)
    HistMap(n).Clim = [HistMap(n).ActualMin HistMap(n).ActualMax];
end
setappdata(fgh,'HistMap',HistMap)
slh = getappdata(fgh,'slh');
Callback_slider(slh(1))
end

%% Delete Func
function Parent_DeleteFcn(oh,~)
        Ch = getappdata(oh,'Children');
        if ~isempty(Ch)
            delete(Ch)
        end        
end

%% Clim editer
%% Callback Add Clim point
function Callback_AddPoint(oh,~)
fgh = get(oh,'Parent');
slh = getappdata(fgh,'slh');set(slh(2),'visible','off');
NowSlice = uint16(round(get(slh(1),'Value')*get(slh(1),'Userdata'))+1);
NowTime = uint16(round(get(slh(2),'Value')*get(slh(2),'Userdata'))+1);
Z = get(slh(1),'Userdata') + 1;
T = get(slh(2),'Userdata') + 1;
CH = guidata(slh(3));

HistMap = getappdata(fgh,'HistMap');

if Z == 1
    return
end

% % Add Point Info.
% ClimMinh = getappdata(fgh,'ClimMinh');
% ClimMaxh = getappdata(fgh,'ClimMaxh');
% Clim_min = str2double(get(ClimMinh,'String'));
% Clim_max = str2double(get(ClimMaxh,'String'));

Pposi = get(fgh,'Position');
Pposi(2) = 30;
Pposi(4) = Pposi(4)/1.5;
Children = getappdata(fgh,'Children');
if isempty(Children)
    %% Make figure for Edit Clim
    Children = figure('Posi',Pposi,...
        'toolbar','none',...
        'Menubar','None',...
        'NumberTitle','off',...
        'Name',['Parent:' num2str(fgh) ' - Clim Editer'],...
        'PaperPosition',[.6 .3 21.9 15.97],...
        'Color','w',...
        'Resize','off',...
        'DeleteFcn',@Children_DeleteFcn);
    setappdata(fgh,'Children',Children)
    
    Maximum = getappdata(fgh,'Maximum');
    Minimum = getappdata(fgh,'Minimum');
    axh = axes('Unit','Normalized',...
        'Position',[0.07 0.2 0.9 0.78]);
    LegendString = [];
    Climdata = getappdata(fgh,'Climh');
    for n = 1:CH
        Ind = sub2ind([1 1 Z T CH],1,1,NowSlice,NowTime,n);
        Clim_max = HistMap(Ind).Clim(2);        
        Clim_min = HistMap(Ind).Clim(1);
        plh_max(n)  = plot(double(NowSlice),Clim_max,'*-.','Color',getColor(Climdata(n).Handle));
        hold on    
        plh_min(n)  = plot(double(NowSlice),Clim_min,'ko-','Color',getColor(Climdata(n).Handle));
        LegendString = cat(1,LegendString,{['Ch' num2str(n) '-Signal']},{['Ch' num2str(n) '-Noise']});
    end
    legend(LegendString,'Location','BestOutside')
    setappdata(Children,'plh_min',plh_min)
    setappdata(Children,'plh_max',plh_max)
    setappdata(Children,'Parent',fgh)
    
    % % Aplly
    uico = uicontrol('Style','pushbutton',...
        'Units','Normalized',...
        'Position',[0.91 0.01 0.08 0.1],...
        'String','Aplly',...
        'Callback',@Callback_ClimEdit);
    uico = uicontrol('Style','popup',...
        'Units','Normalized',...
        'Position',[0.91 0.12 0.08 0.1],...
        'Tag','InterpType',...
        'String',{'linear';'nearest';'pchip';'spline'},...
        'Callback',@Callback_ClimEditview);
    set(uico,'Userdata',Z) %% znum

    grid on    
    xlabel('Slice')
    ylabel('Color limit')
    
    set(axh,'Ylim',[min(Minimum) max(Maximum)])
    set(axh,'Xlim',[1 Z])    
else
    %% Add Point Clim
    plh_min = getappdata(Children,'plh_min');
    plh_max = getappdata(Children,'plh_max');
    for n = 1:CH
        Ind = sub2ind([1 1 Z T CH],1,1,NowSlice,NowTime,n);
        Clim_max = HistMap(Ind).Clim(2);        
        Clim_min = HistMap(Ind).Clim(1);
        clear Ind
        
        Ydata_min = get(plh_min(n),'Ydata');
        Ydata_max = get(plh_max(n),'Ydata');
        Xdata = get(plh_min(n),'Xdata');

        if max(Xdata==NowSlice)
            Ydata_min(Xdata==NowSlice) = Clim_min;
            Ydata_max(Xdata==NowSlice) = Clim_max;
        else
            Xdata = [Xdata NowSlice];
            [Xdata,Ind] = sort(Xdata);
            Ydata_min = [Ydata_min Clim_min];
            Ydata_max = [Ydata_max Clim_max];
            Ydata_min = Ydata_min(Ind);
            Ydata_max = Ydata_max(Ind);
        end
        set(plh_min(n),'Xdata',Xdata,'Ydata',Ydata_min)
        set(plh_max(n),'Xdata',Xdata,'Ydata',Ydata_max)
        clear Xdata Ydata_min Ydata_max Ind
        
    end
end

    function Children_DeleteFcn(oh,~)
        fgh = getappdata(oh,'Parent');
        slh = getappdata(fgh,'slh');
        if get(slh(2),'Userdata')>0
            set(slh(2),'visible','on')
        end
        setappdata(fgh,'Children',[]);
    end

    function Callback_ClimEdit(oh,~)
        Children = get(oh,'Parent');        
        plh_min = getappdata(Children,'plh_min');
        plh_max = getappdata(Children,'plh_max');
        for n_ch = 1:CH        
            Ydata_min = get(plh_min(n_ch),'Ydata');
            Ydata_max = get(plh_max(n_ch),'Ydata');
            Xdata = get(plh_min(n_ch),'Xdata');
            xslice = 1:Z;
            %% Clim Interplotion
            TypeH = findobj('Parent',Children,'Tag','InterpType');
            Type = get(TypeH,'String');
            Type = Type{get(TypeH,'Value')};
            Ydata_min = interp1(Xdata,Ydata_min,xslice,Type);
            Ydata_max = interp1(Xdata,Ydata_max,xslice,Type);
            for n_z = 1:Z
                if or(isnan(Ydata_min(n_z)),isnan(Ydata_max(n_z)))
                    continue
                else
                    Indz = sub2ind([1 1 Z T CH],1,1,n_z,NowTime,n_ch);
                    HistMap(Indz).Clim = [Ydata_min(n_z) Ydata_max(n_z)];
                end
            end
        end
        setappdata(fgh,'HistMap',HistMap)
        delete(Children)
    end

    function Callback_ClimEditview(oh,~)
        TypeH = findobj('Parent',Children,'Tag','InterpType');
            Type = get(TypeH,'String');
            Type = Type{get(TypeH,'Value')};
        for n_ch = 1:CH        
            Ydata_min = get(plh_min(n_ch),'Ydata');
            Ydata_max = get(plh_max(n_ch),'Ydata');
            ploaxes = get(plh_min(n_ch),'Parent');
            Xdata = get(plh_min(n_ch),'Xdata');
            xslice = 1:Z;
            %% Clim Interplotion
            Ydata_min = interp1(Xdata,Ydata_min,xslice,Type);
            Ydata_max = interp1(Xdata,Ydata_max,xslice,Type);
            NewPlot((n_ch-1)*2+1) = plot(xslice,Ydata_min,'k','parent',ploaxes);
            NewPlot(n_ch*2) = plot(xslice,Ydata_max,'k','parent',ploaxes);
        end
        for roopnum = 1:5
            set(NewPlot,'Visible','off')
            pause(.2)
            set(NewPlot,'Visible','on')
            pause(.5)
        end
        delete(NewPlot)
    end
end

%% Callback _ Normalize
function Callback_Normalize(oh,~)
fgh = get(oh,'Parent');
data = getappdata(fgh,'data');
% Out.Input_Original = data;
HistMap = getappdata(fgh,'HistMap');
Clim = cat(1,HistMap.Clim);
ActualMin = cat(1,HistMap.ActualMin);
ActualMax = cat(1,HistMap.ActualMax);
Depth = cat(1,HistMap.Depth);
Time =  cat(1,HistMap.Time);
Channels =  cat(1,HistMap.Channels);


NormalizedImage = zeros(size(data),'like',uint8(1));
for n = 1:length(HistMap)
    indz = HistMap(n).Depth;
    indt = HistMap(n).Time;
    indch = HistMap(n).Channels;
    im = double(data(:,:,indz,indt,indch));
    im = max(im - Clim(n,1),0);
    im = uint8( im /(Clim(n,2) - Clim(n,1)) * 255);
    NormalizedImage(:,:,indz,indt,indch) = im;
    clear im indz indt indch
end
Out.Original = data;
Out.Image = NormalizedImage;
Out.HistMap = HistMap;


xls_matrix = num2cell(cat(2,ActualMin,ActualMax,Clim,Depth,Time,Channels));
STR = cat(2,{'Min'},{'Max'},{'Signal'},{'Noise'},{'Depth(Dim3)'},{'Time(Dim4)'},{'Channels(Dim5)'});
whos xls_matrix STR
A = cat(1,STR,xls_matrix);

InputNewFileName = inputdlg({'FileName:'},'XLSX File Name',1,{'NormalizedMatrix'});
if ~isempty(InputNewFileName)
    try
        xlswrite([InputNewFileName{:} '.xlsx'],A)
    catch err
        disp(err)
    end
end
export2wsdlg({'Output Normalized Image'},{'Normalized_data'},{Out},'To Workspace')        

end

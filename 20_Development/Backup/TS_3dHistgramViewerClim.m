function TS_3dHistgramViewerClim(data)
%% TS_3dHistgramViewerClim(Image)
% 
% <For example...>
% D = load('mri.mat','D');
% TS_3dHistgramViewerClim(squeeze(D))

%% Calucurate Histgram
% BitNum = 256;  %%　諧調数
% Class = 'uint8';
MaximumFreq = 10000;
bar_color = 'b';
Fsiz = 10.5;

Maximum = zeros(size(data,3),1);
Minimum = zeros(size(data,3),1);
HistMap = struct('Hist',[],'HistCenter',[],'BitNum',[],'Clim',[]);

 wh = waitbar(0,'Wait...');
for n = 1:size(data,3)
    im = double(squeeze(data(:,:,n)));
    Minimum(n) = min(im(:));
    Maximum(n) = max(im(:));
    BitNum = max(im(:)) - min(im(:)) + 1;
    if BitNum<2
        BitNum = 256;
    end
%     disp(['Now Slice(z)= ' num2str(n) ', BitNum.:' num2str(BitNum)])
    [h,x] = hist(im(:),BitNum);
    HistMap(n).Hist = h;
    HistMap(n).HistCenter = x;
    HistMap(n).BitNum = BitNum;
    HistMap(n).Clim = [min(im(:)) max(im(:))];
    waitbar(n/size(data,3),wh,'wait...')
    clear im h BitNum
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
    'Name','3D-Histgram Viewer Add Clim',...
    'PaperPosition',[.6 .3 21.9 11.97],...
    'Color','w',...
    'Resize','off',...
    'DeleteFcn',@Parent_DeleteFcn);
% for Image
axh1 = axes('Unit','Normalized',...
    'Position',[0.01 0.06 0.47 0.84]);
imh = imagesc(data(:,:,end));
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
    'String',Maximum(end),...
    'Fontsize',Fsiz);
ClimApplyh = uicontrol('Style','pushbutton',...
    'Units','Normalized',...
    'Position',[0.14 0.94 0.04 0.04],...
    'String','Apply',...
    'Callback',@Callback_ClimAplly,...
    'Fontsize',Fsiz);

setappdata(fgh,'ClimMinh',ClimMinh)
setappdata(fgh,'ClimMaxh',ClimMaxh)

% % Clim Global Apply 
ClimGlobalApplyh = uicontrol('Style','pushbutton',...
    'Units','Normalized',...
    'Position',[0.19 0.94 0.06 0.05],...
    'String','Global',...
    'Callback',@Callback_ClimGlobalAplly,...
    'Fontsize',Fsiz);

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
    'String','Clim Interp',...
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
    'Position',[0.58 0.15 0.4 0.75]);
bh = bar(HistMap(end).HistCenter,HistMap(end).Hist,bar_color);
set(bh,'BarWidth',1)
grid on
X = HistMap(end).HistCenter;
set(axh2,'Xlim',[-0.5+X(1) X(end)+0.5],'Ylim',[0 MaximumFreq],...
    'YLimMode','manual','XLimMode','manual')
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
    'String',['Actual Intensity. Min:' num2str(Minimum(end)) '   Max:' num2str(Maximum(end))],...
    'Fontsize',Fsiz);
%% Clim add
HistMaximum = 10;
for n = 1:length(HistMap)
    HistMaximum = max([HistMap(n).Hist HistMaximum]);
end
set(axh2,'Ylim',[0 HistMaximum])
set(uitx_Ylim,'String',HistMaximum)
Climh = imrect(axh2,[X(1) -HistMaximum*0.1 (X(end)-X(1)) HistMaximum*1.2]) ; %% Rectanglの上と下はサチラセル
setColor(Climh,[1 0 0 ]);
ch = get(Climh,'Children');
a = [1 2 3 4 6 10 13];
set(ch(a),'Visible','off')
addNewPositionCallback(Climh,@(p) PositionConstrainFcn_Clim);

%% Setappdata
setappdata(fgh,'uitx_MaxMin',uitx_MaxMin)
setappdata(fgh,'Maximum',Maximum)
setappdata(fgh,'Minimum',Minimum)
setappdata(fgh,'Ylim_text',uitx_Ylim)
setappdata(fgh,'BarH',bh)
setappdata(fgh,'HistMap',HistMap)
setappdata(fgh,'Axes',[axh1 axh2]);
setappdata(fgh,'Climh',Climh)
%% display

setappdata(fgh,'imh',imh);
setappdata(fgh,'data',data);
znum = size(data,3);
slh = [];
if znum>1
    slh = uicontrol('Style','slider',...
        'Unit','Normalized',...
        'BackgroundColor',[0.5 0.5 0.5],...
        'Position',[0 0 1 0.04],...
        'Value',1,...
        'SliderStep',[1/(znum-1) 10/(znum-1)],...
        'Callback',@Callback_slider);
    txh = uicontrol('Style','text',...
        'unit','Normalized',...
        'Position',[0.95 0.04 0.05 0.03],...
        'String',znum);
    setappdata(fgh,'txh',txh);
end
setappdata(fgh,'slh',slh)
end

function Callback_slider(a,~)
fgh = gcbf;
data = getappdata(fgh,'data');
imh = getappdata(fgh,'imh');
txh = getappdata(fgh,'txh');
znum = size(data,3);
NowSlice = uint16(round(get(a,'Value')*(znum-1))+1);
set(imh,'cdata',data(:,:,NowSlice));
set(txh,'String',num2str(NowSlice))

% Histgram
uitx_MaxMin = getappdata(fgh,'uitx_MaxMin');
Maximum = getappdata(fgh,'Maximum');
Minimum = getappdata(fgh,'Minimum');
bh = getappdata(fgh,'BarH');
HistMap = getappdata(fgh,'HistMap');
axh = getappdata(fgh,'Axes');

set(uitx_MaxMin,'String',...
    ['Actual Intensity. Min.:' num2str(Minimum(NowSlice)) ...
    ' Max.:' num2str(Maximum(NowSlice))]);
set(bh,'Ydata',HistMap(NowSlice).Hist,...
    'Xdata',HistMap(NowSlice).HistCenter)
X = HistMap(NowSlice).HistCenter;
set(axh(2),'Xlim',[-0.5+X(1) X(end)+0.5])

% Clim
Climh = getappdata(fgh,'Climh');
Posi = getPosition(Climh);
NowClim = HistMap(NowSlice).Clim;
Posi(1) = NowClim(1);
Posi(3) = abs(diff(NowClim));
setPosition(Climh,Posi);

end

function Callback_Ylim(oh,~)
fgh = get(oh,'Parent');
uitx_Ylim = getappdata(fgh,'Ylim_text');
Ylim = str2double(get(uitx_Ylim,'String'));
axh = getappdata(fgh,'Axes');
set(axh(2),'Ylim',[0 Ylim])
% Clim Ylimit
Climh = getappdata(fgh,'Climh');
Posi = getPosition(Climh);
Posi(2) = -Ylim*0.1;
Posi(4) = Ylim*1.1 - Posi(2);
setPosition(Climh,Posi)

end

function PositionConstrainFcn_Clim
fgh = gcf;
slh = getappdata(fgh,'slh');
data = getappdata(fgh,'data');
axh = getappdata(fgh,'Axes');
ClimMinh = getappdata(fgh,'ClimMinh');
ClimMaxh = getappdata(fgh,'ClimMaxh');

HistMap = getappdata(fgh,'HistMap');
znum = size(data,3);
if isempty(slh)
    NowSlice = uint8(1);
else
    NowSlice = uint16(round(get(slh,'Value')*(znum-1))+1);
end
Climh = getappdata(fgh,'Climh');
Posi = getPosition(Climh);
SetClim = [Posi(1) Posi(1)+Posi(3)];
set(axh(1),'Clim',SetClim)
HistMap(NowSlice).Clim = SetClim;
setappdata(fgh,'HistMap',HistMap);

% % Tesx 
set(ClimMinh,'String',SetClim(1))
set(ClimMaxh,'String',SetClim(2))
end

function Callback_ClimAplly(oh,~)
fgh = get(oh,'Parent');
Climh = getappdata(fgh,'Climh');
ClimMinh = getappdata(fgh,'ClimMinh');
ClimMaxh = getappdata(fgh,'ClimMaxh');
Posi = getPosition(Climh);
Posi(1) = str2double(get(ClimMinh,'String'));
Posi(3) = str2double(get(ClimMaxh,'String')) - Posi(1);
setPosition(Climh,Posi)
end

function Callback_ClimGlobalAplly(oh,~)
Callback_ClimAplly(oh)
fgh = get(oh,'Parent');
ClimMinh = getappdata(fgh,'ClimMinh');
ClimMaxh = getappdata(fgh,'ClimMaxh');
ClimMin = str2double(get(ClimMinh,'String'));
ClimMax = str2double(get(ClimMaxh,'String'));
HistMap = getappdata(fgh,'HistMap');
for n = 1:length(HistMap)
    HistMap(n).Clim = [ClimMin ClimMax];
end
setappdata(fgh,'HistMap',HistMap)
end

function Callback_ClimReset(oh,~)
fgh = get(oh,'Parent');
HistMap = getappdata(fgh,'HistMap');
Maximum = getappdata(fgh,'Maximum');
Minimum = getappdata(fgh,'Minimum');
for n = 1:length(HistMap)
    HistMap(n).Clim = [Minimum(n) Maximum(n)];
end
setappdata(fgh,'HistMap',HistMap)
Callback_slider(getappdata(fgh,'slh'))
end

function Parent_DeleteFcn(oh,~)
        Ch = getappdata(oh,'Children');
        if ~isempty(Ch)
            delete(Ch)
        end        
end

function Callback_AddPoint(oh,~)
fgh = get(oh,'Parent');
data = getappdata(fgh,'data');
znum = size(data,3);
if znum == 1
    return
end

% % Add Point Info.
ClimMinh = getappdata(fgh,'ClimMinh');
ClimMaxh = getappdata(fgh,'ClimMaxh');
Clim_min = str2double(get(ClimMinh,'String'));
Clim_max = str2double(get(ClimMaxh,'String'));
slh = getappdata(fgh,'slh');
NowSlice = uint16(round(get(slh,'Value')*(znum-1))+1);

Pposi = get(fgh,'Position');
Pposi(2) = 30;
Pposi(4) = Pposi(4)/2;
Ch = getappdata(fgh,'Children');
if isempty(Ch)
    Ch = figure('Posi',Pposi,...
        'toolbar','none',...
        'Menubar','None',...
        'NumberTitle','off',...
        'Name',['Parent:' num2str(fgh) ' - Clim Editer'],...
        'PaperPosition',[.6 .3 21.9 11.97],...
        'Color','w',...
        'Resize','off',...
        'DeleteFcn',@Children_DeleteFcn);
    setappdata(fgh,'Children',Ch)
    
    Maximum = getappdata(fgh,'Maximum');
    Minimum = getappdata(fgh,'Minimum');
    axh = axes('Unit','Normalized',...
        'Position',[0.1 0.2 0.8 0.78]);
       
    plh_max  = plot(NowSlice,Clim_max,'r*-.');
    hold on    
    plh_min  = plot(NowSlice,Clim_min,'ko-');
    
    legend('Clim Max.','Clim Min.')
    setappdata(Ch,'plh_min',plh_min)
    setappdata(Ch,'plh_max',plh_max)
    setappdata(Ch,'Parent',fgh)
    
    % % Aplly
    uico = uicontrol('Style','pushbutton',...
        'Units','Normalized',...
        'Position',[0.91 0.9 0.08 0.1],...
        'String','Aplly',...
        'Callback',@Callback_ClimEdit);
    set(uico,'Userdata',znum) %% znum

    grid on    
    xlabel('Slice')
    ylabel('Color limit')
    
    set(axh,'Ylim',[min(Minimum) max(Maximum)])
    set(axh,'Xlim',[1 znum])    
end

plh_min = getappdata(Ch,'plh_min');
plh_max = getappdata(Ch,'plh_max');
Ydata_min = get(plh_min,'Ydata');
Ydata_max = get(plh_max,'Ydata');
Xdata = get(plh_min,'Xdata');

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
set(plh_min,'Xdata',Xdata,'Ydata',Ydata_min)
set(plh_max,'Xdata',Xdata,'Ydata',Ydata_max)


    function Children_DeleteFcn(oh,~)
        fgh = getappdata(oh,'Parent');
        setappdata(fgh,'Children',[]);
    end

    function Callback_ClimEdit(oh,~)
        Ch = get(oh,'Parent');
        fgh = getappdata(Ch,'Parent');
        HistMap = getappdata(fgh,'HistMap');
        znum = get(oh,'Userdata');
        plh_min = getappdata(Ch,'plh_min');
        plh_max = getappdata(Ch,'plh_max');
        Ydata_min = get(plh_min,'Ydata');
        Ydata_max = get(plh_max,'Ydata');
        Xdata = get(plh_min,'Xdata');
        xslice = 1:znum;
        Ydata_min = interp1(Xdata,Ydata_min,xslice);
        Ydata_max = interp1(Xdata,Ydata_max,xslice);
        for n = 1:znum
            if or(isnan(Ydata_min(n)),isnan(Ydata_max(n)))
                continue
            else
                HistMap(n).Clim = [Ydata_min(n) Ydata_max(n)];
            end
        end
        setappdata(fgh,'HistMap',HistMap)
        delete(Ch)
    end


end

function Callback_Normalize(oh,~)
fgh = get(oh,'Parent');
data = getappdata(fgh,'data');
Out.Input_Original = data;
Out.HistMap = getappdata(fgh,'HistMap');
Clim = cat(1,Out.HistMap.Clim);

NormalizedImage = zeros(size(data),'like',uint8(1));
for n = 1:size(data,3)
    im = double(data(:,:,n));
    im = im - Clim(n,1);
    im = uint8( im /(Clim(n,2) - Clim(n,1)) * 255);
    NormalizedImage(:,:,n) = im;
    clear im
end
Out.NormalizedImage = NormalizedImage;
Out.Signal = Clim(:,2);
Out.Noise = Clim(:,1);

export2wsdlg({'Output Normalized Image'},{'OutPut'},{Out},'To Workspace')
end



































function TS_3dHistgramViewer(data)
%% TS_3dHistgramViewer(Image)
% 
% <For example...>
% load mri
% TS_3dHistgramViewer(squeeze(D))

%% Calucurate Histgram
% BitNum = 256;  %%@æ~’²”
% Class = 'uint8';
MaximumFreq = 10000;
bar_color = 'b';
Fsiz = 10.5;

Maximum = zeros(size(data,3),1);
Minimum = zeros(size(data,3),1);
HistMap = struct('Hist',[],'BitNum',[]);

 wh = waitbar(0,'Wait...');
for n = 1:size(data,3)
    im = double(squeeze(data(:,:,n)));
    Minimum(n) =  0; %min(im(:));
    Maximum(n) = max(im(:));
    BitNum = Maximum(n) - Minimum(n) + 1;
    if and(BitNum == 1,min(im(:))==0)
        BitNum = 256;
    end
    [h,x] = hist(im(:),BitNum);
    HistMap(n).Hist = h;
    HistMap(n).x = x;
    HistMap(n).BitNum = BitNum;
    waitbar(n/size(data,3),wh,'wait...')
    clear im h BitNum
end
close(wh)


%% fgh and Axes
fgh = figure('Posi',[36  307  877  479],...
    'toolbar','figure',...
    'Menubar','None',...
    'Name','3D-Histgram Viewer',...
    'PaperPosition',[.6 .3 21.9 11.97],...
    'Color','w',...
    'Resize','off');
% for Image
axh1 = axes('Unit','Normalized',...
    'Position',[0.01 0.06 0.47 0.93]);
imh = imagesc(data(:,:,end));
axis(axh1,'image','off')
colormap(gray)

% for Histgram
axh2 = axes('Unit','Normalized',...
    'Position',[0.58 0.15 0.4 0.75]);
bh = bar(HistMap(end).x,HistMap(end).Hist,bar_color);
set(bh,'BarWidth',1)
grid on
set(axh2,'Xlim',[-0.5 HistMap(end).BitNum+0.5],'Ylim',[0 MaximumFreq],...
    'YLimMode','manual','XLimMode','manual',...
    'Yscale','log')
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
    'Position',[0.72 0.945 0.25 0.054],...
    'String',['Actual Intensity. Min:' num2str(Minimum(end)) '   Max:' num2str(Maximum(end))],...
    'Fontsize',Fsiz);

setappdata(fgh,'uitx_MaxMin',uitx_MaxMin)
setappdata(fgh,'Maximum',Maximum)
setappdata(fgh,'Minimum',Minimum)
setappdata(fgh,'Ylim_text',uitx_Ylim)
setappdata(fgh,'BarH',bh)
setappdata(fgh,'HistMap',HistMap)
setappdata(fgh,'Axes',[axh1 axh2]);
%% display

setappdata(fgh,'imh',imh);
setappdata(fgh,'data',data);
znum = size(data,3);

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
        'Position',[0 0.04 0.05 0.03],...
        'String',znum);
    setappdata(fgh,'txh',txh);
end
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
    'Xdata',HistMap(NowSlice).x)
set(axh(2),'Xlim',[-.5 HistMap(NowSlice).BitNum+0.5])

end


function Callback_Ylim(oh,~)
fgh = get(oh,'Parent');
uitx_Ylim = getappdata(fgh,'Ylim_text');
Ylim = str2double(get(uitx_Ylim,'String'));
axh = getappdata(fgh,'Axes');
set(axh(2),'Ylim',[0 Ylim])
end

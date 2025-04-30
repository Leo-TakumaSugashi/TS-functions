function xyRePosit_v2016(data)
% マニュアルのXY位置合わせ用　試作品
% dataはxyztまで（3<=ndims(data)<=4）

%%
% if or(ismatrix(data),isvector(data)) || ndims(data)>4
%     errordlg('Inputdataが３次元もしくは４次元データではありません')
%     return
% end

[x, y, z, t, ~, ~] = size(data);

NewPosi = zeros(1,2,z,t); %% NewPosi(:,:,k,time) = [Y位置ズレ，X位置ズレ] ・・・time時間目のkマイ目の情報

figColor = [.8 .8 .8];
fghPosi = [100 30 850 900];
slwidth = 20;
MenuHigh = 70;
fgh = figure('Posi',fghPosi,'NumberTitle','off','Color',figColor,...
    'Name','xyRePosit','Menubar','none','Toolbar','figure','Color',[.1 .1 .1],...
    'WindowKeyPressFcn',@KeyPressFcn);

slh(1) = uicontrol('Parent',fgh,'Tag','TimeSlider','Position',[1 1 fghPosi(3)-2-slwidth slwidth]);
slh(2) = uicontrol('Parent',fgh,'Tag','SliceSlider','Position',[2+fghPosi(3)-slwidth slwidth+1 slwidth fghPosi(4)-2-slwidth-MenuHigh]);
set(slh,'Style','Slider','Visible','on','Units','Normalized','Callback',@CallbackSlider,...
    'Foregroundcolor',[1 1 1],'BackgroundColor',get(fgh,'color'));

axh = axes('Parent',fgh,'Units','Pixels','Position',[1 slwidth+3 fghPosi(3)-slwidth-3 fghPosi(4)-slwidth-3-MenuHigh]);
set(axh,'Units','Normalized','Visible','on','ydir','reverse')
imagesc('Parent',axh,'Cdata',squeeze(data(:,:,1,1)),'Tag','ImageH');
axis(axh,'image','off')

SliderSetUp(slh,z,t)

%% Menu
% 開始ボタン
StartButH = uicontrol('Parent',fgh,'Position',[5 20+fghPosi(4)-MenuHigh 150 35],'String','Start',...
    'Callback',@Callback_Start,'userdata',true,'Tag','StartButtom','FontSize',12);

% RePosit X and Y
PMh(1) = uicontrol('Parent',fgh,'Position',[160 30+fghPosi(4)-MenuHigh 70 20],'String','(axis X) -1',...
    'Callback',@Callback_PM,'userdata',[2 1]);  % Plus Minus handle
PMh(2) = uicontrol('Parent',fgh,'Position',[230 30+fghPosi(4)-MenuHigh 70 20],'String','+1 (axis X)',...
    'Callback',@Callback_PM,'userdata',[2 -1]);   % Userdata = [Dimension ±]
PMh(3) = uicontrol('Parent',fgh,'Position',[160 5+fghPosi(4)-MenuHigh 70 20],'String','(axis Y) -1',...
    'Callback',@Callback_PM,'userdata',[1 -1]);
PMh(4) = uicontrol('Parent',fgh,'Position',[230 5+fghPosi(4)-MenuHigh 70 20],'String','+1 (axis Y)',...
    'Callback',@Callback_PM,'userdata',[1 1]);
PMh(5) = uicontrol('Parent',fgh,'Position',[300 30+fghPosi(4)-MenuHigh 70 20],'String','(axis X) -5',...
    'Callback',@Callback_PM,'userdata',[2 5]);  % Plus Minus handle
PMh(6) = uicontrol('Parent',fgh,'Position',[370 30+fghPosi(4)-MenuHigh 70 20],'String','+5 (axis X)',...
    'Callback',@Callback_PM,'userdata',[2 -5]);   % Userdata = [Dimension ±]
PMh(7) = uicontrol('Parent',fgh,'Position',[300 5+fghPosi(4)-MenuHigh 70 20],'String','(axis Y) -5',...
    'Callback',@Callback_PM,'userdata',[1 -5]);
PMh(8) = uicontrol('Parent',fgh,'Position',[370 5+fghPosi(4)-MenuHigh 70 20],'String','+5 (axis Y)',...
    'Callback',@Callback_PM,'userdata',[1 5]);
PMh(9) = uicontrol('Parent',fgh,'Position',[440 20+fghPosi(4)-MenuHigh 190 25],'String','[X Y]',...
    'Tag','NowRePosition','FontSize',15,'Style','text');

NowZ = uicontrol('Parent',fgh,'Position',[630 25+fghPosi(4)-MenuHigh 170 25],'String',['Now Slice is 1/' num2str(z)],...
    'Tag','NowZdisp');
NowT = uicontrol('Parent',fgh,'Position',[630 fghPosi(4)-MenuHigh 170 25],'String',['Now Time  is 1/' num2str(t)],...
    'Tag','NowTdisp');


set([NowZ NowT],'Style','Text','FontSize',14,'FontWeight','demi')
set([StartButH PMh NowT NowZ],'Units','Normalized','Foregroundcolor',[1 1 1],'BackgroundColor',get(fgh,'color'))
set(PMh,'Visible','off','KeyPressFcn',@KeyPressFcn)

%% Uimenu
uimh = uimenu('parent',fgh,'Label','File');
    uimenu('Parent',uimh,'Label','save','Callback',@Callback_Save);
uimh = uimenu('parent',fgh,'Label','AoutRePosit');
    uimenu(uimh,'Label','Estimate','Callback',@Callback_AutoReposit);
ROIh = uimenu(fgh,'Label','ROI');
    ROIlabel = cat(1,{'Rectangle','Ellipse','Polygon',' Line','Point'},...
        {'imrect' , 'imellipse' , 'impoly' , 'imline' , 'impoint'});
    for n = 1:size(ROIlabel,2)
        uimenu(ROIh,'Label',ROIlabel{1,n},'Userdata',ROIlabel{2,n},...
            'Callback',@Callback_ROI)
    end
    uimenu(ROIh,'Label','ROIview','Callback',@Callback_ROIMeanIntensityView)
Filth = uimenu(fgh,'Label','Filter');
    uimenu(Filth,'label','WienerFilter','Userdata','wiener2','Callback',@Callback_Filt)
    uimenu(Filth,'label','MedianFilter','Userdata','medfilt2','Callback',@Callback_Filt)
%% Setappdata
setappdata(fgh,'data',data)
setappdata(fgh,'Size',[x y z t])
setappdata(fgh,'RePosition',NewPosi)
setappdata(fgh,'PMh',PMh)
setappdata(fgh,'NowROidata',[])
setappdata(fgh,'OriginalImage',data)


colormap(gray(256))
end

function SliderSetUp(slh,Z,T)
    if T>1 , set(slh(1),'Callback',@CallbackSlider,'SliderStep',[1/(T-1) 10/(T-1)],...
            'Value',0,'userdata',T-1,'visible','on')
    else set(slh(1),'visible','off')
    end
    if Z>1 ,  set(slh(2),'Callback',@CallbackSlider,'SliderStep',[1/(Z-1) 10/(Z-1)],...
            'Value',0,'userdata',Z-1,'visible','on')
    else  set(slh(2),'visible','off')
    end
end

function CallbackSlider(~,~)
fgh = gcbf;
StartButH = findobj('Parent',fgh,'Tag','StartButtom');
TFcolor = get(StartButH,'userdata');
imh = findobj('Parent',findobj('parent',fgh,'Type','axes'),'Tag','ImageH');
data = getappdata(fgh,'data');
siz = getappdata(fgh,'Size');
set(findobj('Parent',fgh,'Tag','NowZdisp'),'String',['Now Slice is ' num2str(GetSliceNow) '/' num2str(siz(3))])
set(findobj('Parent',fgh,'Tag','NowTdisp'),'String',['Now Time  is ' num2str(GetTimeNow) '/' num2str(siz(4))])
if TFcolor
    data = squeeze(data(:,:,GetSliceNow,GetTimeNow));
else
    Template = getappdata(fgh,'Template');
    NowImage = GetNowImage(fgh,squeeze(data(:,:,GetSliceNow,GetTimeNow)),GetSliceNow,GetTimeNow);
    % 改変　Binarized　Image
%     Threshold = .2;
%     NowImage.Image = double(NowImage.Image);
%     NowImage.Image = NowImage.Image >= max(NowImage.Image(:))*Threshold;
%     Template = double(Template);
%     Template = Template >= max(Template(:))*Threshold;
%     Add = sum(sum(and(NowImage.Image,Template)))/sum(Template(:))*100;
    Add = corr2(Template,NowImage.Image);
%         disp(Add)
    % 改変終
    
    data = double(cat(3,Template,NowImage.Image,zeros(size(NowImage.Image))));
    data = data/max(data(:));
    NowReposih = findobj('parent',fgh,'Tag','NowRePosition');
    TemplateZT = getappdata(fgh,'TemplateZT');
    if and(TemplateZT(1)==GetSliceNow,TemplateZT(2)==GetTimeNow)
        set(NowReposih,'String','This is Template')
    else
        set(NowReposih,'String',['[' num2str(NowImage.RePosi(1)) ' ' num2str(-1*NowImage.RePosi(2)) '] ' num2str(Add)])        
    end
end
set(imh,'Cdata',data)
ViewROI(fgh)
end

function A = GetSliceNow
slh = findobj('Parent',gcf,'Tag','SliceSlider');
if isempty(get(slh,'userdata'))
    A = uint32(1);
else
    A = uint32(get(slh,'value')*get(slh,'userdata')+1);
end
end

function A = GetTimeNow
tmh = findobj('Parent',gcf,'Tag','TimeSlider');
if isempty(get(tmh,'userdata'))
    A = uint32(1);
else
    A = uint32(get(tmh,'value')*get(tmh,'userdata')+1);
end
end


%% Callback_Start
function Callback_Start(oh,~)
fgh = gcbf;
TFstart = get(oh,'userdata');
if TFstart
    set(oh,'userdata',false,'String',['Template is data(:,:,' num2str(GetSliceNow) ',' num2str(GetTimeNow) ')'],...
        'Style','text')
    data = getappdata(fgh,'data');
    setappdata(fgh,'Template',squeeze(data(:,:,GetSliceNow,GetTimeNow)))
    setappdata(fgh,'TemplateZT',[GetSliceNow GetTimeNow])
    set(getappdata(fgh,'PMh'),'visible','on')
    CallbackSlider
else
    return
end
end

%% Callback Plus or Minus
function Callback_PM(oh,~)
fgh = gcbf;
TemplateZT = getappdata(fgh,'TemplateZT');
if and(TemplateZT(1)==GetSliceNow,TemplateZT(2)==GetTimeNow)
    return
else
    p = get(oh,'userdata');
    NewPosi = getappdata(fgh,'RePosition');
    NewPosi(1,p(1),GetSliceNow,GetTimeNow) = NewPosi(1,p(1),GetSliceNow,GetTimeNow) + p(2);
    setappdata(fgh,'RePosition',NewPosi);
    CallbackSlider
end
end

function A = GetNowImage(fgh,data,NowZ,NowT)

NewPosi = getappdata(fgh,'RePosition');
if isempty(NewPosi)
    NewPosi = [0 0];
end
NewPosi = NewPosi(:,:,NowZ,NowT);

[y x] = size(data);
data = padarray(data,abs(NewPosi),0);
if NewPosi(1)<=0
    Ys = uint32(1);
else
    Ys = uint32(2*NewPosi(1)+1);
end

if NewPosi(2)<=0
    Xs = uint32(1);
else
    Xs = uint32(2*NewPosi(2)+1);
end

A.Image = data(Ys:Ys+y-1,Xs:Xs+x-1);
A.RePosi = NewPosi;
end

%% Save
function Callback_Save(~,~)
fgh = gcbf;
OriginalData = getappdata(fgh,'data');
Reposit = getappdata(fgh,'RePosition');
Newdata = GetRepositImage(fgh);
data.OriginalImage = OriginalData;
data.RePositImage = Newdata;
data.RePositInf = Reposit;
data.Template = getappdata(fgh,'Template');

data = {data};
checklabels = {'Save applied image to variable name;'};
varName = {'data'};
export2wsdlg(checklabels,varName,data,'Save data to Workspace')


end

function Newdata = GetRepositImage(fgh)
OriginalData = getappdata(fgh,'data');
if islogical(OriginalData)
    Newdata = false(size(OriginalData));
else
    Newdata = zeros(size(OriginalData),class(OriginalData));
end
for k = 1:size(OriginalData,3)
    for t = 1:size(OriginalData,4)
        Image = GetNowImage(fgh,squeeze(OriginalData(:,:,k,t)),k,t);
        Newdata(:,:,k,t) = Image.Image;
        clear Image
    end
end
end

%% Aout Reposit
function Callback_AutoReposit(~,~)
fgh = gcbf;
Template = getappdata(fgh,'Template');
if isempty(Template)
    msgbox('Template を指定してください');
    return
end

Input  = inputdlg({'最大移動幅(高さ)'},'Aout Reposit',1,{'10'});
if ~isempty(Input)
    len = str2double(Input{1});
    if isnan(len)
        return
    end
else   
    return
end
A = TS_Corr2(Template,getappdata(fgh,'data'),len);
setappdata(fgh,'RePosition',A.RePositInf)

end

%% KeyPressFcn
function KeyPressFcn(~,ob)
fgh = gcf;
slh(1) = findobj('Parent',fgh,'Tag','SliceSlider');
slh(2) = findobj('Parent',fgh,'Tag','TimeSlider');

Type = ob.Key;
switch Type
    case {'w','d'}
        pm = 1;
    case {'s','a'}
        pm = -1;
    otherwise
        return
end
switch Type
    case {'w','s'}
        slh = slh(1);
    case {'a','d'}
        slh = slh(2);
    otherwise
        return
end
slstep = get(slh,'SliderStep');
val = get(slh,'value')+slstep(1)*pm;
if val>1
    val = 1;
end
if val < 0
    val = 0;
end
set(slh,'value',val)
CallbackSlider
end

%% ROIclass

function Callback_ROI(oh,~)
fgh = gcbf;
DrawROI(fgh,oh,[],[],[],[]);
end

function DrawROI(fgh,oh,type,Posi,Depth,Time)
ViewerType = 'xy';
axh = findobj('Parent',fgh,'type','axes');
ROIdata = getappdata(fgh,'NowROIdata');
ROINUM = [];
if isempty(ROIdata)
   ROINUM = 1;
else
    for i = 1:size(ROIdata,2)
        if ~ROIdata(i).existTF
            ROINUM = i;
            break
        end
    end
    if isempty(ROINUM)
        ROINUM = size(ROIdata,2) + 1;
    end
end
if ~isempty(oh)
    h = feval(get(oh,'Userdata'),axh);
else
    h = feval(type,axh,Posi);
end
Cdata = get(findobj('Parent',axh,'type','image'),'Cdata');
Xlimt = [.5 size(Cdata,2)+.5];
Ylimt = [.5 size(Cdata,1)+.5];
fcn = makeConstrainToRectFcn(class(h),Xlimt,Ylimt);
setPositionConstraintFcn(h,fcn);
addNewPositionCallback(h,@(p) MotionROI);
ch = get(h,'Children');
ph = get(ch(1),'Parent');
data = struct('NUM',ROINUM,'Name',['ROI ' num2str(ROINUM)],'handle',h,'hNUM',ph);
data.ROIplane = ViewerType;
posi = getPosition(h);
[Py,b] = min(posi(:,1));
Px     = posi(uint32(b(1)),2);
textH = text('Parent',get(h,'parent'),'STring',data.Name,...
    'Color',getColor(h),'Position',[Py Px-1],...
    'Fontsize',12,'FontWeight','demi');
data.textH = textH;
data.Lineobh = [];
NowImage = getappdata(fgh,'data');

if isempty(oh)
    data.Depth = Depth;
    data.Time = Time;
else
    data.Depth = [1 size(NowImage,3)];
    data.Time = [1 size(NowImage,4)];
end
set(h,'userdata',data)
ROIdata(ROINUM).handle = h;
ROIdata(ROINUM).Lineobh = [];
ROIdata(ROINUM).existTF = true;
ROIdata(ROINUM).class = class(h);
ROIdata(ROINUM).Position = [];
ROIdata(ROINUM).Plane = ViewerType;
ROIdata(ROINUM).Depth = data.Depth;
ROIdata(ROINUM).Time = data.Time;
ROIdata(ROINUM).Width = [];
ROIdata(ROINUM).High  = [];
    
setappdata(fgh,'NowROIdata',ROIdata);
menuH = get(get(ph,'children'),'uicontextmenu');
menuH = menuH{1};
if isempty(menuH)
    menuH = get(h,'UIcontextmenu');
end
delch = get(menuH,'Children');
delete(findobj(delch,'label','色の設定'))
uimenu(menuH,'Label','色の設定',  'Callback',@CallbackChangeROIColor);
uimenu(menuH,'Label','Depth_Range','Callback',@CallbackDepthROI,'userdata',3);
uimenu(menuH,'Label','Time_Range','Callback',@CallbackDepthROI,'userdata',4);
if max(strcmpi(class(h),{'imrect','imellipse'}))
    uimenu(menuH,'Label','Width','Callback',@CallbackROIrange,'userdata',3);
    uimenu(menuH,'Label','High','Callback',@CallbackROIrange,'userdata',4);
end
uimenu(menuH,'Label','Mask2delete','Callback',@Callback_Mask2Delete)
uimenu(menuH,'Label',['Name : ROI ' num2str(ROINUM)] )
uimenu(menuH,'Label','ROIの削除', 'Callback',@CallbackDeleteROI);

% add field
data.ROIclass = class(h);
data.Position = [];

set(get(h,'children'),'UIcontextMenu',menuH,'userdata',data)

end

function MotionROI
fgh = gcf;
data = get(gco,'userdata');
if isempty(data)
    return
end

h = data.handle;
posi = getPosition(h);
[Py,b] = min(posi(:,1));
Px = posi(uint32(b(1)),2);
if strcmpi(class(h),{'imline'})
    ROINUM = str2double(data.Name(5:end));
    STR = num2str(GetROILength(fgh,ROINUM));
    if length(STR)>5
        STR = STR(1:5);
    end
    set(data.textH,'Posi',[Py Px-3],'color',getColor(h),'String',['  ' STR 'um'])
%     set(data.textH,'FontUnits','centimeters')
%     posi = get(data.textH,'Position');
%     set(data.textH,'position',[posi(1) posi(2)-4]);
%     set(data.textH,'FontUnits','Pixels')
%     set(data.textH,'Posi',[Py Px-5],'color',getColor(h),'String',data.Name)
else
    set(data.textH,'Posi',[Py Px-3],'color',getColor(h),'String',data.Name)
end


%% Draw ROI data
if ~isempty(findobj('Tag',['ROIview' num2str(fgh)]))
    ROIdata = getappdata(fgh,'NowROIdata');
    Lineobh = ROIdata(data.NUM).Lineobh;
    data = get(ROIdata(data.NUM).handle,'userdata');
    if ~isempty(Lineobh)
        Time = data.Time;
        A = GetROImeanIntensity(fgh,h,GetSliceNow,Time,1);
        A = A(:,GetSliceNow,1);
        set(Lineobh,'Ydata',A)
    end
    set(h,'userdata',data)
end
end

function varargout= GetROILength(fgh,ROINUM)
nargoutchk(0,1)
ROIdata = getappdata(fgh,'NowROIdata');
Resolution = getappdata(fgh,'Resolution');
h = ROIdata(ROINUM).handle;
if isempty(h)
    return
end
posi = getPosition(h);
x = posi(:,1);
y = posi(:,2);
MaxX = max(x);
MinX = min(x);
MaxY = max(y);
MinY = min(y);
Len = sqrt(((MaxX-MinX)*Resolution(1))^2+((MaxY-MinY)*Resolution(2))^2);
if nargout==0
    disp([num2str(Len) ' μｍ'])
elseif nargout==1
    varargout{1} = Len;
end
end

function CallbackDepthROI(oh,~)
fgh = gcbf;
handle = gco;
DIM = get(oh,'Userdata');
Image = getappdata(fgh,'data');
NowImageSiz = size(Image);
if NowImageSiz(DIM) >= 2
    x = uint32(NowImageSiz(DIM));
else
    x = uint32(1);
end

handle = get(handle,'userdata');
handle = handle.handle;
Depth = get(handle,'userdata');
if DIM==3
    Depth = Depth.Depth;
else
    Depth = Depth.Time;
end
Depth = inputdlg({[get(oh,'label') ' Low'];[ get(oh,'label') ' high']},...
    get(oh,'Label'),1,{num2str(Depth(1)); num2str(Depth(end))});
%             'Input for Depth',1,{num2str(GetSliceNow); num2str(GetSliceNow)});
            
if isempty(Depth)
    return
else
%     Depth = cell2mat(Depth)
    for i = 1:2
        Depth{i} = uint32(str2double(Depth{i}));
    end
    Depth = cell2mat(Depth);
    
    if Depth==0
        errordlg('値がおかしいです')
        return
    else
        
        data = get(handle,'userdata');
        if DIM==3
            data.Depth = GetTorF(Depth,x);
        else
            data.Time = GetTorF(Depth,x);
        end
        set(handle,'userdata',data)
    end    
end
    function A = GetTorF(Depth,z)
        if Depth(1)>Depth(2)
            Depth = flipdim(Depth,1); % sort(Depth)
        end
        if Depth(1)<1
            Depth(1) = uint32(1);
        elseif Depth(2)>z
            Depth(2) = uint32(z);
        end
        A =reshape(Depth,[1 2]); 
    end
end

function CallbackROIrange(oh,~)
handle = get(gco,'Userdata');
handle = handle.handle;
posi = getPosition(handle);
Label = get(oh,'Label');
defstr = num2str(posi(get(oh,'userdata')));
Input = inputdlg(Label,['Set ' Label],1,{defstr});
if isempty(Input)
    return
end
Input = str2double(Input{1});
posi(get(oh,'userdata')) = Input;
setPosition(handle,posi)
end

function Callback_Mask2Delete(~,~)
oh  = gco;
fgh = gcbf;
Userdata = get(oh,'Userdata');
h = Userdata.handle;
Mask = ~createMask(h);
Depth = Userdata.Depth;
Time = Userdata.Time;
Image = getappdata(fgh,'data');
ImageClass = class(Image);
Mask = feval(ImageClass,Mask);
for t = Time(1):Time(end)
    for k = Depth(1):Depth(end)
        Image(:,:,k,t) = Image(:,:,k,t).*Mask;
    end
end
TempZT = getappdata(fgh,'TemplateZT');
setappdata(fgh,'Template',squeeze(Image(:,:,TempZT(1),TempZT(2))))
setappdata(fgh,'data',Image);
CallbackSlider
end

function CallbackDeleteROI(~,~)
fgh = gcbf;
data = get(gco,'userdata');
for i = 1:size(data,2)
    delete(data(i).hNUM)
    delete(data(i).textH)
    if ~isempty(data(i).Lineobh)
        delete(data(i).Lineobh)
        data(i).Lineobh = [];
    end
    % delete(data(i).handle)
end
NUM = data.NUM;
ROIdata = getappdata(fgh,'NowROIdata');
ROIdata(NUM).handle = [];
ROIdata(NUM).existTF = false;
ROIdata(NUM).Lineobh = [];
setappdata(fgh,'NowROIdata',ROIdata)
end

function CallbackChangeROIColor(~,~)
data = get(gco,'userdata');
nC = uisetcolor(getColor(data(1).handle));
if nC == 0
    return
end
for i = 1:size(data,2)
    setColor(data(i).handle,nC)
    set(data(i).textH,'Color',nC)
    if ~isempty(data(i).Lineobh)
        set(data(i).Lineobh,'Color',nC)
    end
end
end

function ViewROI(fgh)
ROIdata = getappdata(fgh,'NowROIdata');
ViewerType = 'xy';
slicenow = GetSliceNow;
timenow =GetTimeNow;
for i = 1:size(ROIdata,2)
    h = ROIdata(i).handle;
    if ~isempty(h) 
        data = get(h,'userdata');
        if strcmpi(ViewerType,data.ROIplane)
            textH = data.textH;
            Depth = data.Depth;
            Time = data.Time;
            if and(and(slicenow<=Depth(end),slicenow>=Depth(1)),and(timenow<=Time(end),timenow>=Time(1)))
                set(h,'visible','on')
                set(textH,'visible','on')
            else
                set(h,'visible','off')
                set(textH,'visible','off')
            end
        end
    end
end
end

function Callback_ROIMeanIntensityView(~,~)
fgh = gcbf;
ROIdata = getappdata(fgh,'NowROIdata');
if isempty(ROIdata)
    return
end
viewfig = findobj('Tag',['ROIview' num2str(fgh)]);
if isempty(viewfig)
    viewfig = figure('Menubar','none','NumberTitle','off','Name','ROI Mean Intesnsity View',...
        'Tag',['ROIview' num2str(fgh)]);
    axh = axes('Parent',viewfig,'Position',[.05 .05 .93 .93]);
    grid on
    hold(axh,'on')
    InputCh = 1;
    for n = 1:size(ROIdata,2)
        h = ROIdata(n).handle;
        if ~isempty(h)
            Userdata = get(h,'Userdata');
            Time = Userdata.Time;
            A = GetROImeanIntensity(fgh,h,GetSliceNow,Time,InputCh);
            A = A(:,GetSliceNow,InputCh);
            oh = plot(A,'color',getColor(h),'LineWidth',3);
            ROIdata(n).Lineobh = oh;
            setappdata(fgh,'NowROIdata',ROIdata)
            clear Userdata Time A oh Ph ch
        end
        clear h
    end
else
    return
end
end

function A = GetROImeanIntensity(fgh,h,Depth,Time,chNUM)
Image = GetRepositImage(fgh);
Mask = createMask(h);
A = NaN(size(Image,4),size(Image,3),size(Image,5));
for chn = chNUM(1):chNUM(end)
    for k = Depth(1):Depth(end)
        for t = Time(1):Time(end)
            im = squeeze(Image(:,:,k,t,chn));
            A(t,k,chn) = mean(im(Mask));
        end
    end
end
end

%% Filer
function Callback_Filt(oh,~)
fgh = gcbf;
Image = getappdata(fgh,'data');

InputMN = inputdlg({'Size X','Size Y'},'Input FilterSize',1,{'3','3'});
if isempty(InputMN)
    return
else
    MN(1) = str2double(InputMN{1,1});
    MN(2) = str2double(InputMN{2,1});
end

Image = padarray(Image,MN,'symmetric');
if islogical(Image)
    A = false(size(Image));
else
    A = zeros(size(Image),class(Image));
end

cEnd = size(Image,5)*size(Image,4)*size(Image,3);
c = 1;
wh = waitbar(0,'Filter');
for chNum = 1:size(Image,5)
    for t = 1:size(Image,4)
        for k = 1:size(Image,3)
            A(:,:,k,t,chNum) = feval(get(oh,'Userdata'),Image(:,:,k,t,chNum),MN);
            waitbar(c/cEnd,wh,['Filter...' num2str(c) '/' num2str(cEnd)])
            c = c + 1;
        end
    end
end
close(wh)
A = A(MN(1)+1:end-MN(1),MN(2)+1:end-MN(2),:,:,:);
setappdata(fgh,'data',A)
CallbackSlider
end
















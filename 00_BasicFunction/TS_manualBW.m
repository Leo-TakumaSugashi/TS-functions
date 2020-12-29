function bw = TS_manualBW(Image,varargin)


%% Input is Only 2D image
if ~ismatrix(Image)
    disp(['Error Msg.: ' mfilename])
    error(['Input is NOT Matrix data.  ' mfilename('fullpath')])
end

%% siz = size(Imgae)
siz = size(Image);

%% Alpha
Alpha = 0.5;

%% fgh = figure;----> close(fgh) and, output data.
fgh = figure('Position',[50 70 950 750],...
    'Menubar','none',...
    'Toolbar','figure');
set(fgh,'KeyPressFcn',@KeyPressFcn);
setappdata(fgh,'OriginalImage',Image)
setappdata(fgh,'Alpha',Alpha)

% % Axes
axh = axes('Position',[.005 .05 .9 .9]);
imh = imagesc(Image);
axis(axh,'image')

% % bw ON or Off uitext
uih_bwonoff = uicontrol(fgh,...
    'unit','normalized',...
    'Position',[.93 .85 .06 .04],...
    'BackgroundColor',[.5 .5 .5],...
    'Style','togglebutton',...
    'String','OFF',...
    'Callback',@Callback_bwonoff);
setappdata(fgh,'uih_bwonoff',uih_bwonoff)
% % Uipanel
uiph = uipanel('Title','True or False','fontsize',9,...
    'Position',[.9 .92 .1 .07]);
h = uibuttongroup('parent',uiph,'visible','off','Position',[0 0 1 1]);
u_ture = uicontrol('Parent',h,'Style','radiobutton','String','True',...
    'unit','normalized','Position',[0 0 1 .45]);
u_false = uicontrol('Parent',h,'Style','radiobutton','String','False',...
    'unit','normalized','Position',[.52 0 1 .45]);
% Initialaize
set(h,'SelectionChangeFcn',@selcbk);
set(h,'SelectedObject',[]);% No selection
set(h,'Visible','on')
    function selcbk(oh,event)
        STR = get(event.NewValue,'String');
        switch STR
            case 'True'
                setappdata(gcf,'TrueFalse',true)
            case 'False'
                setappdata(gcf,'TrueFalse',false)
        end
    end
setappdata(fgh,'TrueFalse',[]);
setappdata(fgh,'uiph',uiph)

%% h = imellipse
h = imellipse(axh,[siz(2)/2 siz(1)/2 siz(2)/10 siz(1)/10]);
setappdata(fgh,'handle',h);
% setPositionConstrainFcn(h,@PositionConstrainFcn_bw);
addNewPositionCallback(h,@(p) PositionConstrainFcn_bw);

%% setappdata, Image and bw
if nargin==1
    bw = Image > max(Image(:)) * 0.5; %% zantei!!
elseif nargin==2
    bw = varargin{1};
end
Image = double(Image) - double(min(double(Image(:))));
Image = Image ./ max(Image(:));
setappdata(fgh,'Image',Image);
setappdata(fgh,'bw',bw);
setappdata(fgh,'imh',imh)
%% Create Image

Image = OutputImageRGB(Image,bw);
set(imh,'Cdata',Image)

%% output bw data
% waitfor(fgh)
end

function Callback_bwonoff(oh,~)
val = get(oh,'Value');
if val == 1
    set(oh,'String','ON',...
        'BackgroundColor',[.9 .9 .9])
else
    set(oh,'String','OFF',...
        'BackgroundColor',[.5 .5 .5])
end

end

function PositionConstrainFcn_bw
fgh = gcf;
h = getappdata(fgh,'handle');
uih_bwonoff = getappdata(fgh,'uih_bwonoff');
val = get(uih_bwonoff,'Value');
if val==0
    return
else
    Image = getappdata(fgh,'Image');
    bw = getappdata(fgh,'bw');
    roi_bw = createMask(h);
    TF = getappdata(fgh,'TrueFalse');
    if isempty(TF)
        return
    elseif TF
        bw = or(bw,roi_bw);
    else
        bw = and(bw,~roi_bw);
    end
    imh = getappdata(fgh,'imh');
    outImage = OutputImageRGB(Image,bw);
    set(imh,'Cdata',outImage)
    drawnow
    setappdata(fgh,'bw',bw)
end
end

function outImage = OutputImageRGB(Image,bw)
Red = Image;
Alpha = getappdata(gcf,'Alpha');
Red(bw) = Alpha;
outImage = cat(3,Red,Image.*double(~bw),Image.*double(~bw));
% outImage = cat(3,Red,Image,Image);
end

function KeyPressFcn(fgh,ob)
if or(isempty(fgh),~isstruct(ob))
    return
end
Type = ob.Key;
uih_bwonoff = getappdata(fgh,'uih_bwonoff');
switch Type
    case {'space'}
        val = get(uih_bwonoff,'Value');
        if val == 1
            set(uih_bwonoff,'Value',0)
%             set(uih_bwonoff,'String','ON',...
%                 'BackgroundColor',[.9 .9 .9])
        else
            set(uih_bwonoff,'Value',1)
%             set(uih_bwonoff,'String','OFF',...
%                 'BackgroundColor',[.5 .5 .5])
        end
        Callback_bwonoff(uih_bwonoff)
        
    case {'s','a'}
        pm = -1;
    otherwise
        return
end

end


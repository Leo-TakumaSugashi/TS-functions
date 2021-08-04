function varargout = TS_manualBW3d(Image,varargin)


% %% Input is Only 2D image
% if ~ismatrix(Image)
%     disp(['Error Msg.: ' mfilename])
%     error(['Input is NOT Matrix data.  ' mfilename('fullpath')])
% end

%% siz = size(Imgae)
siz = size(Image);

if ~strcmpi(class(Image),'uint8')
    Image = TS_Image2uint8(Image);
end
    

%% Alpha
alp = 0.6;
Alpha = uint8(alp *255);

%% fgh = figure;----> close(fgh) and, output data.
savefgh = figure('visible','off');
setappdata(savefgh,'OriginalImage',Image)
setappdata(savefgh,'Alpha',Alpha)

%% setappdata, Image and bw
if nargin==1
    bw = Image > max(Image(:)) * 0.5; %% Enya! lol,,,...
elseif nargin==2
    bw = varargin{1};
elseif nargin>2
    error('Too more Input...')
end
if ~islogical(bw)
    error('Input BW data is NOT logcial')
end
% Image = double(Image) - double(min(double(Image(:))));
% Image = Image ./ max(Image(:));
if strcmpi(class(Image),'uint8')
    Image = TS_Image2uint8(Image);
end

setappdata(savefgh,'Image',Image);
setappdata(savefgh,'bw',bw);

%% Control figure
fgh = figure('Position',[50 70 950 750],...
    'Menubar','none',...
    'Toolbar','figure',...
    'KeyPressFcn',@KeyPressFcn,...
    'DeleteFcn',@Delete_fgh);
    function Delete_fgh(fgh,event)
        savefgh = getappdata(fgh,'savefgh');
        delete(savefgh);
        delete(fgh)
    end
setappdata(fgh,'savefgh',savefgh)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% uimenu(fgh,'Label','File')
% uimenu(fgh,'Label','Edit')
% uimenu(fgh,'Label','Image Processing')
% uimenu(fgh,'Label','View')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%






% % Axes
axh = axes('Position',[.005 .05 .8 .9]);
    imh = imagesc(Image(:,:,1));
    axis image off
setappdata(fgh,'imh',imh)

%% slider
slh = uicontrol(fgh,...
    'Style','slider',...
    'Unit','normalized',...
    'Position',[0 0 .8 .02],...
    'backGroundColor',ones(1,3)*0.5);
txh = uicontrol(fgh,...
    'Style','text',...
    'Unit','normalized',...
    'Position',[.8 0 .09 .05],...
    'Fontsize',12);
if and(length(siz)>2,size(Image,3)>1)
    slh.SliderStep = [1/(siz(3)-1) 10/(siz(3)-1) ];
    slh.Callback = @Callback_slider;
    set(slh,'Userdata',siz(3))
    set(txh,'String','1')
else
    set(slh,'Userdata',1)
    slh.Visible = 'off';
    txh.Visible = 'off';
end
setappdata(fgh,'slh',slh)
setappdata(fgh,'txh',txh)

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
    'Position',[.81 .92 .18 .07]);
h = uibuttongroup('parent',uiph,'visible','off','Position',[0 0 1 1]);
u_ture = uicontrol('Parent',h,'Style','radiobutton','String','True',...
    'unit','normalized','Position',[0 0 1 .45]);
u_false = uicontrol('Parent',h,'Style','radiobutton','String','False',...
    'unit','normalized','Position',[.52 0 1 .45]);
setappdata(fgh,'TrueFalseH',[u_ture u_false])
% Initialaize
set(h,'SelectionChangeFcn',@selcbk);
set(h,'SelectedObject',[]);% No selection
set(h,'Visible','on')
    function selcbk(oh,event)
        STR = get(event.NewValue,'String');
        switch STR
            case 'True'
                setappdata(fgh,'TrueFalse',true)
            case 'False'
                setappdata(fgh,'TrueFalse',false)
        end
    end
setappdata(fgh,'TrueFalse',[]);
setappdata(fgh,'uiph',uiph)

%% h = imellipse
h = imellipse(axh,[siz(2)/2 siz(1)/2 siz(2)/10 siz(1)/10]);
setappdata(fgh,'handle',h);
Xlimt = [-5.5 size(Image,2)+5.5];
Ylimt = [-5.5 size(Image,1)+5.5];
fcn = makeConstrainToRectFcn(class(h),Xlimt,Ylimt);
setPositionConstraintFcn(h,fcn);
addNewPositionCallback(h,@(p) PositionConstrainFcn_bw);


%% Create Image
Image = OutputImageRGB(Image(:,:,1),bw(:,:,1),savefgh);
set(imh,'Cdata',Image)

%% output bw data
outputh = uicontrol(fgh,...
    'Unit','normalized',...
    'Position',[0.82 .1 .125 .1],...
    'String','Output 2 workspace',...
    'Callback',@Callback_output,...
    'backGroundColor',ones(1,3)*0.5);
    function Callback_output(oh,~)
        bw = getappdata(savefgh,'bw');
        [~,okTF] = export2wsdlg({'Ouput BWdata'},{'BW'},{bw},'Save bw data');        
        if okTF
            TS_3dslider(bw)
        end
    end
end

function A = GetNowslice(oh)
znum = get(oh,'Userdata') - 1;
A = uint32(max(oh.Value * znum + 1,1));

end

function Callback_slider(oh,~)
fgh = oh.Parent;
savefgh = getappdata(fgh,'savefgh');
NowSlice = GetNowslice(oh);
txh = getappdata(fgh,'txh');
txh.String = num2str(NowSlice);
imh = getappdata(fgh,'imh');
Image = getappdata(savefgh,'Image');
bw = getappdata(savefgh,'bw');
imh.CData = OutputImageRGB(Image(:,:,NowSlice),bw(:,:,NowSlice),savefgh);
PositionConstrainFcn_bw
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
PositionConstrainFcn_bw
end

function PositionConstrainFcn_bw
fgh = gcf;
savefgh = getappdata(fgh,'savefgh');
h = getappdata(fgh,'handle');
slh = getappdata(fgh,'slh');
uih_bwonoff = getappdata(fgh,'uih_bwonoff');
val = get(uih_bwonoff,'Value');
if val==0
    return
else
    Image = getappdata(savefgh,'Image');
    BW = getappdata(savefgh,'bw');
    NowSlice = GetNowslice(slh);
    Image = squeeze(Image(:,:,NowSlice));
    bw  = squeeze(BW(:,:,NowSlice));
    
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
    savefgh = getappdata(fgh,'savefgh');
    outImage = OutputImageRGB(Image,bw,savefgh);
    set(imh,'Cdata',outImage)
    drawnow
    BW(:,:,NowSlice) = bw;
    setappdata(savefgh,'bw',BW)
end
end

function outImage = OutputImageRGB(Image,bw,savefgh)
Alpha = getappdata(savefgh,'Alpha');
% Red = Image;
% Red(bw) = Alpha;
Red = uint8(bw) * Alpha;

% outImage = cat(3,Red,Image.*feval(class(Image),(~bw)),...
%                      Image.*feval(class(Image),(~bw)));
outImage = cat(3,Red,Image,Image);
% outImage= cat(3,Red,Image);
outImage = rgbproj(outImage);
end

function KeyPressFcn(fgh,ob)
Type = ob.Key; 
slh = getappdata(fgh,'slh');
uih_bwonoff = getappdata(fgh,'uih_bwonoff');
switch Type
    case {'space'}
        val = get(uih_bwonoff,'Value');
        if val == 1
            set(uih_bwonoff,'Value',0)
        else
            set(uih_bwonoff,'Value',1)
        end
        Callback_bwonoff(uih_bwonoff) 
        return
    case 'return'
        TFH = getappdata(fgh,'TrueFalseH');
        if TFH(1).Value
            TFH(2).Value = true;
            setappdata(fgh,'TrueFalse',false)
        else
            TFH(1).Value = true;
            setappdata(fgh,'TrueFalse',true)
        end
    case 'a'
        pm = -1;
    case 'd'
        pm = 1;
    otherwise
        return
end
Modi = ob.Modifier;
if ~isempty(Modi)            
    switch Modi{1}
        case 'shift'
            pm = pm * 10;
    end
end
switch Type
    case {'a','d'}
        val = pm * slh.SliderStep(1) + slh.Value;
        val = max(val,slh.Min);
        val = min(val,slh.Max);
        slh.Value = val;
        Callback_slider(slh)
end

end


function varargout = TS_3dslider(varargin)
%% TS_3dslider(Image)
% This function is basic GUI for creating new program.
%    Edit by Sugashi. 2016 July.
% 
% <For example...>
% load mri
% TS_3dslider(squeeze(D))
disp('   ...Open TS_3dslider')
disp([ '   ' mfilename('fullpath') ])
if nargin==0
    disp('    load mri (default data)')
    load mri
    data = D;
    clear map siz
else
    data = varargin{1};
end

data = squeeze(data);
if ndims(data)>4
    error('Input Dim. is NOT Correct')
end

fgh = figure('Posi',[50 55 500 600],...
    'toolbar','figure');
if nargout == 1
     varargout{1} = fgh;
end
axh = axes('Unit','Normalized',...
    'Position',[0.01 0.1 0.98 0.88]);
imh = imagesc(rgbproj(data(:,:,end,:)));
axis image off
colormap(gray(256))
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
    'Callback',@Callback_slider,...
    'Userdata',znum-1);
txh = uicontrol('Style','text',...
    'unit','Normalized',...
    'Position',[0.6 0.04 0.4 0.03],...
    'String',num2str(znum));
setappdata(fgh,'slh',slh)
setappdata(fgh,'txh',txh);
end
%% add Pixels infomation
pixh = impixelinfo;
pixh.Position = [1 32 293 21];
setappdata(fgh,'impixelinfoH',pixh)

%% add MIP menu
MIPString = {'Max';'Average';'Median';'SD';'Min';'Sum';'RGB'};
if ndims(data) == 4
    MIPString = MIPString(1:end-1);
end
if znum>1
uih(1) = uicontrol('Style','popupmenu',...
    'Position',[2 580 80 19],...
    'String',MIPString);
uih(2) = uicontrol('Style','Edit',...
    'Position',[84 580 50 19],...
    'String','1');
uih(3) = uicontrol(...
    'Position',[138 580 50 19],...
    'String','Apply',...
    'Callback',@Callback_slider);
uih(4) = uicontrol(...
    'Position',[420 580 78 19],...
    'String','Make Movie',...
    'Callback',@Callback_MakeMovie);
for n = 1:length(uih)
    uih(n).Units = 'normalized';
end
setappdata(fgh,'MIPhandles',uih)
end

end

function A = GetNowSlice(slh)
A = uint32(round(get(slh,'Value')*get(slh,'Userdata')+1));
end

function ResetView(fgh)
slh = getappdata(fgh,'slh');
data = getappdata(fgh,'data');
imh = getappdata(fgh,'imh');
txh = getappdata(fgh,'txh');
znum = size(data,3);
NowSlice = GetNowSlice(slh);

%% MIP
MIPh = getappdata(fgh,'MIPhandles');
Type = get(MIPh(1),'String');
value = get(MIPh(1),'Value');
Type = Type{value};
NUM = str2double(get(MIPh(2),'String'));
zdata = 1:size(data,3);
zidx = and(zdata>=NowSlice,zdata<NowSlice+NUM);
data = (data(:,:,zidx,:));
switch lower(Type)
    case 'max'
        data = rgbproj(max(data,[],3),'auto');
    case 'average'
        data = rgbproj(mean(single(data),3),'auto');
    case 'median'
        data = rgbproj(median(data,3),'auto');
    case 'sd'
        data = rgbproj(std(single(data),[],3),'auto');
    case 'min'
        data = rgbproj(min(data,[],3),'auto');
    case 'sum'
        data = rgbproj(sum(data,3),'auto');
    case 'rgb'
        data = rgbproj(data,'auto');
end

%% imh
imh.CData = data;
find_p = find(zidx);
if (find_p(1)-find_p(end)) == 0
    STR = [num2str(NowSlice) '/' num2str(znum)];
else
    STR = [num2str(NowSlice) '-' num2str(find_p(end)) '/' num2str(znum)];
end
set(txh,'String',STR)        
end


function Callback_slider(a,~)
ResetView(a.Parent)
end



function Callback_MakeMovie(oh,~)
fgh = oh.Parent;

ch = fgh.Children;
STR_onoff = cell(1,length(ch));
for n = 1:length(ch)
    STR_onoff{n} = ch(n).Visible;
    ch(n).Visible = 'off';
end


imh = getappdata(fgh,'imh');
slh = getappdata(fgh,'slh');
siz = size(getappdata(fgh,'data'));
s = slh.SliderStep(1);
slh.Value = 1;
ResetView(fgh)
Mov(1:siz(3)) = struct('cdata',[],'colormap',[]);
map = colormap;
c = 1;
for n = 1:-s:0
    slh.Value = n;
    ResetView(fgh)
    drawnow
    Mov(c) = getframe(imh.Parent);
    c = c + 1;
end

TS_MovieMaker4dim(Mov)

for n = 1:length(ch)
    ch(n).Visible = STR_onoff{n};
end
export2wsdlg({'Save Mov. data to variavel w.s.:'},...
    {'Mov'},...
    {Mov},'Save Movie data to Workspace')
end




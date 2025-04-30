function TS_xyzReposition(Image,varargin)
%% TS_3dslider(Image)
% This function can reposit 3D-Images(XYZ).
%    Edit by Sugashi. 2016 July.
% 
% <For example...>
% load mri
% TS_xyzReposition(squeeze(D),squeeze(D))

% Set Image
data(1).Image = Image;
[y,x,z] = size(Image);
data(1).PixelsSize = [y x z];
if nargin > 1
    for n = 2:nargin
        data(n).Image = varargin{n-1};
        [y,x,z] = size(data(n).Image);
        data(n).PixelsSize = [y x z];
    end
end
clear x y z

%% figure,axes,image 作成
fgh = figure('Posi',[50 324 500 500],...
    'toolbar','figure',...
    'Menubar','none',...
    'KeyPressFcn',@KeyPressFcn,...
    'WindowButtonDownFcn',@TSWindowButtonDownFcn,...
    'WindowButtonUpFcn',@TSWindowButtonUpFcn);
axh = axes('Unit','Normalized',...
    'Position',[0.01 0.06 0.98 0.93]);
imh = imagesc(Image(:,:,end));
axis image off
colormap(gray)



%% 並べ替え用変数--->解像度を含めミクロン単位で動かしたい．．．
Y = 1;
X = 1;
Z = 1;
for n = 1:length(data)
    Pixels_yxz = data(n).PixelsSize;
    data(n).RePosition = [Y X Z]; %% [y x z]
    X = X + Pixels_yxz(2);
    clear yxz
end

% % SliderStep用深さ変更
% data = getappdata(fgh,'data');
% % Pixels_yxz = cat(1,data.PixelsSize);

Pixels_yxz = cat(1,data.PixelsSize);
RePosi_yxz = cat(1,data.RePosition)-1;
MaxSize = max(Pixels_yxz + RePosi_yxz,[],1);
znum = MaxSize(3);
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
    'String',1);
%% Setappdata
setappdata(fgh,'slh',slh)
setappdata(fgh,'txh',txh);
setappdata(fgh,'imh',imh);
setappdata(fgh,'axh',axh);
setappdata(fgh,'data',data);
setappdata(fgh,'MaxSize',MaxSize);

Setup_imrect(fgh)
RefreshImage(fgh)
end

%% Set Up imrect
function Setup_imrect(fgh)
data = getappdata(fgh,'data');
axh = getappdata(fgh,'axh');
for n = 1:length(data)
    yxz = data(n).RePosition;
    siz = data(n).PixelsSize;
    h = imrect(axh,[yxz(2) yxz(1) siz(2) siz(1)]);
    set(h,'Userdata',n) %% data(n)のNumberを保存
    setResizable(h,false)
    addNewPositionCallback(h,@ROI_Moving);
    data(n).handle = h;
end
setappdata(fgh,'data',data);
end

function ROI_Moving(posi)
oh = get(gco,'Parent');
Num = get(oh,'Userdata');
fgh = gcbf;
data = getappdata(fgh,'data');
posi = round(posi);
data(Num).RePosition(1) = posi(2);
data(Num).RePosition(2) = posi(1);
%% Indexがマイナスの場合．．．修正を行う．
if min(posi)<1
    yxz = cat(1,data.RePosition);
    Min_yxz = min(yxz,[],1);
    Min_yxz(Min_yxz>0) = 1;
    Add_index = zeros(size(yxz));
    for n = 1:3 %% ndims==3のため
        Add_index(:,n) = 1 - Min_yxz(n);
    end
    RePosi = yxz + Add_index;
    for n = 1:length(data)
        data(n).RePosition = RePosi(n,:);
        h = data(n).handle;
        siz = data(n).PixelsSize;
        xy = [RePosi(n,2) RePosi(n,1)];
        setPosition(h,[xy siz(2) siz(1)])
    end
end
setappdata(fgh,'data',data);
% RefreshImage(fgh)
% drawnow
end


% %% GetMaxSize
% function znum = GetMaxSize(fgh)
% data = getappdata(fgh,'data');
% Pixels_yxz = cat(1,data.PixelsSize);
% RePosi_yxz = cat(1,data.RePosition)-1;
% znum = max(Pixels_yxz + RePosi_yxz,[],1);
% end

%% GetImage
function Image = GetImage(fgh)
data = getappdata(fgh,'data');
% imh = struct('Image',[],'bw',[]);
siz = getappdata(fgh,'MaxSize');
Image = zeros(siz(1),siz(2),length(data));
BW = Image;
NowSlice = GetNowSlice(fgh);

for n = 1:length(data)
    yxz = data(n).RePosition;
    im_siz = data(n).PixelsSize;
    im = data(n).Image;
    if NowSlice+yxz(3)-1 <= im_siz(3)
        im = im(:,:,NowSlice+yxz(3)-1);
        bw = true(im_siz(1),im_siz(2));
    else
        im = zeros(im_siz(1),im_siz(2));
        bw = false(im_siz(1),im_siz(2));
    end
    Image(yxz(1):yxz(1)+im_siz(1)-1,yxz(2):yxz(2)+im_siz(2)-1,n) = im;
    BW(yxz(1):yxz(1)+im_siz(1)-1,yxz(2):yxz(2)+im_siz(2)-1,n) = bw;
    clear yxz im_siz im bw
end
Image = sum(Image,3);
S = sum(BW,3);
Image = Image./S;
Image(or(isnan(Image),isinf(Image))) = 0;
end

%% GetNowSlice
function NowSlice = GetNowSlice(fgh)
slh = getappdata(fgh,'slh');
val = get(slh,'value');
siz = getappdata(fgh,'MaxSize');
NowSlice = uint16(round(val*(siz(3)-1))+1);
end

%% RefreshImage
function RefreshImage(fgh)
imh = getappdata(fgh,'imh');
txh = getappdata(fgh,'txh');
Image = GetImage(fgh);
set(imh,'cdata',Image);
set(txh,'String',num2str(GetNowSlice(fgh)))
end

%% === Callback === 
% Slider
function Callback_slider(slh,~)
fgh = gcbf;
RefreshImage(fgh)
end

%% =====  Key Press Fcn ====
function KeyPressFcn(fgh,ob)
if or(isempty(fgh),~isstruct(ob))
    return
end
% ob
Type = ob.Key;
switch Type
    case {'w','d'}
        pm = 1;
    case {'s','a'}
        pm = -1;
    case 'space'
        axh = findobj('Parent',fgh,'type','axes');
        axis(axh,'image')
    case 'n'
        RefreshImage(fgh)
    otherwise
        return
end
end


function TSWindowButtonDownFcn(fgh,~)
% disp('Down')
end

function TSWindowButtonUpFcn(fgh,~)
% disp('UP')
end




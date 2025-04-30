function varargout = TS_impoly(varargin)
% h = TS_imline(varargin)
% Add. Length text and Resolution[X Y]
% Ex. 
% figure,image
% [h,txh] = TS_imline;
h = impoly(varargin{:});
addNewPositionCallback(h,@(p) MotionLine);
Posi = getPosition(h);
ch = get(h,'children');
ch(end-1).Visible = 'off';
ch(end-2).Visible = 'off';

data.Resolution = [1 1]; % Resolution [X Y]
set(h,'Userdata',data)

Len =  GetLen(h);
Posi_Ave = mean(Posi,1);
txh = text(Posi_Ave(1),Posi_Ave(2),num2str(Len));
set(txh,'BackGroundColor','w','Color','k');


% % Add Resolution
ch = get(h,'Children');
UIMH = get(ch,'uicontextmenu');

for n = [1 size(Posi,1)+1]
uimH = UIMH{n};
% get(uimH,'Children')
%   Menu    (delete vertex cmenu item)
%   Menu    (set color cmenu item)
%   Menu    (copy position cmenu item)
NowChildren = get(uimH,'Children');
delete(NowChildren(1))
uimenu(uimH,'Label','Resolution', 'Callback',@CallbackResolution,'Separator','on',...
    'Userdata',h)
uimenu(uimH,'Label','Delete', 'Callback',@CallbackDelete,'Separator','on',...
    'Userdata',h)
end

data.txh = txh;
data.FontSize = FontSizeFunc;
data.h = h;
set(h,'Userdata',data)

if nargout==1
    varargout{1} = h;
elseif nargout == 2
    varargout{1} = h;
    varargout{2} = txh;
end
end

%%%%%%%%%%%%%%% FontSize Func. &&&&&&&&
function A = FontSizeFunc
A = 15;
end
%%%%%%%%%%%%%%%%%


function MotionLine

oh = get(gco,'Parent');
data = get(oh,'Userdata');
FSize = data.FontSize;
h = data.h;
txh = data.txh;
% Reso = data.Resolution;
Posi = getPosition(h);
Len = GetLen(h);

% DiffLen = diff(Posi,1).*Reso;
% Len = sqrt(sum(DiffLen.^2));
Len = round(Len*100)/100;
STR = num2str(Len);
if isempty(find(STR=='.'))
    STR = [STR '.0'];
end

Posi_Ave = mean(Posi,1);
set(txh,'Position',Posi_Ave,...
    'String',STR,...
    'Fontsize',FSize) %%% FontSize
end

function CallbackResolution(oh,dummy)
h = get(oh,'Userdata');
data = get(h,'Userdata');
h = data.h;
txh = data.txh;
Reso = data.Resolution;
Pre = {num2str(Reso(1)),num2str(Reso(2))};
Input = inputdlg({'Axis-X','Axis-Y'},'Input Resolution',1,Pre);
if isempty(Input)
    return
else
    Reso(1) = eval(Input{1});
    Reso(2) = eval(Input{2});
    data.Resolution = Reso;
    set(h,'Userdata',data)
    MotionLine
end
end

function CallbackDelete(oh,dummy)
h = get(oh,'Userdata');
data = get(h,'Userdata');
h = data.h;
txh = data.txh;
delete(txh)
delete(h)
end

function Len = GetLen(h)
data = get(h,'Userdata');
Reso = data.Resolution;
Posi = getPosition(h);
Posi = diff(Posi,1,1);
Posi = Posi .*repmat(Reso,[size(Posi,1) 1]);
Len = sum(sqrt(sum(Posi.^2 ,2)));
end

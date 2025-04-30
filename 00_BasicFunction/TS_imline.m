function varargout = TS_imline(varargin)
% h = TS_imline(varargin)
% Add. Length text and Resolution[X Y]
% Ex. 
% figure,image
% [h,txh] = TS_imline;


h = imline(varargin{:});
addNewPositionCallback(h,@(p) MotionLine);
Posi = getPosition(h);
Len =  sqrt(sum(diff(Posi,1).^2));
Posi_Ave = mean(Posi,1);
txh = text(Posi_Ave(1),Posi_Ave(2),num2str(Len));
set(txh,'BackGroundColor','w','Color','k');


% % Add Resolution
ch = get(h,'Children');
uimH = get(ch,'uicontextmenu');
uimH = uimH{1};
NowChildren = get(uimH,'Children');
%   Menu    (delete cmenu item)
%   Menu    (set color cmenu item)
%   Menu    (copy position cmenu item)
delete(NowChildren(1))
uimenu(uimH,'Label','Resolution', 'Callback',@CallbackResolution,'Separator','on',...
    'Userdata',h)
uimenu(uimH,'Label','Delete', 'Callback',@CallbackDelete,'Separator','on',...
    'Userdata',h)

data.txh = txh;
data.FontSize = FontSizeFunc;  %%% FontSize
data.h = h;
data.Resolution = [1 1]; % Resolution [X Y]
set(h,'Userdata',data)

if nargout==1
    varargout{1} = h;
elseif nargout == 2
    varargout{1} = h;
    varargout{2} = txh;
end
end


%% %% Font Size %%%%% %
function A = FontSizeFunc%
A = 15;                  %
end                      %
%% %%%%%%%%%%%%%%%%%% %

function MotionLine
oh = get(gco,'Parent');
data = get(oh,'Userdata');
h = data.h;
txh = data.txh;
Reso = data.Resolution;
Posi = getPosition(h);

DiffLen = diff(Posi,1).*Reso;
Len = sqrt(sum(DiffLen.^2));
Len = round(Len*100)/100;
Posi_Ave = mean(Posi,1);
STR = num2str(Len);
if isempty(find(STR=='.'))
    STR = [STR '.0'];
end
set(txh,'Position',Posi_Ave,...
    'String',STR,...
    'Fontsize',data.FontSize)
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
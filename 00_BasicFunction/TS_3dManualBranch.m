function TS_3dManualBranch(data,bwpoint,varargin)
%% input is bw, data and Resolution(3Dimention)
% TS_3dManualBranch(data,bwpoint,varargin)
%       data    : uint8 class Image or logical data
%       bwpoint : logical class (== size(data))
%         (Reso : XYZ)
%  if Input bwpoint is matrix('like',xyz), OK. edit Sep.2016,

if nargin>2
    Reso = varargin{1};
else
    Reso = ones(1,3);
end

fgh = figure('Name','Manual Branch',...
        'InvertHardcopy','off',...
        'PaperPosition',[.6 .6 35 25],...
        'Position',[50 30 1200 850],...
        'Color','w',...
        'Resize','on',...
        'toolbar','figure');
    centerfig(fgh)
setappdata(fgh,'data',data);
setappdata(fgh,'ResolutionXYZ',Reso);
Th = 0.5; %% enya
axh = axes('Position',[.3 .08 .7 .9]);
xlabel('X')
ylabel('Y')
zlabel('Z')

hold on

posi = [1 1 50 50];

%% For Image Slider
axh(2) = axes('Unit','Normalized',...
    'Position',[0.01 0.56 0.29 0.43]);
imh = imagesc(data(:,:,end));
axis(axh(2),'image')
grid(axh(2),'on')
colormap(gray)
setappdata(fgh,'imh',imh);
setappdata(fgh,'axh',axh)
znum = size(data,3);
slh = uicontrol('Style','slider',...
    'BackgroundColor',[0.5 0.5 0.5],...
    'Position',[0 0 400 20],...
    'Value',1,...
    'SliderStep',[1/(znum-1) 10/(znum-1)],...
    'Callback',@Callback_slider,...
    'Userdata',znum-1);
txh = uicontrol('Style','text',...
    'Position',[0 20 30 20],...
    'String',num2str(znum));
setappdata(fgh,'slh',slh);
setappdata(fgh,'sl_txh',txh);


%% Add imrect
imrh = imrect(axh(2),posi);
setappdata(fgh,'imrh',imrh)
Xlimt = [.5 size(data,2)+.5];
Ylimt = [.5 size(data,1)+.5];
fcn = makeConstrainToRectFcn(class(imrh),Xlimt,Ylimt);
setPositionConstraintFcn(imrh,fcn);
% addNewPositionCallback(h,@(p) MotionROI);

uicontrol('Position',[5 450 60 25],...
    'String','Apply',...
    'Callback',@Callback_isosurface);
uicontrol('Position',[65 450 60 25],...
    'Style','text',...
    'String','Threshold');
Thresholdh = uicontrol('Position',[125 450 50 25],...
    'Style','Edit',...
    'String',num2str(Th));
uicontrol('Position',[180 450 60 25],...
    'Style','text',...
    'String','Depth Range');
DepthRangeh = uicontrol('Position',[240 450 60 25],...
    'Style','Edit',...
    'String',['[1 :' num2str(size(data,3)) ']']);

setappdata(fgh,'Thresholdh',Thresholdh);
setappdata(fgh,'DepthRangeh',DepthRangeh)

%% Reset volume
Reset3dvolume(axh(1),posi)
camh = light('Parent',axh(1));
camlight(camh,2,134);
hold(axh(1),'on')
view(axh(1),3)
daspect(axh(1),ones(1,3))
axis(axh(1),'tight')
grid(axh(1),'on')
box(axh(1),'on')


%% add Point data
Table_xyz = uitable('Parent',fgh,...
    'Position',[5 120 225 300],...
    'ColumnName',{'X','Y','Z','Delete'},...
    'ColumnFormat',{'numeric','numeric','numeric','logical'},...
    'ColumnWidth',{35 35 35 50},...
    'CellSelectionCallback',@CellSelectionCallback,...
    'BusyAction','cancel',...    
    'Enable','on',...
    'CellEditCallback',@CellEditCallback);
uicontrol('Position',[240 280 80 50],'String','Apply',...
    'Callback',@Callback_ApplyDelete,'FontSize',12,'FontWeight','bold');
uicontrol('Position',[240 240 80 30],'String','Apply Visible','Callback',@Callback_ApplyVisible);

uicontrol('Position',[240 130 80 20],'String','Now Point Ind.','Style','text');
IndEdith = uicontrol('Position',[320 130 80 20],'String','0','Style','Edit');
uicontrol('Position',[240 100 160 30],'String','Set Point','Callback',@Callback_SetPoint);

uicontrol('Position',[5 55 20 20],'Style','text','String','Z');
uicontrol('Position',[5 75 20 20],'Style','text','String','Y');
uicontrol('Position',[5 95 20 20],'Style','text','String','X');
siz = size(data);
control_xyz(3) = uicontrol('Position',[25 55 120 20],'SliderStep',[1 10]/(siz(3)-1),'userdata',siz(3)-1);
control_xyz(2) = uicontrol('Position',[25 75 120 20],'SliderStep',[1 10]/(siz(1)-1),'userdata',siz(1)-1);
control_xyz(1) = uicontrol('Position',[25 95 120 20],'SliderStep',[1 10]/(siz(2)-1),'userdata',siz(2)-1);

Nowz = uicontrol('Position',[145 55 20 20],'Style','text','String','1');
Nowy = uicontrol('Position',[145 75 20 20],'Style','text','String','1');
Nowx = uicontrol('Position',[145 95 20 20],'Style','text','String','1');
Nowpoint.h = [Nowx Nowy Nowz];
Nowpoint.Ind = 0; %% Add New Point
Nowpoint.IndEdith = IndEdith;
Nowpoint.plh = plot3(1,1,1,'g*','Linewidth',2,'Parent',axh(1));

set(control_xyz,'Style','Slider','Callback',@Callback_control)
if ismatrix(bwpoint)
    table = num2cell(bwpoint);
else
    [y,x,z] = ind2sub(size(bwpoint),find(bwpoint(:)));
    table = num2cell(cat(2,x,y,z));
end
table = cat(2,table,num2cell(false(size(table,1),1)));
set(Table_xyz,'Data',table)
setappdata(fgh,'Table_xyz',Table_xyz)
setappdata(fgh,'Control',control_xyz)
setappdata(fgh,'plh',[])
setappdata(fgh,'txh',[])
setappdata(fgh,'NowPoint',Nowpoint)
AddNewPlot(fgh)

end

function AddNewPlot(fgh)
Txyz = getappdata(fgh,'Table_xyz');
xyz = get(Txyz,'Data');
axh = getappdata(fgh,'axh');
plh = getappdata(fgh,'plh');
txh = getappdata(fgh,'txh');
if ~isempty(plh)
    delete(plh)
    delete(txh)
end
plh = [];
txh = [];

for n = 1:size(xyz,1)
    x = xyz{n,1};
    y = xyz{n,2};
    z = xyz{n,3};
    plh(n) = plot3(x,y,z,'ro','Linewidth',2,'Parent',axh(1));
    txh(n) = text(x,y,z+2,num2str(n),'Parent',axh(1));    
end
set(txh,'Fontsize',12)
setappdata(fgh,'plh',plh);
setappdata(fgh,'txh',txh);
Nowpoint = getappdata(fgh,'NowPoint');
Nowpoint.Ind = 0;
setappdata(fgh,'NowPoint',Nowpoint);
CheckVisible(fgh)
end

function CheckVisible(fgh)
Txyz = getappdata(fgh,'Table_xyz');
xyz = get(Txyz,'Data');
if isempty(xyz)
    return
end

plh = getappdata(fgh,'plh');
txh = getappdata(fgh,'txh');

x = zeros(size(xyz,1),1,'like',uint32(1));
y = x;
z = x;
TFind = false(size(x));
for n = 1:length(x)
    x(n) = xyz{n,1};
    y(n) = xyz{n,2};
    z(n) = xyz{n,3};
    TFind(n)= xyz{n,4};
end
DepthRangeh = getappdata(fgh,'DepthRangeh');
DepthRange = eval(get(DepthRangeh,'String'));
imrh = getappdata(fgh,'imrh');
posi = getPosition(imrh);
xind = and(x>=posi(1),x<=posi(1)+posi(3));
yind = and(y>=posi(2),y<=posi(2)+posi(4));
zind = and(z>=DepthRange(1),z<=DepthRange(end));
ind = and(xind,and(yind,zind));
set(plh(ind),'visible','on');
set(plh(~ind),'visible','off');
set(txh(ind),'visible','on');
set(txh(~ind),'visible','off');
set(plh(TFind),'visible','off');
set(txh(TFind),'visible','off');
end

function Callback_control(oh,~)
fgh = get(oh,'Parent');
c_xyz = getappdata(fgh,'Control');
x = uint32(get(c_xyz(1),'Value')*get(c_xyz(1),'userdata')+1);
y = uint32(get(c_xyz(2),'Value')*get(c_xyz(2),'userdata')+1);
z = uint32(get(c_xyz(3),'Value')*get(c_xyz(3),'userdata')+1);

%% Table
Txyz = getappdata(fgh,'Table_xyz');
Nowpoint = getappdata(fgh,'NowPoint');
set(Nowpoint.h(1),'String',num2str(x))
set(Nowpoint.h(2),'String',num2str(y))
set(Nowpoint.h(3),'String',num2str(z))
Ind = Nowpoint.Ind;
if ~ishandle(Nowpoint.plh)
    return
end
% xyz = get(Txyz,'Data');
% xyz{Ind,1} = x ;
% xyz{Ind,2} = y ;
% xyz{Ind,3} = z ;
% set(Txyz,'Data',xyz)

% plh txh
set(Nowpoint.plh,'Xdata',x,'Ydata',y,'Zdata',z)
% plh = getappdata(fgh,'plh');
% txh = getappdata(fgh,'txh');
% set(plh(Ind),'Xdata',x,'Ydata',y,'Zdata',z)
% set(txh(Ind),'Position',[x y z+5])
end

function CellSelectionCallback(oh,event)
fgh = get(oh,'Parent');
xyz = get(oh,'Data');
Nowpoint = getappdata(fgh,'NowPoint');
if numel(event.Indices)==0
    return
end
Ind = event.Indices(2);
event = event.Indices(1);

Nowpoint.Ind = event;
setappdata(fgh,'NowPoint',Nowpoint)
set(Nowpoint.IndEdith,'String',num2str(event));

c_xyz = getappdata(fgh,'Control');
set(c_xyz(1),'Value',(xyz{event,1}-1)/get(c_xyz(1),'Userdata'))
set(c_xyz(2),'Value',(xyz{event,2}-1)/get(c_xyz(2),'Userdata'))
set(c_xyz(3),'Value',(xyz{event,3}-1)/get(c_xyz(3),'Userdata'))
Callback_control(oh)

slh = getappdata(fgh,'slh');
set(slh,'Value',(xyz{event,3}-1)/get(slh,'Userdata'))
Callback_slider(slh)

plh = getappdata(fgh,'plh');
set(plh,'Color','r')
set(plh(event),'Color','b')

if Ind==4
    xyz{event,Ind} = not(xyz{event,Ind});
    set(oh,'Data',xyz)
end

end

function CellEditCallback(oh,event)
oh
event
end

function Callback_ApplyDelete(oh,~)
fgh = get(oh,'Parent');
Txyz = getappdata(fgh,'Table_xyz');
xyz = get(Txyz,'Data');
x = uint32(1);
y = uint32(1);
z = uint32(1);

c = uint32(1);
for n = 1:size(xyz,1)
    if xyz{n,4}
        continue
    end
    x(c) = xyz{n,1};
    y(c) = xyz{n,2};
    z(c) = xyz{n,3};
    c = c + 1;
end
siz = size(getappdata(fgh,'data'));
BranchPoint = false(siz);
IND = sub2ind(siz,y,x,z);
BranchPoint(IND) = true;
export2wsdlg({'New Branch'},{'BranchPoint'},{BranchPoint},'Save BW Image')
end

function Callback_ApplyVisible(oh,~)
fgh = get(oh,'Parent');
CheckVisible(fgh)
end

function Callback_SetPoint(oh,~)
fgh = get(oh,'Parent');
axh = getappdata(fgh,'axh');
Txyz = getappdata(fgh,'Table_xyz');
xyz = get(Txyz,'Data');
Nowpoint = getappdata(fgh,'NowPoint');
Nowpoint.Ind = eval(get(Nowpoint.IndEdith,'String'));
if Nowpoint.Ind == 0
    Newxyz = cat(1,cell(1,4),xyz);
    Newxyz{1,1} = get(Nowpoint.plh,'xdata');
    Newxyz{1,2} = get(Nowpoint.plh,'ydata');
    Newxyz{1,3} = get(Nowpoint.plh,'zdata');
    Newxyz{1,4} = false;
    set(Txyz,'data',Newxyz)
else
    try
        x = xyz{Nowpoint.Ind,1};
        y = xyz{Nowpoint.Ind,2};
        z = xyz{Nowpoint.Ind,3};

        x(2)= get(Nowpoint.plh,'xdata');
        y(2) = get(Nowpoint.plh,'ydata');
        z(2) = get(Nowpoint.plh,'zdata');
        set(Nowpoint.plh,'LineStyle','-');
        set(Nowpoint.plh,'Xdata',x,'Ydata',y,'Zdata',z)
        
        %% Just play with Matlab. lol.
% %         [u,v,w] = meshgrid(0:1,0:1,0:1);
% %         if diff(x)~=0 ,X = u*diff(x)+x(1); cx = mean(X(:));
% %             u = u * diff(x)/abs(diff(x));
% %         else  X = u + x(1); cx = x(1);
% %         end
% %         if diff(y)~=0, Y = v*diff(y)+y(1); cy = mean(Y(:));
% %             v = v * diff(y)/abs(diff(y));
% %         else Y = v + y(1); cy = y(1);
% %         end
% %         if diff(z)~=0 ,Z = w*diff(z)+z(1); cz = mean(Z(:));
% %             w = w * diff(z)/abs(diff(z));
% %         else Z = w + z(1); cz = y(1);
% %         end
% %         Scale = sqrt(sum(diff(cat(1,x,y,z),[],2).^2,1));
% % %         disp(num2str(Scale))
% %         cp = coneplot(X,Y,Z,u,v,w,cx,cy,cz,(Scale+15)/Scale);
% %         set(cp,'Edgecolor','none','FaceColor','r')        
% %         drawnow
% %         pause(1)
% %         delete(cp)
        %% Qui ver        
        quiver_h = quiver3(mean(x),mean(y),mean(z),...
            diff(x),diff(y),diff(z),'Parent',axh(1));        
        clear u v w cx cy cz X Y Z Scale        
        for n = 1:5
            set(quiver_h,'visible','off');
            pause(.1)
            set(quiver_h,'visible','on');
            pause(.1)
        end        
        delete(quiver_h)
        set(Nowpoint.plh,'Xdata',x(2),'Ydata',y(2),'Zdata',z(2))
        
        xyz{Nowpoint.Ind,1} = x(2);
        xyz{Nowpoint.Ind,2} = y(2);
        xyz{Nowpoint.Ind,3} = z(2);
        
        set(Txyz,'data',xyz)

    catch err
        warning(err.message)
        set(Nowpoint.plh,'Xdata',x(2),'Ydata',y(2),'Zdata',z(2))
        return
    end
end
AddNewPlot(fgh)
end

function Callback_isosurface(oh,~)
fgh = get(oh,'Parent');
imrh = getappdata(fgh,'imrh');
posi = getPosition(imrh);
axh = getappdata(fgh,'axh');
Reset3dvolume(axh(1),posi)
end

function Reset3dvolume(axh,posi)
fgh = get(axh,'Parent');
data = getappdata(fgh,'data');
Maximum = double(max(data(:)));
Reso = getappdata(fgh,'ResolutionXYZ');
Thh = getappdata(fgh,'Thresholdh');
Th = eval(get(Thh,'String'));
DepthRangeh = getappdata(fgh,'DepthRangeh');

p = getappdata(fgh,'Userdata');
delete(p)

% xysiz = round(50 / Reso(1));
Xdata = round(posi(1)):round(posi(1)+posi(3))-1 ;
% X = (Xdata-1) * Reso(1);
X = Xdata;
Ydata = round(posi(2)):round(posi(2)+posi(4))-1;
% Y = (Ydata-1) * Reso(2);
Y = Ydata;
% Z = ((1:size(data,3)) -1) * Reso(3);
% get(DepthRangeh)
Zdata = eval(get(DepthRangeh,'String'));
Z = Zdata;
% fv = isosurface(X,Y,Z,flip(double(data(Ydata,Xdata,:)),3),Th);
fv = isosurface(X,Y,Z,double(data(Ydata,Xdata,Zdata))/Maximum,Th);

p = patch(fv,'parent',axh);
set(p,'EdgeColor','None',...
    'FaceColor',[.9 .9 1]);
reducepatch(p,0.5)
set(axh,'YlimMode','auto',...
    'XlimMode','auto',...
    'ZlimMode','auto',...
    'Ydir','reverse',...
    'Zdir','normal')
axis tight
alpha(p,.2)
set(axh,'Zlim',[Zdata(1) Zdata(end)],...
    'Ylim',[Ydata(1) Ydata(end)],...
    'Xlim',[Xdata(1) Xdata(end)])

setappdata(fgh,'Userdata',p);
CheckVisible(fgh)
end

function Callback_slider(a,~)
data = getappdata(gcbf,'data');
imh = getappdata(gcbf,'imh');
txh = getappdata(gcbf,'sl_txh');
znum = size(data,3);
NowSlice = uint16(round(get(a,'Value')*(znum-1))+1);
set(imh,'cdata',data(:,:,NowSlice));
set(txh,'String',num2str(NowSlice))
end
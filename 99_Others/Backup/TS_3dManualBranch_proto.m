function TS_3dManualBranch_proto(data,bwpoint)
%% input is bw data and Resolution(3Dimention)

fgh = figure('Name','Manual Branch',...
        'InvertHardcopy','off',...
        'PaperPosition',[.6 .6 12 18],...
        'Position',[50 30 1200 850],...
        'Color','w',...
        'Resize','off',...
        'toolbar','figure');
    centerfig(fgh)
setappdata(fgh,'data',data);
Th = 0.5; %% enya
axh = axes('Position',[.3 .08 .7 .9]);
xlabel('X')
ylabel('Y')
zlabel('Z')
posi = [1 1 5 5];
Reset3dvolume(axh,posi)
hold on
view(3)
daspect(ones(1,3))
axis tight
grid on
box on

%% For Image Slider
axh(2) = axes('Unit','Normalized',...
    'Position',[0.01 0.56 0.29 0.43]);
imh = imagesc(data(:,:,end));
axis(axh(2),'image','off')
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
uicontrol('Position',[65 450 50 25],...
    'Style','text',...
    'String','Threshold');
uih = uicontrol('Position',[115 450 50 25],...
    'Style','Edit',...
    'String',num2str(Th));
setappdata(fgh,'Thresholdh',uih);

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
uicontrol('Position',[240 280 80 50],'String','Apply Delete','Callback',@Callback_ApplyDelete);
uicontrol('Position',[240 240 80 30],'String','Apply Visible','Callback',@Callback_ApplyVisible);
uicontrol('Position',[240 200 80 30],'String','Add Point','Callback',@Callback_AddPoint);

uicontrol('Position',[5 55 20 20],'Style','text','String','Z');
uicontrol('Position',[5 75 20 20],'Style','text','String','Y');
uicontrol('Position',[5 95 20 20],'Style','text','String','X');
siz = size(data);
control_xyz(3) = uicontrol('Position',[25 55 120 20],'SliderStep',[1 10]/(siz(3)-1),'userdata',siz(3)-1);
control_xyz(2) = uicontrol('Position',[25 75 120 20],'SliderStep',[1 10]/(siz(1)-1),'userdata',siz(1)-1);
control_xyz(1) = uicontrol('Position',[25 95 120 20],'SliderStep',[1 10]/(siz(2)-1),'userdata',siz(2)-1);
set(control_xyz,'Style','Slider','Callback',@Callback_control)

[y,x,z] = ind2sub(size(bwpoint),find(bwpoint(:)));
table = num2cell(cat(2,x,y,z));
table = cat(2,table,num2cell(false(length(x),1)));
set(Table_xyz,'Data',table)
setappdata(fgh,'Table_xyz',Table_xyz)
setappdata(fgh,'Control',control_xyz)
setappdata(fgh,'plh',[])
setappdata(fgh,'txh',[])
setappdata(fgh,'NowPoint',[])
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
    txh(n) = text(x,y,z+5,num2str(n),'Parent',axh(1));    
end
set(txh,'Fontsize',12)
setappdata(fgh,'plh',plh);
setappdata(fgh,'txh',txh);
setappdata(fgh,'NowPoint',[])
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
y = zeros(size(xyz,1),1,'like',uint32(1));
TFind = false(size(x));
for n = 1:length(x)
    x(n) = xyz{n,1};
    y(n) = xyz{n,2};
    TFind(n)= xyz{n,4};
end

imrh = getappdata(fgh,'imrh');
posi = getPosition(imrh);
xind = and(x>=posi(1),x<=posi(1)+posi(3));
yind = and(y>=posi(2),y<=posi(2)+posi(4));
ind = and(xind,yind);
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
Ind = getappdata(fgh,'NowPoint');
if isempty(Ind)
    return
end
xyz = get(Txyz,'Data');
xyz{Ind,1} = x ;
xyz{Ind,2} = y ;
xyz{Ind,3} = z ;
set(Txyz,'Data',xyz)

% plh txh
plh = getappdata(fgh,'plh');
txh = getappdata(fgh,'txh');
set(plh(Ind),'Xdata',x,'Ydata',y,'Zdata',z)
set(txh(Ind),'Position',[x y z+5])
end

function CellSelectionCallback(oh,event)
fgh = get(oh,'Parent');
xyz = get(oh,'Data');
if numel(event.Indices)==0
    return
end
Ind = event.Indices(2);
event = event.Indices(1);

setappdata(fgh,'NowPoint',event)

c_xyz = getappdata(fgh,'Control');
set(c_xyz(1),'Value',(xyz{event,1}-1)/get(c_xyz(1),'Userdata'))
set(c_xyz(2),'Value',(xyz{event,2}-1)/get(c_xyz(2),'Userdata'))
set(c_xyz(3),'Value',(xyz{event,3}-1)/get(c_xyz(3),'Userdata'))

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
IND = sub2ind(siz,x,y,z);
BranchPoint(IND) = true;
export2wsdlg({'New Branch'},{'BranchPoint'},{BranchPoint},'Save BW Image')
end

function Callback_ApplyVisible(oh,~)
fgh = get(oh,'Parent');
CheckVisible(fgh)
end

function Callback_AddPoint(oh,~)
fgh = get(oh,'Parent');
Txyz = getappdata(fgh,'Table_xyz');
xyz = get(Txyz,'Data');
Newxyz = cat(1,cell(1,4),xyz);
siz = size(getappdata(fgh,'data'));
Newxyz{1,1} = round(siz(2)/2);
Newxyz{1,2} = round(siz(1)/2);
Newxyz{1,3} = round(siz(3)/2);
Newxyz{1,4} = false;
set(Txyz,'data',Newxyz)
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
Thh = getappdata(fgh,'Thresholdh');
Th = get(Thh,'String');
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
Z = 1:size(data,3);
% fv = isosurface(X,Y,Z,flip(double(data(Ydata,Xdata,:)),3),Th);
fv = isosurface(X,Y,Z,double(data(Ydata,Xdata,:)),Th);

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
camh = camlight(2,134);
% camlight(camh,[2 -34]);
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
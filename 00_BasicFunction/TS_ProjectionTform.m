function TS_ProjectionTform(I)

fgh = figure('Position',[100 100 800 500]);
axh(1) = axes('Position',[.01 .05 .48 .85],'Ydir','reverse');
 imh(1) = imagesc(I);axis image off
axh(2) = axes('Position',[.51 .05 .48 .85],'Ydir','reverse');
 imh(2) = imagesc(I);axis image off
colormap(gray)
impixelinfo
% % impoly
siz = size(I); 
h = impoly(axh(1),[siz(2)*0.1 siz(1)*0.1;...
    siz(2)*0.1 siz(1)*0.9;...
    siz(2)*0.9 siz(1)*0.9;...
    siz(1)*0.9 siz(1)*0.1]);
Xlimt = [1 siz(2)];
Ylimt = [1 siz(1)];
fcn = makeConstrainToRectFcn(class(h),Xlimt,Ylimt);
setPositionConstraintFcn(h,fcn);

% % uicontrol
uih = uicontrol('style','text',...
    'Unit','normalized',...
    'Position',[.01 0.95 .15 .04],...
    'String','Output Size');
uih(2) = uicontrol('style','edit',...
    'Unit','normalized',...
    'Position',[.01 0.905 .15 .04],...
    'String','[256 256]');
uih(3) = uicontrol('Unit','normalized',...
    'Position',[.18 0.91 .1 .08],...
    'String','Apply',...
    'Fontsize',20,...
    'Callback',@Callback_makeimage);

uih(4) = uicontrol('Unit','normalized',...
    'Position',[.3 0.91 .15 .08],...
    'String','Save image',...
    'Fontsize',15,...
    'Callback',@Callback_saveimage);

data.Image = I;
data.axh = axh;
data.imh = imh;
data.uih = uih;
data.h = h;
data.Posi = getPosition(h);
data.OutputImage = [];
setappdata(fgh,'data',data)
Callback_makeimage(uih(3))
end

function Callback_makeimage(oh,~)
fgh = get(oh,'Parent');
data = getappdata(fgh,'data');
siz = eval(get(data.uih(2),'String'));
Posi = getPosition(data.h);
[X,Y] = Posi2D(siz,Posi);
Image = interp2(double(data.Image),X,Y);
data.Posi = Posi;
data.OutputImage = Image;
setappdata(fgh,'data',data);
set(data.imh(2),'Cdata',Image)
axis auto
axis image
end

function [X,Y] = Posi2D(siz,Posi)

siz1 = siz(1);
siz2 = siz(2);
for n = 1:4
    eval(['x' num2str(n) '=Posi(' num2str(n) ',1);']);
    eval(['y' num2str(n) '=Posi(' num2str(n) ',2);']);
end
Xdata = 0:1/siz2:1;
len_x14 = abs(x4-x1);
X1 = (Xdata*len_x14) + min([x1 x4]);
len_x23 = abs(x3-x2);
X2 = (Xdata*len_x23) + min([x2 x3]);
X = imresize(cat(1,X1,X2),siz);

Ydata = 0:1/siz1:1;

% len_y14 = abs(y4-y1);
% Y1 = (Ydata*len_y14) + min([y4 y1]);
% len_y23 = abs(y3 - y2);
% Y2 = (Ydata*len_y23) + min([y3 y2]);
% Y = imresize(cat(1,Y1,Y2),siz,'bilinear');

Ydata = Ydata(:);
len_y12 = abs(y2-y1);
Y1 = (Ydata*len_y12) + min([y1 y2]);
len_y34 = abs(y3 - y4);
Y2 = (Ydata*len_y34) + min([y4 y3]);
Y = imresize(cat(2,Y1,Y2),siz);
end

function Callback_saveimage(oh,~)
fgh = get(oh,'Parent');
Filt = {'*.tif';'*.bmp';'*.jpg'};
[filename,pathname,Indx] = uiputfile(...
    Filt,'Save Picture');
if filename==0
    return
end
Nowdir = cd;
cd(pathname)
data = getappdata(fgh,'data');
im = data.OutputImage;
im = double(im);
im = im - min(im(:));
im = im / max(im(:));
im = uint8(im*255);
map = colormap(fgh);
disp(filename)
Type = Filt{Indx};
Type(1:2) = [];
imwrite(im,map,filename,Type)
cd(Nowdir)
end







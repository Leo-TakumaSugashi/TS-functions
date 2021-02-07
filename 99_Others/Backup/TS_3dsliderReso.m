function TS_3dsliderReso(data)
%% TS_3dslider(Image)
% This function is basic GUI for creating new program.
%    Edit by Sugashi. 2016 July.
% 
% <For example...>
% load mri
% TS_3dslider(squeeze(D))


fgh = figure('Posi',[50 324 500 580],...
    'toolbar','figure');
axh = axes('Unit','Normalized',...
    'Position',[0.01 0.06 0.98 0.90]);
imh = imagesc(data(:,:,end));
axis image off
colormap(gray)

znum = size(data,3);
slh = uicontrol('Style','slider',...
    'Unit','Normalized',...
    'BackgroundColor',[0.5 0.5 0.5],...
    'Position',[0 0 1 0.04],...
    'Value',1,...
    'SliderStep',[1/(znum-1) 10/(znum-1)],...
    'Callback',@Callback_slider);
uih = uicontrol('Style','edit',...
    'unit','Normalized',...
    'Position',[0 0.04 0.05 0.03],...
    'String',num2str(znum));

% % Add Step size
uih(2) = uicontrol('Style','text',...
    'Unit','normalized',...
    'Position',[.01 .97 .12 .029],...
    'String','Step Size');
uih(3) = uicontrol('Style','Edit',...
    'Unit','normalized',...
    'Position',[.14 .97 .12 .029],...
    'String',['1/(' num2str(znum) '-1)']);
uih(4) = uicontrol('Style','pushbutton',...
    'Unit','normalized',...
    'Position',[.27 .97 .12 .029],...
    'String','Apply',...
    'Callback',@Callback_StepSize);



setappdata(fgh,'imh',imh);
setappdata(fgh,'data',data);
setappdata(fgh,'uih',uih);
setappdata(fgh,'slh',slh)
end

function Callback_slider(a,~)
data = getappdata(gcbf,'data');
imh = getappdata(gcbf,'imh');
uih = getappdata(gcbf,'uih');
txh = uih(1);
znum = double(size(data,3));
NowSlice = get(a,'Value')*(znum-1)+1;
ydata = 1:size(data,1);
xdata = 1:size(data,2);
im = interp3(double(data),xdata,ydata,NowSlice,'bilinear');
set(imh,'cdata',im);
set(txh,'String',num2str(NowSlice))
end

function Callback_StepSize(oh,~)
fgh = get(oh,'parent');
slh = getappdata(fgh,'slh');
uih = getappdata(gcbf,'uih');
StepSize = eval(get(uih(3),'String'));
set(slh,'SliderStep',[StepSize StepSize*10])
end

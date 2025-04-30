function varargout = TS_DepthAdjGUI(varargin)
%% Help 
%  varargout = TS_DepthAdjGUI(varargin)
%  TS_DepthAdjGUI(Image1,Image2);
%     Image1 ; Basement Image
%     Image2 ; Object of Image witch needs to Reposit.
% see also , TS_DepthReposi

% TS_DEPTHADJGUI MATLAB code for TS_DepthAdjGUI.fig
%      TS_DEPTHADJGUI, by itself, creates a new TS_DEPTHADJGUI or raises the existing
%      singleton*.
%
%      H = TS_DEPTHADJGUI returns the handle to a new TS_DEPTHADJGUI or the handle to
%      the existing singleton*.
%
%      TS_DEPTHADJGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TS_DEPTHADJGUI.M with the given input arguments.
%
%      TS_DEPTHADJGUI('Property','Value',...) creates a new TS_DEPTHADJGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TS_DepthAdjGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TS_DepthAdjGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TS_DepthAdjGUI

% Last Modified by GUIDE v2.5 28-Jan-2019 11:57:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TS_DepthAdjGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @TS_DepthAdjGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
               
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% End initialization code - DO NOT EDIT


% --- Executes just before TS_DepthAdjGUI is made visible.
function TS_DepthAdjGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TS_DepthAdjGUI (see VARARGIN)

% Choose default command line output for TS_DepthAdjGUI
handles.output = hObject;

%% edit Sugashi
Image1 = varargin{1};
Image2 = varargin{2};

input_checkTF1 = and(size(Image1,4) == 1,size(Image2,4)==1);
input_checkTF2 = and(size(Image1,3)>1,size(Image2,3)>1);
if ~and(input_checkTF1,input_checkTF2)
    delete(hObject)
    error('Input Image1 and Image2 is NOT correct.')
end

%% opening func.
hObject.MenuBar = 'figure';
hObject.ToolBar = 'figure';
hObject.IntegerHandle = 'on'; %% defalt off

%% image handle
handles.image1 = imagesc(...
    rgbproj(Image1(:,:,end,:,:)),'Parent',handles.axes1);
axis(handles.axes1,'image')
axis(handles.axes1,'off')
handles.text2.String = num2str(size(Image1,3));
handles.slider1.Value = 1;

handles.image2 = imagesc(...
    rgbproj(Image2(:,:,end,:,:)),'Parent',handles.axes2);
axis(handles.axes2,'image')
axis(handles.axes2,'off')
handles.text3.String = num2str(size(Image2,3));
handles.slider2.Value = 1;

handles.image3 = imagesc(...
    rgbproj(cat(3,Image1(:,:,end,:,1),Image2(:,:,end,:,1)),'auto'),...
    'Parent',handles.axes4);
axis(handles.axes4,'image')
axis(handles.axes4,'off')


%% slider setup
handles.slider1.SliderStep = [1/(size(Image1,3)-1) 10/(size(Image1,3)-1)];
set(handles.slider1,'Userdata',size(Image1,3)-1)
handles.slider2.SliderStep = [1/(size(Image2,3)-1) 10/(size(Image2,3)-1)];
set(handles.slider2,'Userdata',size(Image2,3)-1)
%% Interpolation Plot
% length_check = size(Image1,3) <= size(Image2,3);
% if length_check
    pdata_X = NaN ; % [1 size(Image2,3)];
    pdata_Y = NaN ; % [size(Image2,3)-size(Image1,3) size(Image2,3)];
% else
%     pdata_X = [1 size(Image2,3) size(Image1,3)];
%     pdata_Y = [1 size(Image1,3) NaN];
% end
handles.InterpPlot = plot(pdata_X,pdata_Y,'.',...
    'Markersize',16,...
    'Color','b',...
    'Parent',handles.axes3);
hold(handles.axes3,'on')
handles.InterpPlotLine = plot(pdata_X,pdata_Y,'--',...
    'LineWidth',1,...
    'Color','k',...
    'Parent',handles.axes3);
handles.NowPlot = plot(size(Image1,3),size(Image2,3),'+',...
    'MarkerSize',10,...
    'Color','r',...
    'Parent',handles.axes3);
hold(handles.axes3,'off')
handles.axes3.XLabel.String = 'Image 2 (Interp. Obj.)';
handles.axes3.YLabel.String = 'Image 1 (Basement)';

%% Apply button
handles.pushbutton1.String = 'Apply';

%% Popup buttom (Method of Interpolatino)
handles.popupmenu1.String = {'linear','nearest','pchip'};

%% output Interp Infomation
handles.pushbutton2.String = {'Interp';'Image2'};

% handles.InterpPoint = plot(;

%%

% Update handles structure
setappdata(hObject,'Image1',Image1);
setappdata(hObject,'Image2',Image2);
guidata(hObject, handles);


% UIWAIT makes TS_DepthAdjGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TS_DepthAdjGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function A = GetNowSlice(handle)
A = uint32( get(handle,'value') * get(handle,'Userdata') + 1);

function SetAxes3Image(handles)
im1 = getimage(handles.axes1);
im2 = getimage(handles.axes2);
sh = TS_SliceReposition(im1(:,:,1),im2(:,:,1));
[~,im2] = TS_Shift2pad_vEachSlice(im1,im2,sh,'crop');
handles.image3.CData = ...
    rgbproj(cat(3,im1,im2),'auto');

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Image = getappdata(hObject.Parent,'Image1');
handles.image1.CData = ...
    rgbproj(Image(:,:,GetNowSlice(handles.slider1),:,:));
handles.text2.String = num2str(GetNowSlice(handles.slider1));
handles.NowPlot.YData = GetNowSlice(handles.slider1);
SetAxes3Image(handles)

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Image = getappdata(hObject.Parent,'Image2');
handles.image2.CData = ...
    rgbproj(Image(:,:,GetNowSlice(handles.slider2),:,:));
handles.text3.String = num2str(GetNowSlice(handles.slider2));
handles.NowPlot.XData = GetNowSlice(handles.slider2);
SetAxes3Image(handles)

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pdata_X = handles.InterpPlot.XData;
pdata_Y = handles.InterpPlot.YData;
Now_X = handles.NowPlot.XData;
Now_Y = handles.NowPlot.YData;
find_point = find(pdata_X == Now_X);
if isempty(find_point)
    Pre_index = pdata_X < Now_X;
    Post_index = pdata_X > Now_X;
    pdata_X = [pdata_X(Pre_index) Now_X pdata_X(Post_index)];
    pdata_Y = [pdata_Y(Pre_index) Now_Y pdata_Y(Post_index)];
else
    pdata_X(find_point) = Now_X;
    pdata_Y(find_point) = Now_Y;
end
handles.InterpPlot.XData = pdata_X;
handles.InterpPlot.YData = pdata_Y;
[vx,vy] = Interp_Plot2Line(pdata_X,pdata_Y,handles.popupmenu1);
handles.InterpPlotLine.XData = vx;
handles.InterpPlotLine.YData = vy;


function [vx,vy] = Interp_Plot2Line(X,Y,popupmenu)
Meth = popupmenu.String{popupmenu.Value};
% Image1 = getappdata(popupmenu.Parent,'Image1');
% vx = 1:size(Image1,3);
vx = [];
vy = [];
X = double(X);
Y = double(Y);
for n = 1:length(Y)-1
    x = X(n):X(n+1);
    try
        y = interp1([x(1) x(end)],[Y(n) Y(n+1)],x,Meth);
    catch err
        disp(err.message)
        y = nan(1,length(x));
    end
    vx = [vx x(1:end-1)];
    vy = [vy y(1:end-1)];
    if n ==length(Y)-1
        vx = [vx x(end)];
        vy = [vy y(end)];
    end
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Image1 = getappdata(handles.figure1,'Image1');
Image2 = getappdata(handles.figure1,'Image2');
X = handles.InterpPlotLine.XData;
Y = handles.InterpPlotLine.YData;


popupmenu = handles.popupmenu1;
Meth = popupmenu.String{popupmenu.Value};
vx = 1:size(Image1,3); %% 
vy = interp1(Y,X,vx,Meth);

%% need check point %%%%%%%%%%%%%%%%%%
vy(vy>size(Image2,3)) = nan;%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% interpolation
% 
% Image2 = permute(Image2,[1 3 2 4 5]);
% siz2 = size(Image2);
% Image2 = reshape(Image2,size(Image2,1),size(Image2,2),[]);
% [interp_X,interp_Y] = meshgrid(vy,1:size(Image2,1));
% outImage = zeros(size(Image2,1),...
%     length(vy),...
%     size(Image2,3),...
%     'like',Image2);
% for n = 1:size(Image2,3)
%     im = Image2(:,:,n);
%     vim = interp2(double(im),interp_X,interp_Y,Meth);
%     outImage(:,:,n) = feval(class(Image2),vim);
% end
% outImage = reshape(outImage,siz2);
% outImage = ipermute(outImage,[1 3 2 4 5]);

data.X = X;
data.Y = Y;
data.vx = vx;
data.vy = vy;
data.Image1 = Image1;
data.Image2 = Image2;
export2wsdlg({'Export to WS'},{'data'},{data},'Save data')

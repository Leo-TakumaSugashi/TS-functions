function varargout = DimFive(varargin)
%
%     Version 2020-Alpha
%
%% HELP DimFive_v~~~
%    DimFive(Image)
%    DimFive(Image,Reso)
%    DimFive(Image,Name)
%    DimFive(...,'close','on') 
%     --> Close property (default is 'on').
%     --> if Close type is 'off', you cannot close gui at one time.
%         but, you can delete gui with command of 'delete' anytime.
%    figure handle = DimFive
% others ...
%    DimFive(Reso)  --> Checnge Resolution at Now Image!!
%    DimFive(Reso,Image,Name)  --> Enable!!
%    DimFive(Image1,Image2,Image3..) 
%             --> if size is equal, Enabel (= cat(5,Image1,Image2,Image3))
% Short cut keies,
%    Term : [Last Click is image handle of figure]
%        w : Depth up 
%        s : Depth down
%        a ; Time back(up)
%        d ; Time advance(down)
%        Alt Click : Context Menu {Colorbar , Save Picture(getframe)}
%      Add Term [viewer type is 'xy']     
%            scroll click  : draw a point ROI (just now Depth and Time)
%            scrol draging : draw a line ROI (just now Depth and Time)
% 
%****  If any issue occur about axes(add plot, image, etc..).***
%*     It might be back up image by next step...               *
%*       1. Edit                                               *
%*       2. Resolution                                         *
%*       3. Apply (Reset View)                                 *
%***************************************************************
%
% Input Type% 
%   Image : 
%       Dimension 5 is Channels (if more than 5, any Dim. will transfer to
%       5 dimmension)
%   Reso  :
%       Resolution == [X Y Z (time)] ,vecotor, ndims ==2
%       if input lenght is 2, Reso = [X Y 1 1]
%   Name
%       charactors
% 
%    * example *
%        load('testdata','fImage','Reso')
%        DimFive(fImage,flip(fImage,3),[4.5  3.9  10],'Test_Image')
%        ...DimFive(Reso)
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ( xyzt Viewer(~2017),n DimFive(2018~) edit by Takuma SUGASHI )%%
%   Thanks for using !                                          %%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% %%  Editional log, %%%%%%%%%%%%%%%%%%%%%%%%%%
% 2017 04 14 , by Takuma Sugashi,
%     edit input type ,
%     delete Depth Auto Adjust system(prototype)
%          It will be Manual Type...soon.             
%     add visible ROI depth Number(ROI)
%     add save picuture at each axes uicontext menu(imh)
%     add measurement ROI menu(ROI)
%     add manual Line measurement program(ROI)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  2017 04 21, by Takuma Sugashi
%     edit manual Line measurement program(ROI), enable check,
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2018 12 22 by Takuma Sugashi,
%    edit for new version(R2018b, and Rename Function Name xyztviewer2017
%    --> DimFive
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2019,09,02 by T.Sugashi
%     edit view all ROI as current view in mip num 
%     modify some bug encord(japanease to english)
%     Add analysis erea for Microglia Analysis in human check.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2020,05,20 by T.Sugashi
%     Input data is enable of output from HKloadLif_vTS and TSloadOif

%% main 
fgh = findobj('Name','DimFive','Type','figure','Tag','DimFive');
input_check = inputsort_cell(varargin{:});
Reso = input_check.Reso;
CloseType = input_check.Close;
Inputdata = input_check.Image;
InputName = input_check.Name;

if ~isempty(fgh)
    if and(~isempty(Inputdata),ndims(Inputdata)>=2)
        data = TSstruct(Inputdata,'Original',Reso);
        AddData(fgh,InputName,data); 
    end
    if and(isempty(Inputdata),~isempty(Reso))
    %% manual input Resolution
        setappdata(fgh,'Resolution',Reso)
        ResetUpView(fgh,...
            getappdata(fgh,'WindowsNUM'),...
            getappdata(fgh,'slwidth'),...
            getappdata(fgh,'ViewerType'))
    end
    figure(fgh)
    if nargout==1
        varargout{1} = fgh;
    end
    return    
end
% Parent figure
figColor = [1 1 1];
fgh = figure('Posi',[100 50 900 800],'NumberTitle','off','Color',figColor,...
    'Name','DimFive','Menubar','none','Toolbar','figure','InvertHardcopy','off',...
    'PaperPositionMode','auto','Renderer','zbuffer',...
    'CloseRequestFcn',@CallbackToolExit,...
    'DeleteFcn',@CallbackDetete,...
    'KeyPressFcn',@KeyPressFcn,...
    'WindowButtonDownFcn',@TSWindowButtonDownFcn,...
    'WindowButtonUpFcn',@TSWindowButtonUpFcn,...
    'Tag','DimFive');
    centerfig(fgh);

% Create Memubar
CreateMenu(fgh)

% Check data
if ~isempty(Inputdata)
    if not(isstruct(Inputdata))
        data = TSstruct(Inputdata,'Original',Reso);
    else
        data = Inputdata;
    end
    InputCheck = true;
else
    InputCheck = false;
end
    

% Default
SetUpDefo(fgh)

% Set Sliderbar
SetUpSliderbar(fgh)

% Set Colormap Red
colormap(gray(256))
SetUimenuEnable(fgh,'off')
if InputCheck
    setappdata(fgh,'NowImageSize',size(data.Image))
    setappdata(fgh,'Nowdata',data)
    setappdata(fgh,'NowROIdata',[])
    setappdata(fgh,'MeanIntensityDIM',3)
    Udata = AddData(fgh,InputName,data,1);
    setappdata(fgh,'NowdataInf',Udata)
    ResetUpView(fgh,getappdata(fgh,'WindowsNUM'),getappdata(fgh,'slwidth'),getappdata(fgh,'ViewerType'))
end
Info.Close = CloseType;
Info.LifDir = cd ; %'\\TS-QVHL1D2\usbdisk2\?????????????????????{???????搶???????f???????[???????^???????֘A';
setappdata(fgh,'InfomationH',Info)

if nargout==1
    varargout{1} = fgh;
end

end

function Input_varargin = inputsort_cell(varargin)
%     narginchk(0,6)
%     Reso_check = ones(1,4);
    CloseType = 'on'; % or off
    Image = [];
    Time_Clock = clock;
    Tname = [num2str(Time_Clock(4)) num2str(Time_Clock(5))];        
    Tname(Tname=='.') = [];
    InputName = ['Inputdata' Tname];
    
    if nargin >= 1 
        if isstruct(varargin{1})
            data = varargin{1};
            Name = data(1).Name;
            if contains(Name,'/') %% lif
                p = strfind(Name,'/');
                InputName = ['Lif_' Name(1:p(end)-1)];
                for nn = 1:length(data)
                    p = strfind(data(nn).Name,'/');
                    data(nn).Name = data(nn).Name(p(end)+1:end);
                    data(nn).Name = ReNameSTR(data(nn).Name);
                end
            elseif contains(Name,'.oif') % Olympus Image format
                data.Name = ReNameSTR(data.Name);
                InputName = ['Olympus_' data.Name];
                InputName = ReNameSTR(InputName);
            else
                for nn = 1:length(data)
                    data(nn).Name = ReNameSTR(data(nn).Name);
                end
            end
            Input_varargin.Reso = data(1).Resolution;
            Input_varargin.Close = CloseType;
            Input_varargin.Image = data;
            Input_varargin.Name = InputName;
            return
        end
        for n = 1:nargin
            if ischar(varargin{n})
                if strcmpi(varargin{n},'close')
                    CloseType = varargin{n+1};
                    varargin{n+1} = [];
                else
                    InputName = varargin{n};
                end
            else            
                if and(ndims(varargin{n})>=2,~isvector(varargin{n})) && ~isstruct(varargin{n})
                    Image = cat(5,Image,varargin{n});
                elseif ismatrix(varargin{n}) && ...
                        isvector(varargin{n}) && ~isstruct(varargin{n})
                    Reso_check = varargin{n};
                    if length(Reso_check)<4
                        Reso_check = padarray(Reso_check,...
                            [0 4-length(Reso_check)],1,'post');
                    end
                elseif isstruct(varargin{n})
                    indata = varargin{n};
                    try
                        Image = indata.Image;
                    catch err
                        error(err.message)
                    end
                    try
                        Reso_check = indata.Resolution;
                    catch
                        try
                            Reso_check = indata.Reso;
                        catch err
                            Reso_check = ones(1,4);
                        end
                    end
                    try
                        InputName = indata.Name;
                    catch err
                    end
                end
            end
        end
    end
    if and(isempty(Image),~exist('Reso_check','var'))
        Reso_check = [];
    elseif ~exist('Reso_check','var')
        Reso_check = ones(1,4) ;
    end
    InputName(InputName=='/') = 'S';
    InputName(InputName==' ') = '';
    InputName(InputName=='\') = 'B';
    InputName(InputName=='.') = 'd';
    InputName = ['Inputdata' InputName];
    
    Input_varargin.Reso = Reso_check;
    Input_varargin.Close = CloseType;
    Input_varargin.Image = Image;
    Input_varargin.Name = InputName;
end

%% ---- Set Defolt -----
function SetUpDefo(fgh,varargin)
setappdata(fgh,'WindowsNUM',1);       %% Number of Windows {1}, 2 , 3 , 4
setappdata(fgh,'ViewerType','xy');    %% viewr type {'xy'},'xz','yz','xyz','xt','yt','xyt'
    MIPdata.Type = 'max';   %% MIP type {'max'},'min','average'
    MIPdata.NUM = 1;        %%???????@MIP????????????????????????????
    MIPdata.Dim = 2;        %%  MIP Dimension  1 , 2 , {3} , 4
setappdata(fgh,'MIP',MIPdata);      %% 
setappdata(fgh,'DataType','Image') %% {'Image'} , 'Processed' (and 'BW')
setappdata(fgh,'Resolution',[1 1 1 1]) %% Resolution[Y X Z T] pixel/um pixel/um pixel/um pixel/ms

setappdata(fgh,'Nowdata',[])
setappdata(fgh,'NowImageSize',nan(1,4))
setappdata(fgh,'NowROIdata',[])
setappdata(fgh,'InfomationH',[])
setappdata(fgh,'MeanIntensityDIM',3)
setappdata(fgh,'NowdataInf',[])
setappdata(fgh,'ROI_AddDepth',0);

% Mous data set
Mdata.OrldSelectionTypeDown.Type = [];
Mdata.OrldSelectionTypeDown.Axes = [];
Mdata.OrldSelectionTypeDown.CurrentPoint = [];
Mdata.OrldSelectionTypeUp.Type = [];
Mdata.OrldSelectionTypeUp.Axes = [];
Mdata.OrldSelectionTypeUp.CurrentPoint = [];
setappdata(fgh,'Mousdata',Mdata)
end

%% ---- Set up slider -----
function SetUpSliderbar(fgh)
    posi = get(fgh,'Posi');
    slWidth = 15;   % slider Bar width
    slLength = 200;
    txtLength_1 = 25;
    txtLength_2 = 200;
    setappdata(fgh,'slwidth',slWidth+5)
    texth(5) = uicontrol('Parent',fgh,'Position',[0 posi(4)-slWidth txtLength_1 slWidth],...
        'Tag','Horiz','BackgroundColor',get(fgh,'Color'),'String','X');
    texth(6) = uicontrol('Parent',fgh,'Position',[0 posi(4)-slWidth*2 txtLength_1 slWidth],...
        'Tag','Vert','BackgroundColor',get(fgh,'Color'),'String','Y');
    texth(7) = uicontrol('Parent',fgh,'Position',[0 posi(4)-slWidth*3 txtLength_1 slWidth],...
        'Tag','Slice','BackgroundColor',get(fgh,'Color'),'String','Z');
    texth(8) = uicontrol('Parent',fgh,'Position',[0 posi(4)-slWidth*4 txtLength_1 slWidth],...
        'Tag','Time','BackgroundColor',get(fgh,'Color'),'String','T');
    
    slh(1) =  uicontrol('Parent',fgh,'Position',[txtLength_1 posi(4)-slWidth slLength slWidth],'Style','slider',...
        'Tag','HorizSlider','BackgroundColor',get(fgh,'Color'));
    slh(2) =  uicontrol('Parent',fgh,'Position',[txtLength_1 posi(4)-slWidth*2 slLength slWidth],'Style','slider',...
        'Tag','VertSlider','BackgroundColor',get(fgh,'Color'));
    slh(3) =  uicontrol('Parent',fgh,'Position',[txtLength_1 posi(4)-slWidth*3 slLength slWidth],'Style','slider',...
        'Tag','SliceSlider','BackgroundColor',get(fgh,'Color'));
    slh(4) =  uicontrol('Parent',fgh,'Position',[txtLength_1 posi(4)-slWidth*4 slLength slWidth],'Style','slider',...
        'Tag','TimeSlider','BackgroundColor',get(fgh,'Color'));
    
    texth(1) = uicontrol('Parent',fgh,'Position',[txtLength_1+slLength posi(4)-slWidth*1 txtLength_2 slWidth],...
        'Tag','NowHroiz','BackgroundColor',get(fgh,'Color'),'String','');
    texth(2) = uicontrol('Parent',fgh,'Position',[txtLength_1+slLength posi(4)-slWidth*2 txtLength_2 slWidth],...
        'Tag','NowVert','BackgroundColor',get(fgh,'Color'),'String','');
    texth(3) = uicontrol('Parent',fgh,'Position',[txtLength_1+slLength posi(4)-slWidth*3 txtLength_2 slWidth],...
        'Tag','NowSlice','BackgroundColor',get(fgh,'Color'),'String','');
    texth(4) = uicontrol('Parent',fgh,'Position',[txtLength_1+slLength posi(4)-slWidth*4 txtLength_2 slWidth],...
        'Tag','NowTime','BackgroundColor',get(fgh,'Color'),'String','');
    set(slh,'Units','normalized','visible','off')
    set(texth,'Units','normalized','Style','text')
    
    drawnow    
    %% Handledata
    Handledata = getappdata(fgh,'Handledata');    
    Handledata.Slider = slh;
    Handledata.Texth = texth;    
    setappdata(fgh,'Handledata',Handledata)
end

function SetUimenuEnable(fgh,type)
if ischar(type)
    type = repmat({type},[5 1]);
end
% Data
h(1) = findobj('Parent',fgh,'Label','Data');
% View
h(2) = findobj('Parent',fgh,'Label','View');
% Edit
h(3) = findobj('Parent',fgh,'Label',' Edit');
% Processed
h(4) = findobj('Parent',fgh,'Label','Image Processing');
% ROI
h(5) = findobj('Parent',fgh,'Label','ROI');
for n = 1:5
    set(h(n),'Enable',type{n})
end
end

%% ----  add Data  ----
function varargout =  AddData(fgh,filename,Newdata,varargin)
% Help
% fgh ...xyztviewr's handle('type','figure')
% filename... Filename--> Data/menu-filename
% Newdata = TSstruct or TSresetdata(for Liffile)
% InputType = 
%      1 --> 1st input
%      2 --> 2nd input for processed image

% point = strfind(filename,'.lif');
% filename = filename(1:point-1);
% barP = strfind(filename,'-');
% filename(barP) = '_';
% barP = strfind(filename,'.');
% filename(barP) = '_';
filename = ReNameSTR(filename);

Dmh = findobj('Parent',fgh,'Label','Data');
ch_Dmh = get(Dmh,'children');
DataName =cell(length(ch_Dmh),1);
for n = 1:length(ch_Dmh)
    DataName{n} = get(ch_Dmh(n),'Label');
end
if nargin>3
    InputType = varargin{1};
else
    InputType = 0;
end

if and(nargin==4,InputType == 2)
Addchil_TF = true;
else
TF = true;
Addchil_TF = false;
while TF
    if nargin==3
    InputNewFileName = inputdlg({'FileName:'},'Input File Name',1,{filename});
    elseif and(nargin==4,InputType==1) %% 1st Input
    InputNewFileName = {filename};
    end    
    if and(and(max(strcmpi(InputNewFileName,DataName)),size(Newdata,2)==1),isscalar(InputNewFileName))
        erh = errordlg('Already exists..','Input FileName','modal');
%         waitfor(erh)
        TF = true;
    else
        try
           InputNewFileName = InputNewFileName{1};
           if ~isempty(InputNewFileName)
               if ~max(strcmpi(InputNewFileName,get(get(Dmh,'Children'),'label')))
                   setappdata(fgh,InputNewFileName,Newdata)
                   TF = false;
               else
                   if isempty(getappdata(fgh,'InputName'))
                       setappdata(fgh,InputNewFileName,Newdata)
                       TF = false;
                   else
                       error('File??')
                   end
               end
           end
        catch err
            errordlg(err.message,'Input FileName','modal');
            TF = true;
        end
    end
end
end

if Addchil_TF %% For Image Processing
 InputNewFileName =  filename;
 uimh = findobj('Parent',Dmh,'Label',InputNewFileName);
 Ad_data = getappdata(fgh,InputNewFileName);
 NUM = size(Ad_data,2) + 1;
 Ad_data(end+1) = Newdata;clear Newdata
 Newdata = Ad_data;
 setappdata(fgh,InputNewFileName,Newdata)
 Userdata.filename = InputNewFileName;
 Userdata.NUM = NUM;
 last_uimh = uimenu(uimh,'Label',Newdata(end).Name,'Userdata',Userdata,'Callback',@Callback_view);
else %% for load lif
 Nnum = ceil(size(Newdata,2)/30);
 jend = 30;
 jstart = 1;
 uimh1 = uimenu(Dmh,'Label',InputNewFileName);
 for i = 1:Nnum
    if Nnum > 1
        uimh = uimenu(uimh1,'Label',['Part' num2str(i)]);
    else  uimh = uimh1;
    end               
    if size(Newdata,2)<jend , jend = size(Newdata,2);
    end        
    for j = jstart:jend                                                                                                                                                                                                                                                                                                                                                                                                                                      
        Userdata.filename = InputNewFileName;
        Userdata.NUM = j;
        last_uimh = uimenu(uimh,'Label',Newdata(j).Name,'Userdata',Userdata,'Callback',@Callback_view);
    end
    jstart = jstart + 30;
    jend   = jend + 30;
 end    
end
%

if nargout==1
    Userdata.filename = InputNewFileName;
    Userdata.NUM = 1;
%     Userdata.last_uimh = last_uimh;
    varargout{1} = Userdata;
end
msgh = msgbox(['Chenge Image-data : ' InputNewFileName]);
waitfor(msgh)
Callback_view(last_uimh)

SetUimenuEnable(fgh,'on')
end

function NewName = ReNameSTR(filename)
point = strfind(filename,'.lif');
if ~isempty(point),filename = filename(1:point-1);end
point = strfind(filename,'.oif');
if ~isempty(point),filename = filename(1:point-1);end

filename(filename=='-') = '_';
filename(filename=='.') = '_';
filename(filename=='%') = '_';
filename(filename=='/') = '_';
filename(filename=='\') = '_';
filename(filename=='"') = '';
NewName = filename;
end

%% make Struct
function data = TSstruct(Inputdata,Name,varargin)
data.Name = Name;
if nargin>2, Reso = varargin{1};
    if length(Reso)<4, Reso = [Reso 1 1 1 1];Reso(5:end) = [];
    end
else Reso = ones(1,4);
end
[y,x,z,t,ch,oth] = size(Inputdata);
data.FOV = [(x-1)*Reso(1) (y-1)*Reso(2) (z-1)*Reso(3) (t-1)*Reso(4)];
data.Unit = '[(X,Dim.1)m (Y,Dim.2)m (Z,Dim.3)m (T,Dim.4)? channels]';
data.Resolution = Reso;
if oth>1
    wah = warndlg('Input dim. is over 5. Reshape(Input Image,[y x z t ch*otherDim.])');
    waitfor(wah)
    Inputdata = reshape(Inputdata,[y x z t ch*oth]);
end
data.Image = Inputdata;
clear Chenddata
data.Maximum = max(Inputdata(:));
data.Minimum = min(Inputdata(:));
data.Size = [x y z t ch*oth];
data.ChannelsNUM = size(Inputdata,5);
end

%% =====  Re-Set Up Fcn  ===== %%
function ResetUpView(fgh,WindowsNUM,slWidth,Type)
Handles = getappdata(fgh,'Handledata');
% ROI
setappdata(fgh,'NowROIdata',ROI2matdata(fgh))
[subfghP,MIPposition]  = GetSubFigPosi(fgh,WindowsNUM,slWidth);
% Reset Uipanel and DataType
% if isfield(Handles,'subfgh')
%     Uiph = Handles.subfgh;
% else
    Uiph = findobj('parent',fgh,'Type','Uipanel');
% end
if and(~isempty(Uiph),ishandle(Uiph))
    for k = 1:length(Uiph)
        delete(Uiph(k))
    end
end
setappdata(fgh,'DataType','Image') %% old viewer ...
%%  MIP Panel
Children(1).Posi = [.01 .1 .2 .4];
Children(2).Posi = [.22 .1 .2 .4];
Children(3).Posi = [.45 .01 .2 .45];
Children(4).Posi = [.7 .1 .25 .8];
Children(5).Posi = [  0 .51 .2 .4];
Children(6).Posi = [.22 .51 .2 .4];
Children(7).Posi = [.45 .51 .2 .4];
% if ~isfield(Handles,'ProjectionPanelH')
uiph = uipanel(fgh,'Position',MIPposition,'Title','Projection Menu',...
    'ForegroundColor',[1 1 1]/6,'BackgroundColor',fgh.Color,'FontSize',11);
uich(5) = uicontrol(uiph,'Unit','Normalized','position',Children(5).Posi,'String','Type');
uich(6) = uicontrol(uiph,'Unit','Normalized','position',Children(6).Posi,'String','Dim.');
uich(7) = uicontrol(uiph,'Unit','Normalized','position',Children(7).Posi,'String','Num.');
set(uich(5:7),'style','text','ForegroundColor',[1 1 1]/10,'BackgroundColor',fgh.Color)

%% MIP Type {'max','average','min','Median','SD','RGB'} %%
uich(1) = uicontrol(uiph,'Unit','Normalized','position',Children(1).Posi,...
    'String',{'max','average','min','Median','SD','RGB'},'Style','popup');
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uich(2) = uicontrol(uiph,'Unit','Normalized','position',Children(2).Posi,...
    'String',{'1','2','3','4','5'},'Style','popup','value',3);
uich(3) = uicontrol(uiph,'Unit','Normalized','position',Children(3).Posi,...
    'String','1','Style','edit');
uich(4) = uicontrol(uiph,'Unit','Normalized','position',Children(4).Posi,...
    'String','Apply','Callback',@Callback_MIP,...
    'ForegroundColor',[1 1 1]/10,'BackgroundColor',fgh.Color/1.1);
set(uich(4),'userdata',uich)
Handles.ProjectionPanelH = [uiph uich];
% else
%     uiph = Handles.ProjectionPanelH(1);
%     uich = Handles.ProjectionPanelH(2:end);
%     uiph.Position = MIPposition;
%     for k = 1:length(Children)
%         uich(k).Position = Children(k).Posi;
%     end    
% end
    
%% MIP Control
MIPdata.Type = 'max';   %% MIP type {'max'},'min','average'
MIPdata.NUM = 1;        %%???????@MIP????????????????????????????
MIPdata.Dim = 3;        %%  MIP Dimension  1 , 2 , {3} , 4
switch lower(Type)
    case {'xy','xz','yz','xt','yt'}
        switch lower(Type)
            case {'xy'}
                set(uich(2),'Value',3)
                MIPdata.Dim = 3;
            case {'xz','xt'}
                set(uich(2),'Value',2)
                MIPdata.Dim = 2;
            case {'yz','yt'}
                set(uich(2),'Value',1)
                MIPdata.Dim = 1;
        end
        set(uich(2),'visible','on')
    case {'xyz','xyt'}
        set(uich(2),'visible','off')
    otherwise
        warndlg({'This Viewer type is not enable.'...
            'Please wait updating....by Sugashi.'})
end
setappdata(fgh,'MIP',MIPdata);      %% 

% Reset Invisible Uimenu
%%
subfgh = zeros(WindowsNUM,1);
axh_struct(1:WindowsNUM) = struct('axes_handle',[]);
for n = 1:WindowsNUM
    subfgh(n) = uipanel('Parent',fgh,'Position',subfghP(n).position,'BackgroundColor',get(fgh,'Color'),'Tag','ViewerPanel');
    axh_struct(n).axes_handle = MakeAxes(subfgh(n),Type);
end
Handles.subfgh = subfgh;
Handles.Axes = axh_struct;
setappdata(fgh,'Handledata',Handles)
clear Handles
%%%%%%%%%%%%%%%%%%%%
%  getappdata(subfgh(1))
%%%%%%%%%%%%%%%%%%%
SetUpData(fgh)
SetappROIdata(fgh)
Handles = getappdata(fgh,'Handledata');
CallbackSlider(Handles.Slider(1))

   %% Add impixels info

% h = findobj('Parent',fgh,'Tag','pixelinfo panel');
if isfield(Handles,'impixelinfoH')
    if ~ishandle(Handles.impixelinfoH)
        Handles.impixelinfoH = impixelinfo;
    end
else
    Handles.impixelinfoH = impixelinfo;
end
ch = Handles.impixelinfoH.Children;
ch(2).String = 'Pixels Info.';
axh  = findobj(Handles.subfgh,'Type','axes');

%% add colorbar
for n = 1:length(axh)
    ImageHandle = findobj(axh(n),'Type','Image');
    TFh = findobj(ImageHandle.UIContextMenu,'Label','Add Colorbar');
    if isempty(TFh)
        Addcolorbarh = uimenu(ImageHandle.UIContextMenu,'Label','Add Colorbar');
        uimenu(Addcolorbarh,'Label','EastOutside','Callback',@Callback_addColorbar)
        uimenu(Addcolorbarh,'Label','SouthOutside','Callback',@Callback_addColorbar)
    end
    TFh = findobj(ImageHandle.UIContextMenu,'Label','Save Picture');
    if isempty(TFh)
        uimenu(ImageHandle.UIContextMenu,'Label','Save Picture',...
            'Callback',@Callback_AxesSavePicture);
    end
end
    function Callback_addColorbar(oh,~)
        naxh = gca;
        h = colorbar(naxh,oh.Label);
        switch lower(oh.Label)
            case 'eastoutside'
                h.Position = [.9 .1 .03 .8];
            case 'southoutside'
                h.Position = [.1 .08 .8 .03];
        end
    end
    function Callback_AxesSavePicture(oh,~)
        naxh = gca;
        INPUT = inputdlg('Name : ','',1,{'*.tif'});
        if isempty(INPUT)
            return
        else
            INPUT = INPUT{1};
        end
        im = getframe(naxh);
        imwrite(im.cdata,INPUT)
    end
   %% Add Check memory
[Persentage,STR]= TS_checkmem;
if isfield(Handles,'memoryH')
    memh = Handles.memoryH;
    memh(3).String = STR;
    memh(2).XData = [0 Persentage];
    if Persentage<20
        memh(2).Color = [1 0 0];
    else
        memh(2).Color = [0 0 1];
    end
else
    memh(1) = axes('Parent',fgh,'Position',[.6  0  .4  .025]);    
    memh(2) = plot(memh(1),[0 Persentage],[0 0],'Linewidth',8);
    memh(3) = text(memh(1),140,0,STR);
    memh(1).XDir = 'reverse';
%     memh(1).Visible = 'off';
    memh(1).XLim = [0 100];
    memh(1).XTickLabel = '';
    memh(1).YTickLabel = '';
    Handles.memoryH = memh;
    
end

%% save Handle's data
setappdata(fgh,'Handledata',Handles)
end

function [A,varargout] = GetSubFigPosi(fgh,ChannelsNUM,Lowmargin)
% posi = get(fgh,'Position'); %% ver.2014
posi = fgh.Position; %% ver.2016
width = posi(3);
high  = posi(4);
Topmargin = 65; %% Top margin
MipPosiwidth = 260;
MIPposition = [(width-MipPosiwidth-3)/width (high-Topmargin+3)/high (MipPosiwidth-18)/width (Topmargin-5)/high];
if nargout>1
    varargout{1} = MIPposition;
end
% InfPosi = [2/width (high-popupHigh+3)/high (width-MipPosiwidth-10)/width (popupHigh-5)/high];
switch ChannelsNUM
    case 1
        A.position = [0 Lowmargin/high 1 (high-Lowmargin-Topmargin)/high];
    case 2
        A(1).position = [0 Lowmargin/high 1/2 (high-Lowmargin-Topmargin)/high];
        A(2).position = [1/2 Lowmargin/high 1/2 (high-Lowmargin-Topmargin)/high];
    case 3
        A(1).position = [0 Lowmargin/high 1/3 (high-Lowmargin-Topmargin)/high];
        A(2).position = [1/3 Lowmargin/high 1/3 (high-Lowmargin-Topmargin)/high];
        A(3).position = [2/3 Lowmargin/high 1/3 (high-Lowmargin-Topmargin)/high];
    case 4
        A(1).position = [0 Lowmargin/high+(high-Lowmargin-Topmargin)/high/2 1/2 (high-Lowmargin-Topmargin)/high/2];
        A(2).position = [1/2 Lowmargin/high+(high-Lowmargin-Topmargin)/high/2 ...
            1/2 (high-Lowmargin-Topmargin)/high/2];
        A(3).position = [0 Lowmargin/high 1/2 (high-Lowmargin-Topmargin)/high/2];
        A(4).position = [1/2 Lowmargin/high 1/2 (high-Lowmargin-Topmargin)/high/2];
    case 6
        A(1).position = [0 Lowmargin/high+(high-Lowmargin-Topmargin)/high/2 ...
            1/3 (high-Lowmargin-Topmargin)/high/2];
        A(2).position = [1/3 Lowmargin/high+(high-Lowmargin-Topmargin)/high/2 ...
            1/3 (high-Lowmargin-Topmargin)/high/2];
        A(3).position = [2/3 Lowmargin/high+(high-Lowmargin-Topmargin)/high/2 ...
            1/3 (high-Lowmargin-Topmargin)/high/2];
        A(4).position = [0 Lowmargin/high 1/3 (high-Lowmargin-Topmargin)/high/2];
        A(5).position = [1/3 Lowmargin/high 1/3 (high-Lowmargin-Topmargin)/high/2];
        A(6).position = [2/3 Lowmargin/high 1/3 (high-Lowmargin-Topmargin)/high/2];
     case 8
        A(1).position = [0 Lowmargin/high+(high-Lowmargin-Topmargin)/high/2 ...
            1/4 (high-Lowmargin-Topmargin)/high/2];
        A(2).position = [1/4 Lowmargin/high+(high-Lowmargin-Topmargin)/high/2 ...
            1/4 (high-Lowmargin-Topmargin)/high/2];
        A(3).position = [2/4 Lowmargin/high+(high-Lowmargin-Topmargin)/high/2 ...
            1/4 (high-Lowmargin-Topmargin)/high/2];
        A(4).position = [3/4 Lowmargin/high+(high-Lowmargin-Topmargin)/high/2 ...
            1/4 (high-Lowmargin-Topmargin)/high/2];
        A(5).position = [0 Lowmargin/high 1/4 (high-Lowmargin-Topmargin)/high/2];
        A(6).position = [1/4 Lowmargin/high 1/4 (high-Lowmargin-Topmargin)/high/2];
        A(7).position = [2/4 Lowmargin/high 1/4 (high-Lowmargin-Topmargin)/high/2];        
        A(8).position = [3/4 Lowmargin/high 1/4 (high-Lowmargin-Topmargin)/high/2];        
end
end

%% Make Axes
function varargout = MakeAxes(subfgh,Type)
subfghPosi = get(subfgh,'Position').*get(get(subfgh,'Parent'),'Position');
switch lower(Type)
    case {'xy','xz','yz','xt','yt'}        
        uih = uicontrol('Parent',subfgh,'String','Channels : 1','Position',[0 0 subfghPosi(3) 20],'Callback',@Callback_ChoiceChannels);
        set(uih,'Units','normalized')
        figPosi = get(get(subfgh,'Parent'),'Position');
        subfghPosi = get(subfgh,'Position').*figPosi;
        axh = axes('Parent',subfgh,...
            'Position',[0.001 0.001+25/subfghPosi(4) 1-0.002 1-0.002-25/subfghPosi(4)]);
    case {'xyz','xyt'}
        axh(1) = axes('Parent',subfgh,'Position',[0.005 0.505 0.490 0.490]);
        axh(2) = axes('Parent',subfgh,'Position',[0.505 0.505 0.490 0.490]);
        axh(3) = axes('Parent',subfgh,'Position',[0.005 0.005 0.490 0.490]);
        uih = uicontrol('Parent',subfgh,'String','Channels : 1','Position',[subfghPosi(3)-200 0 200 20],'Callback',@Callback_ChoiceChannels);
        set(uih,'Units','normalized')
end
setappdata(subfgh,'axh',axh)
set(uih,'Userdata',1) %% Channels Indx
Nowdata = getappdata(get(subfgh,'Parent'),'Nowdata');
if size(Nowdata.Image,5) == 1
    set(uih,'visible','off')
end
if nargout>0 , varargout{1} = axh;end
end

%% 1st Function of 'imgaesc'
function SetUpData(fgh)
WindowsNUM = getappdata(fgh,'WindowsNUM') ;
Type = getappdata(fgh,'ViewerType') ;
Reso = getappdata(fgh,'Resolution');
data = getappdata(fgh,'Nowdata');
Handles = getappdata(fgh,'Handledata');
% slh(1) = findobj('Parent',fgh,'Tag','TimeSlider');
% slh(2) = findobj('Parent',fgh,'Tag','SliceSlider');
slh = Handles.Slider;
txh = Handles.Texth;
set(slh,'Callback',[],'userdata',[],'Visible','on');
set(txh(1:4),'Visible','on');
Image = data.Image;
[Y,X,Z,T,~] = size(Image);
CheckDims(fgh,Z,T) %% Menu bar check
    function CheckDims(fgh,Z,T)
        Ph = findobj('Parent',findobj('Parent',fgh,'Label','View'),'Label','Style');
        xyH = findobj('Parent',Ph,'userdata','xy');
        xzH = findobj('Parent',Ph,'userdata','xz');
        yzH = findobj('Parent',Ph,'userdata','yz');
        xyzH = findobj('Parent',Ph,'userdata','xyz');
        xtH = findobj('Parent',Ph,'userdata','xt');
        ytH = findobj('Parent',Ph,'userdata','yt');
        xytH = findobj('Parent',Ph,'userdata','xyt');        
        set([xyH yzH xyzH xtH ytH xytH],'Enable','on')
        if Z==1
            set([xzH yzH xyzH],'Enable','off')
        end
        if T==1
            set([xtH ytH xytH],'Enable','off')
        end
    end

subfgh = findobj('Parent',fgh,'Tag','ViewerPanel');

xlen = (X-1) * Reso(1);
ylen = (Y-1) * Reso(2);
zlen = (Z-1) * Reso(3);
% tlen = (T-1) * Reso(4);
tlen = (xlen+ylen)/2;
axgaps = .000001;
for n = 1:WindowsNUM
    h = subfgh(end-n+1);
    popupH = findobj('Parent',h,'Style','pushbutton');
    CH = get(popupH,'Userdata');
    setappdata(h,'NowChannles',CH)
%     get(h,'UIcontextMenu')  %%%%%%%
    axh = getappdata(h,'axh');    
    switch Type
        case 'xy'
            set(axh,'tag',[Type 'axes'])
            im = rgbproj(squeeze(Image(:,:,end,1,CH)),axh.CLimMode); %% NewFunc.
            imh = imagesc('Parent',axh,'cdata',im,'Tag',['img' Type]);
            axis(axh,'image')
            daspect(axh,[Reso(2) Reso(1) 1]) %% XY
            SliderSetUp(slh,[0 0 Z T])
        case 'xz'
            set(axh,'tag',[Type 'axes'])
            im = rgbproj(squeeze(Image(Y,:,:,1,CH)),axh.CLimMode); %% New Func.2016
            imh = imagesc('Parent',axh,'cdata',imrotate(im,90),'Tag',['img' Type]);
            axis(axh,'image')
            daspect(axh,[Reso(3) Reso(1) 1])
            SliderSetUp(slh,[0 Y 0 T])
        case 'yz'
            set(axh,'tag',[Type 'axes'])
            im = rgbproj(squeeze(Image(:,X,:,1,CH)),axh.CLimMode);
            imh = imagesc('Parent',axh,'cdata',flip(imrotate(im,90),2),'Tag',['img' Type]);
            axis(axh,'image')
            daspect(axh,[Reso(3) Reso(2) 1])
            SliderSetUp(slh,[X 0 0 T])  
        case 'xt'
            set(axh,'tag',[Type 'axes'])
            im = rgbproj(squeeze(Image(1,:,1,:,CH)),axh.CLimMode);
            imh = imagesc('Parent',axh,'cdata',im,'Tag',['img' Type]);
            axis(axh,'tight')
            SliderSetUp(slh,[0 Y Z 0])
        case 'yt'
            set(axh,'tag',[Type 'axes'])
            im = rgbproj(squeeze(Image(:,1,1,:,CH)),axh.CLimMode);
            imh = imagesc('Parent',axh,'cdata',im,'Tag',['img' Type]);
            axis(axh,'tight')
            SliderSetUp(slh,[X 0 Z 0])
        case 'xyz'
            ReSetUpAxesPosition(axh,xlen,ylen,zlen,axgaps)            
            imh(1) = imagesc('Parent',axh(1),'cdata',...
                rgbproj(squeeze(Image(:,:,Z,1,CH)),axh(1).CLimMode),'Tag','imgXY');
            imh(2) = imagesc('Parent',axh(2),'cdata',...
                flip(rgbproj(squeeze(Image(:,X,:,1,CH)),axh(2).CLimMode),2),'Tag','imgYZ');
            imh(3) = imagesc('Parent',axh(3),'cdata',...
                imrotate(rgbproj(squeeze(Image(Y,:,:,1,CH)),axh(3).CLimMode),90),'Tag','imgXZ');
            for num = 1:length(axh)
                axis(axh(num),'tight')
            end
            daspect(axh(1),[Reso(2)/Reso(1) 1 1]) %% XY
            daspect(axh(2),[Reso(2)/Reso(3) 1 1]) %% ZY
            daspect(axh(3),[1 Reso(1)/Reso(3) 1]) %% XZ
            for num = 1:length(axh)
                axh(num).NextPlot = 'add';
            end
            SliderImlineSetUp([axh(3) axh(2) axh(1)],X,Y,Z)
            SliderSetUp(slh,[X Y Z T])
        case 'xyt'
            imh(1) = imagesc('Parent',axh(1),'cdata',...
                rgbproj(squeeze(Image(:,:,1,1,CH)),axh(1).CLimMode),'Tag','imgXY');
            imh(2) = imagesc('Parent',axh(2),'cdata',...
                rgbproj(squeeze(Image(:,1,1,:,CH)),axh(2).CLimMode),'Tag','imgYT');
            im = rgbproj(squeeze(Image(1,:,1,:,CH)),axh.CLimMode)';
            imh(3) = imagesc('Parent',axh(3),'cdata',im,'Tag','imgXT');
            for num = 1:length(axh)
                axis(axh(num),'tight')
            end
            daspect(axh(1),[Reso(2)/Reso(1) 1 1]) %% XY
            for num = 1:length(axh)
                axh(num).NextPlot = 'add';
            end
            SliderImlineSetUp(flip(axh),X,Y,T)
            SliderSetUp(slh,[X Y Z T]) 
    end
    set(axh,'ydir','reverse','Visible','off') %%
    setappdata(h,'imh',imh)
%     set(axh,'Clim',[0 1]);
end
     
    function SliderSetUp(slh,xyzt)
        for sln=1:length(xyzt)
        if xyzt(sln)>1 
            set(slh(sln),'Callback',@CallbackSlider,'SliderStep',[1/(xyzt(sln)-1) 10/(xyzt(sln)-1)],...
                'Value',0,'userdata',xyzt(sln)-1,'visible','on')
        else set(slh(sln),'visible','off')
        end
        end
    end    
    % SliderImline Set Up
    function SliderImlineSetUp(axh,X,Y,Z)
        H(1:2) = SliderImline(axh(3),[0.5 Y+0.5 ; X+0.5 Y+0.5],[0 1 0]);
        H(3:4) = SliderImline(axh(3),[X+0.5 0.5 ; X+0.5 Y+0.5],[1 0 0]);
        H(5:6) = SliderImline(axh(2),[0.5   0.5 ; 0.5   Y+0.5],[0 0 1]);
        H(7:8) = SliderImline(axh(2),[0.5 Y+0.5 ; Z+0.5 Y+0.5],[0 1 0]);
        H(9:10) = SliderImline(axh(1),[X+0.5 0.5 ; 0.5   0.5  ],[0 0 1]);
        H(11:12) = SliderImline(axh(1),[X+0.5 0.5 ; X+0.5 Z+0.5],[1 0 0]);
        setappdata(axh(1).Parent,'LineH',H)
    end

    function ReSetUpAxesPosition(axh,xlen,ylen,zlen,axgaps)
        Posi = [0 0 1 1];
        axh(1).Position = [axgaps          Posi(4)*zlen/(ylen+zlen+axgaps) ...
                      Posi(3)*xlen/(xlen+zlen+2*axgaps)   Posi(4)*ylen/(ylen+zlen+axgaps)];
        axh(2).Position = [Posi(3)*(xlen+axgaps)/(xlen+zlen+2*axgaps)    Posi(4)*zlen/(ylen+zlen+axgaps) ...
                      Posi(3)*zlen/(xlen+zlen+2*axgaps)   Posi(4)*ylen/(ylen+zlen+axgaps)];
        axh(3).Position = [axgaps    axgaps...
                      Posi(3)*xlen/(xlen+zlen+2*axgaps)   Posi(4)*zlen/(ylen+zlen+axgaps)];
                  drawnow     
    end
end

%% ----  Channels Choice  ----
function Callback_ChoiceChannels(oh,~)
subfgh = get(oh,'Parent');
fgh = get(subfgh,'Parent');
Handles = getappdata(fgh,'Handledata');
PPH = Handles.ProjectionPanelH;
Type = getappdata(fgh,'ViewerType') ;
data = getappdata(fgh,'Nowdata');
ChannelsNUM = size(data.Image,5); %data.ChannelsNUM;
DataName = cell(ChannelsNUM,1);
for n=1:ChannelsNUM,DataName{n} = num2str(n);   end
[CH,ok] = listdlg('PromptString','Select Channels',...
    'SelectionMode','multiple','ListString',DataName);

if ok
    if and(numel(CH)>1,strcmpi(PPH(2).String(PPH(2).Value),'RGB'))
        errordlg('Change Type at Projection Menu');
        return        
    end
    set(oh,'Userdata',CH,...
        'String',['Channels :' num2str(CH)])
    setappdata(subfgh,'NowChannles',CH);
    
    ResetView(subfgh,fgh,Type)
    if numel(CH) == 1
        PPH(2).String = {'max','average','min','Median','SD','RGB'};
    else
        PPH(2).String = {'max','average','min','Median','SD'};
    end
end
end

%% ----  Slider line / ViewType[xyz xyt]  ----
function h = SliderImline(axh,posi,Color)
h(1) = plot(axh,posi(:,1),posi(:,2),'-',...
    'Color',ones(1,3)/2,'Linewidth',2.5);
h(2) = plot(axh,posi(:,1),posi(:,2),'--',...
    'Color',Color,'Linewidth',2);
end

%% ---- CallbackSlider & MIP  ----
function A = GetCenterNow(Dim,varargin)
if nargin>1
    fgh = varargin{1};
else
    fgh = findobj('Name','DimFive','Type','figure','Tag','DimFive');
end 
h = getappdata(fgh,'Handledata');
if Dim == 5
    A = uint32(1);
    return
end
A = uint32(h.Slider(Dim).Value*get(h.Slider(Dim),'Userdata')+1);
if isempty(A), A = uint32(1); end
end

%% Callback Slider
function CallbackSlider(oh,~)
fgh = oh.Parent;
WindowsNUM = getappdata(fgh,'WindowsNUM'); 
Type = getappdata(fgh,'ViewerType') ;
subfgh = findobj('parent',fgh,'Tag','ViewerPanel');
for n = 1:WindowsNUM
    ResetView(subfgh(end-n+1),fgh,Type)
end
ResetInfo(fgh)
end

%% ===================ResetView ===============================================
% Set of Image each uipanels(Nowsubfgh)
% 2nd Function of 'imagesc'
function ResetView(Nowsubfgh,fgh,Type)

try
Image = getappdata(fgh,'Nowdata');
NowChannels = getappdata(Nowsubfgh,'NowChannles');
Image = Image.Image;
[Y,X,Z,T,CH,Other] = size(Image);
if Other>1,warndlg('Input Dimmenssion is over 5...'),end
siz = [X Y Z T CH];
Ind(1:5) = struct('Ind',[]);
for k = 1:5
    Ind(k).Ind = 1:siz(k);
end


MIPdata = getappdata(get(Nowsubfgh,'Parent'),'MIP');

XXX = GetCenterNow(MIPdata.Dim);

%     MIPdata.Type = 'max';   %% MIP type {'max'},'min','average','color'
%     MIPdata.NUM = 1;        %%???????@MIP????????????????????????????
%     MIPdata.Dim = 3;        %%  MIP Dimension  x1 , y2 , z{3} , t4

Range = and(Ind(MIPdata.Dim).Ind>=XXX,...
            Ind(MIPdata.Dim).Ind<=XXX+MIPdata.NUM-1);

% axh = findobj('parent',Nowsubfgh,'type','axes');
axh = getappdata(Nowsubfgh,'axh');
imgh = getappdata(Nowsubfgh,'imh');
ClimMode = get(axh(1),'ClimMode');
if strcmpi(ClimMode,'manual')
clear ClimMode
Map = GetColorChannels(CH);
ClimMode.Color = Map(NowChannels,:);
ClimMode.Gamma = 1;
ClimMode.CLim = get(axh(1),'CLim');
end


switch Type
    case 'xy' %% MIPdata.Dim = 3 or 4
%         imgh = findobj('Parent',axh(end),'tag','imgxy');
        if MIPdata.Dim == 3
            Image = squeeze(feval(MIPdata.Type,Image(:,:,Range,GetCenterNow(4,fgh),NowChannels),[],3));
        elseif MIPdata.Dim==4
            Image = squeeze(feval(MIPdata.Type,Image(:,:,GetCenterNow(3,fgh),Range,NowChannels),[],4));
        else Image = squeeze(Image(:,:,GetCenterNow(3,fgh),GetCenterNow(4,fgh),NowChannels));
        end 
    case 'xz'  %% MIPdata.Dim = 2 or 4
%         imgh = findobj('Parent',axh(end),'tag','imgxz');
        if MIPdata.Dim == 2
            Image = squeeze(feval(MIPdata.Type,Image(Range,:,:,GetCenterNow(4,fgh),NowChannels),[],1));
        elseif MIPdata.Dim==4
            Image = squeeze(feval(MIPdata.Type,Image(GetCenterNow(2,fgh),:,:,Range,NowChannels),[],4));
        else Image = squeeze(Image(GetCenterNow(2,fgh),:,:,GetCenterNow(4,fgh),NowChannels));
        end 
        Image = imrotate(Image,90);
    case 'yz'  %% MIPdata.Dim = 1 or 4
%         imgh = findobj('Parent',axh(end),'tag','imgyz');
        if MIPdata.Dim == 1
            Image = squeeze(feval(MIPdata.Type,Image(:,Range,:,GetCenterNow(4,fgh),NowChannels),[],2));
        elseif MIPdata.Dim == 4
            Image = squeeze(feval(MIPdata.Type,Image(:,GetCenterNow(1,fgh),:,Range,NowChannels),[],4));
        else Image = squeeze(Image(:,GetCenterNow(1,fgh),:,GetCenterNow(4,fgh),NowChannels));
        end 
        Image = flip(imrotate(Image,90),2);
    case 'xt'  %% MIPdata.Dim = 2 or 3
%         imgh = findobj('Parent',axh(end),'tag','imgxt');
        if MIPdata.Dim == 2
            Image = squeeze(feval(MIPdata.Type,Image(Range,:,GetCenterNow(3,fgh),:,NowChannels),[],1));
        elseif MIPdata.Dim == 3
            Image = squeeze(feval(MIPdata.Type,Image(GetCenterNow(2,fgh),:,Range,GetCenterNow(4,fgh),NowChannels),[],3));
        else Image = squeeze(Image(GetCenterNow(2,fgh),:,GetCenterNow(3,fgh),:,NowChannels));
        end 
%         Image = flip(imrotate(Image,270),2);
    case 'yt'   %% MIPdata.Dim = 1 or 3
%         imgh = findobj('Parent',axh(end),'Tag','imgyt');
        if MIPdata.Dim == 3
            Image = squeeze(feval(MIPdata.Type,Image(:,GetCenterNow(1,fgh),Range,:,NowChannels),[],3));
        elseif MIPdata.Dim == 1
            Image = squeeze(feval(MIPdata.Type,Image(:,Range,GetCenterNow(3,fgh),:,NowChannels),[],2));
        else Image = squeeze(Image(:,GetCenterNow(1,fgh),GetCenterNow(3,fgh),:,NowChannels));
        end 
%         Image = imrotate(Image,270);
    case {'xyz','xyt'}
%         imgh = findobj('Parent',axh(end),'tag','imgXY');
            % % == left top == % %
        if strcmpi(Type,'xyz')            
            Range = and(Ind(3).Ind>=GetCenterNow(3),...
                Ind(3).Ind<=GetCenterNow(3)+MIPdata.NUM-1);
            im = squeeze(feval(MIPdata.Type,Image(:,:,Range,GetCenterNow(4,fgh),NowChannels),[],3));
        else
            Range = and(Ind(4).Ind>=GetCenterNow(4),...
                Ind(4).Ind<=GetCenterNow(4)+MIPdata.NUM-1);
            im = squeeze(feval(MIPdata.Type,Image(:,:,GetCenterNow(3,fgh),Range,NowChannels),[],4));
        end
            set(imgh(1),'cdata',rgbproj(im,ClimMode))
            
            % % == right top == % %
%         imghyz = findobj('Parent',axh(2),'tag','imgYZ');
            Range = and(Ind(1).Ind>=GetCenterNow(1),...
                Ind(1).Ind<=GetCenterNow(1)+MIPdata.NUM-1);            
        if strcmpi(Type,'xyz')            
            im = squeeze(feval(MIPdata.Type,Image(:,Range,:,GetCenterNow(4,fgh),NowChannels),[],2));
%             im = flip(im,2);
        else            
            im = squeeze(feval(MIPdata.Type,Image(:,Range,GetCenterNow(3,fgh),:,NowChannels),[],2));
        end
            set(imgh(2),'cdata',rgbproj(im,ClimMode))        
        
            % % == left under == % %
%         imghxz = findobj('Parent',axh(1),'tag','imgXZ');        
            Range = and(Ind(2).Ind>=GetCenterNow(2),...
                Ind(2).Ind<=GetCenterNow(2)+MIPdata.NUM-1);
        if strcmpi(Type,'xyz')
            im = squeeze(feval(MIPdata.Type,Image(Range,:,:,GetCenterNow(4,fgh),NowChannels),[],1));
            im = flip(imrotate(im,90),1);
        else
            im = squeeze(feval(MIPdata.Type,Image(Range,:,GetCenterNow(3,fgh),:,NowChannels),[],1));
            im = permute(im,[2 1 3]);
        end 
            set(imgh(3),'cdata',rgbproj(im,ClimMode))
        return
    otherwise
        return
end
if ~ismatrix(Image)
    set(imgh,'cdata',rgbproj(Image,ClimMode))
else
set(imgh,'cdata',Image)
% set(get(imgh,'Parent'),'ClimMode',ClimMode) 
end

ViewROI(fgh,ROI_VisibleTypeCheck(fgh))
catch err
    disp(' ===== Error Line ====== ')
    for n = 1:length(err.stack)
    disp(['Num.: ' num2str(n)])
    disp(['   name : ' err.stack(n).name])
    disp(['   line : ' num2str(err.stack(n).line)])
    end
    disp(' ======================= ')
    errordlg({err.message;err.identifier;num2str(err.stack(1).line)},'Error : ResetView','modal');
end


    %% Line View update
ROIviewH = findobj('Tag',['ROIview' num2str(fgh.Number)]);
if isempty(ROIviewH)
    return
end
if strcmpi(ROIviewH.Title,'ROI Mean Intensity View')
    return
end
ROIdata = getappdata(fgh,'NowROIdata');
if isempty(ROIdata)
    return
end
for n = 1:length(ROIdata)
    h = ROIdata(n).handle;
    try
    Userdata = get(h,'Userdata');
    h = Userdata.handle;
    Userdata = get(h,'Userdata');
    ROIdata = getappdata(fgh,'NowROIdata');
    Lineobh = ROIdata(Userdata.NUM).Lineobh;
    Reso = getappdata(fgh,'Resolution');
    Nowsubfgh = findobj('Parent',fgh,'Tag','ViewerPanel');
    ImAxh = getappdata(Nowsubfgh,'axh');
    if and(~isempty(Lineobh),max(strcmpi(class(h),{'imline','line'})))
        SliceImage = single(getimage(ImAxh));
        Posi = getPosition(h);
        Len = diff(Posi,1,1);
        Len = sqrt(sum(Len.^2,2));
        PixNum = max(round(Len /(Reso(1)/10))+1,31);
        NewReso = Len/(PixNum-1);
        vx = linspace(Posi(1,1),Posi(2,1),PixNum);
        vy = linspace(Posi(1,2),Posi(2,2),PixNum);
        if size(SliceImage,3)
            im = single(SliceImage(:,:,1));
        else
            im = single(SliceImage);
        end
        A = interp2(im,vx,vy);
        XDATA = (0:PixNum-1)*NewReso;
        XDATA = XDATA - (mean(XDATA(XDATA>0)));
        set(Lineobh,'Ydata',A,'XData',XDATA,'Color',getColor(h))
    end
    catch err
        disp(err.message)
    end
end
toc
end
% ResetView ===============================================

%% ResetInfo
function ResetInfo(fgh)
Handledata  = getappdata(fgh,'Handledata');
Reso  = getappdata(fgh,'Resolution');
Nowdata = getappdata(fgh,'Nowdata');
% siz = getappdata(fgh,'NowImageSize');
siz = size(Nowdata.Image);
if length(siz)<5
    siz = [siz nan nan nan];
end
siz(1:2) = flip(siz(1:2));
unit = {' um';' um';' um';' ms'};
for n = 1:4
    set(Handledata.Texth(n),'String',...
        [num2str(GetCenterNow(n,fgh)) '/' num2str(siz(n)) ' pix. : '...
        num2str((double(GetCenterNow(n,fgh))-1)*Reso(n),'%.1f') ...
        '/' num2str((siz(n)-1)*Reso(n),'%.1f') unit{n}]);
end
% % For XYZ XYT
Type = getappdata(fgh,'ViewerType');
switch lower(Type)
    case {'xyz','xyt'}
        if strcmpi('xyz',Type)
            Line_Blue_dim = 3;
        else
            Line_Blue_dim = 4;
        end
        WindowsNUM = getappdata(fgh,'WindowsNUM');
        Handledata = getappdata(fgh,'Handledata');
        subfgh = Handledata.subfgh;
        for num = 1:WindowsNUM
            LineH = getappdata(subfgh(num),'LineH');
            LineH(1).YData = [GetCenterNow(2,fgh) GetCenterNow(2,fgh)];
                LineH(2).YData = [GetCenterNow(2,fgh) GetCenterNow(2,fgh)];
            LineH(3).XData = [GetCenterNow(1,fgh) GetCenterNow(1,fgh)];
                LineH(4).XData = [GetCenterNow(1,fgh) GetCenterNow(1,fgh)];
            LineH(5).XData = [GetCenterNow(Line_Blue_dim,fgh) GetCenterNow(Line_Blue_dim,fgh)];
                LineH(6).XData = [GetCenterNow(Line_Blue_dim,fgh) GetCenterNow(Line_Blue_dim,fgh)];
            LineH(7).YData = [GetCenterNow(2,fgh) GetCenterNow(2,fgh)];
                LineH(8).YData = [GetCenterNow(2,fgh) GetCenterNow(2,fgh)];
            LineH(9).YData = [GetCenterNow(Line_Blue_dim,fgh) GetCenterNow(Line_Blue_dim,fgh)];
                LineH(10).YData = [GetCenterNow(Line_Blue_dim,fgh) GetCenterNow(Line_Blue_dim,fgh)];
            LineH(11).XData = [GetCenterNow(1,fgh) GetCenterNow(1,fgh)];
                LineH(12).XData = [GetCenterNow(1,fgh) GetCenterNow(1,fgh)];
            drawnow
        end
    otherwise
end
end

    %% GetNowImage
function Image =  GetNowImage(fgh,~)
data = getappdata(fgh,'Nowdata');
DataType = getappdata(fgh,'DataType');
switch DataType  %% Channels DataType
    case 'Image'
        TF = false;
        Image = data.Image;
    case 'Processed'
        try
            if ~isempty(data.Processed.Image)
                Image = data.Processed.Image;
                TF = true;
            else
                warndlg({'GetNowImage:';...
                    '[???' ; 'Original??'},'modal')
                Image = data.Image;
                TF = false;
            end
        catch err
            errordlg({'GetNowImage:' ; err.message ; 'Original???????ŕԂ????????܂?'},'modal')
            Image = data.Image;
            TF = false;
        end
end
DTh = findobj('Parent',findobj('Parent',fgh,'Label',' Edit'),'Label','DataType');
data.Size = [size(Image) 1 1];
setappdata(fgh,'Nowdata',data);
setappdata(fgh,'NowImageSize',size(Image))

if TF
    set(findobj('Parent',DTh,'label','Original'),'Checked','off')
    set(findobj('Parent',DTh,'label','Processed'),'Checked','on')
    setappdata(fgh,'DataType','Processed')                 

else
    set(findobj('Parent',DTh,'label','Original'),'Checked','on')
    set(findobj('Parent',DTh,'label','Processed'),'Checked','off')
    setappdata(fgh,'DataType','Image') 
end

end

    %% Callback MIP
function Callback_MIP(oh,~)
fgh = get(oh.Parent,'Parent');
uih = get(oh,'userdata');
MIPdata.Type = uih(1).String{uih(1).Value};
MIPdata.Dim = uih(2).Value;
MIPdata.NUM = str2double(uih(3).String);
setappdata(fgh,'MIP',MIPdata)
CallbackSlider(oh.Parent)
end

function A = average(Image,~,Dim)
A = mean(Image,Dim);
end
function A = Median(Image,~,Dim)
A = median(Image,Dim);
end
function A = SD(Image,~,Dim)
A = std(single(Image),[],Dim);
end
function A = RGB(Image,~,~)
A = Image;
end

%% ----  Menubar in figure ----
function CreateMenu(fgh)
Fh = uimenu(fgh,'Label','File');
    SupportH = uimenu(Fh,'Label','Support');
        uimenu(SupportH,'Label','help','Callback',['help ' mfilename])
        uimenu(SupportH,'Label','Save WS Now data','Callback',@support_save2ws_Nowdata,'separator','on')
        function support_save2ws_Nowdata(~,~)
            fprintf('Example....\n')
            fprintf('    NOWDATA = getappdata(gcf,''Nowdata'');\n')
            fprintf('    Image = NOWDATA.Image;\n')
            fprintf('    SIZE  = size(NOWDATA.Image)-1;\n')
            fprintf('    Reso = abs(NOWDATA.FOV) ./ (SIZE(1:3));\n')
            fprintf('    clear NOWDATA \n                           ...\n')            
        end
    uimenu(Fh,'Label','Save','Callback',@Callback_SaveData,'separator','on')    
    uimenu(Fh,'Label','SaveROI','Callback',@Callback_SaveROI)
    SavePicH = uimenu(Fh,'Label','SavePicture');
        uimenu(SavePicH,'Label','Figure','Callback',@Callback_SavePicture)
        uimenu(SavePicH,'Label','Each Image(only Image(Original Size, @getimage))','Callback',@Callback_SavePicture)
        uimenu(SavePicH,'Label','Each Image(with ROI (Current Display Size, @getframe))','Callback',@Callback_SavePicture)
    uimenu(Fh,'Label','Load Lieca Image File','Callback',@CallbackLoadLif,'Separator','on')
    uimenu(Fh,'Label','Load Olympus Image Format','Callback',@CallbackLoadOif)
    uimenu(Fh,'Label','Load ROIdata','Callback',@CallbackLoadROIdata)
    uimenu(Fh,'Label','Load Variable Workspace','Callback',@CallbackLoadVariableWorkspace)
    uimenu(Fh,'Label','Load DimFive Data','Callback',@Callback_LoadDimFiveData)
    uimenu(Fh,'Label','Delete A File','Callback',@Callback_DeleteFile,'Separator','on')
    
uimenu(fgh,'Label','Data');
    
Vh = uimenu(fgh,'Label','View');
    uimh = uimenu(Vh,'Label','# Window');
        uimenu(uimh,'Label','1','Callback',@Callback_WindowNUM,'Checked','on')
        uimenu(uimh,'Label','2','Callback',@Callback_WindowNUM)
        uimenu(uimh,'Label','3','Callback',@Callback_WindowNUM)
        uimenu(uimh,'Label','4','Callback',@Callback_WindowNUM)
        uimenu(uimh,'Label','6','Callback',@Callback_WindowNUM)
        uimenu(uimh,'Label','8','Callback',@Callback_WindowNUM)
    uimh = uimenu(Vh,'Label','Style');
        uimenu(uimh,'Label','volumeViewer','Callback',@Callback_ImageProcessing,'Userdata',fgh)
        uimenu(uimh,'Label','MIP3D','Callback',@Callback_ImageProcessing,'Userdata',fgh)
        uimenu(uimh,'Label','X-Y','Callback',@Callback_Style,'Userdata','xy','Checked','on','Separator','on')
        uimenu(uimh,'Label','X-Z','Callback',@Callback_Style,'Userdata','xz')
        uimenu(uimh,'Label','Y-Z','Callback',@Callback_Style,'Userdata','yz')
        uimenu(uimh,'Label','X-Y&&Z-Y&&X-Z','Callback',@Callback_Style,'Userdata','xyz')
        uimenu(uimh,'Label','X-t','Callback',@Callback_Style,'Userdata','xt')
        uimenu(uimh,'Label','Y-t','Callback',@Callback_Style,'Userdata','yt')
        uimenu(uimh,'Label','X-Y&&Y-t&&X-t','Callback',@Callback_Style,'Userdata','xyt')
    uimh = uimenu(Vh,'Label','Color Limit','Separator','on');
        uimenu(uimh,'Label','Global','Callback',@Callback_CLim,'Userdata','manual')
        uimenu(uimh,'Label','Local','Callback',@Callback_CLim,'Userdata','auto')
    uimh = uimenu(Vh,'Label','Map','Separator','on');
    uimh(2) = uimenu(Vh,'Label','Linear Map');
    uimh(3) = uimenu(Vh,'Label','Log Map');
    uimh(4) = uimenu(Vh,'Label','exp(10) Map');
            Clabel = {'ColormapRed','ColormapBlue','ColormapGreen',...
            'gray','parula','kjet','kjetw','jet','hsv','hot','cool','spring',...
            'summer','autumn','winter','bone','copper','pink','lines',...
            'flag'};
        for n = 1:length(Clabel)
            uimenu(uimh(1),'Label',Clabel{n},'Callback',@Callback_Colormap);
            uimenu(uimh(2),'Label',Clabel{n},'Callback',@Callback_LinearColormap);            
            uimenu(uimh(3),'Label',Clabel{n},'Callback',@Callback_LogColormap);
            uimenu(uimh(4),'Label',Clabel{n},'Callback',@Callback_exp10Colormap);
        end
    uimh(4) = uimenu(Vh,'Label','Fluorescence');
    Flouorescence_num = 36;
    Flouorescence_Color = GetColorChannels(Flouorescence_num);
        for n = 1:Flouorescence_num
            uimenu(uimh(4),'Callback',@Callback_Fluorescence_map,...
                'Label','??????????????Color??????????????',...
                'ForegroundColor',Flouorescence_Color(n,:));
        end
        
        
Eh = uimenu(fgh,'Label',' Edit');
    uimenu(Eh,'Label','Resolution','Callback',@Callback_Reso)
    uimenu(Eh,'Label','HistView','Callback',@Callback_ImageProcessing,'Userdata',fgh)
    uimh=uimenu(Eh,'Label','Adjust Image(TS_AdjImage)',...
        'Separator','on');
        uimenu(uimh,'Label','Adjust','Callback',@Callback_AdjImage,'Userdata',fgh)
        uimenu(uimh,'Label','Help','Callback','help TS_AdjImage','Separator','on')
    uimh=uimenu(Eh,'Label','Histgram To Log Scale');
        uimenu(uimh,'Label','min','Callback',@Callback_HistgramLog,'Userdata',fgh)
        uimenu(uimh,'Label','std','Callback',@Callback_HistgramLog,'Userdata',fgh)
        uimenu(uimh,'Label','mode','Callback',@Callback_HistgramLog,'Userdata',fgh)
        uimenu(uimh,'Label','mean','Callback',@Callback_HistgramLog,'Userdata',fgh)
        uimenu(uimh,'Label','Help','Callback','help TS_HistgramLogScaler','Separator','on')
    uimh=uimenu(Eh,'Label','Histgram To Exponential');
        uimenu(uimh,'Label','min','Callback',@Callback_Hist2Exp,'Userdata',fgh)
        uimenu(uimh,'Label','std','Callback',@Callback_Hist2Exp,'Userdata',fgh)
        uimenu(uimh,'Label','mode','Callback',@Callback_Hist2Exp,'Userdata',fgh)
        uimenu(uimh,'Label','mean','Callback',@Callback_Hist2Exp,'Userdata',fgh)
        uimenu(uimh,'Label','Help','Callback','help TS_Histgram2Exponential','Separator','on')
        
        
%     EDTh = uimenu(Eh,'Label','DataType');
%         uimenu(EDTh,'Label','Original','checked','on','Callback',@Callback_SetDataType)
%         uimenu(EDTh,'Label','Processed','checked','off','Callback',@Callback_SetDataType)
    
Proh = uimenu(fgh,'Label','Image Processing');
    uimenu(Proh,'Label','WienerFilter','Callback',@Callback_Filt,'Userdata','wiener2')
    uimenu(Proh,'Label','MedianFilter','Callback',@Callback_Filt,'Userdata','medfilt2')
    uimenu(Proh,'Label','Moving Average','Callback',@Callback_Filt,'Userdata','MovingAve')
    uimh=uimenu(Proh,'Label','Shading(TS_ShadingImage)',...
        'Separator','on');
        uimenu(uimh,'Label','Shading','Callback',@Callback_ImageProcessing,'Userdata',fgh)
        uimenu(uimh,'Label','Help','Callback','help TS_ShadingImage','Separator','on')
    uimh=uimenu(Proh,'Label','Deconv.(TS_deconv_proto)');
        uimenu(uimh,'Label','Deconv','Callback',@Callback_ImageProcessing,'Userdata',fgh)
        uimenu(uimh,'Label','Help','Callback','help TS_deconv_proto','Separator','on')
    uimh=uimenu(Proh,'Label','Hist Equal.(TS_HistgramEqualization_parfor)');
        uimenu(uimh,'Label','HistEqual','Callback',@Callback_ImageProcessing,'Userdata',fgh)
        uimenu(uimh,'Label','Help','Callback','help TS_HistgramEqualization_parfor','Separator','on')
    
ROIh = uimenu(fgh,'Label','ROI');
    ROIColorh = uimenu(ROIh,'Label','Chose Color','ForegroundColor',[0.2 .02 1],'Separator','on');    
        for n = 1:Flouorescence_num
            uimenu(ROIColorh,'Callback',@Callback_ROIColor,...
                'Label','==== Color ====',...
                'ForegroundColor',Flouorescence_Color(n,:));
        end
        
    ROIlabel = cat(1,{'Rectangle','Ellipse','Polygon',' Line','Point'},...
        {'imrect' , 'imellipse' , 'impoly' , 'imline' , 'impoint'});
    for n = 1:size(ROIlabel,2)
        uimenu(ROIh,'Label',ROIlabel{1,n},'Userdata',ROIlabel{2,n},...
            'Callback',@Callback_ROI)
    end
    
    
    
    ROI_SCK= uimenu(ROIh,'Label','Set up Short cut mouse','Separator','on');
    roi_sck_h(1) = uimenu(ROI_SCK,'Label','None','Callback',@Callback_ShortCutKeyROI);
    roi_sck_h(2) = uimenu(ROI_SCK,'Label','Rectangle','Callback',@Callback_ShortCutKeyROI,'Separator','on');
    roi_sck_h(3) = uimenu(ROI_SCK,'Label','Line','Callback',@Callback_ShortCutKeyROI);
    roi_sck_h(4) = uimenu(ROI_SCK,'Label','Point','Callback',@Callback_ShortCutKeyROI,'Checked','on');
    setappdata(fgh,'ROI_ShortCutKey_Handles',roi_sck_h)
    
    ROI_visibleh(1) = uimenu(ROIh,'Label','Visible ALL','Callback',@Callback_VisibleAll,'Separator','on');
    ROI_visibleh(2) = uimenu(ROIh,'Label','Visible ALL Current FOV(MIP-NUM)',...
        'Callback',@Callback_VisibleAllCurrentMIPNUM,...
        'Checked','on');
    ROI_visibleh(3) = uimenu(ROIh,'Label','Invisible ALL ','Callback',@Callback_VisibleAllOFF);
    setappdata(fgh,'ROI_Visible_Handles',ROI_visibleh)
    h = uimenu(ROIh,'Label','Add visible Depth Num','Separator','on');
        AddDepthNum = getappdata(fgh,'ROI_AddDepth');
        AddDepthNum = str2double(AddDepthNum);
        if isnan(AddDepthNum)
            AddDepthNum = 0;
            setappdata(fgh,'ROI_AddDepth',AddDepthNum);
        end
        uimenu(h,'label',['NUM: ' num2str(AddDepthNum)],...
            'Callback',@Callback_ROIAddDepth);
    function Callback_ROIAddDepth(oh,~)
        fgh = oh.Parent.Parent.Parent;
        Def = getappdata(fgh,'ROI_AddDepth');
        INPUT = inputdlg({'ROI : Input Add Depth Num.'},'',1,{num2str(Def)});
        if isempty(INPUT)
            return
        else
            try
                AddDepthNum = eval(INPUT{1});
                AddDepthNum = max(AddDepthNum,0);
                setappdata(fgh,'ROI_AddDepth',AddDepthNum)
                oh.Label = ['NUM: ' num2str(AddDepthNum)];
            catch err
                L = (err.stack.line);
                errordlg({err.message;['Line : ' num2str(L)]})
            end
        end
    end

    uimenu(ROIh,'Label','Delete ALL','Callback',@Callback_DeleteAll,'Separator','on')
    uimenu(ROIh,'Label','Mask ALL','Callback',@Callback_CreateImageMaskFromAllROI,'Separator','on')
    uimenu(ROIh,'Label','Mean Intensity (View)','Callback',@Callback_ROIMeanIntensityView,'Separator','on')
    uimh = uimenu(ROIh,'Label','DimChange');
        uimenu(uimh,'Label','3','Checked','on','Callback',@Callback_ROIMeanIntensityDIM)
        uimenu(uimh,'Label','4','Checked','off','Callback',@Callback_ROIMeanIntensityDIM)
    uimenu(ROIh,'Label','Line Intensity (View)','Callback',@Callback_ROILineIntensityView,'Separator','on')
    h = uimenu(ROIh,'Label','Measurement','Separator','on','ForegroundColor','r');
        uimenu(h,'Label','Line','Callback',@Callback_Measurement)
        uimenu(h,'Label','Poly','Callback',@Callback_Measurement)
        uimenu(h,'Label','By Hand (Line) to matrix(xlsx, too)',...
            'Callback',@Callback_MeasurementByHand,...
            'ForegroundColor','r',...
            'Separator','on')
 CloseH = uimenu(fgh,'Label','Close type');
        uimenu(CloseH,'Label','on','Checked','on','Callback',@Callback_ChangeCloseType);
        uimenu(CloseH,'Label','off','Callback',@Callback_ChangeCloseType);
end

%% == Menu File ==
% --  Save  --
function Callback_SaveData(oh,~)
fgh = get(get(oh,'Parent'),'Parent');
Dh = findobj('Parent',fgh,'Label','Data');
ch = get(Dh,'Children');
DataName = cell(length(ch),1);
for n = 1:length(ch)
    DataName{n} = get(ch(n),'Label');
end
[selt,ok] = listdlg('PromptString','Select a file',...
    'SelectionMode','single','ListString',DataName);
if not(ok)
    return
end
type = 'DimFive';
data = struct('FolderName',DataName{selt},'Image',[]);
data.Image = getappdata(fgh,DataName{selt});
uisave({'type','data'},DataName{selt})
end

% -- Save ROIdata --
function Callback_SaveROI(oh,~)
fgh = get(get(oh,'Parent'),'Parent');
ROIdata = ROI2matdata(fgh);
uisave('ROIdata')
end

% -- Save Figure2Picture --
function Callback_SavePicture(oh,~)
fgh = gcbf;
[filename,pathname] = uiputfile(...
    {'*.tif';'*.bmp';'*.jpg'},'Save as');
if filename==0
    return
end
Handles = getappdata(fgh,'Handledata');
subfgh = Handles.subfgh;
Nowdir = cd;
cd(pathname)
switch oh.Label
    case 'Figure'
        saveas(fgh,filename)
    otherwise 
        Fname = find(filename=='.');
        DOT = filename(Fname:end);
        Fname = filename(1:Fname-1);
        map = get(fgh,'Colormap');
        for n = 1:length(subfgh)
            axh = findobj('Parent',subfgh(n),'type','axes');
            for k = 1:length(axh)
                if strcmp(oh.Label,'Each Image(only Image(Original Size, @getimage))')
                    im = getimage(axh(k));
                else %% 'Each Image(getframe)'
                    im = getframe(axh(k));
                    im = im.cdata;
                end

                if ndims(im)~=3
                    CLim = caxis(axh(k));
                    im = double(im);
                    im = max(im - CLim(1),0);
                    im = round(im./diff(CLim) * (size(map,1)-1));
                    im = ind2rgb8(im,map);
                end
                if and(numel(subfgh)==1,isscalar(axh))
                    imwrite(im,filename)
                else
                    imwrite(im,[Fname '_Win' num2str(n) '_Axis' num2str(k) DOT])
                end
            end
        end
end
cd(Nowdir)
end

% -- Load Lif Files --
function CallbackLoadLif(~,~)
fgh = gcbf;
Info = getappdata(fgh,'InfomationH');
% FileMH = findobj('Parent',fgh,'Label','Data');
Nowdir = cd;
cd(Info.LifDir);
[filename,Path] = uigetfile('*.lif');
if filename==0
    cd(Nowdir)
    return
end
Fullfilename = fullfile(Path,filename);
Info.LifDir = Path;
    setappdata(fgh,'InfomationH',Info)
h = figure('Name','Now Loading .lif files...','NumberTitle','off','Menubar','none','toolbar','none');
axes('Parent',h,'Position',[0 0 1 1]);
Image4wait = imread('DimFive_loadLif.jpg');
imshow(Image4wait),drawnow

% data = TSloadLifverDimFiveROI(filename);
% data = TSresetdata(data);
try
    data = HKloadLif_vTS(Fullfilename);
    close(h)
catch err
    keyboard
end

filename = ['Lieca_' filename];
filename = ReNameSTR(filename);
AddData(fgh,filename,data)

end


% -- Load Olympus Image Format Files --
function CallbackLoadOif(~,~)
fgh = gcbf;
Info = getappdata(fgh,'InfomationH');
% FileMH = findobj('Parent',fgh,'Label','Data');
Nowdir = cd;
cd(Info.LifDir);
[filename,Path] = uigetfile('*.oif');
if filename==0
    cd(Nowdir)
    return
end
Info.LifDir = Path;
    setappdata(fgh,'InfomationH',Info)
h = figure('Name','Now Loading .oif files...','NumberTitle','off','Menubar','none','toolbar','none');
axes('Parent',h,'Position',[0 0 1 1]);
Image4wait = imread('DimFive_loadLif.jpg'); %%%%%%%%%%%%%
imshow(Image4wait),drawnow
[data,Info] = TSloadOifv0(fullfile(Path,filename));
ViewOifProfile(Info)
data.Name = ReNameSTR(data.Name);
InputName = ['Olympus_' filename];
InputName = ReNameSTR(InputName);
try
close(h)
catch
end
AddData(fgh,InputName,data)
end

function CallbackLoadROIdata(oh,~)
fgh = get(get(oh,'Parent'),'Parent');
[filename, pathname] = uigetfile('*.mat');
if filename == 0
    return
end
load([pathname filename])
if isempty(who('ROIdata'))
    errordlg('This data is not ''ROIdata''')
    return
end
if size(ROIdata,2)==0
    return
end
NowROIdata = getappdata(fgh,'NowROIdata');

wh = waitbar(0,'Write ROIdata');
if isempty(NowROIdata)
    NUM = size(NowROIdata,2);
    
    
    for n = NUM:(NUM+size(ROIdata,2)-1)
        NowROIdata(n+1).handle = ROIdata(n-NUM+1).handle;
        NowROIdata(n+1).Lienobh = ROIdata(n-NUM+1).Lineobh;
        NowROIdata(n+1).existTF = ROIdata(n-NUM+1).existTF;
        NowROIdata(n+1).class = ROIdata(n-NUM+1).class;
        NowROIdata(n+1).Position = ROIdata(n-NUM+1).Position;
        NowROIdata(n+1).Plane = ROIdata(n-NUM+1).Plane;
        NowROIdata(n+1).Depth = ROIdata(n-NUM+1).Depth;
        NowROIdata(n+1).Time = ROIdata(n-NUM+1).Time;
        NowROIdata(n+1).Color = ROIdata(n-NUM+1).Color;
        waitbar(n/length(ROIdata),wh,...
            ['Write ROIdata...' num2str(n) '/' num2str(length(ROIdata))])
    end
    
    waitbar(1,wh,'Now Drawing ROIdata....Wait!!')
    setappdata(fgh,'NowROIdata',NowROIdata);
    SetappROIdata(fgh);
    try
        close(wh)
    catch err
        warndlg(err.message)
    end
else
    length(ROIdata)
    for n = 1:length(ROIdata)
        DrawROI(fgh,[],...
            ROIdata(n).class,...
            ROIdata(n).Position,...
            ROIdata(n).Depth,...
            ROIdata(n).Time,...
            ROIdata(n).Color)
        try
        waitbar(n/length(ROIdata),wh,...
            ['Write ROIdata...' num2str(n) '/' num2str(length(ROIdata))])
        catch err
            disp(err.message)            
        end
    end
    try
        close(wh)
    catch err
        disp(err.message)            
    end
end
    
end

% -- Load Variable of Workspace --
function CallbackLoadVariableWorkspace(oh,~)
fgh = get(get(oh,'Parent'),'Parent');
NameList = evalin('base','whos');
[selt,ok] = listdlg('PromptString','Select a file',...
    'SelectionMode','single','ListString',{NameList.name});
if ok
    data = evalin('base',NameList(selt).name);
    data = TSstruct(data,NameList(selt).name);
    AddData(fgh,NameList(selt).name,data)
end

end

% -- Load DimFive File --
function Callback_LoadDimFiveData(oh,~)
fgh = get(get(oh,'Parent'),'Parent');
[filename,pathname,FilterIndex] = uigetfile('*.mat');
if FilterIndex==0
    return
end
try
    load([pathname '\' filename],'type')
    if ~max(strcmpi(type,'DimFive'))
        errordlg('DimFive???????̃f???????[???????^???????ł???????????????܂???????????????')
        return
    end        
catch err
    errordlg({err.message})
    return
end
InputData = load([pathname '\' filename]);
AddData(fgh,InputData.data.FolderName,InputData.data.Image)
end

%% Callback View
function Callback_view(oh,~)
fgh = gcbf;
if isempty(fgh), fgh = gcf; end
Ph = get(oh,'Parent');
Userdata = getappdata(fgh,'NowdataInf');
if ~isempty(Userdata)
    data = getappdata(fgh,Userdata.filename);
    data(Userdata.NUM).ROIdata = ROI2matdata(fgh);
    setappdata(fgh,Userdata.filename,data);    
    clear data Orlddata Userdata Chenddata
end


setappdata(fgh,'NowROIdata',[])
Fileh = findobj('Parent',fgh,'Label','Data'); 
% File ???????̎qobj???????̃`???????F???????G???????Noff
Ch = get(Fileh,'Children');
set(Ch,'Checked','off');
    for n = 1:length(Ch)
        chCh = get(Ch(n),'Children');
        set(chCh,'Checked','off')
        for chnn = 1:length(chCh)
            set(get(chCh(chnn),'Children'),'Checked','off')
        end
    end
set(Ph,'Checked','on')
set(oh,'Checked','on')

Userdata = get(oh,'userdata');
setappdata(fgh,'NowdataInf',Userdata)
filename = Userdata.filename;  %% filename = Parent FolderName
data = getappdata(fgh,filename);
data = data(Userdata.NUM);     %% data.Name = Name

% Chenddata = data.Image(:,:,:,:,end);
% if and(size(data.Image,5)>1,max(Chenddata(:))~=0)
%     Like = feval(class(data.Image),0);
%     data.Image = cat(5,data.Image,zeros(size(data.Image),'like',Like));
% end
if max(strcmpi('ROIdata',fieldnames(data)))
    setappdata(fgh,'NowROIdata',data.ROIdata)
end
SetappROIdata(fgh)
setappdata(fgh,'Nowdata',data)
reso = [data.FOV(1)/(data.Size(1)-1) data.FOV(2)/(data.Size(2)-1) 1 1];
if size(data.FOV,2)>=3
    reso(3) = data.FOV(3)/(data.Size(3)-1);
end
if size(data.FOV,2)==4
    reso(4) = data.FOV(4)/(data.Size(4)-1);
end

setappdata(fgh,'Resolution',abs(reso))
setappdata(fgh,'WindowsNUM',1)
setappdata(fgh,'ViewerType','xy');
ResetUpView(fgh,1,getappdata(fgh,'slwidth'),'xy')

% Set Name
% sah = getappdata(fgh,'InfomationH');
% set(sah.Name(1),'String',data.Name)
% set(sah.Name(2),'String',filename)
end

%% -- Delete Data --
function Callback_DeleteFile(oh,~)
fgh = get(get(oh,'Parent'),'Parent');
Dh = findobj('Parent',fgh,'Label','Data');
ch = get(Dh,'Children');
if isempty(ch)
    return
end
DataName = cell(length(ch),1);
for n = 1:length(ch)
    DataName{n} = get(ch(n),'Label');
end
[selt,ok] = listdlg('PromptString','Select a file',...
    'SelectionMode','single','ListString',DataName);
if not(ok)
    return
end
filename = DataName{selt};
setappdata(fgh,filename,[])
delete(ch(selt))
end


%% == Menu View ==
% -- # Window --
function Callback_WindowNUM(oh,~)
fgh = gcbf;
NUM = str2double(get(oh,'Label'));
setappdata(fgh,'WindowsNUM',NUM)
ResetUpView(fgh,NUM,getappdata(fgh,'slwidth'),getappdata(fgh,'ViewerType'))
set(get(get(oh,'Parent'),'children'),'Checked','off')
set(oh,'Checked','on')
end

% --  Style  --
function Callback_Style(oh,~)
fgh = gcbf;
if strcmpi('on',get(oh,'Checked'))
    return
end
Style = get(oh,'userdata');
setappdata(fgh,'ViewerType',Style)
ResetUpView(fgh,getappdata(fgh,'WindowsNUM'),getappdata(fgh,'slwidth'),Style)
set(get(get(oh,'Parent'),'children'),'Checked','off')
set(oh,'Checked','on')
end

% --  Color Limit --
function Callback_CLim(oh,~)
fgh = gcbf;
Vph = findobj('Parent',fgh,'Tag','ViewerPanel');
Type = get(oh,'Userdata');
Checkbotton = get(get(oh,'Parent'),'Children');
set(Checkbotton,'Checked','off')
data = getappdata(fgh,'Nowdata');
switch Type
    case 'auto'
        for n = 1:length(Vph)
            ch = findobj('Parent',Vph(n),'Type','axes');
            set(ch,'ClimMode',Type)
        end
        set(oh,'Checked','on')
    case 'manual'
        
        Input = inputdlg({'Maximum','Minimum'},'CLim',1,{num2str(max(data.Image,[],'all')),'0'});
        if isempty(Input)
            set(Checkbotton(2),'Checked','on')
            msgbox('Color Limit : Local')
            for n = 1:length(Vph)
                set(findobj('Parent',Vph(n),'Type','axes'),'ClimMode','auto')
            end
        else
            CLIM(1) = str2double(Input{1});
            CLIM(2) = str2double(Input{2});
            CLIM = sort(CLIM);
            for n = 1:length(Vph)
                set(findobj('Parent',Vph(n),'Type','axes'),...
                    'ClimMode',Type,'Clim',CLIM)
            end
            set(oh,'Checked','on')
        end
end
ch = get(fgh,'Children');
CallbackSlider(ch(1))
end

% -- Colormap  --
function Callback_Colormap(oh,~)
fgh = gcbf;
set(fgh,'Colormap',feval(get(oh,'label'),256))
% ch = get(get(oh,'Parent'),'Children');
% set(ch,'Checked','off')
% set(oh,'Checked','on') 
end

% -- linear Colormap  --
function Callback_LinearColormap(oh,~)
fgh = gcbf;
hsvmap = rgb2hsv(feval(get(oh,'label'),256));
hsvmap(:,3) = linspace(0,1,256);
set(fgh,'Colormap',hsv2rgb(hsvmap))
end

% -- Log Colormap  --
function Callback_LogColormap(oh,~)
fgh = gcbf;
hsvmap = rgb2hsv(feval(get(oh,'label'),256));
% hsvmap(:,3) = log10(hsvmap(:,3)*9+1);
hsvmap(:,3) = log10((linspace(0,1,256))*9+1);
set(fgh,'Colormap',hsv2rgb(hsvmap))
end

% == Exp(10) Colormap == 
function Callback_exp10Colormap(oh,~)
fgh = gcbf;
hsvmap = rgb2hsv(feval(get(oh,'label'),256));
% hsvmap(:,3) = 10.^(hsvmap(:,3)) - 1;
hsvmap(:,3) = 10.^(linspace(0,1,256)) - 1;
hsvmap(:,3) = hsvmap(:,3) / max(hsvmap(:,3));
map = hsv2rgb(hsvmap);
% map = feval(get(oh,'label'),256);
% map = 10.^map - 1;
% map = map./max(map(:));
set(fgh,'Colormap',map)
end

% **** Fluorescence_map ****
function Callback_Fluorescence_map(oh,~)
fgh = gcbf;
map = Makemap(get(oh,'ForegroundColor'));
hsvmap = rgb2hsv(map);
hsvmap(:,3) = log10(hsvmap(:,3)*9+1);
set(fgh,'Colormap',hsv2rgb(hsvmap))
end

%% ==  Menu Edit  ==
% --  Resolution  --
function Callback_Reso(~,~)
fgh = gcbf;
TSinputResolution(fgh)
end

function TSinputResolution(fgh)

Reso = getappdata(fgh,'Resolution');
dlgfh = figure('NumberTitle','off','IntegerHandle','off','Name','Resolution ?',...
    'position',[560 520 400 150],'Menubar','none','Toolbar','none');
uith(1) = uicontrol('position',[60 80 70 30],'String','Xaxis');
uith(2) = uicontrol('position',[130 80 70 30],'String','Yaxis');
uith(3) = uicontrol('position',[200 80 70 30],'String','Zaxis pixel/um');
uith(4) = uicontrol('position',[270 80 70 30],'String','Taxis flame/ms');
set(uith,'Style','text','backGroundColor',get(dlgfh,'color'))
uith(1) = uicontrol('position',[60 50 70 30],'String',num2str(Reso(1)));
uith(2) = uicontrol('position',[130 50 70 30],'String',num2str(Reso(2)));
uith(3) = uicontrol('position',[200 50 70 30],'String',num2str(Reso(3)));
uith(4) = uicontrol('position',[270 50 70 30],'String',num2str(Reso(4)));
set(uith,'Style','Edit')
setappdata(dlgfh,'data',uith)
setappdata(dlgfh,'fgh',fgh)
uicontrol('position',[230 10 70 30],'String','Apply','Callback',@Callback_InputReso)

    function Callback_InputReso(~,~)
        fgh  = getappdata(gcbf,'fgh');
        uith = getappdata(gcbf,'data');
        Reso = zeros(1,4);
        try
            for i = 1:4
                cmd = ['Reso(' num2str(i) ') = ' get(uith(i),'String') ';'];
                eval(cmd)
            end
        catch err
            errordlg(err.message,'MISS : Resolution Input','modal')
            close(gcbf)
            return
        end
        setappdata(fgh,'Resolution',Reso)
        close(gcbf)
        ResetUpView(fgh,getappdata(fgh,'WindowsNUM'),getappdata(fgh,'slwidth'),getappdata(fgh,'ViewerType'))

    end
uicontrol('position',[305 10 70 30],'String','Cancel','Callback','closereq')

    
end




function Callback_AdjImage(oh,~)
fgh = get(oh,'Userdata');
data = getappdata(fgh,'Nowdata');
Reso = getappdata(fgh,'Resolution');
Newdata = data;
NowdataInf = getappdata(fgh,'NowdataInf');
Image = data.Image;
%% Processed Name input%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ProcessedName = [data.Name '_' get(oh,'label') ];
A = TS_AdjImage(Image,Reso);
%% for add New data
Newdata.Image = A; %% size?????????????????????ς????????Ȃ??????????????????????OK...
Newdata.Name = ProcessedName;
AddData(fgh,NowdataInf.filename,Newdata,2)
end

function Callback_HistgramLog(oh,~)
fgh = get(oh,'Userdata');
data = getappdata(fgh,'Nowdata');
Newdata = data;
NowdataInf = getappdata(fgh,'NowdataInf');
Image = data.Image;
%% Processed Name input%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ProcessedName = [data.Name '_Hist2Log(' get(oh,'label') ')'];
A = TS_HistgramLogScaler(Image,get(oh,'label'));
%% for add New data
Newdata.Image = A; %% size?????????????????????ς????????Ȃ??????????????????????OK...
Newdata.Name = ProcessedName;
AddData(fgh,NowdataInf.filename,Newdata,2)
end

function Callback_Hist2Exp(oh,~)
fgh = get(oh,'Userdata');
data = getappdata(fgh,'Nowdata');
Newdata = data;
NowdataInf = getappdata(fgh,'NowdataInf');
Image = data.Image;
%% Processed Name input%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ProcessedName = [data.Name '_Hist2Exp(' get(oh,'label') ')'];
A = TS_Histgram2Exponential(Image,get(oh,'label'));
%% for add New data
Newdata.Image = A; %% size?????????????????????ς????????Ȃ??????????????????????OK...
Newdata.Name = ProcessedName;
AddData(fgh,NowdataInf.filename,Newdata,2)
end

%% == Processed Fun ==
% -- Median & Wiener & MovingAverage --
function Callback_Filt(oh,~)
fgh = gcbf;
data = getappdata(fgh,'Nowdata');
Newdata = data;
NowdataInf = getappdata(fgh,'NowdataInf');

% Image = GetNowImage(fgh);
Image = data.Image;

%% Main Process
InputMN = inputdlg({'Size X','Size Y'},'Input FilterSize',1,{'3','3'});
if isempty(InputMN)
    return
else
    MN(1) = str2double(InputMN{1,1});
    MN(2) = str2double(InputMN{2,1});
end
%% Processed Name input%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ProcessedName = [data.Name '_' get(oh,'label') num2str(MN(1)) 'x' num2str(MN(2))];
Image = padarray(Image,MN,'symmetric');
if islogical(Image)
    A = false(size(Image));
else
    Like = feval(class(Image),1);
    A = zeros(size(Image),'like',Like);
end
cEnd = size(Image,5)*size(Image,4)*size(Image,3);
c = 1;
wh = waitbar(0,'Filter');
for chNum = 1:size(Image,5)
%     TF = Image(:,:,:,:,chNum);
%     if max(TF(:))==0
%         continue
%     end
%     clear TF
    for t = 1:size(Image,4)
        for k = 1:size(Image,3)
            A(:,:,k,t,chNum) = feval(get(oh,'Userdata'),Image(:,:,k,t,chNum),MN);
            waitbar(c/cEnd,wh,['Filter...' num2str(c) '/' num2str(cEnd)])
            c = c + 1;
        end
    end
end
close(wh)
A = A(MN(1)+1:end-MN(1),MN(2)+1:end-MN(2),:,:,:);

%% for add New data
Newdata.Image = A; %% size?????????????????????ς????????Ȃ??????????????????????OK...
Newdata.Name = ProcessedName;
AddData(fgh,NowdataInf.filename,Newdata,2)

end

function A = MovingAve(im,MN)
h = ones(MN)/prod(MN(:));
A = imfilter(im,h,'symmetric');
end

function Callback_ImageProcessing(oh,~)
fgh = get(oh,'Userdata');
data = getappdata(fgh,'Nowdata');
Reso = getappdata(fgh,'Resolution');
Newdata = data;
NowdataInf = getappdata(fgh,'NowdataInf');
Image = data.Image;
%% Processed Name input%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ProcessedName = [data.Name '_' get(oh,'label') ];
switch oh.Label
    case 'Shading'
        A = TS_ShadingImage(Image,Reso);
    case 'Deconv'
        A = TS_deconv_proto(Image,Reso);
    case 'HistEqual'
        A = TS_HistgramEqualization_parfor(Image);
    case 'HistView'
        TS_HistgramViewer(Image)
        return
    case 'volumeViewer'
        
        if ndims(Image) == 5
            ChannelsNUM = size(data.Image,5); %ChannelsNUM;
            DataName = cell(ChannelsNUM,1);
            for n=1:ChannelsNUM,DataName{n} = num2str(n);   end
            [CH,ok] = listdlg('PromptString','Select Channels',...
                'SelectionMode','single','ListString',DataName);
            if ok
                Image = squeeze(Image(:,:,:,GetCenterNow(4,fgh),CH));
            else
                return
            end
        end
        Reso = Reso(1:3);
        
        Image = TS_EqualReso3d_2017(Image,Reso,min(Reso));
        siz = size(Image);
        MaximumSiz = 512;
        if max(siz) > MaximumSiz
            Image = imresize3(Image,MaximumSiz/max(siz));
        end
        volumeViewer(Image)
        return
        
        
    case 'MIP3D'
        try
        TS_3dmipviewer(Image,Reso(1:3))
        catch err
            disp(err)
        end
        return
end
%% for add New data
Newdata.Image = A; %% size?????????????????????ς????????Ȃ??????????????????????OK...
Newdata.Name = ProcessedName;
AddData(fgh,NowdataInf.filename,Newdata,2)
end

%% == ROI Fun ==
% -- imrect imellipse impoly imline impoint --
function Callback_ROI(oh,~)
fgh = gcbf;
set(findobj('Parent',fgh,'Label','ROI'),'Enable','off')
DrawROI(fgh,oh,[],[],[],[],[]);
set(findobj('Parent',fgh,'Label','ROI'),'Enable','on')
end

function Callback_ROIColor(oh,~)
ph = oh.Parent;
ph.ForegroundColor = oh.ForegroundColor;
end

function DrawROI(fgh,oh,type,Posi,Depth,Time,Color)

WindowsNUM = getappdata(fgh,'WindowsNUM');       %% Number of Windows {1}, 2 , 3 , 4
ViewerType = getappdata(fgh,'ViewerType');    %% viewr type {'xy'},'xz','yz','xyz','xt','yt','xyt'

if WindowsNUM~=1 || ~max(strcmpi(ViewerType,{'xy'}))
    errordlg('ViewerType??????????????xy???????ɂ????????Ă???????????????????????????????????????????','ERROR','modal')
    return
end
Vph = findobj('Parent',fgh,'Tag','ViewerPanel');
axh = findobj('Parent',Vph,'tag',[ViewerType 'axes']);
ROIdata = getappdata(fgh,'NowROIdata');
ROINUM = [];
if isempty(ROIdata)
   ROINUM = 1;
else
    for i = 1:size(ROIdata,2)
        if ~ROIdata(i).existTF
            ROINUM = i;
            break
        end
    end
    if isempty(ROINUM)
        ROINUM = size(ROIdata,2) + 1;
    end
end
if ~isempty(oh)
    h = feval(get(oh,'Userdata'),axh);
    menuROIh = findobj('Parent',fgh,'Label','ROI');
    setColor(h,menuROIh.Children(end).ForegroundColor)
else
    h = feval(type,axh,Posi);
    setColor(h,Color)
end
Cdata = get(findobj('Parent',axh,'type','image'),'Cdata');
Xlimt = [.5 size(Cdata,2)+.5];
Ylimt = [.5 size(Cdata,1)+.5];
fcn = makeConstrainToRectFcn(class(h),Xlimt,Ylimt);
setPositionConstraintFcn(h,fcn);
addNewPositionCallback(h,@(p) MotionROI);
ch = get(h,'Children');
ph = get(ch(1),'Parent');
data = struct('NUM',ROINUM,'Name',['ROI ' num2str(ROINUM)],'handle',h,'hNUM',ph);
data.ROIplane = ViewerType;
posi = getPosition(h);
[Py,b] = min(posi(:,1));
Px     = posi(uint32(b(1)),2);
textH = text('Parent',get(h,'parent'),'STring',data.Name,...
    'Color',getColor(h),'Position',[Py+3 Px-3],...
    'Fontsize',12,'FontWeight','demi');


data.textH = textH;
Nowdata = getappdata(fgh,'Nowdata');
switch getappdata(fgh,'DataType')
    case 'Image'
        NowImage = Nowdata.Image;
    case 'Processed'
        NowImage = Nowdata.Processed.Image;
end
if isempty(oh)
    data.Depth = Depth;
    data.Time = Time;
else
    data.Depth = [1 GetCenterNow(3,fgh)]; %size(NowImage,3)
    data.Time = [1 size(NowImage,4)];
end
data.Lineobh = [];
set(h,'userdata',data)
ROIdata(ROINUM).handle = h;
ROIdata(ROINUM).Lineobh = [];
ROIdata(ROINUM).existTF = true;
ROIdata(ROINUM).class = class(h);
ROIdata(ROINUM).Position = [];
ROIdata(ROINUM).Plane = ViewerType;
ROIdata(ROINUM).Depth = data.Depth;
ROIdata(ROINUM).Time = data.Time; 
setappdata(fgh,'NowROIdata',ROIdata);
menuH = get(get(ph,'children'),'uicontextmenu');
menuH = menuH{1};
% menuH.Children
%   3x1 Menu ???????z??????????????:
%      Menu    (delete cmenu item)
%      Menu    (set color cmenu item)
%      Menu    (copy position cmenu item)
if ~strcmpi(get(h,'Tag'),'impoint')
    delete(menuH.Children(1))
end
if isempty(menuH)
    menuH = get(h,'UIcontextmenu');
    ch = get(menuH,'Children');
    delete(ch(1));
elseif ~strcmpi('imline',class(h))
    ch = get(menuH,'Children');
    delete(ch(2));    
end
delete(findobj('Parent',menuH,'Label','???????F???????̐ݒ?'))
set(menuH,'Children',flip(get(menuH,'Children'),1))
uimenu(menuH,'Label',['ROI ' num2str(ROINUM)],'Callback',['msgbox(''ROI ' num2str(ROINUM) ''')'])
set(menuH,'Children',flip(get(menuH,'Children'),1))
uimenu(menuH,'Label','Change Color',  'Callback',@CallbackChangeROIColor);
uimenu(menuH,'Label','Depth_Range','Callback',@CallbackDepthROI,'userdata',3,'Separator','on');
uimenu(menuH,'Label','Time_Range','Callback',@CallbackDepthROI,'userdata',4);
if max(strcmpi(class(h),{'imrect','imellipse'}))
    uimenu(menuH,'Label','Width','Callback',@CallbackROIrange,'userdata',3);
    uimenu(menuH,'Label','High','Callback',@CallbackROIrange,'userdata',4);
end
% uimenu(menuH,'Label','Mask2delete','Callback',@Callback_Mask2Delete,'Separator','on')
if max(strcmpi(class(h),{'imrect','imellipse','impoly'}))
    uimenu(menuH,'Label','Crop','Callback',@CallbackCrop,'Separator','on')
end
uimenu(menuH,'Label','ROI Delete', 'Callback',@CallbackDeleteROI,'Separator','on');


% add field
data.ROIclass = class(h);
data.Position = [];
set(cat(1,get(h,'children'),textH),'UIcontextMenu',menuH,'userdata',data)

% % imline text edit%%%%
if strcmpi(class(h),'imline')
    Len = GetROILength(fgh,ROINUM);
    Len = round(Len*100)/100;
    StrName = data.Name;
    StrName(StrName==' ') = '#';
    set(textH,'Color',ones(1,3)*0.1)
    set(textH,'String',[StrName ' = ' num2str(Len) ' um'])
    set(textH,'Position',mean(posi,1))
    set(textH,'BackgroundColor',ones(1,3)*0.9)
end

%%%%%%%%%%%%%%


end

    % \\ ----Class ROI----
function MotionROI
fgh = gcf;
data = get(gco,'userdata');
if isempty(data)
    return
end

h = data.handle;
posi = getPosition(h);
[Py,b] = min(posi(:,1));
Px = posi(uint32(b(1)),2);
try
    imsiz = size(getimage(gca));
catch err
    disp(err.message)
    imsiz = [512 512 3];
end
PlusPosiY = imsiz(1)/60;
PlusPosiX = imsiz(1)/40;
    
if strcmpi(class(h),{'imline'})
    text_AddHight = 0;
    ROINUM = data.NUM;
    STR = num2str(GetROILength(fgh,ROINUM));
    if length(STR)>5
        STR = STR(1:5);
    end
    bw = createMask(h);im = getimage(gca);im = im(:,:,1);
    reso = getappdata(fgh,'Resolution');
    L = im(bw); L = abs(diff(L));[~,b1] = max(L);L(b1) = 0;[~,b2] = max(L);
    DistEdge = abs(b1-b2) * (GetROILength(fgh,ROINUM)/sum(bw(:)));
    StrName = data.Name;
    StrName(StrName==' ') = '#';
    set(data.textH,'Posi',mean(posi,1),'color',getColor(h),'String',[StrName ' = ' STR ' um'])
    data.textH.BackgroundColor = ones(1,3)*0.9;
    data.textH.Color = [.1 .1 .1];
%     set(data.textH,'Posi',[Py-PlusPosiX*2 Px-PlusPosiY],'color',getColor(h),'String',[data.Name ': ' STR 'um'])
%     set(data.textH,'Posi',[Py-PlusPosiX*2 Px-PlusPosiY],'color',getColor(h),'String',['  ' num2str(DistEdge) 'um'])
    set(data.textH,'FontUnits','centimeters')
    posi = get(data.textH,'Position');
    set(data.textH,'position',[posi(1) posi(2)-text_AddHight]);
    set(data.textH,'FontUnits','Pixels')
%     set(data.textH,'Posi',[Py Px-5],'color',getColor(h),'String',data.Name)
else
    set(data.textH,'Posi',[Py-PlusPosiX Px-PlusPosiY],'color',getColor(h),'String',data.Name)
end


% Draw ROI data
Nowsubfgh = findobj('Parent',fgh,'Tag','ViewerPanel');
if ~(numel(Nowsubfgh)==1)
    return
end
NowChannels = getappdata(Nowsubfgh,'NowChannles');

if ~(numel(NowChannels)==1)
    return
end
ROIviewH = findobj('Tag',['ROIview' num2str(fgh.Number)]);
if ~isempty(ROIviewH)
    Userdata = get(h,'Userdata');
    h = Userdata.handle;
    Userdata = get(h,'Userdata');
    ROIdata = getappdata(fgh,'NowROIdata');
    Lineobh = ROIdata(Userdata.NUM).Lineobh;
    data = get(ROIdata(data.NUM).handle,'userdata');
    if strcmpi(ROIviewH.Title,'ROI Mean Intensity View')
        DIM = getappdata(fgh,'MeanIntensityDIM');
        if ~isempty(Lineobh)
            Time = Userdata.Time;
            Depth = Userdata.Depth;
            switch DIM
                case 4
                    A = GetROImeanIntensity(fgh,h,GetCenterNow(3,fgh),Time,NowChannels);
                    A = A(:,GetCenterNow(3,fgh),NowChannels);
                case 3
                    A = GetROImeanIntensity(fgh,h,Depth,GetCenterNow(4,fgh),NowChannels);
                    A = A(GetCenterNow(4,fgh),:,NowChannels);
            end
            set(Lineobh,'Ydata',A,'Color',getColor(h))
        end
    else
        Reso = getappdata(fgh,'Resolution');
        Nowsubfgh = findobj('Parent',fgh,'Tag','ViewerPanel');
        ImAxh = getappdata(Nowsubfgh,'axh');
        if and(~isempty(Lineobh),max(strcmpi(class(h),{'imline','line'})))
            SliceImage = single(getimage(ImAxh));
            Posi = getPosition(h);
            Len = diff(Posi,1,1);
            Len = sqrt(sum(Len.^2,2));
            PixNum = max(round(Len /(Reso(1)/10))+1,31);
            NewReso = Len/(PixNum-1);
            vx = linspace(Posi(1,1),Posi(2,1),PixNum);
            vy = linspace(Posi(1,2),Posi(2,2),PixNum);
            if size(SliceImage,3)
                im = single(SliceImage(:,:,1));
            else
                im = single(SliceImage);
            end
            A = interp2(im,vx,vy);
            XDATA = (0:PixNum-1)*NewReso;
            XDATA = XDATA - (mean(XDATA(XDATA>0)));
            set(Lineobh,'Ydata',A,'XData',XDATA,'Color',getColor(h))
        end
    end
    set(h,'userdata',data)
end

end

function varargout= GetROILength(fgh,ROINUM)
nargoutchk(0,1)
ROIdata = getappdata(fgh,'NowROIdata');
Resolution = getappdata(fgh,'Resolution');
h = ROIdata(ROINUM).handle;
if isempty(h)
    return
end
posi = getPosition(h);
x = posi(:,1);
y = posi(:,2);
MaxX = max(x);
MinX = min(x);
MaxY = max(y);
MinY = min(y);
Len = sqrt(((MaxX-MinX)*Resolution(1))^2+((MaxY-MinY)*Resolution(2))^2);
if nargout==0
    disp([num2str(Len) ' ???????ʂ?'])
elseif nargout==1
    varargout{1} = Len;
end
end

function CallbackDepthROI(oh,~)
fgh = gcbf;
DIM = get(oh,'Userdata');
Image = getappdata(fgh,'Nowdata');
NowImageSiz = size(Image.Image);
if NowImageSiz(DIM) >= 2
    x = NowImageSiz(DIM);
else
    x = 1;
end

handle = get(gco,'userdata');
handle = handle.handle;
Depth = get(handle,'userdata');
if DIM==3
    Depth = Depth.Depth;
%     Depth = GetCenterNow(3,fgh);
else
    Depth = Depth.Time;
end
Depth = inputdlg({[get(oh,'label') ' Low'];[ get(oh,'label') ' high']},...
    get(oh,'Label'),1,{num2str(Depth(1)); num2str(Depth(end))});
%             'Input for Depth',1,{num2str(GetCenterNow(3,fgh)); num2str(GetCenterNow(3,fgh))});
            
if isempty(Depth)
    return
else

    for i = 1:2
        Depth{i} = eval(Depth{i});
    end
    Depth = cell2mat(Depth);
    
    if Depth==0
        warning('Input Index is not Correct. retrun...')
        return
    else
        
        data = get(handle,'userdata');
        if DIM==3
            data.Depth = GetTorF(Depth,x);
        else
            data.Time = GetTorF(Depth,x);
        end
        set(handle,'userdata',data)
    end    
end
    function A = GetTorF(Depth,z)
        Depth = sort(Depth(:));
        if Depth(1)<1
            Depth(1) = 1;
        elseif Depth(2)>z
            Depth(2) = z;
        end
        A = double( Depth ) ;  
        if size(A,2) ==1
            A = A';
        end
    end
end

function CallbackROIrange(oh,~)
handle = get(gco,'Userdata');
handle = handle.handle;
posi = getPosition(handle);
Label = get(oh,'Label');
defstr = num2str(posi(get(oh,'userdata')));

Input = inputdlg(Label,['Set ' Label],1,{defstr});
if isempty(Input)
    return
end
Input = str2double(Input{1});
posi(get(oh,'userdata')) = Input;
setPosition(handle,posi)
end

function Callback_Mask2Delete(~,~)
oh  = gco;
fgh = gcbf;
Userdata = get(oh,'Userdata');
h = Userdata.handle;
Userdata = get(h,'Userdata');
Mask = ~createMask(h);
Depth = Userdata.Depth;
Time = Userdata.Time;
Image = GetNowImage(fgh,getappdata(fgh,'DataType'));
ImageClass = class(Image);
Mask = feval(ImageClass,Mask);
for chNUM = 1:size(Image,5)-1
    for t = Time(1):Time(end)
        for k = Depth(1):Depth(end)
            Image(:,:,k,t,chNUM) = Image(:,:,k,t,chNUM).*Mask;
        end
    end
end
data = getappdata(fgh,'Nowdata');
data.Processed.Image = Image;
setappdata(fgh,'Nowdata',data)
setappdata(fgh,'DataType','Processed')
Ph = findobj('Parent',findobj('Parent',fgh,'Label',' Edit'),'Label','DataType');
ch = get(Ph,'Children');
set(ch(1),'Checked','on')
set(ch(2),'Checked','off')
ch = get(fgh,'Children');
CallbackSlider(ch(1))
end

function CallbackCrop(~,~)
oh  = gco;
fgh = gcbf;
Userdata = get(oh,'Userdata');
h = Userdata.handle;
Userdata = get(h,'Userdata');
Mask = createMask(h);
Depth = Userdata.Depth;
Time = Userdata.Time;
Image = GetNowImage(fgh,getappdata(fgh,'DataType'));
ImageClass = class(Image);
Mask = feval(ImageClass,Mask);
for t = Time(1):Time(end)
    for k = Depth(1):Depth(end)
        Image(:,:,k,t) = Image(:,:,k,t).*Mask;
    end
end
ylen = logical(max(Mask,[],2));
xlen = logical(max(Mask,[],1));
Image = Image(ylen(:),xlen(:),Depth(1):Depth(end),Time(1):Time(end),:);
export2wsdlg({'Crop'},{'CropImage'},{Image},'Save Crop Image')
end

function CallbackDeleteROI(~,~)
fgh = gcbf;
data = get(gco,'userdata');
data = get(data.handle,'Userdata');
NUM = data.NUM;
ROIdata = getappdata(fgh,'NowROIdata');

delete(data.textH)
if ishandle(ROIdata(NUM).Lineobh)
    delete(ROIdata(NUM).Lineobh)
end
delete(data.handle)

ROIdata(NUM).handle = [];
ROIdata(NUM).existTF = false;
setappdata(fgh,'NowROIdata',ROIdata)
end

function CallbackChangeROIColor(~,~)
fgh = gcbf;
data = get(gco,'userdata');
GUI = Sugashi_GUI_support;
% nC = uisetcolor(getColor(data(1).handle));
nC = GUI.select_color;
if isempty(nC)
    return
end
% InputColor = inputdlg({'RGB color'},'Set ROI Color',1,{['[' num2str(getColor(data.handle)) ']']});
% if isempty(InputColor)
%     return
% end
% try
%     eval(['InputColor = ' InputColor{1} ';'])
% catch err;
%     errordlg(err.message,'Change ROI Color','modal')
%     return
% end
% nC = InputColor;

ROIdata = getappdata(fgh,'NowROIdata');
for i = 1:size(data,2)
    setColor(data(i).handle,nC)
    set(data(i).textH,'Color',nC)
    if ishandle(ROIdata(data(i).NUM).Lineobh)
        set(ROIdata(data(i).NUM).Lineobh,'Color',nC)
    end
end
end

%% View ROIs function
function ViewROI(fgh,varargin)
% ViewROI(fgh,varargin)
% 
%  Input ...
%      fgh : figure handle
%      VisibleOnOFF as varargin (1 =< nargin =< 2),
%          All  ************ input String, --> all of ROI will be "Visible ON"
%          CurrentRange **** input String, --> Current Field of View of ROI will be "Visible ON"
%          '0' *************** input zero String, --> all of ROI will be "Visible OFF"

ROIdata = getappdata(fgh,'NowROIdata');
MIPinfo = getappdata(fgh,'MIP');
WindowsNUM = getappdata(fgh,'WindowsNUM');       %% Number of Windows {1}, 2 , 3 , 4
ViewerType = getappdata(fgh,'ViewerType');    %% viewr type {'xy'},'xz','yz','xyz','xt','yt','xyt'

if WindowsNUM~=1 || ~max(strcmpi(ViewerType,{'xy','xz','yz'}))
    return
end
if nargin==2
    VisibleOnOff = varargin{1};
else
    VisibleOnOff = 0;
end

slicenow = GetCenterNow(3,fgh);
timenow  = GetCenterNow(4,fgh);
if MIPinfo.Dim == 3
    slicenow = [slicenow slicenow+MIPinfo.NUM-1];
    timenow = [timenow timenow];
elseif MIPinfo.Dim == 4    
    slicenow = [slicenow slicenow];
    timenow = [timenow timenow+MIPinfo.NUM-1];
end

AddViewDepth = getappdata(fgh,'ROI_AddDepth'); %%% Add Visible Depth
for i = 1:size(ROIdata,2)
    h = ROIdata(i).handle;
    if ~isempty(h) 
        data = get(h,'userdata');
        if strcmpi(ViewerType,data.ROIplane)
            textH = data.textH;
            Depth = data.Depth;
            Time  = data.Time;
            if ~strcmpi(VisibleOnOff,'0')
                if strcmpi(VisibleOnOff,'all')
                    set(h,'visible','on')
                    set(textH,'visible','on')                                    
                elseif strcmpi(VisibleOnOff,'CurrentRange')
%                     disp('here')
                    TFtime = and(max(timenow(1))<=Time,max(timenow(2)>=Time));
                    TFdepth = and(max(slicenow(1)-AddViewDepth <=Depth(end)),...
                        max(slicenow(2)+ AddViewDepth >=Depth(1)));
                    TF = and(TFtime,TFdepth);
                    if TF
                        set(h,'visible','on')
                        set(textH,'visible','on')                                    
                    else
                        set(h,'visible','off')
                        set(textH,'visible','off')                                    
                    end
                else
                    error('Input Visible type is false.')
                end
            else
                set(h,'visible','off')
                set(textH,'visible','off')
            end
        end
    end    
end
drawnow
end

function Type = ROI_VisibleTypeCheck(fgh)
    h = getappdata(fgh,'ROI_Visible_Handles');
    for n = 1:length(h)
        if strcmpi(h(n).Checked,'on')
            if n == 1
                Type = 'All';
            elseif n == 2
                Type = 'CurrentRange';
            elseif n == 3
                Type = '0';
            end
            break
        end            
    end
end

function Callback_VisibleAll(~,~)
    fgh = gcf;
    ViewROI(fgh,'All')
    h = getappdata(fgh,'ROI_Visible_Handles');
    for n = 1:length(h)
        h(n).Checked = 'off';
    end
    h(1).Checked = 'on';
end

function Callback_VisibleAllCurrentMIPNUM(~,~)
    fgh = gcf;
    ViewROI(fgh,'CurrentRange')
    h = getappdata(fgh,'ROI_Visible_Handles');
    for n = 1:length(h)
        h(n).Checked = 'off';
    end
    h(2).Checked = 'on';
end

function Callback_VisibleAllOFF(~,~)
    fgh = gcf;
    ViewROI(fgh,'0')
    h = getappdata(fgh,'ROI_Visible_Handles');
    for n = 1:length(h)
        h(n).Checked = 'off';
    end
    h(3).Checked = 'on';
end

%% others ROI FUnction%%%%%%%%%%%%%%%%%%%%%%%%
function Callback_ShortCutKeyROI(oh,~)
    Handles = getappdata(gcf,'ROI_ShortCutKey_Handles');
    for n = 1:length(Handles)
        Handles(n).Checked = 'off';
    end
    oh.Checked = 'on';
end
function A = Get_ShortCutKeyROI_Label(fgh)
    Handles = getappdata(fgh,'ROI_ShortCutKey_Handles');
    for n = 1:length(Handles)
        if strcmpi(Handles(n).Checked,'on')
            A = Handles(n).Label;
            break
        end
    end
end


function Callback_DeleteAll(~,~)
fgh = gcbf;
ROIdata = getappdata(fgh,'NowROIdata');
if isempty(ROIdata)
    return
end
QusAns = questdlg('DELETE ALL ROI ?');
if isempty(QusAns)
    return
end
if max(strcmpi(QusAns,{'No','Cancel'}))
    return
end
try
    for n = 1:size(ROIdata,2)
        if ROIdata(n).existTF
            h = ROIdata(n).handle;
            if ~isempty(h)
                Udata = get(h,'Userdata');
                txth = Udata.textH;
                delete(h)
                delete(txth)
            end        
        else
%             disp('cant')
        end
    end
    setappdata(fgh,'NowROIdata',[])
    msh = msgbox('All ROI Deleted');
    pause(5)
    if ishandle(msh)
        close(msh)
    end
catch err
    errordlg({'   Miss!!! ' ; err.message},'Delete All ROI','modal')
end
end

function Callback_CreateImageMaskFromAllROI(~,~)
fgh = gcbf;
ROIdata = getappdata(fgh,'NowROIdata');
if isempty(ROIdata)
    return
end
A = false(size(GetNowImage(fgh)));
A = A(:,:,:,:,1);
wh = waitbar(0,'Wait..');
for n = 1:size(ROIdata,2)
    h = ROIdata(n).handle;
    if ~isempty(h)
        A = or(A,CreateMaskImage(fgh,h));
    end
    waitbar(n/length(ROIdata),wh)
end
close(wh)
export2wsdlg({'Create Mask Image'},{'BWMaskImage'},{A},'Save Mask Image')
end

function A = CreateMaskImage(fgh,h)
siz = [size(GetNowImage(fgh)) 1 1 1];
Mask = createMask(h);
Udata = get(h,'Userdata');
Depth = double(Udata.Depth);
Time = double(Udata.Time);
A = padarray(Mask,[0 0 siz(3)-Depth(end) siz(4)-Time(end) 0],false,'post');
A = padarray(A,[0 0 Depth(end)-Depth(1) Time(end)-Time(1) 0],'replicate','pre');
A = padarray(A,[0 0 siz(3)-size(A,3) siz(4)-size(A,4) 0],false,'pre');
end

function A = ROI2matdata(fgh)
% ROIdata(ROINUM).handle = h;
% ROIdata(ROINUM).existTF = true;
% ROIdata(ROINUM).class = class(h);
% ROIdata(ROINUM).Position = [];
% ROIdata(ROINUM).Plane = ViewerType;
% ROIdata(ROINUM).Depth = data.Depth;
% ROIdata(ROINUM).Time = data.TIme; 
ROIdata = getappdata(fgh,'NowROIdata');
NewROIdata = ROIdata;
if ~isempty(ROIdata)
    for i = 1:size(ROIdata,2)
        h = ROIdata(i).handle;
        if ~isempty(h)
            NewROIdata(i).handle = [];
            NewROIdata(i).class = class(h);
            NewROIdata(i).Position = getPosition(h);
            data = get(h,'userdata');
            NewROIdata(i).Depth = data.Depth;
            NewROIdata(i).Time  = data.Time;
            NewROIdata(i).Color = getColor(h);
        end        
    end
    A = NewROIdata;
else
    A = [];
end
end

function SetappROIdata(fgh)
ROIdata = getappdata(fgh,'NowROIdata');
WindowsNUM = getappdata(fgh,'WindowsNUM');     
ViewerType = getappdata(fgh,'ViewerType'); 

if WindowsNUM~=1 || ~max(strcmpi(ViewerType,{'xy','xz','yz'}))
    return
end
if ~isempty(ROIdata)
    for n = 1:size(ROIdata,2)        
        if and(strcmpi(ViewerType,ROIdata(n).Plane),ROIdata(n).existTF)
            ROIdata(n).existTF = false;
            setappdata(fgh,'NowROIdata',ROIdata)
            DrawROI(fgh,[],ROIdata(n).class,ROIdata(n).Position,ROIdata(n).Depth,ROIdata(n).Time,ROIdata(n).Color)
            ROIdata = getappdata(fgh,'NowROIdata');
        end
    end
end
setappdata(fgh,'NowROIdata',ROIdata)
end

function Callback_ROIMeanIntensityView(~,~)
fgh = gcbf;
if ~strcmpi('xy',getappdata(fgh,'ViewerType'))
    return
end
if ~(getappdata(fgh,'WindowsNUM')==1)
    return
end
ROIdata = getappdata(fgh,'NowROIdata');
if isempty(ROIdata)
    return
end
Reso = getappdata(fgh,'Resolution');
DIM =  getappdata(fgh,'MeanIntensityDIM');
Nowsubfgh = findobj('Parent',fgh,'Tag','ViewerPanel');

viewfig = findobj('Tag',['ROIview' num2str(fgh.Number)]);
if isempty(viewfig)
    [subfghP,~]  = GetSubFigPosi(fgh,2,getappdata(fgh,'slwidth'));
    set(Nowsubfgh,'Position',subfghP(1).position)
    fh = uipanel(fgh,...
        'Position',subfghP(2).position,...
        'Title','ROI Mean Intensity View',...
        'Tag',['ROIview' num2str(fgh.Number)]);    
    axh = axes('Parent',fh,'Position',[0.18 0.18 .78 .78]);
    setappdata(fh,'axesh',axh)
    hold(axh,'on')
    NowChannels = getappdata(Nowsubfgh,'NowChannles');
    if ~(numel(NowChannels)==1)
%         close(fh)
        delete(fh)
        [subfghP,~]  = GetSubFigPosi(fgh,1,getappdata(fgh,'slwidth'));
        set(Nowsubfgh,'Position',subfghP(1).position)
        return
    end
    LegendSTR = cell(size(ROIdata,2),1);
    Counter = 1;
    for n = 1:size(ROIdata,2)
        h = ROIdata(n).handle;
        if ~isempty(h)
            Userdata = get(h,'Userdata');
            LegendSTR{Counter} = Userdata.Name;
            Counter = Counter + 1;
            Time = Userdata.Time;
            Depth = Userdata.Depth;
            switch DIM
                case 4
                    A = GetROImeanIntensity(fgh,h,GetCenterNow(3,fgh),Time,NowChannels);
                    A = A(:,GetCenterNow(3,fgh),NowChannels);
                case 3
                    A = GetROImeanIntensity(fgh,h,Depth,GetCenterNow(4,fgh),NowChannels);
                    A = A(GetCenterNow(4,fgh),:,NowChannels);
            end
            if sum(~isnan(A(:)))==1
                Marker = '.';
            else
                Marker = 'none';
            end
%             if DIM==3        
%                 XDATA = (-length(A)+1:0)*Reso(DIM);
%             else
                XDATA = (0:length(A)-1)*Reso(DIM);                
%             end
            lh = plot(XDATA,A,...
                    'color',getColor(h),'LineWidth',1.5,...
                    'Marker',Marker,'MarkerSize',8,'Tag',Userdata.Name);
            Userdata.Lineobh = lh;
            ROIdata(n).Lineobh = lh;
            setappdata(fgh,'NowROIdata',ROIdata)
            set(h,'Userdata',Userdata)
        end
    end
    legend(LegendSTR{1:Counter-1})
    xlabel(['Dim.' num2str(DIM)] )
    ylabel('Intensity [a.u.]')
end
end

function Callback_ROILineIntensityView(~,~)
fgh = gcbf;
if ~strcmpi('xy',getappdata(fgh,'ViewerType'))
    return
end
if ~(getappdata(fgh,'WindowsNUM')==1)
    return
end
ROIdata = getappdata(fgh,'NowROIdata');
if isempty(ROIdata)
    return
end
Reso = getappdata(fgh,'Resolution');
Nowsubfgh = findobj('Parent',fgh,'Tag','ViewerPanel');
ImAxh = getappdata(Nowsubfgh,'axh');
viewfig = findobj('Tag',['ROIview' num2str(fgh.Number)]);
if ~isempty(viewfig)
    delete(viewfig)
end
[subfghP,~]  = GetSubFigPosi(fgh,2,getappdata(fgh,'slwidth'));
set(Nowsubfgh,'Position',subfghP(1).position)    
fh = uipanel(fgh,...
    'Position',subfghP(2).position,...
    'Title','ROI Line Intensity View',...
    'Tag',['ROIview' num2str(fgh.Number)]);    
axh = axes('Parent',fh,'Position',[0.18 0.18 .78 .78]);
setappdata(fh,'axesh',axh)
hold(axh,'on')
NowChannels = getappdata(Nowsubfgh,'NowChannles');
if ~(numel(NowChannels)==1)
    delete(fh)
    [subfghP,~]  = GetSubFigPosi(fgh,1,getappdata(fgh,'slwidth'));
    set(Nowsubfgh,'Position',subfghP(1).position)
    return
end
LegendSTR = cell(size(ROIdata,2),1);
Counter = 1;
SliceImage = getimage(ImAxh);
for n = 1:size(ROIdata,2)
    h = ROIdata(n).handle;
    if max(strcmpi(class(h),{'imline','line'}))
        Userdata = get(h,'Userdata');
        LegendSTR{Counter} = Userdata.Name;
        Counter = Counter + 1;
        Posi = getPosition(h);
        Len = diff(Posi,1,1);
        Len = sqrt(sum(Len.^2,2));
        PixNum = max(round(Len /(Reso(1)/10))+1,31);        
        NewReso = Len/(PixNum-1);
        vx = linspace(Posi(1,1),Posi(2,1),PixNum);
        vy = linspace(Posi(1,2),Posi(2,2),PixNum);
        if size(SliceImage,3)
            im = single(SliceImage(:,:,1));
        else
            im = single(SliceImage);
        end
        A = interp2(im,vx,vy);

        if sum(~isnan(A(:)))==1
            Marker = '.';
        else
            Marker = 'none';
        end
        XDATA = (0:PixNum-1)*NewReso;
        XDATA = XDATA - (mean(XDATA(XDATA>0)));
        lh = plot(XDATA,A,...
                'color',getColor(h),'LineWidth',1.5,...
                'Marker',Marker,'MarkerSize',8,'Tag',Userdata.Name);
        Userdata.Lineobh = lh;
        ROIdata(n).Lineobh = lh;
        setappdata(fgh,'NowROIdata',ROIdata)
        set(h,'Userdata',Userdata)
    end
end
legend(LegendSTR{1:Counter-1})
xlabel('Length [\mum]' )
ylabel('Intensity [a.u.]')


if Counter == 1
    delete(fh)
    [subfghP,~]  = GetSubFigPosi(fgh,1,getappdata(fgh,'slwidth'));
    set(Nowsubfgh,'Position',subfghP(1).position)
    return
end


    function Callback_XLSX(fh,~)
        fh = get(fh,'Parent');
        axh =getappdata(fh,'axesh');
        ch = get(axh,'Children');         
        A = nan(1+length(get(ch(1),'Ydata')),1+length(ch));
        A(2:end,1) = get(ch(1),'xdata');
        for datan = 1:length(ch)
            A(2:end,datan+1) = get(ch(datan),'Ydata');
        end
        A = num2cell(A);
        for datan = 1:length(ch)
            A{1,1+datan} = get(ch(datan),'Tag');
        end
        TFxlsx = true;
        while TFxlsx
            Name = inputdlg({'FileName:'},'Input LifFile Name',1,{'Name'});
            if isempty(Name)
                return
            end
            Name = Name{1};
            [Succese,Message] = xlswrite([Name '.xlsx'],A);
            if isempty(Succese)
                errordlg({Message.message;Message.identifier})
            else
                TFxlsx = false;
            end
        end
    end

end


function A = GetROImeanIntensity(fgh,h,Depth,Time,chNUM)
Image = GetNowImage(fgh);
Mask = createMask(h);
A = NaN(size(Image,4),size(Image,3),size(Image,5));
for chn = chNUM(1):chNUM(end)
    for k = Depth(1):Depth(end)
        for t = Time(1):Time(end)
            im = squeeze(Image(:,:,k,t,chn));
            A(t,k,chn) = mean(im(Mask));
        end
    end
end
end

function Callback_ROIMeanIntensityDIM(oh,~)
fgh = gcbf;
DIM = str2double(get(oh,'Label'));
ch = get(get(oh,'Parent'),'Children');
set(ch,'Checked','off')
set(oh,'Checked','on')
setappdata(fgh,'MeanIntensityDIM',DIM)
end


function Callback_Measurement(oh,~)
Fsize = 20; %% mesurementROI font size
fgh = oh.Parent.Parent.Parent;
vType = getappdata(fgh,'ViewerType');
Reso = getappdata(fgh,'Resolution');
% viewr type {'xy'},'xz','yz','xyz','xt','yt','xyt'
switch vType
    case {'xyz','xyt'}
        errordlg({'Not Enabel Viewer Type...';'(It might be xyz or xyt, Now.)'})
    case 'xy'
        input_reso = Reso([1 2]);
    case 'xz'
        input_reso = Reso([1 3]);
    case 'yz'
        input_reso = Reso([2 3]);
    case 'xt'
        input_reso = [0 Reso(1)];
    case 'yt'
        input_reso = [0 Reso(2)];
    otherwise
end
switch oh.Label
    case 'Line'
        h = TS_imline(gca);
    case 'Poly'
        h = TS_impoly(gca);
end
udata = get(h,'Userdata');
udata.Resolution = input_reso;
udata.txh.FontSize = Fsize;
set(h,'Userdata',udata);

end

%% Measurement ByHand
function Callback_MeasurementByHand(oh,~)
fgh = oh.Parent.Parent.Parent;
vType = getappdata(fgh,'ViewerType');
ROIdata = getappdata(fgh,'NowROIdata');
if ~strcmpi(vType,'xy')
    errordlg('Viewer Type is NOT ''xy''!')
    return
end
if ~isempty(ROIdata)
    errordlg({'Exist ROIdata.';'     Need to Delete All ROIdata'})
    return
end

%% by hand , main flow
d = dialog('Position',[300 300 500 160],'Name','Manual Measurement (Line) Start!!');
    txt = uicontrol('Parent',d,...
               'Style','text',...
               'Position',[10 50 480 100],...
               'String',{'Click the close button when you''re READY to measurement.';
               '(You can draw a Line with draging of Scroll buttton at your mouse.)'},...
               'FontSize',12);
    btn = uicontrol('Parent',d,...
               'Position',[370 10 70 25],...
               'String','Close',...
               'Callback','delete(gcf)');
   centerfig(d)
waitfor(d)
ph = uimenu(oh.Parent,'label','Finish and Write data to xls and mat.',...
    'ForegroundColor','r');
    uimenu(ph,'Label','Do it.',...
    'Callback',@Callback_FinishMeasurementByHand,...
    'ForegroundColor','r',...
    'Userdata',oh);
    uimenu(ph,'Label','Exit measurement mode.',...
        'Callback',@Callback_DeleteAll_FinishByHand,...
        'Userdata',oh)
    function Callback_DeleteAll_FinishByHand(objh,~)
        choice = questdlg('Really ?',...
        'Before Exit...',...
        'Wait, continue.','Exit, Measurement mode.','Wait, continue.');
        if strcmpi('Exit, Measurement mode.',choice)
            oh = get(objh,'Userdata');
            oh.ForegroundColor = 'r';
            SetUimenuEnable(fgh,'on')
            delete(objh.Parent)
        end
    end
oh.ForegroundColor = 'b';

type = {'off'; 'off';'off';'off';'on'};
SetUimenuEnable(fgh,type)

end

function Callback_FinishMeasurementByHand(oh,~)

h = get(oh,'Userdata');
fgh = oh.Parent.Parent.Parent.Parent;
vType = getappdata(fgh,'ViewerType');
if ~strcmpi(vType,'xy')
    errordlg('Viewer Type is NOT ''xy''!')
    return
end
data = getappdata(fgh,'Nowdata');
        handles = getappdata(fgh,'Handledata');
        axh = handles.Axes.axes_handle;
        imh = findobj('Parent',axh,'Type','image');

ROIdata = getappdata(fgh,'NowROIdata');
continueTF = false;
Dnum = zeros(1,length(ROIdata));
Tnum = zeros(1,length(ROIdata));
for n = 1:length(ROIdata)
    hdata = get(ROIdata(n).handle,'Userdata');
    if isempty(hdata)
        continue
    end
    hdata = hdata.textH;
    if ROIdata(n).existTF
        continueTF = true;
         set(ROIdata(n).handle,'Visible','on')
         hdata.Visible = 'on';
         Dnum(n) = ROIdata(n).Depth;
         Tnum(n) = ROIdata(n).Time;
    else
        set(ROIdata(n).handle,'Visible','off')
        hdata.Visible = 'off';
    end
end
Dnum = [min(Dnum(Dnum>0)) max(Dnum(Dnum>0))];
Tnum = [min(Tnum(Tnum>0)) max(Tnum(Tnum>0))];
NowCh = GetCenterNow(5,fgh);
imh.CData = rgbproj(squeeze(max(max(data.Image(:,:,Dnum,Tnum,NowCh),[],3),[],4)));

if ~continueTF
      warndlg('Not Exist ROI....??')
    return
end
d = dialog('Position',[300 300 500 160],'Name','Manual Measurement (Line) Last Step!!');
    txt = uicontrol('Parent',d,...
               'Style','text',...
               'Position',[10 50 480 100],...
               'String',{'Click the close button when you move to Last Step.';
               '    (You shoud take a picrue, proof of ROIdata by hand..)';
               '    (Clik(Right) at axes, and then you can save picture.)';
               '';
               'At 1st, Decide Save Directory....'},...
               'FontSize',12);
    btn = uicontrol('Parent',d,...
               'Position',[370 10 70 25],...
               'String','Close',...
               'Callback','delete(gcf)');
   centerfig(d)
waitfor(d)

%% get save dir
SaveDir = uigetdir;
if SaveDir ==0
    warndlg('Not Finsh....??')
    return
end

NowDir = cd;
cd(SaveDir)

ROIdata = ROI2matdata(fgh);
% % % type of xls {#ROI,Length,sx,sy,ex,ey,'depth','time'}
Reso = getappdata(fgh,'Resolution');
Reso = Reso(1:2);
XLSdata = [];
for n = 1:length(ROIdata)
    if ROIdata(n).existTF
        Posi = double(ROIdata(n).Position);
        Len = sqrt( sum( (diff(Posi,1,1) .*Reso ).^2,2 ) );
        Posi = [Posi(1,:) Posi(2,:)];
        Depth = ROIdata(n).Depth;
        
        if ~isscalar(Depth)
            if Depth(1) == Depth(2)
                Depth = Depth(1);
            else
                error(['Including NOT Correct Data.(Depth) N = ' num2str(n)])
            end
        end
        Time = ROIdata(n).Time;
        if ~isscalar(Time)
            error(['Including NOT Correct Data.(Time) N = ' num2str(n)])
        end
        Add_Line = [n Len Posi double(Depth) double(Time)];
        XLSdata = cat(1,XLSdata,Add_Line);
        
    end
end
whos
TOPcell = {'Num.','Length[um]','x1','y1','x2','y2','Depth(slice)','Time(slice)'};

XLS = cat(1,TOPcell,num2cell(XLSdata));
Fname = inputdlg('Name (input)','',1,{'ManumalROI'});
if isempty(Fname)
    warndlg('Not Finsh....??')
    return
end
Fname = Fname{1};
check_name = dir([Fname '_ROIdata.mat']);
if ~isempty(check_name)
    errordlg('Exist Name!!! return...')
    return
end
    
%% write xls
xlswrite([Fname 'XLSx.xlsx'],XLS)
%% save ROIdata
save([Fname '_ROIdata.mat'],'ROIdata','XLS')
%% save picture(all ROI)
im = getframe(gca);
imwrite(im.cdata,[Fname '_ALL.tif'])

%% save each ROI picture
OKorNONE  = questdlg('Do you want to save EACH ROI picture?',...
    'Before Finish Last Step.',...
    'Yes','No','Yes');
switch OKorNONE
    case 'Yes'
        Margin_Value = 0.2;
        Margin_MIN = 10;
        ExistCheck = ROIdata; %% because Now...ROIdata = ROI2matdata(fgh);
        ROIdata = getappdata(fgh,'NowROIdata');
        for n = 1:length(ROIdata)            
            set(ROIdata(n).handle,'Visible','off')
                hdata = get(ROIdata(n).handle,'Userdata');
                if isempty(hdata)
                    continue
                end
                hdata = hdata.textH;
                hdata.Visible = 'off';
        end
        for n = 1:length(ROIdata)
            if ExistCheck(n).existTF
                hdata = get(ROIdata(n).handle,'Userdata');
                hdata = hdata.textH;
                set(ROIdata(n).handle,'Visible','on')
                hdata.Visible = 'on';
                Depth = ROIdata(n).Depth;
                Time = ROIdata(n).Time;
                imh.CData = rgbproj(squeeze(data.Image(:,:,Depth,Time,NowCh)),'auto');
                posi = getPosition(ROIdata(n).handle);
                Margin_Min = max(sqrt(sum(diff(posi,1,1).^2,2)),Margin_MIN);
                MarginX = max(abs(diff(posi(:,1))) * Margin_Value , Margin_Min);
                MarginY = max(abs(diff(posi(:,2))) * Margin_Value , Margin_Min);
                XLim = sort([posi(1) posi(2)]);
                XLim = [XLim(1)-MarginX XLim(2)+MarginX];
                xlim(axh,XLim)
                YLim = sort([posi(3) posi(4)]);
                YLim = [YLim(1)-MarginY YLim(2)+MarginY];
                ylim(axh,YLim)
                drawnow
                disp([num2str(n) '/' num2str(length(ROIdata))])
%                 pause(.3)
                im = getframe(axh);
                imwrite(im.cdata,[Fname '_Num' num2str(n) '.tif'])
                set(ROIdata(n).handle,'Visible','off')
                hdata.Visible = 'off';
            end
        end
        ResetUpView(fgh,...
                getappdata(fgh,'WindowsNUM'),...
                getappdata(fgh,'slwidth'),...
                getappdata(fgh,'ViewerType'))
    case 'No'
end

delete(oh.Parent)
cd(NowDir)
h.ForegroundColor = 'r';
type = 'on';
SetUimenuEnable(fgh,type)

end

%% ====  Callback Exit  ====
function CallbackToolExit(~,~)
fgh = gcbf;
Info = getappdata(fgh,'InfomationH');
if strcmpi(Info.Close,'on')
    choice = 'No,Close'; %% For Prototype    
else
    choice = questdlg('Do Not U Save Data?',...
        'Before Exit...',...
        'Yes,Save','No,Close','Cancel,Return','Cancel,Return');
end
    
switch choice
    case {'Yes,Save','Cancel,Return'}
        return
    case 'No,Close'
        delete(fgh)
end
end

function CallbackDetete(fgh,~)
viewfig = findobj('Tag',['ROIview' num2str(fgh.Number)]);
if ~isempty(viewfig)
    delete(viewfig)
end
end


%% =====  Key Press Fcn ====
function KeyPressFcn(fgh,ob)

if  isempty(fgh)   %or(isempty(fgh),~isstruct(ob))
    return
end
% try
%     slh(1) = findobj('Parent',fgh,'Tag','SliceSlider');
%     slh(2) = findobj('Parent',fgh,'Tag','TimeSlider');
% catch err
%     disp(err)
%     return
% end
h = getappdata(fgh,'Handledata');
SLH = h.Slider;

Type = ob.Key;
Modifier = ob.Modifier;
MIP = getappdata(fgh,'MIP');
if strcmpi(Modifier,'shift')
%     Magni = MIP.NUM;
    Magni = 10;
else
    Magni = 1;
end
switch Type
    case {'w','d'}
        pm = 1;
    case {'s','a'}
        pm = -1;
    otherwise
        return
end
switch Type
    case {'w','s'}
        slh = SLH(3);
    case {'a','d'}
        slh = SLH(4);
    otherwise
        return
end
slstep = get(slh,'SliderStep');
val = get(slh,'value')+slstep(1)*pm * Magni;
if val>1
    val = 1;
end
if val < 0
    val = 0;
end
set(slh,'value',val)
ch = get(fgh,'Children');
CallbackSlider(ch(1))
end

%% =====  ButtonDown&Up Fcn ====
function TSWindowButtonDownFcn(fgh,~)
Type = get(fgh,'SelectionType');
% % Mdata.OrldSelectionTypeDown.Type = [];
% % Mdata.OrldSelectionTypeDown.Axes = [];
% % Mdata.OrldSelectionTypeDown.CurrentPoint = [];
% % Mdata.OrldSelectionTypeUp.Type = [];
% % Mdata.OrldSelectionTypeUp.Axes = [];
% % Mdata.OrldSelectionTypeUp.CurrentPoint = [];
Mdata = getappdata(fgh,'Mousdata');
Ord_Type = Mdata.OrldSelectionTypeDown.Type;

Mdata.OrldSelectionTypeDown.Type = Type;
Mdata.OrldSelectionTypeDown.Axes = get(fgh,'CurrentAxes');
if ~isempty(get(fgh,'CurrentAxes'))
    Mdata.OrldSelectionTypeDown.CurrentPoint = get(get(fgh,'CurrentAxes'),'CurrentPoint');
else
    Mdata.OrldSelectionTypeDown.CurrentPoint = [];
end
setappdata(fgh,'Mousdata',Mdata)
% Mdata.OrldSelectionTypeDown
% Mdata.OrldSelectionTypeUp
% disp(['     Key press func.[Down] Type = ' Type])
switch Type
    case 'normal'  %% Left()        
        if ~strcmpi(Ord_Type,'alt')
            return
        end
        h = gco;
        if max(strcmpi({'imrect','impoly','imellipse','imline'},get(get(h,'Parent'),'Tag')))
            h = get(h,'Parent');
        elseif ~strcmpi('impoint',get(h,'Tag'))
            return
        end        
        if ~isempty(get(h,'Userdata'))
            return
        end        
        delete(h)
    case 'alt'     %% Right()
    case 'extend'  %% L&R() or Scroll()
    case 'open'    %% Double Click
end

end

function TSWindowButtonUpFcn(fgh,~)
Type = get(fgh,'SelectionType');
% % Mdata.OrldSelectionTypeDown.Type = [];
% % Mdata.OrldSelectionTypeDown.Axes = [];
% % Mdata.OrldSelectionTypeDown.CurrentPoint = [];
% % Mdata.OrldSelectionTypeUp.Type = [];
% % Mdata.OrldSelectionTypeUp.Axes = [];
% % Mdata.OrldSelectionTypeUp.CurrentPoint = [];
Mdata = getappdata(fgh,'Mousdata');
Mousdata = Mdata;
Mdata.OrldSelectionTypeUp.Type = Type;
Mdata.OrldSelectionTypeUp.Axes = get(fgh,'CurrentAxes');
if ~isempty(get(fgh,'CurrentAxes'))
    Mdata.OrldSelectionTypeUp.CurrentPoint = get(get(fgh,'CurrentAxes'),'CurrentPoint');
else
    Mdata.OrldSelectionTypeUp.CurrentPoint = [];
end
setappdata(fgh,'Mousdata',Mdata)
% disp(['     Key press func.[Up] Type = ' Type])
% disp('========================================')
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
    if ~isempty(Mousdata.OrldSelectionTypeDown.CurrentPoint)
        OrldPosi = Mousdata.OrldSelectionTypeDown.CurrentPoint(1,1:2);
    else
        return
    end
    if ~isempty(Mdata.OrldSelectionTypeUp.CurrentPoint)
        NowPosi =  Mdata.OrldSelectionTypeUp.CurrentPoint(1,1:2);
    else
        return
    end
    Dist = sqrt(sum((OrldPosi-NowPosi).^2));
    menuROIh = findobj('Parent',fgh,'Label','ROI');
    roiColor = menuROIh.Children(end).ForegroundColor;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
switch Type
    case 'normal'  %% Left() 
    case 'alt'     %% Right()        
%         if Dist > 3
%             StartPosi = min([OrldPosi ; NowPosi],[],1);
%             ROIPosition = [StartPosi  abs(-OrldPosi + NowPosi)];
%             DrawROI(fgh,[],'imrect',...
%                 ROIPosition,...
%                 GetCenterNow(3,fgh),GetCenterNow(4,fgh),roiColor)
%         end
    case 'extend'  %% L&R() or Scroll()
        DrawType = Get_ShortCutKeyROI_Label(fgh);
        switch lower(DrawType)
            case 'rectangle'
                if Dist > 3
                    StartPosi = min([OrldPosi ; NowPosi],[],1);
                    ROIPosition = [StartPosi  abs(-OrldPosi + NowPosi)];
                    DrawROI(fgh,[],'imrect',...
                        ROIPosition,...
                        GetCenterNow(3,fgh),GetCenterNow(4,fgh),roiColor)
                else
                    warning('Input Dist is not enough...')
                end
            case 'line'
                if Dist > 0
                    DrawROI(fgh,[],...
                        'imline',[OrldPosi ; NowPosi],...
                        GetCenterNow(3,fgh),GetCenterNow(4,fgh),roiColor)
                else
                    warning('Input Dist is not enough...')
                end
            case 'point'                
                DrawROI(fgh,[],'impoint',NowPosi,GetCenterNow(3,fgh),GetCenterNow(4,fgh),roiColor)
            otherwise
        end
    case 'open'    %% Double Click
end
end

%% Close Type 
function Callback_ChangeCloseType(oh,event)
ch = oh.Parent.Children;
for n = 1:length(ch)
    ch(n).Checked = 'off';
end
oh.Checked = 'on';
Info = getappdata(gcf,'InfomationH');
Info.Close = oh.Label;
setappdata(gcf,'InfomationH',Info)
end









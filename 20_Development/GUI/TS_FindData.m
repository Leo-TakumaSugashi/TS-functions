function TS_FindData
% 
% TS_FindData

%% initialize
global fgh ch mh lh Icons Mdata DurationDoubleClick DefaultLoadDir ...
    DefaultFigPosition FindList ObjListImage LocSTR
if and(isunix,~ismac)
    DefaultLoadDir = '/mnt/NAS/SSD/TSmatdata/';
elseif ispc
    DefaultLoadDir = '\\192.168.2.120\ssd\TSmatdata\';
elseif ismac
    DefaultLoadDir = '/Users/leo/Documents/TSmatdata';
end
Mdata.Tic = tic;
Mdata.CurrentTag = [];
Mdata.CurrentFullPath = [];
Mdata.CurrentExtention = [];
Mdata.CurrentChildName = [];
Mdata.CurrentImageList = [];
Mdata.CurrentImageInfo = [];
Mdata.SelectedObjImage = [];   %% for select object file
Icons.Import = [TS_GetPath '20_Development' filesep 'GUI' filesep 'Import_Button.png'];
Icons.Gallery = [TS_GetPath '20_Development' filesep 'GUI' filesep 'Image_Gallery_Icon.png'];
Icons.Load = [TS_GetPath '20_Development' filesep 'GUI' filesep 'Image_Gallery_Loading_Icon.png'];
DurationDoubleClick =1;
ObjListImage = cell(0);
LocSTR = {'Unown','1-ALPHA','2-BRAVO','3-CHARLIE','4-DELTA','5-ECHO','6-FOXTROT','7-GOLF','8-HOTEL','9-INDIA','10-JULIET'};
DefaultColumnName  = {'o',   'FullPath','Child Name','#Mouse','Time info.','Loc.#', 'UserData1','UserData2','UserData3','Memo'};
DefaultColumnWidth = {10,     600,       100,         60,       60,          60,      80,         80,        80,         'auto'};
DefaultColumnFormat ={'logical','char',   'char',     'char',    'char',    LocSTR,   'char',   'char',     'char',     'char'};

%% input check
List = GetList(DefaultLoadDir);
if isempty(List) 
    disp('    back...')
    return
else
end
%% create UI
fgh = uifigure(               'Position',[  1   1 950 402],...
     'Name','Find image data and edit object file',...
     'CloseRequestFcn',@CloseFunction,...
     'HandleVisibility','off');
%  fgh = uifigure;
%  fgh.Position= [  1   1 950 402];
%  fgh.Name = 'Find image data and edit object file';
%  fgh.CloseRequestFcn = @CloseFunction;
%  fgh.HandleVisibility = 'off';
TableH(1) = uipanel(fgh,      'Position',[  2 202 946 200]);
TableH(2) = uipanel(fgh,      'Position',[  2   2 946 198]);    
ch(1) = uilabel(TableH(1),    'Position',[  2 176  50  20],...
    'Text','grep :');
ch(2) = uieditfield(TableH(1),'text','Value','',...
                              'Position',[ 54 176 100  20]);
ch(3) = uibutton(TableH(1),   'Position',[156 176  60  20],...
    'Text','Apply',...
    'ButtonPushedFcn',@GrepApply);
ch(4) = uitable(TableH(1),    'Position',[  2   2 400 172],...
    'Data',List(1).Data,...
    'ColumnName',{'Full Path'},...
    'ColumnWidth',{1000},... {'auto'},...
     'ColumnEditable', true,...
    'Tag','ParentTable',...
    'CellSelectionCallback',@Callback_Select);
ch(5) = uitable('Parent',TableH(1),...
            'Units','pixels','Position',[402  62 286 112],...
            'ColumnName',     {'Name', 'Size'},...
            'ColumnWidth',    { 'auto',    'auto'},....
            'ColumnFormat',   {'char', 'char'},...
            'ColumnEditable', [ false   false   ],...
            'CellSelectionCallback',@Callback_Select,...
            'Tag','ChildrenTable');
ch(6) = uibutton(TableH(1),   'Position',[572   4  54  54],...
    'Icon',Icons.Import,'ButtonPushedFcn',@Callback_Import2ObjList,...
    'Text','','BackgroundColor',[1 1 1]);
ch(7) = uiimage(TableH(1),     'Position',[692  2 196 196],...
    'ImageSource',Icons.Gallery);
ch(8) = uislider(TableH(1),    'Position',[902  10 170 3],...
    'Orientation','Vertical');
ch(9) = uitable(TableH(2),    'Position',[  2   2 684 196],...
    'ColumnName',DefaultColumnName,...
    'ColumnWidth',DefaultColumnWidth,...
    'ColumnFormat',DefaultColumnFormat,...
    'ColumnEditable',[true false false true(1,7)],...
    'Tag','ObjectTable',...
    'CellSelectionCallback',@Callback_Select);
ch(10) = uiimage(TableH(2),    'Position',[692  2 196 196],...
    'ImageSource',Icons.Load);
ch(11) = uislider(TableH(2),   'Position',[902  10 170 3],...
    'Orientation','Vertical');
%%%%%%%%%%%%%%% 4K UHD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Posi0 = get(0,'ScreenSize');
if ismac
    UHD = [1920, 1080];
else
    UHD =[3840,2160];
end
if Posi0(3)>=UHD(1) && Posi0(4)>=UHD(2)
    
    if ~ismac
        FigPosition = [1 1 3704 1980];
%         FigPosition(3:4) = FigPosition(3:4)*2;
        TablePosi = [...
            [2 950 3700 1026];
            [2 1   3700  950]];
        ChPosi = [...
            [2,492*2,60,30];
            [64,492*2,200,30];
            [266,492*2,80,30];
            [2,2,1850,490*2];
            [1854,64,738,900];
            [2184,4, 54,54];
            [2596,1,512*2,512*2];
            [3624,50,3,600];
            [2,2,2594,470*2];
            [2600,1,472*2,472*2];
            [3624,40,3,600]];
    else
        FigPosition = [1 1 1360 990];
        TablePosi = [...
            [2 475 1356 514];
            [2 1   1356  474]];
        ChPosi = [...
            [2,492,40,20];
            [54,492,200,20];
            [256,492,60,20];
            [2,2,450,490];  %Table
            [454,64,338,388]; % Table
            [584,4, 54,54]; %% button
            [796,1,512,512]; % Image
            [1312,50,3,400];
            [2,2,794,470];
            [820,1,472,472];
            [1312,40,3,300]];
    end
    fgh.Position = FigPosition;
    for np = 1:2
        set(TableH(np),'Position',TablePosi(np,:));
    end
    for np = 1:length(ch)
        set(ch(np),'Position',ChPosi(np,:));
    end
    if ~ismac
        for n = [1 2 3 4 5 8 9 11]
            set(ch(n),'FontSize',24)
        end
    end
elseif ~ismac
    FigPosition = [1 1 1900 970];
    TablePosi = [...
        [2 465 1896 503];
        [2 1   1896  464]];
    ChPosi = [...
        [2,492-10,40,20];
        [54,492-10,200,20];
        [256,492-10,60,20];
        [2,2,450+540,490-10];
        [454+540,64,338,388-10];
        [584+540,4, 54,54];
        [796+540,1,512,512];
        [1312+540,50,3,400];
        [2,2,794+540,470-8];
        [820+540,1,472,472];
        [1312+540,40,3,300]];
    
    
    
    fgh.Position = FigPosition;
    for np = 1:2
        set(TableH(np),'Position',TablePosi(np,:));
    end
    for np = 1:length(ch)
        set(ch(np),'Position',ChPosi(np,:));
    end
    for n = [1 2 3 4 5 8 9 11]
        set(ch(n),'FontSize',11)
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

centerfig(fgh);
DefaultFigPosition = fgh.Position;

fgh.Resize = 'off';
%% Menu
mh(1) = uimenu(fgh,'Label','  File  ');
    lh = uimenu(mh(1),'Label','Find List');
    for i = 1:length(List)
        mih = uimenu(lh,'Label',List(i).Name,'UserData',List(i),'Callback',@Callback_ListSelect);
        if i == 1
            mih.Checked = 'on';
        end
    end
    FindList = List(1); %%%%%%%%%%%%% 
    uimenu(mh(1),'Label','Load Find List file','Callback',@Callback_LoadList,...
        'Separator','on');
    uimenu(mh(1),'Label','Make \and Load Find List file','Callback',@Callback_MakeLoadList);
    uimenu(mh(1),'Label','Load Object File(.mat)','Callback',@Callback_LoadObjectFile,...
        'Separator','on');
    uimenu(mh(1),'Label','Load Object File(.csv)','Callback',@Callback_LoadObjectFile,'Enable','off');
    uimenu(mh(1),'Label','Load Object File(.xls*)','Callback',@Callback_LoadObjectFile,'Enable','off');
    uimenu(mh(1),'Label','Import Object File from work space','Callback',@Callback_ImportObjectFile,'Enable','off');
    uimenu(mh(1),'Label','Save Object File(.mat)','Callback',@Callback_SaveObjectFile,...
        'Separator','on');
    uimenu(mh(1),'Label','Save Object File(.csv)','Callback',@Callback_SaveObjectFile)
    uimenu(mh(1),'Label','Save Object File(.xls*)','Callback',@Callback_SaveObjectFile,'Enable','off')
    uimenu(mh(1),'Label','Export Object File to work space','Callback',@Callback_ExportObjectFile);
    uimenu(mh(1),'Label','Exit','Callback',@CloseFunction,...
        'Separator','on');
mh(2) = uimenu(fgh,'Label','  Edit  ');
    uimenu(mh(2),'Label','Add Empry Row','Callback',@Callback_InsertRow)
    uimenu(mh(2),'Label','Insert (above)','Callback',@Callback_InsertRow)
    uimenu(mh(2),'Label','Insert (below)','Callback',@Callback_InsertRow)
    uimenu(mh(2),'Label','Delete Checked Row','Callback',@Callback_DeleteRow,...
        'Separator','on');
    uimenu(mh(2),'Label','Column Fields','Callback',@Callback_EditColumnField,...
        'Separator','on');
mh(3) = uimenu(fgh,'Label','  View  ');
    h = uimenu(mh(3),'Label','Resize');
        uimenu(h,'Label','off','checked','on','Callback',@Callback_ResizeONOFF);
        uimenu(h,'Label','on','Callback',@Callback_ResizeONOFF);
    uimenu(mh(3),'Label','Set Default Size','Callback',@BackFigSiz)
mh(4) = uimenu(fgh,'Label','  Help  ');
    uimenu(mh(4),'Label','Open Abridged edition (English)',...
        'Callback',@Callback_OpenHelp)
    uimenu(mh(4),'Label','Open Abridged edition (Japanese)',...
        'Callback',@Callback_OpenHelp)
    uimenu(mh(4),'Label','Open PDF edition',...
        'Callback',@Callback_OpenHelp)
mh(5) = uimenu(fgh,'Label','Developer');
    uimenu(mh(5),'Label','Contact','Callback',@Callback_Developer);
    uimenu(mh(5),'Label','Input Code','Callback',@Callback_Developer,...
        'Separator','on',....
        'ForegroundColor',[0 0.1 0.9]);

%% Basic function
    function CloseFunction(~,event)
%         delete(fgh)
%         return
        if ~strcmp(event.EventName,'Close')
            delete(fgh)
            return
        end
        ButtonName = questdlg('Did U Save Object File?', ...
                         'Proceed Exit ?', ...
                         'Yes, Exit.', 'Cancell, Return.','Cancell, Return.');
        if isempty(ButtonName)
            return
        end
        if strcmp(ButtonName,'Yes, Exit.')
            delete(fgh)
            return
        end
    end
    function data = GetList(FindDir)
        %TS_ConvertOurNAS('/mnt/NAS/SSD/TSmatdata/')
        a = dir(FindDir);
        TF = false(size(a));
        for n = 1:length(a)
            TF(n) = contains(a(n).name,'.csv');
        end
        Lista = a(TF);
        data(1:length(Lista)) = struct('Data',[]);
        for n = 1:length(Lista)
%             Tt = readtable([Lista(n).folder filesep Lista(n).name],...
%                 'ReadVariableName',false,...
%                 'Encoding','UTF-8');
%             data(n).Data = convertdata(Tt);
            data(n).Data = TSreadCSV([Lista(n).folder filesep Lista(n).name]);
            data(n).Name = Lista(n).name;
        end
    end
    function cc = convertdata(Tt)
        T = table2cell(Tt);
        cc = cell(size(T,1),1);
        for k = 1:size(T,1)
            for m = 1:size(T,2)
                if isempty(T{k,m})
                    continue
                end
                if m==1
                    cc{k} = T{k,m};
                else
                    cc{k} = cat(2,cc{k},' ',T{k,m});
                end
            end
        end
    end
    function Callback_ResizeONOFF(oh,~)
        a= oh.Parent.Children;
        a(1).Checked = 'off';a(2).Checked = 'off';
        oh.Checked = 'on';
        fgh.Resize = oh.Label;
    end
    
    function BackFigSiz(~,~) 
        fgh.Position = DefaultFigPosition;
    end
%% Callback Function (ui)
    function GrepApply(~,~)
        STR = get(ch(2),'Value');
        if isempty(STR),set(ch(4),'Data',FindList.Data),return,end
        
        NewData = FindList.Data;
        
        Astalisk = find(STR=='*');
        AstNum = length(Astalisk)+1;
        Astalisk = [0 Astalisk length(STR)+1];        
        TF = false(size(NewData,1),AstNum);
        for k = 1:AstNum
            checkSTR = STR(Astalisk(k)+1:Astalisk(k+1)-1);
            for n = 1:length(TF)
                TF(n,k) = contains(NewData{n,1},checkSTR);
            end
        end
        TF = sum(TF,2)==size(TF,2);
        NewData = NewData(TF,:);
        set(ch(4),'Data',NewData)
    end
    function Callback_Select(oh,event)
        Ind = event.Indices;
        if size(Ind,1)>1
            disp('return')
            return
        end
        oh.Enable = 'off';
        drawnow
        try
            if strcmp(oh.Tag,'ParentTable')
                set(ch(7),'ImageSource',Icons.Load)
                drawnow
                FullPath = event.Source.Data{Ind(1),1};
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 FullPath(FullPath==' ') = '_';
                FullPath = TS_ConvertNAS(FullPath);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                extention = CheckExtention(FullPath);
                switch extention
                    case 'Lieca Image File'
                        [imgList,xmlList] = HKloadLif_vTS(FullPath);
                    case 'OLYMPUS Image File'
                        [imgList,xmlList] = TSloadOifv0(FullPath);
                    case 'matfile'
                        [imgList,xmlList] = TSLoadMat(FullPath);
                    case 'stack'
                        error(['Current System Don''t compatible ' extention ' .'])
                        imgList = [];
                        xmlList = [];
                    otherwise
                        set(ch(5),'Data',[]);
                        set(ch(7),'ImageSource',Icons.Gallery)                        
                        oh.Enable = 'on';
                        error('What''s up??')
                end
                Mdata.CurrentFullPath = FullPath;
                Mdata.CurrentExtention = extention;
                Mdata.CurrentImageList = imgList;
                Mdata.CurrentImageInfo = xmlList;
                ResetListOfImage
                set(ch(7),'ImageSource',Icons.Gallery)
            elseif strcmp(oh.Tag,'ChildrenTable')
                if Ind(2) ==1
                    tableList = oh.Data;                    
                    extention = Mdata.CurrentExtention;
                    switch extention
                        case {'Lieca Image File','OLYMPUS Image File','matfile'}
                            disp(extention)
                            Image = Mdata.CurrentImageList(event.Indices(1)).Image;
%                             TS_3dslider(Image)
                        case 'stack'
                            error()
                        otherwise
                    end
                    Mdata.CurrentChildName = tableList{Ind(1),1};
                    SetUpSlider(Image,ch(7),ch(8))
                    Mdata.SelectedObjImage = Image;
                else
                end
            elseif strcmp(oh.Tag,'ObjectTable')
                if Ind(2) ==3
                    Image = ObjListImage{Ind(1)};
                    if isempty(Image)
                        set(ch(10),'ImageSource',Icons.Gallery)
                        error('Empty Image')
                    end
                    SetUpSlider(Image,ch(10),ch(11))
                else
                end
            end
            Mdata.CurrentTag = 'Done';
        catch err
            ErrorBox(err)
        end
        oh.Enable = 'on';
    end 
    function SetUpSlider(Image,imh,slh)
        Image = TSmedfilt2(Image,[5 5]);
%         Image = imfilter(single(Image),fspecial('gaussian',7,1.8));
%         Image = TS_HistgramLogScaler(Image,'std');
        siz = size(Image,1:5);
        if siz(3)>2 && siz(4) >2
            if siz(3)>= siz(4)
                Image = nanmean(Image,4);
            else
                Image = max(Image,[],3);
            end
        end
        Image = squeeze(Image);
%         pim = rgbproj(TS_HistgramLogScaler( max(Image,[],3),'std') );
%         pim = TS_AdjImage(max(Image,[],3));
        pim = (max(Image,[],3));
        pim = rgbproj(pim);
        set(imh,'ImageSource',pim)
        set(slh,'Limit', [1 size(Image,3)])
        sldata.imh = imh;
        sldata.Image = Image;
        set(slh,'UserData',sldata);
        set(slh,'ValueChangingFcn',@SliderFunc)
        set(slh,'ValueChangedFcn',@SliderFunc)
%         for k = 1:size(Image,3)
%             set(slh,'Value',k)
%             SliderFunc(slh,[])
%             drawnow
%         end
        function SliderFunc(oh,~)
            val = round(get(oh,'Value'));
            selfdata = get(oh,'UserData');
            Imh = selfdata.imh;
            self = selfdata.Image;
%             whos self
            im = max(self(:,:,1:val,:,:),[],3);  
            im = TS_AdjImage(im);
            im = rgbproj(squeeze(im));
            set(Imh,'ImageSource',im)
        end
    end
    % { 'Lieca Image File' ,'OLYMPUS Image File', 'stack','matfile'}
    function A = CheckExtention(FullPath)
       % switch extention
       %     case 'Lieca Image File'
       %     case 'OLYMPUS Image File'
       %     case 'stack'
       %     case 'matfile'
       %     otherwise
       % end
        p = find(FullPath=='.');   
        
        if isempty(p)
            extention = 'stack';
        elseif strcmpi(FullPath(p(end):end),'.lif')
            extention = 'Lieca Image File';
        elseif strcmpi(FullPath(p(end):end),'.oif')
            extention = 'OLYMPUS Image File';
        elseif strcmpi(FullPath(p(end):end),'.mat')
            extention = 'matfile';
        else
            extention = 'unknoun file';
        end
        A = extention;    
    end
    function Callback_Import2ObjList(~,~)
        ObjData = get(ch(9),'Data');
        NewData = cell(1,length(get(ch(9),'ColumnFormat')));
        NewData{1} = false;
        NewData{2} = Mdata.CurrentFullPath;
        NewData{3} = Mdata.CurrentChildName;
        NewData{6} = LocSTR{1};
        set(ch(9),'Data',cat(1,ObjData,NewData));
        ObjListImage = cat(1,ObjListImage,{ imresize(Mdata.SelectedObjImage,1/4) });
    end
    function ResetListOfImage
        FullPath = Mdata.CurrentFullPath ;
        extention = Mdata.CurrentExtention;
        imgList = Mdata.CurrentImageList;
        xmlList = Mdata.CurrentImageInfo;
        try
            switch extention
                case {'Lieca Image File','OLYMPUS Image File','matfile'}
                    % Base function from HKLoadLif.
                    dat=cell(numel(imgList),2);
                    for n=1:numel(imgList)
                        dat{n,1}=imgList(n).Name;           % Name of image
                        dat{n,2}=num2str(size(imgList(n).Image,1:5),'[%d, %d, %d, %d, %d]'); % size of Image
                    end   
                case 'stack'
                    error('this is stack..............')
                otherwise
                    error('Unknown Extention file....')
            end
            set(ch(5),'Data',dat)
        catch err
            ErrorBox(err)
        end
    end
%% Callback Function (menu)
    function Callback_ListSelect(oh,event)
        for n = 1:length(oh.Parent.Children)
            lh.Children(n).Checked = 'off';
        end
        oh.Checked = 'on';
        FindList = oh.UserData;
        set(ch(4),'Data',FindList.Data)
    end
    function Callback_LoadList(oh,event)
        [file,fullpath] = uigetfile([DefaultLoadDir '*.csv']);
        if file==0, return,end
        FindList = GetList([fullpath,file]);
        for n = 1:length(lh.Children)
            lh.Children(n).Checked = 'off';
        end
        uimenu(lh,'Label',FindList.Name,...
            'Callback',@Callback_ListSelect,...
            'UserData',FindList,...
            'Checked','on')
        set(ch(4),'Data',FindList.Data)
    end
    function Callback_MakeLoadList(oh,event)
        disp('callback make and load list')
    end
    function Callback_LoadObjectFile(oh,event)
        if contains(oh.Label,'.mat')
            FP = UIgetfile([DefaultLoadDir '*.mat']);
            tmpObj = ObjListImage;
            try
                s = load(FP);
                ObjListImage = cat(1,ObjListImage,s.ObjListImage);
                Data = get(ch(9),'Data');
                Data = cat(1,Data,s.cData);
                set(ch(9),'Data',Data);
            catch err
                ErrorBox(err)
                return
            end            
        elseif contains(oh.Label,'.csv')
            disp('callback load object list .csv')
        elseif contains(oh.Label,'.xls')
            disp('callback load object list .xls')
        else
            disp('callback load object list "Unknow Format"')
        end
    end
    function Callback_ImportObjectFile(oh,event)
        disp("callback import object file")
    end
    function Callback_SaveObjectFile(oh,event)
        if contains(oh.Label,'.mat')
            Input = inputdlg('save mat file','Save',1,{'.mat'});
            if isempty(Input)
                return
            end
            STR = Input{1};
            checkFile = dir([DefaultLoadDir STR]);
            if ~isempty(checkFile)
                errordlg('Input Name Alredy Existing....')
                return
            end
            cData = get(ch(9),'Data');
            save([DefaultLoadDir STR],'ObjListImage','cData')
            disp('callback save object list .mat')
        elseif contains(oh.Label,'.csv')
            disp('callback save object list .csv')
        elseif contains(oh.Label,'.xls')
            disp('callback save object list .xls')
        else
            disp('callback save object list "Unknow Format"')
        end
    end
    function Callback_ExportObjectFile(oh,event)
        disp("callback export object file")
    end
    
    
    function Callback_InsertRow(oh,event)
        oh.Label
        ObjData = get(ch(9),'Data');
        NewData = cell(1,length(get(ch(9),'ColumnFormat')));
        NewData{1,1} = false;
        TF = cell2mat(ObjData(:,1));
        p = find(TF);
        switch oh.Label
            case 'Add Empry Row'
                set(ch(9),'Data',cat(1,ObjData,NewData));
                ObjListImage = cat(1,ObjListImage,{''});
            case 'Insert (above)'
                if isempty(p)
                    return
                end
                if p(1)==1
                    set(ch(9),'Data',cat(1,NewData,ObjData));
                    ObjListImage = cat(1,{''},ObjListImage);
                    p(1) = [];
                    if isempty(p)
                        return
                    end
                    p = p+1;
                end
                while ~isempty(p)
                    ObjData = get(ch(9),'Data');
                    set(ch(9),'Data',cat(1,ObjData(1:p(1)-1,:),NewData,ObjData(p(1):end,:)));
                    ObjListImage = cat(1,ObjListImage(1:p(1)-1,:),{''},ObjListImage(p(1):end,:));
                    p = p + 1;
                    p(1) = [];                    
                end
            case 'Insert (below)'
                if isempty(p)
                    return
                end
                if p(end)==length(TF)
                    set(ch(9),'Data',cat(1,ObjData,NewData));
                    ObjListImage = cat(1,ObjListImage,NewData);
                    p(end) = [];
                    if isempty(p)
                        return
                    end                    
                end
                while ~isempty(p)
                    ObjData = get(ch(9),'Data');
                    set(ch(9),'Data',cat(1,ObjData(1:p(end),:),NewData,ObjData(p(end)+1:end,:)));
                    ObjListImage = cat(1,ObjListImage(1:p(end),:),{''},ObjListImage(p(end)+1:end,:));
                    p(end) = [];                    
                end
        end
    end
    function Callback_DeleteRow(oh,event)
        disp(oh.Label)
        ObjData = get(ch(9),'Data');
        TF = cell2mat(ObjData(:,1));
        p = find(TF);
        if isempty(p),  return;end
        ObjData(p,:) = [];
        set(ch(9),'Data',ObjData)
        ObjListImage(p,:) = [];
    end
    function Callback_EditColumnField(oh,event)
        disp('Callbak edit column field')
    end
    function Callback_OpenHelp(oh,~)
        if contains(oh.Label,'English')
        elseif contains(oh.Label,'Japanese')
        elseif contains(oh.Label,'PDF')
            
        else
            msgh = msgbox('Input Language Not Exist..','Sorry');
            waitfor(msgh)
        end
    end
    function Callback_Developer(oh,~)
        switch oh.Label
            case 'Contact'
                STR = {'Developer   :';'        Leo Takuma Sugashi';...
                       'Institution :';'        The University of Electro-Communications';        
                       'Mail address:';'        oshou.0131@gmail.com'};
                msbh = msgbox(STR,'Infomation');
                waitfor(msbh)
            case 'Input Code'
                passwd = inputdlg('Password : ');
                waitfor(passwd)
                if strcmpi(passwd,'sugashi')  
                    % lload matdata
                    % outoput PDF, xls
                    % select all button                    
                    keyboard
                elseif strcmpi(passwd,'check')                    
                    cData = get(ch(9),'Data');
                    for k = 1:size(cData,1)
                        cData{k,1} = true;
                    end
                    set(ch(9),'Data',cData)
                    drawnow
                elseif strcmpi(passwd,'kenshirou')
                    for n = 1:length(ch)
                        set(ch(n),'enable','on')
                    end
                end
        end
    end
    function ErrorBox(err)
        STR = cell(length(err.stack)*3+2,1);
        STR{1}= err.message;
        for n = 1:length(err.stack)
            STR{3+(n-1)*3} = ['file : ' ,err.stack(n).file];
            STR{4+(n-1)*3} = [ 'name : ' , err.stack(n).name];
            STR{5+(n-1)*3} = ['line :       ' , num2str(err.stack(n).line)];
        end
        eh = errordlg(STR);
        waitfor(eh)
    end
end
% 
% 
% function [data,info] = TSLoadMat(FullPath)
% matObj = matfile(FullPath);
% info = whos(matObj);
% data(1:length(info)) = struct('Name',[],'Image',[],'Size',[]);
% for n = 1:length(info)
%     data(n).Name = info(n).name;    
%     data(n).Image = matObj.(info(n).name);
%     data(n).Size = info(n).size;
% end
% end

 
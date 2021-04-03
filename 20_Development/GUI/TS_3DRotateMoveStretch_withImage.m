function varargout = TS_3DRotateMoveStretch_withImage(SEG1,SEG2,Image1,Reso1,Image2,Reso2)
% varargout = TS_3DRotateMoveStretch_withImage(SEG1,SEG2,Image1,Reso1,Image2,Reso2)

global H S V
%% check Input
if or(~isstruct(SEG1),~isstruct(SEG2))
    error('Input SEG is not Struct data.')
else
    Diameterlim = 8;
    for nn = 1:length(SEG1.Pointdata)
        AveD = nanmean(SEG1.Pointdata(nn).Diameter);
        if or(AveD > Diameterlim,SEG1.Pointdata(nn).ID<0)
            SEG1.Pointdata(nn).ID =  -1 * abs(SEG1.Pointdata(nn).ID);
        end
    end
    for nn = 1:length(SEG2.Pointdata)
        AveD = nanmean(SEG2.Pointdata(nn).Diameter);
        if or(AveD > Diameterlim,SEG2.Pointdata(nn).ID<0)
            SEG2.Pointdata(nn).ID =  -1 * abs(SEG2.Pointdata(nn).ID);
        end
    end
    
end

if and(ischar(Image1),ischar(Image2))
    try
        Base = evalin('base',Image1);
        Object = evalin('base',Image2);
        siz1 = size(Base);
        siz2 = size(Object);
        FOV1 = (siz1-1).*Reso1;
        FOV2 = (siz2-1).*Reso2;
    catch err
        keyboard
        error(err.message)
    end
else
    error('Input Image is not Charactor.')    
end
%% Initialize
NewReso1 = [1 1 2.5];
NewReso2 = NewReso1;

%% create Base 
H = create_base_GUI(NewReso1,NewReso2,FOV1,FOV2,Image1,Image2);

%% Resize
ResetSize

%% Panel3 Depict, drawing
V = Reconstruction_Group;
S = Segment_Functions;
SEG1 = S.set_Segment(SEG1);
SEG2 = S.set_Segment(SEG2);

H.Patch_Base = V.SEGview_Limit(H.View3D_axes,SEG1,'same');
hold(H.View3D_axes,'on')
H.Patch_Object = V.SEGview_Limit(H.View3D_axes,SEG2,'same');
H.Patch_Base.LineWidth = 2;
H.Patch_Object.LineWidth = 2;
colormap(cat(1,[0 0 0],[.8 0 .1]))
H.Patch_Object.CData  = H.Patch_Object.CData +2;
H.OriginalXYZ = cat(2,...
    H.Patch_Object.XData,H.Patch_Object.YData,H.Patch_Object.ZData);
H.Plot_Stretch = plot(H.Depth_Stretch_axes,...
    [min(H.OriginalXYZ(:,3)) max(H.OriginalXYZ(:,3))],...
    [min(H.Patch_Object.ZData), max(H.Patch_Object.ZData)],'k.','MarkerSize',1);
% H.Plot_Stretch = plot(H.Depth_Stretch_axes,...
%     H.Patch_Object.ZData,H.OriginalXYZ(:,3),...
%     'k.','MarkerSize',1);
hold(H.Depth_Stretch_axes,'on')
H.BaseReso = SEG1.ResolutionXYZ;
H.ObjectReso = SEG2.ResolutionXYZ;
ObjFOV = (SEG2.Size-1) .* H.ObjectReso;
% H.ObjectCenter = ObjFOV/2;
H.ObjectCenter = [ObjFOV(1:2)/2 ObjFOV(3)]; %% 2021 04 02 edit by Sugashi,
%% Depth Strech
H.Stretch_Group = setup_StrechROIpoint(H);
DrawStretchLine(H);
H = getappdata(H.Figure,'Data');
%% set up Image 
fgh = H.Figure;
H.imageh.CData = GetSliceImage;
if ispc
%     WinOnTop(fgh,true);
end

%% Callback
AddCallback

%% output Handles
if nargout== 1
    varargout{1} = H;
end
%% Set Data (with Handles )
setappdata(H.Figure,'Data',H)



    function H = create_base_GUI(NewReso1,NewReso2,FOV1,FOV2,im1,im2)
        H.FontSiz = 10;
        H.NewReso1 = NewReso1;
        H.NewReso2 = NewReso2;
        H.FOV1 = FOV1;
        H.FOV2 = FOV2;
        H.Image1_Name = im1;
        H.Image2_Name = im2;
        H.useImage1 = [];
        H.useImage2 = [];
        H.Figure = figure('Name','3D Rotation, Movement, Stretch',...
            'Position',[0 0 1200 900],... %% Original [~,~, 1200, 600]
            'MenuBar','none','Resize','on',...
            'Toolbar','figure');
        centerfig(H.Figure)
        H.Panel1 = uipanel(H.Figure,...
            'Units','Pixels',...
            'Position',[0 750 600 150],...
            'Title','Controller : Rotate & Movement');
        H.Panel2 = uipanel(H.Figure,...
            'Units','Pixels',...
            'Position',[0 450 600 300],...
            'Title','Controller : Depth Strech');
        H.Panel0 = uipanel(H.Figure,...
            'Units','Pixels',...
            'Position',[0 0 600 450],...
            'Title','slice Viewer : Object Interpolation');

        H.Panel3 = uipanel(H.Figure,...
            'Units','Pixels',...
            'Position',[600 0 600 900],...
            'Title','3D viewer');

        %% Panel 1 ( Controller Rotate, Movement
        %% Rotate
        H.RotateStepText = uicontrol(H.Panel1,...
            'Style','text',...
            'String','Rotate Step Size:',...
            'Units','Pixels','Position',[1 90 100 35],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','right');
        H.RotateStepEdit = uicontrol(H.Panel1,...
            'Style','Edit',...
            'String','1',...
            'Units','Pixels','Position',[101 103 40 25]);
        H.RotateStepUnitText = annotation(H.Panel1,...
            'textbox',...
            'String','[^o ]',...
            'Interpreter','tex',...
            'EdgeColor','none',...
            'Units','Pixels','Position',[141 108 40 25],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','left');

        H.RotateResetButton = uicontrol(H.Panel1,...
            'Style','pushbutton',...
            'String','Reset',...
            'Units','Pixels','Position',[200 103 90 30],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Rotate_X_text = uicontrol(H.Panel1,...
            'Style','text',...
            'String','X : 0',...
            'Units','Pixels','Position',[2.5  45 90 20],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Rotate_X_Minus = uicontrol(H.Panel1,...
            'Style','pushbutton',...
            'String','-X ',...
            'Units','Pixels','Position',[2.5  10 45 35],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Rotate_X_Plus = uicontrol(H.Panel1,...
            'Style','pushbutton',...
            'String','+X ',...
            'Units','Pixels','Position',[47.5  10 45 35],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Rotate_Y_text = uicontrol(H.Panel1,...
            'Style','text',...
            'String','Y : 0',...
            'Units','Pixels','Position',[102.5  45 90 20],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Rotate_Y_Minus = uicontrol(H.Panel1,...
            'Style','pushbutton',...
            'String','-Y ',...
            'Units','Pixels','Position',[102.5  10 45 35],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Rotate_Y_Plus = uicontrol(H.Panel1,...
            'Style','pushbutton',...
            'String','+Y ',...
            'Units','Pixels','Position',[147.5  10 45 35],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Rotate_Z_text = uicontrol(H.Panel1,...
            'Style','text',...
            'String','Z : 0',...
            'Units','Pixels','Position',[202.5  45 90 20],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Rotate_Z_Minus = uicontrol(H.Panel1,...
            'Style','pushbutton',...
            'String','-Z ',...
            'Units','Pixels','Position',[202.5  10 45 35],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Rotate_Z_Plus = uicontrol(H.Panel1,...
            'Style','pushbutton',...
            'String','+Z ',...
            'Units','Pixels','Position',[247.5  10 45 35],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        %% Separater
        H.Panel1_Separater=  annotation(H.Panel1,...
            'textbox','Units','Pixels','Position',[299.5 0 1 250],...
            'LineStyle',':');
        %% Movement
        H.MovementStepText = uicontrol(H.Panel1,...
            'Style','text',...
            'String','Movement Step Size:',...
            'Units','Pixels','Position',[301 90 100 35],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','right');
        H.MovementStepEdit = uicontrol(H.Panel1,...
            'Style','Edit',...
            'String','1',...
            'Units','Pixels','Position',[401 103 40 25]);
        H.MovementStepUnitText = annotation(H.Panel1,...
            'textbox',...
            'String','[\mum ]',...
            'Interpreter','tex',...
            'EdgeColor','none',...
            'Units','Pixels','Position',[441 108 60 25],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','left');

        H.MovementResetButton = uicontrol(H.Panel1,...
            'Style','pushbutton',...
            'String','Reset',...
            'Units','Pixels','Position',[505 103 78 30],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Movement_X_text = uicontrol(H.Panel1,...
            'Style','text',...
            'String','X : 0',...
            'Units','Pixels','Position',[302.5  45 90 20],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Movement_X_Minus = uicontrol(H.Panel1,...
            'Style','pushbutton',...
            'String','-X ',...
            'Units','Pixels','Position',[302.5  10 45 35],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Movement_X_Plus = uicontrol(H.Panel1,...
            'Style','pushbutton',...
            'String','+X ',...
            'Units','Pixels','Position',[347.5  10 45 35],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Movement_Y_text = uicontrol(H.Panel1,...
            'Style','text',...
            'String','Y : 0',...
            'Units','Pixels','Position',[402.5  45 90 20],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Movement_Y_Minus = uicontrol(H.Panel1,...
            'Style','pushbutton',...
            'String','-Y ',...
            'Units','Pixels','Position',[402.5  10 45 35],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Movement_Y_Plus = uicontrol(H.Panel1,...
            'Style','pushbutton',...
            'String','+Y ',...
            'Units','Pixels','Position',[447.5  10 45 35],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Movement_Z_text = uicontrol(H.Panel1,...
            'Style','text',...
            'String','Z : 0',...
            'Units','Pixels','Position',[502.5  45 90 20],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Movement_Z_Minus = uicontrol(H.Panel1,...
            'Style','pushbutton',...
            'String','-Z ',...
            'Units','Pixels','Position',[502.5  10 45 35],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');
        H.Movement_Z_Plus = uicontrol(H.Panel1,...
            'Style','pushbutton',...
            'String','+Z ',...
            'Units','Pixels','Position',[547.5  10 45 35],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');

        %% Panel2
        H.Depth_Stretch_axes = axes(H.Panel2,...
            'Units','Pixels',...
            'Position',[70 70 490 200],...
            'FontSize',H.FontSiz);
        
        ylabel(H.Depth_Stretch_axes,'Stretch Depth [\mum]')
        xlabel(H.Depth_Stretch_axes,'Base Depth [\mum]')
        H.Interp_Type_popup = uicontrol(H.Panel2,...
            'Style','popup',...
            'String',{'pchip';'linear';'spline';'cubic';'v5cubic'},...
            'Units','Pixels','Position',[1 3 78 30],...
            'FontSize',H.FontSiz);
        H.Interp_Resetup = uicontrol(H.Panel2,...
            'Style','pushbutton',...
            'String','Reset Interp',...
            'Units','Pixels','Position',[85 3 120 30],...
            'FontSize',H.FontSiz);

        H.NewStretchROI_Edit = uicontrol(H.Panel2,...
            'Style','Edit',...
            'String','100',...
            'Units','Pixels','Position',[230 3 78 30],...
            'FontSize',H.FontSiz);
        H.NewStretchROI_Add = uicontrol(H.Panel2,...
            'Style','pushbutton',...
            'String','Set New Point',...
            'Units','Pixels','Position',[320 3 125 30],...
            'FontSize',H.FontSiz);
        H.Depth_Stretch_Reset =  uicontrol(H.Panel2,...
            'Style','pushbutton',...
            'String','Reset',...
            'Units','Pixels','Position',[513 3 78 30],...
            'FontSize',H.FontSiz,...
            'HorizontalAlignment','center');


        %% Panel3
        H.View3D_axes = axes(H.Panel3,...
            'Units','Pixels',...
            'Position',[50 50 500 800],...
            'FontSize',H.FontSiz);
        xlabel(H.View3D_axes,'Axis X')
        ylabel(H.View3D_axes,'Axis Y')
        zlabel(H.View3D_axes,'Axis Z')
        view(H.View3D_axes,3)

        %% Panel 0 (Slice Image)
        SG = Sugashi_GUI_support;
        [uiph,uich] = SG.AddMIPPanel(H.Panel0);
        uich(1).String{end} =[];
        uiph.Position = [.5 .85 .5 .15];
        H.MIP_Panel = uiph;
        H.MIP_Children = uich;
        [slh,txh] = SG.AddSlider(H.Panel0);
        slh.Units = 'Pixels';
        slh.Position = [1 380 290 20];
        slh.BusyAction = 'cancel';
        txh.Units = 'Pixels';
        txh.Position =[5 405 290 20];
        H.View2_Slider = slh;
        H.View2_Slider_Text = txh;
        H.View2_Axes = axes(H.Panel0,...
            'Position',[.01 .01 .98 .82]);
        H.imageh = imagesc(H.View2_Axes,...
            rand(256));
        axis off image
        
        %% Set to Unit Normalized
        Fname = fieldnames(H);
        for n = 1:length(Fname)
            try
            eval(['H.' Fname{n} '.Units = ''Normalized'';'])
            catch err
            end
        end
        %% Menu
        H.FigMenu_Save = uimenu(H.Figure,'Label','Save');
        H.FigMenu_Save_Dir = uimenu(H.FigMenu_Save,'Label','Save to Directory.','Tag','Dir');
        H.FigMenu_Save_WS = uimenu(H.FigMenu_Save,'Label','Save to Warkspace.','Tag','WS');
        H.FigMenu_Save_Image = uimenu(H.FigMenu_Save,...
            'Label','Save Image.','Separator','on',...
            'Callback','disp(''hello save figure'')');

    end
    function Handles = setup_StrechROIpoint(H)
        G.Minimum = -400;
        G.Maximum = 1200;
        % min(H.Plot_Stretch.XData)
        xmax = max(H.Plot_Stretch.XData);
        ymax = max(H.Plot_Stretch.YData);
        G.SurfStatic = plot(H.Depth_Stretch_axes,xmax,ymax,'sr','MarkerSize',6);
        daspect(H.Depth_Stretch_axes,ones(1,3))
        xmin = min(H.Plot_Stretch.XData);
        ymin = min(H.Plot_Stretch.YData);
        G.BottomDynamic = drawpoint(H.Depth_Stretch_axes,...
            'Position',[xmin,ymin],'DrawingArea',[xmin,G.Minimum,0,G.Maximum]);
        delete(G.BottomDynamic.UIContextMenu.Children(1))
        
        G.Middles = [];
        G.InterpType = 'pchip';
        Handles = G;
    end
    
    function [X,Y,lx] = GetStretchLineXY(H)
        sx = H.Stretch_Group.BottomDynamic.Position(1);
        sy = H.Stretch_Group.BottomDynamic.Position(2);
        ex = H.Stretch_Group.SurfStatic.XData;
        ey = H.Stretch_Group.SurfStatic.YData;
        M = H.Stretch_Group.Middles;
        if ~isempty(M)
            TF = false(1,length(M));
            for n = 1:length(M)
                TF(n) = ~ishandle(M(n));
            end
            M(TF) = [];
            H.Stretch_Group.Middles = M;
            xy = zeros(length(M),2);
            for n = 1:length(M)
                xy(n,:) = get(M(n),'Position');
            end
        %     xy = cat(1,M.Position);
            reX = reshape(xy(:,1),1,[]);
            reY = reshape(xy(:,2),1,[]);
            [newX,ind] = sort(reX);
            newY = reY(ind);
        else
            newX = [];
            newY = [];
        end
        X = cat(2,sx,newX,ex);
        Y = cat(2,sy,newY,ey);
        lx = linspace(sx,ex,ceil(abs(sx - ex)+1) );
    end

    function Callback_InterpType(oh,~)
        fgh = gcf;
        H = getappdata(fgh,'Data');
        % oh.String{oh.Value};
        H.Stretch_Group.InterpType = oh.String{oh.Value};
        setappdata(fgh,'Data',H)
    end
    function Reset_InterpLine(~,~)        
        Rotate_Move_Obj(H)        
    end

    function Callback_NewStretchROI(~,~)    
        G = H.Stretch_Group;
        Depth = str2double(H.NewStretchROI_Edit.String);
        [X,~,~] = GetStretchLineXY(H);
        Xdata = G.InterpLine.XData;
        Ydata = G.InterpLine.YData;
        MinimumP = min(abs(X-Depth));
        if MinimumP > 0
            fprintf('Create Setting Point!!.\n')
        elseif MinimumP == 0
            error('Alredy Existing.')
        end
        [~,Ind] = min(abs(Xdata-Depth));
        Xposi = Xdata(Ind(1));
        Yposi = Ydata(Ind(1));
        c = length(G.Middles) + 1;
        G.Middles(c) = drawpoint(H.Depth_Stretch_axes,...
            'Position',[Xposi,Yposi],'DrawingArea',[Xposi,G.Minimum,0,G.Maximum]);
        H.Stretch_Group = G;
        setappdata(gcf,'Data',H);
    end

    function AddCallback
        %% Move(like imtranslate)
        set(H.RotateResetButton,'Callback',@Callback_RotateReset)
        set(H.Rotate_X_Plus,'Callback',@Callback_Rotate)
        set(H.Rotate_X_Minus,'Callback',@Callback_Rotate)
        set(H.Rotate_Y_Plus,'Callback',@Callback_Rotate)
        set(H.Rotate_Y_Minus,'Callback',@Callback_Rotate)
        set(H.Rotate_Z_Plus,'Callback',@Callback_Rotate)
        set(H.Rotate_Z_Minus,'Callback',@Callback_Rotate)

        set(H.MovementResetButton,'Callback',@Callback_MoveReset)
        set(H.Movement_X_Plus,'Callback',@Callback_Move)
        set(H.Movement_X_Minus,'Callback',@Callback_Move)
        set(H.Movement_Y_Plus,'Callback',@Callback_Move)
        set(H.Movement_Y_Minus,'Callback',@Callback_Move)
        set(H.Movement_Z_Plus,'Callback',@Callback_Move)
        set(H.Movement_Z_Minus,'Callback',@Callback_Move)

        set(H.Interp_Type_popup,'Callback',@Callback_InterpType)
        set(H.Interp_Resetup,'Callback',@Reset_InterpLine)
        set(H.NewStretchROI_Add,'Callback',@Callback_NewStretchROI)

        set(H.FigMenu_Save_Dir,'Callback',@Callback_Save)
        set(H.FigMenu_Save_WS,'Callback',@Callback_Save)
        set(H.View2_Slider,'Callback',@Callback_ResetView)
        set(H.MIP_Children(4),'Callback',@Callback_ApplySliceView)
    end
    function Callback_RotateReset(~,~)
    fgh = gcf;
    H = getappdata(fgh,'Data');
    H.Rotate_X_text.String = 'X:0';
    H.Rotate_Y_text.String = 'Y:0';
    H.Rotate_Z_text.String = 'Z:0';
    Rotate_Move_Obj(H)
    end
    function Callback_MoveReset(~,~)
    fgh = gcf;
    H = getappdata(fgh,'Data');
    H.Movement_X_text.String = 'X:0';
    H.Movement_Y_text.String = 'Y:0';
    H.Movement_Z_text.String = 'Z:0';
    Rotate_Move_Obj(H)
    end

    function Callback_Rotate(oh,~)
    fgh = gcf;
    H = getappdata(fgh,'Data');
    STR = oh.String;
    RotateStep = str2double(H.RotateStepEdit.String);

    Sig = GetSign(STR);
    switch STR(2)
        case 'X'
            A = GetNum(H.Rotate_X_text.String);
            Num = A + (Sig*RotateStep);
            H.Rotate_X_text.String = ['X: ' num2str(Num)];
        case 'Y'
            A = GetNum(H.Rotate_Y_text.String);
            Num = A + (Sig*RotateStep);
            H.Rotate_Y_text.String = ['Y: ' num2str(Num)];
        case 'Z'
            A = GetNum(H.Rotate_Z_text.String);
            Num = A + (Sig*RotateStep);
            H.Rotate_Z_text.String = ['Z: ' num2str(Num)];
    end
    Rotate_Move_Obj(H)
    end
    function Callback_Move(oh,~)
    fgh = gcf;
    H = getappdata(fgh,'Data');
    STR = oh.String;
    MoveStep = str2double(H.MovementStepEdit.String);
    Sig = GetSign(STR);

    switch STR(2)
        case 'X'
            A = GetNum(H.Movement_X_text.String);
            Num = A + (Sig*MoveStep);
            H.Movement_X_text.String = ['X: ' num2str(Num)];
        case 'Y'
            A = GetNum(H.Movement_Y_text.String);
            Num = A + (Sig*MoveStep);
            H.Movement_Y_text.String = ['Y: ' num2str(Num)];
        case 'Z'
            A = GetNum(H.Movement_Z_text.String);
            Num = A + (Sig*MoveStep);
            H.Movement_Z_text.String = ['Z: ' num2str(Num)];
    end
    Rotate_Move_Obj(H)
    end
    function Sig = GetSign(STR)
    if strcmpi(STR(1),'+')
        Sig = 1;
    else
        Sig = -1;
    end
    end

    %% Slice Viewer
    function RotMovStretchImage
        fprintf('Setting up Rotate,Move,Stretch Image,,, waite.\n')
        RMSD = GetRotMovStretchData;
        Im2 = evalin('base',H.Image2_Name);
        NewSiz2 = round( (H.FOV2 ./ H.NewReso2 ) + 1);
        imobj = imresize3(Im2,NewSiz2);
%         imobj = H.useImage2;
        Reso= H.NewReso2;
        J = S.Image2RotMovStretch(imobj,Reso,RMSD);
        H.useImage2 = J;
        fprintf('Done...\n\n')
    end
    function Callback_ResetView(~,~)
        ResetSliceView
    end
    function Callback_ApplySliceView(~,~)
        RotMovStretchImage
        ResetSliceView
    end

    function ResetSize %% update NewReso1 NewReso2
        Im1 = evalin('base',H.Image1_Name);
        Im2 = evalin('base',H.Image2_Name);
        NewSiz1 = round( (H.FOV1 ./ H.NewReso1 ) + 1);
        NewSiz2 = round( (H.FOV2 ./ H.NewReso2 ) + 1);
        useImage1 = imresize3(Im1,NewSiz1);
        useImage2 = imresize3(Im2,NewSiz2);
        H.useImage1 = useImage1;
        H.useImage2 = useImage2;
        H.NewReso1 = H.FOV1./(NewSiz1-1);
        H.NewReso2 = H.FOV2./(NewSiz2-1);
        setappdata(H.Figure,'Data',H)

        %% reset Slider
        slh = H.View2_Slider;
        z = NewSiz1(3);
        slh.SliderStep = [1/(z-1) 10/(z-1)];
        slh.Value = 0;
        slh.UserData = z-1;
        ResetSliceView
    end
    function ResetSliceView        
        [A,SliceReal,z] = GetSlice;            
        STR1 = [num2str(A,'%.1f') '/' num2str(z,'%d')];
        STR2 = [num2str(SliceReal,'%.1f') '/' num2str(H.FOV1(3),'%.1f')];
        H.View2_Slider_Text.String = ...
            [STR1 ' [pix.], ' STR2 ' [um]'];
        H.imageh.CData = GetSliceImage;
    end
    function [A,Areal,z] = GetSlice
        slh = H.View2_Slider;
        A = round(slh.Value * slh.UserData + 1);
        Areal = slh.Value * H.FOV1(3);
        z = slh.UserData + 1;
    end
    function Image = GetSliceImage
        A = GetSlice;
        im1 = single(H.useImage1);
        im2 = single(H.useImage2);
        
        MIPType = H.MIP_Children(1);
        MIPType = MIPType.String{MIPType.Value};
        MIPNUM = eval(H.MIP_Children(3).String);
        Aend = min(size(im1,3),A+MIPNUM-1);
        DIM = 3;
        
        [X,Y,Z] = meshgrid(1:size(im1,2),1:size(im1,1),A:Aend);
        im1 = interp3(im1,X,Y,Z);
        im2 = interp3(im2,X,Y,Z);
        
        switch MIPType
            case 'max'
                im1 = max(im1,[],DIM);
                im2 = max(im2,[],DIM);
            case 'min'
                im1 = min(im1,[],DIM);
                im2 = min(im2,[],DIM);
            case 'Average'
                im1 = nanmean(im1,DIM);
                im2 = nanmean(im2,DIM);
            case 'Median'
                im1 = nanmedian(im1,DIM);
                im2 = nanmedian(im2,DIM);
            case 'SD'
                im1 = nanstd(im1,DIM);
                im2 = nanstd(im2,DIM);
            otherwise
                error('call developper, Sugashi.')
        end
        
        if sum(isnan(im1(:))) == numel(im1)
            im1(:) = 0;
            N1 = 0; S1 = 1;
        else
%             [N1,S1] = TS_GetBackgroundValue(im1(:));
            [N1,S1] = TS_GetBackgroundValue_GaussianFit(im1(:));
            N1(isnan(N1)) = 0;
            S1(or(isnan(S1),N1==S1)) = max(max(im1(:)),1);
        end
        if sum(isnan(im2(:))) == numel(im2)
            im2(:) = 0;
            N2 = 0; S2 = 1;
        else
%             [N2,S2] = TS_GetBackgroundValue(im2(:));
            [N2,S2] = TS_GetBackgroundValue_GaussianFit(im2(:));
            N2(isnan(N2)) = 0; 
            S2(or(isnan(S2),N2==S2)) = max(max(im2(:)),1);
        end
        
        cdata.CLim = cat(1,[N1 S1],[N2, S2]);
        cdata.Color = cat(1,[1 0 .2],[0 1 0]);
        cdata.Gamma = [.8 .8];
        Image = rgbproj(cat(3,im1,im2),cdata);        
    end

    %% Rotation Movement and Stretch Main Function.%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function Rotate_Move_Obj(H)
%         H.Patch_Object.XData = H.OriginalXYZ(:,1);
%         H.Patch_Object.YData = H.OriginalXYZ(:,2);
%         H.Patch_Object.ZData = H.OriginalXYZ(:,3);
%         [R,M] = GetRotMov(H);
%         rotate(H.Patch_Object,[1 0 0],R(1),H.ObjectCenter)
%         rotate(H.Patch_Object,[0 1 0],R(2),H.ObjectCenter)
%         rotate(H.Patch_Object,[0 0 1],R(3),H.ObjectCenter)
% 
%         H.Patch_Object.XData = H.Patch_Object.XData + M(1);
%         H.Patch_Object.YData = H.Patch_Object.YData + M(2);
%         H.Patch_Object.ZData = H.Patch_Object.ZData + M(3);
        

        XYZ = H.OriginalXYZ;        
        RMSD = GetRotMovStretchData;
        S = Segment_Functions;
        XYZ = S.xyz2RotMoveStretch(XYZ,RMSD,RMSD.ObjectCenter);
        
        H.Patch_Object.XData = XYZ(:,1);
        H.Patch_Object.YData = XYZ(:,2);
        H.Patch_Object.ZData = XYZ(:,3);
        %% Stretch        
%         H.Plot_Stretch.YData = [min(XYZ(:,3)), max(XYZ(:,3))];
            
%         H.Stretch_Group.SurfStatic.YData = max(H.Patch_Object.ZData);        
        DrawStretchLine(H)
    end    
    function DrawStretchLine(H)
        [X,Y,lx] = GetStretchLineXY(H);

        ly = interp1(X,Y,lx,H.Stretch_Group.InterpType);

        if isfield(H.Stretch_Group,'InterpLine')
            H.Stretch_Group.InterpLine.XData = lx;
            H.Stretch_Group.InterpLine.YData = ly;
        else
            H.Stretch_Group.InterpLine = plot(H.Depth_Stretch_axes,...
                lx,ly);
        end
        setappdata(H.Figure,'Data',H)
    end
    function [R,M] = GetRotMov(H)
        R = zeros(1,3);
        M = R;
        R(1) = GetNum(H.Rotate_X_text.String);
        R(2) = GetNum(H.Rotate_Y_text.String);
        R(3) = GetNum(H.Rotate_Z_text.String);
        % R = R * 180/pi;
        M(1) = GetNum(H.Movement_X_text.String);
        M(2) = GetNum(H.Movement_Y_text.String);
        M(3) = GetNum(H.Movement_Z_text.String);
    end
    function A= GetNum(STR)
        p = find(STR == ':');
        A = str2double(STR(p+1:end));
    end

    function Callback_Save(oh,~)
        Data = GetRotMovStretchData;
        if strcmpi(oh.Tag,'Dir')
            uisave('RotMovStretchData','Rotate_Move_Data')
        elseif strcmpi(oh.Tag,'WS')
            export2wsdlg({'Export to WS'},{'RotMovStretchData'},{Data},'Save data');
        end
    end
    function Data = GetRotMovStretchData
        [R,M] = GetRotMov(H);
        % RotMov = cat(1,R,M);
        [X,Y,lx] = GetStretchLineXY(H);
        ly = H.Stretch_Group.InterpLine.YData;
        Data.Rotate = R;
        Data.Move = M;
        Data.Stretch_lx = lx;
        Data.Stretch_ly = ly;
        Data.StretchX = X;
        Data.StretchY = Y;
        Data.InterpType = H.Stretch_Group.InterpType;
        Data.InputResolution = H.ObjectReso;
        Data.InputSize = size(evalin('base',H.Image2_Name));
        Data.ObjectCenter = H.FOV2/2;
        Data.Units = 'um';
        Data.MEMO = 'NewZ = interp1(lx,ly,zdata,H.Stretch_Group.InterpType);';
        Data.UpDate = TS_ClockDisp;
    end

end
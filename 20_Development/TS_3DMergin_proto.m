function varargout = TS_3DMergin_proto
% varargout = TS_3DMergin_proto

% mriVolumeTranslated = imtranslate(mriVolume,[40,30,0],'OutputView','full');
global H S V
%% check Input
% [Image1,Image2,Image3,Image4,Reso]= Get_ImageName;
Image1 ='im1';Image2='im2';Image3 ='im3';Image4 ='im4';Reso=evalin('base','Reso');
if isempty(Reso) || isempty(Image1)
    return
end
%% Initialize
NewReso = [1 1 5];
NewReso1 = NewReso;
NewReso2 = NewReso;
NewReso3 = NewReso;
NewReso4 = NewReso;

FOV1 = size(evalin('base',Image1)).*Reso;
FOV2 = FOV1;
FOV3 = FOV1;
FOV4 = FOV1;
H.LocationPosition = [1 2 ; 4 3];
H.NewResoBase = NewReso;
H.NewReso(1).val = NewReso1;
H.NewReso(2).val= NewReso2;
H.NewReso(3).val= NewReso3;
H.NewReso(4).val= NewReso4;
H.FOV(1).val= FOV1;
H.FOV(2).val= FOV2;
H.FOV(3).val= FOV3;
H.FOV(4).val= FOV4;
H.Image_Name(1).val = Image1;
H.Image_Name(2).val = Image2;
H.Image_Name(3).val = Image3;
H.Image_Name(4).val = Image4;
H.useImage(1).val = [];
H.useImage(2).val = [];
H.useImage(3).val = [];
H.useImage(4).val = [];
%% create Base 
H = create_base_GUI(H);

%% Resize
ResetSize

%% Panel3 Depict, drawing
V = Sugashi_ReconstructGroup;
S = Segment_Functions;
H.ObjectCenter = FOV2/2;

%% Depth Strech
H.Stretch_Group = setup_StrechROIpoint(H);

for Loc = 2:4
    DrawStretchLine(Loc);
end
%% set up Image 
fgh = H.Figure;
H.imageh.CData = GetSliceImage;
if ispc
    WinOnTop(fgh,true);
end

%% Callback
AddCallback

%% output Handles
if nargout== 1
    varargout{1} = H;
end
    function [a,b,c,d,Reso]= Get_ImageName
        w = evalin('base','whos');
        TFvol = false(length(w),1);
        TFreso = TFvol;
        for n = 1:length(w)
            if length(w(n).size)>=3
                if w(n).size(3) > 1
                    TFvol(n) = true;
                end
            end
            if length(w(n).size)==2
                if min(w(n).size)==1 && max(w(n).size)==3
                    TFreso(n) = true;
                end
            end  
        end
        volitems = cell(sum(TFvol),1);
        p = find(TFvol);
        for n = 1:length(p)
            volitems{n} = w(p(n)).name;
        end
        resoitems = cell(sum(TFreso),1);
        p = find(TFreso);
        for n = 1:length(p)
            resoitems{n} = w(p(n)).name;
        end
        
        
        h = uifigure('Position',[0 0 320 205],'CloseRequestFcn',@Callback_GetImage,...
            'Name','Mergin 3D : input');
        centerfig(h);
        ch(1) = uidropdown(h,'position',[  2 103 100 100],'items',volitems);
        ch(2) = uidropdown(h,'position',[103 103 100 100],'items',volitems);
        ch(3) = uidropdown(h,'position',[  2   2 100 100],'items',volitems);
        ch(4) = uidropdown(h,'position',[103   2 100 100],'items',volitems);
        ch(5) = uidropdown(h,'position',[231 145  80  20],'items',resoitems);
        ch(6) = uibutton(h,'position',[265  45  50  30],'Text','Apply','ButtonPushedFcn',@Callback_GetImage);
        ch(7) = uibutton(h,'position',[211  45  50  30],'Text','Cancell','ButtonPushedFcn',@Callback_GetImage);
        function Callback_GetImage(oh,event)
            if strcmpi(event.EventName,'close')
                a = [];b=[];c=[];d=[];Reso=[];
                delete(oh);
                return
            end
            if strcmpi(event.EventName,'buttonpushed')
                if strcmpi(oh.Text,'Cancell')
                    a = [];b=[];c=[];d=[];Reso=[];
                    delete(oh.Parent);
                    return
                end
            end 
            a = ch(1).Value;
            b = ch(2).Value;
            c = ch(3).Value;
            d = ch(4).Value;
            Reso = evalin('base',ch(5).Value);
            delete(oh.Parent);
        end
        waitfor(h)
    end
    function H = create_base_GUI(H)
        H.FontSiz = 12;
        
        Position = [0 0 1000 650];
        ControllerWidth = 400;
        TabP = [0 0 ControllerWidth 650];
        P0 = [ControllerWidth 0 600 650];
        P1 = [0 450 ControllerWidth 175];
        P2 = [0   0 ControllerWidth 450];
        mippanelP = [0 550 600 100];
        slP = [10 40 200 3];
        sltxP = [...
            83 50 150 25;
            15 50 25 25;
            45 50 25 25 ];
        uichP = [
            100 10 60 25;
            165 10 40 25;
            210 10 33 25;
            250 10 60 40;
            100 35 60 25;
            165 35 40 25;
            210 35 35 25];
        uichP(:,1) = uichP(:,1) + 250;
%         P3 = [];
%         if ismac
%             Position = Position /2;
%         end
        H.Figure = uifigure('Name','3D Mergin',...
            'Position',Position); 
        centerfig(H.Figure)
        H.TabH = uitabgroup(H.Figure,...
            'Position',TabP);
        H.TabLoc(1) = uitab(H.TabH,...
            'Title','Location 1&2');
        
        H.TabLoc(2) = uitab(H.TabH,...
            'Title','Location 1&3');
        
        H.TabLoc(3) = uitab(H.TabH,...
            'Title','Location 1&4');
        
        for nt = 1:3
            H.Panel1(nt) = uipanel(H.TabLoc(nt),...
                'Units','Pixels',...
                'Position',P1,...
                'Title','Controller : Rotate & Movement');
            H.Panel2(nt) = uipanel(H.TabLoc(nt),...
                'Units','Pixels',...
                'Position',P2,...
                'Title','Controller : Depth Strech');
        end
        
        H.Panel0 = uipanel(H.Figure,...
            'Units','Pixels',...
            'Position',P0,...
            'Title','slice Viewer : Object Interpolation');
        
        %% Panel 1 ( Controller Rotate, Movement
        %% Rotate Movement button position
        RotLabelP = [4 85 150 35];
        RotStepNumericP = [10 65 25 25];
        RotUnitP = [41, 68 40 25];
        ResetButtonP = [90 63 70 30];
        BaseButtonP = [
            20, 38, 90, 20;
            0, 10, 30, 30;
            30, 10, 30, 30];
        XButtonP = BaseButtonP;
        XButtonP(:,1) = XButtonP(:,1) + 5; 
        YButtonP = BaseButtonP;
        YButtonP(:,1) = YButtonP(:,1) + 67.5;         
        ZButtonP = BaseButtonP;
        ZButtonP(:,1) = ZButtonP(:,1) + 130;
        
        MovLabelP = RotLabelP;
        MovLabelP(1) = MovLabelP(1) + ControllerWidth/2;
        MovStepNumericP = RotStepNumericP;
        MovStepNumericP(1) = MovStepNumericP(1) + ControllerWidth/2;
        MovUnitP = RotUnitP;
        MovUnitP(1) = MovUnitP(1) + ControllerWidth/2;
        MovResetButtonP = ResetButtonP;
        MovResetButtonP(1) = MovResetButtonP(1) + ControllerWidth/2;
        XmButtonP = BaseButtonP;
        XmButtonP(:,1) = XmButtonP(:,1) + 5+ ControllerWidth/2; 
        YmButtonP = BaseButtonP;
        YmButtonP(:,1) = YmButtonP(:,1) + 67.5+ ControllerWidth/2;         
        ZmButtonP = BaseButtonP;
        ZmButtonP(:,1) = ZmButtonP(:,1) + 130+ ControllerWidth/2;
        
        for nt = 1:3
            %% Rotation 
            H.RotateStepText(nt) = uilabel(...
                'Parent',H.Panel1(nt),...
                'Text','Rotate Step Size:',...
                'Position',RotLabelP,...
                'FontSize',H.FontSiz);
            H.RotateStepEdit(nt) = uieditfield(H.Panel1(nt),'numeric',...
                'Value',1,...
                'Position',RotStepNumericP);

            H.RotateStepUnitText(nt) = uilabel(H.Panel1(nt),...
                'Text','[deg.]',...
                'Position',RotUnitP,...
                'FontSize',H.FontSiz);

            H.RotateResetButton(nt) = uibutton(H.Panel1(nt),...
                'Text','Reset',...
                'Position',ResetButtonP,...
                'FontSize',H.FontSiz);


            H.Rotate_X_text(nt) = uilabel(H.Panel1(nt),...
                'Text','X : 0',...
                'Position',XButtonP(1,:),...
                'FontSize',H.FontSiz);
            H.Rotate_X_Minus(nt) = uibutton(H.Panel1(nt),...
                'Text','-X ',...
                'Position',XButtonP(2,:),...
                'FontSize',H.FontSiz);
            H.Rotate_X_Plus(nt) = uibutton(H.Panel1(nt),...
                'Text','+X ',...
                'Position',XButtonP(3,:),...
                'FontSize',H.FontSiz);

            H.Rotate_Y_text(nt) = uilabel(H.Panel1(nt),...
                'Text','Y : 0',...
                'Position',YButtonP(1,:),...
                'FontSize',H.FontSiz);
            H.Rotate_Y_Minus(nt) = uibutton(H.Panel1(nt),...
                'Text','-Y ',...
                'Position',YButtonP(2,:),...
                'FontSize',H.FontSiz);
            H.Rotate_Y_Plus(nt) = uibutton(H.Panel1(nt),...
                'Text','+Y ',...
                'Position',YButtonP(3,:),...
                'FontSize',H.FontSiz);

            H.Rotate_Z_text(nt) = uilabel(H.Panel1(nt),...
                'Text','Z : 0',...
                'Position',ZButtonP(1,:),...
                'FontSize',H.FontSiz);
            H.Rotate_Z_Minus(nt) = uibutton(H.Panel1(nt),...
                'Text','-Z ',...
                'Position',ZButtonP(2,:),...
                'FontSize',H.FontSiz);
            H.Rotate_Z_Plus(nt) = uibutton(H.Panel1(nt),...
                'Text','+Z ',...
                'Position',ZButtonP(3,:),...
                'FontSize',H.FontSiz);


            %% Movement
            H.MovementStepText(nt) = uilabel(...
                'Parent',H.Panel1(nt),...
                'Text','Movement Step Size:',...
                'Position',MovLabelP,...
                'FontSize',H.FontSiz);
            H.MovementStepEdit(nt) = uieditfield(H.Panel1(nt),'numeric',...
                'Value',1,...
                'Position',MovStepNumericP);

            H.MovementStepUnitText(nt) = uilabel(H.Panel1(nt),...
                'Text','[um]',...
                'Position',MovUnitP,...
                'FontSize',H.FontSiz);

            H.MovementResetButton(nt) = uibutton(H.Panel1(nt),...
                'Text','Reset',...
                'Position',MovResetButtonP,...
                'FontSize',H.FontSiz);


            H.Movement_X_text(nt) = uilabel(H.Panel1(nt),...
                'Text','X : 0',...
                'Position',XmButtonP(1,:),...
                'FontSize',H.FontSiz);
            H.Movement_X_Minus(nt) = uibutton(H.Panel1(nt),...
                'Text','-X ',...
                'Position',XmButtonP(2,:),...
                'FontSize',H.FontSiz);
            H.Movement_X_Plus(nt) = uibutton(H.Panel1(nt),...
                'Text','+X ',...
                'Position',XmButtonP(3,:),...
                'FontSize',H.FontSiz);

            H.Movement_Y_text(nt) = uilabel(H.Panel1(nt),...
                'Text','Y : 0',...
                'Position',YmButtonP(1,:),...
                'FontSize',H.FontSiz);
            H.Movement_Y_Minus(nt) = uibutton(H.Panel1(nt),...
                'Text','-Y ',...
                'Position',YmButtonP(2,:),...
                'FontSize',H.FontSiz);
            H.Movement_Y_Plus(nt) = uibutton(H.Panel1(nt),...
                'Text','+Y ',...
                'Position',YmButtonP(3,:),...
                'FontSize',H.FontSiz);

            H.Movement_Z_text(nt) = uilabel(H.Panel1(nt),...
                'Text','Z : 0',...
                'Position',ZmButtonP(1,:),...
                'FontSize',H.FontSiz);
            H.Movement_Z_Minus(nt) = uibutton(H.Panel1(nt),...
                'Text','-Z ',...
                'Position',ZmButtonP(2,:),...
                'FontSize',H.FontSiz);
            H.Movement_Z_Plus(nt) = uibutton(H.Panel1(nt),...
                'Text','+Z ',...
                'Position',ZmButtonP(3,:),...
                'FontSize',H.FontSiz);
            %% Panel2 Depth set
            H.Depth_Stretch_axes(nt) = uiaxes(H.Panel2(nt),...
                'Units','Pixels',...
                'Position',[50 80 320 320],...
                'FontSize',H.FontSiz);
            ylabel(H.Depth_Stretch_axes(nt),'Stretch Depth [\mum]')
            xlabel(H.Depth_Stretch_axes(nt),'Base Depth [\mum]')
            H.Interp_Type_popup(nt) = uidropdown(H.Panel2(nt),...
                'Items',{'pchip';'linear';'spline';'cubic';'v5cubic'},...
                'Position',[10 5 68 25],...
                'FontSize',H.FontSiz);
            H.Interp_Resetup(nt) = uibutton(H.Panel2(nt),...
                'Text','Reset Interp',...
                'Position',[80 5 90 25],...
                'FontSize',H.FontSiz);

            H.NewStretchROI_Edit(nt) = uieditfield(H.Panel2(nt),...
                'numeric',...
                'Value',100,...
                'Position',[195 5 40 23],...
                'FontSize',H.FontSiz);
            H.NewStretchROI_Add(nt) = uibutton(H.Panel2(nt),...
                'Text','Set New Point',...
                'Position',[250 5 125 25],...
                'FontSize',H.FontSiz);
        end
        
        %% Panel 0 (Slice Image)
        uiph = uipanel(H.Panel0,...
            'Position',mippanelP,...
            'Title','Projection Menu''s',...
            'FontSize',H.FontSiz);
        
        uich(1) = uidropdown(uiph,...
            'Items',{'max','average','min','Median','SD'},...
            'Position',uichP(1,:),...
            'FontSize',H.FontSiz);
        uich(2) = uidropdown(uiph,...
            'Items',{'1','2','3'},...
            'Position',uichP(2,:),...
            'FontSize',H.FontSiz);
        uich(2).Value = '3';
        uich(3) = uieditfield(uiph,'numeric',...
            'Value',1,...
            'Position',uichP(3,:),...
            'FontSize',H.FontSiz);
        uich(4) = uibutton(uiph,...
            'Text','Apply',...
            'Position',uichP(4,:),...
            'FontSize',H.FontSiz+2);
        uich(5) = uilabel(uiph,...
            'Text','Type',...
            'Position',uichP(5,:),...
            'FontSize',H.FontSiz);
        uich(6) = uilabel(uiph,...
            'Text','Dim.',...
            'Position',uichP(6,:),...
            'FontSize',H.FontSiz);
        uich(7) = uilabel(uiph,...
            'Text','Num.',...
            'Position',uichP(7,:),...
            'FontSize',H.FontSiz);
        H.MIP_Panel = uiph;
        H.MIP_Children = uich;
        
        slh = uislider(uiph,...
            'Position',slP);
        uibutton(uiph,...
            'Text','<',...
            'Position',sltxP(2,:),...
            'FontSize',H.FontSiz,...
            'ButtonPushedFcn',@CallbackSlider_ui);
        uibutton(uiph,...
            'Text','>',...
            'Position',sltxP(3,:),...
            'FontSize',H.FontSiz,...
            'ButtonPushedFcn',@CallbackSlider_ui);
        
        
        txh = uilabel(uiph,...
            'Text','1/800',...
            'Position',sltxP(1,:));
        
        slh.BusyAction = 'cancel';
        H.View2_Slider = slh;
        H.View2_Slider_Text = txh;
        
        H.Axes2D = uiaxes(H.Panel0,...
            'Position',[0 0 600 550]);
        H.imageh = imagescReso(H.Axes2D,...
            rand(256,256,3),ones(1,2));
        axis(H.Axes2D,'off')
        axis(H.Axes2D,'image')
        
        
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
    function CallbackSlider_ui(oh,~)
        val = H.View2_Slider.Value;
        Lim = H.View2_Slider.Limits;
        switch oh.Text
            case '>'
                pm = 1;
            case '<'
                pm = -1;
        end
        val = val + pm;
        val = max(val,Lim(1));
        val = min(val,Lim(2));
        H.View2_Slider.Value = val;   
        ResetSliceView
    end
    function Handles = setup_StrechROIpoint(H)
        G.Minimum = -10000;
        G.Maximum = 10000;
        for an = 1:3
            Znow = eval(['H.FOV' num2str(an) '(3);']);
            H.Plot_Stretch(an) = plot(H.Depth_Stretch_axes(an),...
                [0, H.FOV(1).val(3)],...
                [0-(H.FOV(1).val(3)-Znow), Znow],'k-','MarkerSize',1);
            hold(H.Depth_Stretch_axes(an),'on')
            axis(H.Depth_Stretch_axes(an),'equal')
            grid(H.Depth_Stretch_axes(an),'on')
        % min(H.Plot_Stretch.XData)
            xmax = max(H.Plot_Stretch(an).XData);
            ymax = max(H.Plot_Stretch(an).YData);
            G.SurfStatic(an) = plot(H.Depth_Stretch_axes(an),xmax,ymax,'sr','MarkerSize',6);
            xmin = min(H.Plot_Stretch(an).XData);
            ymin = min(H.Plot_Stretch(an).YData);
            G.BottomDynamic(an) = drawpoint(H.Depth_Stretch_axes(an),...
                'Position',[xmin,ymin],'DrawingArea',[xmin,ymin+G.Minimum,0,-G.Minimum+G.Maximum]);
            delete(G.BottomDynamic(an).UIContextMenu.Children(1))
        end

        G.Middles = [];
        G.Middles2 = [];
        G.Middles3 = [];
        G.Middles4 = [];
        G.InterpType = 'phcp';
        Handles = G;
    end
    function [X,Y,lx] = GetStretchLineXY(nn)
        nn = nn -1;
        sx = H.Stretch_Group.BottomDynamic(nn).Position(1);
        sy = H.Stretch_Group.BottomDynamic(nn).Position(2);
        ex = H.Stretch_Group.SurfStatic(nn).XData;
        ey = H.Stretch_Group.SurfStatic(nn).YData;
        M = eval(['H.Stretch_Group.Middles' num2str(nn+1) ';']);
        if ~isempty(M)
            TF = false(1,length(M));
            for n = 1:length(M)
                TF(n) = ~ishandle(M(n));
            end
            M(TF) = [];
            eval(['H.Stretch_Group.Middles' num2str(nn+1) ' = M;']);
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
        Rotate_Move_Obj   
    end

    function Callback_NewStretchROI(~,~)    
        G = H.Stretch_Group;
        Depth = str2double(H.NewStretchROI_Edit.String);
        [X,~,~] = GetStretchLineXY(LocNum);
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
        for ln = 1:3
            set(H.RotateResetButton(ln),'ButtonPushedFcn',@Callback_RotateReset)
            set(H.Rotate_X_Plus(ln),'ButtonPushedFcn',@Callback_Rotate)
            set(H.Rotate_X_Minus(ln),'ButtonPushedFcn',@Callback_Rotate)
            set(H.Rotate_Y_Plus(ln),'ButtonPushedFcn',@Callback_Rotate)
            set(H.Rotate_Y_Minus(ln),'ButtonPushedFcn',@Callback_Rotate)
            set(H.Rotate_Z_Plus(ln),'ButtonPushedFcn',@Callback_Rotate)
            set(H.Rotate_Z_Minus(ln),'ButtonPushedFcn',@Callback_Rotate)

            set(H.MovementResetButton(ln),'ButtonPushedFcn',@Callback_MoveReset)
            set(H.Movement_X_Plus(ln),'ButtonPushedFcn',@Callback_Move)
            set(H.Movement_X_Minus(ln),'ButtonPushedFcn',@Callback_Move)
            set(H.Movement_Y_Plus(ln),'ButtonPushedFcn',@Callback_Move)
            set(H.Movement_Y_Minus(ln),'ButtonPushedFcn',@Callback_Move)
            set(H.Movement_Z_Plus(ln),'ButtonPushedFcn',@Callback_Move)
            set(H.Movement_Z_Minus(ln),'ButtonPushedFcn',@Callback_Move)

            set(H.Interp_Type_popup(ln),'ValueChangedFcn',@Callback_InterpType)
            set(H.Interp_Resetup(ln),'ButtonPushedFcn',@Reset_InterpLine)
            set(H.NewStretchROI_Add(ln),'ButtonPushedFcn',@Callback_NewStretchROI)
        end
        
        set(H.FigMenu_Save_Dir,'Callback',@Callback_Save)
        set(H.FigMenu_Save_WS,'Callback',@Callback_Save)
        set(H.View2_Slider,'ValueChangedFcn',@Callback_ResetView)
        set(H.MIP_Children(4),'ButtonPushedFcn',@Callback_ApplySliceView)
    end
    function Callback_RotateReset(~,~)
    fgh = gcf;
    H = getappdata(fgh,'Data');
    H.Rotate_X_text.String = 'X:0';
    H.Rotate_Y_text.String = 'Y:0';
    H.Rotate_Z_text.String = 'Z:0';
    Rotate_Move_Obj
    end
    function Callback_MoveReset(~,~)
    fgh = gcf;
    H = getappdata(fgh,'Data');
    H.Movement_X_text.String = 'X:0';
    H.Movement_Y_text.String = 'Y:0';
    H.Movement_Z_text.String = 'Z:0';
    Rotate_Move_Obj
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
    Rotate_Move_Obj
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
    Rotate_Move_Obj
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
        imobj = H.useImage2;
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
        for n = 1:4
            Im(n).val = evalin('base',H.Image_Name(n).val);
        end
        
        for n = 1:4
            NewSiz(n,:) = round( (H.FOV(n).val ./ H.NewResoBase ) + 1);
        end
        
        for n = 1:4
            useImage(n).val = imresize3(Im(n).val,NewSiz(n,:));
        end
        Siz = NewSiz(1,:);
        useImage(1).val = padarray(useImage(1).val,Siz(1:2),0,'post');
        useImage(2).val = padarray(useImage(2).val,[0 Siz(2)],0,'pre');
        useImage(2).val = padarray(useImage(2).val,[Siz(1), 0],0,'post');
        useImage(3).val = padarray(useImage(3).val,[0 Siz(2)],0,'pre');
        useImage(3).val = padarray(useImage(3).val,[Siz(1), 0],0,'pre');
        useImage(4).val = padarray(useImage(4).val,[Siz(1),0],0,'pre');
        useImage(4).val = padarray(useImage(4).val,[0,Siz(2)],0,'post');
        for n = 1:4
            H.useImage(n).val = useImage(n).val;
            H.NewReso(n).val = H.FOV(n).val./(NewSiz(n,:)-1);
        end

        %% reset Slider
        slh = H.View2_Slider;
        z =max(NewSiz(:,3));
        
        slh.Limits = [1 z]; 
        slh.Value = z;
        ResetSliceView
    end
    function ResetSliceView        
        [A,SliceReal,z] = GetSlice;            
        STR1 = [num2str(A,'%.1f') '/' num2str(z,'%d')];
        STR2 = [num2str(SliceReal,'%.1f') '/' num2str(H.FOV1(3),'%.1f')];
        H.View2_Slider_Text.Text = ...
            [STR1 ' [p.], ' STR2 ' [um]'];
        H.imageh.CData = GetSliceImage;
    end
    function [A,Areal,z] = GetSlice
        slh = H.View2_Slider;
        %A = round(slh.Value * slh.UserData + 1);
        A = slh.Value;
        Areal = (slh.Value-1) * H.NewReso1(3);
        z = slh.UserData + 1;
    end
    function Image = GetSliceImage
        A = GetSlice;
        for n = 1:4
            im(n).val = single(H.useImage(n).val);
        end
        
        MIPTypeH = H.MIP_Children(1);
        MIPType = MIPTypeH.Value;
        MIPNUM = H.MIP_Children(3).Value;
        Aend = min(size(im(1).val,3),A+MIPNUM-1);
        DimH = H.MIP_Children(2);
        DIM = eval(DimH.Value);
        
        [X,Y,Z] = meshgrid(1:size(im(1).val,2),1:size(im(1).val,1),A:Aend);
        for n = 1:4
            im(n).val = interp3(im(n).val,X,Y,Z);            
        end
        
        for n = 1:4
            switch MIPType
                case 'max'
                    im(n).val = max(im(n).val,[],DIM);
                case 'min'
                    im(n).val = min(im(n).val,[],DIM);
                case 'Average'
                    im(n).val = nanmean(im(n).val,DIM);
                case 'Median'
                    im(n).val = nanmedian(im(n).val,DIM);
                case 'SD'
                    im(n).val = nanstd(im(n).val,DIM);
                otherwise
                    error('call developper, Sugashi.')
            end
        end
        
        for n = 1:4
            if sum(isnan(im(n).val(:))) == numel(im(n).val)
                im(n).val(:) = 0;
                Noise(n) = 0; Signal(n) = 1;
            else
                [N1,S1] = TS_GetBackgroundValue(im(n).val(:));
                N1(isnan(N1)) = 0;
                S1(or(isnan(S1),N1==S1)) = max(max(im(n).val(:)),1);
                Noise(n) = N1;Signal(n) = S1;
            end
        end
        
        cdata.CLim = [Noise(:), Signal(:)];
        cdata.Color = cat(1,[1 1 1]*.8,[1 0 1],[0 1 0],[.3 0 1]);
        cdata.Gamma = [1.5 .8 .8 .8];
        Image = rgbproj(cat(3,im.val),cdata);        
    end

    %% Rotation Movement and Stretch Main Function.%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function Rotate_Move_Obj
        
        
        XYZ = H.OriginalXYZ;        
        RMSD = GetRotMovStretchData;
        XYZ = S.xyz2RotMoveStretch(XYZ,RMSD,H.FOV2/2);
        
        H.Patch_Object.XData = XYZ(:,1);
        H.Patch_Object.YData = XYZ(:,2);
        H.Patch_Object.ZData = XYZ(:,3);
        %% Stretch         
        DrawStretchLine(LocNum)
    end    
    function DrawStretchLine(LocNum)
        [X,Y,lx] = GetStretchLineXY(LocNum);

        ly = interp1(X,Y,lx,H.Stretch_Group.InterpType);
        
        
        if isfield(H.Stretch_Group,'InterpLine')
            if length(H.Stretch_Group.InterpLine) >= LocNum-1
                TF = true;
            else
                TF = false;
            end
        else
            TF = false;
        end
        if TF
            H.Stretch_Group.InterpLine(LocNum-1).XData = lx;
            H.Stretch_Group.InterpLine(LocNum-1).YData = ly;
        else
            H.Stretch_Group.InterpLine(LocNum-1) = plot(H.Depth_Stretch_axes(LocNum-1),...
                lx,ly);
        end
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
    function Data = GetRotMovStretchData(LocNum)
        [R,M] = GetRotMov(H);
        % RotMov = cat(1,R,M);
        [X,Y,lx] = GetStretchLineXY(LocNum);
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
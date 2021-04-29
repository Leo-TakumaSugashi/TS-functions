classdef Segment_GUI
    % core function of GUI for Vascular Tree Structure(=Segment)
    %
    % ver1.55 , almost function(uicontroll,in panels) is Done,
    % But, in real case, FOV 455.88x455.88x800 um, is too heavy for
    % rendering.(may be too many text and plot data)
    % ,obj.MaximamPatchFace is,reducepatch(fv,NUMBER)
    %
    % ver.1.561 is Test for SEGview_limit ver. and, 
    % It has checked 3D Rendering, and Text. Must Be Cool!!
    %    
    % ver.1.562 is added developer's menu in Sample barR
    % ver.1.564 is New ver in May. 2019.
    % ver.1.565 ,,, TS_ReSEG --> Segment FUcntion.Connect
    % Edit , Save Function had Bag....
    % ver.1.566,,, Selection button is just button as selectable more than
    % single....
    % ver 1.56799,,, fuckin TeraStation ate My Function. so ver1.567 n
    % 1.568 disappeared... 2019.06.29,,,,
    % 1.6 Able to Edit Each point data
    %      example , [X, Y, Z] --> [X', Y', Z']
    %version v1.61 --> Rename to LeoTS_Segment_GUI_v0p1
    %                         from Sugashi_Segment_v1.61
    %      add to enable to view 4-D imaging SEG data
    %      edit 2020. 5-30th Arp. to ... by Sugashi
    % 
    % version 1.7.0 LeoTS...v0p1
    % SEGview add slice type(==Time dimmension)
    %     {'same'                   }
    %     {'Type'                   }
    %     {'Diameter'               }
    %     {'Length'                 }
    %     {'class'                  }
    %     {'AverageDiameter'        }
    %     {'Signal'                 }
    %     {'Noise'                  }
    %     {'SNR'                    }
    %     {'Theta'                  }
    %     {'NormThetaXY'            }
    %     {'Fai_AngleFromXYplane'   }
    %     {'AnalysisShoudBeElliptic'}
    % all of type might be able to use in SEGview(SEG,'string')
    %
    %
    % version v1.7.1
    % Name to Segment_GUI
    % add chose all in view(panel 3)
    %
    % version 1.7.2
    %  version information add properties.
    %  Modified RecheckSEG func.
    %
    % version 1.7.3
    %  Modified RecheckSEG_TextONOFF func.
   properties
      Name(1,:) char
      Resize(1,:) char {mustBeMember(Resize,{'on','off','Done'})} = 'on'
      Value
      ControllerHight %% use as controller hight pixels size for ResizeFunc.
      ViewerType(1,:) char {mustBeMember(ViewerType,{'with Volume','Slice only'})} = 'with Volume' 
      Image(:,:,:,:,:) {mustBeNumeric}
      ImageProcessed %% will be structure having fields, "Name","Image","Resolution"..
      Resolution(1,4) % Resolution order is [Y, X, Z, Y] 
      % % Panel 1= Segment data
      PreSEG % it mean Pre-Segment data
      Segment % Segmented Data
      Draw1SEGdata(:,1) = []% = drawpoint(handles)
      ImportBranchPosition_Real(2,3) = nan(2,3) % First or End
      ROIdata
      CurrentSegmentNumber(1,1)
      % % Panel 2 = Slice Image Viewer 
      MaxChannels(1,1) uint8 {mustBeReal, mustBeFinite,mustBeLessThanOrEqual(MaxChannels,12)}  = 12;%% will be for tracking
      Channels(1,:) uint8 {mustBeReal, mustBeFinite} = 1
      ChannelsColor(:,3) double {mustBeReal,mustBeFinite,mustBeLessThanOrEqual(ChannelsColor,12)} = [1 1 .8];
      ChannelsGamma(:,1) double {mustBeReal,mustBeFinite,mustBeGreaterThan(ChannelsGamma,0)} = 1;
      ChannelsCLim(:,2) double {mustBeReal,mustBeFinite} = [0 255];
      ChannelsCLimMode(1,:) char {mustBeMember(ChannelsCLimMode,{'auto','manual'})} = 'auto'
      SEG_CheckLineColor(1,3) double = [0.3, 0.5, 1.0]
      SEG_CheckLineStyle(1,:) char {mustBeMember(SEG_CheckLineStyle,{'-','--',':','-.','none'})} = '--'
      SEG_CheckLineWidth(1,1) double = 4;
      SEG_CheckPointColor(1,3) double = [0.3, 1.0, 0.3]
      SEG_CheckPointMarker(1,:) char {mustBeMember(SEG_CheckPointMarker,{'o','^','x','s'})} = 's'
                                       %Marker  {'+' | 'o' |'*' | '.' | 'x' | 'square' | 'diamond' | 'v' |
                                       %         '^' | '>' | '<' |'pentagram' | 'hexagram' | 'none'}
      SEG_CheckPointMarkerSize(1,1)  double = 10
      SEG_CheckPointLineWidth(1,1)  double = 5
      SEG_CheckImportPointColor(1,3) double = [0.8, 0.7, 0.1]
      SEGview_SelectedLine2DVisible(1,:) char {mustBeMember(SEGview_SelectedLine2DVisible,{'on','off'})} = 'on'
      SEGviewSlice_TextONOFF(1,:) char {mustBeMember(SEGviewSlice_TextONOFF,{'on','off'})} = 'on'
      SEGEditor_ChangeMinimumVoxelsSize(1,1) double = 0.01;
      SegSelection_RangeMod(1,3) double = [60 60 20]; % [ x y z]
      SEGviewCData(:,:) double
        % wanna view as real rength matrix and
      SliceViewCurrentDataName(1,:) char = 'Original'
      MaximumXDataSsize(1,1) uint16 {mustBeReal, mustBeFinite} = 256
      XData(:,:) single {mustBeReal} = 1;
      MaximumYDataSize(1,1) uint16 {mustBeReal, mustBeFinite} = 256
      YData(:,:) single {mustBeReal} = 1;
      MaximumZDataSize (1,1) uint16 {mustBeReal, mustBeFinite} = 256
      ZData(:,:) single {mustBeReal} = 1;
      TimeData(1,:) single {mustBeReal} = nan;
      % %  Panel 3 = Volume Rendering by isosurface and patch function.
      VolumeViewCurrentDataName(1,:) char = 'Original'
      VolumeViewProjection(1,:) char {mustBeMember( VolumeViewProjection,{'orthographic','perspective'})} = 'perspective'
      MaximumRenderingSize(1,1) uint16{mustBeReal} = 128;
      MaximumPatchFace(1,1) double = 10^6
      SEGview_Type(1,:) char {mustBeMember(SEGview_Type,{ ...
          'same','Type','Diameter','Length','class','AverageDiameter',...
          'Signal','Noise','SNR','Theta','NormThetaXY',...
          'Fai_AngleFromAxisZ','AnalysisShoudBeElliptic'})} = 'same'  
      SEGview_LineWidth = 3;
      SEGview_Marker = '.'
      SEGview_MarkerSize = 8;
      SEGview_SelectedLineWidth(1,1) double = 5;
      SEGview_SelectedLineColor(1,3) double = [0 0 1];
      SEGview_SelectedLineStyle = '-'
      SEGview_SelectedMarker = 'none'
      SEGview_SelectedMarkerSize = 5
      
      GUIHandles
      %%
      ViewSupport = Reconstruction_Group
      GUISupport = Sugashi_GUI_support
      SEGFcn = Segment_Functions
      SEG_Connect_Force(1,1) logical = false;
      MovingAverage = @TS_MovingAverage
      xyz2Interp = @TS_xyzInterp
      ReSegment = @TS_ReSEG %% --> Segment_Function(Connect)
      ChaseSegment
      
      Tag
      Version = '1.7.3'
      UserData
   end
   methods
       %% Input check
      function obj = set.Name(obj,v)
          if ~ischar(v)
              error('Input "Name" is not CHARACTOR.')
          else
              obj.Name = v;
          end
      end
      function obj = set.Image(obj,VC)
          if ~isnumeric(VC)
              error('Input Image data is NOT numeric data.')
          end
          if or(isscalar(VC),isvector(VC))
              error('Input Image data is scalar or vector.')
          end
          fprintf('#### Setting up Image file. ################\n')
          disp(['    class : ' class(VC)])
          disp(['    numel :(' num2str(size(VC)) ') [voxels]'])
          obj.Channels = size(VC,5);
          obj.ChannelsColor = GetColorChannels(size(VC,5));
          obj.ChannelsGamma = ones(obj.Channels,1);
          Clim = zeros(obj.Channels,2);
          for k = 1:size(VC,5)
              x = VC(:,:,:,:,k);
              Clim(k,:) = [min(x(:)), max(x(:))];             
          end
          obj.ChannelsCLim = Clim;
          fprintf('--------------------------------------------\n')
          obj.Image = VC;
      end
      function obj = set.Resolution(obj,v)
          
          fprintf('#### Setting up Resolution file. ################\n')
          disp(['    class : ' class(v)])
          disp(['    numel :(' num2str(v,'%.2f %.2f %.2f %.2f') ') [um/voxels]'])
          fprintf('--------------------------------------------\n')
          obj.Resolution = v;
      end
      function obj = set.MaxChannels(obj,ch)
          if ~and(isnumeric(ch),isscalar(ch))
              error('you inputed Max Channels number was NOT scalar numeric.')
          end
          if ceil(ch/2) ~= floor(ch/2)
              error('Input MaxChannels should be even number.')          
          else
              obj.MaxChannels = ch;
          end
      end    
      function obj = set.Segment(obj,SEG)  
          if isempty(SEG)
              obj.Segment = [];
              return
          end
          Segment_FuncH = Segment_Functions;
          obj.Segment = Segment_FuncH.set_Segment(SEG);
      end
       %% test Functions
      function varargout =  sliceviewer(obj)
          fprintf('#### Setting up Slice Viewer. ################\n')
          narginchk(1,1) %% obj is inclued nargin '1'         
          fprintf(' Image infomation\n')
          disp(['    class : ' class(obj.Image)])
          disp(['    size  :[' num2str(uint16(size(obj.Image))) ']'])
          if isempty(obj.Image)
              fprintf('-----------------------------------Return ---\n')
              return
          end
                   
          fgh = figure('Posi',[50 55 500 600],...
                  'toolbar','figure',...
                  'menubar','none',...
                  'Name',['Slice Viewer(XY): ' obj.Name]);
          axh = axes('Unit','Normalized',...
                'Position',[0.01 0.1 0.98 0.85]);
          if nargout ==1
              varargout{1} = axh;
          end
              
          imh = imagesc(rgbproj(obj.Image(:,:,end,:)));
          axis image off
          colormap(gray(256))
          setappdata(fgh,'imh',imh);
          znum = size(obj.Image,3);
          if znum>1
              slh = uicontrol('Style','slider',...
                        'Unit','Normalized',...
                        'BackgroundColor',[0.5 0.5 0.5],...
                        'Position',[0 0 1 0.04],...
                        'Value',1,...
                        'SliderStep',[1/(znum-1) 10/(znum-1)],...
                        'Callback',@Callback_slider,...
                        'Userdata',znum-1);
              txh = uicontrol('Style','text',...
                'unit','Normalized',...
                'Position',[0.6 0.04 0.4 0.03],...
                'String',num2str(znum));
              setappdata(fgh,'slh',slh)
              setappdata(fgh,'txh',txh);
          end
          %% Pixels infomation
          pixh = impixelinfo;
          pixh.Position = [1 32 293 21];
          setappdata(fgh,'impixelinfoH',pixh)
          %% MIP menu
          MIPh = create_MIPmenu(obj,fgh,znum);
          function uih = create_MIPmenu(obj,fgh,znum)
              MIPString = {'Max';'Average';'Median';'SD';'Min';'Sum';'RGB'};
              if ndims(obj.Image) == 4
                  MIPString = MIPString(1:end-1);
              end
              if znum>1
                  uih(1) = uicontrol(fgh,...
                                    'Style','popupmenu',...
                                    'Position',[2 580 80 19],...
                                    'String',MIPString);
                  uih(2) = uicontrol(fgh,...
                                    'Style','Edit',...
                                    'Position',[84 580 50 19],...
                                    'String','1');
                  uih(3) = uicontrol(fgh,...
                                    'Position',[138 580 50 19],...
                                    'String','Apply',...
                                    'Callback',@Callback_slider);

                  for n = 1:length(uih)
                      uih(n).Units = 'normalized';
                  end
%                   setappdata(fgh,'MIPhandles',uih)
              end
          end
          function A = GetNowSlice(slh)
              A = uint32(round(get(slh,'Value')*get(slh,'Userdata')+1));
          end
          function ResetView(fgh)
%               slh = getappdata(fgh,'slh');
% %               data = obj.Image; %getappdata(fgh,'data');
%               imh = getappdata(fgh,'imh');
%               txh = getappdata(fgh,'txh');
%               znum = size(obj.Image,3);
              NowSlice = GetNowSlice(slh);
            %% MIP
%               MIPh = getappdata(fgh,'MIPhandles');
              Type = get(MIPh(1),'String');
              value = get(MIPh(1),'Value');
              Type = Type{value};
              NUM = str2double(get(MIPh(2),'String'));
              zdata = 1:size(obj.Image,3);
              zidx = and(zdata>=NowSlice,zdata<NowSlice+NUM);
              data = (obj.Image(:,:,zidx,:));
              switch lower(Type)
                  case 'max'
                      data = rgbproj(max(data,[],3),'auto');
                  case 'average'
                      data = rgbproj(mean(single(data),3),'auto');
                  case 'median'
                      data = rgbproj(median(data,3),'auto');
                  case 'sd'
                      data = rgbproj(std(single(data),[],3),'auto');
                  case 'min'
                      data = rgbproj(min(data,[],3),'auto');
                  case 'sum'
                      data = rgbproj(sum(data,3),'auto');
                  case 'rgb'
                      data = rgbproj(data,'auto');
              end
            %% imh
%               imh.CData = TS_GammaFilt(data,0.3);
              imh.CData = data;
              find_p = find(zidx);
              if (find_p(1)-find_p(end)) == 0
                  STR = [num2str(NowSlice) '/' num2str(znum)];
              else
                  STR = [num2str(NowSlice) '-' num2str(find_p(end)) '/' num2str(znum)];
              end
                  set(txh,'String',STR)        
          end
          function Callback_slider(a,~)
              ResetView(a.Parent)
          end
      end
      function sliceviewerXZ(obj)
          if max(obj.Resolution(1:3) == 0)
              warning('   Plese input Resolution.')
              return
          end
          obj.Image = flip(permute(obj.Image,[3 2 1]),1);
          axh = sliceviewer(obj);
          Reso = obj.Resolution(1:3);
          daspect(axh,[Reso(3)/Reso(2) 1 1])
          axh.Parent.Name = ['Slice Viewer(XZ): '  obj.Name];
      end
      function sliceviewerYZ(obj)
          if max(obj.Resolution(1:3) == 0)
              warning('   Plese input Resolution.')
              return
          end
          obj.Image = flip(permute(obj.Image,[3 1 2]),1);
          axh = sliceviewer(obj);
          Reso = obj.Resolution(1:3);
          daspect(axh,[Reso(3)/Reso(2) 1 1])
          axh.Parent.Name = ['Slice Viewer(YZ): ' obj.Name];
      end
      
      %% SEGMENT VIEWER & EDITOR
      function H = segeditor(obj)          
          % Slice Viewer is able to view in Pixels Base.
          % Volume Viewer is Rendering as isosurface data(fv) as using
          % patch function.
          % Volume Viewer is able to view in Real Length Base(um);
          %% check Image Resolution
          fprintf('\n # # # # # # # # # # # # # # # # # # # # # # # # # # #\n')
          if isempty(obj.Image) || max(obj.Resolution(1:3)) == 0  || isempty(obj.PreSEG)
              error('Please Input Image ,Resolution, and Pre-Segmentdata.')
          end                   
          if isempty(obj.Segment)
              disp('Set up Segment data as PreSEG.')
              obj.Segment = obj.PreSEG;
          end
          Pdata = obj.Segment.Pointdata;  
          obj.GUISupport.SegEditorDefaultType = obj.ViewerType;
          H  = obj.GUISupport.create_figure_segeditor(obj.MaxChannels);
          FigureH = H.figure;
          FigureH.BusyAction = 'cancel';
          H.ControllerA.Units = 'pixels';
          obj.ControllerHight = H.ControllerA.Position(4);
          fprintf('Input Image data is disirable uint8 class as Image matrix....\n\n')           
      %% Default set up
%           VersionNum = mfilename;
%           IndVer = find(VersionNum == '_');
%           VersionNum = VersionNum(IndVer(3)+2:end);
%           VersionNum(VersionNum=='p') = '.';
          VersionNum = obj.Version;
%           H.figure.Name = ['Segment Editor (ver. '  num2str(VersionNum,'%.1f')  ')'];
          H.figure.Name = ['Segment Editor (ver. '  VersionNum  ')'];
          H.figure.Colormap = gray(256);
          H.figure.Resize = obj.Resize;
          fprintf(['    Starting :' H.figure.Name '\n\n\n'])
          set(H.figure,'WindowButtonDownFcn',@WindowButtonFcn)
          set(H.figure,'WindowButtonUpFcn',@WindowButtonFcn)
          set(H.figure,'WindowKeyPressFcn',@WindowKeyFcn)
          set(H.figure,'WindowKeyReleaseFcn',@WindowKeyFcn)
          
          childrenH = H.ControllerC.Children;
          for cn = 1:length(childrenH)
              childrenH(cn).Units = 'pixels';
          end
          
          % % Projection Menu % %
          DimTF = size(obj.Image,[1 2 3 4]);
          DimN = 3;
          if and(DimTF(3)>1,DimTF(4)>1)
              DimSTR = {'1','2','3','4'};
          elseif and(DimTF(3)>1,DimTF(4)==1)
              DimSTR = {'1','2','3'};
          elseif and(DimTF(3)==1,DimTF(4)>1)
              DimSTR = {'4','4','4'};
          end
          
          childrenH = H.SliceViewerApply.UserData; 
          childrenH(2).String = DimSTR;
          childrenH(2).Value = DimN;   
          
          
          if ~strcmpi('off',obj.Resize)
              set(H.figure,'ResizeFcn',@WindowResize)
          end
          function WindowButtonFcn(ParentH,event)              
              if H.Axes == gca &&  strcmpi(event.EventName,'WindowMousePress')
                 Type = get(H.figure,'SelectionType'); % normal,alt,extend,open
                 
%                  TypeTF = false;
%                  if ismac
%                      TypeTF = strcmpi(Type,'alt');
%                  else
                     TypeTF = strcmpi(Type,'extend');
%                  end
                 if TypeTF && H.SEG_DrawSEGPoint.Value                     
                     ROI = obj.Draw1SEGdata;                     
                     h = drawpoint(H.Axes);
                     delete(h.UIContextMenu.Children)
                     UIContMenuH(1) = uimenu(h.UIContextMenu,...
                         'text','Delete','Callback',@Delete_DrawingROI);
                     
                     if isempty(ROI)
                         ROI = h;
                     else
                         ROI = cat(1,ROI,h);
                     end                     
                     h.Label = num2str(length(ROI));
                     h.UIContextMenu.UserData = h.Label;
                     % XYZ  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% only Z
                     
                     A = GetIndex_slider(H.Slider(1));
                     
                     A = double(A) -1;
                     A = A .* obj.Resolution(3);
                     
                     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                     %XYZ = [];
                     h.UserData = double(A);
                     obj.Draw1SEGdata = ROI;
                 end
              end
              function Delete_DrawingROI(oh,~)
                  check_ROI = obj.Draw1SEGdata;
                  Ind = str2double(oh.Parent.UserData);
                  if isempty(check_ROI) 
                      return
                  elseif length(check_ROI) ==1                      
                      delete(check_ROI(Ind))
                      obj.Draw1SEGdata = [];
                  else
                      delete(check_ROI(Ind))
                      check_ROI(Ind) = [];
                      % Re-Label
                      for n =1 :length(check_ROI)
                          check_ROI(n).Label = num2str(n);
                          check_ROI(n).UIContextMenu.UserData = num2str(n);
                      end
                      obj.Draw1SEGdata = check_ROI;
                  end                  
              end
          end
          function WindowKeyFcn(ParentH,event)
              if H.Axes == gca && strcmpi(event.EventName,'WindowKeyPress')
                  Step = H.Slider(1).SliderStep;
                  if strcmpi(event.Character,'s')
                      val = -1;
                  elseif strcmpi(event.Character,'w')
                      val = 1;
                  else
                      return
                  end
                  InputValue = H.Slider(1).Value +val*Step(1);
                  InputValue = min(max(InputValue,0),1);
                  H.Slider(1).Value = InputValue;
                  SetSliceView
              end
          end
          
          function WindowResize(ParentH,event)
%               fprintf([event.EventName '.   Please Wait...'])
              Hight = obj.ControllerHight;
              Margin = 0.9;
              if ~strcmpi('Done',obj.Resize)
                  obj.Resize = 'Done';                  
              else
                  H.ControllerA.Units = 'Pixels';
                  H.ControllerB.Units = 'Pixels';
                  H.ControllerC.Units = 'Pixels';
                  for n = 1:3
                     H.Panel(n).Units = 'pixels';
                  end
                  H.ViewSEG_Pdata.Units = 'pixels';
                  H.Axes.Units = 'pixels';
                  H.View3DPanel.Units = 'pixels';                  
              end
              
              
              if strcmpi('with Volume',obj.ViewerType)
                  FigWidthMin = 1200;                  
              else
                  FigWidthMin = 1000;                  
              end  
              
              NewPosi = ParentH.Position;
              if NewPosi(3) <FigWidthMin
                  NewPosi(3) = FigWidthMin;
                  ParentH.Position = NewPosi;
                  return
              end 
              ConstantWidth = 480;
              P1 = [1 1 ConstantWidth NewPosi(4)];
              if strcmpi('Slice only',obj.ViewerType)
                  w = (NewPosi(3)-P1(3))-1;
                  P2 = [1+P1(3) 1 w NewPosi(4)];
                  P3 = [0 0 1 1];
              else                  
                  w = (NewPosi(3)-P1(3))/2;
                  P2 = [1+P1(3) 1 w NewPosi(4)];
                  P3 = [1+w+P1(3) 1 w NewPosi(4)];
              end
              Aposi = [1, P1(4)-Hight, ConstantWidth, Hight*Margin];              
              Bposi = [1, P1(4)-Hight, w, Hight*Margin];
              Cposi = [1, P1(4)-Hight, w, Hight*Margin];
         
              H.Panel(1).Position = P1;
              H.Panel(2).Position = P2;
              
              H.ControllerA.Position = Aposi;
              H.ControllerB.Position = Bposi;
              
              H.ViewSEG_Pdata.Position = [1 1 ConstantWidth P1(4)-Hight];
              H.Axes.Position = [1 1 w-2 P1(4)-2-Bposi(4)];
              
              if strcmpi('with Volume',obj.ViewerType)
                  H.Panel(3).Position = P3;
                  H.ControllerC.Position = Cposi;
                  H.View3DPanel.Position = [1 1 w-2 P1(4)-2-Hight];
              end              
          end
          
          %% viewer Type Change
          set(H.MenuH.View_SliceOnly,'Callback',@Callback_ViewerTypeChange)
          set(H.MenuH.View_withVolume,'Callback',@Callback_ViewerTypeChange)
%           if strcmpi('with Volume',obj.ViewerType)
%               Callback_ViewerTypeChange(H.MenuH.View_withVolume,[])
%           else
%               Callback_ViewerTypeChange(H.MenuH.View_SliceOnly,[])
%           end
          
          function Callback_ViewerTypeChange(oh,~)
              obj.ViewerType =  oh.Label;
              if strcmpi('with Volume',obj.ViewerType)
                  H.MenuH.Panel3.Enable = 'on';
                  H.Panel(3).Visible = 'on';
                  set(H.MenuH.View_SliceOnly,'Checked','off')
                  set(H.MenuH.View_withVolume,'Checked','on')                  
              else
                  H.MenuH.Panel3.Enable = 'off';
                  H.Panel(3).Visible = 'off'; 
                  set(H.MenuH.View_SliceOnly,'Checked','on')
                  set(H.MenuH.View_withVolume,'Checked','off')                 
              end       
              
          end
          
      %% Panels
          %% Panel 1 
          Data = set_Table_Pdata(obj.Segment.Pointdata,obj.Segment.ResolutionXYZ);          
          set(H.Table_Pdata,'Data',Data)
          set(H.Table_Pdata,'CellEditCallback',@Callback_CellEdit_Pdata)
          set(H.Table_Pdata,'KeyPressFcn',@Callback_Pdata_KeyPressFcn)
          set(H.Table_Pdata,'CellSelectionCallback',@selectionChangeCallBack)
          set(H.BranchTable_XYZ,'CellEditCallback',@Callback_CellEdit_Branch)
          set(H.BranchTable_XYZ,'CellSelectionCallback','')
          set(H.Table_XYZ,'CellEditCallback',@Callback_CellEdit_PointXYZ)
          set(H.Table_XYZ,'CellSelectionCallback','')
          set(H.SEGSelectionEditButton,'Callback',@Callback_SEGSelectionEditButton)
          set(H.SEG_DeleteButton,'Callback',@Callback_SEG_DeleteButton)
          set(H.SEG_DrawSEGPoint,'Callback',@Callback_SEG_DrawSEGPoint)
          Callback_SEG_DrawSEGPoint
          set(H.SEG_ImportSEGPoint,'Callback',@Callback_SEG_ImportSEGPoint) 
          set(H.SEG_ClearSEGPoint,'Callback',@Callback_SEG_ClearSEGPoint)
          set(H.SEG_CheckSEGPoint,'Callback',@Callback_SEG_CheckSEGPoint)
          set(H.SEG_ConnectSEGPoint,'Callback',@Callback_SEG_ReSegment)          
          set(H.SEG_SeparateSEGPoint,'Callback',@Callback_SEG_ReSegment)
          set(H.SEG_InptIDApply,'callback',@Callback_EditPdata)
%           if DimTF(4)==1
%               H.SEG_InptIDApply.Visible = 'off';
%           end
          set(H.SEGEditor_WriteDataButton,'Callback',@Callback_WriteData2WS)
          set(H.SEGEditor_BranchAddEnd,'Callback',@Callback_SEG_BranchAdd)
          set(H.SEGEditor_BranchAddFirst,'Callback',@Callback_SEG_BranchAdd)
          set(H.SEGEditor_ViewBranch,'Callback',@Callback_ViewBranch)
          set(H.SEGEditor_ApplyBranch,'Callback',@Callback_ApplyBranch)
          
          function Callback_CellEdit_Pdata(oh,EditData)
              TableData = oh.Data;
              KeyModData = oh.UserData;
              Ind = EditData.Indices;
              fprintf('############ ############ ############\n')
              fprintf(['Table edit... : Column-'   oh.ColumnName{Ind(2)} ' , \n'])
              switch oh.ColumnName{Ind(2)}
                  case 'Edit'
                      %normal(normal),extend(shift+normal),alt(ctl+normal)
                      Type = get(H.figure,'SelectionType');                      
                      if strcmpi(Type,'extend') && ~isempty(KeyModData)
                          Row = sort([KeyModData.Index(1) Ind(1)]);
                          Row = Row(1):Row(2);
                          TableData(Row,Ind(2)) = KeyModData.Value;
                          oh.Data = TableData;
                      else
                          KeyModData.Index = Ind;
                          KeyModData.Value = TableData(Ind(1),Ind(2));
                          KeyModData.Type = Type;
                          oh.UserData = KeyModData;
                      end
                      Indexofedit = cell2mat(TableData(:,1));
                      A = oh.Data(Indexofedit,strcmpi(oh.ColumnName,'ID'));
                      A = cell2mat(A);
                      SELECTED = reshape(A,1,[]);
                      fprintf(['Edit Selected IDs: # [' num2str(SELECTED)  ']\n'])
                  case {'Class','Type','MEMO'}                      
                      fprintf([EditData.PreviousData ' to ' EditData.NewData '\n'])
                      fprintf(' ...Refresh Segment data \n')
                      ID = TableData{Ind(1),strcmpi(oh.ColumnName,'ID')};
                      Index = find(ID == cat(1,obj.Segment.Pointdata.ID));
                      if strcmpi(oh.ColumnName{Ind(2)},'Class')
                          obj.Segment.Pointdata(Index).Class = EditData.NewData;
                      elseif strcmpi(oh.ColumnName{Ind(2)},'MEMO')
                          obj.Segment.Pointdata(Index).MEMO = EditData.NewData;
                      elseif strcmpi(oh.ColumnName{Ind(2)},'Type')
                          if strcmpi(EditData.NewData,'E2E')
                              obj.Segment.Pointdata(Index).Type = 'End to End';
                          elseif strcmpi(EditData.NewData,'E2B')
                              obj.Segment.Pointdata(Index).Type = 'End to Branch';
                          elseif strcmpi(EditData.NewData,'B2B')
                              obj.Segment.Pointdata(Index).Type = 'Branch to Branch';
                          else
                              obj.Segment.Pointdata(Index).Type = 'Other';
                          end
                              
                      else
                          warning('Unexpected Input. Anything No refresh in SEGdata.')
                      end
                      
                  case 'Select'                      
                      TableData(:,Ind(2)) = {false};
                      TableData(Ind(1),Ind(2)) = {true};
                      oh.Data = TableData;
                      selectionChangeCallBack(oh, EditData)
                      ID = cell2mat(TableData(Ind(1),strcmpi(oh.ColumnName,'ID')));
                      Index = obj.ID2Index(ID);
                      P = obj.Segment.Pointdata;
                      edgeXYZ = P(Index).PointXYZ([1,end],:);
                      
                                                    
                      fprintf(['Selectid ID : ' num2str(ID) '\n'])
                      fprintf(['Selectid XYZ edge ( seg. reso) : ' num2str(edgeXYZ(1,:)) '\n'])
                      fprintf(['                               : ' num2str(edgeXYZ(end,:)) '\n\n'])
                      fprintf('    Setting up Point Data Table...')                      
                      Data_xyz = set_Table_XYZ(P(Index),obj.Segment.ResolutionXYZ);
                      set(H.Table_XYZ,'Data',Data_xyz)
                      drawnow
                      %% panel 3 SEG view Line Color 
                      fprintf('Done \n    Setting up SEG view Line Color...')                          
                      Change_SelectedLine
                      drawnow
                      fprintf('Done \n')
                      %% Panel 2, Slice Viewr Slider
                      if strcmpi(H.MenuH.Panel2_SegSelectionApply.Checked,'on')
                          fprintf('    Set up Slider Value...')
                          
                          xyz = obj.Segment.Pointdata(Index).PointXYZ;
                          xyz_real = (xyz-1) .* obj.Segment.ResolutionXYZ ;
                          [~,Reso2Dview] = obj.GetCurrentImage('slice');
                          xyz_2Dviewer = (xyz_real ./ Reso2Dview)+1;
                          Index_sort = ROI_GetXYZ_IndexSort;
                          Index = xyz_2Dviewer(:,Index_sort(3));
                          znum = H.Slider(1).UserData;
                          if znum > 1
                              xyz_2Dviewer = xyz_2Dviewer(:,Index_sort);
                              Maximum = max(Index);
                              Minimum = min(Index);
                              AddRange = obj.SegSelection_RangeMod;
%                               AddRange = AddRange./Reso2Dview;
                              %% depth
                              AddNumel = ceil(AddRange(3));
                              Thickness = ceil(Maximum) - floor(Minimum)+1 + AddNumel;
                              Slice = max(floor(Minimum)-1 - AddNumel,0);
                              H.Slider(1).Value = Slice/(znum-1);
                              MIPNUMH = H.SliceViewerApply.UserData;
                              MIPNUM = MIPNUMH(3);
                              MIPNUM.String = num2str(Thickness);
                              %% xy Plane
                              AddX = ceil(AddRange(1));
                              AddY = ceil(AddRange(2));
                              xyz = (xyz_2Dviewer-1).*Reso2Dview;
                              XLim = [min(xyz(:,1))-AddX+.5  max(xyz(:,1))+AddX+.5];
                              YLim = [min(xyz(:,2))-AddY+.5  max(xyz(:,2))+AddY+.5];
                              %%%%%%%%%%%%%%%%%%%%%%%%%%%% BAG. %%%%%%%%%%%
                              H.Axes.XLim = XLim;
                              H.Axes.YLim = YLim;
                              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               axis(H.Axes,'image')
%                               keyboard
                              SetSliceView
                          end
                          drawnow
                          fprintf('Done \n')
                      end
%                   case {'Diameter(Ave.)','Length'}                                            
%                       fprintf([num2str(EditData.PreviousData,'%.5f') ...
%                           '\n to \n' num2str(EditData.NewData,'%.5f') '\n'])                  
                  otherwise
                      warning('This Data is NOT able "EDIT".')
                      TableData(Ind(1),Ind(2)) ={EditData.PreviousData};
                      oh.Data = TableData;                      
              end
              drawnow
              fprintf('============ ============ ============\n')
          end
          
          function selectionChangeCallBack(src, eventdata)
              if ~isempty( eventdata.Indices)
                  where_changed = eventdata.Indices(1);
                  jscrollpane = javaObjectEDT(findjobj(src));
                  viewport    = javaObjectEDT(jscrollpane.getViewport);
                  jtable      = javaObjectEDT( viewport.getView );
                  jtable.scrollRowToVisible(where_changed - 1);
              end
          end
          function Callback_Pdata_KeyPressFcn(h,Event)
          end          
          function Callback_CellEdit_Branch(oh,EditData)
              TableData = oh.Data;
              Ind = EditData.Indices;
              fprintf('############ ############ ############\n')
              fprintf(['Branch Table Selected : Column-'   oh.ColumnName{Ind(2)} ' , \n'])
              switch oh.ColumnName{Ind(2)}
                  case 'Select'
                      fprintf(['    Selected : No.' num2str(Ind(1)) '\n'])
                      TableData(:,Ind(2)) = {false};
                      TableData(Ind(1),Ind(2)) = {true};                     
                      oh.Data = TableData;
                      Reset_SelectedPointView
                  otherwise
                      fprintf([num2str(EditData.PreviousData,'%.5f') ...
                          '\n to \n' num2str(EditData.NewData,'%.5f') '\n'])
              end
              drawnow
              fprintf('============ ============ ============\n')              
          end
          function Callback_CellEdit_PointXYZ(oh,EditData)
              TableData = oh.Data;
              Ind = EditData.Indices;
              fprintf('############ ############ ############\n')
              fprintf(['PointXYZ Table Selected : Column-'   oh.ColumnName{Ind(2)} ' , \n'])
              switch oh.ColumnName{Ind(2)}
                  case 'Select'
                      fprintf(['    Selected : No.' num2str(Ind(1)) '\n'])
                      TableData(:,Ind(2)) = {false};
                      TableData(Ind(1),Ind(2)) = {true};
                      oh.Data = TableData;
                      selectionChangeCallBack(oh, EditData)                      
                      Reset_SelectedPointView
                  case {'X','Y','Z'}
                      [SEG_Index,SEG_ID] = GetIndex_TablePdata_inSelected;
                      fprintf(['Previout ' oh.ColumnName{Ind(2)} ':'...
                          num2str(EditData.PreviousData) '\n'])
                      fprintf(['    --> NewData : ' num2str(TableData{Ind(1),Ind(2)}) '\n'])
                      fprintf('Re-setting up SEG-data ...')
                      xyzInd = Ind(2) -1;% ColumnName order : "Select, X, Y, Z, Branch,,,"
                      Newdata_SegReso = TableData{Ind(1),Ind(2)} / ...
                          obj.Segment.ResolutionXYZ(xyzInd) + 1;                      
                      obj.Segment.Pointdata(SEG_Index).PointXYZ(Ind(1),xyzInd) = ...
                            Newdata_SegReso;
                      ResetSEGview
                      Reset_SelectedPointView
                      view(H.Axes,2)
                  otherwise
                      warning('This Data is NOT able "EDIT".')
                      TableData(Ind(1),Ind(2)) ={EditData.PreviousData};
                      oh.Data = TableData; 
              end
              drawnow
              fprintf('============ ============ ============\n')              
          end
          function Callback_SEGSelectionEditButton(oh,~)
              TableData = H.Table_Pdata.Data;
              if oh.Value
                  oh.BackgroundColor = ones(1,3) * 0.4;
                  oh.String = 'Reset All';
                  InputTF = true;
              else
                  oh.BackgroundColor = ones(1,3) * 0.94;
                  oh.String = 'Check All';
                  InputTF = false;
              end
              TableData(:,1) = {InputTF};
              H.Table_Pdata.Data = TableData ; 
          end
          function Callback_SEG_DeleteButton(oh,~)
              fprintf('############ ############ ############\n   Delete...Please Wait...')
              oh.Enable = 'off';
              % Set up New Pointdata 
              NewPdata = obj.Segment.Pointdata;
              %%%TableData = H.Table_Pdata.Data;
              %%%ID = GetTableID_forDeleteSegments(TableData);
              %%%Pdata = Pdata(ID);
              ID = GetID_TablePdata_inEdit;
              Pdata_catID = cat(1,obj.Segment.Pointdata.ID);              
              
              for x = 1:length(ID)
%                   NewPdata(Pdata_catID==ID(x)).ID = abs(NewPdata(Pdata_catID==ID(x)).ID) * (-1);  %%%%%
%                   Edit 2020,3,13
                  aaa = find(Pdata_catID==ID(x));
                  picupID = NewPdata(aaa(1)).ID;
                  for na=1:length(aaa)
                      NewPdata(aaa(na)).ID = abs(picupID(1)) * (-1); 
                  end
              end
              % Refresh Pdata
              obj.Segment.Pointdata = NewPdata;
              NewTableData = set_Table_Pdata(NewPdata,obj.Segment.ResolutionXYZ);
              set(H.Table_Pdata,'Data',NewTableData)
              % Refresh PointXYZ table
              YangerID = find(Pdata_catID>0);
              NewData = set_Table_XYZ(NewPdata(YangerID(1)),obj.Segment.ResolutionXYZ);
              set(H.Table_XYZ,'Data',NewData)
              % Refresh SEG-view
              try
                ResetSEGview
              catch err
                keyboard
              end
              drawnow
              oh.Enable = 'on';
              fprintf('Done.\n============ ============ ============\n')
          end          
          function ID = GetID_TablePdata_inEdit
              ColumnName = (H.Table_Pdata.ColumnName);
              EditInd = strcmpi(ColumnName,'Edit');
              Ind = cell2mat(H.Table_Pdata.Data(:,EditInd));
              IDInd = strcmpi(ColumnName,'ID');
              ID =  cell2mat(H.Table_Pdata.Data(:,IDInd));
              ID = ID(Ind);
          end
          function [Index,ID] = GetIndex_TablePdata_inSelected
              ColumnName = (H.Table_Pdata.ColumnName);
              SelectedInd = strcmpi(ColumnName,'Select');
              Ind = cell2mat(H.Table_Pdata.Data(:,SelectedInd));
              IDInd = strcmpi(ColumnName,'ID');
              ID =  cell2mat(H.Table_Pdata.Data(:,IDInd));
              ID = ID(Ind);
              catID = cat(1,obj.Segment.Pointdata.ID);
              Index = find(catID == ID);
          end
          function Callback_SEG_DrawSEGPoint(~,~)
              Ind = cell2mat(H.Table_Pdata.Data(:,1));
              oh = H.SEG_DrawSEGPoint;              
              if sum(Ind) > 1
                  Edlgh = errordlg({...
                      '1. If you wanna drawing "New" segment or branch point,';...
                      '  clean all "Edit" column in Segment-Table.';...
                      ' ';....
                      '2. If you will edit curent(existing) segment,';...
                      '  check out just one  "Edit" column in Segment-Table.'});
                  waitfor(Edlgh)
                  oh.Value = 0;
              end              
              if oh.Value
                  oh.BackgroundColor = [0 0.6 0];
                  oh.String = 'Drawing';
                  H.SEG_ImportSEGPoint.Enable = 'on';
                  H.SEG_ClearSEGPoint.Enable = 'on';
                  H.SEG_CheckSEGPoint.Enable = 'on';
                  H.SEG_ImportAsBranchPoint.Enable = 'on';
                  H.SEGEditor_BranchAddEnd.Enable = 'on';
                  H.SEGEditor_BranchAddFirst.Enable = 'on';
                  if sum(Ind)==0
                      H.Table_Pdata.Enable = 'on';                      
                  elseif sum(Ind) ==1 
                      H.Table_Pdata.Enable = 'on'; %% should be off
                      Drawing_AutomaticSEGdata                  
                  end
              else
                  oh.BackgroundColor = [0.2 1 0.2];
                  oh.String = 'Draw ';
                  Callback_SEG_ClearSEGPoint
                  H.SEG_ImportSEGPoint.Enable = 'off';                  
                  H.SEG_ClearSEGPoint.Enable = 'off';
                  H.SEG_CheckSEGPoint.Enable = 'off';
                  H.SEG_ImportAsBranchPoint.Enable = 'off';
                  H.SEGEditor_BranchAddEnd.Enable = 'off';
                  H.SEGEditor_BranchAddFirst.Enable = 'off';
                  H.Table_Pdata.Enable = 'on';
              end
          end
          function Drawing_AutomaticSEGdata
              ID = GetID_TablePdata_inEdit;
              Pdata_catID = cat(1,obj.Segment.Pointdata.ID);
              PointData = obj.Segment.Pointdata(Pdata_catID==ID);
              disp('AAA')
          end          
          function Callback_SEG_ImportSEGPoint(~,~)
              fprintf('############ ############ ############\n   Import Segment\n')
              Callback_SEG_CheckSEGPoint
              [xyz_Voxels,Branch] = ROI2XYZ_ImageVoxels;
              if isempty(xyz_Voxels)
                  fprintf('\n    Nothing....')
                  for n = 1:20; fprintf('...'),pause(0.05),fprintf('\b\b'),pause(0.05),end
                  fprintf('WHY???\n    Considering...wait.'),
                  for n = 1:10; fprintf('.'),pause(0.05),fprintf('\b'),pause(0.05),end                  
                  fprintf('\b\b\b\b\b\n    ')
                  for n = 1:20; fprintf('...'),pause(0.05),fprintf('\b'),pause(0.05),end                  
                  fprintf('\n    Why?\n\n============ ============ ============ \n')
                  return
              end              
%               xyz_Real = (xyz_Voxels - 1) .* obj.Resolution(1:3);
              xyz_SEGVoxels = xyz_Voxels ./ obj.Segment.ResolutionXYZ + 1;
              
              Copy_SEG = obj.Segment;
              if length(Copy_SEG.Pointdata)>1
                  Copy_SEG.Pointdata(2:end) = [];
              end
              Copy_SEG.Pointdata.PointXYZ = xyz_SEGVoxels;
              Copy_SEG.Pointdata.OriginalPointXYZ = xyz_SEGVoxels;
              Copy_SEG.Pointdata.Branch = Branch;
              Copy_SEG.Pointdata.Diameter = [];
              Copy_SEG = obj.SEGFcn.set_Segment(Copy_SEG,'f');
              Copy_Pointdata = Copy_SEG.Pointdata;
%               xyz_SEGVoxels = xyz_Real ;            
              if sum(isnan(Branch(:,1))) == 0
                  Type = 'End to End';
              elseif sum(isnan(Branch(:,1))) == 1
                  Type = 'End to Branch';
              elseif sum(isnan(Branch(:,1))) == 2
                  Type = 'Branch to Branch';
              end
              
              abs_catID = abs(cat(1,obj.Segment.Pointdata.ID));
              Copy_Pointdata.ID = max(abs_catID) + 1;
              Copy_Pointdata.Type = Type;
              Copy_Pointdata.MEMO = ['Drawed ' date];
              NewPointdata = obj.Segment.Pointdata;
              Numel = length(NewPointdata);
              NewPointdata(Numel+1) = Copy_Pointdata;
%               NewPointdata = cat(2,NewPointdata,Copy_Pointdata);
              obj.Segment.Pointdata = NewPointdata;
              % Reset Controller Buttons
              H.SEG_DrawSEGPoint.Value = 0;
              Callback_SEG_DrawSEGPoint 
              % Reset Table              
              set(H.Table_Pdata,'Data',...
                  set_Table_Pdata(obj.Segment.Pointdata,obj.Segment.ResolutionXYZ))
              % Refresh SEGview
              ResetSEGview
              fprintf('============ ============ ============ \n')
          end
          function ROI_ChangeDim(PreDim,ToDim)
              ROI = obj.Draw1SEGdata;
              if isempty(ROI) || PreDim == ToDim
                  return
              end
              IndexSort = ROI_GetXYZ_IndexSort(PreDim);              
              for n = 1:length(ROI)
                  if ishandle(ROI(n))
                      Posi1 = ROI(n).Position;
                      Posi2 = ROI(n).UserData;
                      Posi = cat(2,Posi1,Posi2);
                      PosiXYZ = Posi(1,IndexSort);
                      NewIndexSort = ROI_GetXYZ_IndexSort(ToDim);
                      ROI(n).Position = PosiXYZ(NewIndexSort(1:2));
                      ROI(n).UserData = PosiXYZ(NewIndexSort(3));
                  end
              end
          end
          function [xyz,Branch] = ROI2XYZ_ImageVoxels
              ROI = obj.Draw1SEGdata;
              xyz = [];
              Branch = obj.ImportBranchPosition_Real;
              if isempty(ROI)                  
                  return
              end
              IndexSort = ROI_GetXYZ_IndexSort;              
              for n = 1:length(ROI)
                  if ishandle(ROI(n))
                      Posi1 = ROI(n).Position;
                      Posi2 = ROI(n).UserData;                      
                      Posi = cat(2,Posi1,Posi2);
                      xyz = cat(1,xyz,Posi);
                  end
              end              
              xyz = xyz(:,IndexSort);              
              % Branch
%               Branch = Branch ./ obj.Resolution(1:3) + 1;
              
              xyz = cat(1,Branch(1,:),xyz,Branch(2,:));
              xyz(isnan(xyz(:,1)),:) = [];              
              
          end          
          function IndexSort = ROI_GetXYZ_IndexSort(varargin)
              if nargin ==1
                  Dim = varargin{1};
              else
                  [~,Dim,~] = GetMIPOption;
              end
              if Dim==1
                  IndexSort = [1 3 2];
              elseif Dim==2
                  IndexSort = [3 2 1];
              elseif Dim==3 || Dim ==4
                  IndexSort = [1 2 3];
              else
                  error('Input Dimmention is not Correct..now..return.')
              end
          end
          function Callback_SEG_ClearSEGPoint(~,~)
              ROI = obj.Draw1SEGdata;
              if ~isempty(ROI)
                  for n = 1:length(ROI)
                      if ishandle(ROI(n))
                          delete(ROI(n))
                      end
                  end
              else
                  fprintf('    Clear SEG point(s)\n    No point, or No Drowind ROIdata .\n        Return\n')
              end
              % Branch Reset
              H.SEGEditor_BranchAddFirst.Value = 0;
              Callback_SEG_BranchAdd(H.SEGEditor_BranchAddFirst)
              H.SEGEditor_BranchAddEnd.Value = 0;
              Callback_SEG_BranchAdd(H.SEGEditor_BranchAddEnd)
              obj.Draw1SEGdata = [];
          end
          function Callback_SEG_CheckSEGPoint(~,~)
              xyz_Voxels = ROI2XYZ_ImageVoxels;
              if isempty(xyz_Voxels)
                  return
              end
%               xyz_Real = (xyz_Voxels-1) .* obj.Resolution(1:3);
              xyz_Real = xyz_Voxels;
              Ind = ROI_GetXYZ_IndexSort; 
              if ~isempty(xyz_Voxels)                  
                  hold(H.Axes,'on')
                  hold(H.View3DAxes,'on')
                  p1 = plot(H.Axes,xyz_Voxels(:,Ind(1)),xyz_Voxels(:,Ind(2)));
                  p2 = plot3(H.View3DAxes,xyz_Real(:,1),xyz_Real(:,2),xyz_Real(:,3));
                  p1.LineWidth = obj.SEG_CheckLineWidth;
                  p1.Color = obj.SEG_CheckLineColor;
                  p1.LineStyle = obj.SEG_CheckLineStyle;
                  p2.LineWidth = obj.SEG_CheckLineWidth;
                  p2.Color = obj.SEG_CheckLineColor;
                  p2.LineStyle = obj.SEG_CheckLineStyle;
                  for n = 1:5
                      p1.Visible = 'off';
                      p2.Visible = 'off';drawnow
                      pause(.2)
                      p1.Visible = 'on';
                      p2.Visible = 'on';drawnow
                      pause(.2)
                  end
                  delete([p1,p2])
              else
                  fprintf('    No point, or Not Drawing button.\n        Return\n')
              end
          end
          function Callback_SEG_ReSegment(oh,~)              
              fprintf('############ ############ ############ \n')
              fprintf(['    '  oh.String '\n'])
              ID = GetID_TablePdata_inEdit;              
              try
                  if strcmpi(oh.String,'Connect')
                      % NewSEG = obj.ReSegment(obj.Segment,'Connect',{ID});
                      if obj.SEG_Connect_Force
                          ConnectForceType = '-f';
                      else
                          ConnectForceType = '';
                      end
                      ConnectForceType = '-f';
                      NewSEG = obj.SEGFcn.Connect(obj.Segment,{ID},ConnectForceType);
                  elseif strcmpi(oh.String,'Separate')
                      [SelectedID,separate_index] = check_Selected_Index;
                      if isempty(SelectedID) || isempty(separate_index)
                          error('Please Select one point at least.')
                      end
%                       NewSEG = obj.ReSegment(obj.Segment,'Separate',SelectedID,separate_index);
                      NewSEG = obj.SEGFcn.Separate(obj.Segment,SelectedID,separate_index);
                  end
              catch err
                  fprintf(err.message)
                  fprintf('\n\n    Nothing to DO return.')
                  fprintf('\n\n============ ============ ============ \n')
                  return
              end
              obj.Segment = NewSEG;
              % Refresh Seg-Table 
              set(H.Table_Pdata,'Data',...
                  set_Table_Pdata(obj.Segment.Pointdata,obj.Segment.ResolutionXYZ))  
              catID = cat(1,obj.Segment.Pointdata.ID);
              [SelectedID,~] = check_Selected_Index;              
              set(H.Table_XYZ,'Data',...
                  set_Table_XYZ(obj.Segment.Pointdata(catID == SelectedID),obj.Segment.ResolutionXYZ))
              % Refresh SEGView              
              ResetSEGview
              fprintf('============ ============ ============ \n')
          end
          function [ID,separate_index] = check_Selected_Index
              ColumnName_Selected = strcmpi(H.Table_Pdata.ColumnName,'Select');
              ColumnName_ID = strcmpi(H.Table_Pdata.ColumnName,'ID');
              Selected_Table = cell2mat(H.Table_Pdata.Data(:,ColumnName_Selected));
              ID_Table = cell2mat(H.Table_Pdata.Data(:,ColumnName_ID));
              ID = ID_Table(Selected_Table);
              if numel(ID) ~= 1
                  ID = [];
                  separate_index = [];
                  return
              else
                  ColumnName= H.Table_XYZ.ColumnName;
                  select_posi = strcmpi(ColumnName,'Select');
                  selectedIndex = cell2mat(H.Table_XYZ.Data(:,select_posi));
                  separate_index = find(selectedIndex);                  
              end             
          end                       
          function Callback_SEG_BranchAdd(oh,~)   
              HSVMap = rgb2hsv(oh.BackgroundColor);
              xyz_real = GetPointdataXYZ_RealUnits;
              if oh.Value
                  STR = num2str(xyz_real,'[%.1f, %.1f, %.1f]um');
                  if isempty(STR)
                      STR = '!! Select A Point.';
                      xyz_real = nan(1,3);                      
                  end 
                  HSVMap(3) = 0.7;
              else
                  HSVMap(3) = 1;
                  STR = oh.Tag;
                  xyz_real = nan(1,3);
              end
              oh.BackgroundColor = hsv2rgb(HSVMap);
              oh.String = STR;
              % Refresh obj.ImportBranchPosition_Real
              if strcmpi(oh.Tag,'Appoint as First')
                  obj.ImportBranchPosition_Real(1,:) = xyz_real;    
              elseif strcmpi(oh.Tag,'Appoint as End')
                  obj.ImportBranchPosition_Real(2,:) = xyz_real;
              end
              Reset_ImportBranchView
          end
          Callback_ViewBranch
          function Callback_ViewBranch(~,~)
              fprintf('    ==== View Branch Callback....wait.')
              oh = H.SEGEditor_ViewBranch;              
              if oh.Value
                  oh.String = 'Edit Branch Point';
                  oh.BackgroundColor = ones(1,3)*0.6;
                  H.Table_XYZ.Visible = 'on';
                  H.BranchTable_XYZ.Visible = 'on';
                  H.SEGEditor_BranchDelete.Enable = 'off';
                  H.SEGEditor_ApplyBranch.Enable = 'on';
                  H.SEG_SeparateSEGPoint.Enable = 'off';
              else
                  oh.String = 'Branch Points';
                  oh.BackgroundColor = ones(1,3)*0.94;
                  H.Table_XYZ.Visible = 'on';
                  H.BranchTable_XYZ.Visible = 'off';
                  H.SEGEditor_BranchDelete.Enable = 'off';
                  H.SEGEditor_ApplyBranch.Enable = 'off';
                  H.SEG_SeparateSEGPoint.Enable = 'on';
              end
              drawnow
              fprintf('\b\b\b\b\bDone.\n    =====   =====   =====\n\n')
          end
          function Callback_ApplyBranch(~,~)
              fprintf('    ==== Apply Branch Callback...wait.')
              BranchData = H.BranchTable_XYZ.Data;
              P2 = cell2mat(BranchData(:,2:4));
              % Edit  Segment.BranchPointXYZ                             
              P1 = obj.Segment.BranchPointXYZ;
              P2 = P2./obj.Segment.ResolutionXYZ + 1;     
              obj.Segment.BranchPointXYZ = P2;
                  % if change size is less than 0.1 voxels, neverchange;
              check_index = sum(abs(P1 - P2) < obj.SEGEditor_ChangeMinimumVoxelsSize,2)~=3; 
              P1 = P1(check_index,:);
              P2 = P2(check_index,:);              
              % Edit  Each Branch point(s) as a Segment inPointdata
              Pointdata = obj.Segment.Pointdata;
              Pointdata = obj.SEGEditor_ChangeBranchPosition(Pointdata,P1,P2);
              obj.Segment.Pointdata = Pointdata;
              % Refresh Tables              
              set(H.Table_Pdata,'Data',...
                  set_Table_Pdata(obj.Segment.Pointdata,obj.Segment.ResolutionXYZ))              
              set(H.Table_XYZ,'Data',...
                  set_Table_XYZ(obj.Segment.Pointdata(1),obj.Segment.ResolutionXYZ))          
              set(H.BranchTable_XYZ,'Data',....
                  set_Table_BranchXYZ(obj.Segment,obj.Segment.ResolutionXYZ))
              % Refresh  SEGview
              ResetSEGview
              fprintf('\b\b\b\b\bDone.\n    =====   =====   =====\n\n')
          end          
          function Data = set_Table_Pdata(Pdata,Reso)
              ID = cat(1,Pdata.ID);
              [sortedID,sort_index] = sort(ID);
              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              %%%     ID check, 
              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              Pdata = Pdata(sort_index(sortedID>0));
              
              %%%% ADD FOR TIME DATA %%%%%%%%%%%%%%%%%%%%%%%%
              Pdata = GetCurrentTimePdata(Pdata);
              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              
              Data = cell(length(Pdata),12);
              for n = 1:length(Pdata)
                  Data{n,1} = false;                           %'Edit',...
                  Data{n,2} = n == 1;                          %'Select',...
                  Data{n,3} = Pdata(n).ID ;                    %'ID',...
                  Data{n,4} = Pdata(n).Class;                  %'Class',...   
                  Data{n,5} = nanmean(Pdata(n).Diameter,1);    %'Diameter',...
                  Data{n,6} = Pdata(n).Length;                 %'Length',...                  
                  Data{n,7} = Pdata(n).Length*pi*nanmean(Pdata(n).Diameter,1)^2 ; %'Volume'....
                  switch Pdata(n).Type
                      case 'End to End'
                          Type = 'E2E';
                      case 'End to Branch'
                          Type = 'E2B';
                      case 'Branch to Branch'
                          Type = 'B2B';
                      otherwise
                          Type = 'Other';
                  end
                  Data{n,8}  = Type;                            %'Type',...                                        
                  Data{n,9}  = (mean(Pdata(n).PointXYZ(:,1),1)-1) *Reso(1); %'X',...
                  Data{n,10} = (mean(Pdata(n).PointXYZ(:,2),1)-1) *Reso(2);  %'Y',...
                  Data{n,11} = (mean(Pdata(n).PointXYZ(:,3),1)-1) *Reso(3);  %'Z',...
                  Data{n,12} = Pdata(n).MEMO;                   %'MEMO'};
              end          
          end
          ids = find(cat(1,Pdata.ID)>0);%%2020.08.11 / Sugashi
          Data = set_Table_XYZ(Pdata(ids(1)),obj.Segment.ResolutionXYZ);
          set(H.Table_XYZ,'Data',Data)          
          function Data = set_Table_XYZ(EachPointdata,Reso)
          % Table XYZ
          %{'Edit','X','Y','Z','Branch','Diameter','Signal','Noise','SNR',}
          % 1       2  3  4   5
              %%%% ADD FOR TIME DATA %%%%%%%%%%%%%%%%%%%%%%%%
              EachPointdata = GetCurrentTimePdata(EachPointdata);
              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
          
          
              XYZ = EachPointdata.PointXYZ;
              Branch = EachPointdata.Branch;
              Diameter = EachPointdata.Diameter;
              Signal = EachPointdata.Signal;
              Noise = EachPointdata.Noise;
              % XYZ = EachPointdata.NewXYZ;
              Data = cell(size(XYZ,1),9); 
              
              for n = 1:size(XYZ,1)                  
                  len = TS_EachLengthMap2(Branch,XYZ(n,:),Reso);                  
                  Data{n,1} = false;
                  Data{n,2} = (XYZ(n,1)-1) * Reso(1);
                  Data{n,3} = (XYZ(n,2)-1) * Reso(2);
                  Data{n,4} = (XYZ(n,3)-1) * Reso(3);
                  Data{n,5} = min(len(:)) == 0;
                  Data{n,6} = Diameter(n);
                  Data{n,7} = Signal(n);
                  Data{n,8} = Noise(n);
                  Data{n,9} = 10*log10(Signal(n) / Noise(n));
              end          
          end
          Data = set_Table_BranchXYZ(obj.Segment,obj.Segment.ResolutionXYZ);
          set(H.BranchTable_XYZ,'Data',Data)
          function Data = set_Table_BranchXYZ(SEG,Reso)
          % Table BranchXYZ
          %{'Selection','X','Y','Z','MEMO',}
          % 1            2   3   4   5          
              XYZ = SEG.BranchPointXYZ;
              Data = cell(size(XYZ,1),5);
              for n = 1:size(XYZ,1)
                  Data{n,1} = false;
                  Data{n,2} = (XYZ(n,1)-1) * Reso(1);
                  Data{n,3} = (XYZ(n,2)-1) * Reso(2);
                  Data{n,4} = (XYZ(n,3)-1) * Reso(3);
                  Data{n,5} = [];
              end          
          end  
          
          function Callback_EditPdata(~,~)
              try
                  txt = eval(H.SEG_InptIDEdit.String);
              catch err
                  disp(err.message)
                  return
              end
              
              SEG = obj.Segment;
              catID = cat(1,SEG.Pointdata.ID) > 0;
              SEG.Pointdata = SEG.Pointdata(catID);
              catID = cat(1,SEG.Pointdata.ID);
              if isempty(txt)
                  return
              else
                  IDs = txt;
                  Columname = H.Table_Pdata.ColumnName;
                  catID = H.Table_Pdata.Data(:,strcmpi(Columname,'ID'));                  
                  catID = cell2mat(catID);
                  NewData = H.Table_Pdata.Data;
                  for k = 1:length(IDs)
                      NewData{find(catID == IDs(k)),strcmpi(Columname,'Edit')} = true;
                  end
                  catEdit = cell2mat(NewData(:,strcmpi(Columname,'Edit')));
                  NewData = cat(1,NewData(catEdit,:),NewData(~catEdit,:));
                  H.Table_Pdata.Data = NewData;
              end    
          end
          
          
          Reset_ImportBranchView
          function Reset_ImportBranchView
              Branch_Real = obj.ImportBranchPosition_Real;
              View2D_Reso = obj.Resolution(1:3);
              Branch_Voxel = Branch_Real ./ View2D_Reso + 1;
              Ind = ROI_GetXYZ_IndexSort;              
              if ~isfield(H,'ImportBranchdata')
                  for n = 1:2                  
                      if n == 1
                          p = plot(H.Axes,Branch_Voxel(:,Ind(1)),Branch_Voxel(:,Ind(2)));
                          p.UserData = Branch_Voxel(:,Ind(3));
                      else
                          p = plot3(H.View3DAxes,Branch_Real(:,1),Branch_Real(:,2),Branch_Real(:,3));
                      end
                      p.Marker = obj.SEG_CheckPointMarker;
                      p.Color = obj.SEG_CheckImportPointColor;
                      p.MarkerSize = obj.SEG_CheckPointMarkerSize;
                      p.LineWidth = obj.SEG_CheckPointLineWidth;
                      p.LineStyle = 'none';
                      H.ImportBranchdata(n) = p;
                  end
              end
              % View 2D
              
              H.ImportBranchdata(1).XData = Branch_Voxel(:,Ind(1));
              H.ImportBranchdata(1).YData = Branch_Voxel(:,Ind(2));
              H.ImportBranchdata(1).UserData = Branch_Voxel(:,Ind(3));
              % View 3D
              H.ImportBranchdata(2).XData = Branch_Real(:,1);
              H.ImportBranchdata(2).YData = Branch_Real(:,2);
              H.ImportBranchdata(2).ZData = Branch_Real(:,3);
          end          
          Reset_SelectedPointView
          function Reset_SelectedPointView
              if ~isfield(H,'SelectedPointView2D')
                  hold(H.Axes,'on')
                  p = plot(H.Axes,0,0);
                  p.Marker = obj.SEG_CheckPointMarker;
                  p.Color = obj.SEG_CheckPointColor;
                  p.MarkerSize = obj.SEG_CheckPointMarkerSize;
                  p.LineWidth = obj.SEG_CheckPointLineWidth;
                  H.SelectedPointView2D = p;
              end
              if ~isfield(H,'SelectedPointView3D')
                  hold(H.View3DAxes,'on')
                  p = plot3(H.View3DAxes,0,0,0);
                  p.Marker = obj.SEG_CheckPointMarker;
                  p.Color = obj.SEG_CheckPointColor;
                  p.MarkerSize = obj.SEG_CheckPointMarkerSize;
                  p.LineWidth = obj.SEG_CheckPointLineWidth;
                  H.SelectedPointView3D = p;
              end
              %% main function for Selection callback for 1 point
              xyz_Real = GetPointdataXYZ_RealUnits;
%               View2D_Reso = obj.Resolution(1:3);
%               xyz_Voxel = xyz_Real ./ View2D_Reso + 1;
              xyz_Voxel = xyz_Real ;
              if isempty(xyz_Real)
                  H.SelectedPointView2D.Visible = 'off';
                  H.SelectedPointView3D.Visible = 'off';
                  return
              else
                  H.SelectedPointView2D.Visible = 'on';
                  H.SelectedPointView3D.Visible = 'on';
              end
              Ind = ROI_GetXYZ_IndexSort;
              % View 2D == Panel 2
              H.SelectedPointView2D.XData = xyz_Voxel(Ind(1));
              H.SelectedPointView2D.YData = xyz_Voxel(Ind(2));
              H.SelectedPointView2D.UserData = xyz_Voxel(Ind(3));
              % View 3D == Panel 3
              H.SelectedPointView3D.XData = xyz_Real(1);
              H.SelectedPointView3D.YData = xyz_Real(2);
              H.SelectedPointView3D.ZData = xyz_Real(3);              
          end
          function xyz_Real = GetPointdataXYZ_RealUnits
              check_BranchORPointXYZ = H.SEGEditor_ViewBranch.Value;
              if check_BranchORPointXYZ % branch view on mean Viewing Branch
                  TableHandle = H.BranchTable_XYZ;
              else  % branch view off mean Viewing PointXYZ
                  TableHandle = H.Table_XYZ;
              end              
              ColumnInd = strcmpi(TableHandle.ColumnName,'Select');
              ColumnXInd = strcmpi(TableHandle.ColumnName,'X');
              ColumnYInd = strcmpi(TableHandle.ColumnName,'Y');
              ColumnZInd = strcmpi(TableHandle.ColumnName,'Z');
              TableData = TableHandle.Data;
              if isempty(TableData)
                  xyz_Real = nan(1,3);
                  return
              end
              Ind = cell2mat(TableData(:,ColumnInd));
              X = cell2mat(TableData(:,ColumnXInd));
              Y = cell2mat(TableData(:,ColumnYInd));
              Z = cell2mat(TableData(:,ColumnZInd));
              xyz_Real = [X(Ind),Y(Ind),Z(Ind)];              
          end
          function Pdata = GetCurrentTimePdata(Pdata)
%               TimeDataType = H.SEG_InptIDEdit.String{H.SEG_InptIDEdit.Value};
              [MIPTYPE,DIM,Num] = GetMIPOption;
              NowTime = GetIndex_slider(H.Slider(2));
              tdata = 1:size(obj.Image,4);
              tind = and(tdata>=NowTime,tdata<=NowTime+Num);
              for n = 1:length(Pdata)
                  try
                  switch lower(MIPTYPE) %TimeDataType
                      case {'mean','average'}
                          Pdata(n).Diameter = nanmean(Pdata(n).Diameter(:,tind),2);
                          Pdata(n).Signal   = nanmean(Pdata(n).Signal(:,tind),2);
                          Pdata(n).Noise    = nanmean(Pdata(n).Noise(:,tind),2);
                          Pdata(n).Theta    = nanmean(Pdata(n).Theta(:,tind),2);  
                      case 'sd'
                          Pdata(n).Diameter = nanstd(Pdata(n).Diameter(:,tind),2);
                          Pdata(n).Signal   = nanstd(Pdata(n).Signal(:,tind),2);
                          Pdata(n).Noise    = nanstd(Pdata(n).Noise(:,tind),2);
                          Pdata(n).Theta    = nanstd(Pdata(n).Theta(:,tind),2);
                      case 'median'
                          Pdata(n).Diameter = nanmedian(Pdata(n).Diameter(:,tind),2);
                          Pdata(n).Signal   = nanmedian(Pdata(n).Signal(:,tind),2);
                          Pdata(n).Noise    = nanmedian(Pdata(n).Noise(:,tind),2);
                          Pdata(n).Theta    = nanmedian(Pdata(n).Theta(:,tind),2);
                      case 'max'
                          Pdata(n).Diameter = max(Pdata(n).Diameter(:,tind),[],2);
                          Pdata(n).Signal   = max(Pdata(n).Signal(:,tind),[],2);
                          Pdata(n).Noise    = max(Pdata(n).Noise(:,tind),[],2);
                          Pdata(n).Theta    = max(Pdata(n).Theta(:,tind),[],2);
                      case 'min'
                          Pdata(n).Diameter = min(Pdata(n).Diameter(:,tind),[],2);
                          Pdata(n).Signal   = min(Pdata(n).Signal(:,tind),[],2);
                          Pdata(n).Noise    = min(Pdata(n).Noise(:,tind),[],2);
                          Pdata(n).Theta    = min(Pdata(n).Theta(:,tind),[],2);
                      case 'upload current slice'
                          Pdata(n).Diameter = Pdata(n).Diameter(:,NowTime);
                          Pdata(n).Signal   = Pdata(n).Signal(:,NowTime);
                          Pdata(n).Noise    = Pdata(n).Noise(:,NowTime);
                          Pdata(n).Theta    = Pdata(n).Theta(:,NowTime);
                  end
                  catch err
                      warning('Sorry this is need debag Core Function... pls Contact to TS.')
                      Pdata(n).Diameter = Pdata(n).Diameter(:,1);
                      Pdata(n).Signal   = Pdata(n).Signal(:,1);
                      Pdata(n).Noise    = Pdata(n).Noise(:,1);
                      Pdata(n).Theta    = Pdata(n).Theta(:,1);
                  end
              end 
          end
          %% sort Pointdata(=Segment) Table, as Pdata_Table
          set(H.SEGEditor_SortApply,'Callback',@Callback_SEGEditor_SortApplyButton)
          function Callback_SEGEditor_SortApplyButton(oh,~)
              HSV = rgb2hsv( oh.BackgroundColor);
              if oh.Value
                  HSV(3) = 0.7;
                  oh.String = 'Sort : ON';
                  Callback_SEGEditor_Sort_Pdata_Table
              else
                  HSV(3) = 1.0;
                  oh.String = 'Sort : OFF';
              end
              oh.BackgroundColor = hsv2rgb(HSV);             
          end
          set(H.SEGEditor_SortChar,'Callback',@Callback_SEGEditor_Sort_Pdata_Table)
          set(H.SEGEditor_SortDirection,'Callback',@Callback_SEGEditor_Sort_Pdata_Table)
          function Callback_SEGEditor_Sort_Pdata_Table(~,~)
              if H.SEGEditor_SortApply.Value==0
                  return
              end
              STR = H.SEGEditor_SortChar.String{H.SEGEditor_SortChar.Value};
              Dir = H.SEGEditor_SortDirection.Value;
              check_column_p = find(STR==':');
              TableData = H.Table_Pdata.Data;
              if isempty(check_column_p)
                  Column = strcmpi(H.Table_Pdata.ColumnName,STR);
                  NumericData = cell2mat(TableData(:,Column));
                  if Dir == 1 % 
                      [~,SortIndex] = sort(NumericData,'ascend');
                  elseif Dir == 2
                      [~,SortIndex] = sort(NumericData,'descend');
                  end
                  H.Table_Pdata.Data = TableData(SortIndex,:);
              else
                  check_column_name = STR(1:check_column_p-1);
                  find_name = STR(check_column_p+1:end);
                  
                  Column = strcmpi(...
                      H.Table_Pdata.ColumnName,check_column_name);
                  StringData = TableData(:,Column);
                  Index = strcmpi(StringData,find_name);
                  if Dir == 1
                      NewTableData = cat(1,TableData(Index,:),TableData(~Index,:));
                  elseif Dir ==2
                      NewTableData = cat(1,TableData(~Index,:),TableData(Index,:));
                  end
                  H.Table_Pdata.Data = NewTableData;
              end
          end
          
          %% Save Segment to WorkSpace(WS)
          function Callback_WriteData2WS(~,~)
              SEG = obj.Segment;
              export2wsdlg({'Export to WS'},{'EditSEG'},{SEG},'Save Segment data');
          end
                    
          %% Panel 2
          CMap = obj.ChannelsColor;
          for nn = 1:obj.MaxChannels
%               set(H.ChannelsChoise(nn),'Callback',@ChannelsChoice_Single)
              set(H.ChannelsChoise(nn),'UserData',H.ChannelsChoise)
              set(H.ChannelsEditPush(nn),'Callback',@OpenChannelsEditor,...
                  'UserData',nn)
              if nn >size(obj.Image,5)
                  set(H.ChannelsChoise(nn),'Visible','off')
                  set(H.ChannelsEditPush(nn),'Visible','off')
              else
                  set(H.ChannelsChoise(nn),'Value',true)
                  H.ChannelsEditPush(nn).BackgroundColor = CMap(nn,:);
              end
          end
          imh = ReSetUpSliceViewer;
          H.SliceImageViewimagescHandle = imh;
          Mip_infoH = H.SliceViewerApply.UserData;
          set(Mip_infoH(4),'Callback',@SetSliceView)
          MIPDimH = Mip_infoH(2);
          set(MIPDimH,'Callback',@ChangeMIPDim)          
          IndexData.XYZ = [1 1 1];
          IndexData.SliderValue = [0 0 0];
          IndexData.MIPsH = Mip_infoH;
          
          % % % %SEGview slice % % % %
          H.SEGviewSlice_Line = [];
          H.SEGviewSlice_Text = [];
          if size(obj.Image,4)>1
              ResetUpSEGviewSlice;
              SEGviewSlice_TextONOFFcheck
          end
          
          
          
          function ChannelsChoice_Single(oh,~)
              OtherH = oh.UserData;
              for k = 1:length(OtherH)
                  OtherH(k).Value = 0;
              end
              oh.Value = 1;
          end
          function OpenChannelsEditor(oh,~)              
              uih = obj.GUISupport.SpectrumColormapEditor('top');
              uih(6).Visible = 'on';
              uih(6).String = 'Apply map';              
              set(uih(6),'Callback',@Callback_Colormap_Editor_input)
              function Callback_Colormap_Editor_input(thisH,~)
                  RGB = eval(uih(2).String);
                  Gamma = eval(uih(4).String);
                  check_rgbdata = isnumeric(RGB) && numel(RGB)==3 && isnumeric(Gamma) && numel(Gamma) ==1;
                  if check_rgbdata
                      obj.ChannelsColor(oh.UserData,:) = RGB;
                      obj.ChannelsGamma(oh.UserData,:) = Gamma;
                      oh.BackgroundColor = RGB;
                      close(thisH.Parent)
                  else
                      error('input Color data is not Correct....')
                  end
              end
          end
          
          function imh = ReSetUpSliceViewer
              [SliceImage,SliceReso] = obj.GetCurrentImage('Slice');
              SliceValue = 0;
              znum = size(SliceImage,3);
              tnum = size(SliceImage,4);              
              NowSlice = GetIndex_slider(H.Slider(1));
              NowTime = GetIndex_slider(H.Slider(2));
              
              SliceImage = SliceImage(:,:,NowSlice,NowTime,GetSelectedChannels);
              
              cdata = GetChannelsData(SliceImage,GetSelectedChannels);
              
              A = rgbproj_v2(SliceImage,cdata);            
              imh = imagescReso(H.Axes,A,SliceReso);
              uistack(imh,'bottom')
              H.Axes.Position(2) = 0.01;
              H.Axes.Tag = 'Axes';
              axis(H.Axes,'image')
%               axis(H.Axes,'off')
              if and(size(obj.Image,3) == 1,tnum>1)
                  H.Slider(1).Visible = 'off';
                  H.SliderText(1).Visible = 'off';
                  H.Slider(2).Value = SliceValue;
                  H.Slider(2).SliderStep = [1/(tnum-1) min(10,tnum)/(tnum-1)];                                    
                  H.Slider(2).UserData = tnum -1;
                  set(H.Slider(2),'Callback',@SetSliceView)
              end
              if and(size(obj.Image,4) == 1,znum>1)
                  H.Slider(2).Visible = 'off';
                  H.SliderText(2).Visible = 'off';
                  H.Slider(1).Value = SliceValue;
                  H.Slider(1).SliderStep = [1/(znum-1) min(10,znum)/(znum-1)];                                    
                  H.Slider(1).UserData = znum -1;
                  set(H.Slider(1),'Callback',@SetSliceView)
              end
              %%%%%%%%%%%% TO AVOID GPU Panick %%%%%%%%%%%%%
              H.Slider(1).Interruptible = 'off';
              H.Slider(2).Interruptible = 'off';
              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          end
          function ResetUpSEGviewSlice              
              if ishandle(H.SEGviewSlice_Line)
                  delete(H.SEGviewSlice_Line)
              end
              if ishandle(H.SEGviewSlice_Text)
                  delete(H.SEGviewSlice_Text)
              end 

              pdata = obj.Segment.Pointdata;
              % % % ID >0 are existing, ID <0 are deleted segment.
              catid = cat(1,pdata.ID);
              pdata = pdata(catid>0);

              MaximumLen = size(cat(1,pdata.PointXYZ),1);
              SegNum = length(pdata);
              MaxTimeData = size(pdata(1).Diameter,2);
              % % % main vaarrivel data %%
              cData = inf(MaximumLen+SegNum,MaxTimeData);
              XYZ = inf(MaximumLen+SegNum,3);
              Type = obj.SEGview_Type;
              c = uint32(1);
              for n = 1:length(pdata) 
                  if strcmpi(Type,'same')
                      D = ones(size(pdata(n).PointXYZ,1),MaxTimeData);
                  elseif strcmpi(Type,'Type')
                      len = size(pdata(n).PointXYZ,1);
                      switch pdata(n).Type
                          case 'End to End'
                              D = zeros(len,MaxTimeData);
                          case 'End to Branch'
                              D = ones(len,MaxTimeData);
                          case 'Branch to Branch'
                              D = ones(len,MaxTimeData) *2;
                          otherwise
                              D = ones(len,MaxTimeData) * 3;
                      end
                  elseif strcmpi(Type,'Diameter')
                      D = pdata(n).Diameter;
                      D(isnan(D)) = -0.000001; %% Add 2019.07.13 for display Skeleton
                  elseif strcmpi(Type,'Signal')
                      D = pdata(n).Signal;
                  elseif strcmpi(Type,'Noise')
                      D = pdata(n).Noise;
                  elseif strcmpi(Type,'SNR')
                      D = pdata(n).Signal ./ pdata(n).Noise;
                  elseif strcmpi(Type,'SNRdb')
                      D = 10 * log10(pdata(n).Signal ./ pdata(n).Noise );
                  elseif strcmpi(Type,'Length')
                      D = repmat(pdata(n).Length,[size(pdata(n).PointXYZ,1),MaxTimeData]);
                  elseif strcmpi(Type,'AverageDiameter')
                      AD = nanmean(pdata(n).Diameter,1);
                      D = repmat(AD,[size(pdata(n).PointXYZ,1),1]);
                  elseif strcmpi(Type,'class')
                      D = nan([size(pdata(n).PointXYZ,1),MaxTimeData]);
                      cName = pdata(n).Class;
                      cName(cName==' ') = [];
                      switch lower(cName)
                          case {'sa'}
                              D(:) = 2;
                          case {'pa','art.'}
                              D(:) = 1;
                          case 'cap.'
                              D(:) = 0;
                          case {'pv','vein'}
                              D(:) = -1;
                          case 'sv'
                              D(:) = -2;
                          otherwise
                              D(:) = -3;
                      end
                  else
                      try
                          eval(['D = pdata(n).' Type ';'])                        
                          if isscalar(D)
                              D = repmat(D,[size(pdata(n).PointXYZ,1),MaxTimeData]);
                          end
                      catch err
                          disp(err.message)
                          error('Input View-Type is NOT Correct..')
                      end
                  end
                  if isempty(D)
                      D = nan(size(pdata(n).PointXYZ,1),MaxTimeData);
                  end
                  XYZ(c:c+size(D,1)-1,:) = pdata(n).PointXYZ-1;
                  XYZ(c+size(D,1),:) = nan;
                  cData(c:c+size(D,1)-1,:) = D; 
                  cData(c+size(D,1),:) = nan;
                  c = c+size(D,1)+1;
              end
              XYZ(isinf(cData),:) = [];
              cData(isinf(cData)) = [];
              Reso = obj.Segment.ResolutionXYZ;
              XYZ(:,1) = XYZ(:,1) *Reso(1);
              XYZ(:,2) = XYZ(:,2) *Reso(2);
              XYZ(:,3) = XYZ(:,3) *Reso(3);
              
              obj.SEGviewCData = cData;
              SEGviewH = patch(H.Axes,XYZ(:,1),XYZ(:,2),XYZ(:,3),cData(:,1));
              SEGviewH.Marker = obj.SEGview_Marker;
              SEGviewH.MarkerSize = obj.SEGview_MarkerSize;
              SEGviewH.LineWidth = obj.SEGview_LineWidth;
              SEGviewH.EdgeColor = 'interp';
              Seg = obj.Segment;
              Seg.Pointdata = pdata;
              SEGtxh = obj.ViewSupport.SEGview_Limit_text(H.Axes,Seg,'same');
              for k = 1:length(SEGtxh)
                  SEGtxh(k).Position(3) = 1;
                  SEGtxh(k).Color = [1 1 1];
                  SEGtxh(k).FontSize = 15;
                  SEGtxh(k).FontName = 'Times New Romman';
                  SEGtxh(k).FontWeight = 'bold';
                  uistack(SEGtxh(k),'top')
              end
              H.SEGviewSlice_Line = SEGviewH;
              H.SEGviewSlice_Text = SEGtxh;
          end          
          function SEGviewSlice_TextONOFFcheck
              ONOFF = obj.SEGviewSlice_TextONOFF;
              if ~ishandle(H.SEGviewSlice_Text)
                  return
              end
              txh = H.SEGviewSlice_Text;
              for k = 1:length(txh)
                  if strcmpi(ONOFF,'on')
                      txh(k).Visible = 'on';
                  else
                      txh(k).Visible = 'off';
                  end
              end
              
          end
          function cdata = GetChannelsData(data,NowChannels)
              cdata.Color = obj.ChannelsColor(NowChannels,:);
              cdata.Gamma = obj.ChannelsGamma(NowChannels,:);
              if strcmpi(obj.ChannelsCLimMode,'auto')
                  CLim = zeros(size(data,5),2);
                  for k = 1:size(data,5)                       
                      check = [...
                              min(data(:,:,:,:,k),[],'all'),...
                              max(data(:,:,:,:,k),[],'all'),...
                              ];                              
                      if diff(check)==0
                          check = [0 1];
                      end
                      CLim(k,:) = check;
                  end                  
              else
                  CLim = obj.ChannelsCLim(NowChannels,:);
              end
              cdata.CLim = CLim;
          end
          function A = GetIndex_slider(slh)
              if isempty(slh.UserData)
                  A = uint32(1);
              else
                  A = uint32(slh.Value * slh.UserData + 1);
              end
          end
          function A = GetSelectedChannels()
              uih = H.ChannelsChoise;
              ch = false(1,length(uih));
              for c = 1:length(uih)
                  if strcmpi('on',uih(c).Visible)
                      ch(c) = uih(c).Value;                      
                  end
              end
              A = find(ch);
              
          end
          function [MIPTYPE,DIM,NUM] = GetMIPOption
              aph = H.SliceViewerApply;
              ch = aph.UserData;              
              MIPTYPE = ch(1).String{ch(1).Value};
              DIM  = str2double(ch(2).String{ch(2).Value});
              NUM = str2double(ch(3).String);              
          end
          SetSliceView
          function SetSliceView(~,~)
              [SliceImage,SliceReso] = obj.GetCurrentImage('Slice');
              
              NowSlice = GetIndex_slider(H.Slider(1));
              NowTime = GetIndex_slider(H.Slider(2)); %% Segeditor is considered for 3D...
              
              NowChannels = GetSelectedChannels;
              [MIPType, Dim, Num] = GetMIPOption;
              SliceNumel = size(SliceImage,Dim);
              [SliceImage,XDir,YDir,Aspect] = obj.ImageProject2planeXY(SliceImage,Dim,SliceReso);
              H.Axes.XDir = XDir;
              H.Axes.YDir = YDir;              
              znum = size(SliceImage,3);
              zdata = 1:znum;             
              zind = and(zdata>=NowSlice,zdata<NowSlice+Num);
              tnum = size(SliceImage,4);
              tdata = 1:tnum;
              if ~isempty(NowChannels)     
                  tind = and(tdata>=NowTime,tdata<NowTime+Num);
                  projectionDim = max(3,Dim);
                  SliceImage = obj.Image2projection(...
                      SliceImage(:,:,zind,tind,NowChannels),MIPType,projectionDim); 
                  cdata = GetChannelsData(SliceImage,NowChannels);
                  SliceImage = rgbproj_v2(SliceImage,cdata);
              else
                  SliceImage = false([size(SliceImage,1:2),3]);
              end      
              imh.CData = SliceImage;
%               daspect(imh.Parent,Aspect)
%               daspect(imh.Parent,[1 1 1])
              if Dim==1
                  imh.YData = (0:size(obj.Image,2)-1).*obj.Resolution(2);
                  imh.XData = (0:size(obj.Image,3)-1).*obj.Resolution(3);
              elseif Dim ==2
                  imh.YData = (0:size(obj.Image,1)-1).*obj.Resolution(1);
                  imh.XData = (0:size(obj.Image,3)-1).*obj.Resolution(3);
              else
                  imh.YData = (0:size(obj.Image,1)-1).*obj.Resolution(1);
                  imh.XData = (0:size(obj.Image,2)-1).*obj.Resolution(2);
              end
                  
              IndexData.XYZ(Dim) = NowSlice;
              IndexData.SliderValue(Dim) = H.Slider(1).Value;
              if Dim <=3
                  H.SliderText(1).String = [...
                    num2str(NowSlice) '-' num2str(min(NowSlice+Num-1,znum))...
                    '/' num2str(SliceNumel) '='...
                    num2str((NowSlice-1)*SliceReso(Dim),'%.0f') '-' ...
                    num2str((min(NowSlice+Num-1,znum)-1)*SliceReso(Dim),'%.0f um') ];
              else
                  Reso = obj.Resolution;
                  H.SliderText(2).String = [...
                    num2str(NowTime) '-' num2str(min(NowTime+Num-1,tnum))...
                    '/' num2str(SliceNumel) '='...
                    num2str((NowTime-1)*Reso(Dim),'%.0f') '-' ...
                    num2str((min(NowTime+Num-1,tnum)-1)*Reso(Dim),'%.0f [a.u.]') ];
              end
              if H.RenderingRangeApply.Value
                  H.Slider(1).Enable = 'off';
                  Callback_RenderingRangeApplyFromSliceViewer(H.RenderingRangeApply)
                  H.Slider(1).Enable = 'on';
              end
              SetSEGviewSlice
          end
          function ChangeMIPDim(oh,~)
              SliceImage = obj.GetCurrentImage('Slice');
              [~, Dim, ~] = GetMIPOption;              
              znum = size(SliceImage,Dim);
              H.Slider(1).Value = IndexData.SliderValue(Dim);
              H.Slider(1).SliderStep = [1/(znum-1) 10/(znum-1)];                                    
              H.Slider(1).UserData = znum -1;
              OlderDim = oh.UserData;
              ROI_ChangeDim(OlderDim,Dim)
              SetSliceView
              Reset_SelectedPointView
              Reset_ImportBranchView
              oh.UserData = Dim;
              Change_SelectedLine
          end
          function SetSEGviewSlice
              if ~ishandle(H.SEGviewSlice_Line)
                  return
              end
              [MIPType, Dim, Num] = GetMIPOption; 
              if Dim ~=4
                  return
              end
              NowTime = GetIndex_slider(H.Slider(2)); %% Segeditor is considered for 3D...
              tnum = size(obj.Image,4);
              tdata = 1:tnum;
              tind = and(tdata>=NowTime,tdata<NowTime+Num);
              CData = obj.SEGviewCData;
              if size(CData,2)>=NowTime
                  CData = obj.Image2projection(...
                      CData(:,tind),MIPType,2); 
              else
                  CData = nan(size(CData(:,1),[1 2]));
              end
              H.SEGviewSlice_Line.CData = CData;
              drawnow
          end
          %% Panel 3
          H.RenderingThresholdEdit.String = num2str(0.3,'%.2f') ;
          H.RenderingFaceColorEdit.String = ['[' num2str([1,0,0],'%d,%d,%d') ']'];
          H.RenderingAlphaEdit.String = num2str(0.3,'%.2f');
          if strcmpi('with Volume',obj.ViewerType)
              ReSetUp3DRendering
          end
          set(H.RenderingResetup,'Callback',@Callback_RenderingResetup)
          set(H.RenderingFaceColorApply,'Callback',@Callback_RenderingFaceColorApply)
          set(H.RenderingAlphaApply,'Callback',@Callback_RenderingAlphaApply)
          set(H.RenderingRangeApply,'Callback',@Callback_RenderingRangeApplyFromSliceViewer)
          set(H.SEGview_textONOFF,'Callback',@Callback_SEGview_textONOFF)
          set(H.SEGview_BranchONOFF,'Callback',@Callback_SEGview_BranchONOFF)
          set(H.View3_XYZLimApply,'Callback',@Callback_RenderingRangeApplyFromEdit)
          H.SEGview_Selected =  [];
          H.SEGview_Selected2D =  [];
          H.SEGview_Line =  [];
          H.SEGview_Text =  [];
          H.SEGview_Branch =  [];
          H.SEGview_Branchtext =  [];
          ResetSEGview
          function ResetSEGview
              if ishandle(H.SEGview_Line)
                  delete(H.SEGview_Line)
              end
              if ishandle(H.SEGview_Branch)
                  delete(H.SEGview_Branch)
              end              
              SEGchoice = obj.Segment;
              catID = cat(1,SEGchoice.Pointdata.ID);
              SEGchoice.Pointdata = SEGchoice.Pointdata(catID>0);
              if size(obj.Image,4)>1
                  Pointdata = GetCurrentTimePdata( SEGchoice.Pointdata );
                  SEGchoice.Pointdata = Pointdata;
              end
              % % Segment
%               [PatchH,textH] = obj.ViewSupport.SEGview( H.View3DAxes, SEGchoice);
%               PatchH(1).EdgeColor = 'b';
              
              PatchH = obj.ViewSupport.SEGview_Limit(...
                  H.View3DAxes, SEGchoice,obj.SEGview_Type,[],[],[]);
              H.SEGview_Line =  PatchH;
              %% Selected Function%%%%%%%%
              Change_SelectedLine  
              %% %%%%%%%%%%%%%%%%%%%%%%%55
              Check_SEGview_text
              if isempty(H.SEGview_Text)
                  H.SEGview_textONOFF.Value = 0;
              end
              % % branch
              BranchPlot = obj.ViewSupport.SEGview_Limit(...
                  H.View3DAxes, SEGchoice,'Branch',[],[],[]);
              Check_SEGview_Branch
              H.SEGview_Branch =  BranchPlot;              
              Callback_SEGview_BranchONOFF(H.SEGview_BranchONOFF)
              
              % % SEG slie toriger
              if size(obj.Image,4)>1
                  ResetUpSEGviewSlice;                  
                  SEGviewSlice_TextONOFFcheck
              end              
          end
          function Check_SEGview_text(~,~)
              fprintf('## ## ## ## ## ## ## ## ## ## ## ## \n  Setting up SEG_view text\n')
              if max(ishandle(H.SEGview_Text))
                  delete(H.SEGview_Text)
              end
              if H.SEGview_textONOFF.Value == false
                  fprintf(' Nothing to do.\n## ## ## ## ## ## ## ## ## ## ## ## \n')
                  return
              end
              XLim = H.View3DAxes.XLim;
              YLim = H.View3DAxes.YLim;
              ZLim = H.View3DAxes.ZLim;
              SEG = obj.Segment;
              SEG.Pointdata = SEG.Pointdata(cat(1,SEG.Pointdata.ID)>0);
              
              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              obj.ViewSupport.SEGview_textLim = 10000;
              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              textH = obj.ViewSupport.SEGview_Limit_text(...
                  H.View3DAxes, SEG,obj.SEGview_Type,XLim,YLim,ZLim);
              H.SEGview_Text = textH;
              if isempty(textH)
                  warning('   Overflow Text Handels.')
                  fprintf(' Current Limit Number of SEGview(textH) is ')
                  fprintf([num2str(obj.ViewSupport.SEGview_textLim) '\n\n'])
              else
                  fprintf('  Drawing now...')
                  drawnow
                  fprintf('Done.\n\n')
              end
              fprintf('## ## ## ## ## ## ## ## ## ## ## ## \n')
          end
          function Check_SEGview_Branch(~,~)
              fprintf('## ## ## ## ## ## ## ## ## ## ## ## \n  Setting up SEGview Branch\n')
              if max(ishandle(H.SEGview_Branchtext))
                  delete(H.SEGview_Branchtext)
              end
              XLim = H.View3DAxes.XLim;
              YLim = H.View3DAxes.YLim;
              ZLim = H.View3DAxes.ZLim;
              SEG = obj.Segment;
              SEG.Pointdata = SEG.Pointdata(cat(1,SEG.Pointdata.ID)>0);
              textH = obj.ViewSupport.SEGview_Limit_text(...
                  H.View3DAxes, SEG,'Branch',XLim,YLim,ZLim);
              H.SEGview_Branchtext = textH;
              if isempty(textH)
                  warning('   Overflow Text Handels.')
                  fprintf(' Current Limit Number of SEGview(textH) is ')
                  fprintf([num2str(obj.ViewSupport.SEGview_textLim) '\n\n'])
              else
                  fprintf('  Drawing now...')
                  drawnow
                  fprintf('Done.\n\n')
              end
              fprintf('## ## ## ## ## ## ## ## ## ## ## ## \n')
          end
          
          function Change_SelectedLine(~,~)
              if ishandle(H.SEGview_Selected)
                  delete(H.SEGview_Selected)
              end
              if ishandle(H.SEGview_Selected2D)
                  delete(H.SEGview_Selected2D)
              end
              Index = GetIndex_TablePdata_inSelected;
              if numel(Index)~=1
                  warning('Selected Segment is Nothing or Not Single')
                  H.SEGview_Selected = [];
                  H.SEGview_Selected2D = [];
                  return
              end
              Reso = obj.Segment.ResolutionXYZ;
              xyz = obj.Segment.Pointdata(Index).PointXYZ;
              ph = obj.ViewSupport.xyz2plot(H.View3DAxes,xyz,Reso);
              ph.Marker = obj.SEGview_SelectedMarker;
              ph.MarkerSize = obj.SEGview_SelectedMarkerSize;
              ph.Color = obj.SEGview_SelectedLineColor;
              ph.LineWidth = obj.SEGview_SelectedLineWidth;
              ph.LineStyle = obj.SEGview_SelectedLineStyle;
              H.SEGview_Selected = ph;
              
              %% for 2D
              IndexSort = ROI_GetXYZ_IndexSort;
              xyz_real = (xyz-1).*Reso;
              [~,SliceReso] = obj.GetCurrentImage('slice');
%               xyz_slice = (xyz_real./SliceReso)+1;
              xyz_slice = xyz_real;
              xyz = xyz_slice(:,IndexSort);
              ph2d = plot(H.Axes,xyz(:,1),xyz(:,2));
              ph2d.Color = obj.SEGview_SelectedLineColor;
              ph2d.LineWidth = obj.SEGview_SelectedLineWidth;
              ph2d.Visible = obj.SEGview_SelectedLine2DVisible;
              ph2d.Marker = obj.SEGview_SelectedMarker;
              ph2d.MarkerSize = obj.SEGview_SelectedMarkerSize;            
              ph2d.LineStyle = obj.SEGview_SelectedLineStyle;
              H.SEGview_Selected2D = ph2d;              
          end
          
          function  fv = Image2fv(Image,Reso,Th)
              Image = single(Image);
              Image = Image - min(Image(:));
              Image = Image / max(Image(:));
              xdata = 1:size(Image,2);
              ydata = 1:size(Image,1);
              zdata = 1:size(Image,3);
              xdata = (xdata -1) * Reso(1);
              ydata = (ydata -1 ) * Reso(2);
              zdata = (zdata -1 ) * Reso(3);
              fv = isosurface(xdata,ydata,zdata,Image,Th);
          end     
          function ReSetUp3DRendering
              [VolumeImage,VolumeReso] = obj.GetCurrentImage('Volume');
              Th = str2double(H.RenderingThresholdEdit.String );
              siz = size(VolumeImage,[1,2,3,4]);
              siz = siz(1:3);
              VolumeReso = VolumeReso(1:3);
              VolumeReso([1,2]) =VolumeReso([2,1]) ; 
              warning('#####    ResolutionXYZ to YXZ.    ####')
              FOV = (siz-1) .* VolumeReso;
              H.View3_XLimEdit.String = ['[0, '  num2str(FOV(2),'%.1f') ']'];
              H.View3_YLimEdit.String = ['[0, '  num2str(FOV(1),'%.1f') ']'];
              H.View3_ZLimEdit.String = ['[0, '  num2str(FOV(3),'%.1f') ']'];
              siz = feval(class(obj.MaximumRenderingSize),siz);
              Rsiz = min(siz,obj.MaximumRenderingSize);
              VolumeClass = class(VolumeImage);
              
              if ndims(VolumeImage)==3
                  ResizeVolume = imresize3(single(VolumeImage),Rsiz,'cubic');
              elseif ismatrix(VolumeImage)                  
                  ResizeVolume = imresize3(single(padarray(VolumeImage,[0 0 1],0)),[Rsiz(1:2) 3],'cubic');
              end
              ResizeVolume = feval(VolumeClass,ResizeVolume);
              NewReso = FOV ./ (double(Rsiz) -1);  
              fv = Image2fv(ResizeVolume,NewReso,Th);
              if ismatrix(VolumeImage)
                  fv.vertices(:,3) = 1;
              end
                            
              fv = reducepatch(fv,obj.MaximumPatchFace);              
              H.VolumeView_patch = patch(H.View3DAxes,fv);
              H.VolumeView_patch.FaceColor = eval( H.RenderingFaceColorEdit.String);              
              H.VolumeView_patch.FaceAlpha = str2double(H.RenderingAlphaEdit.String);              
              view(H.View3DAxes,3),
              axis(H.View3DAxes,'tight'),
              daspect(H.View3DAxes,ones(1,3)),
              box(H.View3DAxes,'on'),
              grid(H.View3DAxes,'on'),
              H.VolumeView_patch.EdgeColor = 'none';
          end
          function Callback_RenderingResetup(oh,~)
              oh.Enable = 'off';
              fprintf('# # # # # # # # # # # # \n    Rendering...\n')
              drawnow
              try
                  Old_patch_handle = H.VolumeView_patch;                  
                  ReSetUp3DRendering                  
                  delete(Old_patch_handle)                  
              catch err
                  error(err.message)
              end
              drawnow
              fprintf('\n             ...  Done \n# # # # # # # # # # # # \n')
              oh.Enable = 'on';
          end
          function Callback_RenderingAlphaApply(~,~)
              H.VolumeView_patch.FaceAlpha = eval(H.RenderingAlphaEdit.String);
          end
          function Callback_RenderingFaceColorApply(~,~)
              H.VolumeView_patch.FaceColor = eval(H.RenderingFaceColorEdit.String);
          end
          function Callback_RenderingRangeApplyFromSliceViewer(oh,~)
              HSV = rgb2hsv(oh.BackgroundColor);
              oh.Enable = 'off';
              drawnow
              if oh.Value
                  HSV(3) = 0.7;
                  oh.String = 'View All';
              else
                  HSV(3) = 1;
                  oh.String = 'Set Axis Lim. from Slice Viewer.';
              end
              oh.BackgroundColor = hsv2rgb(HSV);
              % % main % % 
              if oh.Value == 0
                  axis(H.View3DAxes,'tight')
              else
                  Reso = obj.Resolution(1:3);
                  Dim1Lim = H.Axes.XLim  ; % Image dot is in half of pixels position(= *.5);
                  Dim2Lim = H.Axes.YLim  ;
%                   Dim1Lim(1) = Dim1Lim(1) - 1.0;
%                   Dim2Lim(1) = Dim2Lim(1) - 1.0;              
                  ch = H.SliceViewerApply.UserData;
                  Dim = eval(ch(2).String{ch(2).Value});
                  Dim3Num = eval(ch(3).String);
                  Dim3Lim = GetIndex_slider(H.Slider(1)) -0.5;
                  Dim3Lim(2) = min( Dim3Lim(1) + Dim3Num ,size(obj.Image,Dim)+0.5);
                  switch Dim
                      case 1
                          XLim = Dim1Lim;
                          YLim = Dim3Lim;
                          ZLim = Dim2Lim;                      
                      case 2
                          XLim = Dim3Lim;
                          YLim = Dim2Lim;
                          ZLim = Dim1Lim;
                      case 3
                          XLim = Dim1Lim;
                          YLim = Dim2Lim;
                          ZLim = Dim3Lim;
                      otherwise
                          error('Input Dimmention is NOT supported.')
                  end
%                   keyboard
%                   H.View3DAxes.XLim = (XLim-1) * Reso(2);
%                   H.View3DAxes.YLim = (YLim-1) * Reso(1);
%                   H.View3DAxes.ZLim = (ZLim-1) * Reso(3);
                  
                  H.View3DAxes.XLim = XLim;
                  H.View3DAxes.YLim = YLim;
                  H.View3DAxes.ZLim = (ZLim-1) * Reso(3);

                  
                  
              end
              %% SEGview text Handle
              if H.SEGview_textONOFF.Value
                  check_texthandle_inSEG(H.SEGview_textONOFF)
              end
              if H.SEGview_BranchONOFF.Value
                  check_texthandle_inSEG(H.SEGview_BranchONOFF)
              end
              drawnow
              oh.Enable = 'on';                         
          end
          
          function Callback_SEGview_textONOFF(oh,~)
              oh.Enable = 'off';drawnow
              if oh.Value
                  check_texthandle_inSEG(oh)
              else
                  delete(H.SEGview_Text)
                  H.SEGview_Text = [];
              end
              drawnow;oh.Enable = 'on';
          end
          function Callback_SEGview_BranchONOFF(oh,~)
              %%% Debag Sugashi %%%
              oh.Enable = 'off';drawnow
              if oh.Value
                  check_texthandle_inSEG(oh)                                    
              else
                  delete(H.SEGview_Branchtext)
                  H.SEGview_Branchtext = [];                  
              end 
              if ~isempty(H.SEGview_Branchtext)
                  H.SEGview_Branch.Visible =  'on';
              else
                  H.SEGview_Branch.Visible =  'off';
              end
              drawnow;oh.Enable = 'on';
          end
          function check_texthandle_inSEG(h)
              fprintf('#### #### #### #### #### \n')
              fprintf('    Check text handle ....\n Reset text Handles for Graphics\n')
              SEG = obj.Segment;
              catID = cat(1,SEG.Pointdata.ID);
              SEG.Pointdata = SEG.Pointdata(catID>0);
              if strcmpi(h.String,'SEG text')
                  Check_SEGview_text
                  if isempty(H.SEGview_Text)
                      h.Value = 0;
                  end
              elseif strcmpi(h.String,'Branch')
                  Check_SEGview_Branch
                  if isempty(H.SEGview_Branchtext)
                      h.Value = 0;                      
                  end                  
              end                            
              fprintf('    Done Check text handle ....\n Reseted text Handles for Graphics\n')
              fprintf('#### #### #### #### #### \n')
          end  
          function Callback_RenderingRangeApplyFromEdit(~,~)
              XLim = eval(H.View3_XLimEdit.String);
              YLim = eval(H.View3_YLimEdit.String);
              ZLim = eval(H.View3_ZLimEdit.String);
              set(H.View3DAxes,'XLim',XLim,'YLim',YLim,'ZLim',ZLim)
          end
          H.View3DAxes.Projection = obj.VolumeViewProjection;
          
      %% Menu
          H.MenuH = obj.add_specialized_menu_for_segeditor(FigureH,H,H.MenuH);
          set(H.MenuH.Panel2_SegSelectionApply,'Callback',@MenuCallback_SegSelectionApply)
          set(H.MenuH.File_Save2WS,'Callback',@CallbackMenu_ExportToWS)
          set(H.MenuH.File_Save2Dir,'Callback',@CallbackMenu_SaveToDir)
          function CallbackMenu_ExportToWS(~,~)
              SEG = obj.Segment;
              export2wsdlg({'Export to WS'},{'EditSEG'},{SEG},'Save Segment data');
          end
          function CallbackMenu_SaveToDir(~,~)
              EditSEG = obj.Segment;
              uisave('EditSEG','Input_Save_Name')
          end

          function MenuCallback_SegSelectionApply(oh,~)              
              fprintf('################################################################\n')
              if strcmpi(oh.Checked,'on')
                  oh.Checked = 'off';                  
                  fprintf('   This function apply Slider value and setting up Slice Viewer\n')
                  fprintf('   in Selected a Segment(Pointdata Table).\n')
                  warning('       Default is "on".')
              else
                  oh.Checked = 'on';
              end
              fprintf(['\n    ' oh.Label ' : ' oh.Checked '\n\n'])
              fprintf('################################################################\n')
          end
          set(H.MenuH.Panel1_SegmentDensity_Depth,...
              'Callback',@Callback_CheckDensityInDepth)
          function Callback_CheckDensityInDepth(oh,~)
              ColumnName = strcmpi(H.Table_Pdata.ColumnName,'Z');
              zData = cell2mat(H.Table_Pdata.Data(:,ColumnName));              
              figure('Name',oh.Label)
              axh = axes;
              hist(axh,zData)
              grid(axh,'on')
              xlabel('Z-Axis(Depth) [um]')
              ylabel('Frequency of Segment.[#]')
          end
          
          
          set(H.MenuH.Panel1_SegmentDensity_Type,...
              'Callback',@Callback_CheckDensityInType)
          function Callback_CheckDensityInType(oh,~)
              ColumnName = strcmpi(H.Table_Pdata.ColumnName,'Type');
              TypeData = H.Table_Pdata.Data(:,ColumnName);
              E2E = sum(strcmpi(TypeData,'E2E'));
              E2B = sum(strcmpi(TypeData,'E2B'));
              B2B = sum(strcmpi(TypeData,'B2B'));
              ELSE = length(TypeData) - E2E - E2B - B2B;
              
              figure('Name',oh.Label)
              axh = axes;
              bar(axh,[E2E E2B B2B ELSE])
              axh.XTickLabel = {...
                  'End to End';...
                  'End to Branch';
                  'Branch to Branch';
                  'Others'};
              axh.XTickLabelRotation = -60;
              text(1-.2,E2E+axh.YLim(2)/30,['#' num2str(E2E)])
              text(2-.2,E2B+axh.YLim(2)/30,['#' num2str(E2B)])
              text(3-.2,B2B+axh.YLim(2)/30,['#' num2str(B2B)])
              text(4-.2,ELSE+axh.YLim(2)/30,['#' num2str(ELSE)])
              grid(axh,'on')              
              ylabel('Frequency of Segment.[#]')
          end
          
          
          set(H.MenuH.Panel1_InputSelect,'Callback',@Callback_InputSelect)
          function Callback_InputSelect(~,~)
              ColumnName = H.Table_Pdata.ColumnName;
              SelectedID = H.Table_Pdata.Data(:,strcmpi(ColumnName,'Select'));              
              EditData = struct('Indices',[]);
              EditData.Indices = find(cell2mat(SelectedID));
              Input = inputdlg({'Input "Select"'},'Input "Select"',1,...
                  {num2str(EditData.Indices),'Select'});
              if isempty(Input)
                  return
              end
              Input = eval(Input{1});               
              catID = cell2mat(H.Table_Pdata.Data(:,strcmpi(ColumnName,'ID')));
              if isempty(find(catID == Input))
                  error('Input ID is NOT Existing....')
              end
              Index = [find(catID==Input) find(strcmpi(ColumnName,'Select')) ];
              
              EditData.Indices = Index;
              Callback_CellEdit_Pdata(H.Table_Pdata,EditData)
          end
          
          set(H.MenuH.Panel1_InputEdit,'Callback',@Callback_InputEdit)
          function Callback_InputEdit(~,~)
              ColumnName = H.Table_Pdata.ColumnName;
%               SelectedID = H.Table_Pdata.Data(:,strcmpi(ColumnName,'Edit'));              
%               EditData = struct('Indices',[]);
%               EditData.Indices = find(cell2mat(SelectedID));
              Input = inputdlg({'Input "Edit"'},'Input "Edit"',1,...
                  {'[   ]','Select'});
              if isempty(Input)
                  return
              end
              Input = eval(Input{1});               
              catID = cell2mat(H.Table_Pdata.Data(:,strcmpi(ColumnName,'ID')));
              
              if max(isempty(find(catID == Input)))
                  error('Input ID is NOT Existing....')
              end
              for n = 1:length(Input)
                  p = find(catID==Input(n));
                  if isempty(p)
                      continue
                  end
                  Index = [p, find(strcmpi(ColumnName,'Edit')) ];                  
                  H.Table_Pdata.Data{Index(1),Index(2)} = true;
              end
              DDD = H.Table_Pdata.Data;             
              p = cell2mat(DDD(:,Index(2)));
              H.Table_Pdata.Data = cat(1,DDD(p,:),DDD(~p,:));
              drawnow
              
              
          end
          
          
          
          set(H.MenuH.Panel2_SegSelectionVisible_ON,...
              'Callback',@Callback_SegSelectionVisible,...
              'Checked','on')
          set(H.MenuH.Panel2_SegSelectionVisible_OFF,...
              'Callback',@Callback_SegSelectionVisible)
          function Callback_SegSelectionVisible(oh,~)
              H.SEGview_Selected2D.Visible =  lower(oh.Label);
              obj.SEGview_SelectedLine2DVisible = lower(oh.Label);
              if strcmpi('on',oh.Label)
                  H.MenuH.Panel2_SegSelectionVisible_ON.Checked = 'on';
                  H.MenuH.Panel2_SegSelectionVisible_OFF.Checked = 'off';
              else
                  H.MenuH.Panel2_SegSelectionVisible_ON.Checked = 'off';
                  H.MenuH.Panel2_SegSelectionVisible_OFF.Checked = 'on';
              end
          end
          
          set(H.MenuH.Panel3_AxesProjection_orthographic,...
              'Callback',@Callback_3DAxesProcjetion)
          set(H.MenuH.Panel3_AxesProjection_perspective,...
              'Callback',@Callback_3DAxesProcjetion)
          function Callback_3DAxesProcjetion(oh,~)
              H.View3DAxes.Projection = lower(oh.Label);
              obj.VolumeViewProjection = lower(oh.Label);
              if strcmpi(oh.Label,'perspective')
                  H.MenuH.Panel3_AxesProjection_perspective.Checked = 'on';
                  H.MenuH.Panel3_AxesProjection_orthographic.Checked = 'off';
              else
                  H.MenuH.Panel3_AxesProjection_perspective.Checked = 'off';
                  H.MenuH.Panel3_AxesProjection_orthographic.Checked = 'on';
              end
          end
          
          set(H.MenuH.Panel3_CheckBeardInView,'Callback',@Callback_CheckBeardInView)
          function Callback_CheckBeardInView(oh,~)              
              if isempty(H.SEGview_Text)
                  fprintf('Plese check on SEG text.')
                  return
              else
                  txh = H.SEGview_Text;
              end
              SEG = obj.Segment;
              catID = cat(1,SEG.Pointdata.ID) > 0;
              SEG.Pointdata = SEG.Pointdata(catID);
              catID = cat(1,SEG.Pointdata.ID);
              BeardID = [];
              if strcmpi(oh.Label,'Check Beard in View')                  
                  for n = 1:length(txh)
                      chid = str2double(get(txh(n),'String'));
                      index = catID == chid;
                      Type = SEG.Pointdata(index).Type;
                      if strcmpi(Type,'End to Branch')
                          BeardID = [BeardID chid];
                      end
                  end
              elseif strcmpi(oh.Label,'Check ALL in View')                  
                  for n = 1:length(txh)
                      chid = str2double(get(txh(n),'String'));                      
                      BeardID = [BeardID chid];                      
                  end
              else
              end
             
              if isempty(BeardID)
                  fprintf('   Empty type of "End to Branch".')
              end
              
              prompt = {'Checking Beard(End to Branch) Segment(s).'};
              name = 'Input and check Number(s).';
              numlines = 1;
              defaultans = {num2str(BeardID),'ID Numbers'};
              OPT.Resize = 'on';
              Ans = inputdlg(prompt,name,numlines,defaultans,OPT);
              
              if isempty(Ans)
                  return
              else
                  IDs = str2num(Ans{:});
                  Columname = H.Table_Pdata.ColumnName;
                  catID = H.Table_Pdata.Data(:,strcmpi(Columname,'ID'));                  
                  catID = cell2mat(catID);
                  NewData = H.Table_Pdata.Data;
                  for k = 1:length(IDs)
                      NewData{find(catID == IDs(k)),strcmpi(Columname,'Edit')} = true;
                  end
                  catEdit = cell2mat(NewData(:,strcmpi(Columname,'Edit')));
                  NewData = cat(1,NewData(catEdit,:),NewData(~catEdit,:));
                  H.Table_Pdata.Data = NewData;
              end              
          end
          
          set(H.MenuH.Panel3_CheckAllInView,'Callback',@Callback_CheckBeardInView)
         
          
          
          %% SEGview label
          for n = 1:length(H.MenuH.SEGviewLabel)
              set(H.MenuH.SEGviewLabel(n),'Callback',@Callback_SEGviewLabel)
          end
          function Callback_SEGviewLabel(oh,~)
              for nc = 1:length(H.MenuH.SEGviewLabel)                  
                 if strcmp(H.MenuH.SEGviewLabel(nc).Label,oh.Label)
                     H.MenuH.SEGviewLabel(nc).Checked = 'on';
                 else
                     H.MenuH.SEGviewLabel(nc).Checked = 'off';
                 end
              end
              obj.SEGview_Type = oh.Label;
              if size(obj.Image,4)>1
                 ResetUpSEGviewSlice;
                 SEGviewSlice_TextONOFFcheck
              end                
              if and(size(obj.Image,3)>=1,strcmp(obj.ViewerType,'with Volume'))
                  ResetSEGview
              end
          end
          
          set(H.MenuH.Panel2_SEGviewSliceTextONOFF(1),'Callback',@Callback_SEGviewSliceTextONOFF)
          set(H.MenuH.Panel2_SEGviewSliceTextONOFF(2),'Callback',@Callback_SEGviewSliceTextONOFF)
          function Callback_SEGviewSliceTextONOFF(oh,~)
              H.MenuH.Panel2_SEGviewSliceTextONOFF(1).Checked = 'off';
              H.MenuH.Panel2_SEGviewSliceTextONOFF(2).Checked = 'off';
              oh.Checked = 'on';
              obj.SEGviewSlice_TextONOFF = oh.Label;
              SEGviewSlice_TextONOFFcheck
          end
          
      end
      %% SUPPURT FUNCTION
      function Pdata = SEGEditor_ChangeBranchPosition(obj,Pdata,P1,P2)
          if size(P1,1) ~= size(P2,1)
              errorr('Input Size is NOT equal')
          end
          %Threshold = obj.SEGEditor_ChangeMinimumVoxelsSize;
          for k = 1:size(P1,1)
              Before = P1(k,:);
              After = P2(k,:);
              for n = 1:length(Pdata)
                  Branch = Pdata(n).Branch;
                  if isnan(Branch(1))
                      continue
                  end
                  %Ind = find(sum(abs(Branch - Before)>Threshold,2)==3);
                  Ind = find(sum(Branch == Before,2)==3);
                  if isempty(Ind)
                      continue
                  end                  
                  Branch(Ind,:) = After;
                  Pdata(n).Branch = Branch;
                  xyz = Pdata(n).PointXYZ;
                  Ind = find(sum(xyz == Before,2)==3);
                  if isempty(Ind)
                      continue
                  end
                  xyz(Ind,:) = After;
                  Pdata(n).PointXYZ = xyz;                  
              end
          end
      end            
      function [Image,Reso] = GetCurrentImage(obj,Type)
          % [Image,Reso] = GetCurrentImage(obj,{'Slice' or 'Volume'})
          switch lower(Type)
              case 'slice'
                  RequestName = obj.SliceViewCurrentDataName;
              case 'volume'
                  RequestName = obj.VolumeViewCurrentDataName;
          end
          
          switch RequestName
              case 'Original'
                  Image = obj.Image;
                  Reso = obj.Resolution(1:3);
              case 'Enhanced'
                  data = obj.ImageProcessed;
                  Image = data.Image;
                  Reso = data.Resolution;
              otherwise
                  struct_Image_data = obj.ImageProcessed;
                  len = length(struct_Image_data);
                  if isempty(len)
                      error('Requested Image( NOT ORIGINAL) data does not exist....')
                  end
                  c = 1;
                  TF = true;
                  while TF
                      try
                          check_name = struct_Image_data(c).Name;
                      catch err
                          disp(err.message)
                          error('Requested Extra mode image not Exist....')
                      end                      
                      if strcmpi(RequestName,check_name)
                          Image = struct_Image_data(c).Image;
                          Reso = struct_Image_data(c).Resolution;
                          TF = false;
                      else
                          c = c + 1;
                      end
                  end
          end   
      end      
      function output = Image2projection(obj,Image,MIPType,Dim)
          switch MIPType
              case {'max','min'}
                  Image = feval(MIPType,Image,[],Dim);
              case {'average'}
                  Image = mean(Image,Dim);
              case 'Median'
                  Image = median(Image,Dim);
              case 'SD'
                  Image = std(single(Image),[],Dim);                  
              otherwise
                  error('Please edito new type projection menu.')
          end
          output = Image;          
      end
      function [Image,XDir,YDir,Aspect] = ImageProject2planeXY(obj,Image,Dim,Reso)
          switch Dim
              case {1}
                  Image = permute(Image,[3,2,1,4,5]);
                  YDir = 'normal';
                  XDir = 'normal';
                  Aspect = [Reso(3)/Reso(2), 1, 1];
              case {2}
                  Image = permute(Image,[1,3,2,4,5]);
                  YDir = 'reverse';
                  XDir = 'reverse';
                  Aspect = [1, Reso(3)/Reso(1), 1];
              case {3,4}
                  YDir = 'reverse';
                  XDir = 'normal';
                  Aspect = [1, Reso(1)/Reso(2), 1];
              otherwise
                  error('input Dim. is NOT Correct')
          end
%           Image = squeeze(Image);    
      end
      function Index = ID2Index(obj,ID)
          catID = cat(1,obj.Segment.Pointdata.ID);
          Index = find(catID==ID);
      end
      %% Menu for segeditor
      function MenuHandle = add_specialized_menu_for_segeditor(obj,fgh,GUIHandles,MenuHandle)
          MenuHandle.File.Enable = 'on';
%           MenuHandle.Data.Enable = 'off';
          MenuHandle.View.Enable = 'on';
          MenuHandle.Edit.Enable = 'on';          
%           MenuHandle.Panel3.Enable = 'off';
        %% File 
          MenuHandle.File_Save2WS = uimenu(MenuHandle.File,...
              'Label','Export to Work Space');
          MenuHandle.File_Save2Dir = uimenu(MenuHandle.File,...
              'Label','Save to Directory');
          SavePic = uimenu(MenuHandle.File,'Label','Save Picture');
          uimenu(SavePic,'Label','FigureView','Callback',@Callback_SavePic)
          uimenu(SavePic,'Label','SliceView','Callback',@Callback_SavePic)
          uimenu(SavePic,'Label','VolumeView','Callback',@Callback_SavePic)
          function Callback_SavePic(oh,~)
              disp(oh.Label)
              disp('Select Save Directory')
              FullPath = uigetdir();
              if isempty(FullPath)
                  return
              end
              Names = inputdlg({'Input file name'},'Input tif name',1,{'Picture.tif'});
              
              if isempty(Names)
                  return
              end
              Names = Names{1};
              switch oh.Label
                  case 'FigureView'
                      saveas(fgh,[FullPath filesep Names])
                  case 'SliceView'
                      im=getframe(GUIHandles.Axes);
                      imwrite(im.cdata,[FullPath filesep Names])
                  case 'VolumeView'
                      im=getframe(GUIHandles.Panel(3));
                      imwrite(im.cdata,[FullPath filesep Names])
              end
          end
          
        %% Edit
          uimh = uimenu(MenuHandle.Edit,'Label','Colormap');
          Clabel = {'ColormapRed','ColormapBlue','ColormapGreen',...
                'Class map',...
                'gray','parula','kjet','kjetw','jet','hsv','hot','cool','spring',...
                'summer','autumn','winter','bone','copper','pink','lines',...
                'flag'};
          for n = 1:length(Clabel)
              h = uimenu(uimh,'Label',Clabel{n},'Callback',@Callback_Colormap);
          end
          function Callback_Colormap(oh,~)
              if strcmpi('Class map',oh.Label)
                  ts = tsmaps;
                  fgh.Colormap = ts.class_map;
              else
                  fgh.Colormap = feval(oh.Label,256);
              end
          end
          
          uimh = uimenu(MenuHandle.Edit,'Label','SEGview Label');
          SEGviewLabel = {...
                    'same'                   ;
                    'Type'                   ;
                    'Diameter'               ;
                    'Length'                 ;
                    'class'                  ;
                    'AverageDiameter'        ;
                    'Signal'                 ;
                    'Noise'                  ;
                    'SNR'                    ;
                    'Theta'                  ;
                    'NormThetaXY'            ;
                    'Fai_AngleFromAxisZ'     ;
                    'AnalysisShoudBeElliptic'};
         for n = 1:size(SEGviewLabel,1)
             MenuHandle.SEGviewLabel(n) = uimenu(uimh,'Label',SEGviewLabel{n});
         end
         %% SEGview Slice Text
         uimh = uimenu(MenuHandle.Panel2,'Label','SEGview Slice Text');
         MenuHandle.Panel2_SEGviewSliceTextONOFF(1) = uimenu(uimh,'Label','on',...
             'Checked','on');
         MenuHandle.Panel2_SEGviewSliceTextONOFF(2) = uimenu(uimh,'Label','off');
%          if size(obj.Image,4)==1
%              uimh.Enable = 'off';
%          end
        %% for program editor...
          uimenu(MenuHandle.Sample,...
              'Label','print Object Fields','Callback',@Callback_printobj,...
              'Separator','on');
          function Callback_printobj(~,~)
              disp(obj)
          end
          uimenu(MenuHandle.Sample,...
              'Label','print GUI Handls','Callback',@Callback_printGUIHandles);
          function Callback_printGUIHandles(~,~)              
              disp(GUIHandles)
          end
          uimenu(MenuHandle.Sample,...
              'Label','print Menu Handls','Callback',@Callback_printMenuHandles);
          function Callback_printMenuHandles(~,~)
              disp(MenuHandle)
          end
          
          uimenu(MenuHandle.Sample,...
              'Label','Editors MEMO(Sugashi)','Callback',@Callback_SugashiMEMO,...
              'Separator','on');
          ch = MenuHandle.Sample.Children;
          for n = 1:length(ch)
              if strcmpi(ch(n).Text,'Edit as Developer')
                  set(ch(n),'Callback',@Callback_DeveloperMode)
              end
          end
          function Callback_DeveloperMode(~,~)
              inputstr = inputdlg('Developer Mode Password :',...
                  'Password',1);
              if ~strcmpi(inputstr{1},'sugashi')
                  return
              else
                  fprintf(['==============================\n',...
                      '     Welcome to Developer Mode. \n'...
                      '==============================\n'])                  
                  keyboard
              end
          end
          
          function Callback_SugashiMEMO(~,~)
              memofigure = obj.GUISupport.SetupEditorsMemo('SegEditor','Sugashi');
              uistack(memofigure,'top')
          end
      end
   end
end
























classdef Sugashi_Segment_v1p51
   properties
      Name(1,:) char
      Resize(1,:) char {mustBeMember(Resize,{'on','off'})} = 'on'
      Value
      Image(:,:,:,:) {mustBeNumeric}
      ImageProcesed %% will be structure having fields, "Name","Image","Resolution"..
      Resolution(1,3) % Resolution order is [Y, X, Z] 
      % % Panel 1= Segment data
      PreSEG % it mean Pre-Segment data
      Segment % Segmented Data
      Draw1SEGdata(:,1) = []% = Sugashi_ROI
      ROIdata
      CurrentSegmentNumber(1,1)
      % % Panel 2 = Slice Image Viewer 
      MaxChannels(1,1) uint8 {mustBeReal, mustBeFinite,mustBeLessThanOrEqual(MaxChannels,12)}  = 12;%% will be for tracking
      Channels(1,1) uint8 {mustBeReal, mustBeFinite} = 1
      ChannelsColor(1,3) double {mustBeReal,mustBeFinite,mustBeLessThanOrEqual(ChannelsColor,12)} = [1 1 .8];
      ChannelsGamma(1,1) double {mustBeReal,mustBeFinite,mustBeGreaterThan(ChannelsGamma,0)} = 1;
      ChannelsCLim(1,2) double {mustBeReal,mustBeFinite} = [0 255];
      ChannelsCLimMode(1,:) char {mustBeMember(ChannelsCLimMode,{'auto','manual'})} = 'auto'
      SEG_CheckLineColor(1,3) double = [0.5, 0.5, 1.0]
      SEG_CheckLineWidth(1,1) double = 9;
      SEG_CheckPointColor(1,3) double = [0.5, 0.8, 1]
      SEG_CheckPointMarker(1,:) char {mustBeMember(SEG_CheckPointMarker,{'o','^','x','s'})} = 's'
      SEG_CheckPointMarkerSize(1,1)  double = 8
      SEG_CheckPointLineWidth(1,1)  double = 3
      SEGEditor_ChangeMinimumVoxelsSize(1,1) double = 0.01;
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
      MaximumRenderingSize(1,1) uint16{mustBeReal} = 128;
      GUIHandles
      Tag
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
          fprintf('--------------------------------------------\n')
          obj.Image = VC;
      end
      function obj = set.Resolution(obj,v)
          fprintf('#### Setting up Resolution file. ################\n')
          disp(['    class : ' class(v)])
          disp(['    numel :(' num2str(v,'%.2f %.2f %.2f') ') [um/voxels]'])
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
          %% Pointdata
          Pdata = SEG.Pointdata;
          if ~isfield(Pdata,'Class')
              for n = 1:length(Pdata)
                  Pdata(n).Class = 'others'; 
              end
          end
          if ~isfield(Pdata,'Diameter')
              for n = 1:length(Pdata)
                  Pdata(n).Diameter = nan(size(Pdata(n).PointXYZ,1),1); 
              end
          end
          if ~isfield(Pdata,'MEMO')
              for n = 1:length(Pdata)
                  Pdata(n).MEMO = ' '; 
              end
          end
          if ~isfield(Pdata,'Signal')
              for n = 1:length(Pdata)
                  Pdata(n).Class = nan(size(Pdata(n).PointXYZ,1),1); 
              end
          end
          if ~isfield(Pdata,'Noise')
              for n = 1:length(Pdata)
                  Pdata(n).Diameter = nan(size(Pdata(n).PointXYZ,1),1); 
              end
          end
          if ~isfield(SEG,'BranchPointXYZ')
              SEG.BranchPointXYZ = SEG.BPmatrix(:,1:3);
          end          
          SEG.SegEditor = mfilename;
          SEG.Pointdata = Pdata;
          obj.Segment = SEG;            
      end
       %% Main Function
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
          if max(obj.Resolution == 0)
              warning('   Plese input Resolution.')
              return
          end
          obj.Image = flip(permute(obj.Image,[3 2 1]),1);
          axh = sliceviewer(obj);
          Reso = obj.Resolution;
          daspect(axh,[Reso(3)/Reso(2) 1 1])
          axh.Parent.Name = ['Slice Viewer(XZ): '  obj.Name];
      end
      function sliceviewerYZ(obj)
          if max(obj.Resolution == 0)
              warning('   Plese input Resolution.')
              return
          end
          obj.Image = flip(permute(obj.Image,[3 1 2]),1);
          axh = sliceviewer(obj);
          Reso = obj.Resolution;
          daspect(axh,[Reso(3)/Reso(2) 1 1])
          axh.Parent.Name = ['Slice Viewer(YZ): ' obj.Name];
      end
      function FigureH = segeditor(obj)          
          % Slice Viewer is able to view in Pixels Base.
          % Volume Viewer is Rendering as isosurface data(fv) as using
          % patch function.
          % Volume Viewer is able to view in Real Length Base(um);
          fprintf('\n\n\n')
          %% check Image Resolution
          if isempty(obj.Image) || max(obj.Resolution) == 0  || isempty(obj.PreSEG)
              error('Please Input Image ,Resolution, and Pre-Segmentdata.')
          end                   
          if isempty(obj.Segment)
              disp('Set up Segment data as PreSEG.')
              obj.Segment = obj.PreSEG;
          end
          Pdata = obj.Segment.Pointdata;
          GUI = Sugashi_GUI_support;
          ViewSupport = Sugashi_ReconstructGroup;
          H  = GUI.create_figure_segeditor(obj.MaxChannels);
          FigureH = H.figure;
          fprintf('Input Image data is disirable uint8 class as Image matrix....\n')
                    
      %% Default set up
          VersionNum = mfilename;
          IndVer = find(VersionNum == '_');
          VersionNum = VersionNum(IndVer(2)+2:end);
          VersionNum(VersionNum=='p') = '.';
          H.figure.Name = ['Segment Editor (ver. '  num2str(VersionNum,'%.1f')  ')'];
          H.figure.Colormap = gray(256);
          H.figure.Resize = obj.Resize;
          set(H.figure,'WindowButtonDownFcn',@WindowButtonFcn)
          set(H.figure,'WindowButtonUpFcn',@WindowButtonFcn)
          set(H.figure,'WindowKeyPressFcn',@WindowKeyFcn)
          set(H.figure,'WindowKeyReleaseFcn',@WindowKeyFcn)
          
          function WindowButtonFcn(ParentH,event)
              if H.Axes == gca &&  strcmpi(event.EventName,'WindowMousePress')
                 Type = get(H.figure,'SelectionType'); % normal,alt,extend,open
                 if strcmpi(Type,'extend') && H.SEG_DrawSEGPoint.Value                     
                     ROI = obj.Draw1SEGdata;                     
                     h = drawpoint(H.Axes);
                     if isempty(ROI)
                         ROI = h;
                     else
                         ROI = cat(1,ROI,h);
                     end
                     h.Label = num2str(length(ROI));
                     % XYZ
                     fprintf('Plese input XYZ drawpoint function.\n')
                     A = GetIndex_slider(H.Slider(1));
                     %XYZ = [];
                     h.UserData = A;
                     obj.Draw1SEGdata = ROI;
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
          
      %% Panels
          %% Panel 1
          Data = set_Table_Pdata(Pdata,obj.Segment.ResolutionXYZ);          
          set(H.Table_Pdata,'Data',Data)
          set(H.Table_Pdata,'CellEditCallback',@Callback_CellEdit_Pdata)
          set(H.Table_Pdata,'KeyPressFcn',@Callback_Pdata_KeyPressFcn)
          set(H.Table_Pdata,'CellSelectionCallback','')
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
          set(H.SEG_ConnectSEGPoint,'Callback',@Callback_SEG_ConnectSEGPoint)          
          set(H.SEG_SeparateSEGPoint,'Callback',@Callback_SEG_SeparateSEGPoint)
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
                      SELECTED = reshape( find(cell2mat(TableData(:,1))),1,[]);
                      fprintf(['Selected : #' num2str(SELECTED)  ' \n'])
                  case {'Class','Type','MEMO'}                      
                      fprintf([EditData.PreviousData '\n to \n' EditData.NewData '\n'])
                  case 'Select'
                      fprintf('    Setting up Point Data Table...')
                      TableData(:,Ind(2)) = {false};
                      TableData(Ind(1),Ind(2)) = {true};
                      oh.Data = TableData;
                      P = obj.Segment.Pointdata;                      
                      Data_xyz = set_Table_XYZ(P(Ind(1)),obj.Segment.ResolutionXYZ);
                      set(H.Table_XYZ,'Data',Data_xyz)
                      drawnow
                      %% panel 3 SEG view Line Color 
                      fprintf('Done \n    Setting up SEG view Line Color...')
                      for n = 1:length(H.SEGview_Line)
                          H.SEGview_Line(n).EdgeColor = 'interp';
                      end
                      ID = cell2mat(TableData(Ind(1),3));
                      H.SEGview_Line(ID).EdgeColor = 'b';
                      drawnow
                      fprintf('Done \n')
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
                      Reset_SelectedPointView
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
              % Set up New Pointdata 
              Pdata = obj.Segment.Pointdata;
              TableData = H.Table_Pdata.Data;
              ID = GetTableID(TableData);
              Pdata = Pdata(ID);
              % Refresh Pdata
              obj.Segment.Pointdata = Pdata;
              NewTableData = set_Table_Pdata(Pdata,obj.Segment.ResolutionXYZ);
              set(H.Table_Pdata,'Data',NewTableData)
              % Refresh PointXYZ table
              NewData = set_Table_XYZ(Pdata(1),obj.Segment.ResolutionXYZ);
              set(H.Table_XYZ,'Data',NewData)
              % Refresh SEG-view
              ResetSEGview
              drawnow
              fprintf('Done.\n============ ============ ============\n')
          end
          function ID = GetTableID(TableData)
              Selection = cell2mat(TableData(:,1));
              ID = cell2mat(TableData(:,3));
              ID = ID(~Selection);
          end
          function Callback_SEG_DrawSEGPoint(~,~)
              oh = H.SEG_DrawSEGPoint;
              if oh.Value
                  oh.BackgroundColor = [0 0.6 0];
                  oh.String = 'Drawing';
                  H.SEG_ImportSEGPoint.Enable = 'on';
                  H.SEG_ClearSEGPoint.Enable = 'on';
                  H.SEG_CheckSEGPoint.Enable = 'on';
                  H.SEG_ImportAsBranchPoint.Enable = 'on';
                  H.SEGEditor_BranchAddEnd.Enable = 'on';
                  H.SEGEditor_BranchAddFirst.Enable = 'on';
                  
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
              end
          end
          function Callback_SEG_ImportSEGPoint(~,~)
              oh = H.SEG_DrawSEGPoint;
              fprintf('############ ############ ############\n   Import Segment\n')
              Callback_SEG_CheckSEGPoint
              fprintf('AAA\n')
              Callback_SEG_ClearSEGPoint
              oh.Value = 0;
              Callback_SEG_DrawSEGPoint  
              fprintf('============ ============ ============ \n')
          end
          function ROI_ChangeDim(PreDim,ToDim)
              ROI = obj.Draw1SEGdata;
              if isempty(ROI) || PreDim == ToDim
                  return
              end
              IndexSort = ROI_GetIndexSort(PreDim);              
              for n = 1:length(ROI)
                  if ishandle(ROI(n))
                      Posi1 = ROI(n).Position;
                      Posi2 = ROI(n).UserData;
                      Posi = cat(2,Posi1,Posi2);
                      PosiXYZ = Posi(1,IndexSort);
                      if ToDim==1
                          ROI(n).Position = PosiXYZ([1,3]);
                          ROI(n).UserData = PosiXYZ(2);
                      elseif ToDim==2
                          ROI(n).Position = PosiXYZ([3,2]);
                          ROI(n).UserData = PosiXYZ(1);
                      elseif ToDim==3
                          ROI(n).Position = PosiXYZ([1,2]);
                          ROI(n).UserData = PosiXYZ(3);
                      end
                  end
              end
          end
          function xyz = ROI2Segment
              ROI = obj.Draw1SEGdata;
              xyz = [];
              if isempty(ROI)
                  return
              end
              IndexSort = ROI_GetIndexSort;              
              for n = 1:length(ROI)
                  if ishandle(ROI(n))
                      Posi1 = ROI(n).Position;
                      Posi2 = ROI(n).UserData;
                      Posi = cat(2,Posi1,Posi2);
                      xyz = cat(1,xyz,Posi);
                  end
              end
              xyz = xyz(:,IndexSort);
          end          
          function IndexSort = ROI_GetIndexSort(varargin)
              if nargin ==1
                  Dim = varargin{1};
              else
                  [~,Dim,~] = GetMIPOption;
              end
              if Dim==1
                  IndexSort = [1 3 2];
              elseif Dim==2
                  IndexSort = [3 2 1];
              elseif Dim==3
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
              obj.Draw1SEGdata = [];
          end
          function Callback_SEG_CheckSEGPoint(~,~)
              xyz = ROI2Segment;
              [~,Dim,~] = GetMIPOption;
              if ~isempty(xyz)                  
                  hold(H.Axes,'on')
                  hold(H.View3DAxes,'on')
                  if Dim==3
                      p = plot(H.Axes,xyz(:,1),xyz(:,2));
                  elseif Dim==2
                      p = plot(H.Axes,xyz(:,3),xyz(:,2));
                  elseif Dim==1
                      p = plot(H.Axes,xyz(:,1),xyz(:,3));
                  else
                      fprintf(['# # # # # # # # # # #\n' mfilename '\n Can''t recognaized Dimmension\n\n'])
                  end
                  p.LineWidth = obj.SEG_CheckLineWidth;
                  p.Color = obj.SEG_CheckLineColor;
                  for n = 1:5
                      p.Visible = 'off';drawnow
                      pause(.2)
                      p.Visible = 'on';drawnow
                      pause(.3)
                  end
                  delete(p)
              else
                  fprintf('    No point, or Not Drawing button.\n        Return\n')
              end
          end
          function Callback_SEG_ConnectSEGPoint(~,~)
              fprintf('SEG_ConnectSEGPoint\n')
          end
          function Callback_SEG_SeparateSEGPoint(~,~)
              fprintf('SEG_SeparateSEGPoint\n')
          end             
          function Callback_SEG_BranchAdd(oh,~)
              
              disp('SEG Branch Add')
              disp(oh.String)
          end
          Callback_ViewBranch
          function Callback_ViewBranch(~,~)
              fprintf('    ==== View Branch Callback....wait.')
              oh = H.SEGEditor_ViewBranch;              
              if oh.Value
                  oh.String = 'Viewing Branch';
                  oh.BackgroundColor = ones(1,3)*0.6;
                  H.Table_XYZ.Visible = 'off';
                  H.BranchTable_XYZ.Visible = 'on';
                  H.SEGEditor_BranchDelete.Enable = 'off';
                  H.SEGEditor_ApplyBranch.Enable = 'on';
              else
                  oh.String = 'View Branch Point';
                  oh.BackgroundColor = ones(1,3)*0.94;
                  H.Table_XYZ.Visible = 'on';
                  H.BranchTable_XYZ.Visible = 'off';
                  H.SEGEditor_BranchDelete.Enable = 'off';
                  H.SEGEditor_ApplyBranch.Enable = 'off';
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
              Data = cell(length(Pdata),12);          
              for n = 1:length(Pdata)
                  Data{n,1} = false;                           %'Edit',...
                  Data{n,2} = n == 1;                           %'Select',...
                  Data{n,3} = n ;                              %'ID',...
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
          Data = set_Table_XYZ(Pdata(1),obj.Segment.ResolutionXYZ);
          set(H.Table_XYZ,'Data',Data)          
          function Data = set_Table_XYZ(EachPointdata,Reso)
          % Table XYZ
          %{'Edit','X','Y','Z','Branch','Diameter','Signal','Noise','SNR',}
          % 1       2  3  4   5
          
              XYZ = EachPointdata.PointXYZ;
              Branch = EachPointdata.Branch;
              Diameter = EachPointdata.Diameter;
              Signal = EachPointdata.Signal;
              Noise = EachPointdata.Noise;
              % XYZ = EachPointdata.NewXYZ;
              Data = cell(size(XYZ,1),9);              
              for n = 1:length(XYZ)
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
              for n = 1:length(XYZ)
                  Data{n,1} = false;
                  Data{n,2} = (XYZ(n,1)-1) * Reso(1);
                  Data{n,3} = (XYZ(n,2)-1) * Reso(2);
                  Data{n,4} = (XYZ(n,3)-1) * Reso(3);
                  Data{n,5} = [];
              end          
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
              Ind = cell2mat(TableData(:,ColumnInd));
              X = cell2mat(TableData(:,ColumnXInd));
              Y = cell2mat(TableData(:,ColumnYInd));
              Z = cell2mat(TableData(:,ColumnZInd));
              xyz_Real = [X(Ind),Y(Ind),Z(Ind)];
              xyz_Voxel = xyz_Real ./ obj.Segment.ResolutionXYZ + 1;
              
              disp('main function for Selection callback for 1 point')
          end
          
          
          function Callback_WriteData2WS(~,~)
              SEG = obj.Segment;
              export2wsdlg({'Export to WS'},{'EditSEG'},{SEG},'Save Segment data');
          end
                    
          %% Panel 2
          imh = ReSetUpSliceViewer;
          H.SliceImageViewimagescHandle = imh;
          Mip_infoH = H.SliceViewerApply.UserData;
          set(Mip_infoH(4),'Callback',@SetSliceView)
          MIPDimH = Mip_infoH(2);
          set(MIPDimH,'Callback',@ChangeMIPDim)          
          IndexData.XYZ = [1 1 1];
          IndexData.SliderValue = [0 0 0];
          IndexData.MIPsH = Mip_infoH;
          for nn = 1:obj.MaxChannels
              set(H.ChannelsChoise(nn),'Callback',@ChannelsChoice_Single)
              set(H.ChannelsChoise(nn),'UserData',H.ChannelsChoise)
              set(H.ChannelsEditPush(nn),'Callback',@OpenChannelsEditor)
              if nn >1
                  set(H.ChannelsChoise(nn),'Visible','off')
                  set(H.ChannelsEditPush(nn),'Visible','off')
              end
          end
          DimH = H.SliceViewerApply.UserData;
          DimH(2).String = {'1', '2', '3'};
          
          function ChannelsChoice_Single(oh,~)
              OtherH = oh.UserData;
              for k = 1:length(OtherH)
                  OtherH(k).Value = 0;
              end
              oh.Value = 1;
          end
          function OpenChannelsEditor(oh,~)
              GUI = Sugashi_GUI_support;
              uih = GUI.SpectrumColormapEditor;
              uih(6).Visible = 'on';
              uih(6).String = 'Apply map';              
              set(uih(6),'Callback',@Callback_Colormap_Editor_input)
              function Callback_Colormap_Editor_input(thisH,~)
                  RGB = eval(uih(2).String);
                  Gamma = eval(uih(4).String);
                  check_rgbdata = isnumeric(RGB) && numel(RGB)==3 && isnumeric(Gamma) && numel(Gamma) ==1;
                  if check_rgbdata
                      obj.ChannelsColor = RGB;
                      obj.ChannelsGamma = Gamma;
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
              SliceImage = SliceImage(:,:,NowSlice,NowTime);
              
              cdata = GetChannelsData(SliceImage);              
              A = rgbproj_v2(SliceImage,cdata);            
              imh = imagesc(H.Axes,A);
              H.Axes.Position(2) = 0.01;
              H.Axes.Tag = 'Axes';
              axis(H.Axes,'image')
              axis(H.Axes,'off')
              if size(obj.Image,3) == 1
                  H.Slider(1).Visible = 'off';
                  H.SliderText(1).Visible = 'off';
                  H.Slider(2).Value = SliceValue;
                  H.Slider(2).SliderStep = [1/(tnum-1) 10/(tnum-1)];                                    
                  H.Slider(2).UserData = tnum -1;
                  set(H.Slider(2),'Callback',@SetSliceView)
              end
              if size(obj.Image,4) == 1
                  H.Slider(2).Visible = 'off';
                  H.SliderText(2).Visible = 'off';
                  H.Slider(1).Value = SliceValue;
                  H.Slider(1).SliderStep = [1/(znum-1) 10/(znum-1)];                                    
                  H.Slider(1).UserData = znum -1;
                  set(H.Slider(1),'Callback',@SetSliceView)
              end
          end
          function cdata = GetChannelsData(SliceImage)
              cdata.Color = obj.ChannelsColor;
              cdata.Gamma = obj.ChannelsGamma;              
              if strcmpi(obj.ChannelsCLimMode,'auto')
                  cdata.CLim = [min(SliceImage(:)) max(SliceImage(:))];
              else
                  cdata.CLim = obj.ChannelsCLim;
              end
          end
          function A = GetIndex_slider(slh)
              if isempty(slh.UserData)
                  A = uint32(1);
              else
                  A = uint32(slh.Value * slh.UserData + 1);
              end
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
              NowTime = GetIndex_slider(H.Slider(2)); %% Segeditor is considered for 3D.
              [MIPType, Dim, Num] = GetMIPOption;              
              SliceImage = SliceImage(:,:,:,NowTime);
              SliceNumel = size(SliceImage,Dim);
              [SliceImage,XDir,YDir,Aspect] = obj.ImageProject2planeXY(SliceImage,Dim,SliceReso);
              H.Axes.XDir = XDir;
              H.Axes.YDir = YDir;              
              zdata = 1:size(SliceImage,3);
              zind = and(zdata>=NowSlice,zdata<NowSlice+Num);              
              SliceImage = obj.Image2projection(SliceImage(:,:,zind),MIPType,3);              
              cdata = GetChannelsData(SliceImage);              
              imh.CData = rgbproj_v2(SliceImage,cdata);
              daspect(imh.Parent,Aspect)
              IndexData.XYZ(Dim) = NowSlice;
              IndexData.SliderValue(Dim) = H.Slider(1).Value;
              H.SliderText(1).String = [num2str(NowSlice) '-' num2str(NowSlice+Num-1) '/' num2str(SliceNumel) ];
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
              oh.UserData = Dim;
          end
          
          %% Panel 3
          ReSetUp3DRendering
          set(H.RenderingRangeApply,'Callback',@Callback_RenderingRangeApplyFromSliceViewer)
          set(H.SEGview_textONOFF,'Callback',@Callback_SEGview_textONOFF)
          H.SEGview_Line =  [];
          H.SEGview_Text =  [];
          ResetSEGview
          function ResetSEGview
              if ishandle(H.SEGview_Line)
                  delete(H.SEGview_Line)
              end
              if ishandle(H.SEGview_Text)
                  delete(H.SEGview_Text)
              end
              [PatchH,textH] = ViewSupport.SEGview( H.View3DAxes, obj.Segment);
              PatchH(1).EdgeColor = 'b';
              H.SEGview_Line =  PatchH;
              H.SEGview_Text =  textH;
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
              Th = 0.3;
              siz = size(VolumeImage);
              FOV = (siz-1) .* VolumeReso;
                siz = feval(class(obj.MaximumRenderingSize),siz);
              Rsiz = min(siz,obj.MaximumRenderingSize);
              ResizeVolume = imresize3(VolumeImage,Rsiz,'cubic');
              NewReso = FOV ./ (double(Rsiz) -1);  
              fv = Image2fv(ResizeVolume,NewReso,Th);
              p = patch(H.View3DAxes,fv);
              p.FaceColor = 'r';
              p.FaceAlpha = 0.3;
              view(H.View3DAxes,3),
              axis(H.View3DAxes,'tight'),
              daspect(H.View3DAxes,ones(1,3)),
              box(H.View3DAxes,'on'),
              grid(H.View3DAxes,'on'),
              p.EdgeColor = 'none';
          end
          function Callback_RenderingRangeApplyFromSliceViewer(oh,~)
              Reso = obj.Resolution;
              Dim1Lim = H.Axes.XLim  ; % Image dot is in half of pixels position(= *.5);
              Dim2Lim = H.Axes.YLim  ;
              Dim1Lim(1) = Dim1Lim(1) - 1.0;
              Dim2Lim(1) = Dim2Lim(1) - 1.0;              
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
              H.View3DAxes.XLim = (XLim-1) * Reso(2);
              H.View3DAxes.YLim = (YLim-1) * Reso(1);
              H.View3DAxes.ZLim = (ZLim-1) * Reso(3);
              
              %% SEGview text Handle
              for n = 1:length(H.SEGview_Text)
                  txh = H.SEGview_Text(n);
                  TF = H.View3DAxes.XLim(1) <= txh.Position(1) && ...
                       H.View3DAxes.XLim(2) >= txh.Position(1) && ...
                       H.View3DAxes.YLim(1) <= txh.Position(2) && ...
                       H.View3DAxes.YLim(2) >= txh.Position(2) && ...
                       H.View3DAxes.ZLim(1) <= txh.Position(3) && ...
                       H.View3DAxes.ZLim(2) >= txh.Position(3) ;
                  if TF
                      txh.Visible = 'on';
                  else
                      txh.Visible = 'off';
                  end
              end
          end
          function Callback_SEGview_textONOFF(oh,~)
              if oh.Value
                  Type = 'on';
              else
                  Type = 'off';
              end
              for nt = 1:length(H.SEGview_Text)
                  H.SEGview_Text(nt).Visible = Type;
              end
          end
          
     %% setappdata
          setappdata(FigureH,'Object',obj)
          
      %% Menu
          H.MenuH = obj.add_specialized_menu_for_segeditor(FigureH,H,H.MenuH);
          
      end
      function output = segtracker(obj,varargin)
          nargin
          output = obj.segeditor;
          H = output.GUIHandles;
          for nn = 1:obj.MaxChannels
              set(H.ChannelsChoise(nn),'Visible','on')
              set(H.ChannelsEditPush(nn),'Visible','on')
          end

          
          
          
      end
      
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
                  Reso = obj.Resolution;
              otherwise
                  struct_Image_data = obj.ImageProcesed;
                  len = length(struct_Image_data);
                  if isempty(len)
                      error('Requested Image data does not exist....')
                  end
                  c = 1;
                  TF = false;
                  while TF
                      check_name = struct_Image_data(c).Name;
                      if strcmpi(RequestName,check_name)
                          Image = struct_Image_data(c).Image;
                          Reso = struct_Image_data(c).Resolution;
                      else
                          c = c + 1;
                      end
                  end
          end          
      end
      
      function output = Image2projection(obj,Image,MIPType,Dim)
          switch MIPType
              case {'max','min'}
                  Image = squeeze(feval(MIPType,Image,[],Dim));
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
          Image = squeeze(Image);    
      end
      %% Menu for segeditor
      function MenuHandle = add_specialized_menu_for_segeditor(obj,fgh,GUIHandles,MenuHandle)
        %% File 
        %% Edit

          MenuHandle.ImageProcessing = uimenu(MenuHandle.Edit,...
              'Label','Image Processing');
          MenuHandle.MedianFilter = uimenu(MenuHandle.ImageProcessing,...
              'Label','Median Filter(2D)',...
              'Callback',@Callback_ImageProcessing);
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
            %% Image Processing
          function Callback_ImageProcessing(oh,~)
              disp(oh.Label)
          end
      end
      function tsMedfilt2(dummy1,dummy2)
      end
      
   end
end
























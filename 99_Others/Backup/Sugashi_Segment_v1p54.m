classdef Sugashi_Segment_v1p54
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
      Draw1SEGdata(:,1) = []% = drawpoint(handles)
      ImportBranchPosition_Real(2,3) = nan(2,3) % First or End
      ROIdata
      CurrentSegmentNumber(1,1)
      % % Panel 2 = Slice Image Viewer 
      MaxChannels(1,1) uint8 {mustBeReal, mustBeFinite,mustBeLessThanOrEqual(MaxChannels,12)}  = 12;%% will be for tracking
      Channels(1,1) uint8 {mustBeReal, mustBeFinite} = 1
      ChannelsColor(1,3) double {mustBeReal,mustBeFinite,mustBeLessThanOrEqual(ChannelsColor,12)} = [1 1 .8];
      ChannelsGamma(1,1) double {mustBeReal,mustBeFinite,mustBeGreaterThan(ChannelsGamma,0)} = 1;
      ChannelsCLim(1,2) double {mustBeReal,mustBeFinite} = [0 255];
      ChannelsCLimMode(1,:) char {mustBeMember(ChannelsCLimMode,{'auto','manual'})} = 'auto'
      SEG_CheckLineColor(1,3) double = [0.3, 0.5, 1.0]
      SEG_CheckLineStyle(1,:) char {mustBeMember(SEG_CheckLineStyle,{'-','--',':','-.','none'})} = '--'
      SEG_CheckLineWidth(1,1) double = 4;
      SEG_CheckPointColor(1,3) double = [0.3, 1.0, 0.3]
      SEG_CheckPointMarker(1,:) char {mustBeMember(SEG_CheckPointMarker,{'o','^','x','s'})} = 's'
       %Marker  {'+' | 'o' |'*' | '.' | 'x' | 'square' | 'diamond' | 'v' |
       %         '^' | '>' | '<' |'pentagram' | 'hexagram' | 'none'}
      SEG_CheckPointMarkerSize(1,1)  double = 8
      SEG_CheckPointLineWidth(1,1)  double = 3
      SEG_CheckImportPointColor(1,3) double = [0.8, 0.7, 0.1]
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
      %%
      ViewSupport = Sugashi_ReconstructGroup
      GUISupport = Sugashi_GUI_support
      SEGFcn = Segment_Functions
      MovingAverage = @TS_MovingAverage
      xyz2Interp = @TS_xyzInterp
      ReSegment = @TS_ReSEG
      ChaseSegment
      
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
          Segment_FuncH = Segment_Functions;
          obj.Segment = Segment_FuncH.set_Segment(SEG);            
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
      function H = segeditor(obj)          
          % Slice Viewer is able to view in Pixels Base.
          % Volume Viewer is Rendering as isosurface data(fv) as using
          % patch function.
          % Volume Viewer is able to view in Real Length Base(um);
          %% check Image Resolution
          fprintf('\n # # # # # # # # # # # # # # # # # # # # # # # # # # #\n')
          if isempty(obj.Image) || max(obj.Resolution) == 0  || isempty(obj.PreSEG)
              error('Please Input Image ,Resolution, and Pre-Segmentdata.')
          end                   
          if isempty(obj.Segment)
              disp('Set up Segment data as PreSEG.')
              obj.Segment = obj.PreSEG;
          end
          Pdata = obj.Segment.Pointdata;                  
          H  = obj.GUISupport.create_figure_segeditor(obj.MaxChannels);
          FigureH = H.figure;
          fprintf('Input Image data is disirable uint8 class as Image matrix....\n\n')
                    
      %% Default set up
          VersionNum = mfilename;
          IndVer = find(VersionNum == '_');
          VersionNum = VersionNum(IndVer(2)+2:end);
          VersionNum(VersionNum=='p') = '.';
          H.figure.Name = ['Segment Editor (ver. '  num2str(VersionNum,'%.1f')  ')'];
          H.figure.Colormap = gray(256);
          H.figure.Resize = obj.Resize;
          fprintf(['    Starting :' H.figure.Name '\n\n\n'])
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
                     % XYZ                     
                     A = GetIndex_slider(H.Slider(1));
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
          
      %% Panels
          %% Panel 1          
          Data = set_Table_Pdata(obj.Segment.Pointdata,obj.Segment.ResolutionXYZ);          
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
          set(H.SEG_ConnectSEGPoint,'Callback',@Callback_SEG_ReSegment)          
          set(H.SEG_SeparateSEGPoint,'Callback',@Callback_SEG_ReSegment)
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
                      ID = cell2mat(TableData(Ind(1),strcmpi(oh.ColumnName,'ID')));
                      Index = obj.ID2Index(ID);
                      P = obj.Segment.Pointdata;                      
                      Data_xyz = set_Table_XYZ(P(Index),obj.Segment.ResolutionXYZ);
                      set(H.Table_XYZ,'Data',Data_xyz)
                      drawnow
                      %% panel 3 SEG view Line Color 
                      fprintf('Done \n    Setting up SEG view Line Color...')
                      for n = 1:length(H.SEGview_Line)
                          H.SEGview_Line(n).EdgeColor = 'interp';
                      end
                      
                      H.SEGview_Line(ID).EdgeColor = 'b';
                      drawnow
                      fprintf('Done \n')
                      %% Panel 2, Slice Viewr Slider
                      if strcmpi(H.MenuH.Panel2_SegSelectionApply.Checked,'on')
                          fprintf('    Set up Slider Value...\n')
                          
                          xyz = obj.Segment.Pointdata(Index).PointXYZ;
                          xyz_real = (xyz-1) .* obj.Segment.ResolutionXYZ ;
                          xyz_2Dviewer = (xyz_real ./ obj.Resolution)+1;
                          Index_sort = ROI_GetXYZ_IndexSort;
                          Index = xyz_2Dviewer(:,Index_sort(3));
                          znum = H.Slider(1).UserData;
                          if znum > 1
                              Maximum = max(Index);
                              Minimum = min(Index);
                              AddNumel = 1;
                              Thickness = ceil(Maximum) - floor(Minimum)+1 + AddNumel;
                              Slice = max(floor(Minimum)-1 - AddNumel,0);
                              H.Slider(1).Value = Slice/(znum-1);
                              MIPNUMH = H.SliceViewerApply.UserData;
                              MIPNUM = MIPNUMH(3);
                              MIPNUM.String = num2str(Thickness);
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
              NewPdata = obj.Segment.Pointdata;
              %%%TableData = H.Table_Pdata.Data;
              %%%ID = GetTableID_forDeleteSegments(TableData);
              %%%Pdata = Pdata(ID);
              ID = GetID_TablePdata_inEdit;
              Pdata_catID = cat(1,obj.Segment.Pointdata.ID);
              for x = 1:length(ID)
                  NewPdata(Pdata_catID==ID(x)).ID = abs(NewPdata(Pdata_catID==ID(x)).ID) * (-1); 
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
              ResetSEGview
              drawnow
              fprintf('Done.\n============ ============ ============\n')
          end
          function ID = GetTableID_forDeleteSegments(TableData)
              Selection = cell2mat(TableData(:,1));
              ID = cell2mat(TableData(:,3));
              ID = ID(~Selection);
          end
          function ID = GetID_TablePdata_inEdit
              ColumnName = (H.Table_Pdata.ColumnName);
              EditInd = strcmpi(ColumnName,'Edit');
              Ind = cell2mat(H.Table_Pdata.Data(:,EditInd));
              IDInd = strcmpi(ColumnName,'ID');
              ID =  cell2mat(H.Table_Pdata.Data(:,IDInd));
              ID = ID(Ind);
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
              PointData = obj.Segment.Pointdata(Pdata_catID==ID)
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
              xyz_Real = (xyz_Voxels - 1) .* obj.Resolution;
              xyz_SEGVoxels = xyz_Real ./ obj.Segment.ResolutionXYZ + 1;
              disp(num2str(xyz_SEGVoxels,4))
              Copy_Pointdata = obj.Segment.Pointdata(1);              
              if sum(isnan(Branch(:,1))) == 0
                  Type = 'End to End';
              elseif sum(isnan(Branch(:,1))) == 1
                  Type = 'End to Branch';
              elseif sum(isnan(Branch(:,1))) == 2
                  Type = 'Branch to Branch';
              end
              SEGReso = obj.Segment.ResolutionXYZ;
              Copy_Pointdata.PointXYZ = xyz_SEGVoxels;
              Copy_Pointdata.Type = Type;
              Copy_Pointdata.Length = sum(xyz2plen(xyz_SEGVoxels,SEGReso));
              Copy_Pointdata.Branch = Branch;
              Copy_Pointdata.Signal = single(nan(size(xyz_SEGVoxels,1),1));
              Copy_Pointdata.Noise = single(nan(size(xyz_SEGVoxels,1),1));
              Copy_Pointdata.Diameter = single(nan(size(xyz_SEGVoxels,1),1));
              Copy_Pointdata.NewXYZ = single(nan(size(xyz_SEGVoxels,1),1));
              Copy_Pointdata.Class = 'ohters';
              Copy_Pointdata.MEMO = ['Drawed ' date];
              obj.Segment.Pointdata(end+1) = Copy_Pointdata;
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
              Branch = Branch ./ obj.Resolution + 1;
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
              xyz_Real = (xyz_Voxels-1) .* obj.Resolution;
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
                      NewSEG = obj.ReSegment(obj.Segment,'Connect',{ID});
                  elseif strcmpi(oh.String,'Separate')
                      [SelectedID,separate_index] = check_Selected_Index;
                      if isempty(SelectedID) || isempty(separate_index)
                          error('Please Select one point at least.')
                      end
                      NewSEG = obj.ReSegment(obj.Segment,'Separate',SelectedID,separate_index);
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
                  oh.String = 'Viewing Branch';
                  oh.BackgroundColor = ones(1,3)*0.6;
                  H.Table_XYZ.Visible = 'off';
                  H.BranchTable_XYZ.Visible = 'on';
                  H.SEGEditor_BranchDelete.Enable = 'off';
                  H.SEGEditor_ApplyBranch.Enable = 'on';
                  H.SEG_SeparateSEGPoint.Enable = 'off';
              else
                  oh.String = 'View Branch Point';
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
          Reset_ImportBranchView
          function Reset_ImportBranchView
              Branch_Real = obj.ImportBranchPosition_Real;
              View2D_Reso = obj.Resolution;
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
              View2D_Reso = obj.Resolution;
              xyz_Voxel = xyz_Real ./ View2D_Reso + 1;
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
              uih = obj.GUISupport.SpectrumColormapEditor;
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
              uistack(imh,'bottom')
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
              if H.RenderingRangeApply.Value
                  H.Slider(1).Enable = 'off';
                  Callback_RenderingRangeApplyFromSliceViewer(H.RenderingRangeApply)
                  H.Slider(1).Enable = 'on';
              end
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
          end
          
          %% Panel 3         
          H.RenderingThresholdEdit.String = num2str(0.3,'%.2f') ;
          H.RenderingFaceColorEdit.String = ['[' num2str([1,0,0],'%d,%d,%d') ']'];
          H.RenderingAlphaEdit.String = num2str(0.3,'%.2f');
          ReSetUp3DRendering
          set(H.RenderingResetup,'Callback',@Callback_RenderingResetup)
          set(H.RenderingFaceColorApply,'Callback',@Callback_RenderingFaceColorApply)
          set(H.RenderingAlphaApply,'Callback',@Callback_RenderingAlphaApply)
          set(H.RenderingRangeApply,'Callback',@Callback_RenderingRangeApplyFromSliceViewer)
          set(H.SEGview_textONOFF,'Callback',@Callback_SEGview_textONOFF)
          set(H.SEGview_BranchONOFF,'Callback',@Callback_SEGview_BranchONOFF)
          set(H.View3_XYZLimApply,'Callback',@Callback_RenderingRangeApplyFromEdit)
          H.SEGview_Line =  [];
          H.SEGview_Text =  [];
          H.SEGview_Branch =  [];
          H.SEGview_Branchtext =  [];
          ResetSEGview
          function ResetSEGview
              if ishandle(H.SEGview_Line)
                  delete(H.SEGview_Line)
              end
              if ishandle(H.SEGview_Text)
                  delete(H.SEGview_Text)
              end
              if ishandle(H.SEGview_Branch)
                  delete(H.SEGview_Branch)
              end
              if ishandle(H.SEGview_Branchtext)
                  delete(H.SEGview_Branchtext)
              end
              SEGchoice = obj.Segment;
              catID = cat(1,SEGchoice.Pointdata.ID);
              SEGchoice.Pointdata = SEGchoice.Pointdata(catID>0);
              % % Segment
              [PatchH,textH] = obj.ViewSupport.SEGview( H.View3DAxes, SEGchoice);
              PatchH(1).EdgeColor = 'b';
              H.SEGview_Line =  PatchH;
              H.SEGview_Text =  textH;
              % % branch
              [BranchPlot,BtextH] = obj.ViewSupport.SEGview( H.View3DAxes, SEGchoice,'Branch');
              H.SEGview_Branch =  BranchPlot;
              H.SEGview_Branchtext =  BtextH;
              Callback_SEGview_BranchONOFF(H.SEGview_BranchONOFF)
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
              siz = size(VolumeImage);
              VolumeReso([1,2]) =VolumeReso([2,1]) ; 
              warning('#####    ResolutionXYZ to YXZ.    ####')
              FOV = (siz-1) .* VolumeReso;
              H.View3_XLimEdit.String = ['[0, '  num2str(FOV(2),'%.1f') ']'];
              H.View3_YLimEdit.String = ['[0, '  num2str(FOV(1),'%.1f') ']'];
              H.View3_ZLimEdit.String = ['[0, '  num2str(FOV(3),'%.1f') ']'];
              siz = feval(class(obj.MaximumRenderingSize),siz);
              Rsiz = min(siz,obj.MaximumRenderingSize);
              ResizeVolume = imresize3(VolumeImage,Rsiz,'cubic');
              NewReso = FOV ./ (double(Rsiz) -1);  
              fv = Image2fv(ResizeVolume,NewReso,Th);
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
              end
              %% SEGview text Handle
              if H.SEGview_textONOFF.Value
                  check_texthandle_inSEG(H.SEGview_Text)
              end
              if H.SEGview_BranchONOFF.Value
                  check_texthandle_inSEG(H.SEGview_Branchtext)
              end
              drawnow
              oh.Enable = 'on';                         
          end
          
          function Callback_SEGview_textONOFF(oh,~)
              if oh.Value
                  check_texthandle_inSEG(H.SEGview_Text)
              else
                  for nt = 1:length(H.SEGview_Text)
                      H.SEGview_Text(nt).Visible = 'off';
                  end
              end
          end
          function Callback_SEGview_BranchONOFF(oh,~)              
              if oh.Value
                  Type = 'on';
                  check_texthandle_inSEG(H.SEGview_Branchtext)                  
                  H.SEGview_Branch.Visible =  Type;
              else
                  Type = 'off';
                  H.SEGview_Branch.Visible =  Type;                  
                  for nt = 1:length(H.SEGview_Branchtext)
                      H.SEGview_Branchtext(nt).Visible = Type;
                  end
              end              
          end
          function check_texthandle_inSEG(h)
              for n = 1:length(h)
                  txh = h(n);
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
          function Callback_RenderingRangeApplyFromEdit(~,~)
              XLim = eval(H.View3_XLimEdit.String);
              YLim = eval(H.View3_YLimEdit.String);
              ZLim = eval(H.View3_ZLimEdit.String);
              set(H.View3DAxes,'XLim',XLim,'YLim',YLim,'ZLim',ZLim)
          end
          
     %% setappdata
          setappdata(FigureH,'Object',obj)
          
      %% Menu
          H.MenuH = obj.add_specialized_menu_for_segeditor(FigureH,H,H.MenuH);
          set(H.MenuH.Panel2_SegSelectionApply,'Callback',@MenuCallback_SegSelectionApply)
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
                          TF = true;
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
      function Index = ID2Index(obj,ID)
          catID = cat(1,obj.Segment.Pointdata.ID);
          Index = find(catID==ID);
      end
      %% Menu for segeditor
      function MenuHandle = add_specialized_menu_for_segeditor(obj,fgh,GUIHandles,MenuHandle)
          MenuHandle.File.Enable = 'off';
          MenuHandle.Data.Enable = 'off';
          MenuHandle.View.Enable = 'off';
          MenuHandle.Edit.Enable = 'off';
          MenuHandle.Panel1.Enable = 'off';
          MenuHandle.Panel3.Enable = 'off';
        %% File 
        %% Edit
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
      end
   end
end
























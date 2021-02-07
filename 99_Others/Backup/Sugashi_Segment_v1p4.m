classdef Sugashi_Segment_v1p4
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
      CurrentSegmentNumber(1,1)
      % % Panel 2 = Slice Image Viewer 
      MaxChannels(1,1) uint8 {mustBeReal, mustBeFinite,mustBeLessThanOrEqual(MaxChannels,12)}  = 12;%% will be for tracking
      Channels(1,1) uint8 {mustBeReal, mustBeFinite} = 1
      ChannelsColor(1,3) double {mustBeReal,mustBeFinite,mustBeLessThanOrEqual(ChannelsColor,12)} = [1 1 .8];
      ChannelsGamma(1,1) double {mustBeReal,mustBeFinite,mustBeGreaterThan(ChannelsGamma,0)} = 1;
      ChannelsCLim(1,2) double {mustBeReal,mustBeFinite} = [0 255];
      ChannelsCLimMode(1,:) char {mustBeMember(ChannelsCLimMode,{'auto','manual'})} = 'auto'
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
        %%  Segeditor
        %                       figure: [1×1 Figure]
        %                        Panel: [1×3 Panel]
        %                  ControllerA: [1×1 Panel]
        %                ViewSEG_Pdata: [1×1 Panel]
        %                  Table_Pdata: [1×1 Table]
        %                    Table_XYZ: [1×1 Table]
        %               Table_Tracking: [1×1 Table]
        %                  ControllerB: [1×1 Panel]
        %                         Axes: [1×1 Axes]
        %                       Slider: [1×2 UIControl]
        %                   SliderText: [1×2 UIControl]
        %     SliceViewerChannelsPanel: [1×1 Panel]
        %                ChanelsChoice: [1×1 UIControl]
        %             ChannelsEditPush: [1×1 UIControl]
        %                  ProjectionH: [1×1 Panel]
        %             SliceViewerApply: [1×1 UIControl]
        %                  ControllerC: [1×1 Panel]
        %                    Rendering: [1×1 Panel]
        %                  View3DPanel: [1×1 Panel]
        %                   View3DAxes: [1×1 Axes]
        %                        MenuH: [1×1 struct]
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
          Pdata = SEG.Pointdata;
          if ~isfield(Pdata,'Class')
              for n = 1:length(Pdata)
                  Pdata(n).Class = 'others'; 
              end
          end
          if ~isfield(Pdata,'Diameter')
              for n = 1:length(Pdata)
                  Pdata(n).Diameter = nan; 
              end
          end
          if ~isfield(Pdata,'MEMO')
              for n = 1:length(Pdata)
                  Pdata(n).MEMO = ' '; 
              end
          end
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
          H  = GUI.create_figure_segeditor(obj.MaxChannels);
          FigureH = H.figure;
          fprintf('Input Image data is disirable uint8 class as Image matrix....\n')
                    
      %% Default set up
          H.figure.Name = 'Segment Editor (ver.1.3)';
          H.figure.Colormap = gray(256);
          H.figure.Resize = obj.Resize;
      %% Panels
          %% Panel 1
          Data = set_Table_Pdata(Pdata);          
          set(H.Table_Pdata,'Data',Data)
          function Data = set_Table_Pdata(Pdata)   
  % Table Pointdata = Pre- Segment
  % selection, Class, Centrod X, Y, Z, Edit, diameter, Length, Type, MEMO
  % 1          2             3   4  5   6       7         8     9      10 
              Data = cell(length(Pdata),10);          
              for n = 1:length(Pdata)
                  Data{n,1} = n == 1;
                  Data{n,2} = Pdata(n).Class;
                  Data{n,3} = mean(Pdata(n).PointXYZ(:,1),1);
                  Data{n,4} = mean(Pdata(n).PointXYZ(:,2),1);
                  Data{n,5} = mean(Pdata(n).PointXYZ(:,3),1);
                  Data{n,6} = false;
                  Data{n,7} = mean(Pdata(n).Diameter,1);
                  Data{n,8} = Pdata(n).Length;
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
                  Data{n,9} = Type;
                  Data{n,10} = Pdata(n).MEMO;
              end          
          end                    
          Data = set_Table_XYZ(Pdata(1).PointXYZ,Pdata(1).Branch,obj.Segment.ResolutionXYZ);
          set(H.Table_XYZ,'Data',Data)
          function Data = set_Table_XYZ(XYZ,Branch,Reso)
          % Table XYZ
          % Branch, X, Y, Z, Edit
          % 1       2  3  4   5

              Data = cell(size(XYZ,1),5);  
              for n = 1:length(XYZ)
                  len = TS_EachLengthMap2(Branch,XYZ(n,:),Reso);
                  Data{n,1} = min(len(:)) == 0;
                  Data{n,2} = (XYZ(n,1)-1) * Reso(1);
                  Data{n,3} = (XYZ(n,2)-1) * Reso(2);
                  Data{n,4} = (XYZ(n,3)-1) * Reso(3);
                  Data{n,5} = false;
              end          
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
              SetSliceView              
          end
          
          %% Panel 3
          ReSetUp3DRendering
          set(H.RendringRangeApply,'Callback',@Callback_RenderingRangeApplyFromSliceViewer)
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
              view(3),axis('tight'),daspect(ones(1,3)),
              box on,grid on
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
          end
                             
      %% Menu
          H.MenuH = obj.add_specialized_menu_for_segeditor(FigureH,H.MenuH);
          
     %% setappdata
          setappdata(FigureH,'Object',obj)
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
      function MenuHandle = add_specialized_menu_for_segeditor(obj,fgh,MenuHandle)
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
              Object = getappdata(fgh ,'Object');
              disp(Object.GUIHandles)
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
























classdef Sugashi_Segment_v1p2
   properties
      Name(1,:) char
      Resize(1,:) char {mustBeMember(Resize,{'on','off'})} = 'on'
      Value
      Image(:,:,:,:) {mustBeNumeric}
      ImageProcessing %% will be structure having fields, "Name","Image","Resolution"..
      Resolution(1,3)
      % % Panel 1= Segment data
      PreSEG % it mean Pre-Segment data
      Segment % Segmented Data
      CurrentSegmentNumber(1,1)
      % % Panel 2 = Slice Image Viewer 
      MaxChannels(1,1) uint8 {mustBeReal, mustBeFinite,mustBeLessThanOrEqual(MaxChannels,12)}  = 12;%% will be for tracking
      Channels(1,1) uint8 {mustBeReal, mustBeFinite} = 1
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
        % % Segeditor
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
      function obj = segeditor(obj)
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
          
      %% Default set up
          H.figure.Name = 'Segment Editor (ver.1.2)';
          H.figure.Colormap = gray(256);
          H.figure.Resize = obj.Resize;
      %% Menu
          %% File 
          %% Edit
          H.MenuH.ImageProcessing = uimenu(H.MenuH.Edit,...
              'Label','Image Processing');
          H.MenuH.MedianFilter = uimenu(H.MenuH.ImageProcessing,...
              'Label','Median Filter(2D)',...
              'Callback',@tsMedfilt2);
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
          imh = imagesc(H.Axes,obj.Image(:,:,1));
          H.Axes.Position(2) = 0.025 
          axis(H.Axes,'image')
          axis(H.Axes,'off')
          
          if size(obj.Image,3) == 1
              H.Slider(1).Visible = 'off';
              H.SliderText(1).Visible = 'off';
          end
          if size(obj.Image,4) == 1
              H.Slider(2).Visible = 'off';
              H.SliderText(2).Visible = 'off';
          end
          %% Panel 3
          ReSetUp3DRendering
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
              Volume = obj.Image;
              Th = 0.3;
              siz = size(Volume);
              Reso = obj.Resolution;  
              FOV = (siz-1) .* Reso;
                siz = feval(class(obj.MaximumRenderingSize),siz);
              Rsiz = min(siz,obj.MaximumRenderingSize);
              ResizeVolume = imresize3(Volume,Rsiz,'cubic');
              NewReso = FOV ./ (double(Rsiz) -1);  
              fv = Image2fv(ResizeVolume,NewReso,Th);
              p = patch(H.View3DAxes,fv);
              p.FaceColor = 'r';
              p.FaceAlpha = 0.3;
              view(3),axis('tight'),daspect(ones(1,3))
              p.EdgeColor = 'none';
          end
                             
        %% Image Processing
          function tsMedfilt2(dummy1,dummy2)
              dummy1
              dummy2
              obj
          end
        %% output 
          obj.GUIHandles = H;
      end
      
   end
end
























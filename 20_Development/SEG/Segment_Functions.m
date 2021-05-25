classdef Segment_Functions
    % Important parts.
    % "ID" is not duplicated in absolute value.
    % If the ID is negative, the calculation and visualization will not 
    % work in the subsequent processing.
    % In other words, if you want to erase the segment, you just have to 
    % make the ID negative.
    % It is not assumed that the ID will be 0.
    %
    % #### For fields other than ID in Pointdata ####
    %  ## Regarding location information.
    %   In "PointXYZ" and "Branch", the order is x, y, z.
    % "Point XYZ" is vector data, and a vector consisting of n sample 
    %   points is in the format of nx3.
    % "Branch" is a vector of at least 1x3, and segments without branches
    %   are composed of NaN (Not a Number).
    %   Each point of "Branch" must be included in PointXYZ.
    %   If PointXYZ and Branch is different type( like that double and 
    %   single type ), it would cause an error.
    %
    %  ## Regarding special fields of strings.
    %   "Type" is a character string, and only four types of "End to End",
    %     "End to Branch", "Branch to Branch", and "others" are assumed.
    %   "Class" is a character string, assuming only 9 types of'Art.','SA',
    %     'PA','Cap.', Vein','SV','PV','Parent','others' Not.
    %   "MEMO" can be freely added as a character string, but Separate and 
    %     Connect information will be entered.
    %
    %  ## Other
    % Other parameters depend on the number of "N" center points of the 
    % base PointXYZ or consist of a single scalar.
    % For example. 
    %  "Diameter" is in Nx1 data format, but if there are T slice images
    %   with different time information without changing the center point,
    %   it will be in NxT format.
    %  "Length" is the Euclidean length of the center point and is a scalar.
    %
    % Known issue.
    % With self.Connect (), self.Separate () and functions that use them, 
    % only the main parts in Pointdata (fields developed by March 2020) 
    % can be changed. However other fields and added by user are placed 
    % would be change the structure against the intention of the developer
    % in function of Connect and Separate. These are the factors that cause
    % errors in the subsequent processing (mainly visualization).
    %  Scalar data connections other than ID and Length are only arranged vertically.
    %  It is recommended to ReDo the calculation related to space after connection.
    
    %% version memo
    % Dec. 30th, 2020 Sugashi
    %  Edited set_Segment for new structure(NewXYZrot,nor,ell)
    %
    % Jan. 29th, 2021 Sugashi
    %  Edited RecheckType (Branch to Branch,  Branch to End, End to End or Others)
    %
    % Feb. 1-6th, 2021 Sugashi
    %  add Euclidian distance from AorV
    % Feb. 7th, 2021 Sugashi
    %  Organize, add help, examples, etc.
    %
    %  Suggestion_ReConnection,Find_NearSegment_xyz
    %
    %  Feb. 19th, 2021 Sugashi
    % Solving connection problems. 
    % But, Scalar data connections other than ID and Length are 
    % only arranged vertically.
    %
    %  Feb. 24th, 2021, Sugashi
    %  shoud edit..... fuckin error
    %  HigherResolutionOfBranchCoordinates 
    %  Reconnect2Branch
    %  JointBallRadius
%% Properties
    properties

        Segment  % Main data. Vasculature Segment. ( = TS_AutoSegmnet_vNewest())
        StartEndXYZ(2,3,:)  % using in self.Chase()
        MesureLine = @TS_Measure % function TS_Measure

        Chase_Limit(1,1) = 10 % Using in self.Chase(). Limit of ID, but having bags.
        
        
        Pointdata_Scalars = {'ID','Length',...
            'GenerationsNum_Arteries',...
            'GenerationsNum_Veins',...
            'GenerationsNum_ArterioVenous'}% Definition Scalar data in Pointdata.
        Pointdata_UniqueNumels = {'Branch','OriginalPointXYZ'}% Definition Unequ Numels data in Pointdata.

        Class_Artery = {'Art.','SA','PA'} % Definition class names as artery.
        Class_Vein = {'Vein','SV','PV'} % Definition class names as vein.

        Tracking_Distance_Limit(1,1) = 10 % Limit of distans to Trak time-scopic data. Default is 10 [um]

        RFitting_WindowSize(1,1) = 20 % How long use in caliculate "Radius" on each point. Default is 20 [um]
        RFitting_MaxDistance(1,1) = 10 % Dump of old function used. or Developer foget
        StraghtAS(1,1) = 30 % Definition as "Straght" by how over "Radius" . Default is 30 [um]

        BsplineFunc = @HS_B_Spline_ver19Alpha % Alias of Bspline function (c) Hiroki Suzuki.
        BsplineDim = 5 % Dimmention of bspline. Default is 5.
        BsplineFistDownSizeRatio = 1/3; % 1st donw size ratio in bspline. default is 1/3.

        ResamplingRate(1,1) = 0.5; %% Definition of Resampling Rate [um]. Default is 0.5 um. it should be smaller than minimum of self.Segment.ResolutionXYZ
        ResamplingDenoiseWindowSize(1,1) = 11 %% Definition of average window size in self.SmoothingSEG.[um],default is 11.see also self.Resampling
        NormReferenceLength(1,1)  = 3; %% Definition of window width in normal vector calculation. The default is 3 um. This should exceed a sampling ratio of at least twice.
        FaiReferenceLength(1,1) = 10; %% Definition of window width in Fai degree calculation (between each vecotor and z-axis). Default is 10 um.
        EllipticLengthLim = 5; %% Reference value to be approximated by an ellipse judged by the segment length. just for 2D
        EllipticFaiLim = pi/4; % Reference value to be approximated by an ellipse judged by the Fai.[radian], for 3D

        LastDate = '2021/19th/Feb., by Leo Sugashi Takuma'
        Version = '2.1.10' %% Current version is 2.1.10, under edit help.
        UserData
    end
    methods
        function obj = set.Segment(obj,SEG)
            obj.Segment = obj.set_Segment(SEG);
        end

        %% Set up Segment
        function SEG = set_Segment(obj,SEG,varargin)
            % default set up for Segment Analysis by Leo Sugashi Takuma
            % SEG = This.set_Segment(SEG)
            % SEG = This.set_Segment(SEG,'f')
            %     * 'f' is force type.
            %      AnalysisShouldBeElliptic and NormThetaXY field add since
            %     2020, 20, Apri.
            %     This Field use in TS_AutoAnalyssiDiam_SEG_v2020Beta(
            %     or later version).
            %
            % this ID is for traking and enable data.
            % ID < 0 mean deleted Segment. ID > 0 is usable data.
            % So, when Adding new Segment, Deleting, Editing, it is able to
            % track(=chaise) , and it will be usefull with MEMO infomation....
            %
            % Add Logical Volume data to Index and, "Size" field.
            %
            % edit, BPmatrix,
            % Add, if size(PointXYZ,1) ~= length(Diameter),
            %    example when resampling
            %
            % editlog 2020 20th Apr. by Sugashi
            % Add , Pointdata.AnalysisShouldBeElliptic and
            % Pointdata.NormXYplan field,
            %% SEG.Size is Trigar of 2D ore 3D;
            if ~isfield(SEG,'Size')
                try
                    SEG.Size = size(SEG.Output,1:3);
                catch err
                    SEG.Size = size(SEG.Original,1:3);
                end
            end
            %% at 1st, need resampling to degital index to real
            OverWriteType = 'no';
            if nargin==3
                OverWriteType = varargin{1};
            end
%             if or(~isfield(SEG,'ResamplingRate'),strcmp(OverWriteType,'f'))
            if strcmp(OverWriteType,'f')
%                 SEG = ResampllingSEG(obj,SEG);%%Edit 2020.08.11 Kusaka
                 SEG = obj.ResampllingSEG(SEG);
            end

            %% Pointdata (3D-2D data check)
            Pdata = SEG.Pointdata;
            if size(Pdata(1).PointXYZ,2)==2
                for n = 1:length(Pdata)
                    Pdata(n).PointXYZ = cat(2,Pdata(n).PointXYZ,...
                        ones(size(Pdata(n).PointXYZ,1),1));
                end
            end
            %%%%%%%%%%%%%% This is bag of pre-processing. Unexpectedly,
            %%%%%%%%%%%%%% the same point appeared on the neighbor.
            for n = 1:length(Pdata)
                xyz = Pdata(n).PointXYZ;
                if size(xyz,1)==1
                    continue
                end

                try
                plen = obj.xyz2plen(xyz,SEG.ResolutionXYZ);
                plen(1) = inf;
                delete_index = plen <obj.ResamplingRate/10; %% pieacewise distance equal 0
                PointNumel =size(xyz,1);
                if sum(delete_index)>0
                    xyz(delete_index,:) = [];
                    Pdata(n).PointXYZ = xyz;
                    FiName = fieldnames(Pdata);
                    for k = 1:length(FiName)
                        if and(or(isnumeric(Pdata(n).(FiName{k})),...
                                islogical(Pdata(n).(FiName{k}))),...
                                ~strcmp(FiName{k},'PointXYZ'))
                            if size(Pdata(n).(FiName{k}),1) == PointNumel
                                Pdata(n).(FiName{k})(delete_index,:) = [];
%                                 Pdata(n).Noise(delete_index,:) = [];
%                                 Pdata(n).Theta(delete_index,:) = [];
%                                 Pdata(n).Diameter(delete_index,:) = [];
%                                 Pdata(n).LineRotDiameter(delete_index,:) = [];
%                                 Pdata(n).NormDiameter(delete_index,:) = [];
%                                 Pdata(n).EllipticDiameter(delete_index,:) = [];
%                                 Pdata(n).NewXYZ(delete_index,:) = [];
%                                 Pdata(n).NormThetaXY(delete_index,:) = [];
%                                 Pdata(n).Fai_AngleFromAxisZ(delete_index,:) = [];
%                                 Pdata(n).AnalysisShoudBeElliptic(delete_index,:) = [];
%                                 Pdata(n).NewXYZrot(delete_index,:) = [];
%                                 Pdata(n).NewXYZnor(delete_index,:) = [];
%                                 Pdata(n).NewXYZell(delete_index,:) = [];
                            end
                        end
                    end
                end
                catch err
                    keyboard
                end
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            if ~isfield(Pdata,'ID')
                for n = 1:length(Pdata)
                    Pdata(n).ID = n;
                end
            end
            if ~isfield(Pdata,'Branch')
                for n = 1:length(Pdata)
                    Pdata(n).Branch = nan(1,3);
                end
            end
            if ~isfield(Pdata,'Class')
                for n = 1:length(Pdata)
                    Pdata(n).Class = 'others';
                end
            end
            if ~isfield(Pdata,'Signal') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).Signal = nan(size(Pdata(n).PointXYZ,1),1,'like',single(1));
                end
            end
            if ~isfield(Pdata,'Noise') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).Noise = nan(size(Pdata(n).PointXYZ,1),1,'like',single(1));
                end
            end
            if ~isfield(Pdata,'Theta') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).Theta = nan(size(Pdata(n).PointXYZ,1),1,'like',single(1));
                end
            end
            if ~isfield(Pdata,'Diameter') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).Diameter = nan(size(Pdata(n).PointXYZ,1),1,'like',single(1));
                end
            end
            if ~isfield(Pdata,'Diameter_EnablePoint') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).Diameter_EnablePoint = true(size(Pdata(n).PointXYZ,1),1);
                end
            end
            
            if ~isfield(Pdata,'LineRotDiameter') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).LineRotDiameter = nan(size(Pdata(n).PointXYZ,1),1,'like',single(1));
                end
            end
            if ~isfield(Pdata,'NormDiameter') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).NormDiameter = nan(size(Pdata(n).PointXYZ,1),1,'like',single(1));
                end
            end
            if ~isfield(Pdata,'EllipticDiameter') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).EllipticDiameter = nan(size(Pdata(n).PointXYZ,1),1,'like',single(1));
                end
            end

            if ~isfield(Pdata,'NewXYZ') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).NewXYZ= nan(size(Pdata(n).PointXYZ,1),3,'like',single(1));
                end
            else
                % % if after resampling....
            end
            if ~isfield(Pdata,'NewXYZrot') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).NewXYZrot= nan(size(Pdata(n).PointXYZ,1),3,'like',single(1));
                end
            else
                % % if after resampling....
            end
            if ~isfield(Pdata,'NewXYZnor') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).NewXYZnor= nan(size(Pdata(n).PointXYZ,1),3,'like',single(1));
                end
            else
                % % if after resampling....
            end
            if ~isfield(Pdata,'NewXYZell') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).NewXYZell= nan(size(Pdata(n).PointXYZ,1),3,'like',single(1));
                end
            else
                % % if after resampling....
            end
            if ~isfield(Pdata,'MEMO')
                for n = 1:length(Pdata)
                    Pdata(n).MEMO = ' ';
                end
            end
            % % saved as original data = result of TS_AutoSegment_...
            if ~isfield(Pdata,'OriginalPointXYZ')
                for n = 1:length(Pdata)
                    Pdata(n).OriginalPointXYZ= Pdata(n).PointXYZ;
                end
            end

            % % for euclid length form arteriovein
            if ~isfield(Pdata,'EuclidLength_Arteries') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).EuclidLength_Arteries = nan(size(Pdata(n).PointXYZ,1),1,'like',single(1));
                end
            end
            if ~isfield(Pdata,'GenerationsNum_Arteries') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).GenerationsNum_Arteries = nan(1,1,'like',single(1));
                end
            end
            if ~isfield(Pdata,'EuclidLength_Veins') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).EuclidLength_Veins = nan(size(Pdata(n).PointXYZ,1),1,'like',single(1));
                end
            end
            if ~isfield(Pdata,'GenerationsNum_Veins') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).GenerationsNum_Veins = nan(1,1,'like',single(1));
                end
            end
            if ~isfield(Pdata,'EuclidLength_ArterioVenous') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).EuclidLength_ArterioVenous = nan(size(Pdata(n).PointXYZ,1),1,'like',single(1));
                end
            end
            if ~isfield(Pdata,'GenerationsNum_ArterioVenous') || strcmp(OverWriteType,'f')
                for n = 1:length(Pdata)
                    Pdata(n).GenerationsNum_ArterioVenous = nan(1,1,'like',single(1));
                end
            end



            %% including TimeData
            mt = 1; %% maximum time data numel
            for n = 1:length(Pdata)
                mt = max(mt,size(Pdata(n).Diameter,2));
                mt = max(mt,size(Pdata(n).Signal,2));
                mt = max(mt,size(Pdata(n).Noise,2));
                mt = max(mt,size(Pdata(n).Theta,2));
            end
            %% update SEG data for TIME SCOPE
            if mt > 1
                for n = 1:length(Pdata)
                    siz = size(Pdata(n).PointXYZ,1);
                    cn = size(Pdata(n).Diameter,2);
                    if cn <mt
                        Pdata(n).Diameter = cat(2,Pdata(n).Diameter,...
                            nan(siz,mt-cn,'like',single(1)));
                    end
                    cn = size(Pdata(n).Signal,2);
                    if cn <mt
                        Pdata(n).Signal = cat(2,Pdata(n).Signal,...
                            nan(siz,mt-cn,'like',single(1)));
                    end
                    cn = size(Pdata(n).Noise,2);
                    if cn <mt
                        Pdata(n).Noise = cat(2,Pdata(n).Noise,...
                            nan(siz,mt-cn,'like',single(1)));
                    end
                    cn = size(Pdata(n).Theta,2);
                    if cn <mt
                        Pdata(n).Theta = cat(2,Pdata(n).Theta,...
                            nan(siz,mt-cn,'like',single(1)));
                    end
                    cn = size(Pdata(n).LineRotDiameter,2);
                    if cn <mt
                        try
                        Pdata(n).LineRotDiameter = cat(2,Pdata(n).LineRotDiameter,...
                            nan(siz,mt-cn,'like',single(1)));
                        catch err
                            keyboard
                        end
                    end
                    cn = size(Pdata(n).NormDiameter,2);
                    if cn <mt
                        Pdata(n).NormDiameter = cat(2,Pdata(n).NormDiameter,...
                            nan(siz,mt-cn,'like',single(1)));
                    end
                    cn = size(Pdata(n).EllipticDiameter,2);
                    if cn <mt
                        Pdata(n).EllipticDiameter = cat(2,Pdata(n).EllipticDiameter,...
                            nan(siz,mt-cn,'like',single(1)));
                    end
                end
            end


            if strcmp(OverWriteType,'f')  %% check Diameter Num == point Num
                for n = 1:length(Pdata)
                    D = Pdata(n).Diameter ;
                    if isempty(D)
                        continue
                    end
                    num = size(Pdata(n).PointXYZ,1);
                    if length(D) < num
                        X = zeros(num,mt);
                        for t = 1:mt
                            X(:,t) = interp1(D(:,t),linspace(1,length(D),num)','linear');
                        end
                        Pdata(n).Diameter = X;
                    end
                end
            end

            if strcmp(OverWriteType,'f') %% check Diameter Num == point Num
                for n = 1:length(Pdata)
                    D = Pdata(n).LineRotDiameter ;
                    num = size(Pdata(n).PointXYZ,1);
                    if length(D) < num
                        X = zeros(num,mt);
                        for t = 1:mt
                            X(:,t) = interp1(D(:,t),linspace(1,length(D),num)','linear');
                        end
                        Pdata(n).LineRotDiameter = X;
                    end
                end
            end

            if strcmp(OverWriteType,'f') %% check Diameter Num == point Num
                for n = 1:length(Pdata)
                    D = Pdata(n).NormDiameter ;
                    num = size(Pdata(n).PointXYZ,1);
                    if length(D) < num
                        X = zeros(num,mt);
                        for t = 1:mt
                            X(:,t) = interp1(D(:,t),linspace(1,length(D),num)','linear');
                        end
                        Pdata(n).NormDiameter = X;
                    end
                end
            end

            if strcmp(OverWriteType,'f') %% check Diameter Num == point Num
                for n = 1:length(Pdata)
                    D = Pdata(n).EllipticDiameter ;
                    num = size(Pdata(n).PointXYZ,1);
                    if length(D) < num
                        X = zeros(num,mt);
                        for t = 1:mt
                            X(:,t) = interp1(D(:,t),linspace(1,length(D),num)','linear');
                        end
                        Pdata(n).EllipticDiameter = X;
                    end
                end
            end

            if strcmp(OverWriteType,'f') %% check Diameter Num == point Num
                for n = 1:length(Pdata)
                    D = Pdata(n).Signal ;
                    num = size(Pdata(n).PointXYZ,1);
                    if length(D) < num
                        X = zeros(num,mt);
                        for t = 1:mt
                            X(:,t) = interp1(D(:,t),linspace(1,length(D),num)','linear');
                        end
                        Pdata(n).Signal = X;
                    end
                end
            end

            if strcmp(OverWriteType,'f') %% check Diameter Num == point Num
                for n = 1:length(Pdata)
                    D = Pdata(n).Noise ;
                    num = size(Pdata(n).PointXYZ,1);
                    if length(D) < num
                        X = zeros(num,mt);
                        for t = 1:mt
                            X(:,t) = interp1(D(:,t),linspace(1,length(D),num)','linear');
                        end
                        Pdata(n).Noise = X;
                    end
                end
            end

            if strcmp(OverWriteType,'f') %% check Theta Num == point Num
                for n = 1:length(Pdata)
                    D = Pdata(n).Noise ;
                    num = size(Pdata(n).PointXYZ,1);
                    if length(D) < num
                        Pdata(n).Theta = nan(num,mt);
                    end
                end
            end


            %% Parent SEG
            SEG.Pointdata = Pdata;
            if ~isfield(SEG,'AddBP')
                SEG.AddBP = zeros(1,0);
            end
            if ~isfield(SEG,'Branch')
                SEG.Branch = zeros(1,0);
            end
            if ~isfield(SEG,'BPmatrix')
                SEG.BPmatrix = obj.Modify_BranchPointMatrix(SEG);
                warning('Input SEG data has no BPmatrix.')
            end
            if ~isfield(SEG,'BranchPointXYZ')
                SEG.BranchPointXYZ = SEG.BPmatrix(:,1:3);
            end
            if ~isfield(SEG,'Resampling')
                SEG.Resampling = false;
            end

            if length(SEG.Size)==2
                SEG.Size = [SEG.Size 1];
            end
            try
                if islogical(SEG.Output)
                    SEG.Output = find(SEG.Output(:));
                end
            catch
            end
            if islogical(SEG.AddBP)
                SEG.AddBP = find(SEG.AddBP(:));
            end
            if islogical(SEG.Branch)
                SEG.Branch = find(SEG.Branch(:));
            end
            if islogical(SEG.BranchGroup)
                SEG.BranchGroup = find(SEG.BranchGroup(:));
            end
            if islogical(SEG.End)
                SEG.End = find(SEG.End(:));
            end
            if islogical(SEG.Original)
                SEG.Original = find(SEG.Original(:));
            end
            if length(SEG.ResolutionXYZ)==2
                SEG.ResolutonXYZ(3) = 1;
            end

            %% Add Parameter for Measurement

            if or(~isfield(Pdata,'NormThetaXY'),strcmp(OverWriteType,'f'))
                SEG = obj.AddNormThetaXY(SEG);
            end
            if or(~isfield(Pdata,'AnalysisShoudBeElliptic'),strcmp(OverWriteType,'f'))
                SEG = obj.AddAnalysisShoudBeElliptic(SEG);
            end
            %% endroll
            if ~isfield(SEG,'SegEditor')
                SEG.SegEditor = [];
            end
            SEG.SegmentFunctionLastUpdate = obj.LastDate;

        end

        %% alias
        function Pdata = Pointdata_ID(obj,ID)
          % Allias self.Segment.Pointdata with inputing "ID"
          %
          % Pdata = self.Pointdata_ID(ID)
          %  ID : scolar or vector.

            ind = obj.ID2Index(ID);
            if isnan(ind)
                Pdata = nan;
                return
            end
            Pdata = obj.Segment.Pointdata(ind);
        end

        %% Main Function
        function NewSEG = Connect(obj,SEG,varargin)
            % Connects multiple Segments.
            % NewSEG = self.Connect(SEG,Pairs,{"normal",'--force','-f'})
            %
            % SEG    : Segment data.
            % Pairs  : IDs vecotor. Or {IDs_1:IDs_2:...}
            % Option :{"normal",'--force','-f'}
            %         if '--force' ot '-f', Forcibly connect even if the Segments are separated.


%             obj.Segeditor.Segment = SEG;
%             clear SEG
%             NewSEG = obj.Segeditor.Segment;
            obj.Segment = SEG;
            NewSEG = obj.Segment;
            Pairs = varargin{1};
            if nargin ==4
                if max(strcmpi(varargin{2},{'--force', '-f'}))
                    ForceType = true;
                else
                    ForceType = false;
                end
            else
                ForceType = false;
            end
            obj.check_Pairs(Pairs)
            Pairs = obj.ID2Index(Pairs,cat(1,NewSEG.Pointdata.ID));
            NewPdata = NewSEG.Pointdata;
            catID = cat(1,NewSEG.Pointdata.ID);
            OldMaxID = max(abs(catID));
            for k = 1:length(Pairs)
                Index = Pairs{k};
                Index = reshape(Index,1,[]);
                NewPdata(end+1) = obj.Connect_Pointdata(NewSEG,Index,ForceType);
                NewPdata(end).ID = OldMaxID + k;
                for n = 1:length(Index)
                    NewPdata(Index(n)).ID = ...
                        abs(NewPdata(Index(n)).ID) * (-1);
                end
            end
            NewSEG.Pointdata = NewPdata;
        end
        function NewPdata = Connect_Pointdata(obj,SEG,Ind,ForceConnecting)
          % The function used in the self.Connect function.
          %
          % It is known that an error occurs depending on the data in Pointdata.
          % Available fields are follows.
          % PointXYZ Branch Signal Noise Diameter Theta NewXYZ
            Pdata = SEG.Pointdata(Ind);
            [Startindex,SegmentType] = obj.Find_EndSEG(Pdata);
%             catID = cat(1,Pdata.ID);
%             OldMaxID = max(abs(catID));
            NewPdata = SEG.Pointdata(Startindex);
            sort_table = true(1,length(Ind));
            sort_table(Startindex) = false;
            
            %% Pointdata Fields check
            DefaultPdata = Pdata(1);
            PFields = fieldnames(NewPdata);
            
            % check class
            Class_check = cell(1,length(Ind));
            Class_check{1} = Pdata(Startindex).Class;
            BeforeIndex = Startindex;
            for n = 1:length(Ind)-1
                [NearIndex,TF_flip_Parent,TF_flip_Foward,ErrorString] ...
                = obj.FindNearestID(NewPdata.PointXYZ,Pdata,sort_table,SEG.ResolutionXYZ);
                NearIndex = NearIndex(1);
                NextPdata = Pdata(NearIndex);
                sort_table(NearIndex) = false;
                if ~isempty(ErrorString)
                    warning(['Force Connecting : ' num2str(ForceConnecting)])
                    if ~ForceConnecting
                        fprintf('Force Connecting = false\n    if you wanna connect, need "-f" in input.\n')
                        error(['    Error Index : ' num2str(Ind(BeforeIndex)) ' and ' num2str(Ind(NearIndex))])
                    else
                        fprintf('Force Connecting = true\n')
                        fprintf(['    Force Connect. : ' num2str(Ind(BeforeIndex)) ' and ' num2str(Ind(NearIndex)) '\n'])
                    end
                end
                BeforeIndex = NearIndex;
                
                for nf = 1:length(PFields)
                    Xn = NextPdata.(PFields{nf});
                    if or(isnumeric(Xn),islogical(Xn))
                        if TF_flip_Parent
                            Xp = flip(NewPdata.(PFields{nf}),1);
                        else
                            Xp = NewPdata.(PFields{nf});
                        end
                        if TF_flip_Foward
                            Xn = flip(Xn,1);
                        end
                        NewPdata.(PFields{nf}) = cat(1,Xp,Xn);
                    elseif ischar(Xn)
                        NewPdata.(PFields{nf}) = cat(2,...
                            NewPdata.(PFields{nf}),'/',Xn);
                    else
                        keyboard
                        error('Input Pointdata has no support.')
                    end
                end
                Class_check{n+1} = NextPdata.Class;
            end
            %% old version
%             Signal = Pdata(Startindex).Signal;
%             Noise = Pdata(Startindex).Noise;
%             Diameter = Pdata(Startindex).Diameter;
%             Theta = Pdata(Startindex).Theta;
%             NewXYZ = Pdata(Startindex).NewXYZ;
%             % check class
%             Class_check = cell(1,length(Ind));
%             Class_check{1} = Pdata(Startindex).Class;
%             BeforeIndex = Startindex;
%             for n = 1:length(Ind)-1
%                 [NearIndex,TF_flip_Parent,TF_flip_Foward,ErrorString] ...
%                 = obj.FindNearestID(xyz,Pdata,sort_table,SEG.ResolutionXYZ);
%                 NearIndex = NearIndex(1);
%                 NextPdata = Pdata(NearIndex);
%                 sort_table(NearIndex) = false;
%                 if ~isempty(ErrorString)
%                     warning(['Force Connecting : ' num2str(ForceConnecting)])
%                     if ~ForceConnecting
%                         fprintf('Force Connecting = false\n    if you wanna connect, need "-f" in input.\n')
%                         error(['    Error Index : ' num2str(Ind(BeforeIndex)) ' and ' num2str(Ind(NearIndex))])
%                     else
%                         fprintf('Force Connecting = true\n')
%                         fprintf(['    Force Connect. : ' num2str(Ind(BeforeIndex)) ' and ' num2str(Ind(NearIndex)) '\n'])
%                     end
%                 end
%                 BeforeIndex = NearIndex;
%                 xyz_Add = NextPdata.PointXYZ;
%                 Branch_Add = NextPdata.Branch;
%                 Signal_Add = NextPdata.Signal;
%                 Noise_Add = NextPdata.Noise;
%                 Diameter_Add = NextPdata.Diameter;
%                 Theta_Add = NextPdata.Theta;
%                 NewXYZ_Add = NextPdata.NewXYZ;
%                 Class_check{n+1} = NextPdata.Class;
%                 if TF_flip_Parent
%                     xyz = flip(xyz,1);
%                     Branch = flip(Branch,1);
%                     Signal = flip(Signal,1);
%                     Noise = flip(Noise,1);
%                     Diameter = flip(Diameter,1);
%                     Theta = flip(Theta,1);
%                     NewXYZ = flip(NewXYZ,1);
%                 end
%                 if TF_flip_Foward
%                     xyz_Add = flip(xyz_Add,1);
%                     Branch_Add = flip(Branch_Add,1);
%                     Signal_Add = flip(Signal_Add,1);
%                     Noise_Add = flip(Noise_Add,1);
%                     Diameter_Add = flip(Diameter_Add,1);
%                     Theta_Add = flip(Theta_Add,1);
%                     NewXYZ_Add = flip(NewXYZ_Add,1);
%                 end
%                 xyz = cat(1,xyz,xyz_Add);
%                 Branch = cat(1,Branch,Branch_Add);
%                 Signal = cat(1,Signal,Signal_Add);
%                 Noise = cat(1,Noise,Noise_Add);
%                 Diameter = cat(1,Diameter,Diameter_Add);
%                 Theta = cat(1,Theta,Theta_Add);
%                 NewXYZ = cat(1,NewXYZ,NewXYZ_Add);
%             end
%             
            
            %% check same point
            xyz = NewPdata.PointXYZ;
            Plen = obj.xyz2plen(xyz,SEG.ResolutionXYZ);
            Plen(1) = inf;
            Delete_Ind = Plen ==0;
            xyz(Delete_Ind,:) = [];
            for nf = 1:length(PFields)
                Xn = DefaultPdata.(PFields{nf});
                if and(and(or(isnumeric(Xn),islogical(Xn)),size(Xn,1)>1),...
                        ~max(strcmp(PFields{nf},obj.Pointdata_UniqueNumels)))
                    X = NewPdata.(PFields{nf});
                    X(Delete_Ind,:) = [];
                    NewPdata.(PFields{nf}) = X;
                end
            end
                


            if max(strcmpi(Class_check,'Art.'))
                output_class = 'Art.';
            elseif max(strcmpi(Class_check,'Vein'))
                output_class = 'Vein';
            elseif max(strcmpi(Class_check,'SA'))
                output_class = 'SA';
            elseif max(strcmpi(Class_check,'SV'))
                output_class = 'SV';
            elseif max(strcmpi(Class_check,'PA'))
                output_class = 'PA';
            elseif max(strcmpi(Class_check,'PV'))
                output_class = 'PV';
            elseif max(strcmpi(Class_check,'Cap.'))
                output_class = 'Cap.';
            elseif max(strcmpi(Class_check,'Parent'))
                output_class = 'Parent';
            else
                output_class = 'others';
            end

            %% output

            NewPdata.Type     = SegmentType;
            NewPdata.Length   = sum(obj.xyz2plen(xyz,SEG.ResolutionXYZ));
%             NewPdata.ID       = max(max(abs(cat(1,NewPdata.ID))),OldMaxID)+1
            NewPdata.Class    = output_class;%'Parent';
            NewPdata.MEMO     = ['Paired:' num2str(Ind)];
        end
        function NewSEG = Connect_Edge2Nearest(obj,SEG,xyz,IDobj)
            % NewSEG = Connect_Edge2Nearest(obj,SEG,xyz,toID)
            %
            % Not Change IDs,
            % In oder to Connect from "xyz" (including to find basement ID)
            % to Nearest xyz in "toID".
            % If, "xyz" is just End point, PointXYZ in found ID from "xyz"
            % change(connect to one), and will copy Diameter, S, N, etc.
            % If, "xyz" is NOT  End point, Create New Pointdata(Segment),
            % and copy neseccery infomation.

            obj.Segment = SEG;
            Reso = SEG.ResolutionXYZ;

            Index_obj = obj.ID2Index(IDobj);
            % 1. Check xyz
            ID_base = obj.FindID_xyz(xyz);
            Index_base = obj.ID2Index(ID_base);
            xyz_obj = obj.Segment.Pointdata(Index_obj).PointXYZ;
            lenmap = obj.GetEachLength(xyz,xyz_obj,Reso);
            [Len,ind] = min(lenmap);
            fprintf([mfilename '\n  Connection distance ' num2str(Len) 'um\n'])
            if Len > 50
                yn = input('Contine ?? Yes[y], No[n] : ','s');
                if ~strcmpi(yn(1),'y')
                    fprintf(' OK, Return now.\n')
                    NewSEG = SEG;
                    return
                end
            else
            end
            AddXYZ = xyz_obj(ind,:);
            xyz_base = obj.Segment.Pointdata(Index_base).PointXYZ;
            CatDir = and(and(xyz(1) == xyz_base(1,1),...
                xyz(2) == xyz_base(1,2)),...
                xyz(3) == xyz_base(1,3));
            if numel(ID_base)==1 %% edit PointXYZ,
                xyz_obj = obj.Segment.Pointdata(Index_obj).PointXYZ;
                lenmap = obj.GetEachLength(xyz,xyz_obj,Reso);
                [~,ind] = min(lenmap);
                AddXYZ = xyz_obj(ind,:);
                xyz_base = obj.Segment.Pointdata(Index_base).PointXYZ;
                CatDir = and(and(xyz(1) == xyz_base(1,1),...
                    xyz(2) == xyz_base(1,2)),...
                    xyz(3) == xyz_base(1,3));
                if CatDir
                    n_PointXYZ = cat(1,AddXYZ,xyz_base);
                    n_Branch = cat(1,AddXYZ,obj.Segment.Pointdata(Index_base).Branch);
                    n_Signal = cat(1,obj.Segment.Pointdata(Index_obj).Signal(ind),...
                        obj.Segment.Pointdata(Index_base).Signal);
                    n_Noise = cat(1,obj.Segment.Pointdata(Index_obj).Noise(ind),...
                        obj.Segment.Pointdata(Index_base).Noise);
                    n_Diameter = cat(1,obj.Segment.Pointdata(Index_obj).Diameter(ind),...
                        obj.Segment.Pointdata(Index_base).Diameter);
                    n_NewXYZ = cat(1,obj.Segment.Pointdata(Index_obj).NewXYZ(ind,:),...
                        obj.Segment.Pointdata(Index_base).NewXYZ);
                else
                    n_PointXYZ = cat(1,xyz_base,AddXYZ);
                    n_Branch = cat(1,obj.Segment.Pointdata(Index_base).Branch,AddXYZ);
                    n_Signal = cat(1,obj.Segment.Pointdata(Index_base).Signal,...
                        obj.Segment.Pointdata(Index_obj).Signal(ind));
                    n_Noise = cat(1,obj.Segment.Pointdata(Index_base).Noise,...
                        obj.Segment.Pointdata(Index_obj).Noise(ind) );
                    n_Diameter = cat(1,obj.Segment.Pointdata(Index_base).Diameter,...
                        obj.Segment.Pointdata(Index_obj).Diameter(ind) );
                    n_NewXYZ = cat(1,obj.Segment.Pointdata(Index_base).NewXYZ,...
                        obj.Segment.Pointdata(Index_obj).NewXYZ(ind,:));
                end
                n_Length = sum(obj.xyz2plen(n_PointXYZ,Reso));
                n_Branch(isnan(n_Branch(:,1)),:) = [];
                n_ID = obj.Segment.Pointdata(Index_base).ID;
                EditIndex = Index_base;

            elseif numel(ID_base) >1 %% add New Pointdata
                if CatDir
                    base_ind = 1;
                else
                    base_ind = size(obj.Segment.Pointdata(Index_base).PointXYZ);
                end
                OldMaxID = max(abs(cat(1,obj.Segment.Pointdata.ID)));
                n_ID = OldMaxID +1;
                n_PointXYZ = cat(1,AddXYZ,xyz_base);
                n_Length = sum(obj.xyz2plen(n_PointXYZ,Reso));
                n_Branch = cat(1,AddXYZ,obj.Segment.Pointdata(Index_base).Branch);
                n_Branch(isnan(n_Branch(:,1)),:) = [];
                n_Signal = cat(1,obj.Segment.Pointdata(Index_obj).Signal(ind),...
                        obj.Segment.Pointdata(Index_base).Signal(base_ind));
                n_Noise = cat(1,obj.Segment.Pointdata(Index_obj).Noise(ind),...
                        obj.Segment.Pointdata(Index_base).Noise(base_ind));
                n_Diameter = cat(1,obj.Segment.Pointdata(Index_obj).Diameter(ind),...
                        obj.Segment.Pointdata(Index_base).Diameter(base_ind));
                n_NewXYZ = cat(1,obj.Segment.Pointdata(Index_obj).NewXYZ(ind,:),...
                        obj.Segment.Pointdata(Index_base).NewXYZ(base_ind,:));
                EditIndex = length(obj.Segment.Pointdata) + 1;
            else
                error('Missing Input xyz??, Never find out that xyz.')
            end
            obj.Segment.Pointdata(EditIndex).PointXYZ = n_PointXYZ;
            obj.Segment.Pointdata(EditIndex).Length = n_Length;
            obj.Segment.Pointdata(EditIndex).Branch = n_Branch;
            obj.Segment.Pointdata(EditIndex).Signal = n_Signal;
            obj.Segment.Pointdata(EditIndex).Noise = n_Noise;
            obj.Segment.Pointdata(EditIndex).Diameter = n_Diameter;
            obj.Segment.Pointdata(EditIndex).NewXYZ = n_NewXYZ;
            obj.Segment.Pointdata(EditIndex).ID = n_ID;

            NewSEG = obj.ReCheckType();

        end
        function NewSEG = Separate(obj,SEG,SegID,Index)
          % NewSEG = self.Separate(SEG,SegID,Index)
          %
          % SEG   : Segment DateData
          % SegID : ID (scalar)
          % Index : index of place to separate. (scalar)
          %
          % It is known that an error occurs depending on the data in Pointdata.
          % Available fields are follows.
          % PointXYZ Branch Signal Noise Diameter Theta NewXYZ
            obj.Segment = SEG;
            clear SEG
            NewSEG = obj.Segment;
            catID = cat(1,NewSEG.Pointdata.ID);
            SegNum = find(catID == SegID);
            if ~isscalar(SegNum)
                error('Input Segment Number(=SegNum) is NOT Scalar')
            end
            if ~isscalar(Index)
                error('Input Index Number in SegNum(=Index) is NOT vector')
            end
            ParentPdata = NewSEG.Pointdata(SegNum);
            if max(Index==1) || max(Index ==size(ParentPdata.PointXYZ,1))
                error('Input Index Number has 1 or end.')
            end
            if max(diff(sort(Index)) == 0)
                error('Input Index has same point.');
            end
            % % Main
            NewPdata = NewSEG.Pointdata;
            PFields = fieldnames(NewPdata(1));
            NewPdata(SegNum).ID = abs(NewPdata(SegNum).ID) * (-1);
            NewBranch = cat(1,ParentPdata.PointXYZ(Index,:),ParentPdata.Branch);
            NewBranch(isnan(NewBranch(:,1)),:) = [];
            Index = [1 ; sort(Index(:)) ; size(ParentPdata.PointXYZ,1)];
            ydata = 1:size(ParentPdata.PointXYZ,1);
            EndID = max(abs(cat(1,NewSEG.Pointdata.ID)));
            for n = 1:length(Index)-1
%                 cutIndex = Index(n):Index(n+1);
                cutIndex = and(ydata>=Index(n),ydata<=Index(n+1));
                xyz = ParentPdata.PointXYZ(cutIndex,:);
                NewPdata(end +1).PointXYZ = xyz;
                for k = 1:length(PFields)
                    if size(ParentPdata.PointXYZ,1)==size(ParentPdata.(PFields{k}),1)
                        NewPdata(end).(PFields{k}) = ParentPdata.(PFields{k})(cutIndex,:);
                    end
                end
                Branch   = obj.CheckBranch(xyz,NewBranch,NewSEG.ResolutionXYZ);
                NewPdata(end).Branch = Branch;
                NewPdata(end).OriginalPointXYZ = xyz;
%                 NewPdata(end).Signal   = ParentPdata.Signal(cutIndex);
%                 NewPdata(end).Noise    = ParentPdata.Noise(cutIndex);
%                 NewPdata(end).Theta    = ParentPdata.Theta(cutIndex);
%                 NewPdata(end).Diameter = ParentPdata.Diameter(cutIndex);
%                 NewPdata(end).NewXYZ   = ParentPdata.NewXYZ(cutIndex,:);
                if size(Branch,1) >=2
                    SegmentType = 'Branch to Branch';
                elseif size(Branch,1) ==1 && ~max(isnan(Branch))
                    SegmentType = 'End to Branch';
                else
                    SegmentType = 'End to End';
                end
                NewPdata(end).Type     = SegmentType;
                NewPdata(end).Length   = sum(obj.xyz2plen(xyz,NewSEG.ResolutionXYZ));
                NewPdata(end).ID       = EndID+n;
                NewPdata(end).Class    = ParentPdata.Class;
                NewPdata(end).MEMO     = [' Separated from ID :' num2str(SegID) ];
            end

            NewSEG.Pointdata = NewPdata;
        end
        function chase_data = Chase(obj,SEG,input_xyz,varargin)
          % chase_data = self.Chase(SEG,input_xyz)
          % Input :
          %   SEG       : Segment data.
          %   input_xyz : Start point of xyz, 1x3,vecotor.
          % Output : (structure)
          %   chase_data.StartID   :  Start ID
          %   chase_data.Chase     :  main output(structure)
          %             .Chase(n).IDs    : Chased IDs.
          %             .Chase(n).FlipTF : Inversion information of segment vector at the time of chasing.
          %
          %  see also, self.FindNextSegment
            SEG = obj.set_Segment(SEG);
            cutids = cat(1,SEG.Pointdata.ID) > 0;
            SEG.Pointdata = SEG.Pointdata(cutids);
            obj.Segment = SEG;
            chase_data = struct('Input_XYZ',input_xyz,...
                'StartID',[],'Chase',[]);
            if ~isvector(input_xyz)
                error('Input XYZ(= Start XYZ) must Be [X,Y,Z] Vector data.')
            end
            [obj,StartID,StartFlipTF] = obj.Check_input_Chaser(obj.Segment.Pointdata,input_xyz);
            chase_data.StartID = StartID;
            %% Main
            catID = [];
            catFlipTF = [];
            for n = 1:length(StartID)
                [IDs,FlipTFs] = obj.FindNextSegment(StartID(n),StartFlipTF(n));
                catID = cat(1,catID,IDs);
                catFlipTF = cat(1,catFlipTF,FlipTFs);
            end

            Chase(1:size(catID,1)) = struct('IDs',[],'FlipTFs',[]);
            for n = 1:size(catID,1)
                Chase(n).IDs = catID{n};
                Chase(n).FlipTFs = catFlipTF{n};
            end
            chase_data.Chase = Chase;
        end
        function [obj,StartID,FlipTF] = Check_input_Chaser(obj,Pdata,xyz)
          % [obj,StartID,FlipTF] = self.Check_input_Chaser(Pdata,xyz)
          % Used in the Chase function.
            cat_xyz = cat(1,Pdata.PointXYZ);
            Xtf = xyz(1) == cat_xyz(:,1);
            Ytf = xyz(2) == cat_xyz(:,2);
            Ztf = xyz(3) == cat_xyz(:,3);
            TF = and( and( Xtf, Ytf), Ztf);
            if ~max(TF)
                warning('Input XYZ(Start XYZ) is NOT exist in PointXYZ.')
            end

            catID = cat(1,Pdata.ID);
            XYZ_matrix = zeros(2,3,length(Pdata));
            for n = 1:length(Pdata)
                XYZ_matrix(1,:,n) = Pdata(n).PointXYZ(1,:);
                XYZ_matrix(2,:,n) = Pdata(n).PointXYZ(end,:);
            end
            obj.StartEndXYZ = XYZ_matrix;
            Index = squeeze(obj.FindSameStartEndXYZ(xyz));
            [y,x] = find(Index);
            StartID = catID(x);
            FlipTF = y ==2;
            if isempty(StartID)
                warning('Input XYZ(Start XYZ) is NOT exist in PointXYZ.')
                try
                    check = obj.BranchInXYZ(xyz,cat_xyz,obj.Segment.ResolutionXYZ);
                catch err
                    error(err.message)
                end
                StartID = check;
                FlipTF = false;
            end
        end
        function NewSEG = CalculateSphereFitRadius(obj,SEG)
          % NewSEG = self.CalculateSphereFitRadius(SEG)
          %
          % An older version of the curve radius calculation
          % function at a point. The new ones are as follows.
          %    [Rad,UVec,Scal] = self.CircleFit_Taubin(xy_real); as 2D
          %    [Rad,UVec,Scal] = self.SphereFit_LeastSquares(xyz_real; ad 3D
            Pdata = SEG.Pointdata;
            Reso = SEG.ResolutionXYZ;
            fprintf(['    ' mfilename '\n'])
            disp(['Number of Segment (ID>0) : ' num2str(sum(cat(1,Pdata.ID)>0))])
            fprintf('... using parfor...')
            tic
            Pdata(1).SphereFitRadius = [];
            parfor n = 1:length(Pdata)
                if Pdata(n).ID < 0
                    continue
                end
                xyz = Pdata(n).PointXYZ;
                xyz = (xyz - 1) .* Reso;
                R = obj.SphereFit_pcfitsphere(xyz,10,15);
                Pdata(n).SphereFitRadius = R;
            end
            NewSEG = SEG;
            NewSEG.Pointdata = Pdata;
            fprintf('Done...\n')
            toc
            fprintf('\n\n')
        end
        function NewSEG = CalculateCircleFitRadius(obj,SEG)
          % NewSEG = self.CalculateSphereFitRadius(SEG)
          %
          % An older version of the curve radius calculation
          % function at a point. The new ones are as follows.
          %    [Rad,UVec,Scal] = self.CircleFit_Taubin(xy_real); as 2D
          %    [Rad,UVec,Scal] = self.SphereFit_LeastSquares(xyz_real; ad 3D
            Reso = SEG.ResolutionXYZ;
            NewStep = SEG.ResolutionXYZ(1); %% unit um/pix.
            XYZrange = repmat(NewStep*3,[1 3]); %% unit, um
            NewSEG = obj.SmoothingSEG(SEG,NewStep,XYZrange);

            val = 31; %% point number
            Threshold_lineR = 30; %% um

            for n = 1:length(NewSEG.Pointdata)
                xyz = NewSEG.Pointdata(n).PointXYZ;
                R = obj.xyz2CalcR(xyz,val);
                Rs = R(:,3) * Reso(1);
                R_straight = Rs >= Threshold_lineR;
                [L,Num_Straight] =  bwlabel(R_straight);
                s = regionprops(L,'Area');
                [~,MaxLenInd] = max(cat(1,s.Area));
                pickupXYZ = xyz(L==MaxLenInd,:);
                MaximumStraight = sum(obj.xyz2plen(pickupXYZ,Reso));
                [~,Num_Curve] =  bwlabel(~R_straight);
                [MinimumR,MinRInd] = min(Rs);
                xyz_data = (1:size(xyz,1))';

                Left = xyz(and(R_straight,xyz_data<MinRInd(1)),:);
                Right = xyz(and(R_straight,xyz_data>MinRInd(1)),:);
                lenmap = obj.GetEachLength(Left,Right,Reso);
                MinimumWidth = min(lenmap(:));
                if isempty(MinimumWidth)
                    MinimumWidth = nan;
                end

                EvalValues(1) = Num_Straight;
                EvalValues(2) = MaximumStraight;
                EvalValues(3) = Num_Curve;
                EvalValues(4) = MinimumR;
                EvalValues(5) = MinimumWidth;
                NewSEG.Pointdata(n).Rs = Rs;
                NewSEG.Pointdata(n).EvalValues = EvalValues';
            end
        end
        function NewSEG = AddSpatialPhysicalQuantityj(obj,SEG,varargin)
            % NewSEG = AddSpatialPhysicalQuantityj(SEG)
            % NewSEG = AddSpatialPhysicalQuantityj(SEG,'--force')
            %
            % Calculation of spatial physical quantities from
            % Vasculature and vector data of the center point.
            % # # Under Development.
            %
            % see properties...(default are...)
            %   obj.RFitting_WindowSize = 15 % um
            %   obj.RFitting_MaxDistance = 10
            %   obj.StraghtAS = 30 % um
            %
            % Editing 2019 09 05 ~, by Sugashi.T.,Suzuki.H.
            %% input check & Initialize
            Time = tic;
            warning('off','all')
            ForceType = 'none';
            if nargin == 3
                ForceType = varargin{1};
            end
		      	NewSEG = InputCheck_AddSpatialPhisicalQuatity(obj,SEG);
            if isfield(NewSEG,'SpatialPhysicEvalDate')
                if ~max(strcmpi(ForceType,{'-f','--force','force'}))
                    error('Input SEG data has Spatial Physic Quantities.')
                else
                    NewSEG.SpatialPhysicEvalDate = date;
                end
            else
                NewSEG.SpatialPhysicEvalDate = date;
            end
            NewSEG.RFitting_WindowSize = obj.RFitting_WindowSize; % um
            NewSEG.RFitting_MaxDistance = obj.RFitting_MaxDistance;
            NewSEG.StraghtAS = obj.StraghtAS; % um
            %% initialize for parfor
            ParObj = gcp;
            if isempty(ParObj)
                ParObj = struct('NumWorkers',[]);
                ParObj.NumWorkers = 1;
%                 ParObj = parpool;
            end
            obj.Segment = NewSEG;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             ReSEG = obj.ReCheckType();
            ReSEG = NewSEG;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Pdata = NewSEG.Pointdata;
            Pdata(1).Enable_TF = [];
            Pdata(1).is_edge = []; %% Type 'End to Branch'. : 1.00
            %                             & End to End      : 0.50
            %                               else            : 0.00
%             Pdata(1).PeaceWise_Length = [];
            Pdata(1).DirectedDistance = [];
            Pdata(1).DirectedVector = [];
            Pdata(1).Length_from_Branch = [];
            Pdata(1).SphereFitRadius = [];
            Pdata(1).SphereFitUnitVector = [];
            Pdata(1).SphereFitScalar = [];
%             Pdata(1).RatioOfCurve = [];
            Pdata(1).CurveNumber = [];
%             Pdata(1).CurveRatio = [];
            Pdata(1).Curvature = []; % (Length - DirectLength)/(Directed Distance)
%             Pdata(1).CurveMaximumR = [];
            Pdata(1).CurveMinimumR = [];
            Pdata(1).StraghtNumber = [];
            Pdata(1).StraghtSumationLength = [];
            Pdata(1).StraghtMaximumLength = [];
            Pdata(1).StraghtMinimumLength = [];

            % % % % % for shaving  % % % % %
            Pdata(1).SignalMaximumGap = [];
            Pdata(1).NoiseMaximumGap = [];
            Pdata(1).SNRMaximumGap = [];
            Pdata(1).DiameterMaximumGap = [];
            Pdata(1).SignalDiffMeanABS = [];
            Pdata(1).NoiseDiffMeanABS = [];
            Pdata(1).SNRDiffMeanABS = [];
            Pdata(1).DiameterDiffMeanABS = [];
            Pdata(1).SignalDiffSD = [];
            Pdata(1).NoiseDiffSD = [];
            Pdata(1).SNRDiffSD = [];
            Pdata(1).DiameterDiffSD = [];
            Pdata(1).DistanceNearestEdgeXY = [];
            Pdata(1).DistanceNearestEdgeZ = [];
            % after Calculate SphereFitUnitVectors
            % Find Nearest other Segment,
            % compare with each Branch point Vectors
            Pdata(1).MinimumVecterParallelism = [];

            %% main
            Reso = SEG.ResolutionXYZ;
            FOV = (NewSEG.Size-1).*NewSEG.ResolutionXYZ;
            fprintf(['    ' mfilename '\n'])
            disp(['Number of Segment (ID>0) : ' num2str(sum(cat(1,Pdata.ID)>0))])
            fprintf('... using parfor...\n')
            fprintf(['NumWorkers : ' num2str(ParObj.NumWorkers) '\n'])
%             TS_WaiteProgress(0)
            for nc = 1:length(Pdata)
                if Pdata(nc).ID < 0
                    Pdata(nc).Enable_TF = false;
                else
                    Pdata(nc).Enable_TF = true;
                end
                if strcmpi(ReSEG.Pointdata(nc).Type,'End to Branch')
                    Pdata(nc).is_edge = 1;
                elseif strcmpi(ReSEG.Pointdata(nc).Type,'End to End')
                    Pdata(nc).is_edge = 0.5;
                else
                    Pdata(nc).is_edge = 0;
                end
                xyz = Pdata(nc).PointXYZ;
                Branch = Pdata(nc).Branch;
                Length = Pdata(nc).Length;
                DirectDist = sqrt( sum((diff(xyz([1,end],1),1,1).*Reso).^2,2) );
                Pdata(nc).DirectedDistance = DirectDist;
                Pdata(nc).DirectedVector = diff(xyz([1,end],:),1,1);

                PieaceDist = obj.DistanceFromBranch(xyz,Branch,Reso);
                Pdata(nc).Length_from_Branch = PieaceDist;

                if sum(xyz(:,3) == 1 ) == size(xyz,1) % 2D
                    [Rad,UVec,Scal] = obj.CircleFit_Taubin((xyz-1).*Reso);
                else
                    [Rad,UVec,Scal] = obj.SphereFit_LeastSquares((xyz-1).*Reso);
                end
                Pdata(nc).SphereFitRadius = Rad;
                Pdata(nc).SphereFitUnitVector = UVec;
                Pdata(nc).SphereFitScalar = Scal;
                %% poler %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                Increaser = cat(1,false,diff(Rad)>0);
                Decreaser = cat(1,diff(Rad)<0,false);
                Poler = and(Increaser,Decreaser);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                TF_straght = and(Rad >= obj.StraghtAS,~Poler);
                TF_curve = ~TF_straght;
                [Ls,NUMs] = bwlabel(TF_straght);
                CC_c = bwconncomp(TF_curve);
                EachLen = zeros(1,NUMs);
                if isempty(EachLen)
                    EachLen = 0;
                end
                for ln = 1:NUMs
                    EachLen(ln) = sum(obj.xyz2plen(xyz(Ls==ln,:),Reso));
                end

                CMR = min(Rad(TF_curve));
                if isempty(CMR)
                    CMR = nan;
                end
                Pdata(nc).CurveNumber = CC_c.NumObjects;
                 CV = (Length - DirectDist)/DirectDist;
                if isinf(CV)
                    CV = nan;
                end
                Pdata(nc).Curvature =CV; % (Length - DirectLength)/(Directed Distance)
                Pdata(nc).CurveMinimumR = CMR;

                Pdata(nc).StraghtNumber = NUMs;
                Pdata(nc).StraghtSumationLength = sum(EachLen);
                Pdata(nc).StraghtMaximumLength = max(EachLen);
                Pdata(nc).StraghtMinimumLength = min(EachLen);

                % % % % % for shaving  % % % % %
                Signal = Pdata(nc).Signal;
                Noise = Pdata(nc).Noise;
                SNR = Signal./Noise;
                Diam = Pdata(nc).Diameter;
                Pdata(nc).SignalMaximumGap = max(Signal) - min(Signal);
                Pdata(nc).NoiseMaximumGap = max(Noise) - min(Noise);
                Pdata(nc).SNRMaximumGap = max(SNR) - min(SNR);
                Pdata(nc).DiameterMaximumGap = max(Diam) - min(Diam);
                Pdata(nc).SignalDiffMeanABS = nanmean(diff(Signal(:),1,1));
                Pdata(nc).NoiseDiffMeanABS = nanmean(diff(Noise(:),1,1));
                Pdata(nc).SNRDiffMeanABS = nanmean(diff(SNR(:),1,1));
                Pdata(nc).DiameterDiffMeanABS = nanmean(diff(Diam(:),1,1));
                Pdata(nc).SignalDiffSD = nanstd(diff(Signal(:),1,1));
                Pdata(nc).NoiseDiffSD = nanstd(diff(Noise(:),1,1));
                Pdata(nc).SNRDiffSD = nanstd(diff(SNR(:),1,1));
                Pdata(nc).DiameterDiffSD = nanstd(diff(Diam(:),1,1));

                xyz_real = (xyz -1).*Reso;
                Dx = min( min(xyz_real(:,1)), min(abs(xyz_real(:,1)-FOV(1))) );
                Dy = min( min(xyz_real(:,2)), min(abs(xyz_real(:,2)-FOV(2))) );
                Dz = min( min(xyz_real(:,3)), min(abs(xyz_real(:,3)-FOV(3))) );
                Pdata(nc).DistanceNearestEdgeXY = min([Dx,Dy]);
                Pdata(nc).DistanceNearestEdgeZ = Dz;

%                 TS_WaiteProgress(nc/length(Pdata))
            end
            toc(Time)
            fprintf('Calculate Minimum Vecter Parallelism \n')

            obj.Segment = NewSEG;
            parPdata = Pdata;
            parfor nc = 1:length(parPdata)
%                 TS_WaiteProgress((nc-1)/length(Pdata))
                if ~and(parPdata(nc).is_edge,parPdata(nc).ID>0)
                    Pdata(nc).MinimumVecterParallelism = nan;
                    continue
                end
                ID = parPdata(nc).ID;
                xyz_1st = parPdata(nc).PointXYZ(1,:);
                IDs = obj.FindID_xyz(xyz_1st);
                IDs(IDs==ID) = [];
                if isempty(IDs)
                    val_1st = nan;
                else
                    V0 = parPdata(nc).SphereFitUnitVector(1,:);
                    val_1st = obj.Get_VecterParallelismS(...
                        V0,xyz_1st,obj.ID2Index(IDs),parPdata);
                end


                xyz_end = parPdata(nc).PointXYZ(end,:);
                IDs = obj.FindID_xyz(xyz_end);
                IDs(IDs==ID) = [];
                if isempty(IDs)
                    val_end = nan;
                else
                    V0 = parPdata(nc).SphereFitUnitVector(end,:);
                    val_end = obj.Get_VecterParallelismS(...
                        V0,xyz_end,obj.ID2Index(IDs),parPdata);
                end
                Pdata(nc).MinimumVecterParallelism = ...
                    min(cat(1,val_1st(:),val_end(:)));
            end
%             TS_WaiteProgress(1)
            NewSEG.Pointdata = Pdata;
            fprintf('Done...\n')
            toc(Time)
            warning('on','all')
            fprintf('\n\n')
			function NewSEG = InputCheck_AddSpatialPhisicalQuatity(obj,SEG)
        %
        %
					NewSEG = obj.set_Segment(SEG);
					fprintf([mfilename 'Input check ....'])
					for n = 1:length(NewSEG.Pointdata)
						P = NewSEG.Pointdata(n);
						if P.ID<0
							continue
						end
						if ~isfield(P,'Signal') || ~isfield(P,'Noise') || ~isfield(P,'Diameter') || ...
							~isfield(P,'Theta') || ~isfield(P,'Length')
							error('Input SEG data is wrong structure for this function...ask sugashi')
						end
						if isempty(P.Length) || size(P.PointXYZ,1) ~= length(P.Signal) || ...
							size(P.PointXYZ,1) ~= length(P.Noise) ||...
							size(P.PointXYZ,1) ~= length(P.Diameter) || ...
							size(P.PointXYZ,1) ~= length(P.Theta)
							error('Input SEG data has wrong size for Pointdata ....')
						end
					end
			   end
        end
        function NewSEG = AddSpatialPhysicalQuantity_Capillaro(obj,SEG,varargin)
            % NewSEG = AddSpatialPhysicalQuantityj(SEG)
            % NewSEG = AddSpatialPhysicalQuantityj(SEG,'--force')
            %
            % see properties...(default are...)
            %   obj.RFitting_WindowSize = 15 % um
            %   obj.RFitting_MaxDistance = 10
            %   obj.StraghtAS = 30 % um
            %
            % Editing 2019 09 05 ~, by Sugashi.T.,Suzuki.H.
            %% input check & Initialize
            Time = tic;
            warning('off','all')
            ForceType = 'none';
            if nargin == 3
                ForceType = varargin{1};
            end

			%% NewSEG = InputCheck_AddSpatialPhisicalQuatity(obj,SEG);
            NewSEG = obj.set_Segment(SEG);
            if isfield(NewSEG,'SpatialPhysicEvalDate')
                if ~max(strcmpi(ForceType,{'-f','--force','force'}))
                    error('Input SEG data has Spatial Physic Quantities.')
                else
                    NewSEG.SpatialPhysicEvalDate = date;
                end
            else
                NewSEG.SpatialPhysicEvalDate = date;
            end
            NewSEG.RFitting_WindowSize = obj.RFitting_WindowSize; % um
            NewSEG.RFitting_MaxDistance = obj.RFitting_MaxDistance;
            NewSEG.StraghtAS = obj.StraghtAS; % um
            %% initialize for parfor
            obj.Segment = NewSEG;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             ReSEG = obj.ReCheckType();
            ReSEG = NewSEG;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Pdata = NewSEG.Pointdata;
            Pdata(1).Enable_TF = [];
            Pdata(1).is_edge = []; %% Type 'End to Branch'. : 1.00
            %                             & End to End      : 0.50
            %                               else            : 0.00
            %% main
            Reso = SEG.ResolutionXYZ;
            FOV = (NewSEG.Size-1).*NewSEG.ResolutionXYZ;

            for nc = 1:length(Pdata)
                if Pdata(nc).ID < 0
                    Pdata(nc).Enable_TF = false;
                else
                    Pdata(nc).Enable_TF = true;
                end
                if strcmpi(ReSEG.Pointdata(nc).Type,'End to Branch')
                    Pdata(nc).is_edge = 1;
                elseif strcmpi(ReSEG.Pointdata(nc).Type,'End to End')
                    Pdata(nc).is_edge = 0.5;
                else
                    Pdata(nc).is_edge = 0;
                end
                xyz = Pdata(nc).PointXYZ;
                Branch = Pdata(nc).Branch;
                Length = Pdata(nc).Length;
                DirectDist = sqrt( sum((diff(xyz([1,end],1),1,1).*Reso).^2,2) );
                Pdata(nc).DirectedDistance = DirectDist;
                Pdata(nc).DirectedVector = diff(xyz([1,end],:),1,1);

                PieaceDist = obj.DistanceFromBranch(xyz,Branch,Reso);
                Pdata(nc).Length_from_Branch = PieaceDist;

                if obj.Segment.Size(3) == 1% old ver,sum(xyz(:,3) == 1 ) == size(xyz,1) % 2D
                    [Rad,UVec,Scal] = obj.CircleFit_Taubin((xyz-1).*Reso);
                else
                    [Rad,UVec,Scal] = obj.SphereFit_LeastSquares((xyz-1).*Reso);
                end

                Pdata(nc).SphereFitRadius = Rad;
                Pdata(nc).SphereFitUnitVector = UVec;
                Pdata(nc).SphereFitScalar = Scal;

                CV = (Length - DirectDist)/DirectDist;
                if isinf(CV)
                    CV = nan;
                end
                Pdata(nc).Curvature =CV; % (Length - DirectLength)/(Directed Distance)
                %% poler %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                siz = size(Rad);
                siz(1) = 1;
                Increaser = cat(1,false(siz),diff(Rad,[],1)>0);
                Decreaser = cat(1,diff(Rad,[],1)<0,false(siz));
                Poler = and(Increaser,Decreaser);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                Cmap = zeros(...
                    length(obj.RFitting_WindowSize),...
                    length(obj.StraghtAS));
                CMRmap = Cmap;
                NUMsmap = Cmap;
                SumLenmap = Cmap;
                MaxLenmap = Cmap;
                MinLenmap = Cmap;
%                 se = strel('rectangle',[2 1]);
                for RWind= 1:length(obj.RFitting_WindowSize)
                    RadiusLine = squeeze(Rad(:,1,RWind));
                    for SAS = 1:length(obj.StraghtAS)
%                         TF_straght = and(RadiusLine >= obj.StraghtAS(SAS),squeeze(~Poler(:,1,RWind)));
                        TF_straght = or(RadiusLine >= obj.StraghtAS(SAS),isnan(RadiusLine));
%                         TF_curve = and(RadiusLine < obj.StraghtAS(SAS),squeeze(~Poler(:,1,RWind)));
                        TF_curve = ~TF_straght;
                        [Ls,NUMs] = bwlabel(TF_straght);
%                         [Lscu,NUMscu] = bwlabel(TF_curve);
                        CC_c = bwconncomp(TF_curve);
                        EachLen = zeros(1,NUMs);
                        if isempty(EachLen)
                            EachLen = 0;
                        end
                        for ln = 1:NUMs
                            EachLen(ln) = sum(obj.xyz2plen(xyz(Ls==ln,:),Reso));
                        end
%                         for lncu = 1:NUMscu
%                             EachLencu(lncu) = sum(obj.xyz2plen(xyz(Lscu==lncu,:),Reso));
%                         end

                        CMR = min(RadiusLine(TF_curve));
                        if isempty(CMR)
                            CMR = nan;
                        end
%
%                         subEachLen = EachLen;
%                         subEachLen(subEachLen==0)=nan;
%                         NewNum = nnz(~isnan(subEachLen));
                        Cmap(RWind,SAS) = CC_c.NumObjects;
                        CMRmap(RWind,SAS) = CMR;
                        NUMsmap(RWind,SAS) = NUMs;
%                         NUMsmap(RWind,SAS) = NewNum;
                        SumLenmap(RWind,SAS) = sum(EachLen);
                        MaxLenmap(RWind,SAS) = max(EachLen);
                        MinLenmap(RWind,SAS) = min(EachLen);
                        MeanLenmap(RWind,SAS) = nanmean(EachLen);
%                         MinLenmap(RWind,SAS) = min(subEachLen,[],'omitnan');
%                         MeanLenmap(RWind,SAS) = nanmean(subEachLen);
%                         SDLenmap(RWind,SAS) = nanstd(subEachLen);


%                         SDLenmap(RWind,SAS) = std(EachLen);  %%edit kusaka
%
%                         subEachLencu = EachLencu;
%                         subEachLencu(subEachLencu==0)=nan;
%                         NewNumcu = nnz(~isnan(subEachLencu));
%                         SumLenmapcu(RWind,SAS) = sum(EachLencu);
%                         MaxLenmapcu(RWind,SAS) = max(EachLencu);
%                         MinLenmapcu(RWind,SAS) = min(subEachLencu,[],'omitnan');
%                         MeanLenmapcu(RWind,SAS) = nanmean(subEachLencu);
%                         SDLenmapcu(RWind,SAS) = nanstd(subEachLencu);



                    end
                end
%                 keyboard
                Pdata(nc).CurveNumber = Cmap;
                Pdata(nc).CurveMinimumR = CMRmap;
                Pdata(nc).StraghtNumber = NUMsmap;
                Pdata(nc).StraghtSumationLength = SumLenmap;
                Pdata(nc).StraghtMaximumLength = MaxLenmap;
                Pdata(nc).StraghtMinimumLength = MinLenmap;
                Pdata(nc).MeanLenmap = MeanLenmap;

%                 Pdata(nc).NewStraghtNumber = NewNum;
%                 Pdata(nc).NewCurveNumber = NewNumcu;
%                 Pdata(nc).SDStraghtLength = SDLenmap;
%
%                 Pdata(nc).SumLenmapcu = SumLenmapcu;
%                 Pdata(nc).MaxLenmapcu = MaxLenmapcu;
%                 Pdata(nc).MinLenmapcu = MinLenmapcu;
%                 Pdata(nc).MeanLenmapcu = MeanLenmapcu;
%                 Pdata(nc).SDLenmapcu = SDLenmapcu;
                Pdata(nc).TF_straght = TF_straght;
                Pdata(nc).TF_curve = TF_curve;
                % % % % % for shaving ./ cell tracking?? % % % % %
                Signal = Pdata(nc).Signal;
                Noise = Pdata(nc).Noise;
                SNR = Signal./Noise;
                Diam = Pdata(nc).Diameter;
                Pdata(nc).SignalMaximumGap = max(Signal) - min(Signal);
                Pdata(nc).NoiseMaximumGap = max(Noise) - min(Noise);
                Pdata(nc).SNRMaximumGap = max(SNR) - min(SNR);
                Pdata(nc).DiameterMaximumGap = max(Diam) - min(Diam);
                Pdata(nc).SignalDiffMeanABS = nanmean(diff(Signal(:),1,1));
                Pdata(nc).NoiseDiffMeanABS = nanmean(diff(Noise(:),1,1));
                Pdata(nc).SNRDiffMeanABS = nanmean(diff(SNR(:),1,1));
                Pdata(nc).DiameterDiffMeanABS = nanmean(diff(Diam(:),1,1));
                Pdata(nc).SignalDiffSD = nanstd(diff(Signal(:),1,1));
                Pdata(nc).NoiseDiffSD = nanstd(diff(Noise(:),1,1));
                Pdata(nc).SNRDiffSD = nanstd(diff(SNR(:),1,1));
                Pdata(nc).DiameterDiffSD = nanstd(diff(Diam(:),1,1));

                xyz_real = (xyz -1).*Reso;
                Dx = min( min(xyz_real(:,1)), min(abs(xyz_real(:,1)-FOV(1))) );
                Dy = min( min(xyz_real(:,2)), min(abs(xyz_real(:,2)-FOV(2))) );
                Dz = min( min(xyz_real(:,3)), min(abs(xyz_real(:,3)-FOV(3))) );
                Pdata(nc).DistanceNearestEdgeXY = min([Dx,Dy]);
                Pdata(nc).DistanceNearestEdgeZ = Dz;

%                 TS_WaiteProgress(nc/length(Pdata))
            end
            toc(Time)
            fprintf('Calculate Minimum Vecter Parallelism \n')

            obj.Segment = NewSEG;
            parPdata = Pdata;
            for nc = 1:length(parPdata)
                TS_WaiteProgress((nc-1)/length(Pdata))
                if ~and(parPdata(nc).is_edge,parPdata(nc).ID>0)
                    Pdata(nc).MinimumVecterParallelism = nan;
                    continue
                end
                ID = parPdata(nc).ID;
                xyz_1st = parPdata(nc).PointXYZ(1,:);
                IDs = obj.FindID_xyz(xyz_1st);
                IDs(IDs==ID) = [];
                if isempty(IDs)
                    val_1st = nan;
                else
                    V0 = parPdata(nc).SphereFitUnitVector(1,:);
                    try
                    val_1st = obj.Get_VecterParallelismS(...
                        V0,xyz_1st,obj.ID2Index(IDs),parPdata);
                    catch err
                        val_1st = nan;
                    end
                end


                xyz_end = parPdata(nc).PointXYZ(end,:);
                IDs = obj.FindID_xyz(xyz_end);
                IDs(IDs==ID) = [];
                if isempty(IDs)
                    val_end = nan;
                else
                    V0 = parPdata(nc).SphereFitUnitVector(end,:);
                    try
                    val_end = obj.Get_VecterParallelismS(...
                        V0,xyz_end,obj.ID2Index(IDs),parPdata);
                    catch err
                        val_end = nan;
                    end
                end
                Pdata(nc).MinimumVecterParallelism = ...
                    min(cat(1,val_1st(:),val_end(:)));
            end
            TS_WaiteProgress(1)
            NewSEG.Pointdata = Pdata;
            fprintf('Done...\n')
            toc(Time)
            warning('on','all')
            fprintf('\n\n')
			function NewSEG = InputCheck_AddSpatialPhisicalQuatity(obj,SEG)
        % Used with AddSpatialPhysicalQuantityj
					NewSEG = obj.set_Segment(SEG);
					fprintf([mfilename 'Input check ....'])
					for n = 1:length(NewSEG.Pointdata)
						P = NewSEG.Pointdata(n);
						if P.ID<0
							continue
						end
						if ~isfield(P,'Signal') || ~isfield(P,'Noise') || ~isfield(P,'Diameter') || ...
							~isfield(P,'Theta') || ~isfield(P,'Length')
							error('Input SEG data is wrong structure for this function...ask sugashi')
						end
						if isempty(P.Length) || size(P.PointXYZ,1) ~= length(P.Signal) || ...
							size(P.PointXYZ,1) ~= length(P.Noise) ||...
							size(P.PointXYZ,1) ~= length(P.Diameter) || ...
							size(P.PointXYZ,1) ~= length(P.Theta)
							error('Input SEG data has wrong size for Pointdata ....')
						end
					end
			   end
        end
        function NewSEG = AddNormThetaXY(obj,SEG)
          % NewSEG = self.AddNormThetaXY(SEG)
          %
          % Adds a normal vector angle in the XY plane
          % core function is self.xyz2NormXYplane
            Pdata = SEG.Pointdata;

            for n = 1:length(Pdata)
%                 ID = Pdata(n).ID; %% should do all Segment. Ithink.
                Pdata(n).NormThetaXY = ...
                    obj.xyz2NormXYplane(Pdata(n).PointXYZ,SEG.ResolutionXYZ);
            end
            NewSEG = SEG;
            NewSEG.Pointdata = Pdata;
        end
        function NewSEG = AddAnalysisShoudBeElliptic(obj,SEG)
          % NewSEG = self.AddAnalysisShoudBeElliptic(SEG)
          %
          % Add an index to see if the point should be ellipsed.
          % Core function is self.xyz2Fai_AngleFromAxisZ()
          % Used with AddSpatialPhysicalQuantityj()
          % % % Under development.
            Pdata = SEG.Pointdata;
            SegReso = SEG.ResolutionXYZ;
            siz = SEG.Size;
            FaiLim = obj.EllipticFaiLim;
            LenLim = obj.EllipticLengthLim;

            if siz(3)>1
                for n = 1:length(Pdata)
                    Fai = obj.xyz2Fai_AngleFromAxisZ(Pdata(n).PointXYZ,SegReso);
                    Pdata(n).Fai_AngleFromAxisZ = Fai;
                    Pdata(n).AnalysisShoudBeElliptic =  abs(Fai) > FaiLim;
                end
            else

                for n = 1:length(Pdata)
                    Len = Pdata(n).Length;
                    pnum = size(Pdata(n).PointXYZ,1);
                    Pdata(n).Fai_AngleFromAxisZ = single(nan(pnum,1));
                    Pdata(n).AnalysisShoudBeElliptic = repmat(Len>LenLim,[pnum,1]);
                end
            end
            NewSEG = SEG;
            NewSEG.Pointdata = Pdata;
            NewSEG.EllipticLengthLim = [num2str(LenLim,'%.1f'), ' um'];
            NewSEG.EllipticFaiLim = ...
                    [num2str(FaiLim * 180/pi,'%.0f') ' degree'];
        end
        function NewSEG = BeardExtention(obj,SEG,AddLength)
          % NewSEG = self.BeardExtention(SEG,AddLength)
          % This is protorype. Extend the Branch to End segment.
          %
          %  SEG       : Segmnet DateData
          %  AddLength : Extention Lenght (um)
            NewSEG = SEG;
            Pdata = SEG.Pointdata;
            Reso = SEG.ResolutionXYZ;
            for n = 1:length(Pdata)
                Type = Pdata(n).Type;
                if ~strcmpi(Type,'End to Branch')
                    Pdata(n).ExtantionTF = false(size(Pdata(n).PointXYZ,1),1);
                    continue
                end
                xyz = Pdata(n).PointXYZ([1 end],:);
                b = Pdata(n).Branch;
                len = obj.GetEachLength(xyz,b,Reso);
                len = min(len,[],1);
                [Minimum,ind] = min(len);
                if Minimum ~= 0
                    warning([mfilename ' Branch point is not Correct??, Index:' num2str(n)])
                end
                FlipTF = ind ==1;
                if FlipTF
                    sxyz = xyz(end,:);
                    unitV = Pdata(n).SphereFitUnitVector(end,:);
                else
                    sxyz = xyz(1,:);
                    unitV = (-1)* Pdata(n).SphereFitUnitVector(1,:);
                end

                ExtLen = 0;
                nxyz = sxyz;
                AddXYZ = [];

                while ExtLen < AddLength
                    nxyz = unitV + nxyz;
                    AddXYZ = cat(1,AddXYZ,nxyz);
                    ExtLen = sqrt(sum( ((sxyz - nxyz).^2 ).*Reso ,1));
                end
                XYZ = Pdata(n).PointXYZ;
                TF = false(size(XYZ,1),1);
                ATF = true(size(AddXYZ,1),1);
                if FlipTF
                    XYZ = cat(1,XYZ,AddXYZ);
                    TF = cat(1,TF,ATF);
                else
                    XYZ = cat(1,flip(AddXYZ,1),XYZ);
                    TF = cat(1,ATF,TF);
                end
                Pdata(n).PointXYZ = XYZ;
                Pdata(n).ExtantionTF = TF;
            end
            NewSEG.Pointdata = Pdata;
            NewSEG.BeardExtentionDate = TS_ClockDisp;

        end


        function NewSEG = Euclid_Length_from_arteriovenous(obj,SEG)
            % NewSEG = self.Euclid_Length_from_arteriovenous(SEG)
            %
            % $$ It will not work unless the arteries and veins are classified.
            % Calculate the cumulative Euclidean distance and generation number
            % from the arteriovenous class segment.
            % Use the self.Chase function.
            obj.Segment = SEG;
            [Aid,Vid,Aind,Vind] = obj.FindID_Class_arteriovenous();
%             NewSEG = [];
%             SEG.Pointdata= SEG.Pointdata(Aind);
%             SEGview(SEG)
%             return
            if and(isempty(Aid),isempty(Vid))
                error('Empty Class of arteriovenous.')
            end
            %% setup / clear value
            Pdata = obj.Segment.Pointdata;
%             XYZ_matrix = zeros(2,3,length(Pdata));
%             for n = 1:length(Pdata)
%                 XYZ_matrix(1,:,n) = Pdata(n).PointXYZ(1,:);
%                 XYZ_matrix(2,:,n) = Pdata(n).PointXYZ(end,:);
%             end
%             obj.StartEndXYZ = XYZ_matrix;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % obj.Chase_Limit = 20;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % % Art.
            XYZ = zeros(2*length(Aind),3);
            for n = 1:length(Aind)
                XYZ(n*2-1,:) = Pdata(Aind(n)).PointXYZ(1,:);
                XYZ(n*2,:) = Pdata(Aind(n)).PointXYZ(end,:);
            end
            XYZ = obj.Delete_SamePointXYZ(XYZ);
            fprintf('   ####  Euclid Length from Arteries #### \n')
            obj = obj.Euclid_Length_loop(XYZ,'Art.');
            % % Vei.
            XYZ = zeros(2*length(Vind),3);
            for n = 1:length(Vind)
                XYZ(n*2-1,:) = Pdata(Vind(n)).PointXYZ(1,:);
                XYZ(n*2,:) = Pdata(Vind(n)).PointXYZ(end,:);
            end
            XYZ = obj.Delete_SamePointXYZ(XYZ);
            fprintf('   ####  Euclid Length from Veins #### \n')
            obj = obj.Euclid_Length_loop(XYZ,'Vein');

            % % ArterioVenous
            Pdata = obj.Segment.Pointdata;
            for n = 1:length(Pdata)
                a_dis = Pdata(n).EuclidLength_Arteries;
                v_dis = Pdata(n).EuclidLength_Veins;
                check = nanmin(a_dis,v_dis) == v_dis;
                a_dis(a_dis<1) = 1;
                v_dis(v_dis<1) = -1;
                a_v_dis = a_dis;
                a_v_dis(check) = abs(v_dis(check))*(-1);
                Pdata(n).EuclidLength_ArterioVenous = a_v_dis;
                a_gen = Pdata(n).GenerationsNum_Arteries;
                v_gen = Pdata(n).GenerationsNum_Veins;
                Pdata(n).GenerationsNum_ArterioVenous = nanmin(a_gen,v_gen);
            end
            obj.Segment.Pointdata = Pdata;

            NewSEG = obj.Segment;
        end

        function obj = Euclid_Length_loop(obj,XYZ,Class)
          % Euclid_Length_from_arteriovenous loop function.
            for np = 1:size(XYZ,1)
                xyz = XYZ(np,:);
                try
                    chase_data = obj.Chase(obj.Segment,xyz);
                catch err
                    disp(err.message)
                    fprintf('   .. Go to next.. \n')
                    continue
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Shoud be
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% change >
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% with Chase()
                data = chase_data.Chase;
                Gen = [];
                IDs = [];
                FTF = [];
                for n = 1:length(data)
                    Gen = cat(2,Gen, 1:length(data(n).IDs));
                    IDs = cat(1,IDs, data(n).IDs);
                    FTF = cat(2,FTF, data(n).FlipTFs);
                end
                IDs = IDs';
                DeleteInd = [];
                for n = 1:length(Gen)-1
                    TF1 = Gen(n) == Gen(n+1:end);
                    TF2 = IDs(n) == IDs(n+1:end);
                    TF3 = FTF(n) == FTF(n+1:end);
                    TF = and(and(TF1,TF2),TF3);
                    p = find(TF);
                    if isempty(p)
                        continue
                    end
                    DeleteInd = cat(2,DeleteInd, p+n);
                end
                Gen(DeleteInd) = [];
                IDs(DeleteInd) = [];
                FTF(DeleteInd) = [];
                fprintf([TS_num2strNUMEL(np,3)  '/' num2str(size(XYZ,1)) ' '])
                TS_WaiteProgress(0)
                for k = 1:length(IDs)
                    Ind = obj.ID2Index(IDs(k));
                    obj = obj.Euclid_Length_core(Ind,FTF(k),Gen(k),Class);
                    TS_WaiteProgress(k/length(IDs))
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Shoud be
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% change /
            end
        end

        function obj = Euclid_Length_core(obj,ind,FlipTF,GenerationsNum,Class)
            % Euclid_Length_from_arteriovenous core function.
            Pdata = obj.Segment.Pointdata(ind);
            Reso = obj.Segment.ResolutionXYZ;
            if max(strcmpi(Class,obj.Class_Artery))
                EuName = 'EuclidLength_Arteries';
                GeName = 'GenerationsNum_Arteries';
                skip_TF = max(strcmpi(Pdata.Class,obj.Class_Artery));
            elseif max(strcmpi(Class,obj.Class_Vein))
                EuName = 'EuclidLength_Veins';
                GeName = 'GenerationsNum_Veins';
                skip_TF = max(strcmpi(Pdata.Class,obj.Class_Vein));
            else
                error('input class is not correct or disexist.')
            end
            xyz = Pdata.PointXYZ;
            if skip_TF
                Pdata.(EuName) = zeros(size(xyz,1),1,'single');
                Pdata.(GeName) = 1;
            else
                if FlipTF
                    xyz = flip(xyz,1);
                end
                plen = obj.xyz2plen(xyz,Reso);
                Dist = cumsum(plen);
                % % check Base Distance
                ID = obj.FindID_xyz(xyz(1,:));
                ID(ID==Pdata.ID) = [];
                BaseDist = obj.GetBaseEuclidDist(xyz,ID,EuName);
    %             try
                Dist = Dist + BaseDist;
    %             catch err
    %                 keyboard
    %             end
                if FlipTF
                    Dist = flip(Dist,1);
                end
                check_Dist = Pdata.(EuName);
                Dist = nanmin(Dist,check_Dist);
                Pdata.(EuName) = Dist;
                check_Gene = Pdata.(GeName);
                Pdata.(GeName) = nanmin(GenerationsNum,check_Gene);
            end

            obj.Segment.Pointdata(ind) = Pdata;
        end
        function BaseDist = GetBaseEuclidDist(obj,xyz,ID,Class)
            % BaseDist = GetBaseEuclidDist(xyz[1x3],ID,Class)
            % xyz Must be in self.Pointdata_ID(ID).PointXYZ
            % Used in Euclid_Length_core
            D = nan(length(ID),1);
            for n = 1:length(ID)
                Pdata = obj.Pointdata_ID(ID(n));
                ind = obj.BranchInXYZ(xyz,Pdata.PointXYZ,obj.Segment.ResolutionXYZ);
                Dist = Pdata.(Class);
                if or(isempty(ind),isnan(ind))
                    D(n) = 0;
                else
                    %% some time length(ind) > 1
                    D(n) = min(Dist(ind)); %%
                end
            end
            BaseDist = nanmin(D);
            if isempty(BaseDist)
                BaseDist = 0;
            end
        end


        %%% for capillaro
        function [NewSEG,IDs] = ReSEG_Capillaro_bag(obj,SEG)
            % This is protorype
            ReSegLen = 50; %% um
            Pdata = SEG.Pointdata;
            Reso = SEG.ResolutionXYZ;
            for n = 1:length(Pdata)
                Type = Pdata(n).Type;
                if strcmpi(Type,'Branch to Branch')
                    Pdata(n).pVal = [];
                    Pdata(n).EndPoint_selfID = [];
                    continue
                end

                xyz = Pdata(n).PointXYZ([1 end],:);

                if strcmpi(Type,'End to Branch')
                    b = Pdata(n).Branch;
                    len = obj.GetEachLength(xyz,b,Reso);
                    len = min(len,[],1);
                    [Minimum,ind] = min(len);
                    if Minimum ~= 0
                        warning([mfilename ' Branch point is not Correct??, Index:' num2str(n)])
                    end
                    FlipTF = ind ==1;
                    if FlipTF
                        x = xyz(1,1);y = xyz(1,2);
                        selfIDs = [Pdata(n).ID size(xyz,1), x, y];
                        unitV = Pdata(n).SphereFitUnitVector(end,:);
                    else
                        x = xyz(end,1);y = xyz(end,2);
                        selfIDs = [Pdata(n).ID 1,x,y];
                        unitV = (-1)* Pdata(n).SphereFitUnitVector(1,:);
                    end
                else
                    selfIDs = [Pdata(n).ID 1;
                               Pdata(n).ID size(xyz,1)];
                    x = xyz([1 end],1);y = xyz([1 end],1);
                    selfIDs = cat(2,selfIDs,x,y);
                    unitV = [ (-1)* Pdata(n).SphereFitUnitVector(1,:);
                             Pdata(n).SphereFitUnitVector(end,:)];
                end
                pVal = zeros(size(x,1),2);
                for k = 1:size(x,1)
                    a = unitV(k,2)/unitV(k,1);
                    b = y(k) - a*x(k);
                    pVal(k,:) = [a b];
                end
                Pdata(n).pVal = pVal;
                Pdata(n).EndPoint_selfID = selfIDs;
            end
            SelfID = cat(1,Pdata.EndPoint_selfID);
            Pval = cat(1,Pdata.pVal);
            IDs = {};
            IDcounter = 1;
            for n = 2:size(Pval,1)
                a = Pval(n-1,1);b = Pval(n-1,2);
                Refxyz = [SelfID(n-1,3:4) 0];
                Len_check = nan(1,length(n:size(Pval,1)));
                counter = 1;
                ID_check = Len_check;
                for k = n:size(Pval,1)
                    Targetxyz = [SelfID(k,3:4) 0];
                    c = Pval(k,1);  d = Pval(k,2);
                    cx = (d-b)/(a-c);
                    cy = cx*c+d;
                    len1 = obj.GetEachLength([cx,cy,0],cat(1,Refxyz,Targetxyz),Reso);
                    len2 = obj.GetEachLength(Refxyz,Targetxyz,Reso);
                    len = cat(1,len1(:),len2(:));
                    Len_check(counter) = max(len);
                    ID_check(counter) = SelfID(k,1);
                    counter = counter + 1;
                end
                [Dist,Ind] = min(Len_check);

                if Dist < ReSegLen
                    IDs{IDcounter,1} = [SelfID(n-1,1) ID_check(Ind)];
                    IDcounter = IDcounter +1;
                end
            end

            %% having bag...
            TF = true(size(IDs,1),1);
            for c = 1:size(IDs,1)
                check = IDs{c,:};
                if check(1) == check(2)
                    TF(c) = false;
                end
            end
            IDs = IDs(TF,:);
            %%

            keyboard
            NewSEG = obj.Connect(SEG,IDs);
        end

        function [NewSEG,Mov] = ReSEG_Capillaro(obj,SEG)
            Pdata = SEG.Pointdata;
            ConnectLengthX = 100;
            ConnectLengthY = 10;
            FindingLim = 5;
            TargetIndIDxyz = [];

            for n = 1:length(Pdata)
                ID = Pdata(n).ID;
                xyz = Pdata(n).PointXYZ;
                [~,ind] = min(xyz(:,2));
                ymin_xyz = xyz(ind,:);
                xyz1 = xyz(1,:);
                xyz2 = xyz(end,:);
                len1 = obj.GetEachLength(xyz1,ymin_xyz,SEG.ResolutionXYZ);
                len2 = obj.GetEachLength(xyz2,ymin_xyz,SEG.ResolutionXYZ);
                if len1<FindingLim && len2<FindingLim
                    continue
                end
                if len1<FindingLim
                    TargetIndIDxyz = cat(1,TargetIndIDxyz,[n ID xyz1 0]);
                end
                if len2<FindingLim
                    TargetIndIDxyz = cat(1,TargetIndIDxyz,[n ID xyz2 1]);
                end
            end
            Inds = {};
            c = 1;
            p = SEGview(SEG,'ID');
            axh = gca;p.LineWidth = 4;slice = 1;
            colormap(rand(length(Pdata),3));
            hold on
            x = TargetIndIDxyz(:,3);y = TargetIndIDxyz(:,4);
            plot((x-1)*SEG.ResolutionXYZ(1),(y-1)*SEG.ResolutionXYZ(1),'o')
            ph = plot([0 1],[0 1],'o-');
            for n = 2:size(TargetIndIDxyz,1)
                Indref = TargetIndIDxyz(n-1,1);
                Rexyz = TargetIndIDxyz(n-1,3:5);
                ReFlip = TargetIndIDxyz(n-1,6);
                for k = n:size(TargetIndIDxyz,1)
                    Indtar = TargetIndIDxyz(k,1);
                    if isnan(Indtar)
                        continue
                    end
                    Txyz = TargetIndIDxyz(k,3:5);
                    TFlip = TargetIndIDxyz(k,6);
                    ph.XData = ([Rexyz(1) Txyz(1)]-1).*SEG.ResolutionXYZ(1);
                    ph.YData = ([Rexyz(2) Txyz(2)]-1).*SEG.ResolutionXYZ(2);
                    drawnow,pause(.05),Mov(slice) = getframe(axh.Parent);slice = slice+1;
                    lenx = abs(Rexyz(1) -Txyz(1))*SEG.ResolutionXYZ;
                    leny = abs(Rexyz(2) -Txyz(2))*SEG.ResolutionXYZ;
                    if and((lenx <=ConnectLengthX),(leny<=ConnectLengthY))
                        TargetIndIDxyz(k,:) = nan;
                        Inds{c} = [Indref, Indtar, ReFlip, TFlip];
                        c = c+ 1;
                        plot(ph.XData,ph.YData,'r-')
                        break
                    end
                end
            end
            ID = abs(cat(1,Pdata.ID));
            MaxID = max(ID);
            for n = 1:length(Inds)
                CC = Inds{n};
                Ind1 = CC(1);
                Ind2 = CC(2);
                IndF1 = CC(3);
                IndF2 = CC(4);
                Pdata(Ind1).ID = -abs(Pdata(Ind1).ID);
                Pdata(Ind2).ID = -abs(Pdata(Ind2).ID);
                Pdata(end+1).ID = MaxID + n;
                xyz1 = Pdata(Ind1).PointXYZ;
                xyz2 = Pdata(Ind2).PointXYZ;
                if IndF1==0
                    xyz1 = flipud(xyz1);
                end
                if IndF2 ==1
                    xyz2 = flipud(xyz2);
                end
                xyz = cat(1,xyz1,xyz2);
                Pdata(end).PointXYZ = xyz;
                Pdata(end).Branch = cat(1,Pdata(Ind1).Branch,Pdata(Ind2).Branch);
                Pdata(end).Type = 'End to End'; %%%% force clasifier
                len = obj.xyz2plen(xyz,SEG.ResolutionXYZ);
                Pdata(end).Length = sum(len);
                Pdata(end).Class = 'others';
                Pdata(end).Diameter = nan(size(xyz,1),1);
                Pdata(end).Signal = nan(size(xyz,1),1);
                Pdata(end).Noise = nan(size(xyz,1),1);
                Pdata(end).Theta = nan(size(xyz,1),1);
                Pdata(end).NewXYZ = nan(size(xyz,1),1);
                Pdata(end).MEMO =['Connected from' num2str(Ind1) ', ' num2str(Ind2)] ;
                Pdata(end).OriginalPointXYZ = xyz;
            end
            NewSEG = SEG;
%
%             Pdata = NewSEG.Pointdata;
%             ID = cat(1,Pdata.ID);
%             Pdata = Pdata(ID>0);
            NewSEG.Pointdata = Pdata;
        end


        function NewSEG = SmoothingSEG(obj,SEG,NewStep,XYZrange)
            % NewSEG = self.SmoothingSEG(SEG,NewStep,XYZrange)
            %
            % SEG      : Segment data.
            % NewStep  : Resampling ratio [um/voxel]
            % XYZrange : Reference windows Size for smoothing. [X,Y,Z] [um]
            obj.ResamplingRate = NewStep;
            obj.ResamplingDenoiseWindowSize = XYZrange;
            NewSEG = obj.ResampllingSEG(SEG);
        end
        function NewSEG = ResampllingSEG(obj,SEG)
            % NewSEG = SmoothingSEG(obj,SEG,NewStep,XYZrange)
            % NewStep \ um
            % XYZrange = [X,Y,Z] ,,, TS_MovingAverage window size
            NewStep = obj.ResamplingRate;
            XYZrange = obj.ResamplingDenoiseWindowSize;
            if length(XYZrange)<3
                XYZrange = repmat(XYZrange,[1 3]);
            end

            Step = NewStep; % um
            if XYZrange(1) ~= XYZrange(2)
                error('Incorrect input')
            end
            xy_range = XYZrange(1); %11; % um
            z_range = XYZrange(3); %11; % um
            Pdata = SEG.Pointdata;
            Reso = SEG.ResolutionXYZ;
            for n = 1:length(Pdata)
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                try
                    xyz = Pdata(n).OriginalPointXYZ;%%%%%
                    if isempty(xyz)
                        xyz = Pdata(n).PointXYZ;
                        Pdata(n).OriginalPointXYZ = xyz;
                    end
                catch err
                    xyz = Pdata(n).PointXYZ;
                    Pdata(n).OriginalPointXYZ = xyz;
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                Branch = Pdata(n).Branch;
                Branch(isnan(Branch(:,1)),:) = [];
                [~,P] = obj.BranchInXYZ(Branch,xyz,Reso);
                if length(P)>=2
%                     NewXYZ = zeros(size(xyz));
                    NewXYZ = [];
                    for pn = 2:length(P)
                        peace_xyz = xyz(P(pn-1):P(pn),:);
%                         NewXYZ(P(pn-1):P(pn),:) = resampling(obj,...
%                             peace_xyz,Reso,Step,xy_range,z_range);
                        resamplingXYZ = resampling(obj,...
                            peace_xyz,Reso,Step,xy_range,z_range);
                        if pn == 2
                            resamplingXYZ(end,:) = [];
                        end
                        NewXYZ = cat(1,NewXYZ,resamplingXYZ);
                    end
                else
                    NewXYZ = resampling(obj,xyz,Reso,Step,xy_range,z_range);
                end
                NewXYZ = obj.CutOverlappingPoint(NewXYZ);
                len = obj.xyz2plen(NewXYZ,Reso);
                Pdata(n).PointXYZ = NewXYZ;
                Pdata(n).Length = sum(len);
            end
            SEG.Pointdata = Pdata;
            SEG.ResamplingRate = [num2str(obj.ResamplingRate,'%.1f') ' um'];
            SEG.ResamplingInterpWindwSize = [num2str(obj.ResamplingDenoiseWindowSize,'%.1f') ' um'];
            NewSEG = SEG;
            NewSEG.Resampling = TS_ClockDisp;
            function Newxyz = resampling(obj,xyz,Reso,Step,xyR,zR)
                % Newxyz = self.resampling(xyz,Reso,Step,xyR,zR)
                %
                % xyz     : pre-resamplingXYZ
                % Reso    ; Resolution of pre-resamplingXYZ
                % Step    : New resampling ratio.
                % xyR     : Reference radius for smoothing in XY -axis.
                % zR      : Reference radius for smoothing in Z -axis.
                if size(xyz,1)==1
                    Newxyz = xyz;
                    return
                end

                Elen = obj.xyz2plen(xyz,Reso);
                if length(Elen)>1
                    if max(Elen(2:end)==0)
                        Deletep = Elen==0;
                        Deletep(1) = false;
                        xyz(Deletep,:) =[];
                        Elen = obj.xyz2plen(xyz,Reso);
                    end
                end
                max_len = sum(Elen);
                % % Resampling % % %
                Resample = linspace(0,max_len,ceil(max_len/Step));
                NewReso = max_len/(length(Resample)-1);
                Elen_p = cumsum(Elen);
                Type = 'pchip';
%                 fgh = figure;
%                 axh = TS_subplot(fgh,[1 3]);
%                 plot(axh(1),xyz(:,1),'o:'),...
%                     hold on,plot(axh(1),wiener2(xyz(:,1),[3 1]),'o:')
%                 plot(axh(2),xyz(:,2),'o:'),...
%                     hold on,plot(axh(2),wiener2(xyz(:,2),[3 1]),'o:')
%                 plot(axh(3),xyz(:,3),'o:'),...
%                     hold on,plot(axh(3),wiener2(xyz(:,3),[3 1]),'o:')
                Nx = interp1(Elen_p,xyz(:,1),Resample,Type);
                Ny = interp1(Elen_p,xyz(:,2),Resample,Type);
                Nz = interp1(Elen_p,xyz(:,3),Resample,Type);

                % % Smootihing % %
                Nxq = TS_MovingAverage(Nx,ceil(xyR/NewReso));
                Nyq = TS_MovingAverage(Ny,ceil(xyR/NewReso));
                Nzq = TS_MovingAverage(Nz,ceil(zR/NewReso));
%                 if length(Nx) ~= length(Nxq) || length(Ny) ~= length(Nyq)...
%                         || length(Nz) ~= length(Nzq)
%                 end
%                 waitfor(fgh)
                Newxyz = cat(2,Nxq(:),Nyq(:),Nzq(:));
                if sum(diff(cat(1,Newxyz(1,:),xyz(1,:)),[],1))~=0
                    Newxyz = cat(1,xyz(1,:),Newxyz);
                end
                if sum(diff(cat(1,Newxyz(end,:),xyz(end,:)),[],1))~=0
                    Newxyz = cat(1,Newxyz,xyz(end,:));
                end

            end
        end
        function NewSEG = SmoothingSEG_Bspline(obj,SEG,NewStep)
            % NewSEG = SmoothingSEG_Bspline(obj,SEG,NewStep)
            % NewStep \ um
            % Core Function is obj.BsplineFunc, obj.xyzSmooth_Bspline
            %
            % Under developing.
            %  (c) Hiroki Suzuki.

            Step = NewStep; % um
            SEG = obj.set_Segment(SEG);
            Pdata = SEG.Pointdata;
            Reso = SEG.ResolutionXYZ;
            for n = 1:length(Pdata)
                xyz = Pdata(n).PointXYZ;
                Branch = Pdata(n).Branch;
                Branch(isnan(Branch(:,1)),:) = [];
                [~,P] = obj.BranchInXYZ(Branch,xyz,Reso);
                NewXYZ = [];
                if length(P)>=2
                    for pn = 2:length(P)
                        peace_xyz = xyz(P(pn-1):P(pn),:);
                        resamplingXYZ = obj.xyzSmooth_Bspline_Reso(peace_xyz,Reso,Step);
                        NewXYZ = cat(1,NewXYZ,resamplingXYZ);
                    end
                    Plen = obj.xyz2plen(NewXYZ,Reso);
                    DeleteInd = Plen ==0;
                    DeleteInd(1) = false;
                    NewXYZ(DeleteInd,:) = [];
                else
                    NewXYZ = obj.xyzSmooth_Bspline_Reso(xyz,Reso,Step);
                end
                len = obj.xyz2plen(NewXYZ,Reso);
                Pdata(n).PointXYZ = NewXYZ;
                Pdata(n).Length = sum(len);
            end
            SEG.Pointdata = Pdata;
            SEG.Resampling = mfilename;
            NewSEG = obj.set_Segment(SEG);
        end
        %% Support Functions
        function val = Get_VecterParallelismS(obj,V0,xyz,Indexis,Pdata)
            Indexis(isnan(Indexis)) = [];
            val = zeros(length(Indexis),1);
            for k = 1:length(Indexis)
                try
                obj_xyz = Pdata(Indexis(k)).PointXYZ;
                catch
                    keyboard
                end
                p = and( and( ...
                    single(obj_xyz(:,1)) == single(xyz(1)) , ...
                    single(obj_xyz(:,2)) == single(xyz(2)) ) , ...
                    single(obj_xyz(:,3)) == single(xyz(3)) );

                V = Pdata(Indexis(k)).SphereFitUnitVector(p,:);
                if isempty(V)
                    warning(['Find ID error?? XYZ : ' num2str(xyz,'%f, %f, %f')])
                    V = nan(1,3);
                elseif sum(p)>1
                    pf = find(p);
                    V = Pdata(Indexis(k)).SphereFitUnitVector(pf(1),:);
                end
                val(k) = obj.Evaluate_2VecterParallelism(V0,V);
            end
            if isempty(val)
                val = nan;
            end
        end

        function PieaceDist = DistanceFromBranch(obj,xyz,Branch,Reso)
            Branch(isnan(Branch(:,1)),:) = [];
            [P,Pd] = obj.BranchInXYZ(Branch,xyz,Reso);
            PieaceDist = nan(size(xyz,1),1);
            if length(P)>=1
                EndPd = true(1,length(Pd));
                for n = [1, length(Pd)]
                    EndPd(n) = max(Pd(n)==P);
                end
                for pn = 1:length(Pd)-1
                    peace_xyz = xyz(Pd(pn):Pd(pn+1),:);
                    if pn==1
                        if ~EndPd(1)
                            D = obj.xyz2plen(flip(peace_xyz,1),Reso);
                            cD = flip(cumsum(D),1);
                        else
                            cD = Function_Branchdistance(obj,peace_xyz,Reso);
                        end
                    elseif pn==length(Pd)-1
                        if ~EndPd(end)
                            D = obj.xyz2plen(peace_xyz,Reso);
                            cD = cumsum(D);
                        else
                            cD = Function_Branchdistance(obj,peace_xyz,Reso);
                        end
                    else
                        cD = Function_Branchdistance(obj,peace_xyz,Reso);
                    end
                    PieaceDist(Pd(pn):Pd(pn+1)) = cD(:);
                end
            end
            function Distance = Function_Branchdistance(obj,xyz,Reso)
                Di = obj.xyz2plen(xyz,Reso);
                cDi1 = cumsum(Di);
                Di = obj.xyz2plen(flip(xyz,1),Reso);
                cDi2 = flip(cumsum(Di),1);
                Distance = min(cat(2,cDi1,cDi2),[],2);
            end
        end

        function check_Pairs(obj,Pairs)
            if ~iscell(Pairs)
                error('Input "Pair(s)" is NOT cell class.')
            end
            if ~isvector(Pairs)
                error('Input "Pair(s)" is NOT vector.')
            end
            check_Ind = [];
            for n = 1:length(Pairs)
                Ind = Pairs{n};
                if ~isvector(Ind)
                    error('Input Ind data in Pairs is NOT vector.')
                end
                if numel(Ind) <= 1
                    error('Input Ind data in Pairs should NOT BE less than 1 Numel.')
                end
                check_Ind = cat(1,check_Ind,Ind(:));
            end
            Diff_Ind = diff(sort(single(check_Ind)));
            p = find(Diff_Ind==0);
            if ~isempty(p)
                fprintf(['\n    Error. Overlap Numbers : ' num2str(check_Ind(p)) '\n'])
                error('Input Index has included same Index')
            end
        end
        function Index = ID2Index(obj,Pairs,varargin)
            if nargin ==3
                catID = varargin{1};
            else
                catID = cat(1,obj.Segment.Pointdata.ID);
            end
            %%%%%%%%%%%%%%%%%% debug %%%%2019 09 13 %%%%%%%%%%%
            catID = abs(catID);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            output_cell2mat = false;
            if ~iscell(Pairs)
                output_cell2mat = true;
                Pairs = {Pairs};
            end

             Index = Pairs;
             for x = 1:length(Pairs)
                 ID = Pairs{x};
                 for k = 1:length(ID)
                     try
                     ID(k) = find(ID(k) == catID);
                     catch err
                         fprintf(['\n  ' err.message '\n'])
%                          warning([' Finding ' num2str(ID(k)) ', but Not existing...NaN return.'])
                         ID(k) = nan;
                     end
                 end
                 Index{x} = ID;
             end
             if output_cell2mat
                 Index = cell2mat(Index);
             end

        end
        function NewSEG = ...
                ResamplingIDs_Emargency_existing_Same_IDs(obj,SEG)
            catID = cat(1,SEG.Pointdata.ID);
            Pdata = SEG.Pointdata;
            MaximumID = max(abs(catID)) +1 ;
            [sortID,sort_index] = sort(catID);
            check_sameIDs = diff(sortID) == 0;
            if sum(check_sameIDs) == 0
                fprintf('Any IDs is NOT OVERLAP!!!\n   Return... \n')
                NewSEG = SEG;
                return
            end
            check_sameIDs = [check_sameIDs ; false];
            checkIDs = sortID(check_sameIDs);
            for n = 1:length(checkIDs)
                index = find(catID == checkIDs(n));
                for k = 2:length(index)
                    Pdata(index(k)).ID = MaximumID;
                    MaximumID = MaximumID + 1;
                end
                clear index
            end
            NewSEG = SEG;
            NewSEG.Pointdata = Pdata;
        end

        function NewSEG = ReCheckType(obj)
            Pdata = obj.Segment.Pointdata;
            c = 0;
            for k = 1:length(Pdata)
                if Pdata(k).ID > 0
                    xyz = Pdata(k).PointXYZ;
                    %% Check Type 2019.06.13, edit %%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    % End point    --> 1,
                    % Branch point --> 3,
                    % So,
                    % E2E   = 2,  E2B = 4, B2B = 6
                    Check_Edge = nan(1,2);
                    check_xyz = xyz([1 end],:);
                    for n =1:2
%                       %%% Id_count = obj.FindID_xyz_edge(check_xyz(n,:));
                        % If Parent Vascular has some branch point,...
                        % it shoud not be used obj.FindID_xyz_edge func..
                        Id_count = obj.FindID_xyz(check_xyz(n,:));
                        Id_count(isnan(Id_count)) = [];
                        if numel(Id_count)>1
                            Check_Edge(n) = 3;
                        else
                            Check_Edge(n) = 1;
                        end
                    end
                    Check_Edge = sum(Check_Edge);
                    if Check_Edge == 2
                        SegmentType = 'End to End';
                    elseif Check_Edge == 4
                        SegmentType = 'End to Branch';
                    elseif Check_Edge == 6
                        SegmentType = 'Branch to Branch';
                    else
                        SegmentType = 'Others';
                    end
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    if ~strcmpi(SegmentType,Pdata(k).Type)
                        fprintf([' ID : ' num2str(Pdata(k).ID) ...
                            ', Type : ' Pdata(k).Type])
                        fprintf(['\n        to   ' SegmentType '\n\n'])
                        Pdata(k).Type = SegmentType;
                        c = c + 1;
                    end
                else
                    Pdata(k).Type = 'Others';
                end
            end
            obj.Segment.Pointdata = Pdata;
            NewSEG = obj.Segment;
            fprintf(['   Changed # ' num2str(c) '\n'])
        end
        
        function NewSEG = HigherResolutionOfBranchCoordinates(obj,SEG,cbw)
            
            if ~max(SEG.Size==size(cbw,[1 2 3]))
                error('Input BW is not Correct Size')
            end
            
            NewSEG = SEG;
            Pdata = SEG.Pointdata;
            
            
        end


        function [index,Type] = Find_EndSEG(obj,Pdata)
            index_E2E = false(length(Pdata),1);
            index_E2B = false(length(Pdata),1);
            index_B2B = false(length(Pdata),1);
            for n  = 1:length(Pdata)
                index_E2E(n) = strcmpi(Pdata(n).Type,'End to End');
                index_E2B(n) = strcmpi(Pdata(n).Type,'End to Branch') ;
                index_B2B(n) = strcmpi(Pdata(n).Type,'Branch to Branch') ;
            end
            End_Exist = or(max(index_E2E),max(index_E2B));
            Branch_Exist = or(max(index_B2B),max(index_E2B));
            if ~Branch_Exist
                Type = 'End to End';
            elseif and(End_Exist,Branch_Exist)
                Type = 'End to Branch';
            else
                Type = 'Branch to Branch';
            end
            if max(index_E2E)
                index = index_E2E;
            elseif and(max(index_E2B),~max(index_E2E))
                index = index_E2B;
            else
                index = true;
            end
            p = find(index);
            index = p(1);
        end
        function [Index,TF_flip_Parent,TF_flip_Foward,Err] =...
                FindNearestID(obj,xyz1,Pdata,sort_index,Reso)
            % just use for Connect Func.
            p = find(sort_index);
            xyz2 = zeros(length(p)*2,3);
            for n  = 1:length(p)
                D = Pdata(p(n));
                xyz2((n*2-1):n*2,:) = D.PointXYZ([1, end],:);
            end
            xyz1 = xyz1([1, end],:);
            Len_map = obj.GetEachLength(xyz1,xyz2,Reso);

            [len1,ind1] = min(Len_map(:,1));
            ind1 = ind1(1);
            [len2,ind2] = min(Len_map(:,2));
            ind2 = ind2(1);


            if ~(len1==0 || len2 ==0)
                Err = 'Error : None Share Branch Point';
            else
                Err = [];
            end
            if len1 <= len2
                Index = p(ceil(ind1/2));
                TF_flip_Parent = true;
                TF_flip_Foward = ceil(ind1/2) == floor(ind1/2);
            elseif len1 > len2
                Index = p(ceil(ind2/2));
                TF_flip_Parent = false;
                TF_flip_Foward = ceil(ind2/2) == floor(ind2/2);
            end
        end

        %% Chase Vascular Segment ,Core Func.
        function [IDs,FlipTFs] = FindNextSegment(obj,ID,FlipTF,varargin)
            % ID must Be 1 numel
            %% %% %% Cat Limit #################
            CatLimit = obj.Chase_Limit;%%%%%%%%%%%%%%%%%%%%%%%
            %% %% %% %%#################%%%%%%%%
            catID = cat(1,obj.Segment.Pointdata.ID);
            XYZ = obj.StartEndXYZ;
            SegInd = catID == ID;
            if FlipTF
                xyz = XYZ(1,:,SegInd);
            else
                xyz = XYZ(2,:,SegInd);
            end
            if nargin ==3 % when starting
                chase_index= find(SegInd);
                chase_FlipTFs = FlipTF;
                IDs = [];
                FlipTFs = [];
%                 fprintf(['# # # # # # # # # # # # # # # # # # # # \n',...
%                     '# # Starting "Chasing Segmentations"# # \n',...
%                     '# # # # # # # # # # # # # # # # # # # # \n'])
            else
                chase_index= [varargin{1}, find(SegInd)];
                chase_FlipTFs = [varargin{2}, FlipTF];
                IDs = varargin{3};
                FlipTFs = varargin{4};
                %fprintf(['-' num2str(chase_index(end))])
            end

            if length(chase_index)>1
                XYZ = obj.StartEndXYZ;
                XYZ = XYZ(:,:,chase_index(1:end-1));
                AlredyIndex = obj.FindSameStartEndXYZ(xyz,XYZ);
                check_same_branch_TF = max(AlredyIndex(:));
            else
                check_same_branch_TF = false;
            end
            SameIndex =squeeze(obj.FindSameStartEndXYZ(xyz));
            NextIndex = SameIndex;
            NextIndex(:,chase_index) = false;
            if and(max(NextIndex(:)),~check_same_branch_TF) && length(IDs)< CatLimit
                [y,x] = find(NextIndex);
                for n = 1:length(y)
                    [IDs,FlipTFs] = obj.FindNextSegment(...
                        catID(x(n)),y(n)==2,chase_index,chase_FlipTFs,...
                        IDs,FlipTFs);
                end
            else  %% End point
%                 fprintf(['==== ==== ==== ==== \n No.' num2str(size(IDs,1)) '    Numels :' num2str(length(chase_index)) ' \n'])
%                 fprintf(['   Indexs : ' num2str(chase_index) '\n'])
%                 fprintf(['      IDs : ' num2str(reshape(catID(chase_index),1,[])) '\n'])
                IDs = cat(1,IDs,{catID(chase_index)});
                FlipTFs = cat(1,FlipTFs,{chase_FlipTFs});
            end
        end
        function index = FindSameStartEndXYZ(obj,xyz,varargin)
            if nargin ==2
                XYZ = obj.StartEndXYZ;
            else
                XYZ = varargin{1};
            end
            Xtf = XYZ(:,1,:) == xyz(1);
            Ytf = XYZ(:,2,:) == xyz(2);
            Ztf = XYZ(:,3,:) == xyz(3);
            index = and( and( Xtf, Ytf ), Ztf);
        end
        function [IDs,Dist,SeparateXYZ] = Find_NearSegment_xyz(obj,xyz,Minimum)
            % [IDs,Dist,SeparateIndex] = self.Find_NearSegment_xyz(xyz,Minimum)
            %
            % Input : 
            %  xyz   : [x,y,z] 1x3 vector
            %  Minimum : Minimum Distance for search.
            %
            % Output : 
            %   IDs    : IDs [1xn]
            %   Dist   : Distance from xyz, [1xn]
            %   SeparateIndex : if Nearest index is not edge of Segment,
            %    indicates separate index of PointXYZ in IDs. if edge, NaN.
            
            SEG = obj.Segment;
            selfID = obj.FindID_xyz(xyz);
            selfIndex = obj.ID2Index(selfID);
            SEG.Pointdata(selfIndex).ID = abs(SEG.Pointdata(selfIndex).ID)*(-1);
            obj.Segment = SEG;
            
            XYZ = [];
            catID = [];
            for n = 1:length(SEG.Pointdata)
                if SEG.Pointdata(n).ID<0
                    continue
                end
                XYZ = cat(1,XYZ,SEG.Pointdata(n).PointXYZ);
                catID = cat(1,catID,...
                    repmat(SEG.Pointdata(n).ID,[size(SEG.Pointdata(n).PointXYZ,1),1]));
            end
            
            len = obj.GetEachLength(xyz,XYZ,SEG.ResolutionXYZ);
%             keyboard
            ind = len <= Minimum;
            
            len(~ind) = [];
            IDs = catID(ind);
            Dist = len;
            SeparateXYZ = XYZ(ind,:);
        end
        function [XYZ,IDs] = Get_EndPointXYZ(obj)
            %  [XYZ,IDs] = self.Get_EndPointXYZ()
            Pdata = obj.Segment.Pointdata;
            XYZ = [];
            IDs = [];
            for n = 1:length(Pdata)
                if Pdata(n).ID < 0
                    continue
                end
                if strcmpi((Pdata(n).Type),'End to End')
                    XYZ = cat(1,XYZ,Pdata(n).PointXYZ([1 end],:));
                    IDs = cat(1,IDs,repmat(Pdata(n).ID,[2 1]));
                elseif strcmpi((Pdata(n).Type),'End to Branch')
                    IDs = cat(1,IDs,Pdata(n).ID);
                    xyz = Pdata(n).PointXYZ(1,:); % first point
                    Branch = Pdata(n).Branch;
                    TFx = xyz(1) == Branch(:,1);
                    TFy = xyz(2) == Branch(:,2);
                    TFz = xyz(3) == Branch(:,3);
                    TF = max(and(and(TFx,TFy),TFz));
                    if TF
                        XYZ = cat(1,XYZ,xyz);
                        continue
                    end
                    xyz = Pdata(n).PointXYZ(end,:);% last Point
                    TFx = xyz(1) == Branch(:,1);
                    TFy = xyz(2) == Branch(:,2);
                    TFz = xyz(3) == Branch(:,3);
                    TF = max(and(and(TFx,TFy),TFz));
                    if TF
                        XYZ = cat(1,XYZ,xyz);
                        continue
                    end
                end
                
            end
        end
        function data = Suggestion_ReConnection(obj,varargin)
            % data = self.SReConnection(varargin)
            % if nargin ==2 
            %    Minimum = varargin{1};
            % else
            %    Reso = obj.Segment.ResolutionXYZ;
            %    Minimum = sqrt(sum(Reso.^2));
            % end
            
            if nargin ==2 
                Minimum = varargin{1};
            else
                Reso = obj.Segment.ResolutionXYZ;
                Minimum = sqrt(sum(Reso.^2))*3.5; %%% experimental value
                Minimum = max(Reso)*sqrt(3)*1.5;%%% experimental value
            end
            
            [XYZ,selfIDs] = obj.Get_EndPointXYZ();
            
            data = struct('Target_XYZ',[],'Target_ID',[],...
                'Found_IDs',[],'Found_Dist',[],...
                'Found_SeparateIndex',[]);
            c = 1;
            for n = 1:size(XYZ,1)
                [IDs,Dist,SeparateIndex] = ...
                    obj.Find_NearSegment_xyz(XYZ(n,:),Minimum);
                if isempty(IDs)
                    continue
                end
                data(c).Target_XYZ = XYZ(n,:);
                data(c).Target_ID = selfIDs(n);
                data(c).Found_IDs = IDs;
                data(c).Found_Dist = Dist;
                data(c).Found_SeparateXYZ = SeparateIndex;
                c =c +1;
            end
        end
        
        
        function [Newxyz,CutInd,Label] = CutOverlappingPoint(~,xyz)
            XYZ = xyz;
            Label = zeros(size(xyz,1),1);
            c = 1;
            CutInd = false(size(xyz,1),1);
            for n = 1:size(xyz,1)
                if Label(n)==0
                    f = xyz(n,:);
                    XYZ(n,:) = nan;
                    Label(n) = c;
                    tf = true(size(xyz,1),1);
                    for t = 1:length(f)
                        tf = and(tf,f(t)==XYZ(:,t));
                    end
                    XYZ(tf,:) = nan;
                    Label(tf) = c;
                    CutInd = or(CutInd,tf);
                    c = c+1;
                else
                    continue
                end
            end
            Newxyz = xyz(~CutInd,:);
        end
        function [MinimumLength,IndexSort] = check_xyz_sort(obj,p1,p2,Reso)
            p1= cat(1,p1(1,:),p1(end,:));
            p2= cat(1,p2(1,:),p2(end,:));
            MapLen = obj.GetEachLength(p1,p2,Reso);
            [MinimumLength,IndexSort] = min(MapLen(:));
        end

        function Len_map = GetEachLength(obj,xyz1,xyz2,Reso)
            Len_map = zeros(size(xyz2,1),size(xyz1,1));
            for n = 1:size(xyz1,1)
                select = xyz1(n,:);
                select = repmat(select,[size(xyz2,1) 1]);
                LEN = (xyz2 - select) .* repmat(Reso(1:3),[size(xyz2,1) 1]);
                LEN = sqrt(sum(LEN .^2 , 2));
                Len_map(:,n) = LEN;
            end
        end
        function Branch = CheckBranch(obj,xyz,NewBranch,Reso)
            % just use for Connect Fucn.
            Branch = [];
            for n = 1:size(xyz,1)
                xyz1 = xyz(n,:);
                len  = obj.GetEachLength(xyz1,NewBranch,Reso);
                check_branch = len(:,1) == 0;
                Branch = cat(1,Branch,NewBranch(check_branch,:));
            end
            if isempty(Branch)
                Branch = nan(1,3);
            end
        end

        function [BranchIndex,AddEdgeIndex] = BranchInXYZ(obj,Branch,xyz,Reso)
            if isempty(Branch)
                BranchIndex = [];
                AddEdgeIndex = [];
                return
            end
            p = nan(1,size(Branch,1));
            for n = 1:length(p)
                b = Branch(n,:);
                x = single(xyz(:,1)) == single(b(1));
                y = single(xyz(:,2)) == single(b(2));
                z = single(xyz(:,3)) == single(b(3));
                P = find(and(and(x,y),z));
                if isempty(P)
                    len = obj.GetEachLength(xyz,b,Reso);
                    [~,ind] = min(len);
                    p(n) = ind(1);
                elseif numel(P) > 1
%                     error('Same Point are existing in Input Segment')
%                     warning('Same Point are existing in Input Segment')
                    p(n) = P(1);
                else
                    p(n) = P;
                end
            end
            p(isnan(p)) = [];
            BranchIndex = sort(p);
            AddEdgeIndex = BranchIndex;
            if ~max(BranchIndex==1)
                AddEdgeIndex = [1, AddEdgeIndex];
            end
            if ~max(BranchIndex==size(xyz,1))
                AddEdgeIndex = [AddEdgeIndex, size(xyz,1)];
            end
        end
        function [output_XYZ,DI] = Delete_SamePointXYZ(~,XYZ)
            DeleteInd = [];
            for n = 1:size(XYZ,1)-1
                if ~isempty(DeleteInd)
                    if max(n==DeleteInd)
                        continue
                    end
                end
                xyz1 = XYZ(n,:);
                xyz2 = XYZ(n+1:end,:);
                TFx = xyz1(1) == xyz2(:,1);
                TFy = xyz1(2) == xyz2(:,2);
                TFz = xyz1(3) == xyz2(:,3);
                ind = find(and(and(TFx,TFy),TFz));
                DeleteInd = cat(1,DeleteInd,ind(:)+n);
            end
            XYZ(DeleteInd,:) = [];
            output_XYZ = XYZ;
            DI = DeleteInd;
        end


        function [Aid,Vid,Aind,Vind] = FindID_Class_arteriovenous(obj)
            % [Aid,Vid,Aind,Vind] = FindID_Class_arteriovenous()
            %
            % Use This.Segment
            % Output :
            % Aid, Vid are Artery ID and Vein ID.
            % Aind, Vind, are Artery index and Vein index.
            Pdata = obj.Segment.Pointdata;
            Art_class = obj.Class_Artery;
            Vein_class = obj.Class_Vein;
            Aid = [];
            Vid = [];
            Aind = [];
            Vind = [];
            for n = 1:length(Pdata)
                if Pdata(n).ID < 0
                    continue
                end
                if max(strcmpi(Pdata(n).Class,Art_class))
                    Aid = cat(1,Aid,Pdata(n).ID);
                    Aind = cat(1,Aind,n);
                elseif max(strcmpi(Pdata(n).Class,Vein_class))
                    Vid = cat(1,Vid,Pdata(n).ID);
                    Vind = cat(1,Vind,n);
                end
            end
        end

        function ID = FindID_xyz(obj,XYZ)
            XYZ = single(XYZ);
            x = XYZ(1);
            y = XYZ(2);
            z = XYZ(3);
            Pdata = obj.Segment.Pointdata;
            catID = cat(1,Pdata.ID);
            Pdata = Pdata(catID>0);
            ID = [];
            for n = 1:length(Pdata)
                xyz = single(Pdata(n).PointXYZ);
                TFx = max(xyz(:,1) == x);
                TFy = max(xyz(:,2) == y);
                TFz = max(xyz(:,3) == z);
                TF = TFx && TFy && TFz;
                if TF
                    ID = cat(2,ID,Pdata(n).ID);
                end
            end
        end
        function ID = FindID_xyz_edge(obj,XYZ)
            x = XYZ(1);
            y = XYZ(2);
            z = XYZ(3);
            Pdata = obj.Segment.Pointdata;
            catID = cat(1,Pdata.ID);
            Pdata = Pdata(catID>0);
            ID = [];
            for n = 1:length(Pdata)
                xyz = Pdata(n).PointXYZ([1,end],:);
                TFx = max(xyz(:,1) == x);
                TFy = max(xyz(:,2) == y);
                TFz = max(xyz(:,3) == z);
                TF = TFx && TFy && TFz;
                if TF
                    ID = [ID Pdata(n).ID];
                end
            end
        end
        function [ID,minLen] = FindID_xyz_nearest(obj,xyz)
            Pdata = obj.Segment.Pointdata;
            catID = cat(1,Pdata.ID);
            Pdata = Pdata(catID>0);
            IDs = [];
            for n = 1:length(Pdata)
                IDs = cat(1,IDs,repmat(Pdata(n).ID,size(Pdata(n).PointXYZ,1),1));
            end
            XYZ = cat(1,Pdata.PointXYZ);
            len = obj.GetEachLength(xyz,XYZ,obj.Segment.ResolutionXYZ);
            [minLen,ind] = min(len);
            ID = IDs(ind);
            if isscalar(ID)
                return
            end
            DeleteTF = false(size(ID));            
            for n = 1:length(ID)-1
                p = find(ID(n) == ID(n+1:end));
                if isempty(p)
                    continue
                else
                    p = p + n;
                    DeleteTF(p) = true;
                end
            end
            ID(DeleteTF) = [];
        end
        function obj = Delete_loopSegment(obj)
            fprintf('##### Delete loop Segment #####')
            Pdata = obj.Segment.Pointdata;
            cut_Length = obj.Segment.cutlen;

            for n = 1:length(Pdata)
                if Pdata(n).ID < 1
                    continue
                end
                xyz1 = Pdata(n).PointXYZ(1,:);
                xyz2 = Pdata(n).PointXYZ(end,:);
                loopTF = xyz1(1) == xyz2(1) && ...
                         xyz1(2) == xyz2(2) && ...
                         xyz1(3) == xyz2(3);
                Len = Pdata(n).Length;
                if and(loopTF,Len <= cut_Length)
                    Pdata(n).ID = -1 * abs(Pdata(n).ID );
                    fprintf(['   Delete ' num2str(Pdata(n).ID) '\n'])
                end
            end
            obj.Segment.Pointdata = Pdata;
            fprintf('Done: Delete loop Segment ##### \n')
        end

        function [NewSEG,none_cut_SEG] = ModifySEG(obj)
            tic
            %% Delete Loop Segment. It was found 2019.5.26.
            % PointXYZ(1,:) == PointXYZ(end,:) && Length <= SEG.cutlen
            obj = obj.Delete_loopSegment();

%             fprintf('/n ## ## ## /n Befor Modify Branch Point Matrix.,/n')
%             obj.Segment.BPmatrix
            obj = obj.Modify_BranchPointMatrix();
%             fprintf('/n ## ## ## /n After Modify Branch Point Matrix.,/n')
%             obj.Segment.BPmatrix
            BPmatrix = obj.Segment.BPmatrix;
%             2 --> connect
%             1 --> end point
%             3 more--> Branch point

            %% Find Connect IDs
            fprintf('#### Starting Finding Connect Pairs. ########\n')
            ConnectBranch = BPmatrix(BPmatrix(:,5) == 2,:);
            connectID = nan(size(ConnectBranch,1),2);

            for n = 1:size(ConnectBranch,1)

                connect_ids = obj.FindID_xyz_edge(ConnectBranch(n,1:3));
                try
                    connectID(n,:) = connect_ids(1:2);
                catch err
                    fprintf('***** Error, in Finding both end of Branch Connection Segment ID ]n')
                    fprintf([err.message '\n'])
                    fprintf(['    XYZ = : ' num2str(ConnectBranch(n,:)) '\n'])
                    fprintf(['    IDs   : ' num2str(connect_ids) '\n'])
                    continue
                end
                TS_WaiteProgress((n-1)/size(ConnectBranch,1))
            end
            TS_WaiteProgress(1)
            connectID(isnan(connectID(:,1)),:) = [];
            N = 1;
            Nmax = size(connectID,1);

            if Nmax ~= 0
                c = 1;
                IDs = [];
                fprintf('     Now, Chasing IDs,  ########\n')
                while ~isempty(N)
                    TS_WaiteProgress((N-1)/Nmax)
                    % Left
                    sID_L = connectID(N,1);
                    % Right
                    sID_R = connectID(N,2);

                    % Left
                    connectID(N,1) = nan;
                    margeID = sID_L;
                    [margeID,connectID] = FindNextIDs(sID_L,connectID,margeID);
                    % Right
                    connectID(N,2) = nan;
                    margeID = [margeID sID_R];
                    [margeID,connectID] = FindNextIDs(sID_R,connectID,margeID);

                    %% Next
                    IDs{c} = margeID;
                    c = c + 1;
                    N = find(~isnan(connectID(:,1)),1);
                end
                TS_WaiteProgress(1)
                fprintf('   Finish Finding Connect Pairs. \n')
                %% Connect.
                % delete same index, just 1 numel pair,;
                fprintf('####   Starting Check Pairs.  ######## \n')
                DeleteInd = false(1,length(IDs));
                for n = 1:length(IDs)
                    check_ids = IDs{n};
                    if numel(check_ids) < 2
                        DeleteInd(n) = true;
                        continue
                    end
                    check_ids = sort(check_ids);
                    diff_ids = diff([check_ids, nan]);
                    p = diff_ids==0;
                    check_ids(p) = [];
                    check_ids(isnan(check_ids)) = [];
                    if numel(check_ids) < 2
                        DeleteInd(n) = true;
                    else
                        IDs{n} = check_ids;
                    end
                end
                fprintf('   Finish Check Pairs. \n')
                % Connect Function.
                NewSEG = obj.Connect(obj.Segment,IDs,'-f');
            else
                NewSEG = obj.Segment;
                fprintf('Skip Auto Connecting Process.\n')
            end
             function [IDs,ConnectMatrix] = FindNextIDs(sID,Connects,margeID)
                    [L,R] = find(Connects == sID);
                    if isempty(L)
                        IDs = margeID;
                        ConnectMatrix = Connects;
                    elseif numel(L) > 1
                        warning('There may be Error Connection(Brnach) Point... ')
                        IDs = margeID;
                        Connects(L,:) = nan;
                        ConnectMatrix = Connects;
                    else
                        if R == 1
                            nID = Connects(L,2);
                        else
                            nID = Connects(L,1);
                        end
                        % margeID = [margeID, Connects(L,R)];
                        Connects(L,:) = nan;
                        margeID = [margeID, sID, nID];
                        [IDs,ConnectMatrix] = FindNextIDs(nID,Connects,margeID);
                    end
                end

            %% Reset up BP matrix.
            fprintf('####   Reset up BP matrix......  ######## \n')
            obj.Segment = NewSEG;
            obj = obj.Modify_BranchPointMatrix();
            BPmatrix = obj.Segment.BPmatrix;
            for n = 1:size(BPmatrix,1)
                xyz = BPmatrix(n,1:3);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%% IF 1 branch has 1 edge and inside of Segment,,
                %%% its number of branch shoud be "2"
                ID = obj.FindID_xyz(xyz);
                BPmatrix(n,5) = numel(ID);
                TS_WaiteProgress((n-1)/size(BPmatrix,1))
            end
            TS_WaiteProgress(1)
            obj.Segment.BPmatrix = BPmatrix;

            %% Re Check Type
            NewSEG = obj.ReCheckType();
            obj.Segment = NewSEG;

            %% output
            none_cut_SEG = obj.Segment;
            Pdata = obj.Segment.Pointdata;
            catID = cat(1,Pdata.ID);
            obj.Segment.Pointdata = Pdata(catID>0);
            NewSEG = obj.Segment;
            fprintf(['    Finish : ' mfilename '\n'])
            toc
            fprintf('\n ######## ######## ######## ######## ######## ######## \n')

        end
        function Output = Modify_BranchPointMatrix(obj,varargin)
            % Output = Modify_BranchPointMatrix(obj,varargin)
            % if nargin ==1
            %     SEG    <-- obj.Segment
            %     Output <-- obj.Segment.BPmatrix <-- NewBPmatrix
            % else
            %     SEG = varargin{1};
            %     Output <-- NewBPmatrix
            % end

            if nargin ==1
                SEG = obj.Segment;
            else
                SEG = varargin{1};
            end
            catID = cat(1,SEG.Pointdata.ID);
            Pdata = SEG.Pointdata(catID>0);
            XYZ_matrix = zeros(length(Pdata)*2,3);
            for n = 1:length(Pdata)
                XYZ_matrix(n*2-1,:) = Pdata(n).PointXYZ(1,:);
                XYZ_matrix(n*2,:) = Pdata(n).PointXYZ(end,:);
            end


            %%%% 2019. 25th, March edit by Sugashi%%%%%%%%%%%%%%%%%%%
            BPmatrix = nan(size(XYZ_matrix));
            c = 1;
            for n = 1:size(XYZ_matrix,1)
                xyz = XYZ_matrix(n,:);
                sameX = single(BPmatrix(:,1)) == single(xyz(1));
                sameY = single(BPmatrix(:,2)) == single(xyz(2));
                sameZ = single(BPmatrix(:,3)) == single(xyz(3));
                TF = sum(cat(2,sameX,sameY,sameZ),2) ==3;
                if max(TF) ==0
                    BPmatrix(c,:) = xyz;
                    c = c + 1;
                end
            end
            BPmatrix(isnan(BPmatrix(:,1)),:) = [];
            BPmatrix = cat(2,BPmatrix,nan(size(BPmatrix,1),2));

            for n = 1:size(BPmatrix,1)
                xyz = BPmatrix(n,:);
                sameX = single(XYZ_matrix(:,1)) == single(xyz(1));
                sameY = single(XYZ_matrix(:,2)) == single(xyz(2));
                sameZ = single(XYZ_matrix(:,3)) == single(xyz(3));
                TF = sum(cat(2,sameX,sameY,sameZ),2) ==3;
                BPmatrix(n,5) = sum(TF);
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


            %%%%%%%%%%% Old version %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             TF = true;
%             c = 1;
%             BPmatrix = zeros(0,5);
%             while TF
%                 xyz = XYZ_matrix(c,:);
%                 Indx = obj.FindSameStartEndXYZ(xyz,XYZ_matrix);
%                 Indx(1:c) = false;
%                 p = find(Indx);
%                 XYZ_matrix(p,:) = [];
%                 if c + 1 > size(XYZ_matrix,1)
%                     TF = false;
%                 else
%                     c = c + 1;
%                 end
%                 Num = 1 + numel(p);
%                 BPmatrix = cat(1,BPmatrix,[xyz,nan,Num]);
%             end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if nargin ==1
                SEG.BPmatrix = BPmatrix;
                obj.Segment = SEG;
                Output = obj;
            else
                Output = BPmatrix;
            end

        end
        function NormTheta = xyz2NormXYplane(obj,xyz,varargin)
            % [NormTheta,Pasu] = TS_xyz2Norm(xyx,RefLen,{Reso})
            % input
            %     xy(z) ; xyz index,if nx3 matrix , xyz = xyz(:,1:2);
            %     RefLen  ; more than 1 point.
            %
            % output
            %     NormTheta
            %     ...  pasu = mean((diff(y)) / mean(diff(x))
            Reso = ones(1,3);
            if nargin ==3
                Reso = varargin{1};
            end
%             pnum = 1:size(xyz,1);
            NormTheta = zeros(size(xyz,1),1);
            if size(xyz,2)==3
                xyz(:,3) = 1;
            else
                xyz = cat(2,xyz,ones(size(xyz,1),1));
            end
%             xyz(:,2) = -1*xyz(:,2); %% For SI unit
            RefLen = obj.NormReferenceLength/2;
            for n = 1:length(NormTheta)
%                 if n==1
%                     checksame = diff(xyz(1:2,:),1,1);
%                     if checksame(1)==0 && checksame(2) ==0 && checksame(3)==0
%                         NormTheta(n) = nan;
%                         continue
%                     end
%                 end
%                 try
                bottomLen = cumsum(obj.xyz2plen(xyz(n:end,:),Reso));
%                 catch err
%                     keyboard
%                 end

                if n ==1
                    pnum = bottomLen;
                else
                    topLen = cumsum(obj.xyz2plen(flip(xyz(1:n,:),1),Reso));
                    topLen = flip(topLen,1);
                    pnum = cat(1,topLen(1:end-1),bottomLen);
                end
                ind = pnum <=RefLen;
%                 ind = and(pnum >= n - RefLen, pnum <= n + RefLen);
                [UnitVec,~] = obj.xyz2Vector(xyz(ind,:),Reso);
                Theta = obj.UnitVector2Theta(UnitVec,[1 0 0]);
                Theta = Theta *sign(UnitVec(2));
                Theta = Theta + pi/2;
                NormTheta(n) = Theta;
            end
        end
        function Fai = xyz2Fai_AngleFromAxisZ(obj,xyz,Reso)
            if length(Reso) ~= 3
                error('Input Resolution must be 3 numel.')
            end

            Fai = zeros(size(xyz,1),1);

            Refp = obj.FaiReferenceLength/2;
            for n = 1:length(Fai)
                bottomLen = cumsum(obj.xyz2plen(xyz(n:end,:),Reso));
                if n ==1
                    pnum = bottomLen;
                else
                    topLen = cumsum(obj.xyz2plen(flip(xyz(1:n,:),1),Reso));
                    topLen = flip(topLen,1);
                    pnum = cat(1,topLen(1:end-1),bottomLen);
                end
%                 ind = and(pnum >= n -1, pnum <= n +1);
                ind = pnum <=Refp;


                 [UnitVec,~] = obj.xyz2Vector(xyz(ind,:),Reso);
                Theta = obj.UnitVector2Theta(UnitVec,[0 0 1]);
                if Theta > pi/2
                    Theta = pi - Theta;
                end
                Fai(n) = Theta;
            end
        end
        function Bending = BendingFreq(~,xyz)
            Bending = nan(size(xyz,1),1);
            for n = 2:size(xyz,1)-1
                a = xyz(n,:) - xyz(n-1,:);
                b = xyz(n+1,:) - xyz(n,:);
                Cos = (a.*b)/(sqrt(sum(a.^2))*sqrt(b.^2));
                Bending(n) = acos(Cos);
            end
        end

        %% xyz2CalcR_old
        function PPar = xyz2CalcR(~,xyz,val)
            len = size(xyz,1);
            xyz = xyz(:,1:2);
            xyz = padarray(xyz,[val 0],'replicate');
            PPar = nan(len,3);
            for n = 1:len
                pxy = xyz(n:n+val*2,:);
                P = CircleFitByTaubin(pxy);
                PPar(n,:) = P;
            end
        end
        %% NewCalcR
        function [R,UVec,Scal] = CircleFit_Taubin(obj,xyz,varargin)
            if nargin > 3
                WindowRSize = varargin{2};
            else
                WindowRSize = obj.RFitting_WindowSize ; %% Radius[um]
            end
%             ptCloudIn = pointCloud(xyz);
%             xyz = xyz(:,1:2);
            R = nan(size(xyz,1),1,length(WindowRSize));
            UVec = nan(size(xyz,1),3,length(WindowRSize));
            Scal = nan(size(xyz,1),1,length(WindowRSize));
            for n = 1:size(xyz,1)
                TL = obj.TrackingLength(xyz,ones(1,3),n);
                for WRind = 1:length(WindowRSize)
                    Indices = TL <= WindowRSize(WRind);
                    try
                        Taubin = CircleFitByTaubin(xyz(Indices,1:2));
                    catch err
                        Taubin = nan(1,3);
                    end
                    Rad = Taubin(3);
                    R(n,1,WRind) = Rad;
                    [UV,S] = obj.xyz2Vector(xyz(Indices,:));
                    UVec(n,:,WRind) = UV;
                    Scal(n,1,WRind) = S;
                end
            end
        end
        function [R,UVec,Scal] = SphereFit_pcfitsphere(obj,xyz,varargin)
            % M = SphereFit_pcfitsphere(xyz)
            % M = SphereFit_pcfitsphere(xyz,MaxDistance)
            % M = SphereFit_pcfitsphere(xyz,MaxDistance,WindowRSize)
            if nargin > 2
                MaxDistance = varargin{1};
            else
                MaxDistance = obj.RFitting_MaxDistance;
            end
            if nargin > 3
                WindowRSize = varargin{2};
            else
                WindowRSize = obj.RFitting_WindowSize ; %% Radius[um]
            end
            ptCloudIn = pointCloud(xyz);
            R = nan(size(xyz,1),1);
            UVec = nan(size(xyz,1),3);
            Scal = nan(size(xyz,1),1);
            for n = 1:size(xyz,1)
                Center = xyz(n,:);
                Range = [...
                    Center(1) - WindowRSize,Center(1) + WindowRSize;
                    Center(2) - WindowRSize,Center(2) + WindowRSize;
                    Center(3) - WindowRSize,Center(3) + WindowRSize];
                Indices = findPointsInROI(ptCloudIn,Range);
                M = pcfitsphere(ptCloudIn,MaxDistance,'SampleIndices',Indices);
%                 [Rad,~] = obj.SphereFit(xyz(Indices,:));
                if and(sum(M.Center) ==0,M.Radius ==0)
                    R(n) = nan;
                else
                    R(n) = M.Radius;
                end
%                 R(n) = Radius;
                [UV,S] = obj.xyz2Vector(xyz(Indices,:));
                UVec(n,:) = UV;
                Scal(n) = S;
            end
            %%%% Add for nan space %%%%% 2019 09 08
            TFnan = isnan(R);
            if or(~max(TFnan),sum(TFnan)==numel(R))
                return
            end
            xind = cumsum(obj.xyz2plen(xyz,ones(1,3)));
            vx = xind(TFnan);
            Rad_interp = R;
            Rad_interp(TFnan) = [];
            xind(TFnan) = [];
            NewRad = interp1(xind,Rad_interp,vx,'linear');
            R(TFnan) = NewRad;
        end
        function [R,UVec,Scal] = SphereFit_LeastSquares(obj,xyz,varargin)
            if nargin > 3
                WindowRSize = varargin{2};
            else
                WindowRSize = obj.RFitting_WindowSize ; %% Radius[um]
            end
            xyz = obj.Emaergency_isnanxyz(xyz); %% if u use, Rotate Move date./.... fuckl...
            ptCloudIn = pointCloud(xyz);
            R = nan(size(xyz,1),1);
            UVec = nan(size(xyz,1),3);
            Scal = nan(size(xyz,1),1);
            for n = 1:size(xyz,1)
                Center = xyz(n,:);
                Range = [...
                    Center(1) - WindowRSize,Center(1) + WindowRSize;
                    Center(2) - WindowRSize,Center(2) + WindowRSize;
                    Center(3) - WindowRSize,Center(3) + WindowRSize];
                Indices = findPointsInROI(ptCloudIn,Range);
                [Rad,~] = obj.SphereFit(xyz(Indices,:));
                R(n) = Rad;
                [UV,S] = obj.xyz2Vector(xyz(Indices,:));
                UVec(n,:) = UV;
                Scal(n) = S;
            end
            %%%% Add for nan space %%%%% 2019 09 08
            TFnan = or(isnan(R),isinf(R));
            if or(~max(TFnan),sum(TFnan)==numel(R))
                return
            end
            xind = cumsum(obj.xyz2plen(xyz,ones(1,3)));
            vx = xind(TFnan);
            Rad_interp = R;
            Rad_interp(TFnan) = [];
            xind(TFnan) = [];
            NewRad = interp1(xind,Rad_interp,vx,'linear');
            R(TFnan) = NewRad;
        end

        %% will be delete
        function interp_xyz = Emaergency_isnanxyz(~,xyz)
            x = extrap_interp1_emarg(xyz(:,1));
            y = extrap_interp1_emarg(xyz(:,2));
            z = extrap_interp1_emarg(xyz(:,3));
            interp_xyz = cat(2,x(:),y(:),z(:));
            function nx = extrap_interp1_emarg(x)
                tfx = or(isnan(x),isinf(x));
                if sum(tfx)~=0
                    vx = 1:length(x);
                    x(tfx) = [];
                    ind = vx;
                    ind(tfx) = [];
                    nx = interp1(ind,x,vx,'linear','extrap');
                else
                    nx = x;
                end
            end
        end

         %% Sphere Fitting (Ref. Alan Jennings, University of Dayton)
        function [Radius,Center] = SphereFit(~,X)
           % [Radius,Center] = SphereFit(~,XYZ)
           % Original function is SphereFitByLeastSquares by Alan Jennings, University of Dayton

           % this fits a sphere to a collection of data using a closed form for the
            % solution (opposed to using an array the size of the data set).
            % Minimizes Sum((x-xc)^2+(y-yc)^2+(z-zc)^2-r^2)^2
            % x,y,z are the data, xc,yc,zc are the sphere's center, and r is the radius
            % Assumes that points are not in a singular configuration, real numbers, ...
            % if you have coplanar data, use a circle fit with svd for determining the
            % plane, recommended Circle Fit (Pratt method), by Nikolai Chernov
            % http://www.mathworks.com/matlabcentral/fileexchange/22643
            % Input:
            % X: n x 3 matrix of cartesian data
            % Outputs:
            % Center: Center of sphere
            % Radius: Radius of sphere
            % Author:
            % Alan Jennings, University of Dayton
            A=[mean(X(:,1).*(X(:,1)-mean(X(:,1)))), ...
                2*mean(X(:,1).*(X(:,2)-mean(X(:,2)))), ...
                2*mean(X(:,1).*(X(:,3)-mean(X(:,3)))); ...
                0, ...
                mean(X(:,2).*(X(:,2)-mean(X(:,2)))), ...
                2*mean(X(:,2).*(X(:,3)-mean(X(:,3)))); ...
                0, ...
                0, ...
                mean(X(:,3).*(X(:,3)-mean(X(:,3))))];
            A=A+A.';
            B=[mean((X(:,1).^2+X(:,2).^2+X(:,3).^2).*(X(:,1)-mean(X(:,1))));...
                mean((X(:,1).^2+X(:,2).^2+X(:,3).^2).*(X(:,2)-mean(X(:,2))));...
                mean((X(:,1).^2+X(:,2).^2+X(:,3).^2).*(X(:,3)-mean(X(:,3))))];

            Center=(A\B).';
            Radius=sqrt(mean(sum([X(:,1)-Center(1),X(:,2)-Center(2),X(:,3)-Center(3)].^2,2)));
        end
        %% developing now...
        function TL = TrackingLength(obj,xyz,Reso,CenterInd)
            %TL = TrackingLength(obj,xyz,Reso,CenterInd)
            Plen = obj.xyz2plen(xyz,Reso);
            CumLen = cumsum(Plen);
            TL = abs(CumLen - sum(Plen(1:CenterInd)));
        end

        %% Tracking for nearest xyz2ID
        function TrackingData = TrackingDays_FindNearestIDs(obj,SEG1,SEG2)
            catID = cat(1,SEG1.Pointdata.ID);
            SEG1.Pointdata = SEG1.Pointdata(catID>0);
            obj.Segment = SEG1;

            S = Segment_Functions;
            catID = cat(1,SEG2.Pointdata.ID);
            SEG2.Pointdata = SEG2.Pointdata(catID>0);
            S.Segment = SEG2;

            %% xyz1(base) to xyz2(object)
            Num = length(obj.Segment.Pointdata);
            objXYZ = cat(1,S.Segment.Pointdata.PointXYZ);
            XYZ = (objXYZ -1 ) .* S.Segment.ResolutionXYZ;
            TS_WaiteProgress(0)
            try
            for n = 1:Num
                xyz1 = obj.Segment.Pointdata(n).PointXYZ;
                xyz1 = (xyz1 -1) .* obj.Segment.ResolutionXYZ;
                IDs = zeros(size(xyz1,1),1);
                for k = 1:size(xyz1,1)
                    len = obj.GetEachLength(xyz1(k,:),XYZ,ones(1,3));
                    [~,ind] = min(len);
                    ind = ind(1);
                    check_ids = S.FindID_xyz(objXYZ(ind,:));
                    if numel(check_ids)>1
                        IDs(k) = nan;
                    else
                        IDs(k) = check_ids;
                    end
                end
                IDs(isnan(IDs)) = [];
                IDs = sort(IDs);
                p = diff([IDs; inf])>0;
                x_id = IDs(p);
                index = cell2mat(S.ID2Index({x_id}));
                Parcentage = zeros(size(index));
                ID_counts = Parcentage;
                for k = 1:length(index)
                    xyz = S.Segment.Pointdata(index(k)).PointXYZ;
                    ID_counts(k) = sum(x_id(k) == IDs);
                    Parcentage(k) = ID_counts(k)/ size(xyz,1);
                end
                obj.Segment.Pointdata(n).Tracking.IDs = x_id;
                obj.Segment.Pointdata(n).Tracking.ID_counts = ID_counts;
                obj.Segment.Pointdata(n).Tracking.ObjectParcentage = Parcentage;
                TS_WaiteProgress(n/Num)
            end
            catch err
                err
                keyboard
            end
            TrackingData = obj.Segment;
        end
        function TrackingData = TrackingDays_FindNearestIDs_parfor(obj,SEG1,SEG2)
            tic;
            catID = cat(1,SEG1.Pointdata.ID);
            SEG1.Pointdata = SEG1.Pointdata(catID>0);
            obj.Segment = SEG1;
            DistanceLim = obj.Tracking_Distance_Limit;

            S = Segment_Functions;
            catID = cat(1,SEG2.Pointdata.ID);
            SEG2.Pointdata = SEG2.Pointdata(catID>0);
            S.Segment = SEG2;

            %% xyz1(base) to xyz2(object)
            Pdata = obj.Segment.Pointdata;
            BaseReso = obj.Segment.ResolutionXYZ;
            Num = length(obj.Segment.Pointdata);
            objXYZ = cat(1,S.Segment.Pointdata.PointXYZ);
            XYZ = (objXYZ -1 ) .* S.Segment.ResolutionXYZ;
            Pdata(1).Tracking.IDs = [];
            Pdata(1).Tracking.ID_counts = [];
            Pdata(1).Tracking.ObjectParcentage = [];
            parfor n = 1:Num
                disp(num2str(n/Num * 100,'%.1f'))
                xyz1 = Pdata(n).PointXYZ;
                xyz1 = (xyz1 -1) .* BaseReso;
                IDs = zeros(size(xyz1,1),1);
                for k = 1:size(xyz1,1)
                    len = S.GetEachLength(xyz1(k,:),XYZ,ones(1,3));
                    [Distance,ind] = min(len);
                    ind = ind(1);
                    check_ids = S.FindID_xyz(objXYZ(ind,:));
                    if or(numel(check_ids)>1,Distance>DistanceLim)
                        IDs(k) = nan;
                    else
                        IDs(k) = check_ids;
                    end
                end
                IDs(isnan(IDs)) = [];
                IDs = sort(IDs);
                p = diff([IDs; inf])>0;
                x_id = IDs(p);
                index = cell2mat(S.ID2Index({x_id}));
                Parcentage = zeros(size(index));
                ID_counts = Parcentage;
                EuclidianSD = Parcentage;
                EuclidianAve= Parcentage;
                for k = 1:length(index)
                    xyz = S.Segment.Pointdata(index(k)).PointXYZ;
                    ID_counts(k) = sum(x_id(k) == IDs);
                    Parcentage(k) = ID_counts(k)/ size(xyz,1);
                    xyz = ( xyz -1).* S.Segment.ResolutionXYZ;
                    [val,D] = S.Evaluate_2Line_Euclidean(xyz1,xyz);
                    EuclidianSD(k) = val;
                    EuclidianAve(k) = D;
                end
                Pdata(n).Tracking.IDs = x_id;
                Pdata(n).Tracking.ID_counts = ID_counts;
                Pdata(n).Tracking.ObjectParcentage = Parcentage;
                Pdata(n).Tracking.EuclidianAve = EuclidianAve;
                Pdata(n).Tracking.EuclidianSD = EuclidianSD;
            end
            obj.Segment.Pointdata = Pdata;
            TrackingData = obj.Segment;
            toc
        end

        function X = OutputTrackingData_XLS_Days(obj,TrackingData)
            % Days
            % ID, Class, Zum(base_D00), Dia.(Ave.), SD  ,Length, Tracking-ID(D21)
            Names = {'ID','Class','Z um(base D00)', 'Diam.(Ave.)', 'SD', 'n-Numbers' ,'Length','Tracking-IDs'};
            X = cell(length(TrackingData.Pointdata),length(Names));
            Pdata = TrackingData.Pointdata;
            Reso = TrackingData.ResolutionXYZ;
            for n = 1:size(X,1)
                X{n,1} = Pdata(n).ID;
                X{n,2} = Pdata(n).Class;
                X{n,3} = ( mean(Pdata(n).PointXYZ(:,3)) -1 )*Reso(3) ;
                X{n,4} =  nanmean(Pdata(n).Diameter);
                X{n,5} =  nanstd(Pdata(n).Diameter);
                X{n,6} =  sum(~isnan(Pdata(n).Diameter));
                X{n,7} =  Pdata(n).Length;
                if isfield(Pdata,'TrackingIDs')
                    X{n,8} =  num2str(Pdata(n).TrackingIDs(:)');
                else
                    X{n,8} =  '--';
                end
            end
            DateData = cell(1,length(Names));
            DateData{1,1} = 'Output : ';
            DateData{1,2} = date;
            X = cat(1,Names,X,DateData);

        end
        function X = OutputTrackingData_XLS_Tracking(obj,TD_base,TD_obj,Days)
            Names = {'BaseID','D00',Days};
            S = Segment_Functions;
            S.Segment = TD_obj;
            Pdata = TD_base.Pointdata;
            X = cell(length(Pdata),3);
            for n = 1:length(Pdata)
                X{n,1} = Pdata(n).ID;
                X{n,2} = nanmean(Pdata(n).Diameter);
                TrackingIDs = Pdata(n).TrackingIDs;
                Ind = S.ID2Index(TrackingIDs);
                Diameter = cat(1,TD_obj.Pointdata(Ind).Diameter);
                X{n,3} = nanmean(Diameter);
            end
            DateData = cell(1,length(Names));
            DateData{1,1} = 'Output : ';
            DateData{1,2} = date;
            X = cat(1,Names,X,DateData);
        end

        function TrackingData = TrackingDays_xcorr_DistanceLim(obj,SEG1,SEG2)
            tic
            Output = SEG1;
            DistLim = 100; %% Unit [Numbers],

            Pdata1 = SEG1.Pointdata;
            S2 = Segment_Functions;
            S2.Segment = SEG2;
            for n1 = 1:length(Pdata1)
                xyz1 = Pdata1(n1).PointXYZ;
                [ID,len] = obj.Check_Distance(xyz1,SEG1.ResolutionXYZ,SEG2,DistLim);
                Index = S2.ID2Index({ID});
                Index = cell2mat(Index);
                Pdata2 = SEG2.Pointdata(Index);
                check_IDs = zeros(length(Pdata2),1);
                check_length = check_IDs;
                check_corrcoef = zeros(length(Pdata2),3);
                parfor n2 = 1:length(Pdata2)
                    check_IDs(n2) = Pdata2(n2).ID;
                    check_length(n2) = len(n2);
                    xyz2 = Pdata2(n2).PointXYZ;
%                     [tho,~] = obj.trackingFcn_xcorr(xyz1,xyz2);
                    tho = obj.trackingFcn_ParallelismSTD(xyz1,xyz2);
                    check_corrcoef(n2,:) = tho;
                end
                Pdata1(n1).Check_Tracking.ID = check_IDs;
                Pdata1(n1).Check_Tracking.Distance = check_length;
                Pdata1(n1).Check_Tracking.CorrCoef = check_corrcoef;
                TS_WaiteProgress((n1-1)/length(Pdata1))
            end
            TS_WaiteProgress(1)
            TrackingData = Pdata1;
            toc
         end

        function [ID,len,Index] = Check_Distance(obj,xyz,Reso,SEG_Obj,DistLim)
             xyz = (xyz - 1) .*Reso;
             Pdata = SEG_Obj.Pointdata;
             Pdata = Pdata(cat(1,Pdata.ID)>0);
             Reso_obj = SEG_Obj.ResolutionXYZ;
             ID = cat(1,Pdata.ID);
             len = zeros(size(ID));
             for n = 1:length(Pdata)
                 xyz_obj = Pdata(n).PointXYZ;
                 xyz_obj = (xyz_obj-1).* Reso_obj;
                 lenmap = obj.GetEachLength(xyz,xyz_obj,ones(1,3));
                 len(n) = min(lenmap(:));
             end
             sort_len = sort(len);
             Dist_th = sort_len(DistLim);
             Index = len <= Dist_th;
             len = len(Index);
             ID = ID(Index);
         end

        function TrackingData = TrackingDays_xcorr_proto(obj,SEG1,SEG2)
            tic
            Pdata1 = SEG1.Pointdata;
            Pdata2 = SEG2.Pointdata;
            Thomatrix = nan(length(Pdata1),length(Pdata2),3);
            for n1 = 1:length(Pdata1)
                xyz1 = Pdata1(n1).PointXYZ;
                parfor n2 = 1:length(Pdata2)
                    xyz2 = Pdata2(n2).PointXYZ;
                    for Dim = 1:3
                        [tho,~] = obj.trackingFcn_xcorr(xyz1(:,Dim),xyz2(:,Dim));
                        Thomatrix(n1,n2,Dim) = tho;
                    end
                end
                TS_WaiteProgress((n1-1)/length(Pdata1))
            end
            TS_WaiteProgress(1)
            TrackingData = Thomatrix;
            toc


        end
        function [tho,LagDiff] = trackingFcn_xcorr(~,l1,l2)
%              [r,lag] = xcorr(l1,l2);
%              [~,Ind] = max(abs(r));
%              LagDiff = lag(Ind);
%              lenTF = length(l1) >= length(l2);
%              try
%              if LagDiff == 1 || LagDiff ==0
%                  if lenTF
%                      l1 = l1(1:length(l2));
%                  else
%                      l2 = l1(1:length(l1));
%                  end
%              elseif LagDiff < 0
%                  if lenTF
%     %                  l1 = l1(-LagDiff+1:end);
%                      l1 = l1(-LagDiff+1:-LagDiff+length(l2));
%                  else
%     %                  l2 = l2(-LagDiff+1:end);
%                      l2 = l2(-LagDiff+1:-LagDiff+length(l1));
%                  end
%              else
%                  if lenTF
%     %                  l1 = l1(-LagDiff+1:end);
%                      l1 = l1(length(l1)-length(l2)-LagDiff+2:length(l1)-LagDiff+1);
%                  else
%     %                  l2 = l2(-LagDiff+1:end);
%                      l2 = l2(length(l2)-length(l1)-LagDiff+2:length(l2)-LagDiff+1);
%                  end
%              end
%
%
%              catch err
%                  keyboard
%              end
                 %%% too match missing Result.....

                 %% New version,
             if size(l1,1) >= size(l2,1)
                 L1 = l1;
                 L2 = l2;
             else
                 L1 = l2;
                 L2 = l1;
             end
             %%%%% 20190602 %%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Tho1 = zeros(size(L1,1)-size(L2,1)+1,3);
%              Tho2 = zeros(size(L1,1)-size(L2,1)+1,3);
%              lenver = size(L2,1);
% %              Lag = Tho;
%              for n = 1:size(Tho1,1)
%                  Tho1(n,1) = corr(L1(n:lenver+n-1,1),L2(:,1));
%                  Tho1(n,2) = corr(L1(n:lenver+n-1,2),L2(:,2));
%                  Tho1(n,3) = corr(L1(n:lenver+n-1,3),L2(:,3));
%                  Tho2(n,1) = corr(L1(n:lenver+n-1,1),flip(L2(:,1),1));
%                  Tho2(n,2) = corr(L1(n:lenver+n-1,2),flip(L2(:,2),1));
%                  Tho2(n,3) = corr(L1(n:lenver+n-1,3),flip(L2(:,3),1));
%              end
%              [Max1,Lag1] = max(mean(Tho1,2));
%              [Max2,Lag2] = max(mean(Tho2,2));
             %%%%% 20190604 %%%%%%%%%%%%%%%%%%%%%%%%%%%
             Tho1 = zeros(size(L1,1)-size(L2,1)+1,1);
             Tho2 = zeros(size(L1,1)-size(L2,1)+1,1);
             lenver = size(L2,1);
             for n = 1:size(Tho1,1)
                 Tho1(n,1) = corr2(L1(n:lenver+n-1,:),L2);
                 Tho2(n,1) = corr2(L1(n:lenver+n-1,:),flip(L2,1));
             end
             [Max1,Lag1] = max(Tho1);
             [Max2,Lag2] = max(Tho2);
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             if Max1 >= Max2
                 LagDiff = Lag1;
                 LagDiff = LagDiff(1);
                 tho = Tho1(LagDiff);
             else
                 LagDiff = Lag2;
                 LagDiff = LagDiff(1);
                 tho = Tho2(LagDiff);
             end
%              [~,LagDiff] = max(abs(Tho));
%              LagDiff = LagDiff(1);
%              tho = Tho(LagDiff);
        end

        function tho = trackingFcn_ParallelismSTD(~,l1,l2)

                 %% New version,
             if size(l1,1) >= size(l2,1)
                 L1 = l1;
                 L2 = l2;
             else
                 L1 = l2;
                 L2 = l1;
             end
             %%%%% 20190604 %%%%%%%%%%%%%%%%%%%%%%%%%%%
             Tho1 = zeros(size(L1,1)-size(L2,1)+1,3);
             Tho2 = zeros(size(L1,1)-size(L2,1)+1,3);
             lenver = size(L2,1);
             for n = 1:size(Tho1,1)
                 Tho1(n,:) = std(L1(n:lenver+n-1,:) - L2,1);
                 Tho2(n,:) = std(L1(n:lenver+n-1,:) - flip(L2,1),1);
             end
             THO1 = sum(Tho1,2);
             THO2 = sum(Tho2,2);
             [~,ind1] = min(THO1);
             [~,ind2] = min(THO2);
             Tho1 = Tho1(ind1(1),:);
             Tho2 = Tho2(ind2(1),:);
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             if sum(Tho1(:))>= sum(Tho2(:))
                 tho = Tho1;
             else
                 tho = Tho2;
             end


        end
        function NewSEG = RotMoveStretch_SEG(obj,SEG,RotMovStretchData)
            % NewSEG = RotMoveStretch_SEG(obj,SEG,RotMovStretchData)
            % RotMovStretchData  <-- TS_3DRotateMoveStretch
            Pdata = SEG.Pointdata;
            catID = cat(1,Pdata.ID);
            Pdata = Pdata(catID>0);
            Reso = SEG.ResolutionXYZ;
            Center = (SEG.Size-1) .* SEG.ResolutionXYZ /2;
            for n = 1:length(Pdata)
                xyz = Pdata(n).PointXYZ;
                xyz = (xyz-1).*Reso;
                xyz = obj.xyz2RotMoveStretch(xyz,RotMovStretchData,Center);
                xyz = (xyz./Reso) + 1;
                Pdata(n).PointXYZ = xyz;
            end
            NewSEG = SEG;
            NewSEG.Pointdata = Pdata;

        end

        function XYZ = xyz2RotMoveStretch(obj,xyz,RotMovStretchData,OriginalCenter)
            %% input must be real lenght unit
            % XYZ = xyz2RotMoveStretch(xyz,RotMovStretchData,OriginalCenter)
            % XYZ = ...(real unit (X,Y,Z), RotMovStretchData,FOV/2)
            Rx = obj.RotX(RotMovStretchData.Rotate(1));
            Ry = obj.RotY(RotMovStretchData.Rotate(2));
            Rz = obj.RotZ(RotMovStretchData.Rotate(3));
            zdata = xyz(:,3);
            xyz = xyz - OriginalCenter;
            xyz = xyz';
            xyz = Rz*(Ry*(Rx*xyz));
            xyz = xyz';
            XYZ = xyz + OriginalCenter;
            XYZ = XYZ + RotMovStretchData.Move;
            newZ = interp1(RotMovStretchData.Stretch_lx,...
                RotMovStretchData.Stretch_ly,...
                XYZ(:,3),...  %% old is zdata
                RotMovStretchData.InterpType);
            XYZ(:,3) = newZ;
        end
        function XYZ = xyz2RotMoveStretch_Reverse(obj,xyz,RotMovStretchData,OriginalCenter)
            %% input must be real lenght unit
            % XYZ = xyz2RotMoveStretch_Reverse(xyz,RotMovStretchData,OriginalCenter)
            % XYZ = ...(real unit (X,Y,Z), RotMovStretchData,FOV/2)
            Rx = obj.RotX(-RotMovStretchData.Rotate(1));
            Ry = obj.RotY(-RotMovStretchData.Rotate(2));
            Rz = obj.RotZ(-RotMovStretchData.Rotate(3));
            zdata = xyz(:,3);

            xyz = xyz - OriginalCenter;
            xyz = xyz';
%             xyz = Rz*(Ry*(Rx*xyz));
            xyz = Rz\(Ry\(Rx\xyz));
            xyz = xyz';
            XYZ = xyz + OriginalCenter;
            
            XYZ = XYZ - RotMovStretchData.Move; %%
%             Shift = - abs(RotMovStretchData.Move(1:2));
%             Shift(3) = RotMovStretchData.Move(3);
%             XYZ = XYZ - Shift; %%
            if strcmpi(RotMovStretchData.InterpType,'phcp')
                RotMovStretchData.InterpType = 'pchip';
            end
            newZ = interp1(RotMovStretchData.Stretch_ly,...
                RotMovStretchData.Stretch_lx,...
                XYZ(:,3),...  %% old is zdata
                RotMovStretchData.InterpType);
            XYZ(:,3) = newZ;
        end
        


        %% inpterpolation
        function [Xo,Yo,Zo] = GetNormMesh_Reso(obj,Center,NorVec,outsiz,NewReso)
            % [Xo,Yo,Zo] = GetMesh_Reso(~,Center,NorVec,outsiz,NewReso)
            %
            % Center, [Xc,Yc,Zc] Center Position as real length [unit um]
            % NorVec, Norm Vecter(s), size(NorVec,1) == size(Center,1)
            %     see also
            %         xyz2Vector
            %         SphereFit_LeastSquares
            %         CircleFit_Taubin
            % outsiz , scalar, unit pix.(==vox.)
            % NewReso, output Resolution, scalar,
            %
            % Create Oct. 2nd 2019 , Sugashi

            if and(~isscalar(NewReso),~isscalar(outsiz))
                error('Input New Resolution and Outsiz is not Scalor')
            end
            % (x-xo)u + (y-yo)v + (z-zo)w = 0; Norm Vector is [u,v,w],
%             FOV = (Siz-1) .* Reso;
            BaseVector = [1 0 0];
            T = NorVec;
            T(:,3) = 0;

            Theta = obj.UnitVector2Theta(T,repmat(BaseVector,[size(T,1), 1]));
%
%
%
%             Xdata = ( 0:outsiz-1 ) *NewReso;
%             Xdata = Xdata - (max(Xdata)/2);
%             Ydata = ( 0:outsiz-1 ) *NewReso;
%             Ydata = Ydata - (max(Ydata)/2);
%             [Xdata,Ydata] = meshgrid(Xdata,Ydata);
%             Zdata = ( 0:outsiz-1 ) *NewReso;
%             Zdata = Zdata - (max(Zdata)/2);
%             Xo = repmat(Xdata,[1 1 size(NorVec,1)]);
            len = length(obj.GetThetaIndex([0 0],0,outsiz));
%             Xo = repmat(zeros(round(outsiz/2)*2+1),[1 1 size(NorVec,1)]);
            Xo = zeros(outsiz,len,size(NorVec,1));
            Yo = Xo;
            Zo = Xo;
            for n = 1:size(NorVec,1)
                N = NorVec(n,:);
                VertTheta = obj.UnitVector2Theta(N,BaseVector);
                [~,~,Posi] = obj.GetThetaIndex(Center(n,1:2),Theta(n),abs(outsiz*cos(VertTheta)));
                Cx = linspace(Posi(1,1),Posi(2,1),outsiz);
                Cy = linspace(Posi(1,2),Posi(2,2),outsiz);
                Cz = linspace((outsiz/2)*sin(VertTheta),-(outsiz/2)*sin(VertTheta),outsiz);
                X = zeros(outsiz,len);
                Y = X;
                Z = X;
                Cxyz = cat(2,Cx(:),Cy(:),Cz(:));
                for k = 1:length(Cz)
                    [xp,yp] = obj.GetThetaIndex(...
                        Cxyz(k,:),Theta(n) + pi/2,outsiz);
                    X(k,:) = xp;
                    Y(k,:) = yp;
                    Z(k,:) = Cz(k)+ Center(n,3);
                end
%                 X = Xdata ./ NorVec(n,1);
%                 Y = Ydata ./ NorVec(n,2);
%                 Z = ( -Xdata.*NorVec(n,1) -Ydata.*NorVec(n,2) )./NorVec(n,3);
%                 if NorVec(n,1)==0
%                     X = Xdata;
%                     X(:) = Center(n,1);
%                 else
%                     X = X + Center(n,1);
%                 end
%                 if NorVec(n,2)==0
%                     Y = Xdata;
%                     Y(:) = Center(n,2);
%                 else
%                     Y = Y + Center(n,2);
%                 end
%                 if NorVec(n,3)==0
%                     Z = Xdata;
%                     Z(:) = Center(n,3);
%                 else
%                     Z = Z + Center(n,3);
%                 end
                Xo(:,:,n) = X;
                Yo(:,:,n) = Y;
                Zo(:,:,n) = Z;
            end
        end

        function V = InterpNormLine_proto(obj,MSEG,ID,Image,Reso,varargin)
            %V = InterpNormLine_proto(obj,MSEG,ID,Image,Reso,varargin)
            % varargin Len , default 70 um,
            if nargin <=5
                Len = 70; % um
            elseif nargin > 5
                Len = varargin{1};
            end

            if ~isscalar(ID)
                error('Input ID is NOT Scalar')
            end

            LenPix = Len ./Reso(1);
            SEGReso = MSEG.ResolutionXYZ;
            xyz = MSEG.Pointdata(ID).PointXYZ;
            realxyz = (xyz-1).*SEGReso;
            ImSizXYZ = realxyz./Reso + 1;
            Vec = MSEG.Pointdata(ID).SphereFitUnitVector;
            Theta = obj.UnitVector2Theta(Vec,repmat([1 0 0],[length(Vec),1]));
            NTheta = Theta + pi/2;
            Vlen = length(obj.GetThetaIndex([0 0],0,LenPix));
            V = nan(Vlen,size(xyz,1));
            [Xp,Yp] = meshgrid(1:size(Image,1),1:size(Image,2));
            for n = 1:size(xyz,1)
                zind = (xyz(n,3) - 1)*SEGReso(3)./Reso(3) + 1;
                if ismatrix(Image)
                    im = single(Image);
                else
                    im = interp3(single(squeeze(Image)),...
                        Xp,Yp,ones(size(Xp))*zind);
                end
                [xp,yp] = obj.GetThetaIndex(ImSizXYZ(n,1:2),...
                    NTheta(n),LenPix);
                l = interp2(im,xp,yp);
                V(:,n) = l(:);
                Xqp(:,n) = xp;
                Yqp(:,n) = yp;
            end
        end

        function V = InterpNormLine_VideoInput(obj,MSEG,ID,Image,Reso,varargin)
            %V = InterpNormLine_proto(obj,MSEG,ID,Image,Reso,varargin)
            % varargin Len , default 70 um,
            if nargin <=5
                Len = 70; % um
            elseif nargin > 5
                Len = varargin{1};
            end

            if ~isscalar(ID)
                error('Input ID is NOT Scalar')
            end

            Image = squeeze(Image);
            if ndims(Image)~=3
                error('Input Image must be less than 3 dimmension.')
            end

            LenPix = Len ./Reso(1);
            SEGReso = MSEG.ResolutionXYZ;
            xyz = MSEG.Pointdata(ID).PointXYZ;
            realxyz = (xyz-1).*SEGReso;
            ImSizXYZ = realxyz./Reso + 1;
            Vec = MSEG.Pointdata(ID).SphereFitUnitVector;
            Theta = obj.UnitVector2Theta(Vec,repmat([1 0 0],[length(Vec),1]));
            NTheta = Theta + pi/2;
            Vlen = length(obj.GetThetaIndex([0 0],0,LenPix));
            Xqp = nan(Vlen,size(xyz,1));
            Yqp = Xqp;
            for n = 1:size(xyz,1)
                [xp,yp] = obj.GetThetaIndex(ImSizXYZ(n,1:2),...
                    NTheta(n),LenPix);
                Xqp(:,n) = xp;
                Yqp(:,n) = yp;
            end

            Zp = zeros([size(Xqp), size(Image,3)]);
            for n = 1:size(Image,3)
                Zp(:,:,n) = n;
            end
            Xqp = repmat(Xqp,[1 1 size(Image,3)]);
            Yqp = repmat(Yqp,[1 1 size(Image,3)]);
            V = interp3(single(Image),Xqp,Yqp,Zp);
        end

        function SEG = HS_add_Imagedata2SEG(~,Image,Reso,SEG,fname)
            % NewSEG = obj.HS_add_Imagedata2SEG(~,Image,Reso,SEG,field-Name)
            % field_Name must be ...
            %     StayTime
            Pdata = SEG.Pointdata;
            SegReso = SEG.ResolutionXYZ;
            if ndims(Image)>4
                error('inpuut Image must be less than 4 dimmention.')
            end
            if length(Reso)==2
                Reso(3) = 1;
            elseif length(Reso)>3
                Reso = Reso(1:3);
            end
            if length(SegReso)==2
                SegReso(3) = 1;
            end

            for n = 1:length(Pdata)
                if Pdata(n).ID<=0
                    continue
                end
                xyz = Pdata(n).PointXYZ;
                xyzq = (xyz-1).*SegReso./Reso + 1;
                x = xyzq(:,1);
                y = xyzq(:,2);
                z = xyzq(:,3);
                Matrix = nan(size(xyz,1),size(Image,4));
                for t = 1:size(Image,4)
                    im = double(Image(:,:,:,t));
                    if size(im,3)>1
                        p = interp3(single(im),x,y,z);
                    else
                        p = interp2(single(im),x,y);
                    end
                    Matrix(:,t) =p(:);
                end
                switch lower(fname)
                    case 'staytime'
                        Pdata(n).StayTimeSkel = Matrix;
                    otherwise
                        warrning('Please contcat Developper, Leo Sugashi Takuma.')
                        eval(['Pdata(n).' fname '=Matrix;']);
                end
            end
            SEG.Pointdata = Pdata;
        end

        function S_test = xyzSmooth_Bspline(obj,yxz,varargin)
            % S_test = xyzSmooth_Bspline(obj,yxz,varargin)
            % OutPutSizTime = 2; %% default
            % if nargin >2
            %     OutPutSizTime = varargin{1};
            % end
            % size(S_test,1) == size(yxz,1)*OutPutSizTime
            %% check
            siz = size(yxz,1);
            if siz <3
                S_test = yxz;
                return
            end
            %% initialize
            FirstDownSizRatio = obj.BsplineFistDownSizeRatio;
            OutPutSizTime = 2; %% default
            if nargin >2
                OutPutSizTime = varargin{1};
            end
            DIM = obj.BsplineDim;
            %% main
            FirstDoneTF = false;
            try
               [S_test] = obj.BsplineFunc(yxz,DIM,siz*FirstDownSizRatio);
               FirstDoneTF = true;
               [S_test] = obj.BsplineFunc(S_test,DIM,siz*OutPutSizTime);
               S_test(1,:) = yxz(1,:);
               S_test(end,:) = yxz(end,:);
            catch
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if FirstDoneTF
                    [S_test] = obj.BsplineFunc(S_test,0,siz*OutPutSizTime,[],'Bezier');
                else
                    [S_test] = obj.BsplineFunc(yxz,0,siz*FirstDownSizRatio,[],'Bezier');
                    [S_test] = obj.BsplineFunc(S_test,0,siz*OutPutSizTime,[],'Bezier');
                end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end
        end
        function S_test = xyzSmooth_Bspline_Reso(obj,yxz,inReso,outReso)
            % S_test = xyzSmooth_Bspline(obj,yxz,varargin)
            % OutPutSizTime = 2; %% default
            % if nargin >2
            %     OutPutSizTime = varargin{1};
            % end
            % size(S_test,1) == size(yxz,1)*OutPutSizTime
            %% check
            siz = size(yxz,1);
            if siz <3
                S_test = yxz;
                return
            end

            %% initialize
            FirstDownSizRatio = obj.BsplineFistDownSizeRatio;
            DIM = obj.BsplineDim;
            %% main
            FirstDoneTF = false;
            try
               [S_test] = obj.BsplineFunc(yxz,DIM,siz*FirstDownSizRatio);
               plen = obj.xyz2plen(S_test,inReso);
               OutPutSiz = ceil(sum(plen)/outReso);
               FirstDoneTF = true;
               [S_test] = obj.BsplineFunc(S_test,DIM,OutPutSiz);
               S_test(1,:) = yxz(1,:);
               S_test(end,:) = yxz(end,:);
            catch
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if FirstDoneTF
                    [S_test] = obj.BsplineFunc(S_test,0,OutPutSiz,[],'Bezier');
                else
                    [S_test] = obj.BsplineFunc(yxz,0,siz*FirstDownSizRatio,[],'Bezier');
                    plen = obj.xyz2plen(S_test,inReso);
                    OutPutSiz = ceil(sum(plen)/outReso);
                    [S_test] = obj.BsplineFunc(S_test,0,OutPutSiz,[],'Bezier');
                end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end
        end

        %% Image rotation Move, Stretch
        function [J,Xq,Yq,Zq] = Image2RotMovStretch(obj,objImage,objReso,RotMovStretchData,varargin)
            %[J,Xq,Yq,Zq] = Image2RotMovStretch(obj,objImage,objReso,RotMovStretchData)
            %[J,Xq,Yq,Zq] = Image2RotMovStretch(obj,objImage,objReso,RotMovStretchData,CutSize)
            %
            %Input :
            % objImage : objectImage (only 3D)
            % objReso : object Resolution [X Y Z]
            % RotMovStretchData : see also TS_3DRotateMoveStretch
            % (nargin ==4) = output size from surface(meaned end of z
            % size)
            %
            % Output
            % J = rotated and interpolated image
            if nargin ==4
                OutSize = size(objImage,3);
            else
                OutSize = varargin{1};
                if ~isscalar(OutSize)
                    error('Output size must be scalar')
                end
            end
            
            [X,Y,Z] = meshgrid(...
                (0:size(objImage,2)-1)*objReso(1),...
                (0:size(objImage,1)-1)*objReso(2),...
                (0:size(objImage,3)-1)*objReso(3));
            siz = size(X);
%             Center = (size(objImage)-1).*objReso /2;
            Center = RotMovStretchData.ObjectCenter;
            Rxyz = obj.xyz2RotMoveStretch_Reverse(...
                cat(2,X(:),Y(:),Z(:)),RotMovStretchData,Center);
            Xq = reshape(Rxyz(:,1),siz);
            Yq = reshape(Rxyz(:,2),siz);
            Zq = reshape(Rxyz(:,3),siz);
            J = interp3(X,Y,Z,single(objImage),Xq,Yq,Zq);
                        
            
            if size(J,3)==OutSize
                return
            elseif size(J,3) > OutSize
                J = J(:,:,1:OutSize);
            else
                if RotMovStretchData.Move(3) > 0
                    J = padarray(J,[0, 0, OutSize-size(J,3)],0,'post');
                else
                    J = padarray(J,[0, 0, OutSize-size(J,3)],0,'pre');
                end
            end
        end
        function [J,Xq,Yq,Zq] = Image2RotMovStretch_OnlyDepth(obj,objImage,objReso,RotMovStretchData,varargin)
            %[J,Xq,Yq,Zq] = Image2RotMovStretch(obj,objImage,objReso,RotMovStretchData)
            %[J,Xq,Yq,Zq] = Image2RotMovStretch(obj,objImage,objReso,RotMovStretchData,CutSize)
            %
            %Input :
            % objImage : objectImage (only 3D)
            % objReso : object Resolution [X Y Z]
            % RotMovStretchData : see also TS_3DRotateMoveStretch
            % (nargin ==4) = output size from surface(meaned end of z
            % size)
            %
            % Output
            % J = rotated and interpolated image
            if nargin ==4
                OutSize = size(objImage,3);
            else
                OutSize = varargin{1};
                if ~isscalar(OutSize)
                    error('Output size must be scalar')
                end
            end
            
            [X,Y,Z] = meshgrid(...
                (0:size(objImage,2)-1)*objReso(1),...
                (0:size(objImage,1)-1)*objReso(2),...
                (0:size(objImage,3)-1)*objReso(3));
            siz = size(X);
%             Center = (size(objImage)-1).*objReso /2;
%             Center = RotMovStretchData.ObjectCenter;
            XYZ = cat(2,X(:),Y(:),Z(:));
            if strcmpi(RotMovStretchData.InterpType,'phcp')
                RotMovStretchData.InterpType = 'pchip';
            end
            newZ = interp1(RotMovStretchData.Stretch_ly,...
                RotMovStretchData.Stretch_lx,...
                XYZ(:,3),...  %% old is zdata
                RotMovStretchData.InterpType);
            XYZ(:,3) = newZ;
            
            
            Rxyz = XYZ;
            Xq = reshape(Rxyz(:,1),siz);
            Yq = reshape(Rxyz(:,2),siz);
            Zq = reshape(Rxyz(:,3),siz);
            J = interp3(X,Y,Z,single(objImage),Xq,Yq,Zq);
            
            Padsiz = abs(round(RotMovStretchData.Move(3)/objReso(3)));
%             if RotMovStretchData.Move(3)<0                
%                 J = padarray(J,[0 0 Padsiz],0,'post');
%             elseif RotMovStretchData.Move(3)>0                
                J = padarray(J,[0 0 Padsiz],0,'pre');
%             end
            if size(J,3)==OutSize
                return
            elseif and(size(J,3) > OutSize,RotMovStretchData.Move(3)<0)
                J = J(:,:,size(J,3)-OutSize+1:end);
            elseif and(size(J,3) > OutSize,RotMovStretchData.Move(3)>=0)
                J = J(:,:,1:OutSize);
            else
                if OutSize>size(J,3)
                    if RotMovStretchData.Move(3) > 0
                        J = padarray(J,[0, 0, OutSize-size(J,3)],0,'post');
                    else
                        J = padarray(J,[0, 0, OutSize-size(J,3)],0,'pre');
                    end
                end
            end
        end
        function J = Image2RotMovStretch_byScatteredInterpolant(obj,objImage,objReso,outSize,outReso,RotMovStretchData)
            InputAns = input('This Function is Toooo Late, Proceed?? Yes(y), [ No(n) ]?','%d');
            if strcmpi(InputAns,'n')
                J = [];
                return
            end
            [X,Y,Z] = meshgrid(...
                (0:size(objImage,2)-1)*objReso(1),...
                (0:size(objImage,1)-1)*objReso(2),...
                (0:size(objImage,3)-1)*objReso(3));
            siz = size(X);
            Center = (size(objImage)-1).*objReso /2;
            Rxyz = obj.xyz2RotMoveStretch(...
                cat(2,X(:),Y(:),Z(:)),RotMovStretchData,Center);
            X = reshape(Rxyz(:,1),siz);
            Y = reshape(Rxyz(:,2),siz);
            Z = reshape(Rxyz(:,3),siz);
            x = (0:outSize(2)-1)*outReso(1);
            y = (0:outSize(1)-1)*outReso(2);
            z = (0:outSize(3)-1)*outReso(3);
            [Xq,Yq,Zq] = meshgrid(x,y,z);
            keyboard
            F = scatteredInterpolant(X(:),Y(:),Z(:),double(objImage(:)));
            J = F(Xq,Yq,Zq);
        end



        %% others
        function PieceLength = xyz2plen(~,xyz,Reso)
            % xyz position data caluculate to piece length
            Reso = repmat(Reso,[size(xyz,1),1]);
            xyz = (xyz-1).*Reso;
%             PieceLength =  sqrt(sum(diff(xyz,1,1).^2 ,2)); % sometime,
%             error, bellow
%            Out of memory. The likely cause is an infinite recursion within the program.
            PieceLength =  (sum(diff(xyz,1,1).^2 ,2)).^(1/2);
            PieceLength = cat(1,0,PieceLength);
        end
        function [xp,yp,Posi] = GetThetaIndex(~,Center,theta,Length,varargin)
            % [xp,yp,Posi] = GetThetaIndex(obj,Center,theta,Length,{Reso})
            % from TS_GetLinePro2mesh...
            % Zero is V(x,y,z) = [1 0 0];
            % [xp,yp] = S.GetThetaIndex([0 0],0,10)
            % xp =
            % -5  -4  -3  -2  -1  0   1   2   3   4   5
            % yp =
            % 0   0   0   0   0   0   0  0  0   0   0
            %% initialize
            if nargin==6
                Reso = varargin{1};
            else
                Reso = 1;
            end
            Length = round(Length/Reso);
            %% main
            fx1 = @(x,theta,Length) cos(pi+theta)*Length/2+x;
            fx2 = @(x,theta,Length) cos(theta)*Length/2+x;
            fy1 = @(x,theta,Length) sin(pi+theta)*Length/2+x;
            fy2 = @(x,theta,Length) sin(theta)*Length/2+x;

            x1 = fx1(Center(1),theta,Length);
            x2 = fx2(Center(1),theta,Length);
            y1 = fy1(Center(2),theta,Length);
            y2 = fy2(Center(2),theta,Length);
            Posi = [x1 y1; x2 y2];

            RadNum =  ceil(Length/2);
            pnum = RadNum * 2 + 1;
%             keyboard
            if (x2-x1) == 0
                xp = ones(1,pnum) * x1;
            else
                xp1 = flip(linspace(Center(1),x1,RadNum+1) ,2);
                xp2 = linspace(Center(1)+abs(diff(xp1(1:2))),x2,RadNum) ;
                xp = cat(2,xp1,xp2);
            end

            if (y2-y1) == 0
                yp = ones(1,pnum) * y1;
            else
                yp1 = flip(linspace(Center(2),y1,RadNum+1) ,2);
                yp2 = linspace(Center(2)+abs(diff(yp1(1:2))),y2,RadNum) ;
                yp = cat(2,yp1,yp2);
            end
        end
        function Val = Evaluate_2VecterParallelism(obj,V1,V2)
            % Val = Evaluate_2VecterParallelism(V1,V2)
            %
            % Compare with V1 and V2
            % V1,V2 = [u,v,w]; (will be vectorized to unit vector )
            % output :
            %   0 <= Val <= 1
            % Val : 0 -->  Orthogonal
            % Val : 1 -->  Parallel
            Val = abs((obj.UnitVector2Theta(V1,V2) - (pi/2))/(pi/2));
        end
        function [UnitVec,Scalar] = xyz2Vector(~,xyz,varargin)
            % [UnitVec,Scalar] = xyz2Vector(~,xyz,varargin)
            if nargin ==3
                Reso = varargin{1};
            else
                Reso = ones(1,3);
            end
            xyz = (xyz-1) .*Reso;
            if size(xyz,1)==1
                u = 0;
                v = 0;
                w = 0;
            else
                De = diff(xyz,1,1);
                u = nansum(De(:,1));
                v = nansum(De(:,2));
                w = nansum(De(:,3));
            end
            Scalar = sqrt(u^2 + v^2 + w^2 );
            UnitVec = [u,v,w]./Scalar;
        end
        function Theta = UnitVector2Theta(obj,V1,V2)
            V1 = obj.UnitVectorize(V1);
            V2 = obj.UnitVectorize(V2);
            CosTheta = sum(V1.*V2,2);
            Theta = acos(CosTheta);
        end
        function UnitV = UnitVectorize(~,V)
            Scalar = sqrt(sum(V.^2,2));
            UnitV = V./Scalar;
        end
        function R = RotX(~,x)
            R = [1, 0      , 0 ;
                0, cosd(x), -sind(x);
                0, sind(x),  cosd(x)];
        end
        function R = RotY(~,x)
            R = [cosd(x),  0   , sind(x);
                0,         1   ,  0     ;
                -sind(x),  0   , cosd(x)];
        end
        function R = RotZ(~,x)
            R = [cosd(x), -sind(x), 0 ;
                 sind(x),  cosd(x), 0 ;
                 0,       0,        1 ];
        end
        function [val,D] = Evaluate_2Line_Euclidean(obj,xyz1,xyz2)
%             Len_map = obj.GetEachLength(xyz1,xyz2,Reso);
%             [len,Dim] = min(size(Len_map));
%             if Dim == 1
%                 Len_map = Len_map';
%             end
            len = min(size(xyz1,1),size(xyz2,1));
            lenmax = max(size(xyz1,1),size(xyz2,1));
            V = nan(length( 1:lenmax-len+1 ),1);
            A = V;
            if size(xyz1,1) >= size(xyz2,1)
                basexyz = xyz2;
                objxyz = xyz1;
            else
                basexyz = xyz1;
                objxyz = xyz2;
            end

            for n = 1:lenmax-len+1
                P2Plen = basexyz - objxyz(n:n+len-1,:);
                P2Plen = sqrt(sum(P2Plen.^2,2));
                V(n) = nanstd(P2Plen);
                A(n) = nanmean(P2Plen);
            end
            val1 = min(V);
            dist1 = min(A);

            objxyz = flip(objxyz,1);
            for n = 1:lenmax-len+1
                P2Plen = basexyz - objxyz(n:n+len-1,:);
                P2Plen = sqrt(sum(P2Plen.^2,2));
                V(n) = std(P2Plen);
                A(n) = nanmean(P2Plen);
            end
            val2 = min(V);
            dist2 = min(A);
            [val,ind] = min([val1,val2]);
            Distance = [dist1,dist2];
            D = Distance(ind);
        end
        function V = get_Volume(obj,Type)
            V = false(obj.Segment.Size);
            Ind = eval(['obj.Segment.' Type ';']);
            V(Ind) = true;
        end
        function [SEG,Image,Reso] = make_sample(obj)
            % [SEG,Image,Reso] = make_sample()
            % Create Sample Segment data.
            Image = rand(16,16,8,'single');
            Image(Image<0.6) = 0;
            Image = uint8((Image - 0.6)/0.4*255);
            Image = uint8(imresize3(Image,[64,64,64]));
            Reso = [1 1 1.2];
            [rImage,NewReso] = TS_EqualReso3d_2017(Image,Reso,1);
            bw = rImage>100;
            skel = bwskel(bw);
            skel = TS_bwmorph3d(skel,'thin');
            SEG = TS_AutoSegment_v2021b(skel,NewReso,[],0);
            SEG = obj.set_Segment(SEG,'f');
        end
    end
end

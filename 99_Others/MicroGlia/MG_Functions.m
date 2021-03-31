classdef MG_Functions
    properties
        Version = 'Falcon'
        Update = '2021-03-31' %'2019-11-19'by Tsukada, 2021-03-09 Sugashi
        Leica_Type = 'sp8'
        Editors = 'Ryo Tsukada, T.Sugashi'
        UserData 
    end
    methods
        %% core functions
        function [output,varargout] = FormAnalysis(obj,Im,FIm,GIm,Reso,Center,CentroidXYZ)
            %output = FormAnalysis(~,Im,FIm,Reso,Center,CentroidXYZ)
            % Im : Input Volume Image of MG (Croped data)
            % FIm == TS_MexicanHatFilt(Im,Res);
            % Reso [X, Y, Z] , Resolution,
            % Center :  Centroid point in Wholed Image (Before Crop, Original Size) 
            % Centroid XYZ, In Croped data, Center of X,Y,and Z voxels.
            %
            %     Edit Selection soma bw bag, 2019. 10,05
            tic
            %% setup
            Fx =@(s) (s .*0.02 +50).*s *0.01; %% Old Threshold for sp8,,, might be wrong....
            if ~max(strcmpi(class(Im),{'uint8','uint16'}))
                error('Input Class Is NOT uint8')
            end
            Info = {...
                'MfileName     :' mfilename('fullpath') '\n',...
                'Last Updata   :' obj.Update '\n',...
                'Leica Version :' obj.Leica_Type '\n',...
                'All step data should be saved/preserved at every processing step.\n',...
                'I tried to add BW to the end of the field in the binarized data.\n',...
                'Save the input voxel size,.\n',...
                'output binarized data into "Index"..\n',...
                'This will save storage capacity...by Sugashi\n'...
                };
            if nargout ==2
                varargout{1} = Info;
            end
            output.Input_Volume_Size = size(Im);
            output.ID = [];
            output.Analysis_TF = [];
            output.Analysis_Soma_TF = [];
            output.Analysis_Process_TF = [];
            output.Analysis_Edge_TF = [];
            output.InputImage = Im;
            output.Resolution = Reso;
            output.Input_CenterOfImage = Center;
            output.Input_CentroidXYZ = CentroidXYZ;
            output.Output_CentroidXYZ = [];
            output.Dummy = [];
            
            %% Mexican Hat Filter
            output.FilteredImage = FIm;

            %% Binarize and Extract Soma Center
            signal_coef = 0.05;
            bg = TS_GetBackgroundValue(FIm(:));
            sg = sort(FIm(:),'descend');
            sg = mean(sg(1:round(length(sg)*signal_coef)));
            thn = bg+(sg-bg)*0.5;
            BW = FIm> thn;
            BW_forSkel = BW;
            output.Signal_Coef = signal_coef;
            output.FirstSignal = sg;
            output.FirstBackGroundNoise = bg;
            output.FirstBinarizedImage_BW = find(BW(:));
            % % Gaussian Filt
%             GaussinaFWHM = [1 1 5];
%             try
%                 GIm = TS_GaussianFilt3D_GPU(Im,Reso,GaussinaFWHM);
%             catch err
%                 disp(err.message)
%                 GIm = TS_GaussianFilt3D_parfor(Im,Reso,GaussinaFWHM);
%             end                        
%             output.GaussinaFWHM = GaussinaFWHM;
            output.GaussianFilteredImage = GIm;
            output.Dummy0 = "++++++++++++++ SOMA +++++++++++++";
            % % Opening
            Soma_siz = 4; % [um]                
            se = strel('ball',round(Soma_siz/Reso(1)/2),round(Soma_siz/Reso(3)/2),0);
            Im_soma =  imopen(Im,se);
            output.Opening_KernelRaius = [num2str(Soma_siz) ' um'];
            output.OpeningImageAsExtractionSoma = Im_soma;
            % %binalize
            sg = sort(Im_soma(:),'descend');
            sg = mean(sg(1:round(length(sg)*signal_coef)));
            bg = TS_GetBackgroundValue(Im_soma(:));
            thn = bg+(sg-bg)*0.5;
            BW_soma = Im_soma> thn;
            
            Length_Limit = 20;% 'um'            
            [Soma_Select_BW,Soma_Center] = ...
                obj.FindNearestObj(BW_soma,Center,Reso,Length_Limit);
            
            output.ExtractionSoma_FromOpeningImage_Signal = sg;
            output.ExtractionSoma_FromOpeningImage_Noise = bg;
            output.ExtractionSoma_FromOpeningImage_Threshold = thn;
            output.ExtractionSoma_FromOpeningImage_BW = find(BW_soma(:));
            output.ExtractionSoma_FromOpeningImage_Selected_BW = find(Soma_Select_BW(:));
            output.ExtractionSoma_FromOpeningImage_Soma_Center = Soma_Center;
            
            % % Centroid of detail 
            DiffCenter = Soma_Center - output.Input_CenterOfImage;
            output.Output_CentroidXYZ = CentroidXYZ + DiffCenter;
            output.Dummy1 = [];
            % % % some err occur.................
            roundZ = max( min( round(Soma_Center(3)), size(Im,3) ), 1);
            
            %% Re Binary From Sorma Center (Centroid)
            xdata = 1:size(Im,2);
            ydata = 1:size(Im,1);
            zdata = 1:size(Im,3);
            xind = and(xdata>=Soma_Center(1)-1,xdata<=Soma_Center(1)+1);
            yind = and(ydata>=Soma_Center(2)-1,ydata<=Soma_Center(2)+1);
            zind = and(zdata>=Soma_Center(3)-1,zdata<=Soma_Center(3)+1);
            % % % % % using Gaussian % % % % % % % % % % % % % % % % % % % % 
            % GIm = TS_GaussianFilt(Im,Reso,[1 1 1]);
            Signal = GIm(yind,xind,zind);
            Signal = nanmean(Signal(:));
            Noise = TS_GetBackgroundValue(GIm(:));
            GIm = max(GIm - Noise,0);
            if Noise >= Signal
                Threshold = nan;
                bw = false(size(GIm));                
            else
                Threshold = Fx(Signal-Noise);
                bw = GIm > Threshold;
            end
            
            % % selection Objct            
            
            Soma_SectionalArea_Image = ...
                obj.FindNearestObj(...
                bw(:,:,roundZ),...
                [Soma_Center(1:2) 1],...
                Reso,Length_Limit);
            Soma_SectionalArea = sum(Soma_SectionalArea_Image(:)) * prod(Reso(1:2));
            Vol = sum(bw(:)) * prod(Reso);
                       
            % % write
            
            output.Soma_FromGaussian_Signal = Signal;
            output.Soma_FromGaussian_Noise = Noise;
            output.Soma_FromGaussian_Threshold = Threshold;            
            output.Soma_FromGaussian_Volume = Vol;
            output.Soma_FromGaussian_SectionalArea = Soma_SectionalArea;
            output.Soma_FromGaussian_BW = find(bw(:));            
            output.Soma_FromGaussian_SectionalArea_BW = find(Soma_SectionalArea_Image(:));
            output = obj.RegionFormAnalysis2D_forSoma(...
                Soma_SectionalArea_Image,Reso,'FromGaussian',output);
            output.Dummy2 = [];
            
            
            
            
            % %%%%%%%%% using opened Image % % % % % %%%%%%%%%%%%%%%%%%%%%%%%
            Signal = Im_soma(yind,xind,zind);
            Signal = mean(Signal(:));
            Noise = TS_GetBackgroundValue(Im_soma(:));
            GIm = max(Im_soma - Noise,0);
            if Noise >= Signal
                Threshold = nan;
                bw = false(size(GIm));                
            else
                Threshold = Fx(Signal-Noise);
                bw = GIm > Threshold;
            end
            % % selection Objct  
            Soma_SectionalArea_Image = ...
                obj.FindNearestObj(...
                bw(:,:,roundZ),...
                [Soma_Center(1:2) 1],...
                Reso,Length_Limit);
            Soma_SectionalArea = sum(Soma_SectionalArea_Image(:)) * prod(Reso(1:2));
            Vol = sum(bw(:)) * prod(Reso);
            
            % % write
            output.Soma_FromOpening_Signal = Signal;
            output.Soma_FromOpening_Noise = Noise;
            output.Soma_FromOpening_Threshold = Threshold;            
            output.Soma_FromOpening_Volume = Vol;
            output.Soma_FromOpening_SectionalArea = Soma_SectionalArea;
            output.Soma_FromOpening_BW = find(bw(:));            
            output.Soma_FromOpening_SectionalArea_BW = find(Soma_SectionalArea_Image(:));
                        
            
            output = obj.RegionFormAnalysis2D_forSoma(...
                Soma_SectionalArea_Image,Reso,'FromOpening',output);            
            output.Dummy3 = [];
            output.Unit_of_Volume_SectionalArea = 'um^3 / um^2';
            output.Dummy4 = "++++++++++++++ Process +++++++++++++";
            %%
% %             
% %             %% feret properties needs more than R2019a
% %             try %% more than R2019a
% %                 Resion = regionprops(Soma_SectionalArea_Image,...
% %                     'Area','Perimeter','Eccentricity',...
% %                     'MajorAxisLength','MinorAxisLength',... 
% %                     'MaxFeretProperties','MinFeretProperties',....
% %                     'Orientation');
% %                 [~,Aind] = max(cat(1,Resion.Area)); %% somtimes has some object...
% %                 Resion = Resion(Aind);    
% %             catch err %% less than R2018b
% %                 theta = linspace(0, 180, 361);
% %                 fd = imFeretDiameter(Soma_SectionalArea_Image, theta);
% %                 Resion = regionprops(Soma_SectionalArea_Image,...
% %                     'Area','Perimeter','Eccentricity',...
% %                     'MajorAxisLength','MinorAxisLength',...
% %                     'Orientation');
% %                 [~,Aind] = max(cat(1,Resion.Area));
% %                 Resion = Resion(Aind);
% %                 [Maxi,MaI] = max(fd);
% %                 [Mini,MiI] = min(fd);
% %                 Resion.MaxFeretDiameter = Maxi;
% %                 Resion.MaxFeretAngle = theta(MaI);
% %                 Resion.MinFeretDiameter = Mini;
% %                 Resion.MinFeretAngle= theta(MiI);
% %             end            
% %             output.ResionPropsArea = Resion.Area * prod(Reso(1:2));
% %             output.MajorAxisLength = Resion.MajorAxisLength * Reso(1);
% %             output.MinorAxisLength = Resion.MinorAxisLength * Reso(1);
% %             output.Orientation = Resion.Orientation;
% %             output.Eccentricity = Resion.Eccentricity; %% 0.0 circle <---->  line 1.0
% %             output.Perimeter = Resion.Perimeter * Reso(1);
% %             output.MaxFeretProperty_Diameter = Resion.MaxFeretDiameter *Reso(1);
% %             output.MaxFeretProperty_Theta    = Resion.MaxFeretAngle;
% %             output.MinFeretProperty_Diameter = Resion.MinFeretDiameter *Reso(1);
% %             output.MinFeretProperty_Theta    = Resion.MinFeretAngle;
            %% Process
            %% Area Open and output skeleton MIP data  
            if max(BW_forSkel(:)) == false
                ThinIm = false(size(BW_forSkel));
            else
%                 keyboard
                try
    %                 skel3D = bwskel(BW);
                    skel3D = bwskel(BW_forSkel);
                catch err
                    warning(err.message)
    %                 skel3D = Skeleton3D(BW);
                    skel3D = Skeleton3D(BW_forSkel);
                end
                % % saimenn ka bubu no sai kei san
                try
                    ThinIm = TS_Skeleton3D_mex(skel3D);
                catch 
                    ThinIm = TS_bwmorph3d_v2019a(skel3D,'thin');                    
                end
            end

            % % selection    
            ThinLabel = bwlabeln(ThinIm);
            Lnum = ThinLabel(Soma_Select_BW);
            Lnum(Lnum==0) = [];
            [h,x] = hist(Lnum,1:max(Lnum));
            x(h==0) = [];
            choice = false(size(ThinIm));

            for n = 1:length(x)
                choice = or(choice,ThinLabel==x(n));
            end

            ThinIm = choice;
            Tmip = squeeze(max(ThinIm,[],3));
            
            % % write
            output.Skeleton_FromBWGaussianIm_BW = find(ThinIm(:));
            output.Skeleton_FromBWGaussianIm_Select_BW = find(ThinIm(:));
            output.Skeleton_FromBWGaussianIm_Select_MIP_BW = find(Tmip(:));
            
            %% Process Direction and Momentum evaluation
            %% TS program --> MN
            ct = round(Soma_Center);

            %% distance (2D)
            if max(isnan(ct))
                base = false(size(Tmip));
            else
                base = zeros(size(Tmip));
                base(ct(2),ct(1)) = 1;
                base = bwdist(base) ;
            end
            Thindist = base .* single(Tmip);   
            output.Skeleton2D_dist = Thindist;

            %% Sholl analysis
            % Number measurement
            Cir = base;

            for n=6:2:80
                Cir(Cir>=n*1/Reso(1)&Cir<n*1/Reso(1)+1) = 1; 
            end
            Cir(Cir>1)=0;
            Cir(Cir<1)=0;
            C = imfuse(Thindist>0,Cir,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);

            StepDist = 6:2:80;% unit [um]
            P_num = zeros([1 length(StepDist)]);

            for n = 1:length(StepDist)
                ring = Thindist>=StepDist(n)*1/Reso(1)&Thindist<StepDist(n)*1/Reso(1)+1;%8.33??????2??????m??????????????????pixel???T???C???Y,1.74???????????[???g3????????????????l 
                % 8.33 is a pixel size equivalent to 2 ??????m, 1.74 is a value exceeding root 3
                [~,RingObjNum] = bwlabel(ring,8);
                P_num(n) = RingObjNum;
                clear ring ringlbl
            end
            P_numM = [P_num(6) P_num(9) P_num(10) P_num(18)];
            P_numDist = [StepDist(6) StepDist(9) StepDist(10) StepDist(18)];
            output.Sholl_Analysis_image = C;
            output.Sholl_Analysis_StepDist = StepDist;
            output.Sholl_Analysis_P_num = P_num;
            output.Sholl_Analysis_StepDistM = P_numDist;
            output.Sholl_Analysis_P_numM = P_numM;
            %% Dived Segment Number
            Segment_Num = 20;
            L = MN_DivideArea(Segment_Num,Soma_Center(1:2),[size(Im,1) size(Im,2)]);
            L_Len = L .*single(max(ThinIm,[],3));

            Theta = linspace(0,2*pi,Segment_Num+1);
            Theta(end) = [];
            Each_Length = zeros(Segment_Num,1);
            Each_MaxLength = zeros(Segment_Num,1);
            for n = 1:Segment_Num
                Each_Length(n) = sum(L_Len(:)==n) * Reso(1);
                EML = max(Thindist(L==n));
                if isempty(EML)
                    EML = nan;
                else
                    EML = EML *Reso(1);
                end
                Each_MaxLength(n) = EML;
            end
            output.SegmentAnalysis_Label = uint8(L);
            output.SegmentAnalysis_Label_Skeleton2D = L_Len;
            output.SegmentAnalysis_Theta = Theta;
            output.SegmentAnalysis_Each_Length = Each_Length;
            output.SegmentAnalysis_Each_MaxLength = Each_MaxLength;
            output.SegmentAnalysis_Units = 'rad. and um';


            %% Toc
%             toc
        end
        function AdjImage = VesselsMicrogliaContrastAdjust(~,Image,Reso)
            % AdjImage = VesselsMicrogliaContrastAdjust(Image,Reso)
            % Ch1 : vessels
            % Ch2 : MicroGlia
            
            Image = TS_Circmedfilt2d(Image,2);
            vImage = TS_GaussianFilt3D_GPU(Image(:,:,:,1,1),Reso,[2 2 5]);
            gImage = TS_GaussianFilt3D_GPU(Image(:,:,:,1,2),Reso,[1 1 5]);
            gGamma = TS_GammaFilt(gImage,0.3);
            vadj = TS_AdjImage(vImage);
            gadj = TS_AdjImage(gGamma);
            AdjImage = cat(5,vadj,gadj);
        end
        function [ROIdata,xyz,bw] = MG_AutoCrop(~,Image,Reso)
            
            th = 0.4;
            Image = TS_Circmedfilt2d(Image,2);
            gImage = TS_GaussianFilt3D_GPU(Image,Reso,[4 4 5],5);
            bw = false(size(gImage));
            parfor n = 1:size(Image,3)
                im = gImage(:,:,n);
                im = im - min(im(:));
                im = im ./max(im(:));
                bw(:,:,n) = im >= th;
            end
            s = regionprops(bwlabeln(bw,26),'Centroid');
            xyz = cat(1,s.Centroid);
            ROIdata = TS_Centroid2ROIdata(s,[.4 .1 1.0]);
        end
        %% Spacail shape/form Analysis 2D
        function output = RegionFormAnalysis2D_forSoma(~,bw,Reso,AddFname,varargin)
            if nargin == 5
                output = varargin{1};
            else
                eval(['output.' AddFname '= [];']);
            end
            %% feret properties needs more than R2019a
            if max(bw(:)) == false
                Resion.Area = nan;
                Resion.MajorAxisLength = nan;
                Resion.MinorAxisLength = nan;
                Resion.Orientation = nan;
                Resion.Eccentricity = nan;
                Resion.Perimeter = nan;
                Resion.MaxFeretDiameter = nan;
                Resion.MaxFeretAngle = nan;
                Resion.MinFeretDiameter = nan;
                Resion.MinFeretAngle = nan;
                Resion.Circularity = nan;
            else
                try %% more than R2019a
                    Resion = regionprops(bw,...
                        'Area','Perimeter','Eccentricity',...
                        'MajorAxisLength','MinorAxisLength',... 
                        'MaxFeretProperties','MinFeretProperties',....
                        'Orientation' ,'Circularity');
                    [~,Aind] = max(cat(1,Resion.Area)); %% somtimes has some object...
                    Resion = Resion(Aind);    
                catch  %% less than R2018b
                    theta = linspace(0, 180, 361);
                    fd = imFeretDiameter(bw, theta);
                    Resion = regionprops(bw,...
                        'Area','Perimeter','Eccentricity',...
                        'MajorAxisLength','MinorAxisLength',...
                        'Orientation');
                    [~,Aind] = max(cat(1,Resion.Area));
                    Resion = Resion(Aind);
                    [Maxi,MaI] = max(fd);
                    [Mini,MiI] = min(fd);
                    Resion.MaxFeretDiameter = Maxi;
                    Resion.MaxFeretAngle = theta(MaI);
                    Resion.MinFeretDiameter = Mini;
                    Resion.MinFeretAngle= theta(MiI);
                end            
            end
            eval(['output.ResionPropsArea_' AddFname ' = Resion.Area * prod(Reso(1:2));']);
            eval(['output.MajorAxisLength_' AddFname ' = Resion.MajorAxisLength * Reso(1);']);
            eval(['output.MinorAxisLength_' AddFname ' = Resion.MinorAxisLength * Reso(1);']);
            eval(['output.Orientation_' AddFname ' = Resion.Orientation;']);
            eval(['output.Eccentricity_' AddFname ' = Resion.Eccentricity;']); %% 0.0 circle <---->  line 1.0
            eval(['output.Perimeter_' AddFname ' = Resion.Perimeter * Reso(1);']);
            eval(['output.MaxFeretProperty_Diameter_' AddFname ' = Resion.MaxFeretDiameter *Reso(1);']);
            eval(['output.MaxFeretProperty_Theta_' AddFname '    = Resion.MaxFeretAngle;']);
            eval(['output.MinFeretProperty_Diameter_' AddFname ' = Resion.MinFeretDiameter *Reso(1);']);
            eval(['output.MinFeretProperty_Theta_' AddFname '    = Resion.MinFeretAngle;']);
            eval(['output.Circularity_' AddFname ' = Resion.Circularity;']); %% 1.0 circle <---->  line 0.0
        end
        function  [BW,Centroid] = FindNearestObj(~,bw,Center,Reso,Length_Limit)
%             Length_Limit = 20;% 'um'
            if max(bw(:)) == false
                BW = bw;
                Centroid = nan(1,3);
                return
            end
            S = Segment_Functions;
            IS2d = ismatrix(bw);
            if IS2d
                bw = cat(3,bw,false(size(bw)));
            end
            CC = bwconncomp(bw);
            minLen = zeros(1,CC.NumObjects);
            s = regionprops(CC,'Centroid');
            for n = 1:CC.NumObjects
                [y,x,z] = ind2sub(CC.ImageSize,CC.PixelIdxList{n});
                Len = S.GetEachLength(Center,cat(2,x(:),y(:),z(:)),Reso);
                minLen(n) = min(Len);
            end
            [MinimumLength,IndexCC] = min(minLen);
            BW = false(CC.ImageSize);
            if MinimumLength > Length_Limit
                warning([mfilename ' : /No founder nearest soma.'])
                Centroid = nan(1,3);
            else                
                Centroid = s(IndexCC).Centroid;
                BW(CC.PixelIdxList{IndexCC}) = true;
            end
            if IS2d
                BW(:,:,2) = [];
            end
        end
        
        %% Main Function
        function output = MG2FormAnalysis(...
                obj,Image,Reso,ROIdata,SaveDir,promoter,Locno,varargin)
            %% 
            % output = MGImageROIdata2FormAnalysis(...
            %     obj,Image,Reso,ROIdata,SaveDir,promoter,Loc. No.)
            % output = MGImageROIdata2FormAnalysis(...
            %     obj,Image,Reso,ROIdata,SaveDir,promoter,Loc. No.,mouse#)
            %
            %
            %
            % supported Sugashi
            %
            % Edit Class objective,
            % high performance Skeleton method 
            % some bag, modify.
            narginchk(7,8)
            TIME = tic;
            %% input check
            if ndims(Image) ~= 3
                error('Input Image is NOT 3d Volumes')
            end

            if Reso(1) ~= Reso(2)
                error('input Resolution X and Y is not equal.')
            end

            if numel(Reso)~= 3
                error('Input Resolution Need 3 (X,Y,Z) numels vector');
            end

            mouseNumber = 'NoNumber';
            if nargin == 8
                mouseNumber = varargin{1};
                if isinteger( mouseNumber )
                    mouseNumber = num2str(mouseNumber);
                end
            end

            [~,ExName] = TS_ClockDisp;
            % ExName = [date x(9:end)];
            % ExName(ExName == '-') = [];
            if nargin == 9
                ExName = varargin{2};
                if ~ischar(ExName)
                    error('Input Extra Name must BE "Char" class.')
                end
            end
            
            if ~ischar(ExName) || ~ischar(promoter) || ~ischar(Locno) || ~ischar(mouseNumber)
                error('Input character string is not correct...')
            end
            
            NewDirName = ['Result_' promoter '_Loc' Locno '_' mouseNumber '_' ExName];
            DirCheck = dir([SaveDir filesep NewDirName]);
            while ~isempty(DirCheck)
                error(' Upps... It alredy has been exist..')
            end


            %% initialize
            CropSize = [80 80 81]; %% unit [um]
            Edge_Lim = 20; % unit [um]

            %% output setting up
            output.AnalysisDate = TS_ClockDisp;
            output.SaveDir = SaveDir;
            output.NewDir = NewDirName;
            output.Promoter = promoter;
            output.Location = Locno;
            output.MouseNumber = mouseNumber;
            output.InputImage = Image;
            output.filteredImage = [];
            output.Resolution = Reso;
            output.Edge_Lim = [num2str(Edge_Lim) ' um'];
            %% main
%             Poj = gcp('nocreate');
%             if isempty(Poj)
%                 parpool
%             end
            GaussinaFWHM = [1 1 5];
            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            GaussianImage = TS_GaussianFilt3D_GPU(Image,Reso,GaussinaFWHM);
            fImage = TS_MexicanHatFilt(Image,Reso);
            %% check program %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             GaussianImage = single(Image);
%             fImage = single(Image);
            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            output.GaussinaFWHM = GaussinaFWHM ;
            output.GaussianImage = GaussianImage;
            output.filteredImage = fImage;
            %% ROIdata 2 Centroid
            s(1:length(ROIdata)) =  struct('Centroid',[],'TF',[]);
            IDs = 1:length(ROIdata);
            for n = 1:length(ROIdata)
                if and(strcmpi(ROIdata(n).class,'impoint'),...
                        strcmpi(ROIdata(n).Plane,'xy')) && ROIdata(n).existTF
                    s(n).Centroid = [double(ROIdata(n).Position), double( ROIdata(n).Depth(1) )];
                    s(n).TF = true;
                else
                    s(n).TF = false;
                end
            end
            TF = cat(1,s.TF);
            Cent = s(TF);
            IDs = IDs(TF);
            output.Centroid = Cent;
            %% Cent 2 Crop
            Cropdata = TS_centroid2Crop(Image,fImage,CropSize,Reso,Cent);
            Gcrop = TS_centroid2Crop(GaussianImage,[],CropSize,Reso,Cent);
            %% Analysis MG Process
            output.Cropdata = Cropdata;
            for n = 1:length(output.Cropdata)
                output.Cropdata(n).Image = [];
                output.Cropdata(n).fImage = [];
            end
            % X = zeros(1,length(Cropdata)); 
            n = 1;
            fprintf('Analysis Each MG:')
            [X,Info] = obj.FormAnalysis(...
                    Cropdata(n).Image,Cropdata(n).fImage,Gcrop(n).Image,...
                    Reso,Cropdata(n).CenterOfImage,Cropdata(n).centroidXYZ);
                X(n).Analysis_TF = true;
                X(n).Analysis_Soma_TF = true;
                X(n).Analysis_Process_TF = true;
            output.Infomation = Info;
            disp(n)
            FOV = (size(Image)-1) .* Reso;
            % % create same structure
            for n = 1:length(Cropdata)
                X(n).ID = IDs(n);
            end
%             PoolObj = gcp;
%             if isempty(PoolObj)
% %                 PoolObj = parcluster;
%                 PoolObj = parpool;
%             end
            TS_WaiteProgress(0)
            for n = 2:length(Cropdata)
                try
                X(n) = obj.FormAnalysis(...
                    Cropdata(n).Image,Cropdata(n).fImage,Gcrop(n).Image,...
                    Reso,Cropdata(n).CenterOfImage,Cropdata(n).centroidXYZ);                
                X(n).ID = IDs(n); %% re write . because output.ID = [];
                X(n).Analysis_TF = true;
                X(n).Analysis_Soma_TF = true;
                X(n).Analysis_Process_TF = true;
                NewCent = X(n).Output_CentroidXYZ;
                NewCent = (NewCent-1).*Reso;
                TFx = and(Edge_Lim<=NewCent(1) , NewCent(1) <= FOV(2)-Edge_Lim);
                TFy = and(Edge_Lim<=NewCent(2) , NewCent(2) <= FOV(1)-Edge_Lim);
                TFz = and(Edge_Lim<=NewCent(3) , NewCent(3) <= FOV(3)-Edge_Lim);    
                X(n).Analysis_Edge_TF = TFx && TFy && TFz;  
                TS_WaiteProgress(n/length(Cropdata))
                catch err
                    keyboard
                end
            end
            % X(2:length(Cropdata)).InputImage = [];
            output.Result = X;

            %% Saves
            %% Create New Directory and save developer infomation
            mkdir([SaveDir filesep NewDirName])
            fprintf('Analysis Time : ');
            AnalysisTime = toc(TIME);
            toc(TIME)
            fprintf(' output figure, and Save data(s)... \n');
%             PoolObj = TS_classdef2structure(PoolObj);
%             PoolObj.Cluster = TS_classdef2structure(PoolObj.Cluster);
%             PoolObj.Cluster.Jobs = [];
%             PoolObj.FevalQueue = TS_classdef2structure(PoolObj.FevalQueue);
%             PoolObj.FevalQueue.Parent = [];
            MG_FunctionInfo = TS_classdef2structure(obj);
%             save([SaveDir filesep NewDirName filesep 'DeveloperInfo.mat'],...
%                 'AnalysisTime','PoolObj','MG_FunctionInfo')
            save([SaveDir filesep NewDirName filesep 'DeveloperInfo.mat'],...
                'AnalysisTime','MG_FunctionInfo')
            ROIdata = TS_Centroid2ROIdata(cat(1,X.Output_CentroidXYZ));
            save([SaveDir filesep NewDirName filesep 'NewROIdata.mat'],...
                'ROIdata')            
            %% Save Figure and TIFF
            
            obj.SaveFigures_FormAnalysis(output)
            
            %% make xls tables and save
            [A,NoImageX] = obj.VectorStructure2Table(X);
            output.Result = NoImageX;    
            save([SaveDir filesep NewDirName filesep 'ResultXLS.mat'],'A')
            writetable(A,[SaveDir filesep NewDirName filesep 'XLSData.csv'])
            %% save mat data as dirname
            output.AnalysisTime = toc(TIME);
            eval([NewDirName ' = output;']);
            fprintf('save output. with Image...')
            save([SaveDir filesep NewDirName filesep 'Result.mat'],NewDirName,'-v7.3')
            fprintf('Done\n save ROIdata ')
            TS_WaiteProgress(0)
            for n = 1:length(X)
                eval(['ROI_' num2str(X(n).ID) ' = X(n);']);
                save([SaveDir filesep NewDirName filesep 'Result.mat'],...
                    ['ROI_' num2str(X(n).ID)],'-append')
                eval(['clear ROI_' num2str(X(n).ID) ])
                TS_WaiteProgress(n/length(X))
            end
            
            %% add since v2019Beta
            % clear Image data
            data = output;
            data.InputImage = [];
            data.GaussianImage = [];
            data.filteredImage = [];            
            eval(['NoImage_' NewDirName ' = data;']);
            fprintf('Done\n save NoImage data... ')
            save([SaveDir filesep NewDirName filesep 'Result.mat'],['NoImage_' NewDirName],'-append')
            fprintf('Done. \n')
            %% last time output
            toc(TIME)
        end
        
        %% support functions
        function SaveFigures_FormAnalysis(obj,output)
            %% See also, RyoT_Output_MG_Analysis
            SaveDir = [output.SaveDir filesep  output.NewDir];
            FigDir = [SaveDir filesep 'FIG'];
            TiffDir = [SaveDir filesep 'TIFF'];
            mkdir(FigDir)
            mkdir(TiffDir)
            TS_WaiteProgress(0)
            for n = 1:length(output.Result)
                Handles = obj.OutputFigure_FormAnalysis(output.Result(n));
                fgh = Handles.Figure;
                %% save
                NoSTR = num2str(n);
                for xxx = 1:3-length(NoSTR)
                    NoSTR = ['0' NoSTR];
                end
                drawnow
                saveas(fgh,[FigDir filesep 'No_' NoSTR '.fig'] )
                saveas(fgh,[TiffDir filesep 'No_' NoSTR '.tif'] )
                close(fgh)

                %% progress
                TS_WaiteProgress(n/length(output.Result))
            end
        end
        function Handles = OutputFigure_FormAnalysis(obj,Result)
            
            fgh = figure('Position',[50 30 1800 900]);
            axh(1) = axes(fgh,'Position',[0.001 0.501 0.248 .45]);
            axh(2) = axes(fgh,'Position',[0.001 0.001 0.248 .45]);
            axh(3) = axes(fgh,'Position',[0.251 0.501 0.248 .45]);
            axh(4) = axes(fgh,'Position',[0.251 0.001 0.248 .45]);
            axh(5) = axes(fgh,'Position',[0.501 0.501 0.248 .45]);
            axh(6) = axes(fgh,'Position',[0.501 0.001 0.248 .45]);
            axh(7) = axes(fgh,'Position',[0.801 0.601 0.190 .35]);
            axh(8) = polaraxes(fgh,'Position',[0.771 0.055 0.208 .40]);


            im = max( Result.InputImage,[],3);
            im = im - min(im(:)); im = double(im); im = uint8(im/max(im(:))*255);
            imagesc(axh(1),ind2rgb(im,Colormap_Gamma( ColormapGreen(256),1) ) )
            title(axh(1),['Raw Croped Image #' num2str(Result.ID)])

            im = max( Result.FilteredImage,[],3);
            im = im - min(im(:)); im = double(im); im = uint8(im/max(im(:))*255);
            imagesc(axh(2),ind2rgb(im,Colormap_Gamma( ColormapGreen(256),.5) ) )
            title(axh(2),'Mexican hat Filtered ')

%             im = max( Result.FirstBinarizedImage,[],3);
            bw = false(Result.Input_Volume_Size);
            bw(Result.FirstBinarizedImage_BW) = true;
            im = max( bw,[],3);
            imagesc(axh(3),ind2rgb(im,gray(2)))
            title(axh(3),'BW')

%             im = max( Result.Soma_SectionalArea_Image,[],3);
%             im = max( Result.Soma_SectionalArea_Image,[],3);
            bw = false(Result.Input_Volume_Size(1:2));
            bw(Result.Soma_FromGaussian_SectionalArea_BW)= true;            
            imagesc(axh(4),ind2rgb(bw,gray(2)))
            title(axh(4),'Soma select')

            bw = false(Result.Input_Volume_Size);
            bw(Result.Skeleton_FromBWGaussianIm_BW) = true;
            im1 = uint8(max( bw,[],3));
            bw = false(Result.Input_Volume_Size);
            bw(Result.Skeleton_FromBWGaussianIm_Select_BW) = true;
            im2 = uint8( max(bw,[],3));
            im = im1 + im2;
            imagesc(axh(5),ind2rgb(im,cat(1,[0 0 0],[1 .8 0],[1 1 1])))
            title(axh(5),'Skeleton and Selected')

            imagesc(axh(6), Result.Sholl_Analysis_image)
            title(axh(6),'Sholl Analysis')

            for an = 1:6
                axis(axh(an),'image')
                axh(an).XTickLabel = '';
                axh(an).YTickLabel = '';
            end

            p1 =  Result.Sholl_Analysis_StepDist;
            p2 =  Result.Sholl_Analysis_P_num;
            plot(axh(7),p1,p2,'o-','linewidth',2);
            title(axh(7),'Result of Sholl Analysis')
            ylabel(axh(7),'Object Number')
            xlabel(axh(7),'Distance from Soma centorid [um]')

            Theta =  Result.SegmentAnalysis_Theta;
            Theta = [Theta Theta(1)];
            p1 =  Result.SegmentAnalysis_Each_Length;
            p1 = [p1 ; p1(1)];
            polarplot(axh(8),Theta,p1,'LineStyle','--','LineWidth',1,'Marker','^')
            hold on
            p2 =  Result.SegmentAnalysis_Each_MaxLength;
            p2 = [p2 ; p2(1)];
            polarplot(axh(8),Theta,p2,'LineStyle','-','LineWidth',1,'Marker','*')
            axh(8).ThetaZeroLocation = 'top';
            axh(8).ThetaDir= 'clockwise';
            axh(8).RLim = [0 300];
            title(axh(8),'Rotation Segment Area Analysis')
            lh = legend('Length(pix. Num.)','Maximum Dist. from soma');
            lh.Position  = [0.8900 1.0000e-03 0.1094 0.0406];
            
            Handles.Figure = fgh;
            Handles.Axes = axh;
        end
        function [T,Structure] = VectorStructure2Table(obj,data)            
            fName = fieldnames(data);
            for n = 1:length(fName)
                check_data = eval(['data(1).' fName{n}]);
                if ~isnumeric(check_data) && ~isempty(check_data)...
                        && ~ischar(check_data) && ~islogical(check_data)
                    for k = 1:length(data)
                        eval(['data(k).' fName{n} ...
                            '= obj.Struct2StringWithSize(data(k).' fName{n} ');']);
                    end
                end
            end           
            for n = 1:length(fName)                
                check_data = eval(['data(1).' fName{n}]);
                if ~ischar(check_data) && ~isvector(check_data)...
                        && ~isempty(check_data) && ~islogical(check_data)
                    for k = 1:length(data)
                        eval(['data(k).' fName{n} ...
                            '= obj.Struct2StringWithSize(data(k).' fName{n} ');']);
                    end
                end
            end
            for n = 1:length(fName)                                
                if strcmpi('bw',fName{n}(end-1:end))
                    for k = 1:length(data)
                        eval(['data(k).' fName{n} '= ''Index of BW'';']);
                    end
                end 
            end
            T = struct2table(data,'AsArray',true);
            Structure = data;
        end
        function STR = Struct2StringWithSize(~,data)
            STRsiz = num2str(size(data),'%d x ');
            STR = [STRsiz(1:end-1) ' ' class(data)];
        end
    end
end
function STR = History
%   'function output = RyoT_Analysis_MG_Process_v2019Delta(Im,FIm,Reso,Center,CentroidXYZ)\n ' ...
%      '       \n ' ...
%      '       \\TS-QVHL1D2\shere\MNTI\MN_Program\MN_culcharafixth170104\n ' ...
%      '       \n ' ...
%      '       function [P_num,result,vcon,ths,thn,thre] = MN_culcharafixth160626(Im,Ims,tit,N,ss)\n ' ...
%      '       Input is ...\n ' ...
%      '           Im = [] : Image of Glia Image(3D)\n ' ...
%      '           Ims0\n ' ...
%      '           Reso  = []l]\n ' ...
%      '           \n ' ...
%      '       output is ..\n ' ...
%      '           tit, title\n ' ...
%      '           ''result'' ; struct(''Plength'',[],''Area'',[])\n ' ...
%      '                   eace Process Length and Whole Area (sumation)\n ' ...
%      '           ''P_num'', Shole ?????????????????????A6um?????~???A?????????????????????????_??????\n ' ...
%      '       				As a result of sholl analysis, the bumber of vertices in ?????? increments after 6um\n ' ...
%      '           ''P_numM'',??????\???I????????_????????\n ' ...
%      '       				Number ob representative intersections\n ' ...
%      '           ''ThinIm'', ?????????????????????????i???RD)\n ' ...
%      '       				Thinning result(3D)\n ' ...
%      '           ''fin'',????????8????????????\n ' ...
%      '       				Region 8 division\n ' ...
%      '           ''fin2''???@??????????????8????????????,\n ' ...
%      '       				Thinning 8 divisions\n ' ...
%      '           ''SIm'',soma???@Image\n ' ...
%      '           ''FIm2'',Filtered???@Image ???QD\n ' ...
%      '           ''Vol''???@soma Volume,\n ' ...
%      '           ''Area'', Soma Area(???f???????j\n ' ...
%      '           ''lp'',???@???~?????????????a\n ' ...
%      '       				Diameter of circular approximation\n ' ...
%      '           ''MaxRVal'', ?????E?????????????????????\n ' ...
%      '       				Maximum distance of cell area\n ' ...
%      '           ''MaxPlen''???@?????N????????????????\n ' ...
%       '      				Maximum distance of process\n ' ...
%      '           \n ' ...
%      '       ss = 0.6;\n ' ...
%      '       ex = ss/0.2;%ss?????X???e???b???v???T???C???Y,?????????Xss0.2??????????????????????????????????I???u???W???F???N???g?????T???C???Y????????????????????????????????????????????0.2??????\n ' ...
%      '       ss is step size	Since the size of the object to be removed was originally determined by 0.2um, 0.2\n ' ...
%      '       Reso(1) = 0.2;\n ' ...
%      '       \n ' ...
%      '       Editors Log, Original function edit by Ryo Hachiya as\n ' ...
%      '           RyoH_Analysis_MG_Process_v*\n ' ...
%      '           2019 09 02 Japanese to English Ryo Tsukada\n ' ...
%      '           2019 09 04 edit by Sugashi, T.\n ' ...
%      '                09  17 add MajorAxisLength, MinorAxisLength, \n ' ...
%      '                          MaxFeretProperties, MinFeretProperties,\n ' ...
%      '                           Perimeter n Eccentricity\n ' ...
%      '       \n ' ...
%      '           Edit Input, Regionprops, some bug  by sugashi, 2019,09,25'];

%  fprintf(STR)
end
classdef Reconstruction_Group
    %% see also Segment_Functions, TS_AutoSEG_mex,...
    %
    % version 1.1,
    % add Check_Chase_data code 
    %
    % version 1.1.1
    % add Voxels Patch 
    
    properties
        Name(1,:)char
        PolyNum(1,1)uint16 {mustBeReal,mustBeGreaterThan(PolyNum,2)} = 8
        SEGview_textLim(1,1) = 100
        CircumferenceNum = 8;
        Editor = 'Leo-Takuma-Sugashi'
        Version = '1.1.1'
        Value
        UserData
    end
    methods
        %% Main Fucntion)
        function bw = SEG2mask(~,SEG,outSiz)
            Siz = SEG.Size;
            SegReso = SEG.ResolutionXYZ;
            FOV = (Siz-1).*SegReso;
            outReso = FOV./(outSiz-1);
            bw = false(outSiz);
            for n = 1:length(SEG.Pointdata)
                ID = SEG.Pointdata(n).ID;
                if ID <0
                    continue
                end
                xyz = SEG.Pointdata(n).PointXYZ;
                xyzq = (xyz-1).*SegReso./outReso + 1;
                if isnan(outReso(3))
                    xyzq(:,3) = 1;
                end
                ind = TS_polyline2mask3D(xyzq,outSiz);
                bw(ind) = true;
            end   
        end
        function bw = SEG2Reconstract(obj,SEG)
            DiamImage = obj.SEG2DiamImage(SEG);
            if SEG.Size(3) ==1
                inReso = mean(SEG.ResolutionXYZ(1:2));
            else
                inReso = mean(SEG.ResolutionXYZ);
            end
            bw = TS_Diam2ReconstBW(DiamImage,inReso);
%             bw = TS_Diam2ReconstBW_parfor(DiamImage,mean(SEG.ResolutionXYZ));
        end
        function DiamImage = SEG2DiamImage(~,SEG)
            % DiamImage = TS_SEG2DiamImage_v2019b(SEG)
            % TS_SEG2DiamImage_v2019a is gone.... fuck off TeraStation HDD.
            % re-edit by Sugashi, 2019,07,15

            %% check out Segment data
            S = Segment_Functions;
            SEG = S.set_Segment(SEG);
            %%
            Pdata = SEG.Pointdata;
            try
                Size = SEG.Size;
            catch err
                warning(err.message)
                Size = size(SEG.Output);
            end
            try
                DiamImage = zeros(SEG.Size,'like',single(1));
                Size = SEG.Size;
            catch err
                warning(err.message)
                DiamImage = zeros(Size,'like',single(1));
            end

            fprintf(mfilename)
            TS_WaiteProgress(0)
            for n = 1:length(Pdata)
                if Pdata(n).ID <0
                    continue
                end                
                D = Pdata(n).Diameter;
                xyz = round(Pdata(n).PointXYZ);
                Index = sub2ind(Size,xyz(:,2),xyz(:,1),xyz(:,3));
                for k = 1:length(Index)
                    DiamImage(Index(k)) = nanmax(D(k),DiamImage(Index(k)));
                end
                
                TS_WaiteProgress(n/length(Pdata))
            end
        end
        function DiamImage = SEG2DiamImage_class(~,SEG)
            % DiamImage = TS_SEG2DiamImage_v2019b(SEG)
            % TS_SEG2DiamImage_v2019a is gone.... fuck off TeraStation HDD.
            % re-edit by Sugashi, 2019,07,15

            %% check out Segment data
            S = Segment_Functions;
            SEG = S.set_Segment(SEG);
            %%
            Pdata = SEG.Pointdata;
            Size = size(SEG.Output);
            try
                DiamImage = zeros(SEG.Size,'like',single(1));
                Size = SEG.Size;
            catch err
                warning(err.message)
                DiamImage = zeros(Size,'like',single(1));
            end

            fprintf(mfilename)
            TS_WaiteProgress(0)
            for n = 1:length(Pdata)
                if Pdata(n).ID <0
                    continue
                end                
                D = Pdata(n).Diameter;
                cName = Pdata(n).Class;
                switch lower(cName)
%                         case 'art.'
%                             D(:) = 3;
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
%                         case 'vein'
%                             D(:) = -3;
                    otherwise
                        D(:) = -3;
                end
                D = D+4;
                xyz = round(Pdata(n).PointXYZ);
                Index = sub2ind(Size,xyz(:,2),xyz(:,1),xyz(:,3));
                DiamImage(Index) = D;
                TS_WaiteProgress(n/length(Pdata))
            end
        end
                
        %% Make Circle
        function [X,Y,Z] = makeCircle(obj,Radius) %% Center = [0 0 0 ],
            t = linspace(0,2*pi,obj.PolyNum+1);            
            t = [t ,nan];
            Center = [0 0 0];
            X = sin(t) * Radius + Center(1);
            Y = cos(t) * Radius + Center(2);
            Z = zeros(1,length(X)) + Center(3);
            Z(end) = nan;
        end
        function [NormTheta,P] = xyz2NormXY(~,xyz,varargin)
            % [NormTheta,P] = xyz2Norm(obj,xyz)
            % [NormTheta,P] = xyz2Norm(obj,xyz,RefLen)
            if nargin ==2
                RefLen = 1; %% as default
            elseif nargin ==3
                RefLen = varargin{1};
            end
            pnum = 1:size(xyz,1);
            NormTheta = zeros(size(xyz,1),1);
            P = NormTheta;            
            for n = 1:length(NormTheta)
                ind = and(pnum >= n - RefLen, pnum <= n + RefLen);
                x = xyz(ind,1);
                y = xyz(ind,2);
                pasu = mean(diff(y)) / mean(diff(x));
                theta = atan(pasu);
                P(n) = pasu;
                NormTheta(n) = tan(theta + pi/2);
            end
        end
        function uvw = xyz2vectoraverage(~,xyz)
            if size(xyz,1) ==1
                uvw = nan(1,size(xyz,2));
                return
            end
            xyz = double(xyz);
            xyz_pre  = cat(1,xyz(1,:),xyz(1:end-1,:));
            xyz_post = cat(1,xyz(2:end,:),xyz(end,:));
            xyz = cat(3,xyz_pre,xyz,xyz_post);            
            UVW = squeeze(sum(diff(xyz,1,3),3));
            uvw = UVW ./ sqrt(sum(UVW.^2,2));
        end  %% xyz(:,3) ,uvw(:,3),
        function YAW = RotZ(~,rho) %% Axis Z
            YAW = [  cos(rho),  sin(rho), 0.000000, ;
                    -sin(rho),  cos(rho), 0.000000, ;
                     0.000000,  0.000000, 1.000000, ];
        end
        function PIT = RotY(~,yaw) %% Axis Y
            PIT = [ cos(yaw),  0.000000, -sin(yaw), ;
                    0.000000,  1.000000,  0.000000, ;
                    sin(yaw),  0.000000,  cos(yaw), ];
        end
        function RHO = RotX(~,pit) %% Axis X
            RHO = [ 1.000000,  0.000000,  0.000000, ;
                    0.000000,  cos(pit),  sin(pit), ;
                    0.000000, -sin(pit),  cos(pit), ];
        end
        function ThetaPhi = Rectangular2Spherical(obj,xyz,varargin) %% Spherion Angle
            % [Theta,Phi] = rectangular2SphericalCoordinateSystem(xyz,Reso)
            if nargin ==3
                Reso = varargin{1};
                xyz(:,1) = (xyz(:,1)-1) * Reso(2);
                xyz(:,2) = (xyz(:,2)-1) * Reso(1);
                xyz(:,3) = (xyz(:,3)-1) * Reso(3);
            end
            uvw = obj.xyz2vectoraverage(xyz);
            % r = sqrt(sum(uvw.^2,2)); %% all 1.000
            Theta = acos(uvw(:,3)); % -1.0<=w <=1.0 , so must Be Real
            Phi = sign(uvw(:,2)).*acos(uvw(:,1)./sqrt( sum( uvw(:,1:2).^2,2) ) );
            ThetaPhi = cat(2,Theta,Phi);
        end
        function Spherion = xyz2eul(obj,xyz,varargin) %% Euler (Spherion Angle
            % Spherion = rectangular2SphericalCoordinateSystem(xyz,Reso)
            % Spherion = [rotate(axisZ), rotate(axis X), rotate(axis Z)], 
            % T = RotZ*RotX*RotZ
            %
            % uvw = xyz2vectoraverage(xyz,...)
            % eul = ****(uvw)
            if nargin ==3
                Reso = varargin{1};
                xyz(:,1) = (xyz(:,1)-1) * Reso(2);
                xyz(:,2) = (xyz(:,2)-1) * Reso(1);
                xyz(:,3) = (xyz(:,3)-1) * Reso(3);
            end
            uvw = obj.xyz2vectoraverage(xyz);
            Spherion = zeros(size(xyz));
            for k =1:size(uvw,1)
                a = uvw(k,:);
                a = reshape(a,1,[]);
                b = [1; 0; 0]; % RotZ, basement==Axis-X
                A = acos( a*b / ( sqrt( sum(a.^2,2) ) ) );
                a = obj.RotZ(A) * a(:);
                a = reshape(a,1,[]);
                b = [0; 0; 1]; % RotX, basement==Axis-Z
                B = acos( a*b / ( sqrt( sum(a.^2,2) ) ) );
                a = obj.RotX(B) * a(:);
                a = reshape(a,1,[]);
                b = [0; 1; 0]; % RotZ, basement==Axis-Y
                C = acos( a*b / ( sqrt( sum(a.^2,2) ) ) );
                Spherion(k,:) = [A  B  C];
            end            
        end
        function T = Spherical2Tform(obj,Theta,Phi)
            Yaw = obj.RotY(Theta);           
            if isnan(Phi)
                T = Yaw;
            else
                Rho = obj.RotZ(Phi);
%                 T = Rho*Yaw;
                T = Rho*Yaw;
            end
        end %% Tform for affine
        function [X,Y,Z,C] = xyzDiam2reconstruct(obj,xyz,Diam)
            TP = obj.Rectangular2Spherical(xyz);
            Theta = TP(:,1);
            Phi   = TP(:,2); 
%             PatchData(1:size(xyz,1)) = struct('X',[],'Y',[],'Z',[]);
            PatchData(1:size(xyz,1)) = struct('X',[],'Y',[],'Z',[],'C',[]);
            for k = 1:size(xyz,1)
                [x,y,z] = obj.makeCircle(Diam(k)/2);
                T = obj.Spherical2Tform(-Theta(k),-Phi(k));
                XYZ = cat(1,x,y,z);
                newXYZ = T * XYZ;
                PatchData(k).X = newXYZ(1,:) + xyz(k,1);
                PatchData(k).Y = newXYZ(2,:) + xyz(k,2);
                PatchData(k).Z = newXYZ(3,:) + xyz(k,3);
                PatchData(k).C = linspace(0,100,length(x));%repmat(Diam(k),[1,length(x)]);
            end
            X = cat(2,PatchData.X);
            Y = cat(2,PatchData.Y);
            Z = cat(2,PatchData.Z);
            C = cat(2,PatchData.C);
        end
        %% will be delete function
        function [p,txh] = SEGview(obj,axh,SEG,varargin)
            % basic senctence
            % [p,txh] = SEGview(axh,SEG)
            %
            % 1. use for Segment and set up FaceColor meaning.
            % [p,txh] = SEGview(axh,SEG,type)
            %     type : {'same'}, 'Diameter', 'Length', 'AverageDiameter',
            %
            % 2. use for Branch
            % [p,txh] = SEGview(axh,SEG,'Branch')
            warning('this function will be delete!!!')
            if nargin == 4
                Type = varargin{1};
            else
                Type = 'same';
            end
            if ~ishandle(axh)
                figure,axh = axes;
            end
            S = Segment_Functions;
            SEG = S.set_Segment(SEG);
            Reso = SEG.ResolutionXYZ;
            Pdata = SEG.Pointdata;
            %% Type Branch
            if strcmpi(Type,'Branch')
                try 
                    xyz = SEG.BranchPointXYZ;
                catch err
                    warning(err.message)
                    xyz =  SEG.BPmatrix(:,1:3);
                end
                xyz = (xyz - 1).*Reso;
                BranchColor = [0 1 0 ];
                BranchTextColor = [0 0.5 0 ];
                p = plot3(axh,xyz(:,1),xyz(:,2),xyz(:,3),'*');
                p.LineWidth = 2;
                p.MarkerSize = 7;
                p.Color = BranchColor;
                for n = 1:size(xyz,1)
                    txh(n) = text(axh,xyz(n,1),xyz(n,2),xyz(n,3),num2str(n),...
                        'FontWeight','Bold',...
                        'Color',BranchTextColor);
                end
                return
            end
            %% Type same, Diameter, Length, AverageDiameter,..
            for n = 1:length(Pdata)
                if strcmpi(Type,'same')
                    D = ones(size(Pdata(n).PointXYZ,1),1);
                elseif strcmpi(Type,'Diameter')
                    D = Pdata(n).Diameter;
                elseif strcmpi(Type,'Length')
                    D = repmat(Pdata(n).Length,[size(Pdata(n).PointXYZ,1),1]);
                elseif strcmpi(Type,'AverageDiameter')
                    AD = nanmean(Pdata(n).Diameter);
                    D = repmat(AD,[size(Pdata(n).PointXYZ,1),1]);
                else
                    error('Input View-Type is NOT Correct..')
                end
                p(n) = obj.xyzD2patch(axh,Pdata(n).PointXYZ,D,Reso);
                p(n).Marker = 'none';
                p(n).LineWidth = 3;
                xyz = mean(Pdata(n).PointXYZ-1,1).*Reso;
                txh(n) = text(axh,xyz(1),xyz(2),xyz(3),num2str(Pdata(n).ID));
            end
            view(3),
            grid(axh,'on')
            daspect(ones(1,3))
        end
        %% SEGviews
        function [p,varargout] = SEGview_Limit(obj,axh,SEG,varargin)
            % basic senctence
            % [p,txh] = SEGview_Limit(axh,SEG,Type,XLim,YLim,ZLim)
            %
            % 1. use for Segment and set up FaceColor meaning.
            % [p,txh] = SEGview(axh,SEG,type)
            %     type : {'same'},'Type' ,'Diameter', 'Length', 'AverageDiameter',
            %            same is all point has 1 value;
            %            Type is Each type,(End to ~,..) has 0,1,2
            % 2. use for Branch
            % [p,txh] = SEGview(axh,SEG,'Branch')
            %
            % SEGview_Limit ver. has Text (handles) Limit. See This Code.
            % Default is 100(?)
            % 
            % XLim,YLim,ZLim, are real size Limit, size(LIM) = (1,2)
            narginchk(3,8)
            if isempty(axh)
                figure,axh = axes;
            end
            if ~ishandle(axh)
                error('Deleted Axes handels?')
            end
            SEGFun = Segment_Functions;
            SEG = SEGFun.set_Segment(SEG);
            cutID = cat(1,SEG.Pointdata.ID)>0;
            SEG.Pointdata = SEG.Pointdata(cutID);
            [Type,XLim,YLim,ZLim,SEG] = Input_Check(SEG,varargin{:});
            function [Type,XLim,YLim,ZLim,SEG] = Input_Check(SEG,varargin)
                Type = 'same';
                S = Segment_Functions;
                S.Segment = SEG;
                catXYZ = cat(1,SEG.Pointdata.PointXYZ);
                catXYZ = (catXYZ - 1) .* SEG.ResolutionXYZ;
                Mini_XYZ = min(catXYZ,[],1);
                Maxi_XYZ = max(catXYZ,[],1);
%                 FOV = (SEG.Size-1).* SEG.ResolutionXYZ;
                XLim = [Mini_XYZ(1) Maxi_XYZ(1)];
                YLim = [Mini_XYZ(2) Maxi_XYZ(2)];
                ZLim = [Mini_XYZ(3) Maxi_XYZ(3)];
                if nargin >= 2
                    Type = varargin{1};
                end
                if nargin >=3
                    XLim = varargin{2};                    
                    YLim = varargin{3};                    
                    ZLim = varargin{4};
                    if isempty(XLim)
                        XLim = [Mini_XYZ(1) Maxi_XYZ(1)];
                    end
                    if isempty(YLim)
                        YLim = [Mini_XYZ(2) Maxi_XYZ(2)];
                    end
                    if isempty(ZLim)
                        ZLim = [Mini_XYZ(3) Maxi_XYZ(3)];
                    end                    
                end
                if nargin >=6
                    IDs = varargin{5};
                    ID_index = cell2mat(S.ID2Index({IDs}));
                    Pointdata = SEG.Pointdata(ID_index);
                    SEG.Pointdata = Pointdata;
                end
            end
            % TextLimit = obj.SEGview_textLim;
            
            Reso = SEG.ResolutionXYZ;
            Pdata = SEG.Pointdata;
            if and(~ishandle(axh),~isempty(axh))
                error('Please set up an axes.')
            end
            %% Type Branch
%             YLim
            if strcmpi(Type,'Branch')
                try 
                    xyz = SEG.BranchPointXYZ;
                catch err
                    warning(err.message)
                    xyz =  SEG.BPmatrix(:,1:3);
                end
                xyz = (xyz - 1).*Reso;
                Num = 1:size(xyz,1);
                % % % Limit version % % % %
                if ~or(or(isempty(XLim),isempty(YLim)),isempty(ZLim))
                    index_X = and(xyz(:,1)>=XLim(1),xyz(:,1)<=XLim(2));
                    index_Y = and(xyz(:,2)>=YLim(1),xyz(:,2)<=YLim(2));
                    index_Z = and(xyz(:,3)>=ZLim(1),xyz(:,3)<=ZLim(2));
                    index = and(and(index_X,index_Y),index_Z);
                    Num = Num(index);
                    xyz = xyz(index,:);
                end
                % % % % % % % % % % % % % % 
                % % if axes handle is empty. output = xyz;
                if isempty(axh)
                    p = xyz;
                    return
                end              
                
                BranchColor = [0 1 0 ];
                BranchTextColor = [0 0.5 0 ];
               
                p = plot3(axh,xyz(:,1),xyz(:,2),xyz(:,3),'*');
                p.LineWidth = 2;
                p.MarkerSize = 3;
                p.Color = BranchColor;
                view(axh,3),
                grid(axh,'on')
                daspect(axh,ones(1,3))
                axh.YDir = 'reverse';
                return
            end
            %% Type same, Diameter, Length, AverageDiameter,..
            MaximumLen = size(cat(1,Pdata.PointXYZ),1);
            SegNum = length(Pdata);
            Data = inf(MaximumLen+SegNum*5,1);
            XYZ = inf(MaximumLen+SegNum*5,3);
            c = 1;
            indexTF = false(1,length(Pdata));
            fprintf('SEG view (Limit ver.), setting up.. Please waite. \n')
            TS_WaiteProgress(0)
            for n = 1:length(Pdata)                
                xyz = Pdata(n).PointXYZ;
                xyz = (xyz-1).*Reso;
                if ~and(and(isempty(XLim),isempty(YLim)),isempty(ZLim))
                    TFOR_X = and(xyz(:,1)>=XLim(1),xyz(:,1)<=XLim(2));
                    TFOR_Y = and(xyz(:,2)>=YLim(1),xyz(:,2)<=YLim(2));
                    TFOR_Z = and(xyz(:,3)>=ZLim(1),xyz(:,3)<=ZLim(2));
                    TFOR = and(and(TFOR_X,TFOR_Y),TFOR_Z);
                    TF = max(TFOR);
                else
                    TF = true;
                end
%                 if ~TF || (Pdata(n).ID < 0)
%                     TS_WaiteProgress(n/length(Pdata))
%                     continue
%                 else
                    indexTF(n) = true;
%                 end
                if strcmpi(Type,'same')
                    D = ones(size(Pdata(n).PointXYZ,1),1);
                elseif strcmpi(Type,'Type')
                    len = size(Pdata(n).PointXYZ,1);
                    switch Pdata(n).Type
                        case 'End to End'
                            D = zeros(len,1);
                        case 'End to Branch'
                            D = ones(len,1);
                        case 'Branch to Branch'
                            D = ones(len,1) *2;
                        otherwise
                            D = ones(len,1) * 3;
                    end
                elseif strcmpi(Type,'Diameter')
                    D = Pdata(n).Diameter;
                    D(isnan(D)) = -0.000001; %% Add 2019.07.13 for display Skeleton
                elseif strcmpi(Type,'Signal')
                    D = Pdata(n).Signal;
                elseif strcmpi(Type,'Noise')
                    D = Pdata(n).Noise;
                elseif strcmpi(Type,'SNR')
                    D = Pdata(n).Signal ./ Pdata(n).Noise;
                elseif strcmpi(Type,'SNRdb')
                    D = 10 * log10(Pdata(n).Signal ./ Pdata(n).Noise );
                elseif strcmpi(Type,'Length')
                    D = repmat(Pdata(n).Length,[size(Pdata(n).PointXYZ,1),1]);
                elseif strcmpi(Type,'AverageDiameter')
                    AD = nanmean(Pdata(n).Diameter);
                    D = repmat(AD,[size(Pdata(n).PointXYZ,1),1]);
                elseif strcmpi(Type,'class')
                    D = nan([size(Pdata(n).PointXYZ,1),1]);
                    cName = Pdata(n).Class;
                    cName(cName==' ') = [];
                    switch lower(cName)
%                         case 'art.'
%                             D(:) = 3;
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
%                         case 'vein'
%                             D(:) = -3;
                        otherwise
                            D(:) = -3;
                    end
                else
                    try
                        eval(['D = Pdata(n).' Type ';'])                        
                        if isscalar(D)
                            D = repmat(D,[size(Pdata(n).PointXYZ,1),1]);
                        end
                    catch err
                        disp(err.message)
                        error('Input View-Type is NOT Correct..')
                    end
                end
                if isempty(D)
                    D = nan(size(Pdata(n).PointXYZ,1),1);
                end
                

                XYZ(c:c+size(D,1)-1,:) = Pdata(n).PointXYZ;                
                XYZ(c+size(D,1),:) = Pdata(n).PointXYZ(end,:);                
                Data(c:c+size(D,1)-1,:) = D; 
                Data(c+size(D,1),:) = D(end);
                c = c+size(D,1)+1;
                XYZ(c,:) = nan;
                Data(c,:) = nan;
                c = c+ 1;
                
                TS_WaiteProgress(n/length(Pdata))
%                 XYZ = cat(1,XYZ,Pdata(n).PointXYZ,nan(1,3));
%                 Data = cat(1,Data,D,nan);
            end
            XYZ(isinf(Data),:) = [];
            Data(isinf(Data)) = [];
            % % if axes handle is empty. output = xyz;
            if isempty(axh)
                p = xyz;
                varargout{1} = Data;
                return
            end   
            p = obj.xyzD2patch(axh,XYZ,Data,Reso);
            p.Marker = 'none';
            p.LineWidth = 2;
            if SEG.Size(3) > 1
                view(axh,3),
            end
            grid(axh,'on')
            axh.YDir = 'revers';
            daspect(axh,ones(1,3)) 
            if strcmpi(Type,'class')
                ts = tsmaps;
                map = ts.class_map;
                colormap(axh,map)
            end
        end
        
        function txh = SEGview_Limit_text(obj,axh,SEG,varargin)
            % basic senctence
            % [p,txh] = SEGview_Limit(axh,SEG,Type,XLim,YLim,ZLim)
            %
            % 1. use for Segment and set up FaceColor meaning.
            % [p,txh] = SEGview(axh,SEG,type)
            %     type : {'same'}, 'Diameter', 'Length', 'AverageDiameter',
            %
            % 2. use for Branch
            % [p,txh] = SEGview(axh,SEG,'Branch')
            %
            % SEGview_Limit ver. has Text (handles) Limit. See This Code.
            % Default is 100(?)
            % 
            % XLim,YLim,ZLim, are real size Limit, size(LIM) = (1,2)
            txh = [];
            TextLimit = obj.SEGview_textLim;
            SEGFun = Segment_Functions;
            SEG = SEGFun.set_Segment(SEG);
            Reso = SEG.ResolutionXYZ;
            Pdata = SEG.Pointdata;
            if ~ishandle(axh)
                error('Please set up an axes.')
            end
%             catXYZ = cat(1,SEG.Pointdata.PointXYZ);
             [Type,XLim,YLim,ZLim,SEG] = Input_Check(SEG,varargin{:});
             
            function [Type,XLim,YLim,ZLim,SEG] = Input_Check(SEG,varargin)
                Type = 'same';
                S = Segment_Functions;
                S.Segment = SEG;
                catXYZ = cat(1,SEG.Pointdata.PointXYZ);
                catXYZ = (catXYZ - 1) .* SEG.ResolutionXYZ;
                Mini_XYZ = min(catXYZ,[],1);
                Maxi_XYZ = max(catXYZ,[],1);
%                 FOV = (SEG.Size-1).* SEG.ResolutionXYZ;
                XLim = [Mini_XYZ(1) Maxi_XYZ(1)];
                YLim = [Mini_XYZ(2) Maxi_XYZ(2)];
                ZLim = [Mini_XYZ(3) Maxi_XYZ(3)];
                if nargin >= 2
                    Type = varargin{1};
                end
                if nargin >=3
                    XLim = varargin{2};                    
                    YLim = varargin{3};                    
                    ZLim = varargin{4};
                    if isempty(XLim)
                        XLim = [Mini_XYZ(1) Maxi_XYZ(1)];
                    end
                    if isempty(YLim)
                        YLim = [Mini_XYZ(2) Maxi_XYZ(2)];
                    end
                    if isempty(ZLim)
                        ZLim = [Mini_XYZ(3) Maxi_XYZ(3)];
                    end                    
                end
                if nargin >=6
                    IDs = varargin{5};
                    ID_index = cell2mat(S.ID2Index({IDs}));
                    Pointdata = SEG.Pointdata(ID_index);
                    SEG.Pointdata = Pointdata;
                end
            end
            %
            %% Type Branch
            if strcmpi(Type,'Branch')
                try 
                    xyz = SEG.BranchPointXYZ;
                catch err
                    warning(err.message)
                    xyz =  SEG.BPmatrix(:,1:3);
                end
                xyz = (xyz - 1).*Reso;
                Num = 1:size(xyz,1);
                if ~and(and(isempty(XLim),isempty(YLim)),isempty(ZLim))
                    % % % Limit version % % % %                    
                    index_X = and(xyz(:,1)>=XLim(1),xyz(:,1)<=XLim(2));
                    index_Y = and(xyz(:,2)>=YLim(1),xyz(:,2)<=YLim(2));
                    index_Z = and(xyz(:,3)>=ZLim(1),xyz(:,3)<=ZLim(2));
                    index = and(and(index_X,index_Y),index_Z);
                    Num = Num(index);
                    xyz = xyz(index,:);
                    % % % % % % % % % % % % % %                 
                end
                if size(xyz,1) > TextLimit
                    txh = [];
                    return
                end
                BranchTextColor = [0 0.7 0];
                for n = 1:size(xyz,1)
                    txh(n) = text(axh,xyz(n,1),xyz(n,2),xyz(n,3),num2str(Num(n)),...
                        'FontWeight','Bold',...
                        'Color',BranchTextColor);
                end
                return
            end
            %% Type same, Diameter, Length, AverageDiameter,..
            if ~and(and(isempty(XLim),isempty(YLim)),isempty(ZLim))              
                indexTF = false(1,length(Pdata));
                fprintf('SEG view (Limit ver.), setting up.. Please waite. \n')
                TS_WaiteProgress(0)
                for n = 1:length(Pdata)                    
                    TS_WaiteProgress(n/length(Pdata))
                    xyz = Pdata(n).PointXYZ;
                    xyz = (xyz-1).*Reso;
                    TFOR_X = and(xyz(:,1)>=XLim(1),xyz(:,1)<=XLim(2));
                    TFOR_Y = and(xyz(:,2)>=YLim(1),xyz(:,2)<=YLim(2));
                    TFOR_Z = and(xyz(:,3)>=ZLim(1),xyz(:,3)<=ZLim(2));
                    TFOR = and(and(TFOR_X,TFOR_Y),TFOR_Z);
                    TF = max(TFOR);
                    if ~TF || (Pdata(n).ID < 0)
                        continue
                    else
                        indexTF(n) = true;
                    end                    
                end
                Pdata = Pdata(indexTF);
            end
            if length(Pdata) > TextLimit                
                return
            end            
            for n = 1:length(Pdata)
                xyz = mean(Pdata(n).PointXYZ-1,1).*Reso;
                txh(n) = text(axh,xyz(1),xyz(2),xyz(3),num2str(Pdata(n).ID));
                %%%%%%Font Color Limit for End to Branch %%%%
                if strcmpi((Pdata(n).Type),'End to Branch')
                    try
                        txh(n).Color = [0.8 0 0];
                    catch
                        set(txh(n),'Color',[0.8 0 0])
                    end
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end
        end
        
        function p = xyzD2patch(obj,axh,xyz,Diameter,varargin)
            % p = xyzD2patch(axh,xyz,Diameter)
            % p = xyzD2patch(axh,xyz,Diameter,ResolutionXYZ)
            if nargin==5
                Reso = varargin{1};
                xyz = (xyz-1) .*Reso;
            end
            xyz = cat(1,xyz,nan(1,3));
            Diameter = cat(1,Diameter,nan);
            p = patch(axh,xyz(:,1),xyz(:,2),xyz(:,3),Diameter,...
                'EdgeColor','interp','Marker','o','MarkerFaceColor','flat');
        end
        
        function p = xyz2plot(obj,axh,xyz,Reso)
            xyz = (xyz-1).*Reso;
            p = plot3(axh,xyz(:,1),xyz(:,2),xyz(:,3));            
        end
        
        
        function p = SEGview_old(obj,axh,SEG)
            Pdata = SEG.Pointdata;
            Reso = SEG.ResolutionXYZ;
            c = 1;
            for n = 1:length(Pdata)
                if Pdata(n).ID < 0
                    continue
                end
                xyz = Pdata(n).PointXYZ;
                xyz = (xyz-1).*Reso;
                hold(axh,'on')
                p(c) = plot3(axh,xyz(:,1),xyz(:,2),xyz(:,3),...
                    'Marker','none',...
                    'LineStyle','-',...
                    'LineWidth',2);
            end
        end
        %% tube plot
        function [x,y,z,CData] = Tubeplot(~,curve,r,n,ct,varargin)
        % Usage: [x,y,z,CData]=Tubeplot(curve,r,n,ct)
        % 
        % Tubeplot constructs a tube, or warped cylinder, along
        % any 3D curve, much like the build in cylinder function.
        % If no output are requested, the tube is plotted.
        % Otherwise, you can plot by using surf(x,y,z);
        %
        % Example of use:
        % t=linspace(0,2*pi,50);
        % [x,y,z] = obj.Tubeplot([cos(t);sin(t);0.2*(t-pi).^2],rand(50,1)*0.1+0.1);
        % figure,surf(x,y,z)
        % daspect([1,1,1]); camlight;
        %
        % Arguments:
        % curve: [N,3] vector of curve data
        % r      the radius of the tube
        % n      number of points to use on circumference. Defaults to 8
        % ct     threshold for collapsing points. Defaults to r/2 
        %
        % The algorithms fails if you have bends beyond 90 degrees.
        % Janus H. Wesenberg, july 2004
        %
        % Add Each Radius , Sugashi, 21st, Oct. 2019

            curve = curve';
            if length(r) ~=size(curve,2)
                error('Input radius is not same length input curve')
            end
            if nargin<4 || isempty(n) 
                n=8;
                if nargin<3 
                    error('Give at least curve and radius');
                end
            end
            if size(curve,1)~=3
                error('Malformed curve: should be [3,N]');
            end
            if nargin<5 || isempty(ct)
                ct=0.5*r;
            end
            if nargin == 6
                CData = varargin{1};
            else
                CData = r *2;
            end


            %Collapse points within 0.5 r of each other
            npoints=1;
            for k=2:(size(curve,2)-1)
                if norm(curve(:,k)-curve(:,npoints))>ct(k-1) %% Sugashi chnage
                    npoints=npoints+1;
                    curve(:,npoints)=curve(:,k);
                end
            end
            %Always include endpoint
            if norm(curve(:,end)-curve(:,npoints))>0
                npoints=npoints+1;
                curve(:,npoints)=curve(:,end);
            end

            %deltavecs: average for internal points.
            %           first strecth for endpoitns.
            dv=curve(:,[2:end,end])-curve(:,[1,1:end-1]);

            %make nvec not parallel to dv(:,1)
            nvec=zeros(3,1);
            [buf,idx]=min(abs(dv(:,1)));
            nvec(idx)=1;

            xyz=zeros([4,n+1,npoints+2]);

            %precalculate cos and sing factors:
            cfact=repmat(cos(linspace(0,2*pi,n+1)),[3,1]);
            sfact=repmat(sin(linspace(0,2*pi,n+1)),[3,1]);

            %% Main loop: propagate the normal (nvec) along the tube
            for k=1:npoints
                convec=cross(nvec,dv(:,k));
                convec=convec./norm(convec);
                nvec=cross(dv(:,k),convec);
                nvec=nvec./norm(nvec);
                %update xyz:
                xyz(1:3,:,k+1)=repmat(curve(:,k),[1,n+1])+...
                    cfact.*repmat(r(k)*nvec,[1,n+1])...
                    +sfact.*repmat(r(k)*convec,[1,n+1]);
%                 xyz(4,:,k+1) = r(k) * 2; %% radius to diameter
                xyz(4,:,k+1) = CData(k); %% CData change
            end
            %finally, cap the ends:
            xyz(1:3,:,1)=repmat(curve(:,1),[1,n+1]);
            xyz(4,:,1)=r(1)*2;
            xyz(1:3,:,end)=repmat(curve(:,end),[1,n+1]);
            xyz(4,:,end)=r(end)*2;
            %,extract results:
            x=squeeze(xyz(1,:,:));
            y=squeeze(xyz(2,:,:));
            z=squeeze(xyz(3,:,:));     
            CData=squeeze(xyz(4,:,:));     
        end
        function [FV,p] = SEGdiam2TubePatch(obj,SEG,varargin)
            if nargin==2
                Fname = 'Diameter';
            else
                Fname = varargin{1};
            end
            Pdata = SEG.Pointdata;
            X = [];
            Y = [];
            Z = [];
            CD = [];
            CircNum = obj.CircumferenceNum;
            SegReso = SEG.ResolutionXYZ;            
            for n = 1:length(Pdata)
                TS_WaiteProgress((n-1)/length(Pdata))
                ID = Pdata(n).ID;
                if ID < 0 
                    continue
                end
                xyz = Pdata(n).PointXYZ;
                xyz = (xyz-1).*SegReso;
                D = Pdata(n).Diameter;
                D(isnan(D)) = 0;
                R = D /2;
                % % core function
                if ~strcmpi(Fname,'Diameter')
                    cdata = Pdata(n).(Fname);
                    if isscalar(cdata)
                        cdata = repmat(cdata,size(xyz,1));
                    elseif size(cdata,2)>1
                        cdata = cdata(:,1);
                    end
                else
                    cdata = D;
                end
                [x,y,z,C] = obj.Tubeplot(xyz,R,CircNum,[],cdata);
                X = cat(2,X,nan(size(x,1),1),x);
                Y = cat(2,Y,nan(size(y,1),1),y);
                Z = cat(2,Z,nan(size(z,1),1),z);
                CD = cat(2,CD,nan(size(C,1),1),C);                
            end
            FV = surf2patch(X,Y,Z,CD,'triangles');
            TS_WaiteProgress(1)
        end
        function fvx = create_patchfields(~)
            fvx.faces = [];
            fvx.vertices = [];
            fvx.facevertexcdata = [];
        end
        function p = Reconstruct_TubeSEG(obj,axh,SEG,varargin)
            %%
            %% having bag on SEGdim2Tube
            %%
            if nargin==3
                Fname = 'Diameter';
            else
                Fname = varargin{1};
            end
            
            
            fv = obj.SEGdiam2TubePatch(SEG,Fname);
            if isempty(axh)
                figure,
                axh = axes;
            end
            p = patch(axh,fv);
            p.FaceColor = 'interp';
            p.EdgeColor = 'none';
            daspect(axh,ones(1,3))
            view(axh,3)
        end
        
        %% interpolation/ Crop       
        
        function Index = createLineMaskIndex3D(~,outSiz,p1,p2)
            % Index = createLineMask3D(outSiz,p1,p2)
            % Input : 
            %    outSiz  : output size (= size(Image), such as [Y,X,Z]).
            %    p1,p2   : [X,Y,Z] , vecotor
            % Output:
            %    Index   : Index of true; = sub2ind(~)
                
            p1 = round(p1);
            p2 = round(p2);
            Numel = max(diff(cat(1,p1,p2),1,1));
            xdata = round(linspace(p1(1),p2(1),Numel));
            ydata = round(linspace(p1(2),p2(2),Numel));
            zdata = round(linspace(p1(3),p2(3),Numel));
            Index = sub2ind(outSiz,ydata,xdata,zdata);
        end
        
        function [outImage,pLen] = Interp_Pointdata_withNormTheta(obj,...
                Image,Reso,SEG,ID,varargin)
            if ismatrix(Image)
                Reso(3) = 0;
                Image = single(Image);
            end
            
            Sf = Segment_Functions;
            Sf.Segment = SEG;
            Pdata = Sf.Pointdata_ID(ID);
            
            if nargin ==5
                Len = max(Pdata.Diameter);
            else
                Len = varargin{1};
            end
            try
                 NormTheta = Pdata.NormThetaXY;
            catch 
                SEG.Pointdata = Pdata;
                SEG = Sf.AddNormThetaXY(SEG);
                NormTheta = SEG.Pointdata(1).NormThetaXY;
            end
            xyz_real = (Pdata.PointXYZ-1) .*SEG.ResolutionXYZ;
            xyz = (xyz_real./Reso)+1;
            n = 1;
            
            [xq,yq] = obj.GetLinePro2mesh(xyz(n,[1 2]),Len,Reso,NormTheta(n));
            outImage = zeros(length(xq),size(xyz,1));
            Xq = outImage;
            Yq = outImage;
            Zq = outImage;
            Xq(:,1) = xq;
            Yq(:,1) = yq;
            Zq(:,1) = xyz(n,3);
            for n = 2:size(xyz,1)
                [xq,yq] = obj.GetLinePro2mesh(xyz(n,[1 2]),Len,Reso,NormTheta(n));
                Xq(:,n) = xq;
                Yq(:,n) = yq;
                Zq(:,n) = xyz(n,3);
            end
            keyboard
            if ismatrix(Image)
                outImage = interp2(Image,Xq,Yq);
            else
                outImage = interp3(single(Image),Xq,Yq,Zq);
            end
            plen = Sf.xyz2plen(Pdata.PointXYZ,SEG.ResolutionXYZ);
            pLen = cumsum(plen);
        end
        
        function [Xp,Yp,theta] = GetLinePro2mesh(obj,Center,Length,Reso,varargin)
            % 
            % [Xp,Yp,theta] = GetLinePro2mesh(Center,Length,Reso,varargin)%
            %% Original , Edit 11th jun. 2019            % 
            %               TS_GetLineProfileTheta_v2...
            % Center = [X Y]
            % Length =  um / unit
            % Reso = [xy]; %% Resolution(XY), Scalar
            % varargin{1} = theta
            % 
            % edit varargin input type to theta, 
            % 2019 11 13
            
            %% check input
            if nargin == 5
                theta = varargin{1};
            else    
                Step_rotation = pi/(180);
                Max_rotation = pi - Step_rotation;
                theta = 0:Step_rotation:Max_rotation;
            end
            if length(Reso)>1
                if Reso(1) ~=Reso(2)
                    error('Input Resolution of X and Y is NOT Equal....')
                end
                Reso = Reso(1);
            end


            %% initilize
            Length = round(Length / Reso); %% um --> pixels
%             Type_interp = 'linear';

            %% Main Function
            % theta = flip(0:Step_rotation:Max_rotation,2);

            n = 1;
            [xp,yp] = obj.GetIndex(Center,theta(n),Length);
%             vp = interp2(double(im),xp,yp,Type_interp);
            % vpmatrix = zeros(length(vp),length(theta));
            Xp = zeros(length(xp),length(theta));
              Xp(:,n) = xp;
            Yp = zeros(length(xp),length(theta));
              Yp(:,n) = yp;

            % vpmatrix(:,n) = vp;

            for n = 2:length(theta)
                [xp,yp] = obj.GetIndex(Center,theta(n),Length);
                Xp(:,n) = xp;
                Yp(:,n) = yp;
            end
            % vpmatrix = interp2(double(im),Xp,Yp,Type_interp);


        end

        % % GetIndex
        function [xp,yp] = GetIndex(~,Center,theta,Length) 
            % % use in GetLinePro2mesh
            fx1 = @(x,theta,Length) cos(pi+theta)*Length/2+x;
            fx2 = @(x,theta,Length) cos(theta)*Length/2+x;
            fy1 = @(x,theta,Length) sin(pi+theta)*Length/2+x;
            fy2 = @(x,theta,Length) sin(theta)*Length/2+x;

            x1 = fx1(Center(1),theta,Length);
            x2 = fx2(Center(1),theta,Length);
            y1 = fy1(Center(2),theta,Length);
            y2 = fy2(Center(2),theta,Length);

            RadNum =  ceil(Length/2);
            pnum = RadNum * 2 + 1;

            if (x2-x1) == 0
            %     xp = ones(1,Length+1) * x1;
                xp = ones(1,pnum) * x1;
            else
            %     xp = x1:(x2-x1)/Length:x2;
                %     xp = x1:(x2-x1)/Length:x2;
                xp1 = flip(linspace(Center(1),x1,RadNum+1) ,2);
                xp2 = linspace(Center(1)+abs(diff(xp1(1:2))),x2,RadNum) ;
                xp = cat(2,xp1,xp2);
            end

            if (y2-y1) == 0
            %     yp = ones(1,Length+1) * y1;
                yp = ones(1,pnum) * y1;
            else
            %     yp = y1:(y2-y1)/Length:y2;
                yp1 = flip(linspace(Center(2),y1,RadNum+1) ,2);
                yp2 = linspace(Center(2)+abs(diff(yp1(1:2))),y2,RadNum) ;
                yp = cat(2,yp1,yp2);
            end
        end

        % % Patch sub-function
        function fv = BWVoxels2patchdata(~,bw)
            % fv = self.Voxels2patchdata(bw)
            %
            % Example
            % a = false(3,3,3);
            % a([1 5 14 24 23 27]) = 1;
            % fv = self.BWVoxels2patchdata(a);
            % figure,
            % ph = patch(fv);
            % ph.FaceAlpha = 0;
            % ph.LineWidth =2;
            % xlim([0.5 3.5])
            % ylim([0.5 3.5])
            % zlim([0.5 3.5])
            % view(3),daspect(ones(1,3))
            %
            % ph.FaceAlpha =1;
            % ph.FaceColor = ones(1,3)*.5;
            % cmh = camlight;
            
            if ~islogical(bw)
                error('input bw must be logical data')
            end
            
            [y,x,z] = ind2sub(size(bw,[1 2 3]),find(bw(:)));
            vertices = zeros(8*length(y),3);
            faces = zeros(6*length(y),4);
            for n = 1:length(y)
                [v,f] = bw2fv(x(n),y(n),z(n));
                vertices((n-1)*8+1:n*8,:) = v;
                faces((n-1)*6+1:n*6,:) = f+(n-1)*8;
            end
            fv = struct('vertices',vertices,'faces',faces);
            function [ver,face] = bw2fv(x,y,z)
                ver = [x-0.5, y-0.5, z-0.5;
                    x-0.5, y-0.5, z+0.5;
                    x-0.5, y+0.5, z-0.5;
                    x-0.5, y+0.5, z+0.5;
                    x+0.5, y+0.5, z-0.5;
                    x+0.5, y+0.5, z+0.5;
                    x+0.5, y-0.5, z-0.5;
                    x+0.5, y-0.5, z+0.5];
                face = [1 2 4 3;
                    3 4 6 5;
                    5 6 8 7;
                    7 8 2 1;
                    1 3 5 7;
                    2 4 6 8];
            end
        end
        function [ph,cmh] = BWVoxels2patchFigure(obj,bw)
            %[ph,cmh] = self.BWVoxels2patchFigure(bw)
            %see also, self BWVoxels2patchdata
            
            fv = obj.BWVoxels2patchdata(bw);
            figure,
            ph = patch(fv);
            ph.FaceAlpha = 1;
            ph.FaceColor = [.7 .7 .7];
            ph.LineWidth =2;
            ph.Parent.YDir = 'reverse';
            axis off
            cmh = camlight;
            cmh.Position(2) = 25;
            xlim([0.5 size(bw,2)+0.5])
            ylim([0.5 size(bw,1)+0.5])
            zlim([0.5 size(bw,3)+0.5])
            view(3),
            daspect(ones(1,3))
        end
        
        
        %% for check program
        
        function Mov = CheckNormLine(obj,SEG)
            Sf = Segment_Functions;
            p = obj.SEGview_Limit([],SEG,'Fai_AngleFromAxisZ');
            p.EdgeColor = 'interp';
            p.Marker = 'o';
            p.LineWidth = 2;
            p.MarkerSize = 2;
            
            
            axh = p.Parent;
            axh.Position(1) = 0.05;
            axh.Color = ones(1,3)*0.9;
            axh.Parent.Color = ones(1,3)*0.975;
%                 axh.YDir = 'normal';
            axis(axh,'tight');
            Xlim = axh.XLim;
            Ylim = axh.YLim;
            Zlim = axh.ZLim;
            
            cmh = colorbar;
            cmh.Position = [.85 .3 .03 .4];
            cmh.Label.String = 'Angle to Axis Z [radian]';
            cmh.Ticks = [0 pi/4 pi/2];
            cmh.TickLabels = {'0','\pi/4','\pi/2'};
            cmh.Limits = [0 pi/2];
            
            hold(axh,'on')
            Pdata = SEG.Pointdata;
            XX =[];
            YY = [];
            ZZ = [];
            Mov = getframe(axh.Parent);
            fgh = axh.Parent;
            c = 2;
            for n = 1:length(Pdata)
                xyz = Pdata(n).PointXYZ;
                X = nan(3,size(xyz,1));
                Y = X;
                Z = X;
                xyz = (xyz -1).* SEG.ResolutionXYZ;
                Norm = Pdata(n).NormThetaXY;
                for k = 1:size(xyz,1)
                    
                    [x,y] = Sf.GetThetaIndex(xyz(k,:),Norm(k),10);
                    X(1,k) = x(1);
                    X(2,k) = x(end);
                    Y(1,k) = y(1);
                    Y(2,k) = y(end);
                    Z(1:2,k) = xyz(k,3);
                    ph = plot3(axh,X(:),Y(:),Z(:),'-r',...
                        'LineWidth',1);
                    axh.YLim = xyz(k,2) + [-30 30];
                    axh.XLim = xyz(k,1) + [-30 30];
                    axh.ZLim = xyz(k,3) + [-50 50];
                    view(axh,2)
                    drawnow
                    if n<10
                        Mov(c) = getframe(fgh);
                        c =c + 1;
                    elseif n>=10 && n<12
                        if ceil(k/4)==floor(k/4)
                            Mov(c) = getframe(fgh);
                            c =c + 1;
                        end
                    elseif n>=12
                        if ceil(k/12)==floor(k/12)
                            Mov(c) = getframe(fgh);
                            c =c + 1;
                        end
                    end
                    disp(num2str(Norm(k)*180/pi,'%.0f'))
                    if k < size(xyz,1)
                        delete(ph)
                    else
                        pause(.2)
                    end
                end
                delete(ph)
                XX = cat(1,XX,X(:));
                YY = cat(1,YY,Y(:));
                ZZ = cat(1,ZZ,Z(:));
                ph = plot3(axh,X(:),Y(:),Z(:),'-k',...
                        'LineWidth',1);
                drawnow
                
            end
            ZoomX = interp2(cat(1,axh.XLim,Xlim),[1 2],linspace(1,2,24*3)');                
            ZoomY = interp2(cat(1,axh.YLim,Ylim),[1 2],linspace(1,2,24*3)');
            ZoomZ = interp2(cat(1,axh.ZLim,Zlim),[1 2],linspace(1,2,24*3)');
            [a,b] = view(axh);
            ae = linspace(a,-50,24*3);
            az = linspace(b,30,24*3);
            for n = 1:length(az)
                axh.YLim =ZoomY(n,:);
                axh.XLim =ZoomX(n,:);
                axh.ZLim =ZoomZ(n,:);
                view(axh,[ae(n),az(n)]);
                drawnow
                Mov(c) = getframe(fgh);
                c = c+ 1;
            end
            
            
        end
        
        function Mov = Check_Chase_data(obj,SEG,chase_data)
            fgh = figure;
            fgh.Position = [0 0 640 480];
            centerfig(fgh)
            axh = axes;
            p0 = obj.SEGview_Limit(axh,SEG,'same');
            p0.EdgeAlpha = 0.3;
            p0.EdgeColor = [0.4 0.2 0.8];
            
            hold(axh,'on')
            drawnow
            c = 1;
            Mov(c) = getframe(fgh);c =c+1;
            
            Sf = Segment_Functions;
            Sf.Segment = SEG;
            Reso = SEG.ResolutionXYZ;
            %% input point data flash
            xyz = (chase_data.Input_XYZ-1).*Reso;
            p1 = plot3(xyz(1),xyz(2),xyz(3));
            p1.Marker = 'o';
            p1.MarkerSize = 8; 
            p1.LineWidth = 3.3; 
            p1.Color = [.8 .2 0];
            title('Start Point')
            drawnow
            Mov(c) = getframe(fgh);c =c+1;
            
            %% Start ID flash
            index = Sf.ID2Index(chase_data.StartID);
            Pdata = Sf.Segment.Pointdata;
            SEG.Pointdata = Pdata(index);
            p2 = obj.SEGview_Limit(axh,SEG,'same');
            p2.LineWidth = 3.3; 
            p2.EdgeColor = [.5 .2 0];
            title('Start ID ')
            drawnow
            Mov(c) = getframe(fgh);c =c+1;
            delete(p2),drawnow
            
            %% Chase
            for k = 1:length(chase_data.Chase)
                index = Sf.ID2Index(chase_data.Chase(k).IDs);
                Pdata = Sf.Segment.Pointdata;
                SEG.Pointdata = Pdata(index);
                p2 = obj.SEGview_Limit(axh,SEG,'same');
                p2.LineWidth = 3.3; 
                p2.EdgeColor = [.5 .2 0];
                title(['Chase (#).IDs : ' num2str(k)])
                drawnow
                Mov(c) = getframe(fgh);c =c+1;
                delete(p2),drawnow
            end
        end
        
    
        
    end
end
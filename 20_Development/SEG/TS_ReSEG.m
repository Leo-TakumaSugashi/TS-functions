function NewSEG = TS_ReSEG(SEG,varargin)
% function NewSEG = TS_ReSEG(SEG,varargin)
% 
% SEG : have to throgh out Sugashi_Segment class, or same structure
%     like this, 
%     Handle = Sugashi_Segment; 
%     Handle.Segment = SEG;
%     NewSEG = TS_ReSEG(Handle.Segment,...)
%     
% This Function is working for below Segment Editor
% 1. Connect
%     NewSEG = TS_ReSEG(SEG,'connect',Pairs)
%         Pairs(:,1) , must Be Cell,
%         example,
%         Pairs = {[1, 4, 5, 142];[8, 10]; [90 6]}
%     NewSEG = TS_ReSEG(SEG,'connect',Pairs,Force_Connection)
%         Force_Connection,{'--force', '-f',or else}
%         -f, --force, If you will connect in force,
%         else(default), If connection can't throgh in same point(branch),
%                        it will be error.
% 2. Separate
%     NewSEG = TS_ReSEG(SEG,'Separate',SegID,Index)
%         SegID(1,1), must Be numeric, Segment ID,
%             It mean... SEG.Pointdata.ID
%         Index(1,1),  must Be numeric, Index Number,
%             It mean ....SEG.Pointdata(SegNum).PointInd(Index,:)
% 
% Edit by Sugashi,'18-Feb-2019'
%   Add Force Connection type,( Error in Connection), 21-Feb-2019
narginchk(3,5)
warning('This FUnction will be gone. Use Segment_Function.')
Type = varargin{1};

NewSEG = SEG;
if strcmpi(Type,'connect')
    Pairs = varargin{2};
    if nargin ==4 
        if max(strcmpi(varargin{3},{'--force', '-f'}))
            ForceType = true;
        else
            ForceType = false;
        end
    else
        ForceType = false;
    end
    check_Pairs(Pairs)
    Pairs = ID2Index(Pairs,cat(1,SEG.Pointdata.ID));
    NewPdata = SEG.Pointdata;
    for k = 1:length(Pairs)
        Index = Pairs{k};
        NewPdata(end+1) = Connect_Pointdata(SEG,Index,ForceType);
        for n = 1:length(Index)
            NewPdata(Index(n)).ID = ...
                abs(NewPdata(Index(n)).ID) * (-1);                
        end
    end
    NewSEG.Pointdata = NewPdata;
elseif strcmpi(Type,'separate')
    SegID = varargin{2};
    catID = cat(1,SEG.Pointdata.ID);
    SegNum = find(catID == SegID);
    Index = varargin{3};    
    if ~isscalar(SegNum)
        error('Input Segment Number(=SegNum) is NOT Scalar')
    end
    if ~isscalar(Index)
        error('Input Index Number in SegNum(=Index) is NOT vector')
    end
    ParentPdata = SEG.Pointdata(SegNum);    
    if max(Index==1) || max(Index ==size(ParentPdata.PointXYZ,1))
        error('Input Index Number has 1 or end.')
    end
    if max(diff(sort(Index)) == 0)
        error('Input Index has same point.');
    end
    % % Main
    NewPdata = SEG.Pointdata;
    NewPdata(SegNum).ID = abs(NewPdata(SegNum).ID) * (-1);
    NewBranch = cat(1,ParentPdata.PointXYZ(Index,:),ParentPdata.Branch);
    NewBranch(isnan(NewBranch(:,1)),:) = [];
    Index = [1 ; sort(Index(:)) ; size(ParentPdata.PointXYZ,1)];
    EndID = max(cat(1,SEG.Pointdata.ID));
    for n = 1:length(Index)-1
        cutIndex = Index(n):Index(n+1);
        xyz = ParentPdata.PointXYZ(cutIndex,:);
        NewPdata(end +1).PointXYZ = xyz;
        Branch   = CheckBranch(xyz,NewBranch,SEG.ResolutionXYZ);
        NewPdata(end).Branch = Branch;
        NewPdata(end).Signal   = ParentPdata.Signal(cutIndex);
        NewPdata(end).Noise    = ParentPdata.Noise(cutIndex);
        NewPdata(end).Diameter = ParentPdata.Diameter(cutIndex);
        NewPdata(end).NewXYZ   = ParentPdata.NewXYZ(cutIndex,:);
        if size(Branch,1) >=2
            SegmentType = 'Branch to Branch';
        elseif size(Branch,1) ==1 && ~max(isnan(Branch))
            SegmentType = 'End to Branch';
        else
            SegmentType = 'End to End';
        end
        NewPdata(end).Type     = SegmentType;
        NewPdata(end).Length   = sum(xyz2plen(xyz,SEG.ResolutionXYZ));
        NewPdata(end).ID       = EndID+n;
        NewPdata(end).Class    = ParentPdata.Class;
        NewPdata(end).MEMO     = [' Separated from ID :' num2str(SegID) ];  
    end
    NewSEG.Pointdata = NewPdata;
else
    error('Input Type is not correct.Type={''connect'',''separate''}')
end
end

    function check_Pairs(Pairs)
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
    function Index = ID2Index(Pairs,catID)         
         Index = Pairs;
         for x = 1:length(Pairs)
             ID = Pairs{x};
             for k = 1:length(ID)
                 ID(k) = find(ID(k) == catID);
             end
             Index{x} = ID;
         end
    
    end
    function NewPdata = Connect_Pointdata(SEG,Ind,ForceConnecting)
        Pdata = SEG.Pointdata(Ind);
        [Startindex,SegmentType] = Find_EndSEG(Pdata);
        NewPdata = SEG.Pointdata(Startindex);        
        sort_table = true(1,length(Ind));
        sort_table(Startindex) = false;
        xyz = Pdata(Startindex).PointXYZ;
        Branch = Pdata(Startindex).Branch;
        Signal = Pdata(Startindex).Signal;
        Noise = Pdata(Startindex).Noise;
        Diameter = Pdata(Startindex).Diameter;
        NewXYZ = Pdata(Startindex).NewXYZ;
        BeforeIndex = Startindex;
        for n = 1:length(Ind)-1
            [NearIndex,TF_flip_Parent,TF_flip_Foward,ErrorString] ...
            = FindNearestID(xyz,Pdata,sort_table,SEG.ResolutionXYZ);
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
            xyz_Add = NextPdata.PointXYZ;
            Branch_Add = NextPdata.Branch;
            Signal_Add = NextPdata.Signal;
            Noise_Add = NextPdata.Noise;
            Diameter_Add = NextPdata.Diameter;
            NewXYZ_Add = NextPdata.NewXYZ;            
            if TF_flip_Parent
                xyz = flip(xyz,1);
                Branch = flip(Branch,1);
                Signal = flip(Signal,1);
                Noise = flip(Noise,1);
                Diameter = flip(Diameter,1);
                NewXYZ = flip(NewXYZ,1);
            end
            if TF_flip_Foward
                xyz_Add = flip(xyz_Add,1);
                Branch_Add = flip(Branch_Add,1);
                Signal_Add = flip(Signal_Add,1);
                Noise_Add = flip(Noise_Add,1);
                Diameter_Add = flip(Diameter_Add,1);
                NewXYZ_Add = flip(NewXYZ_Add,1);
            end
            xyz = cat(1,xyz,xyz_Add);
            Branch = cat(1,Branch,Branch_Add);
            Signal = cat(1,Signal,Signal_Add);
            Noise = cat(1,Noise,Noise_Add);
            Diameter = cat(1,Diameter,Diameter_Add);
            NewXYZ = cat(1,NewXYZ,NewXYZ_Add);
        end
        %% check same point
        Plen = xyz2plen(xyz,SEG.ResolutionXYZ);
        Plen(1) = inf;
        Delete_Ind = Plen ==0;
        xyz(Delete_Ind,:) = [];        
        Signal(Delete_Ind) = [];
        Noise(Delete_Ind) = [];
        Diameter(Delete_Ind) = [];
        NewXYZ(Delete_Ind,:) = [];
        
        NewPdata.PointXYZ = xyz;
        NewPdata.Branch   = Branch;
        NewPdata.Signal   = Signal;
        NewPdata.Noise    = Noise;
        NewPdata.Diameter = Diameter;
        NewPdata.NewXYZ   = NewXYZ;
        NewPdata.Type     = SegmentType;
        NewPdata.Length   = sum(xyz2plen(xyz,SEG.ResolutionXYZ));
        NewPdata.ID       = max(cat(1,SEG.Pointdata.ID))+1;
        NewPdata.Class    = 'Parent';
        NewPdata.MEMO     = ['Paired:' num2str(Ind)];        
    end
    function [index,Type] = Find_EndSEG(Pdata)
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
   
    function [Index,TF_flip_Parent,TF_flip_Foward,Err] ...
            = FindNearestID(xyz1,Pdata,sort_index,Reso)
        p = find(sort_index);
        xyz2 = zeros(length(p)*2,3);
        for n  = 1:length(p)
            D = Pdata(p(n));
            xyz2((n*2-1):n*2,:) = D.PointXYZ([1, end],:);
        end
        if size(xyz1,1) > 2
            xyz1 = xyz1([1 end],1);
        elseif size(xyz1,1) <=1
            warning('Input Segment has NOT less than 2 point...')
        end
            
        Len_map = GetEachLength(xyz1,xyz2,Reso);
        
        [len1,ind1] = min(Len_map(:,1));
        %ind1 = ceil(ind1(1)/2);        
        [len2,ind2] = min(Len_map(:,2));
        %ind2 = ceil(ind2(1)/2);
        if len1~=0 || len2 ~=0
            Err = 'Error : None Share Branch Point';
        else
            Err = [];
        end
        if len1 <= len2            
            Index = p(ceil(ind1(1)/2));
            TF_flip_Parent = true;
            TF_flip_Foward = ceil(ind1/2) == floor(ind1/2);
        elseif len1 > len2
            Index = p(ceil(ind2(1)/2));
            TF_flip_Parent = false;
            TF_flip_Foward = ceil(ind2/2) == floor(ind2/2);
        end
    end
    function [MinimumLength,IndexSort] = check_xyz_sort(p1,p2,Reso)
        p1= cat(1,p1(1,:),p1(end,:));
        p2= cat(1,p2(1,:),p2(end,:));
        MapLen = GetEachLength(p1,p2,Reso);
        [MinimumLength,IndexSort] = min(MapLen(:));
    end
    function Len_map = GetEachLength(xyz1,xyz2,Reso)
        Len_map = zeros(size(xyz2,1),size(xyz1,1));
        for n = 1:size(xyz1,1)
            select = xyz1(n,:);
            select = repmat(select,[size(xyz2,1) 1]);
            LEN = (xyz2 - select) .* repmat(Reso(1:3),[size(xyz2,1) 1]);
            LEN = sqrt(sum(LEN .^2 , 2));
            Len_map(:,n) = LEN;
        end
    end
    function Branch = CheckBranch(xyz,NewBranch,Reso)
        Branch = [];
        for n = 1:size(xyz,1)
            xyz1 = xyz(n,:);
            len  = GetEachLength(xyz1,NewBranch,Reso);
            check_branch = len(:,1) == 0;
            Branch = cat(1,Branch,NewBranch(check_branch,:));
        end        
        if isempty(Branch)
            Branch = nan(1,3);
        end
    end








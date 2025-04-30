function SEG = AutoSegment(skel,NewReso,AddBP,cutlen)
% SEG = TS_AutoSegment_loop(skel,NewReso,AddBP,cutlen)
% version 19Charly, a bag modiry.... true connection in b2b.
% version 19Delta (just name AutoSegment) is writen for mex c-code
%    by Sugashi, 2019, 11, 17
%
% other function 
% AtSEG_shaving
% AutoSegment_Pre
% AutoSegment(self)
% GetEachLength
% sort_xyz
% TS_AutoSegment_base
% TS_bwlabeln3D26
% TS_bwlabeln3D26 > Labeling
% TS_bwlabeln3D26 > TS_bwlabeln_linux_c
% TS_Label2Centroid
% TS_Label2Centroid > vectGra
% TS_skel2endpoint
% TS_skel2endpoint > CreateSE
% TS_Skeleton3D_oldest
% TS_Skeleton3D_oldest > TS_find
% TS_skelmorph3d
% xyz2plen



if ismatrix(skel)
    skel = cat(3,skel,false(size(skel)));
end

skel1 = skel;
if isempty(AddBP)
    AddBP = false(size(skel));
end
lnum = 1;
if cutlen > 0
    SEG = AutoSegment_Pre(skel1,NewReso,AddBP);
    skel2 = AtSEG_shaving(SEG,cutlen);
    
    while sum(skel1(:)) ~= sum(skel2(:))
%         disp(['  Now Shaving... loop No. ' num2str(lnum)])
        skel1 = SEG.Input;
        SEG = AutoSegment_Pre(skel2,NewReso,AddBP);
        skel2 = AtSEG_shaving(SEG,cutlen);
        lnum = lnum + 1;
    end
    %clear  skel2
    % AddBP = false(size(skel));
    % SEG = TS_AutoSegment1st_New20161021(skel1,NewReso,AddBP);
end
SEG = TS_AutoSegment_base(skel1,NewReso,AddBP);
SEG.loopNum = lnum;
SEG.cutlen = cutlen;
SEG.Original = skel;
end

function Nxyz = sort_xyz(xyz,Reso)
if size(xyz,1) <=2
    Nxyz = xyz;
    return
end

lenmap = GetEachLength(xyz,xyz,Reso);
LenVal = sum(lenmap,1);
[~,sp] = max(LenVal);
sp = sp(1);
Nxyz= xyz;
Nxyz(1,:) = xyz(sp,:);
beforP = xyz(sp,:);
xyz(sp,:) = [];
c = 2;
while ~isempty(xyz)
    lenmap = GetEachLength(beforP,xyz,Reso);
    [~,p] = min(lenmap);
    p = p(1);
    Nxyz(c,:) = xyz(p,:);
    beforP = xyz(p,:);
    xyz(p,:) = [];
    c = c + 1;
end
end

function Output = TS_AutoSegment_base(bwthindata,Reso,AddBP)
% Output = TS_AutoSegment1(skeleton_logicaldata,Resolution)
% 0. Pre Processing
% 1. End point to Branch or End Point
% 2. Branch to Branch Point
%  * Resolution need X:Y:Z = [1:1:1]!!!
% % 

if islogical(AddBP)
   AddBP = and(bwthindata,AddBP);
end
tic
OriginalBW = bwthindata;
% % PointXYZ is matrix, Type is 'End to Branch' or 'Branch to Branch'
% Pdata_base = struct('PointXYZ',[],'Type',[],'Length',[],'Branch',[]); %  point--->[Y X Z]
SegP = nan(2048,3);
Pdata_base = struct(...
    'PointXYZ',nan(2048,3),...
    'Type',zeros(1,1),...
    'Length',zeros(1,1),...
    'Branch',nan(2,3)); %  point--->[Y X Z]
Pdata = repmat(Pdata_base,[1 2^15]);
TYPEnum = zeros(1,1,'like',double(1));
%% Analysis Branch-point and End-point 
disp('Analysis Branch-point and End-point ')
[BPcentroid,~,BPgroup,EndP] = TS_skelmorph3d(bwthindata);
BPcentroid(AddBP) = true;
EndP(AddBP) = false;
 %% % term add . 2016.10.17
 BPgroup = or(BPcentroid,BPgroup);
%% main process
disp('Analysis Branch-point and End-point ')
[bpy,bpx,bpz] = ind2sub(size(BPcentroid),find(BPcentroid(:)));
 % BP point infomation,[X Y Z Number Count]
 BPmatrix = cat(2,bpx,bpy,bpz,find(BPcentroid(:)),zeros(size(bpx))); 
 %clear  bpy bpx bpz

Output.Output = OriginalBW; %%�@Output.Input-->Output.Output�ɕύX�DTS_AutoSegment��Shaving��̍ŏISEG�D�̂��߁D
Output.AddBP = AddBP;
Output.Branch = BPcentroid;
Output.BranchGroup = BPgroup;
Output.End = EndP;
Output.Pointdata = Pdata;
Output.ResolutionXYZ = Reso;

bwthindata = padarray(bwthindata,[1 1 1],0); %% For Crop;Nearest 26 point
%  pointview(bwthindata,Reso,'figure')
BPcentroid = padarray(BPcentroid,[1 1 1],0);
BPgroup = padarray(BPgroup,[1 1 1],0);
[~,DistInd] = bwdist(BPcentroid);
% L_BPgroup = uint32(bwlabeln(BPcentroid,26));
L_BPgroup = TS_bwlabeln3D26(BPcentroid);

L_BPgroup(BPgroup) = L_BPgroup(DistInd(BPgroup));
%clear  DistInd
bwthindata(BPcentroid) = false; %% bwthindata --->����čs���A�Ȃ��Ȃ�����I��
bwthindata(BPgroup) = false;

EndP = padarray(EndP,[1 1 1],0);

%% End point to a Branchpoint or a Endpoint
disp('   ... 1st End point to a Branchpoint or a Endpoint')
[ey,ex,ez] = ind2sub(size(EndP),find(EndP(:)));
len_ey = sum(EndP(:));
Pdata_count = 1;
for n = 1:len_ey %length(ey)
    Y = ey(n);
    X = ex(n);
    Z = ez(n);
    BranchPoint = nan(2,3);
    % % End point check(End-End�͓�Ԗڂ�EndPoint�������Ă��܂����߁B)
    if not(bwthindata(Y,X,Z))
        continue
    end
    c = uint32(1);
    TYPEnum = nan(1,1);
%     Segment = struct('point',[]);
%     Segment(c).point = double([X Y Z]-1); %% padarray���Ă��邽��-1
    SegP(c,:) = double([X Y Z]-1);
    bwthindata(Y,X,Z) = false;
    Go2Next = true;    
    while Go2Next
        c = c + 1;
        BPcentroid_ROI = BPcentroid(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
        BPgroup_ROI = BPgroup(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
        bwthindata(Y,X,Z) = false;
        ROI = bwthindata(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
        lenp = [Y X Z];
      if max(BPcentroid_ROI(:))
            [BPCy,BPCx,BPCz] = ind2sub(size(BPcentroid_ROI),find(BPcentroid_ROI(:)));
            BPC = cat(2,BPCy+Y-2,BPCx+X-2,BPCz+Z-2);
            lenp = repmat(lenp,[size(BPC,1) 1]);
            LEN = sum((BPC - lenp).^2,2);
            [~,Ind] = min(LEN);
            Ind = Ind(1);
            X = BPC(Ind,2); Y = BPC(Ind,1); Z = BPC(Ind,3);
%             Segment(c).point = double([X Y Z]-1);
            SegP(c,:) = double([X Y Z]-1);
            %clear  Ind LEN Lnum BPCy BPCx BPCz BPC                        
%             TYPE = 'End to Branch';
            TYPEnum = 1;
            BranchPoint(1,:) = [X Y Z] - 1;
            Go2Next = false;
      else
        if max(BPgroup_ROI(:))            
            [BPGy,BPGx,BPGz] = ind2sub(size(BPgroup_ROI),find(BPgroup_ROI(:)));
            BPG = cat(2,BPGy+Y-2,BPGx+X-2,BPGz+Z-2);
            lenp = repmat(lenp,[size(BPG,1) 1]);
            LEN = sum((BPG - lenp).^2,2);
            [~,Ind] = min(LEN);
            Ind = Ind(1);
            X = BPG(Ind,2); Y = BPG(Ind,1); Z = BPG(Ind,3);
%             Segment(c).point = double([X Y Z]-1);
            SegP(c,:) = double([X Y Z]-1);
            
             c = c + 1;
            Lnum = L_BPgroup(Y,X,Z);
            FindNearestBP = and(BPcentroid,L_BPgroup==Lnum);
            [Fy,Fx,Fz] = ind2sub(size(FindNearestBP),find(FindNearestBP(:)));
            Fyxz = cat(2,Fy,Fx,Fz);
%             try
            if size(Fyxz,1)>1    
                p = padarray([Y X Z],[size(Fyxz,1)-1 0],'symmetric','pre');
%                 p = repmat([Y X Z],[size(Fyxz,1) 1]);
%             catch err
            else
%                 warning(err.message)
%                 disp(['*****Current Pointdata Number is ' num2str(Pdata_count) '*****'])
%                 disp('   1.1---> Find Nearest Branch Point(centroid)')
%                 disp('**********************************************')
                [Fy,Fx,Fz] = ind2sub(size(BPcentroid),find(BPcentroid(:)));
                Fyxz = cat(2,Fy,Fx,Fz);
                p = repmat([Y X Z],[size(Fyxz,1) 1]);                
            end
            LEN = sum((Fyxz - p).^2,2);
            [~,Ind] = min(LEN);
            Ind = Ind(1);
            X = Fyxz(Ind,2);
            Y = Fyxz(Ind,1);
            Z = Fyxz(Ind,3);
%             Segment(c).point = double([X Y Z]-1);
            SegP(c,:) = double([X Y Z]-1);
            %clear  Fyxz Ind LEN p Fy Fx Fz FindNearestBP Lnum BPGy BPGx BPGz BPG
            
%             TYPE = 'End to Branch';
            TYPEnum = 1;
            BranchPoint(1,:) = [X Y Z] - 1;
            Go2Next = false;
                       
        else
           if max(ROI(:))==0
%             TYPE = 'End to End';
            TYPEnum = 5;
            Go2Next = false;
           else
            [Cy,Cx,Cz] = ind2sub(size(ROI),find(ROI(:)));
            C = cat(2,Cy+Y-2,Cx+X-2,Cz+Z-2);
            lenp = repmat(lenp,[size(C,1) 1]);
            LEN = sum((C - lenp).^2,2);
            [~,Ind] = min(LEN);
            Ind = Ind(1);
            X = C(Ind,2);
            Y = C(Ind,1);
            Z = C(Ind,3);
%             Segment(c).point = double([X Y Z]-1);
            SegP(c,:) = double([X Y Z]-1);
            bwthindata(Y,X,Z) = false;
            if EndP(Y,X,Z)
%                 TYPE = 'End to End';
                TYPEnum = 5;
                Go2Next = false;
            else
                Go2Next = true;
            end
            %clear  Ind LEN Lnum Cy Cx Cz C
           end
        end
      end        
        %clear  leny lenx lenz lenp LEN Index
    end
%     Point4Len = cat(1,Segment.point);
    Pdata(Pdata_count(1)).PointXYZ(1:c,1:3) = SegP(1:c,1:3);
%     Pdata(Pdata_count).PointXYZ = Point4Len;
    % % Lenght by bilinear
    NumSeg = sum(~isnan(SegP(:,1)));
    if NumSeg == 1
        Pdata(Pdata_count).Length = 0;
    else
        LEN_reso = diff(SegP,1) .* ...
            repmat(Reso,[size(SegP,1)-1 1]);
        Pdata(Pdata_count).Length = nansum(sqrt(nansum(LEN_reso.^2,2)),1);
    end
    SegP(:) = nan;
    Pdata(Pdata_count).Type = TYPEnum;
    Pdata(Pdata_count).Branch = BranchPoint;
    Pdata_count = Pdata_count+ 1;
end
% disp(['End Point Num.:' num2str(n) ', Segment(bp-end) NUM.:' num2str(Pdata_count-1)])

%% Next Step
disp('   ... 2nd Branch - Branch')
NewEndP = TS_skel2endpoint(bwthindata);

%% 2nd Segment Branch - Branch
[NewEy,NewEx,NewEz] = ind2sub(size(NewEndP),find(NewEndP(:)));
for n = 1:length(NewEy)
    Y = NewEy(n);
    X = NewEx(n);
    Z = NewEz(n);
    BranchPoint = nan(2,3);
%     TYPE = 'Branch to Branch';
    TYPEnum = 0;
    % % End point check(End-End�͓�Ԗڂ�EndPoint�������Ă��܂����߁B)
    if not(bwthindata(Y,X,Z))
        continue
    end    
%     Segment = struct('point',[]);
    
    %% Find Nearest BPgroup
    % 3x3x3 crop
%11     BPcentroid_ROI = BPcentroid(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
    BPgroup_ROI = BPgroup(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
    bwthindata(Y,X,Z) = false;
    ROI = bwthindata(Y-1:Y+1,X-1:X+1,Z-1:Z+1);    
    
    if max(BPgroup_ROI(:))==0
        %% Not Exist Near BPgroup
%     Segment(1).point = double([X Y Z]-1);
    SegP(1,:) = double([X Y Z]-1);
%     TYPE = 'Point';
    TYPEnum = nan;
%     disp(['*****Current Pointdata Number is ' num2str(Pdata_count) '*****'])
%     warning(TYPE)    
%     disp('  2.1 ---> Just Point!!')
%     disp('**********************************************')
%11     Go2Next = false;
    
    else
    lenp = [Y X Z];
    %% Nearest
    [BPGy,BPGx,BPGz] = ind2sub(size(BPgroup_ROI),find(BPgroup_ROI(:)));
    BPG = cat(2,BPGy+Y-2,BPGx+X-2,BPGz+Z-2);
    lenp = repmat(lenp,[size(BPG,1) 1]);
    LEN = sum((BPG - lenp).^2,2);
    [~,Ind] = min(LEN);
    Ind = Ind(1);
    X1 = BPG(Ind,2);
    Y1 = BPG(Ind,1);
    Z1 = BPG(Ind,3);
    Lnum = L_BPgroup(Y1,X1,Z1);
    % BPgroup or BPpoint
    if BPcentroid(Y1,X1,Z1)
%         Segment(1).point = double([X1 Y1 Z1]-1);
%         Segment(2).point = double([X Y Z]-1);
        SegP(1,:) = double([X1 Y1 Z1]-1);
        SegP(2,:) = double([X Y Z]-1);
        BranchPoint(1,:) = double([X1 Y1 Z1]-1);
        c = uint32(3);
    else
        % Find Nearest BPpoint(centorid)        
        FindNearestBP = and(BPcentroid,L_BPgroup==Lnum);
        [Fy,Fx,Fz] = ind2sub(size(FindNearestBP),find(FindNearestBP(:)));
        Fyxz = cat(2,Fy,Fx,Fz);
%         try
        if size(Fyxz,1)>1
            p = padarray([Y1 X1 Z1],[size(Fyxz,1)-1 0],'symmetric','pre');
%             p = repmat([Y1 X1 Z1],[size(Fyxz,1) 1]);
%         catch err
        else   
%             warning(err.message)
%             disp(['*****Current Pointdata Number is ' num2str(Pdata_count) '.*****'])
%             disp('   2.2---> Find Nearest Branch Point(centroid).')
%             disp('**********************************************')
            [Fy,Fx,Fz] = ind2sub(size(BPcentroid),find(BPcentroid(:)));
            Fyxz = cat(2,Fy,Fx,Fz);
            p = repmat([Y1 X1 Z1],[size(Fyxz,1) 1]);             
        end        
        LEN = sum((Fyxz - p).^2,2);
        [~,Ind] = min(LEN);
        Ind = Ind(1);
        X2 = Fyxz(Ind,2);
        Y2 = Fyxz(Ind,1);
        Z2 = Fyxz(Ind,3);
%         Segment(1).point = double([X2 Y2 Z2]-1);
%         Segment(2).point = double([X1 Y1 Z1]-1);
%         Segment(3).point = double([X Y Z]-1);
        SegP(1,:) = double([X2 Y2 Z2]-1);
        SegP(2,:) = double([X1 Y1 Z1]-1);
        SegP(3,:) = double([X Y Z]-1);        
        BranchPoint(1,:) = double([X2 Y2 Z2]-1);
        c = uint32(4);
    end
    %clear  Fyxz Ind LEN p Fy Fx Fz FindNearestBP X1 X2 Y1 Y2 Z1 Z2 
    %clear  BPGy BPGx BPGz BPG lenp
    
    %% Next point
    % BPgroup or Normal point
    NextBPgroup_ROI = BPgroup;
    NextBPgroup_ROI(L_BPgroup==Lnum) = false;
    BPgroup_ROI = NextBPgroup_ROI(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
    
    % Exis Next BPgroup
    if max(BPgroup_ROI(:))
        [BPGy,BPGx,BPGz] = ind2sub(size(BPgroup_ROI),find(BPgroup_ROI(:)));
        BPG = cat(2,BPGy+Y-2,BPGx+X-2,BPGz+Z-2);
        lenp = repmat([Y X Z],[size(BPG,1) 1]);
        LEN = sum((BPG - lenp).^2,2);
        [~,Ind] = min(LEN);
        Ind = Ind(1);
        X1 = BPG(Ind,2);
        Y1 = BPG(Ind,1);
        Z1 = BPG(Ind,3);
        if BPcentroid(Y1,X1,Z1)
%             Segment(c).point = double([X1 Y1 Z1]-1);
            SegP(c,:) = double([X1 Y1 Z1]-1);
            BranchPoint(2,:) = double([X1 Y1 Z1]-1);
%11             Go2Next = false;
        else
            % Find Nearest BPpoint(centorid)        
            FindNearestBP = and(BPcentroid,L_BPgroup==Lnum);
            [Fy,Fx,Fz] = ind2sub(size(FindNearestBP),find(FindNearestBP(:)));
            Fyxz = cat(2,Fy,Fx,Fz);
            p = repmat([Y1 X1 Z1],[size(Fyxz,1) 1]);
            LEN = sum((Fyxz - p).^2,2);
            [~,Ind] = min(LEN);
%             try
            Ind = Ind(1);
%             catch err
%                 disp(err)
%111                 keyboard
%             end
            X2 = Fyxz(Ind,2);
            Y2 = Fyxz(Ind,1);
            Z2 = Fyxz(Ind,3);            
%             Segment(c).point = double([X1 Y1 Z1]-1);
%             Segment(c+1).point = double([X2 Y2 Z2]-1);
            SegP(c,:) = double([X1 Y1 Z1]-1);
            SegP(c+1,:) = double([X2 Y2 Z2]-1);
            BranchPoint(2,:) = double([X2 Y2 Z2]-1);
%11             Go2Next = false;
        end
        %clear  Fyxz Ind LEN p Fy Fx Fz FindNearestBP X1 X2 Y1 Y2 Z1 Z2 
        %clear  BPGy BPGx BPGz BPG lenp
        
    %% No Exis Next BPgroup    
    elseif max(ROI(:))
        Go2Next = true;
        while Go2Next
            [Ny,Nx,Nz] = ind2sub(size(ROI),find(ROI(:)));
            NextPoint = cat(2,Ny+Y-2,Nx+X-2,Nz+Z-2);
            %clear  Ny Nx Nz
            lenp = repmat([Y X Z],[size(NextPoint,1) 1]);
            LEN = sum((NextPoint - lenp).^2,2);
            [~,Ind] = min(LEN);
%???             try
            Ind = Ind(1);
%             catch err
%                 disp(err)
%                 NextPoint
%                 lenp
%                 [Y X Z]
%                 ROI
%                 error('debag')
%             end
            X = NextPoint(Ind,2);
            Y = NextPoint(Ind,1);
            Z = NextPoint(Ind,3);
%             Segment(c).point = double([X Y Z]-1);
            SegP(c,:) = double([X Y Z]-1);
            bwthindata(Y,X,Z) = false;
            c = c + 1;
            %clear  Ind LEN lenp NextPoint
            
            % check Next
            BPcentroid_ROI = BPcentroid(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
            BPgroup_ROI = BPgroup(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
            
            if max(BPgroup_ROI(:))                
                if max(BPcentroid_ROI(:)) %% to Branch point( centorid )
                    [BPGy,BPGx,BPGz] = ind2sub(size(BPcentroid_ROI),find(BPcentroid_ROI(:)));
                    BPG = cat(2,BPGy+Y-2,BPGx+X-2,BPGz+Z-2);%clear  BPGy BPGx BPGz
                    lenp = repmat([Y X Z],[size(BPG,1) 1]);
                    LEN = sum((BPG - lenp).^2,2);
                    [~,Ind] = min(LEN);
                    Ind = Ind(1);
                    X1 = BPG(Ind,2);
                    Y1 = BPG(Ind,1);
                    Z1 = BPG(Ind,3);
%                     Segment(c).point = double([X1 Y1 Z1]-1);
                    SegP(c,:) = double([X1 Y1 Z1]-1);
                    BranchPoint(2,:) = double([X1 Y1 Z1]-1);
                    Go2Next = false;
                    %clear  lenp LEN Ind X1 Y1 Z1 BPG
                else %% to Branch group and Branch point( centorid )
                    [BPGy,BPGx,BPGz] = ind2sub(size(BPgroup_ROI),find(BPgroup_ROI(:)));
                    BPG = cat(2,BPGy+Y-2,BPGx+X-2,BPGz+Z-2);%clear  BPGy BPGx BPGz
                    lenp = repmat([Y X Z],[size(BPG,1) 1]);
                    LEN = sum((BPG - lenp).^2,2);
                    [~,Ind] = min(LEN);
                    Ind = Ind(1);
                    X1 = BPG(Ind,2);
                    Y1 = BPG(Ind,1);
                    Z1 = BPG(Ind,3);
%                     Segment(c).point = double([X1 Y1 Z1]-1);
                    SegP(c,:) = double([X1 Y1 Z1]-1);
                    c = c + 1;
                    %clear  BPG lenp LEN Ind
                    
                    Lnum = L_BPgroup(Y1,X1,Z1);
                    % Find Nearest BPpoint(centorid)        
                    FindNearestBP = and(BPcentroid,L_BPgroup==Lnum);
                    [Fy,Fx,Fz] = ind2sub(size(FindNearestBP),find(FindNearestBP(:)));
                    Fyxz = cat(2,Fy,Fx,Fz);
                    %clear  Fy Fx Fz FindNearestBP
                    
%                     try
                    if size(Fyxz,1)>1
                        p = padarray([Y1 X1 Z1],[size(Fyxz,1)-1 0],'symmetric','pre');
%                         p = repmat([Y1 X1 Z1],[size(Fyxz,1) 1]);
%                     catch err
                    else
%                         warning(err.message)
%                         disp(['*****Current Pointdata Number is ' num2str(Pdata_count) '*****'])
%                         disp('   2.3---> Find Nearest Branch Point(centroid)')
%                         disp('**********************************************')
                        [Fy,Fx,Fz] = ind2sub(size(BPcentroid),find(BPcentroid(:)));
                        Fyxz = cat(2,Fy,Fx,Fz);
                        p = repmat([Y1 X1 Z1],[size(Fyxz,1) 1]);                
                    end
                                        
                    LEN = sum((Fyxz - p).^2,2);
                    [~,Ind] = min(LEN);
                    Ind = Ind(1);
                    X2 = Fyxz(Ind,2);
                    Y2 = Fyxz(Ind,1);
                    Z2 = Fyxz(Ind,3);    
%                     Segment(c).point = double([X2 Y2 Z2]-1);
                    SegP(c,:) = double([X2 Y2 Z2]-1);
                    BranchPoint(2,:) = double([X2 Y2 Z2]-1);
                    Go2Next = false;
                    %clear  p LEN Ind X1 Y1 Z1 X2 Y2 Z1
                end
            else
                ROI = bwthindata(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
                if ~max(ROI(:))
%                     disp(['*****Current Pointdata Number is ' num2str(Pdata_count) '*****'])
%                     disp('   2.2---> Find Nearest Branch Point(centroid)')
                       bp1 = BranchPoint(1,:)+1;
                       [Fy,Fx,Fz] = ind2sub(size(BPcentroid),find(BPcentroid(:)));
                       Ind = and(and(Fy(:)==bp1(2),Fx(:) == bp1(1)),Fz(:) == bp1(3));
                       Fyxz = cat(2,Fy,Fx,Fz);
                       Fyxz(Ind,:) = [];
                        p = repmat([Y X Z],[size(Fyxz,1) 1]);
                        LEN = sum((Fyxz - p).^2,2);
                        [~,Ind] = min(LEN);
                        Ind = Ind(1);
                        X2 = Fyxz(Ind,2);
                        Y2 = Fyxz(Ind,1);
                        Z2 = Fyxz(Ind,3);    
%                         Segment(c).point = double([X2 Y2 Z2]-1);
                        SegP(c,:) = double([X2 Y2 Z2]-1);
                        BranchPoint(2,:) = double([X2 Y2 Z2]-1);
                        Go2Next = false;
                        %clear  p LEN Ind X1 Y1 Z1 X2 Y2 Z1
                else
                    Go2Next = true;
                end
            end
            %clear  Fyxz Ind LEN p Fy Fx Fz FindNearestBP X1 X2 Y1 Y2 Z1 Z2 
            %clear  BPGy BPGx BPGz BPG lenp
        end
    end
    end
    
    %% output Segment data
%     Point4Len = cat(1,Segment.point);
    c = sum(~isnan(SegP(:,1)));
    Pdata(Pdata_count).PointXYZ(1:c,:) = SegP(1:c,:);
    NumSeg = sum(~isnan(SegP(:,1)));
    % % Lenght by bilinear
    if NumSeg == 1
        Pdata(Pdata_count).Length = 0;
    else
        LEN_reso = diff(SegP,1) .* ...
            repmat(Reso,[size(SegP,1)-1 1]);            
        Pdata(Pdata_count).Length = nansum(sqrt(nansum(LEN_reso.^2,2)),1);
    end
    SegP(:) = nan;
    Pdata(Pdata_count).Type = TYPEnum;
    Pdata(Pdata_count).Branch = BranchPoint;
    Pdata_count = Pdata_count+ 1;
    %clear  Segment Y X Z c Go2Next Point4Len LEN_reso
end

%% Version Charly
% Find out Neighbor each BranchPoint
skel = OriginalBW;
siz = size(skel);
for n = 1:length(Pdata)
    if isnan(Pdata(n).PointXYZ(1,1)) %isempty(Pdata(n).PointXYZ)
        break
    end
    xyz = Pdata(n).PointXYZ;
    for k = 1:size(xyz,1)
        if isnan(xyz(k,1))
            break
        end
        skel(xyz(k,2),xyz(k,1),xyz(k,3)) = false;
    end
end

% CC = bwconncomp(skel);
[L,NUM] = TS_bwlabeln3D26(skel);
BPxyz = BPmatrix(:,1:3);

NeighborLim = sqrt( sum( ( ([5 5 5]-1).*Reso).^2 , 2) );
for n = 1:NUM
    ind = find(L(:) == n);
    [y,x,z] = ind2sub(siz,ind);
    xyz = cat(2,x(:),y(:),z(:));
    Nxyz = sort_xyz(xyz,Reso);
    FiBPxyz = BPxyz;
    lenmap = GetEachLength(Nxyz(1,:),FiBPxyz,Reso);
    [len1st,p] = min(lenmap);
    p = p(1);
    s_xyz = FiBPxyz(p,:);
    FiBPxyz(p,:) = [];
    lenmap = GetEachLength(Nxyz(end,:),FiBPxyz,Reso);
    [len2nd,p] = min(lenmap);
    p = p(1);
    e_xyz = FiBPxyz(p,:);
    if NeighborLim > max(cat(1,len1st(:),len2nd(:)))
        AddSegment = cat(1,s_xyz,Nxyz,e_xyz);
        c = size(AddSegment,1);
        Pdata(Pdata_count).PointXYZ(1:c,:) = AddSegment;
        Pdata(Pdata_count).Length = nansum(xyz2plen(AddSegment,Reso));
        Pdata(Pdata_count).Type = 0; %'Branch to Branch';
        Pdata(Pdata_count).Branch = cat(1,s_xyz,e_xyz);
        Pdata_count = Pdata_count+ 1;
    end
end

%% Delete empty 
while isempty(Pdata(end).Length)
    Pdata(end) = [];
end
% try
% Pdata(Pdata_count:end) = [];
% catch
% end

%% BP point infomation,[X Y Z Number Count]
% Branch = cat(1,Pdata.Branch);
Branch = nan(length(Pdata)*2,3);
c = 1;
for n = 1:length(Pdata)
    if isempty(Pdata(n).PointXYZ(1,1))
        break
    end
    bp = Pdata(n).Branch;
    len = sum(~isnan(bp(:,1)));
    Branch(c:c+len-1,:) = bp(1:len,:);
    c = c + len;
end

for n = 1:size(BPmatrix,1)
    p = BPmatrix(n,1:3);
    c = 0;
    for k = 1:size(Branch,1)
        if isnan(Branch(k,1))
            break
        end
        if Branch(k,1) ==p(1) && Branch(k,2) ==p(2) && Branch(k,3) ==p(3)
            c = c + 1;
        end
    end    
    BPmatrix(n,5) = c;
end

Output.Pointdata = Pdata;
Output.BPmatrix = BPmatrix;
end

function Output = AutoSegment_Pre(bwthindata,Reso,AddBP)
% Output = TS_AutoSegment1(skeleton_logicaldata,Resolution)
% 0. Pre Processing
% 1. End point to Branch or End Point
% 2. Branch to Branch Point
%  * Resolution need X:Y:Z = [1:1:1]!!!
% % 

AddBP = and(bwthindata,AddBP);
tic
OriginalBW = bwthindata;
% Resi = sum(bwthindata(:));

% % PointXYZ is matrix, Type is 'End to Branch' or 'Branch to Branch'
% Pdata(1:2^15) = struct('PointXYZ',[],'Type',[],'Length',[],'Branch',[]); %  point--->[Y X Z]
SegP = nan(2048,3);
Pdata_base = struct(...
    'PointXYZ',nan(2048,3),...
    'Type',zeros(1,1),...
    'Length',zeros(1,1),...
    'Branch',nan(1,3)); %  point--->[Y X Z]
Pdata = repmat(Pdata_base,[1 2^15]);
%% Analysis Branch-point and End-point 
% disp('Analysis Branch-point and End-point ')
[BPcentroid,~,BPgroup,EndP] = TS_skelmorph3d(bwthindata);
BPcentroid(AddBP) = true;
EndP(AddBP) = false;
 %% % term add . 2016.10.17
 BPgroup = or(BPcentroid,BPgroup);


%% main process
% disp('Analysis Branch-point and End-point ')
[bpy,bpx,bpz] = ind2sub(size(BPcentroid),find(BPcentroid(:)));
 % BP point infomation,[X Y Z Number Count]
 BPmatrix = cat(2,bpx,bpy,bpz,find(BPcentroid(:)),zeros(size(bpx))); 
 %clear  bpy bpx bpz

Output.Input = OriginalBW;
Output.AddBP = AddBP;
Output.Branch = BPcentroid;
Output.BranchGroup = BPgroup;
Output.End = EndP;
Output.Pointdata = Pdata;
Output.ResolutionXYZ = Reso;
Output.BPmatrix = BPmatrix;

bwthindata = padarray(bwthindata,[1 1 1],0); %% For Crop;Nearest 26 point
%  pointview(bwthindata,Reso,'figure')
BPcentroid = padarray(BPcentroid,[1 1 1],0);
BPgroup = padarray(BPgroup,[1 1 1],0);
[~,DistInd] = bwdist(BPcentroid);
% L_BPgroup = uint32(bwlabeln(BPcentroid,26));
L_BPgroup = TS_bwlabeln3D26(BPcentroid);
L_BPgroup(BPgroup) = L_BPgroup(DistInd(BPgroup));
%clear  DistInd
bwthindata(BPcentroid) = false; %% bwthindata --->����čs���A�Ȃ��Ȃ�����I��
bwthindata(BPgroup) = false;

EndP = padarray(EndP,[1 1 1],0);
%% End point to a Branchpoint or a Endpoint
% disp('   ... 1st End point to a Branchpoint or a Endpoint')

Pdata= Output.Pointdata;
Reso = Output.ResolutionXYZ ;
TYPEnum = zeros(1,1);

[ey,ex,ez] = ind2sub(size(EndP),find(EndP(:)));
Pdata_count = double(1);
for n = 1:length(ey)
    Y = ey(n);
    X = ex(n);
    Z = ez(n);
    BranchPoint = nan(1,3);
    % % End point check(End-End�͓�Ԗڂ�EndPoint�������Ă��܂����߁B)
    if not(bwthindata(Y,X,Z))
        continue
    end
    c = uint32(1);
%     Segment = struct('point',[]);
%     Segment(c).point = double([X Y Z]-1); %% padarray���Ă��邽��-1
    SegP(c,:) = double([X Y Z]-1);
    bwthindata(Y,X,Z) = false;
    Go2Next = true;    
    while Go2Next
        c = c + 1;
        BPcentroid_ROI = BPcentroid(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
        BPgroup_ROI = BPgroup(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
        bwthindata(Y,X,Z) = false;
        ROI = bwthindata(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
        lenp = [Y X Z];
      if max(BPcentroid_ROI(:))
            [BPCy,BPCx,BPCz] = ind2sub(size(BPcentroid_ROI),find(BPcentroid_ROI(:)));
            BPC = cat(2,BPCy+Y-2,BPCx+X-2,BPCz+Z-2);
            lenp = repmat(lenp,[size(BPC,1) 1]);
            LEN = sum((BPC - lenp).^2,2);
            [~,Ind] = min(LEN);
            Ind = Ind(1);
            X = BPC(Ind,2); Y = BPC(Ind,1); Z = BPC(Ind,3);
%             Segment(c).point = double([X Y Z]-1);
            SegP(c,:) = double([X Y Z]-1);
            %clear  Ind LEN Lnum BPCy BPCx BPCz BPC                        
%             TYPE = 'End to Branch';
            TYPEnum = 1;
            BranchPoint = [X Y Z] - 1;
            Go2Next = false;
      else
        if max(BPgroup_ROI(:))            
            [BPGy,BPGx,BPGz] = ind2sub(size(BPgroup_ROI),find(BPgroup_ROI(:)));
            BPG = cat(2,BPGy+Y-2,BPGx+X-2,BPGz+Z-2);
            lenp = repmat(lenp,[size(BPG,1) 1]);
            LEN = sum((BPG - lenp).^2,2);
            [~,Ind] = min(LEN);
            Ind = Ind(1);
            X = BPG(Ind,2); Y = BPG(Ind,1); Z = BPG(Ind,3);
%             Segment(c).point = double([X Y Z]-1);
            SegP(c,:) = double([X Y Z]-1);
             c = c + 1;
            Lnum = L_BPgroup(Y,X,Z);
            FindNearestBP = and(BPcentroid,L_BPgroup==Lnum);
            [Fy,Fx,Fz] = ind2sub(size(FindNearestBP),find(FindNearestBP(:)));
            Fyxz = cat(2,Fy,Fx,Fz);
%             try
                p = padarray([Y X Z],[size(Fyxz,1)-1 0],'symmetric','pre');
%                 p = repmat([Y X Z],[size(Fyxz,1) 1]);
%             catch err
%                 warning(err.message)
%                 disp(['*****Current Pointdata Number is ' num2str(Pdata_count) '*****'])
%                 disp('   1.1---> Find Nearest Branch Point(centroid)')
%                 disp('**********************************************')
%                 [Fy,Fx,Fz] = ind2sub(size(BPcentroid),find(BPcentroid(:)));
%                 Fyxz = cat(2,Fy,Fx,Fz);
%                 p = repmat([Y X Z],[size(Fyxz,1) 1]);                
%             end
            LEN = sum((Fyxz - p).^2,2);
            [~,Ind] = min(LEN);
            Ind = Ind(1);
            X = Fyxz(Ind,2);
            Y = Fyxz(Ind,1);
            Z = Fyxz(Ind,3);
%             Segment(c).point = double([X Y Z]-1);
            SegP(c,:) = double([X Y Z]-1);
            %clear  Fyxz Ind LEN p Fy Fx Fz FindNearestBP Lnum BPGy BPGx BPGz BPG
            
%             TYPE = 'End to Branch';
            TYPEnum = 1;
            BranchPoint = [X Y Z] - 1;
            Go2Next = false;
                       
        else
           if max(ROI(:))==0
%             TYPE = 'End to End';
            TYPEnum = 5;
            Go2Next = false;
           else
            [Cy,Cx,Cz] = ind2sub(size(ROI),find(ROI(:)));
            C = cat(2,Cy+Y-2,Cx+X-2,Cz+Z-2);
            lenp = repmat(lenp,[size(C,1) 1]);
            LEN = sum((C - lenp).^2,2);
            [~,Ind] = min(LEN);
            Ind = Ind(1);
            X = C(Ind,2);
            Y = C(Ind,1);
            Z = C(Ind,3);
%             Segment(c).point = double([X Y Z]-1);
            SegP(c,:) = double([X Y Z]-1);
            bwthindata(Y,X,Z) = false;
            if EndP(Y,X,Z)
%                 TYPE = 'End to End';
                TYPEnum = 5;
                Go2Next = false;
            else
                Go2Next = true;
            end
            %clear  Ind LEN Lnum Cy Cx Cz C
           end
        end
      end        
        %clear  leny lenx lenz lenp LEN Index
    end
%     c = length(Segment);
%     Point4Len = zeros(c,3);
%     for ii = 1:c
%         Point4Len(ii,:) = Segment(ii).point(1:3);
%     end
%     Point4Len = cat(1,Segment.point);
    Pdata(Pdata_count(1)).PointXYZ(1:c,1:3) = SegP(1:c,1:3);
    NumSeg = sum(~isnan(SegP(:,1)));
    % % Lenght by bilinear
    if NumSeg == 1
        Pdata(Pdata_count).Length = 0;
    else
        LEN_reso = diff(SegP,1) .* ...
            repmat(Reso,[size(SegP,1)-1 1]);
        Pdata(Pdata_count).Length = nansum(sqrt(nansum(LEN_reso.^2,2)),1);
    end
    SegP(:) = nan;
%     if strcmpi(TYPE,'End to End')
%         Pdata(Pdata_count).Type = TYPE;
%         Pdata(Pdata_count).Type = .5;
%     elseif strcmpi(TYPE,'End to Branch')
%         Pdata(Pdata_count).Type = 1;
%     end
    Pdata(Pdata_count).Type = TYPEnum;
    Pdata(Pdata_count).Branch = BranchPoint;
    Pdata_count = Pdata_count+ 1;    
    %clear  Segment Y X Z c Go2Next Point4Len LEN_reso
end
% disp(['End Point Num.:' num2str(n) ', Segment(bp-end) NUM.:' num2str(Pdata_count-1)])

% Pdata(Pdata_count:end) = [];


Output.Pointdata = Pdata;
Output.BPmatrix = BPmatrix;
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










function SEG = TS_AutoSegment_v2021a(skel,NewReso,AddBP,cutlen)
% % SEG = TS_AutoSegment_{version*}(skel,Reso,AddBP,cutlen)
% Create Vascular Tree Structure (=Segment) from skeletoning data.
% 
% Input :
%     skel   : Skeletoning(Thining) data. output of bwskel or Skeleton3D.
%     Reso   : Resolution of [X, Y, Z], 1x3 vecotor.
%     AddBP  : Additional Branch Point. Enable as [] (empty).
%     cutlen : Cut of length for Shaving in fake Segment. 
%              Input unit depends on Resolution.
%     
% Output : (main fields)
%       -fields-     -description-                    -size class-
%           Output: Index of skeleton after shaving.  [N×1 double]
%            AddBP: Index of AddBP(Input).            [N×1 double]
%           Branch: Index of Branch Point.            [N×1 double]
%      BranchGroup: Index of Branch Point Group.      [N×1 double]
%              End: Index of End Point.               [N×1 double]
%        Pointdata: Segment data (structure).         [1×N struct]
%    ResolutionXYZ: Resolution(Input)                 [X, Y, Z]
%         BPmatrix: Branch Point Matrix(for Developer)[N×5 double]
%          loopNum: Number of loop for Shaving         1x1 double
%           cutlen: cutlen(Input)                      1x1 double
%         Original: Index of skeleton(Input)          [N×1 double]
%   BranchPointXYZ: Branch Point [N x XYZ]            [N×3 double]
%             Size: Input Size(=size(skel))           [1x3 double]
% 
% % Example.
% load mri
% clear siz map
% D = squeeze(D);
% Reso = [1 1 1.5];
% bw = D > 65;
% bw = imclose(bw,strel('disk',2,0));
% skel = bwskel(bw);
% pointview(skel,Reso)
% SEG = TS_AutoSegment_v2021a(skel,Reso,[],15);
% SEGview(SEG,'ID'),title('After Auto Segment')
% Sf = Segment_Functions;
% NewSEG = Sf.SmoothingSEG(SEG,0.2,7);
% SEGview(NewSEG,'ID'),title('After Smoothing')
% 
% see also Segment_Functions

% version 19Charly, a bag modiry.... true connection in b2b.
%
% version 2021a
% Add Segment_function.set_Segment(output) 31st, Jan. 2021. Takuma Sugashi
% 
% (c) Leo Takuma Sugashi



ISmatrix = ismatrix(skel);
if ismatrix(skel)
    skel = cat(3,skel,false(size(skel)));
end

if length(NewReso)==2
    NewReso(3) = 0;
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
        disp(['  Now Shaving... loop No. ' num2str(lnum)])
        skel1 = SEG.Input;
        SEG = AutoSegment_Pre(skel2,NewReso,AddBP);
        skel2 = AtSEG_shaving(SEG,cutlen);
        lnum = lnum + 1;
    end
    clear skel2
    % AddBP = false(size(skel));
    % SEG = TS_AutoSegment1st_New20161021(skel1,NewReso,AddBP);
end
SEG = AutoSegment(skel1,NewReso,AddBP);
if ISmatrix
    SEG.Output(:,:,2) = [];
    SEG.AddBP(:,:,2) = [];
    SEG.Branch(:,:,2) = [];
    SEG.BranchGroup(:,:,2) = [];
    SEG.End(:,:,2) = [];
    skel(:,:,2) = [];
end
SEG.loopNum = lnum;
SEG.cutlen = cutlen;
SEG.Original = skel;

%% 31st, Jan. 2021
Sf = Segment_Functions;
SEG = Sf.set_Segment(SEG);

end

function Nxyz = sort_xyz(xyz,Reso)
if size(xyz,1) <=2
    Nxyz = xyz;
    return
end
S = Segment_Functions;
lenmap = S.GetEachLength(xyz,xyz,Reso);
LenVal = sum(lenmap,1);
[~,sp] = max(LenVal);
sp = sp(1);
Nxyz= xyz;
Nxyz(1,:) = xyz(sp,:);
beforP = xyz(sp,:);
xyz(sp,:) = [];
c = 2;
while ~isempty(xyz)
    lenmap = S.GetEachLength(beforP,xyz,Reso);
    [~,p] = min(lenmap);
    p = p(1);
    Nxyz(c,:) = xyz(p,:);
    beforP = xyz(p,:);
    xyz(p,:) = [];
    c = c + 1;
end
end

function Output = AutoSegment(bwthindata,varargin)
% Output = TS_AutoSegment1(skeleton_logicaldata,Resolution)
% 0. Pre Processing
% 1. End point to Branch or End Point
% 2. Branch to Branch Point
%  * Resolution need X:Y:Z = [1:1:1]!!!
% % 

Reso = ones(1,3);
AddBP = [];
% CutLen = 20;
if nargin >=2
    Reso = varargin{1};
end
if nargin >= 3
    AddBP = varargin{2};
    if ~isempty(AddBP)
        AddBP = and(bwthindata,AddBP);
    end
end
tic
OriginalBW = bwthindata;
% % PointXYZ is matrix, Type is 'End to Branch' or 'Branch to Branch'
Pdata(1:10000) = struct('PointXYZ',[],'Type',[],'Length',[],'Branch',[]); %  point--->[Y X Z]
%% Analysis Branch-point and End-point 
disp('Analysis Branch-point and End-point ')
[BPcentroid,~,BPgroup,EndP] = TS_bwmorph3d(bwthindata,'branchpoint','none');


BPcentroid(AddBP) = true;
EndP(AddBP) = false;
 %% % term add . 2016.10.17
 BPgroup = or(BPcentroid,BPgroup);
%% main process
disp('Analysis Branch-point and End-point ')
[bpy,bpx,bpz] = ind2sub(size(BPcentroid),find(BPcentroid(:)));
 % BP point infomation,[X Y Z Number Count]
 BPmatrix = cat(2,bpx,bpy,bpz,find(BPcentroid(:)),zeros(size(bpx))); 
 clear bpy bpx bpz

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
L_BPgroup = uint32(bwlabeln(BPcentroid,26));
L_BPgroup(BPgroup) = L_BPgroup(DistInd(BPgroup));
clear DistInd
bwthindata(BPcentroid) = false; %% bwthindata --->����čs���A�Ȃ��Ȃ�����I��
bwthindata(BPgroup) = false;

EndP = padarray(EndP,[1 1 1],0);

%% End point to a Branchpoint or a Endpoint
disp('   ... 1st End point to a Branchpoint or a Endpoint')
[ey,ex,ez] = ind2sub(size(EndP),find(EndP(:)));
Pdata_count = 1;
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
    Segment = struct('point',[]);
    Segment(c).point = double([X Y Z]-1); %% padarray���Ă��邽��-1
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
            Segment(c).point = double([X Y Z]-1);
            clear Ind LEN Lnum BPCy BPCx BPCz BPC                        
            TYPE = 'End to Branch';
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
            Segment(c).point = double([X Y Z]-1);
             c = c + 1;
            Lnum = L_BPgroup(Y,X,Z);
            FindNearestBP = and(BPcentroid,L_BPgroup==Lnum);
            [Fy,Fx,Fz] = ind2sub(size(FindNearestBP),find(FindNearestBP(:)));
            Fyxz = cat(2,Fy,Fx,Fz);
            try
                p = padarray([Y X Z],[size(Fyxz,1)-1 0],'symmetric','pre');
%                 p = repmat([Y X Z],[size(Fyxz,1) 1]);
            catch err
                warning(err.message)
                disp(['*****Current Pointdata Number is ' num2str(Pdata_count) '*****'])
                disp('   1.1---> Find Nearest Branch Point(centroid)')
                disp('**********************************************')
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
            Segment(c).point = double([X Y Z]-1);
            clear Fyxz Ind LEN p Fy Fx Fz FindNearestBP Lnum BPGy BPGx BPGz BPG
            
            TYPE = 'End to Branch';
            BranchPoint = [X Y Z] - 1;
            Go2Next = false;
                       
        else
           if max(ROI(:))==0
            TYPE = 'End to End';
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
            Segment(c).point = double([X Y Z]-1);
            bwthindata(Y,X,Z) = false;
            if EndP(Y,X,Z)
                TYPE = 'End to End';
                Go2Next = false;
            else
                Go2Next = true;
            end
            clear Ind LEN Lnum Cy Cx Cz C
           end
        end
      end        
        clear leny lenx lenz lenp LEN Index
    end
    Point4Len = cat(1,Segment.point);
    Pdata(Pdata_count).PointXYZ = Point4Len;
    % % Lenght by bilinear
    if size(Point4Len,1) == 1
        Pdata(Pdata_count).Length = 0;
    else
        LEN_reso = diff(Point4Len,1) .* ...
            repmat(Reso,[size(Point4Len,1)-1 1]);
        Pdata(Pdata_count).Length = sum(sqrt(sum(LEN_reso.^2,2)),1);
    end
    Pdata(Pdata_count).Type = TYPE;
    Pdata(Pdata_count).Branch = BranchPoint;
    Pdata_count = Pdata_count+ 1;
    
    
    clear Segment Y X Z c Go2Next Point4Len LEN_reso
end
disp(['End Point Num.:' num2str(n) ', Segment(bp-end) NUM.:' num2str(Pdata_count-1)])

%% Next Step
disp('   ... 2nd Branch - Branch')

NewEndP = TS_bwmorph3d(bwthindata,'endpoint');


%% 2nd Segment Branch - Branch
[NewEy,NewEx,NewEz] = ind2sub(size(NewEndP),find(NewEndP(:)));
for n = 1:length(NewEy)
    Y = NewEy(n);
    X = NewEx(n);
    Z = NewEz(n);
    BranchPoint = nan(2,3);
    TYPE = 'Branch to Branch';
    % % End point check(End-End�͓�Ԗڂ�EndPoint�������Ă��܂����߁B)
    if not(bwthindata(Y,X,Z))
        continue
    end    
    Segment = struct('point',[]);
    
    %% Find Nearest BPgroup
    % 3x3x3 crop
%11     BPcentroid_ROI = BPcentroid(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
    BPgroup_ROI = BPgroup(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
    bwthindata(Y,X,Z) = false;
    ROI = bwthindata(Y-1:Y+1,X-1:X+1,Z-1:Z+1);    
    
    if max(BPgroup_ROI(:))==0
        %% Not Exist Near BPgroup
    Segment(1).point = double([X Y Z]-1);
    TYPE = 'Point';
    disp(['*****Current Pointdata Number is ' num2str(Pdata_count) '*****'])
    warning(TYPE)    
    disp('  2.1 ---> Just Point!!')
    disp('**********************************************')
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
        Segment(1).point = double([X1 Y1 Z1]-1);
        Segment(2).point = double([X Y Z]-1);
        BranchPoint(1,:) = double([X1 Y1 Z1]-1);
        c = uint32(3);
    else
        % Find Nearest BPpoint(centorid)        
        FindNearestBP = and(BPcentroid,L_BPgroup==Lnum);
        [Fy,Fx,Fz] = ind2sub(size(FindNearestBP),find(FindNearestBP(:)));
        Fyxz = cat(2,Fy,Fx,Fz);
        try
            p = padarray([Y1 X1 Z1],[size(Fyxz,1)-1 0],'symmetric','pre');
%             p = repmat([Y1 X1 Z1],[size(Fyxz,1) 1]);
        catch err
            warning(err.message)
            disp(['*****Current Pointdata Number is ' num2str(Pdata_count) '.*****'])
            disp('   2.2---> Find Nearest Branch Point(centroid).')
            disp('**********************************************')
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
        Segment(1).point = double([X2 Y2 Z2]-1);
        Segment(2).point = double([X1 Y1 Z1]-1);
        Segment(3).point = double([X Y Z]-1);
        BranchPoint(1,:) = double([X2 Y2 Z2]-1);
        c = uint32(4);
    end
    clear Fyxz Ind LEN p Fy Fx Fz FindNearestBP X1 X2 Y1 Y2 Z1 Z2 
    clear BPGy BPGx BPGz BPG lenp
    
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
            Segment(c).point = double([X1 Y1 Z1]-1);
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
            try
            Ind = Ind(1);
            catch err
                disp(err)
%111                 keyboard
            end
            X2 = Fyxz(Ind,2);
            Y2 = Fyxz(Ind,1);
            Z2 = Fyxz(Ind,3);            
            Segment(c).point = double([X1 Y1 Z1]-1);
            Segment(c+1).point = double([X2 Y2 Z2]-1);
            BranchPoint(2,:) = double([X2 Y2 Z2]-1);
%11             Go2Next = false;
        end
        clear Fyxz Ind LEN p Fy Fx Fz FindNearestBP X1 X2 Y1 Y2 Z1 Z2 
        clear BPGy BPGx BPGz BPG lenp
        
    %% No Exis Next BPgroup    
    elseif max(ROI(:))
        Go2Next = true;
        while Go2Next
            [Ny,Nx,Nz] = ind2sub(size(ROI),find(ROI(:)));
            NextPoint = cat(2,Ny+Y-2,Nx+X-2,Nz+Z-2);
            clear Ny Nx Nz
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
            Segment(c).point = double([X Y Z]-1);
            bwthindata(Y,X,Z) = false;
            c = c + 1;
            clear Ind LEN lenp NextPoint
            
            % check Next
            BPcentroid_ROI = BPcentroid(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
            BPgroup_ROI = BPgroup(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
            
            if max(BPgroup_ROI(:))                
                if max(BPcentroid_ROI(:)) %% to Branch point( centorid )
                    [BPGy,BPGx,BPGz] = ind2sub(size(BPcentroid_ROI),find(BPcentroid_ROI(:)));
                    BPG = cat(2,BPGy+Y-2,BPGx+X-2,BPGz+Z-2);clear BPGy BPGx BPGz
                    lenp = repmat([Y X Z],[size(BPG,1) 1]);
                    LEN = sum((BPG - lenp).^2,2);
                    [~,Ind] = min(LEN);
                    Ind = Ind(1);
                    X1 = BPG(Ind,2);
                    Y1 = BPG(Ind,1);
                    Z1 = BPG(Ind,3);
                    Segment(c).point = double([X1 Y1 Z1]-1);
                    BranchPoint(2,:) = double([X1 Y1 Z1]-1);
                    Go2Next = false;
                    clear lenp LEN Ind X1 Y1 Z1 BPG
                else %% to Branch group and Branch point( centorid )
                    [BPGy,BPGx,BPGz] = ind2sub(size(BPgroup_ROI),find(BPgroup_ROI(:)));
                    BPG = cat(2,BPGy+Y-2,BPGx+X-2,BPGz+Z-2);clear BPGy BPGx BPGz
                    lenp = repmat([Y X Z],[size(BPG,1) 1]);
                    LEN = sum((BPG - lenp).^2,2);
                    [~,Ind] = min(LEN);
                    Ind = Ind(1);
                    X1 = BPG(Ind,2);
                    Y1 = BPG(Ind,1);
                    Z1 = BPG(Ind,3);
                    Segment(c).point = double([X1 Y1 Z1]-1);
                    c = c + 1;
                    clear BPG lenp LEN Ind
                    
                    Lnum = L_BPgroup(Y1,X1,Z1);
                    % Find Nearest BPpoint(centorid)        
                    FindNearestBP = and(BPcentroid,L_BPgroup==Lnum);
                    [Fy,Fx,Fz] = ind2sub(size(FindNearestBP),find(FindNearestBP(:)));
                    Fyxz = cat(2,Fy,Fx,Fz);
                    clear Fy Fx Fz FindNearestBP
                    
                    try
                        p = padarray([Y1 X1 Z1],[size(Fyxz,1)-1 0],'symmetric','pre');
%                         p = repmat([Y1 X1 Z1],[size(Fyxz,1) 1]);
                    catch err
                        warning(err.message)
                        disp(['*****Current Pointdata Number is ' num2str(Pdata_count) '*****'])
                        disp('   2.3---> Find Nearest Branch Point(centroid)')
                        disp('**********************************************')
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
                    Segment(c).point = double([X2 Y2 Z2]-1);
                    BranchPoint(2,:) = double([X2 Y2 Z2]-1);
                    Go2Next = false;
                    clear p LEN Ind X1 Y1 Z1 X2 Y2 Z1
                end
            else
                ROI = bwthindata(Y-1:Y+1,X-1:X+1,Z-1:Z+1);
                if ~max(ROI(:))
                    disp(['*****Current Pointdata Number is ' num2str(Pdata_count) '*****'])
                    disp('   2.2---> Find Nearest Branch Point(centroid)')
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
                        Segment(c).point = double([X2 Y2 Z2]-1);
                        BranchPoint(2,:) = double([X2 Y2 Z2]-1);
                        Go2Next = false;
                        clear p LEN Ind X1 Y1 Z1 X2 Y2 Z1
                else
                    Go2Next = true;
                end
            end
            clear Fyxz Ind LEN p Fy Fx Fz FindNearestBP X1 X2 Y1 Y2 Z1 Z2 
            clear BPGy BPGx BPGz BPG lenp
        end
    end
    end
    
    %% output Segment data
    Point4Len = cat(1,Segment.point);
    Pdata(Pdata_count).PointXYZ = Point4Len;
    % % Lenght by bilinear
    if size(Point4Len,1) == 1
        Pdata(Pdata_count).Length = 0;
    else
        LEN_reso = diff(Point4Len,1) .* ...
            repmat(Reso,[size(Point4Len,1)-1 1]);            
        Pdata(Pdata_count).Length = sum(sqrt(sum(LEN_reso.^2,2)),1);
    end
    Pdata(Pdata_count).Type = TYPE;
    Pdata(Pdata_count).Branch = BranchPoint;
    Pdata_count = Pdata_count+ 1;
    clear Segment Y X Z c Go2Next Point4Len LEN_reso
end

%% Version Charly
% Find out Neighbor each BranchPoint
skel = OriginalBW;
siz = size(skel);
for n = 1:length(Pdata)
    if isempty(Pdata(n).PointXYZ)
        break
    end
    xyz = Pdata(n).PointXYZ;    
    ind = sub2ind(siz,xyz(:,2),xyz(:,1),xyz(:,3));
    skel(ind) = false;    
end

CC = bwconncomp(skel);
BPxyz = BPmatrix(:,1:3);
S = Segment_Functions;
NeighborLim = sqrt( sum( ( ([5 5 5]-1).*Reso).^2 , 2) );
for n = 1:CC.NumObjects
    ind = CC.PixelIdxList{n};
    [y,x,z] = ind2sub(siz,ind);
    xyz = cat(2,x(:),y(:),z(:));
    Nxyz = sort_xyz(xyz,Reso);
    FiBPxyz = BPxyz;
    lenmap = S.GetEachLength(Nxyz(1,:),FiBPxyz,Reso);
    [len1st,p] = min(lenmap);
    if ~isempty(p)
        p = p(1);
        s_xyz = FiBPxyz(p,:);
    else
        s_xyz = []; 
    end
    FiBPxyz(p,:) = [];
    lenmap = S.GetEachLength(Nxyz(end,:),FiBPxyz,Reso);
    [len2nd,p] = min(lenmap);
    if ~isempty(p)
        p = p(1);
        e_xyz = FiBPxyz(p,:);
    else
        e_xyz = [];
    end

    if NeighborLim > max(cat(1,len1st(:),len2nd(:)))
        AddSegment = cat(1,s_xyz,Nxyz,e_xyz);
        Pdata(Pdata_count).PointXYZ = AddSegment;
        Pdata(Pdata_count).Length = sum(S.xyz2plen(AddSegment,Reso));
        Pdata(Pdata_count).Type = 'Branch to Branch';
        Pdata(Pdata_count).Branch = cat(1,s_xyz,e_xyz);
        Pdata_count = Pdata_count+ 1;
    end
end



% % % NeighborLim = sqrt( sum( ( ([5 5 5]-1).*Reso).^2 , 2) );
% % % BPxyz = BPmatrix(:,1:3);
% % % S = Segment_Functions;
% % % xyz = BPxyz(1,1:3);
% % % BPxyz(1,:) = [];
% % % while ~isempty(BPxyz)
% % %     lenmap = S.GetEachLength(xyz,BPxyz,Reso);
% % %     p = find(lenmap <= NeighborLim);
% % %     if ~isempty(p)
% % %         for n = 1:length(p)
% % %             AddSegment = cat(1,xyz,BPxyz(p(n),:));
% % %             Pdata(Pdata_count).PointXYZ = AddSegment;
% % %             Pdata(Pdata_count).Length = lenmap(p(n));
% % %             Pdata(Pdata_count).Type = 'Branch to Branch';
% % %             Pdata(Pdata_count).Branch = AddSegment;
% % %             Pdata_count = Pdata_count+ 1;
% % %         end
% % %     end
% % %     xyz = BPxyz(1,1:3);
% % %     BPxyz(1,:) = [];    
% % % end

%% Delete empty 
try
Pdata(Pdata_count:end) = [];
catch
end

%% BP point infomation,[X Y Z Number Count]
Branch = cat(1,Pdata.Branch);
for n = 1:size(BPmatrix,1)
    p = BPmatrix(n,1:3);
    p = repmat(p,[size(Branch,1) 1]);
    Count = sum(sum(Branch==p,2)==3);
    BPmatrix(n,5) = Count;
end

Output.Pointdata = Pdata;
Output.BPmatrix = BPmatrix;
end

function Output = AutoSegment_Pre(bwthindata,varargin)
% Output = TS_AutoSegment1(skeleton_logicaldata,Resolution)
% 0. Pre Processing
% 1. End point to Branch or End Point
% 2. Branch to Branch Point
%  * Resolution need X:Y:Z = [1:1:1]!!!
% % 
narginchk(1,3)
Reso = ones(1,3);
AddBP = [];
% CutLen = 20;
if nargin > 1
    Reso = varargin{1};
end
if nargin > 2
    AddBP = varargin{2};
    if ~isempty(AddBP)
        AddBP = and(bwthindata,AddBP);
    end
end
% if nargin == 4
%     CutLen = varargin{3};
% end

tic
OriginalBW = bwthindata;
% Resi = sum(bwthindata(:));

% % PointXYZ is matrix, Type is 'End to Branch' or 'Branch to Branch'
Pdata(1:10000) = struct('PointXYZ',[],'Type',[],'Length',[],'Branch',[]); %  point--->[Y X Z]

%% Analysis Branch-point and End-point 
% disp('Analysis Branch-point and End-point ')

[BPcentroid,~,BPgroup,EndP] = TS_bwmorph3d(bwthindata,'branchpoint','none');

BPcentroid(AddBP) = true;
EndP(AddBP) = false;
 %% % term add . 2016.10.17
 BPgroup = or(BPcentroid,BPgroup);


%% main process
% disp('Analysis Branch-point and End-point ')
[bpy,bpx,bpz] = ind2sub(size(BPcentroid),find(BPcentroid(:)));
 % BP point infomation,[X Y Z Number Count]
 BPmatrix = cat(2,bpx,bpy,bpz,find(BPcentroid(:)),zeros(size(bpx))); 
 clear bpy bpx bpz

Output.Input = OriginalBW;
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
L_BPgroup = uint32(bwlabeln(BPcentroid,26));
L_BPgroup(BPgroup) = L_BPgroup(DistInd(BPgroup));
clear DistInd
bwthindata(BPcentroid) = false; %% bwthindata --->����čs���A�Ȃ��Ȃ�����I��
bwthindata(BPgroup) = false;

EndP = padarray(EndP,[1 1 1],0);
%% End point to a Branchpoint or a Endpoint
% disp('   ... 1st End point to a Branchpoint or a Endpoint')

Pdata= Output.Pointdata;
Reso = Output.ResolutionXYZ ;


[ey,ex,ez] = ind2sub(size(EndP),find(EndP(:)));
Pdata_count = 1;
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
    Segment = struct('point',[]);
    Segment(c).point = double([X Y Z]-1); %% padarray���Ă��邽��-1
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
            Segment(c).point = double([X Y Z]-1);
            clear Ind LEN Lnum BPCy BPCx BPCz BPC                        
            TYPE = 'End to Branch';
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
            Segment(c).point = double([X Y Z]-1);
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
            Segment(c).point = double([X Y Z]-1);
            clear Fyxz Ind LEN p Fy Fx Fz FindNearestBP Lnum BPGy BPGx BPGz BPG
            
            TYPE = 'End to Branch';
            BranchPoint = [X Y Z] - 1;
            Go2Next = false;
                       
        else
           if max(ROI(:))==0
            TYPE = 'End to End';
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
            Segment(c).point = double([X Y Z]-1);
            bwthindata(Y,X,Z) = false;
            if EndP(Y,X,Z)
                TYPE = 'End to End';
                Go2Next = false;
            else
                Go2Next = true;
            end
            clear Ind LEN Lnum Cy Cx Cz C
           end
        end
      end        
        clear leny lenx lenz lenp LEN Index
    end
    Point4Len = cat(1,Segment.point);
    Pdata(Pdata_count).PointXYZ = Point4Len;
    % % Lenght by bilinear
    if size(Point4Len,1) == 1
        Pdata(Pdata_count).Length = 0;
    else
        LEN_reso = diff(Point4Len,1) .* ...
            repmat(Reso,[size(Point4Len,1)-1 1]);
        Pdata(Pdata_count).Length = sum(sqrt(sum(LEN_reso.^2,2)),1);
    end
    Pdata(Pdata_count).Type = TYPE;
    Pdata(Pdata_count).Branch = BranchPoint;
    Pdata_count = Pdata_count+ 1;
    
    
    clear Segment Y X Z c Go2Next Point4Len LEN_reso
end
% disp(['End Point Num.:' num2str(n) ', Segment(bp-end) NUM.:' num2str(Pdata_count-1)])

Pdata(Pdata_count:end) = [];


Output.Pointdata = Pdata;
Output.BPmatrix = BPmatrix;
end


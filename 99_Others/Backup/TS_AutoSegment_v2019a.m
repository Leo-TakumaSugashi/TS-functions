function Output = TS_AutoSegment_v2019a(bwthindata,Reso,cutlen)
% Output = TS_AutoSegment1(skeleton_logicaldata,Resolution)
% 0. Pre Processing
% 1. End point to Branch or End Point
% 2. Branch to Branch Point
%  * Resolution need X:Y:Z = [1:1:1]!!!
% % 
% Editors log, 
% 2019,07,01, Create new function from TS_AutoSegment,,,,
SEGTIME = tic;
SEG = skel2SEG(bwthindata,Reso);
Output = Shaving(SEG,cutlen);
loopnum = 1;
TF = true;
while TF
    SEG = Output;
    Output = Shaving(SEG,cutlen);
    loopnum = loopnum + 1;
    if length(SEG.Pointdata) == length(Output.Pointdata)
        TF = false;
        loopnum = loopnum -1;
    end
end
Pdata = Output.Pointdata;
for n  = 1:length(Pdata)
    Pdata(n).ID = n;
end
Output.Pointdata = Pdata;
XYZ = cat(1,Pdata.PointXYZ);
siz = size(bwthindata);
Ind = sub2ind(siz,XYZ(:,2),XYZ(:,1),XYZ(:,3));
LastestBW = false(siz);
LastestBW(Ind) = true;
Output.loopNum = loopnum;
Output.Original = find(bwthindata(:));
Output.Output = find(LastestBW(:));
Output.Size = size(bwthindata);
fprintf(mfilename)
toc(SEGTIME)
fprintf('  !!\n')
end

function Output = skel2SEG(bwthindata,Reso)
AddBP = [];
% CutLen = 20;
if length(Reso) <3
    Reso(3) = 1;
end

tic
OriginalBW = bwthindata;
siz = ones(1,3);
for n = 1:3
    siz(n) = size(OriginalBW,n);
end
%% Analysis Branch-point and End-point 
disp('Analysis Branch-point and End-point ')
[BPcentroid,~,BPgroup,EndP] = TS_bwmorph3d_v2019a(bwthindata,'branchpoint','none');
%% % term add . 2016.10.17
BPgroup = or(BPcentroid,BPgroup);

%% xyz map
[Cy,Cx,Cz] = ind2sub(siz,find(BPcentroid(:)));
    C = cat(2,Cx(:),Cy(:),Cz(:));
[Gy,Gx,Gz] = ind2sub(siz,find(BPgroup(:)));
    G = cat(2,Gx(:),Gy(:),Gz(:));
[Ey,Ex,Ez] = ind2sub(siz,find(EndP(:)));
    E = cat(2,Ex(:),Ey(:),Ez(:));

%% main process
fprintf(mfilename)
PieaceWiseBW = bwthindata;
PieaceWiseBW(BPgroup) = false;
[L,NUM] = bwlabeln(PieaceWiseBW,26);
if NUM < (2^16)-1
    L = uint16(L);
elseif NUM < (2^32) -1
    L = uint32(L);
end
% % PointXYZ is matrix, Type is 'End to Branch' or 'Branch to Branch'
Pdata(1:NUM) = struct('PointXYZ',[],'Type',[],'Length',[],'Branch',[],'Delete',[]); %  point--->[Y X Z]
fprintf(['\n 1st Step. Finding Each Pint Line (' num2str(NUM) ')...'])
%% finding each pint line
parfor n = 1:NUM
    an = L == n;
    if sum(an(:)) == 1
        [ey,ex,ez] = ind2sub(siz,find(an(:)));
        XYZ = [ex(1), ey(1), ez(1)];
        Nowxyz = XYZ;
    else
        en = bwmorph3(an,'endpoint');    
        [ey,ex,ez] = ind2sub(siz,find(en(:)));
        XYZ = [ex(1), ey(1), ez(1)];
        Nowxyz = XYZ;
    end
    an(ey(1),ex(1),ez(1)) = false;
    [y,x,z] = ind2sub(siz,find(an(:)));
    ContinueTF = ~isempty(y);
    xyz = cat(2,x(:),y(:),z(:));
    while ContinueTF        
        lenval =  sum((xyz-Nowxyz).^2,2);
        [~,Ind] = min(lenval);
        Nowxyz = xyz(Ind(1),:);
        XYZ = cat(1,XYZ,Nowxyz);
        xyz(Ind(1),:) = [];
        if isempty(xyz)
            ContinueTF = false;
        end
    end
    Pdata(n).PointXYZ = XYZ;
end

%% Second Check for not exit in (L) but in BPgroup
XYZ = cat(1,Pdata.PointXYZ);
Ind = sub2ind(siz,XYZ(:,2),XYZ(:,1),XYZ(:,3));
Check2nd = BPgroup;
Check2nd(Ind) = false;
Check2nd(BPcentroid) = false;
[L,NUM] = bwlabeln(Check2nd,26);
FirstNUM = length(Pdata);
Pdata(end+NUM).PointXYZ = [];
fprintf(['\n 2nd. Step. Second Check for not exit in (L) but in BPgroup (' num2str(NUM) ')...'])
for n = 1:NUM
    an = L == n;
    [y,x,z] = ind2sub(siz,find(an(:)));
    xyz = cat(2,x(:),y(:),z(:));
    if numel(x)>1        
        p = mean(xyz,1);
        lenval = sum( (xyz-p).^2, 2 );
        [~,Ind] = min(lenval);
        XYZ = [x(Ind(1)), y(Ind(1)), z(Ind(1)),];
    else
        XYZ = [x, y, z];
    end
    Pdata(FirstNUM + n).PointXYZ = XYZ;
end



%% finding each pint line to End or Branch,
fprintf(['\n 3rd. Step. finding each pint line to End or Branch, (' num2str(length(Pdata)) ')...'])
S = Segment_Functions;
parfor n = 1:length(Pdata)
    Deletable = false;
    XYZ = Pdata(n).PointXYZ;
    %% check 1st point    
    xyz1 = XYZ(1,:);
    EndTFx = E(:,1) ==  xyz1(1);
    EndTFy = E(:,2) ==  xyz1(2);
    EndTFz = E(:,3) ==  xyz1(3);
    EndTF1  = max( and( and( EndTFx, EndTFy ), EndTFz ) );
    Branch = [];    
    if ~EndTF1
        lenval2G = sum((G-xyz1).^2,2);
        [~,Ind] = min(lenval2G);
        Nowxyz = G(Ind(1),:);
        XYZ = cat(1,Nowxyz,XYZ);
        CTFx = C(:,1) ==  Nowxyz(1);
        CTFy = C(:,2) ==  Nowxyz(2);
        CTFz = C(:,3) ==  Nowxyz(3);
        CTF = max( and( and( CTFx, CTFy ), CTFz ) );
        if CTF 
            
            Branch = cat(1,Branch,Nowxyz);
        else
            lenval2C = sum((C-Nowxyz).^2,2);
            [~,Ind] = min(lenval2C);
%             MinusC = Ind(1);
            Nowxyz = C(Ind(1),:);
            XYZ = cat(1,Nowxyz,XYZ);
            Branch = cat(1,Branch,Nowxyz);
        end
    end    
    %% check end point    
    xyz2 = XYZ(end,:);
    EndTFx = E(:,1) ==  xyz2(1);
    EndTFy = E(:,2) ==  xyz2(2);
    EndTFz = E(:,3) ==  xyz2(3);
    EndTF2  = max( and( and( EndTFx, EndTFy ), EndTFz ) );    
    if ~EndTF2
        CheckedC = C;        
        lenmap = S.GetEachLength(XYZ,CheckedC,Reso);
        lenmap = min(lenmap,[],2);
        CheckedC(lenmap==0,:) = Inf;
        
        CheckedG = G;        
        lenmap = S.GetEachLength(XYZ,CheckedG,Reso);
        lenmap = min(lenmap,[],2);
        CheckedG(lenmap==0,:) = Inf;
        
        lenval2G = sum((CheckedG-xyz2).^2,2);
        [~,Ind] = min(lenval2G);
        Nowxyz = CheckedG(Ind(1),:);
        XYZ = cat(1,XYZ,Nowxyz);
        CTFx = C(:,1) ==  Nowxyz(1);
        CTFy = C(:,2) ==  Nowxyz(2);
        CTFz = C(:,3) ==  Nowxyz(3);
        CTF = max( and( and( CTFx, CTFy ), CTFz ) );        
        if CTF 
            Branch = cat(1,Branch,Nowxyz);
        else            
            lenval2C = sum((CheckedC-Nowxyz).^2,2);
            [DistMin,Ind] = min(lenval2C);
            if sqrt(DistMin) > sqrt(3*2^2)
                Deletable = true;
            end
            Nowxyz = CheckedC(Ind(1),:);
            XYZ = cat(1,XYZ,Nowxyz);
            Branch = cat(1,Branch,Nowxyz);
        end
    end
    Pdata(n).PointXYZ = XYZ;
    %% check TYPE
    if sum(uint8([EndTF1,EndTF2])) == 2
        Pdata(n).Type = 'Branch to Branch';
    elseif sum(uint8([EndTF1,EndTF2])) == 1
        Pdata(n).Type = 'Branch to End';
    else
        Pdata(n).Type = 'End to End';
    end
    %% output
    Pdata(n).Branch = Branch;
    LEN_reso = diff(XYZ,[],1) .*Reso;
    Pdata(n).Length =  sum(sqrt(sum(LEN_reso.^2,2)),1);
    Pdata(n).Delete = Deletable;
end
Dtf = cat(1,Pdata.Delete);
Pdata(Dtf) = [];
Pdata = rmfield(Pdata,'Delete');
%% BP point infomation,[X Y Z Number Count]
fprintf('\n    Set up to Segment data.... ')

[bpy,bpx,bpz] = ind2sub(size(BPcentroid),find(BPcentroid(:)));
 % BP point infomation,[X Y Z Number Count]
BPmatrix = cat(2,bpx,bpy,bpz,find(BPcentroid(:)),zeros(size(bpx))); 
Branch = cat(1,Pdata.Branch);
for n = 1:size(BPmatrix,1)
    p = BPmatrix(n,1:3);
    p = repmat(p,[size(Branch,1) 1]);
    Count = sum(sum(Branch==p,2)==3);
    BPmatrix(n,5) = Count;
end

Output.Original = OriginalBW;
Output.AddBP = AddBP;
Output.Branch = BPcentroid;
Output.BranchGroup = BPgroup;
Output.End = EndP;
Output.Pointdata = Pdata;
Output.ResolutionXYZ = Reso;
Output.BPmatrix = BPmatrix;
Output.Output = [];
fprintf('\n')
end

function Output = Shaving(SEG,cutlen)
S = Segment_Functions;
S.Segment = SEG;
Reso = SEG.ResolutionXYZ;
Pdata = SEG.Pointdata;
Check1TF = false(1,length(Pdata));
parfor n = 1:length(Pdata)
    if strcmpi(Pdata(n).Type,'End to Branch')
        len = Pdata(n).Length;
        Check1TF(n) = len < cutlen;
    end
end
p = find(Check1TF);
Check2TF = false(size(Check1TF));
for n = 1:length(p)
    MyID = Pdata(p(n)).ID;
    MyLength = Pdata(p(n)).Length;
    Branch = Pdata(p(n)).Branch;
    xyz1e = Pdata(p(n)).PointXYZ([1 end],:);
    lenmap = S.GetEachLength(xyz1e,Branch,Reso);
    lenmap = min(lenmap,[],2);
    Branch = Branch(lenmap==0,:);
    IDs = S.FindID_xyz_edge(Branch);
    IDs(IDs==MyID) = [];
    ind = S.ID2Index(IDs);
    ind(isnan(ind)) = [];
    Lens = cat(1,Pdata(ind).Length);
    if ~isempty(Lens)
        Check2TF(p(n)) = max(Lens) > MyLength;
    end
end
Pdata(Check2TF) = [];
SEG.Pointdata = Pdata;
SEG.cutlen = cutlen;
S.Segment = SEG;
Output = S.ModifySEG;
end
function Output = TS_AutoSegment_v2019b(bwthindata,Reso,cutlen)
% Output = TS_AutoSegment1(skeleton_logicaldata,Resolution)
% 0. Pre Processing
% 1. End point to Branch or End Point
% 2. Branch to Branch Point
%  * Resolution need X:Y:Z = [1:1:1]!!!
% % 
% Editors log, 
% 2019,07,01, Create new function from TS_AutoSegment,,,,
SEGTIME = tic;

if cutlen > 0
	skel1 = bwthindata;
	SEG = skel2SEG(skel1,Reso,'shaving');
	skel2 = shavingSEG(SEG,cutlen);	
	loopnum = 1;
	TF = sum(skel1(:)) ~= sum(skel2(:));
	while TF
		skel1 = skel2;
		SEG = skel2SEG(skel2,Reso,'shaving');
		skel2 = shavingSEG(SEG,cutlen);		
		TF = sum(skel1(:)) ~= sum(skel2(:));
		if TF
			loopnum = loopnum + 1;
		end
	end
end
Output = skel2SEG(skel2,Reso,'all');
Pdata = Output.Pointdata;
for n  = 1:length(Pdata)
    Pdata(n).ID = n;
end
Output.Pointdata = Pdata;
% XYZ = cat(1,Pdata.PointXYZ);
% siz = size(bwthindata);
% Ind = sub2ind(siz,XYZ(:,2),XYZ(:,1),XYZ(:,3));
% LastestBW = false(siz);
% LastestBW(Ind) = true;
Output.loopNum = loopnum;
Output.Original = find(bwthindata(:));
Output.Output = find(skel2(:));
Output.Size = size(bwthindata);
fprintf(mfilename)
toc(SEGTIME)
fprintf('  !!\n')
end

function Output = skel2SEG(bwthindata,Reso,STEP)
% STEP = {'shaving', 'all'};

AddBP = [];
Output.Input = bwthindata;
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
if strcmpi(STEP,'all')	
	if NUM < (2^16)-1
		L = uint16(L);
	elseif NUM < (2^32) -1
		L = uint32(L);
	end
elseif strcmpi(STEP,'shaving')
	selectL = TS_GetSameValueSort( L(EndP) );
	LL = L;
    L = zeros(size(L),'like',uint16(1));
    for n = 1:length(selectL)
        L(LL==selectL(n)) = n;
    end
	NUM = length(selectL);
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

function Output_skel = shavingSEG(Segmentdata,Cutlen)
%     Input : [120x120x250 logical]
%            Branch: [120x120x250 logical]
%               End: [120x120x250 logical]
%         Pointdata: [1x437 struct]
%     ResolutionXYZ: [1.7878 1.7878 1.7878]
tic
%% Input
% Reso = Segmentdata.ResolutionXYZ; %% Resolution [X Y Z]
bwthindata = Segmentdata.Input;
% BPcentroid = Segmentdata.Branch;
% [bpy,bpx,bpz] = ind2sub(size(BP),find(BP(:)));
% EndP = Segmentdata.End;
Pdata = Segmentdata.Pointdata;
if isempty(Pdata) 
    Output_skel = bwthindata;
    return
end
BPmatrix = Segmentdata.BPmatrix;
% OriginalBW = bwthindata;

%% bwthindata --->

End2Branch = [];
Pdata(1).DeleteTF = [];
for n = 1:length(Pdata)
    switch Pdata(n).Type
        case {'End to Branch','End to End'}
            End2Branch = cat(1,End2Branch,Pdata(n).Branch);
            Pdata(n).DeleteTF = true;
        case 'Branch to Branch'
    end
end
% Branch = cat(1,Pdata.Branch);

End2Branch_NUM = zeros(size(BPmatrix,1),1);
%% Caliculate End 2 Branch point's count....
PadSiz = size(End2Branch,1) - 1;
for n = 1:size(BPmatrix,1)
    p = BPmatrix(n,1:3); % [ X Y Z ]
    p = padarray(p,[PadSiz 0],'symmetric','pre');
    End2Branch_NUM(n) = sum(sum(p==End2Branch,2)==3,1);
end
clear n PadSiz End2Branch


for n = 1:size(BPmatrix,1)
    NUM = End2Branch_NUM(n);
    if NUM<2
        continue
    else
        bp = BPmatrix(n,1:3);
        LEN = [];
        Ind = [];
        for n2 = 1:length(Pdata)
            switch Pdata(n2).Type
                case 'End to Branch'
                    if sum(Pdata(n2).Branch == bp)==3
                        Ind = cat(1,Ind,n2);
                        LEN = cat(1,LEN,Pdata(n2).Length);                        
                    end
            end
        end
        [~,MaxIndex] = max(LEN);
        if ~isempty(MaxIndex)
            Pdata(Ind(MaxIndex)).DeleteTF = false;
        end
    end
    clear bp NUM LEN Ind n2 MaxIndex
end


%% Delete
bwthindata = padarray(bwthindata,[1 1 1],false);
for n = 1:length(Pdata)
    switch Pdata(n).Type
        case 'End to End'
            if Cutlen<Pdata(n).Length
                continue
            end
            xyz = Pdata(n).PointXYZ + 1;
            bwthindata(xyz(:,2),xyz(:,1),xyz(:,3)) = false;
            clear xyz
        case 'End to Branch'
            if Cutlen<Pdata(n).Length
                continue
            end            
            if Pdata(n).DeleteTF
                xyz = Pdata(n).PointXYZ;
                for n2 = 1:size(xyz,1)
                    x = xyz(n2,1) + 1;
                    y = xyz(n2,2) + 1;
                    z = xyz(n2,3) + 1;
                    ROI = bwthindata(y-1:y+1,x-1:x+1,z-1:z+1);
                    [~,NUMpre] = bwlabeln(ROI,26);
%                     s = bwconncomp(ROI,26);
%                     NUMpre = s.NumObjects;
                    ROI(2,2,2) = false;
                    [~,NUMaft] = bwlabeln(ROI,26);
%                     s = bwconncomp(ROI,26);
%                     NUMaft = s.NumObjects;
                    %% Check Deletable or Not
                    if NUMpre==NUMaft
                        bwthindata(y,x,z) = false;
                    end
                    clear x y z ROI s NUMpre NUMaft
                end
                clear xyz
            end            
        case 'Branch to Branch'
    end
end

%% Re Skeletoning by TS_bwmoroph3d
Output_skel = TS_Skeleton3D_oldest(bwthindata(2:end-1,2:end-1,2:end-1));
end

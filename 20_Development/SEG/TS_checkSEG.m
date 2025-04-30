function SEG = TS_checkSEG(SEG)
% SEG = TS_check(SEG)
% This program is for SEGdate debugging only. The result of 
% TS_AutoSegment_vXXXX includes Pointdata (= Segment) that cannot share 
% the branch point. Created because there are other functions that do not
% work properly if they do not share the same branch point.
% 
% February 27, 2021. Sugashi,

obj = Segment_Functions;
obj.Segment = SEG;
obj = obj.Modify_BranchPointMatrix();


BPM = SEG.BPmatrix;
size(BPM)
BPcheck = obj.Segment.BPmatrix;
size(BPcheck)
% keyboard
%% main
    %% setting up
Find_Dist = sqrt(3)*3.2;
Reso = [1 1 1];

    %% BPcheck as that able or not to find nearest True BP.
% XYZc = BPcheck(:,1:3);
% BPM_Base = BPM;
% BPM_Base(:,5) = 0;
XYZ = BPM(:,1:3);
Base_Ind = nan(size(BPcheck,1),1);
TS_WaiteProgress(0)
for n = 1:length(Base_Ind)
    x = BPcheck(n,1);
    y = BPcheck(n,2);
    z = BPcheck(n,3);
    TFx = XYZ(:,1) ==x;
    TFy = XYZ(:,2) ==y;
    TFz = XYZ(:,3) ==z;
    TF = and(and(TFx,TFy),TFz);
    Ind = find(TF);
    if isempty(Ind)
        len = obj.GetEachLength([x,y,z],XYZ,Reso);
        [minLen,Ind] = min(len);
            
        if minLen > Find_Dist %% almost 
%             warning('Index of minimum length are over than Find_Dist.')
            Ind = nan;
        elseif length(Ind) > 1
            warning('Index of minimum length are exisst more than two.')
            BPM(Ind,1:3)
            keyboard
        end
%         if and(~isnan(Ind),isscalar(Ind))
%             BPM_Base(Ind,5) = BPM_Base(Ind,5)+1; %% for check BPmatrix
%         end
    elseif length(Ind)==1
        Ind = nan;
%         BPM_Base(Ind,5) = BPM_Base(Ind,5)+1;%% for check BPmatrix
    else
        warning('Same Point Exisiting.')
        keyboard
    end
    Base_Ind(n) = Ind;
    TS_WaiteProgress(n/length(Base_Ind))
end

try
%% Modified Re-Connect
ModXYZ = BPcheck(~isnan(Base_Ind),1:3);
Base_Ind = Base_Ind(~isnan(Base_Ind));
Pdata = obj.Segment.Pointdata;
CopyFields = {...
    'PointXYZ';
    'Signal';
    'Noise';
    'Theta';
    'Diameter';
    'LineRotDiameter';
    'NormDiameter';
    'EllipticDiameter';
    'NewXYZ';
    'NewXYZrot';
    'NewXYZnor';
    'NewXYZell';
    'OriginalPointXYZ';
    'NormThetaXY';
    'Fai_AngleFromAxisZ';
    'AnalysisShoudBeElliptic';
    'EuclidLength_Arteries';
    'EuclidLength_Veins';
    'EuclidLength_ArterioVenous'};
CopyData = {...
    'get';
    'get';
    'get';
    'get';
    'get';
    'get';
    nan;
    nan;
    'get';
    'get';
    'get';
    'get';
    'get';
    'get';
    nan;
    false;
    nan;
    nan;
    nan};
TS_WaiteProgress(0)
for n = 1:size(ModXYZ,1)
    xyz = ModXYZ(n,:);
    IDs = obj.FindID_xyz(xyz);
    for k = 1:length(IDs)
        ind = obj.ID2Index(IDs(k));
        PointXYZ = Pdata(ind).PointXYZ;
        len = obj.GetEachLength(xyz,PointXYZ([1 end],:),Reso);
        [~,vind] = min(len);
        Vert = vind == 1;
        
        target_xyz = BPM(Base_Ind(n),1:3);
        targetID = obj.FindID_xyz(target_xyz);
        if isempty(targetID)
            [targetID,tLen] = obj.FindID_xyz_nearest(target_xyz);
            if tLen > 1
                keyboard
            end
        end
        targetInd = obj.ID2Index(targetID(1)); %% no matter if length(ID)>2
        PointXYZ = Pdata(targetInd).PointXYZ;
        len = obj.GetEachLength(xyz,PointXYZ([1 end],:),Reso);
        [~,tind] = min(len);
        Ref = tind ==1;%% no matter if length(ind)>2
        
        for m = 1:length(CopyFields)
            if strcmp(CopyData{m},'get')
                data = Pdata(targetInd).(CopyFields{m});
                if Ref
                data = data(1,:);
                else
                    data = data(end,:);
                end
            else
                data = CopyData{m};
            end
            
            Origin = Pdata(ind).(CopyFields{m});
            if Vert
                data = cat(1,data,Origin);
            else
                data = cat(1,Origin,data);
            end
            Pdata(ind).(CopyFields{m}) = data;
        end
        
        %% Branch check
        bp = Pdata(ind).Branch;
        pxyz = Pdata(ind).PointXYZ([1 end],:);
        for bk = 1:size(bp,1)
            if max(isnan(bp(bk,:)))
                continue
            end
            bxyz = bp(bk,:);
            TFx = pxyz(:,1) == bxyz(1);
            TFy = pxyz(:,2) == bxyz(2);
            TFz = pxyz(:,3) == bxyz(3);
            if max(and(and(TFx,TFy),TFz))
            else
                len = obj.GetEachLength(bxyz,pxyz,Reso);
                [~,bind] = min(len);
                bp(bk,:) = pxyz(bind(1),:);
            end
        end
        Pdata(ind).Branch = bp;
        
        %% Length
        len = sum(obj.xyz2plen(Pdata(ind).PointXYZ,SEG.ResolutionXYZ));
        Pdata(ind).Length = len;        
    end
    TS_WaiteProgress(n/size(ModXYZ,1))
end
SEG.Pointdata = Pdata;
catch err
    keyboard
end



















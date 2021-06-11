function NewSEG = TS_ModifyDiameterAroundBranch(EditSEG)


Sf = Segment_Functions;
NewSEG = EditSEG;
Pdata = EditSEG.Pointdata;
Sf.Segment = EditSEG;

BPmatrix = Sf.Modify_BranchPointMatrix(EditSEG);
TF = BPmatrix(:,5)==1; %% Number 5 is count of branch. 1 is just end point.
BPmatrix = BPmatrix(~TF,:);
BP = BPmatrix(:,1:3);

%% modify Branch infomation
tic
for n = 1:length(Pdata)
    xyz = Pdata(n).PointXYZ;
    Branch = [];
    for k = 1:size(xyz,1)
        index = Sf.FindSameStartEndXYZ(xyz(k,:),BP);
        if sum(index)>0
            Branch = cat(1,Branch,BP(index,:));
        end
    end
    if isempty(Branch)
        Branch = nan(1,3);
    end
    Pdata(n).Branch = Branch;
end
clear n xyz Branch k index 
toc
%%
tic
SEGReso = EditSEG.ResolutionXYZ;
MinimumDiam = 2;
for n = 1:size(BPmatrix,1)
    
    xyz = BP(n,1:3);
    ID = Sf.FindID_xyz(xyz);
    if isempty(ID)
        keyboard
    end
    Index = Sf.ID2Index(ID);
    for k = 1:length(Index)
        TargetXYZ = Pdata(Index(k)).PointXYZ;
        TargetXYZ = Sf.InterpNaN(TargetXYZ);
        Pdata(Index(k)).PointXYZ = TargetXYZ;
        
        
        
        TarBranchInd = Sf.BranchInXYZ(xyz,TargetXYZ,SEGReso);
        TarBranch = TargetXYZ(TarBranchInd,:);
        if k==1
            Diameter = Pdata(Index(k)).Diameter(TarBranchInd,1);
        end
        [~,BranchInd] = Sf.BranchInXYZ(Pdata(Index(k)).Branch,TargetXYZ);
        DistanceFromBranch = Sf.GetEachLength(TarBranch,TargetXYZ,SEGReso);
        RadiusArea = DistanceFromBranch > Diameter/2;
        
        EnableDiameter = RadiusArea;
        EnableDiameter(BranchInd) = true;
        Pdata(Index(k)).Diameter_EnablePoint = EnableDiameter;
        Ddata = Pdata(Index(k)).Diameter;
        if isnan(Ddata(1))
            Ddata(1) = MinimumDiam;
        end
        if isnan(Ddata(end))
            Ddata(end) = MinimumDiam;
        end
        Ddata = Sf.InterpNaN(Ddata);
        xdata = Sf.xyz2plen(TargetXYZ,SEGReso);
        xdata = cumsum(xdata);
        Xin = xdata(EnableDiameter);
        Din = Ddata(EnableDiameter);
        Din(isnan(Din)) = MinimumDiam;
        try
            NewDdata = interp1(Xin,Din,xdata,'pchip');
        catch err
            keyboard
        end
        NewDdata = nanmin(NewDdata,Ddata);
        Pdata(Index(k)).Diameter = NewDdata;
    end
end
toc
%% output
NewSEG.Pointdata = Pdata;
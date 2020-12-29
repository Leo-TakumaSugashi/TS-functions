function DiamImage = TS_SEG2DiamAveImage(SEG)

Pdata = SEG.Pointdata;
Size = size(SEG.Output);
try
DiamImage = zeros(SEG.Size,'like',single(1));
catch err
    warning(err.message)
    DiamImage = zeros(Size,'like',single(1));
end

for n = 1:length(Pdata)
    D = Pdata(n).Diameter;
    Ind = Pdata(n).NoneBranchDiamInd;
    D = D(and(Ind,D>0));    
    Diam = nanmean(D);
    xyz = Pdata(n).PointXYZ;
    for k = 1:size(xyz,1)
        DiamImage(xyz(k,2),xyz(k,1),xyz(k,3)) = ...
            max([Diam DiamImage(xyz(k,2),xyz(k,1),xyz(k,3))]); %% Each Branch point...
    end
end
    





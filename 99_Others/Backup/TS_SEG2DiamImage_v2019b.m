function DiamImage = TS_SEG2DiamImage_v2019b(SEG)
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
    D = Pdata(n).Diameter;
%     Ind = Pdata(n).NoneBranchDiamInd;
%     D = D(and(Ind,D>0));    
%     Diam = nanmean(D);
    xyz = round(Pdata(n).PointXYZ);
    Index = sub2ind(Size,xyz(:,2),xyz(:,1),xyz(:,3));
    DiamImage(Index) = D;
%     for k = 1:size(xyz,1)
%         DiamImage(xyz(k,2),xyz(k,1),xyz(k,3)) = ...
%             max([Diam DiamImage(xyz(k,2),xyz(k,1),xyz(k,3))]); %% Each Branch point...
%     end
    TS_WaiteProgress(n/length(Pdata))
end
    





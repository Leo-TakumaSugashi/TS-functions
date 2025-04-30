function SEG_gliacheck = TS_Centroid2SEG_4MGAnalysis(s,Reso,siz)


S = Segment_Functions;
SEG = struct('Output',[],'AddBP',[],'Branch',[],...
    'BranchGroup',[],'End',[],...
    'Pointdata',[],'ResolutionXYZ',Reso,...
    'BPmatrix',[],'loopNum',[],...
    'cutlen',0,'Original',[]);
SEG.Size = siz(1:3);
slen = length(s);
SEG.BPmatrix = cat(2,cat(1,s.Centroid),zeros(slen,2));
Pdata(1:slen) = struct('PointXYZ',[]);
for n = 1:slen
    Pdata(n).PointXYZ = s(n).Centroid;
    Pdata(n).Length = 0;
    Pdata(n).Type = 'End to End';
    Pdata(n).Branch = [];
end
SEG.Pointdata = Pdata;
SEG_gliacheck = S.set_Segment(SEG);
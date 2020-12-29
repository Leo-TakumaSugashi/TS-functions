function SEG = TS_PenetResult2SEG(PR,DiamImage,Reso,skel)
% SEG = TS_PenetResult2SEG(PR,DiamImage,Reso,skel)
% This function is prototype,,,,
% you need check  segmentdata by your eyes.
% PR = reconstract of Penetodata
% DIamImage... Diameter of Image at skel point 
% Reso Resolution of X Y Z
% skel skeleton data (logciacl)

[L,NUM] = bwlabeln(PR);
count_1stTF = true;
for n = 1:NUM
    bw = L == n;
    D = DiamImage;
    D(~bw) = nan;
    s = skel;
    s(~bw) = false;
    [y,x,z] = ind2sub(size(skel),find(s(:)));
    xyz  = cat(2,y,x,z);
    if isempty(xyz)
        continue
    end
    D = D(s);
    seg = TS_xyztD2seg(xyz,D,Reso,s);
    if count_1stTF
        SEG = seg;
        count_1stTF = false;
    else
        SEG.Pointdata = cat(2,SEG.Pointdata,seg.Pointdata);
    end
    clear seg bw D s x y z xyz 
end


function SEG = TS_xyztD2seg(xyz,D,Reso,skel)
[parent,FPoint,dim,XYZ,D] = TS_xyzD2SEG_loop(xyz,D,Reso,[]);
SEG.Type = 'Penetrating';
SEG.Pointdata.PointXYZ = FPoint;
SEG.Pointdata.Parent = parent;
SEG.Pointdata.Type = 'Parent';
SEG.Pointdata.Length = sum(xyz2plen(FPoint,Reso));
SEG.Pointdata.Diameter = dim;
SEG.Pointdata.AverageDiameter = nanmean(dim(dim>0));
SEG.Original = skel;
SEG.ResolutionXYZ = Reso;

TF = ~isempty(D);
c = 2;
while TF
    [parent,Point,dim,XYZ,D] = TS_xyzD2SEG_loop(XYZ,D,Reso,FPoint);
    SEG.Pointdata(c).PointXYZ = Point;
    SEG.Pointdata(c).Parent = parent;
    SEG.Pointdata(c).Type = 'Children';
    SEG.Pointdata(c).Length = sum(xyz2plen(Point,Reso));
    SEG.Pointdata(c).Diameter = dim;
    SEG.Pointdata(c).AverageDiameter = nanmean(dim(dim>0));
    c = c + 1;
    TF = ~isempty(D);
end

function [parent,Point,dim,XYZ,D] = TS_xyzD2SEG_loop(xyz,D,Reso,First)
%% start position
% find most surface index 
if isempty(First)
    if isempty(xyz)
        parent = [];
        Point = [];
        dim = [];
        XYZ = [];
        D = [];
        return
    end
    z = xyz(:,3);
    [~,ind] = max(z);
    ind = ind(1);
    parent = xyz(ind,:);
else
    map = TS_EachLengthMap2(First,xyz,Reso);
    [~,ind] = min(min(map,[],2));
    ind = ind(end);
    fp = xyz(ind,:);
    len = TS_EachLengthMap2(fp,First,Reso);
    [~,pind] = min(len);
    parent = First(pind(1),:);
end
sp = xyz(ind,:);
diameter = D(ind);
dim = diameter;
D(ind) = [];


Point = sp;
XYZ = xyz;
XYZ(ind,:) = []; %% xyz --> delete

TF = true;

while TF
    len = TS_EachLengthMap2(sp,XYZ,Reso);
    
    [~,ind] = min(len);
    if isempty(ind)
            TF = false;
    else
        ind = ind(1);
        if diameter*2 < len(ind)
            TF = false;
        else
        sp = XYZ(ind,:);
        Point = cat(1,Point,sp);
        diameter = D(ind);
        dim = cat(1,dim,diameter);
        D(ind) = [];
        XYZ(ind,:) = [];
        end
    end
end
return

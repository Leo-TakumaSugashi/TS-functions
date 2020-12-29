function [NearestIndex,ActualMap,Len] = TS_FindNearestIndex(xyz1,xyz2,Reso,AssuranceLength)
% NearestIndex = TS_FindNearestIndex(xyz1,xyz2,Reso)
%  see also TS_EachLengthMap2
% xyz1 = Centroid(n).xyz
% xyz2 = Centroid(n+1).xyz

ActualMap = TS_EachLengthMap2(xyz1,xyz2,Reso);
Map = ActualMap;
Map(Map>AssuranceLength) = nan;
if sum(isnan(Map(:)))==numel(Map)
    NearestIndex = false(size(Map));
    Len = [];
    return
end
[~,Idx1] = nanmin(Map,[],1);
[~,Idx2] = nanmin(Map,[],2);
bw1 = false(size(Map));
bw2 = bw1;

for n = 1:length(Idx1)
    bw1(Idx1(n),n) = true;
end
for n = 1:length(Idx2)
    bw2(n,Idx2(n)) = true;
end

NearestIndex = and(bw1,bw2);

%% Index Length (2D)
[y,x] = find(NearestIndex);
Len = zeros(size(y));
xyz1(:,3) = 0;
xyz2(:,3) = 0;
Map = TS_EachLengthMap2(xyz1,xyz2,Reso);
for n = 1:length(y)
    Len(n) = Map(y(n),x(n));
end







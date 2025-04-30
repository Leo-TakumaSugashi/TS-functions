function  Distance = TS_SkelLine2Dist(skel)
x = squeeze(max(max(skel,[],3),[],1));
y = squeeze(max(max(skel,[],3),[],2));
z = squeeze(max(max(skel,[],2),[],1));
xind = find(x);
xind = xind(1) : xind(end);
yind = find(y);
yind = yind(1) : yind(end);
zind = find(z);
zind = zind(1) : zind(end);
skel = skel(yind,xind,zind);



[~,NUM6] = bwlabeln(skel,6);
[~,NUM18] = bwlabeln(skel,18);
% [~,NUM26] = bwlabeln(skel,26);
S = sum(skel(:))-1;
Ssqrt2 = (NUM6-NUM18);
Ssqrt3 = (NUM18 - 1);
S = S - Ssqrt2 - Ssqrt3;
Distance = S + Ssqrt2*sqrt(2) + Ssqrt3*sqrt(3);
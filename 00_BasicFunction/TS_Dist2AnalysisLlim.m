function [Dist,L_index] = TS_Dist2AnalysisLlim(D)
% [Dist,AnalysisLim] = TS_Dist2AnalysisLlim(Mask);
  %%%%%%%%%%%%%% Voronoi Area
pD1 = padarray(D,ones(1,3),true);
pD0 = padarray(false(size(D)),ones(1,3),true);
[Dist,Index] = bwdist(pD1);

L_index = false(size(pD1));
L_index(:) = pD0(Index);
L_index = L_index(2:end-1,2:end-1,2:end-1);
Dist = Dist(2:end-1,2:end-1,2:end-1);

Dist(L_index) = nan;
L_index = ~L_index;
% TS_3dslider(Dist)




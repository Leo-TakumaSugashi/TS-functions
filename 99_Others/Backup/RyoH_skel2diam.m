function [DiamImage07,PointNumber07] = RyoH_skel2diam(SKEL,X)
% [DiamImage07,PointNumber07] = RyoH_skel2diam(SKEL,X)
%     Input:
%         SKLE:×ü‰»
%         X:DimaImage
% Ž©“®’ÇÕ
% edit at Nov.15th.2016

[~,Ind] = bwdist(SKEL);
PointNumber07 = zeros(size(SKEL),'LIKE',single(1));
DiamImage07 = zeros(size(SKEL),'LIKE',single(1));
[y,x,z] = ind2sub(size(SKEL),find(SKEL(:)));
% X = Rdata(2).Image(:,:,:,:,2);
Diam = zeros(size(x));
N = zeros(size(x));
parfor n = 1:length(x)
    ind_n = Ind(y(n),x(n),z(n));
    ind = Ind == ind_n;
    d = X(ind);
    d(d == 0) = [];
    Diam(n,1) = nanmedian(d);
    N(n,1) = sum(d(:) > 0);
%     DiamImage07(y(n),x(n),z(n)) = Diam;
end

for n = 1:length(x)
    DiamImage07(y(n),x(n),z(n)) = Diam(n);
    PointNumber07(y(n),x(n),z(n)) = N(n);
end
end

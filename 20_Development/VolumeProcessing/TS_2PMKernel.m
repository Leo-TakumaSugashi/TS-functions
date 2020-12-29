function f = TS_2PMKernel


f = zeros(65,65,27);

r = (size(f,1)-1)/2;
DepthCenter = (size(f,3)-1)/2;
DimR = false(size(f,1));
DimR(r+1,r+1) = true;
DimR = bwdist(DimR);
R = linspace(r,1,DepthCenter);
Weight = linspace(0.1,1,DepthCenter);
for n = 1:DepthCenter
    f(:,:,n) = double(DimR <= R(n)) * Weight(n);
end
% f = double(f);
f = f / sum(f(:));
f = flip(f,3);


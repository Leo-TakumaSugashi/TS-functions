function [NormTheta,P,Newxyz] = TS_xyz2Norm(xyz,RefLen,varargin)
% [NormTheta,Pasu] = TS_xyz2Norm(xyx,RefLen)
% input 
%     xy(z) ; xyz index, 
%     RefLen  ; %% 中心を含む周囲何点で法線角度（Orientation)を決めるか？
%           2の場合　-2 -1 0 +1 +2 の5点
% 
% output
%     NormTheta
%     ...  pasu = mean((diff(y)) / mean(diff(x))
%          output = atan(pasu)..



pnum = 1:size(xyz,1);

NormTheta = zeros(size(xyz,1),1);
P = NormTheta;
Newxyz = [];
for n = 1:length(NormTheta)
    ind = and(pnum >= n - RefLen, pnum <= n + RefLen);
    x = xyz(ind,1);
    y = xyz(ind,2);
    pasu = mean(diff(y)) / mean(diff(x));
    theta = atan(pasu);
    
    P(n) = pasu;
    NormTheta(n) = tan(theta + pi/2);
    
%     
%     pasu = NormTheta(n);
%     x = xyz(n,1);
%     y = xyz(n,2);
%     z = xyz(n,3);
%     b = y - pasu * x;
%     A = 1 + pasu^2;
%     B = -x + pasu * b - pasu* y;
%     C = RefLen^2 - x^2 + 2* b * y - y^2;
%     x1 = real(-(B/A) + sqrt(C/A + B/(A^2)));
%     x2 = real(-(B/A) - sqrt(C/A + B/(A^2)));
%     y1 = pasu * x1 + b;
%     y2 = pasu * x2 + b;
%     Newxyz(n,:,1) = [x1 y1 z] - 1;
%     Newxyz(n,:,2) = [x2 y2 z] - 1;
    
    
end

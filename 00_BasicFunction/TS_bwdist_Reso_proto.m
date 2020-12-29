function [Dist,Idx] = TS_bwdist_Reso_proto(bw,Reso)
% This Func. is prototype...

Rbw = TS_EqualReso3d_parfor(bw,Reso,min(Reso));
[Dist,Idx] = bwdist(Rbw);

% Original_Indx = reshape(1:numel(bw),size(bw));
% R_Indx = TS_imresize3d(Original_Indx,size(Rbw),'nearest');
% Idx = R_Indx(Idx);

Dist = TS_imresize3d(Dist,size(bw),'nearest');
% Idx = TS_imresize3d(Idx,size(bw),'nearest');

if nargout==2
xgv = linspace(1,size(bw,2),size(Rbw,2));
ygv = linspace(1,size(bw,1),size(Rbw,1));
zgv = linspace(1,size(bw,3),size(Rbw,3));

[X,Y,Z] = meshgrid(xgv,ygv,zgv);

X = X(Idx);
Y = Y(Idx);
Z = Z(Idx);
X = round(TS_imresize3d(X,size(bw),'nearest'));
Y = round(TS_imresize3d(Y,size(bw),'nearest'));
Z = round(TS_imresize3d(Z,size(bw),'nearest'));
Idx = sub2ind(size(bw),X(:),Y(:),Z(:));
end


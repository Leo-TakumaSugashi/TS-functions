function pdata = TS_ReCalNewPoint(Input_struct)
%% Initialize
LEN = Input_struct.Len;
% xyim = zeros(size(skel_SP,1),size(skel_SP,2));
% Center = [30,30];
% [vp,theta] = TS_GetLinePro2Matrix(xyim,Center,LEN,NewReso(1));
CenP = round(LEN/2);
Rmatrix = @(x) [cosd(x), -sind(x); sind(x) , cosd(x)];
THETA = Input_struct.theta;
%%
pdata = Input_struct.Pointdata;
Max_xyz = double(max(cat(1,pdata.XYZ),[],1));
Min_xyz = double(min(cat(1,pdata.XYZ),[],1));
parfor n = 1:length(pdata);
xyzP = pdata(n).XYZ;
NowTheta = round(pdata(n).Theta *180 /pi);
R = Rmatrix(NowTheta);
ThetaInd = THETA == pdata(n).Theta;
x1 = mean(pdata(n).FWHM(ThetaInd,:) - CenP);
if isnan(x1)
    x1 = 0;
end
y1 = 0;
xy0 = R*[x1;y1];
x0 = xyzP(1) +  xy0(1);
y0 = xyzP(2) +  xy0(2);
z0 = xyzP(3);
NewP = [x0 y0 z0];
NewP = max(Min_xyz,NewP);
NewP = min(Max_xyz,NewP);
pdata(n).NewXYZ = NewP;
end








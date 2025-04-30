function NormTheta = xyz2normaltheta(xyz,Reso)

Dxy = diff(xyz(:,1:2),1,1); %% just plane-xy
xlen = (Dxy(1:end-1,1) + Dxy(2:end,1))*Reso(1);
ylen = (Dxy(1:end-1,2) + Dxy(2:end,2))*Reso(2);
Len = sqrt(xlen.^2 + ylen.^2);
Theta = acosd(xlen./Len);
NormTheta = padarray(Theta + 90,[1 0],'symmetric');
function [Xq,Yq,Zq,outReso] = TS_meshFor3DReplaceActualLength_proto(...
    Image,Reso,outsiz,ShiftData,Loose)
% [Xq,Yq,Zq,outReso] = TS_meshFor3DReplaceActualLength(insiz,Reso,outsiz,ShiftData,Loose)
% insiz(1,:) {mustBeNumeric,mustBeGreaterThan(Resolution,0)}
% Resolution(1,3) {mustBeNumeric,mustBeGreaterThan(Resolution,0)} % [Y, X, Z]
% outsiz(1,:) {mustBeReal,"length(outsiz)==length(insiz)"}
% %% SliceMove
% ShiftData.X(1,1) {mustBeReal}
% ShiftData.Y(1,1) {mustBeReal}
% ShiftData.Z(1,1) {mustBeReal}
% %% Rotate
% ShiftData.Rho(1,1) {mustBeReal}   % XY-Plane
% ShiftData.Yaw(1,1) {mustBeReal}   % XZ-Plane
% ShiftData.Pitch(1,1) {mustBeReal} % YZ-Plane

insiz = size(Image);
FOV = (insiz-1) .* Reso;
outReso = FOV ./ (outsiz-1) ;



%% set up default size
%% SliceMove    
% % xdata = linspace(0,FOV(2),outsiz(2));
% % ydata = linspace(0,FOV(1),outsiz(1));
% % zdata = linspace(0,FOV(3),outsiz(3));
% % % to Pixel Index 
% % XData = xdata / Reso(2) + 1;
% % YData = ydata / Reso(1) + 1;
% % ZData = zdata / Reso(3) + 1;
XData = linspace(0,FOV(2),outsiz(2));
YData = linspace(0,FOV(1),outsiz(1));
ZData = linspace(0,FOV(3),outsiz(3));

[Xq,Yq,Zq] = meshgrid(XData,YData,ZData);
Center = [median(XData) median(YData) median(ZData)]';
X = reshape(Xq,1,[]) - Center(1);
Y = reshape(Yq,1,[]) - Center(2);
Z = reshape(Zq,1,[]) - Center(3);


%% Rotate
rho = pi/6;
Rho = [ cos(rho),  sin(rho), 0.000000, 0.000000;
       -sin(rho),  cos(rho), 0.000000, 0.000000;
        0.000000,  0.000000, 1.000000, 0.000000;
        0.000000,  0.000000, 0.000000, 1.000000];
yaw = pi/6;
Yaw = [ cos(yaw),  0.000000, -sin(yaw), 0.000000;
        0.000000,  1.000000,  0.000000, 0.000000;
        sin(yaw),  0.000000,  cos(yaw), 0.000000;
        0.000000,  0.000000,  0.000000, 1.000000];
pit = pi/6;
Pit = [ 1.000000,  0.000000,  0.000000, 0.000000;
        0.000000,  cos(pit),  sin(pit), 0.000000;
        0.000000, -sin(pit),  cos(pit), 0.000000;        
        0.000000,  0.000000,  0.000000, 1.000000];

% tform = affine3d(Rho * Yaw * Pit);
invT = inv(Pit)*inv(Yaw)*inv(Rho);
invT = invT(1:3,1:3);
%% NewXYZ = T * XYZ;
XYZ = invT * cat(1,X,Y,Z);
    
%% output
Xq = reshape(XYZ(1,:),size(Xq)) + Center(1);
Yq = reshape(XYZ(2,:),size(Xq)) + Center(2);
Zq = reshape(XYZ(3,:),size(Xq)) + Center(3);

Xq = Xq / Reso(2) + 1;
Yq = Yq / Reso(1) + 1;
Zq = Zq / Reso(3) + 1;

V = interp3(single(Image),Xq,Yq,Zq);
figure,imagesc(max(V,[],3)),axis image,impixelinfo

















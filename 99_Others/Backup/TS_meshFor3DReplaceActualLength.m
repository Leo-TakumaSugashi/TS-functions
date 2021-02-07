function [Xq,Yq,Zq,outReso] = TS_meshFor3DReplaceActualLength(...
    insiz,Reso,outsiz,ShiftData,varargin)
% [Xq,Yq,Zq,outReso] = TS_meshFor3DReplaceActualLength(insiz,Resolution,outsiz,ShiftData)
% [Xq,Yq,Zq,outReso] = TS_meshFor3DReplaceActualLength(insiz,Resolution,outsiz,ShiftData,Center)
%###################input value ###########################################
% 1. insiz(1,:)         {mustBeNumeric,mustBeGreaterThan(Resolution,0)}
% 2. Resolution(1,3)    {mustBeNumeric,mustBeGreaterThan(Resolution,0)} % [Y, X, Z]
% 3. outsiz(1,:)        {mustBeReal,"length(outsiz)==length(insiz)"}
% 4. SiftData(1,6)      {mustBeReal} [Rho Yaw Pitch X Y Z]
% 5. Center(1,3 )       {mustBeReal} default is center of FOV
% 
% %% Rotate
% ShiftData.Rho(1,1) {mustBeReal}   % XY-Plane 0-360
% ShiftData.Yaw(1,1) {mustBeReal}   % XZ-Plane 0-360
% ShiftData.Pitch(1,1) {mustBeReal} % YZ-Plane 0-360
% %% SliceMove
% ShiftData.X(1,1) {mustBeReal}
% ShiftData.Y(1,1) {mustBeReal}
% ShiftData.Z(1,1) {mustBeReal}

FOV = (insiz-1) .* Reso;
outReso = FOV ./ (outsiz-1) ;
%% set up default size
XData = linspace(0,FOV(2),outsiz(2));
YData = linspace(0,FOV(1),outsiz(1));
ZData = linspace(0,FOV(3),outsiz(3));

[Xq,Yq,Zq] = meshgrid(XData,YData,ZData);
if nargin == 5
    Center = varargin{1}';
else
    Center = [median(XData) median(YData) median(ZData)]';
end
X = reshape(Xq,1,[]) - Center(1);
Y = reshape(Yq,1,[]) - Center(2);
Z = reshape(Zq,1,[]) - Center(3);


%% Rotate
rho = ShiftData(1) * (pi/180);
Rho = [ cos(rho),  sin(rho), 0.000000, ;
       -sin(rho),  cos(rho), 0.000000, ;
        0.000000,  0.000000, 1.000000, ];
yaw = ShiftData(2) * (pi/180);
Yaw = [ cos(yaw),  0.000000, -sin(yaw), ;
        0.000000,  1.000000,  0.000000, ;
        sin(yaw),  0.000000,  cos(yaw), ];
pit = ShiftData(3) * (pi/180);
Pit = [ 1.000000,  0.000000,  0.000000, ;
        0.000000,  cos(pit),  sin(pit), ;
        0.000000, -sin(pit),  cos(pit), ];
invT = inv(Pit)*inv(Yaw)*inv(Rho);
%% NewXYZ = T * XYZ;
XYZ = invT * cat(1,X,Y,Z);
%% SliceMove    
Xq = reshape(XYZ(1,:),size(Xq)) + Center(1) - ShiftData(4);
Yq = reshape(XYZ(2,:),size(Xq)) + Center(2) - ShiftData(5);
Zq = reshape(XYZ(3,:),size(Xq)) + Center(3) - ShiftData(6);

%% output
Xq = Xq / Reso(2) + 1;
Yq = Yq / Reso(1) + 1;
Zq = Zq / Reso(3) + 1;


















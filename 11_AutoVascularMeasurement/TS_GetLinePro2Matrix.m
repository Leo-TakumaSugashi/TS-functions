function [vpmatrix,theta,CropImage,CropBW] = TS_GetLinePro2Matrix(im,Center,Length,Reso,varargin)
%% Edit 15th Sep. 2016
% [vpmatrix,theta,CropImage,CropBW] = TS_GetLinePro2Matrix(im,Center,Length,Reso,varargin)
% Original TS_GetLineProfileTheta_v2...
% Center = [X Y]
% Length =  um / unit
% Reso = [xy]; %% Resolution(XY), Scalar

Step_rotation = pi/(180);
Max_rotation = pi - Step_rotation;
Length = round(Length / Reso); %% um --> pixels
Type_interp = 'linear';

%% Add CropImage
xind = 1:size(im,2);
yind = 1:size(im,1);
xind = and(xind>=Center(1)-Length/2,xind<=Center(1)+Length/2);
yind = and(yind>=Center(2)-Length/2,yind<=Center(2)+Length/2);
cim = double(im);
bwim = false(size(im));
bwim(round(Center(2)),round(Center(1))) = true;
bwim = bwdist(bwim)<Length/2;
cim(~bwim) = nan;
CropImage = cim(yind,xind);
CropBW = bwim(yind,xind);

%% Main Function
% theta = flip(0:Step_rotation:Max_rotation,2);
theta = 0:Step_rotation:Max_rotation;
n = 1;
[xp,yp] = GetIndex(Center,theta(n),Length);
vp = interp2(double(im),xp,yp,Type_interp);
vpmatrix = zeros(length(vp),length(theta));
vpmatrix(:,n) = vp;
% vpmatrix = zeros(Length+1,length(theta));
for n = 2:length(theta)
    [xp,yp] = GetIndex(Center,theta(n),Length);
    vp = interp2(double(im),xp,yp,Type_interp);
    vpmatrix(:,n) = vp;
end

%% GetIndex
function [xp,yp] = GetIndex(Center,theta,Length) 
fx1 = @(x,theta,Length) cos(pi+theta)*Length/2+x;
fx2 = @(x,theta,Length) cos(theta)*Length/2+x;
fy1 = @(x,theta,Length) sin(pi+theta)*Length/2+x;
fy2 = @(x,theta,Length) sin(theta)*Length/2+x;

x1 = fx1(Center(1),theta,Length);
x2 = fx2(Center(1),theta,Length);
y1 = fy1(Center(2),theta,Length);
y2 = fy2(Center(2),theta,Length);

RadNum =  ceil(Length/2);
pnum = RadNum * 2 + 1;

if (x2-x1) == 0
%     xp = ones(1,Length+1) * x1;
    xp = ones(1,pnum) * x1;
else
%     xp = x1:(x2-x1)/Length:x2;
    %     xp = x1:(x2-x1)/Length:x2;
    xp1 = flip(linspace(Center(1),x1,RadNum+1) ,2);
    xp2 = linspace(Center(1)+abs(diff(xp1(1:2))),x2,RadNum) ;
    xp = cat(2,xp1,xp2);
end

if (y2-y1) == 0
%     yp = ones(1,Length+1) * y1;
    yp = ones(1,pnum) * y1;
else
%     yp = y1:(y2-y1)/Length:y2;
    yp1 = flip(linspace(Center(2),y1,RadNum+1) ,2);
    yp2 = linspace(Center(2)+abs(diff(yp1(1:2))),y2,RadNum) ;
    yp = cat(2,yp1,yp2);
end
end

end

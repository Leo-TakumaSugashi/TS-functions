function [vp,xp,yp] = TS_GetLineProfileTheta(im,Center,theta,Length,Reso,varargin)
% [vp,xp,yp] = TS_GetLineProfileTheta(im,Center,theta,Length,Reso,varargin)
% Center = [X Y]
% Length =  [um];
% Reso = XY; %% Resolution[X==Y] um/Pixels

%% Method of interp2 
Method = 'linear';

%% Check Input image
im = squeeze(im);
if ~ismatrix(im)
    error('Input is NOR matrix image')
end
       
%% Main Function
[xp,yp] = GetIndex(Center,theta,Length,Reso);
vp = interp2(double(im),xp,yp,Method);

end


%% GetIndex
function [xp,yp] = GetIndex(Center,theta,Length,Reso) %% unit pixels
fx1 = @(x,theta,Length,Reso) cosd(180+theta)*Length/Reso(1)/2+x;
fx2 = @(x,theta,Length,Reso) cosd(theta)*Length/Reso(1)/2+x;
fy1 = @(x,theta,Length,Reso) sind(180+theta)*Length/Reso(2)/2+x;
fy2 = @(x,theta,Length,Reso) sind(theta)*Length/Reso(2)/2+x;

x1 = fx1(Center(1),theta,Length,Reso);
x2 = fx2(Center(1),theta,Length,Reso);
y1 = fy1(Center(2),theta,Length,Reso);
y2 = fy2(Center(2),theta,Length,Reso);

RadNum =  ceil(Length/2);
pnum = RadNum * 2 + 1;

if (x2-x1) == 0
    xp = ones(1,pnum) * x1;
else
%     xp = x1:(x2-x1)/Length:x2;
    xp1 = flip(linspace(Center(1),x1,RadNum+1) ,2);
    xp2 = linspace(Center(1)+abs(diff(xp1(1:2))),x2,RadNum) ;
    xp = cat(2,xp1,xp2);
end

if (y2-y1) == 0
    yp = ones(1,pnum) * y1;
else
    yp1 = flip(linspace(Center(2),y1,RadNum+1) ,2);
    yp2 = linspace(Center(2)+abs(diff(yp1(1:2))),y2,RadNum) ;
    yp = cat(2,yp1,yp2);
%     yp1 = flip(Center(2) : -(y2-y1)/Length : y1 ,2);
%     yp2 =      Center(2) :  (y2-y1)/Length : y2 ;
%     yp = cat(2,yp1,yp2(2:end));
end
end


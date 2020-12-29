function [Xp,Yp,theta] = TS_GetLinePro2mesh(im,Center,Length,Reso,varargin)
%% Edit 11th jun. 2019
%  [Xp,Yp,theta] = TS_GetLinePro2mesh(im,Center,Length,Reso,varargin)
% Original TS_GetLineProfileTheta_v2...
% Center = [X Y]
% Length =  um / unit
% Reso = [xy]; %% Resolution(XY), Scalar
% varargin{1} = theta
% 
% edit varargin input type to theta, 
% 2019 11 13


%% check input
if nargin == 5
    theta = varargin{1};
else    
    Step_rotation = pi/(180);
    Max_rotation = pi - Step_rotation;
    theta = 0:Step_rotation:Max_rotation;
end
if length(Reso)>1
    if Reso(1) ~=Reso(2)
        error('Input Resolution of X and Y is NOT Equal....')
    end
    Reso = Reso(1);
end


%% initilize
Length = round(Length / Reso); %% um --> pixels
Type_interp = 'linear';

%% Main Function
% theta = flip(0:Step_rotation:Max_rotation,2);

n = 1;
[xp,yp] = GetIndex(Center,theta(n),Length);
vp = interp2(double(im),xp,yp,Type_interp);
% vpmatrix = zeros(length(vp),length(theta));
Xp = zeros(length(vp),length(theta));
  Xp(:,n) = xp;
Yp = zeros(length(vp),length(theta));
  Yp(:,n) = yp;

% vpmatrix(:,n) = vp;

for n = 2:length(theta)
    [xp,yp] = GetIndex(Center,theta(n),Length);
    Xp(:,n) = xp;
    Yp(:,n) = yp;
end
% vpmatrix = interp2(double(im),Xp,Yp,Type_interp);

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

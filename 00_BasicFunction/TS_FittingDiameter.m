function [MinDiameter,Theta] = TS_FittingDiameter(DiffFWHM,theta,Range)
% [MinDiameter,Theta] = TS_FittingDiameter(DiffFWHM,theta,Range)
%  input 
%    diffFWHM : length(DiffFWHM) == length(theta)
%    theta    : Theta (rad.)
%    Range    : Input of Minimum Theta as DiffFHWM +/- Range 
% 
%   output
%     MinDiameter = f(1) * (f(3)/f(1) - (f(2)/(2*f(1))).^2);
%     Theta = -f(2)/(2*f(1));

% edit by sugashi, 2016.12.21
[~,MININD] = min(DiffFWHM);
MINtheta = theta(MININD);
if isempty(MININD)
    MinDiameter = [];
    Theta = [];
    return
end

Bin = diff(theta(1:2));
RepTheta = [-theta(end)-Bin: Bin : -Bin theta theta(end)+Bin:Bin:2*theta(end)+Bin];
RepFWHM = repmat(DiffFWHM(:),[3 1]);


bwind = and(RepTheta>=MINtheta-Range,RepTheta<=MINtheta+Range);

x = RepTheta(bwind);
y = RepFWHM(bwind);
% figure,plot(x,y)
f = polyfit(x(:),y(:),2);
% vx = linspace(x(1),x(end),length(x)*Magni);
% vy = polyval(f,vx);

% vy = f(1)*vx.^2 + f(2)*vx + f(3);
% hold on,plot(vx,vy)
MinDiameter = f(1) * (f(3)/f(1) - (f(2)/(2*f(1))).^2);
Theta = -f(2)/(2*f(1));


 %% check figure
%  whos RepTheta RepFWHM
% figure,plot(RepTheta,RepFWHM)
% hold on
% plot(MINtheta,DiffFWHM(MININD),'r*')
% plot(x,polyval(f,x),'k')
% plot(Theta,MinDiameter,'k+')

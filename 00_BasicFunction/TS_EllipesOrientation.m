function [vx,vy] = TS_EllipesOrientation(s)
% Input s...
%    s = regionprops(bw,'MinorAxisLength','MajorAxisLength','Centroid','Orientation')

theta = 0:360;

% funy = @(theta,c,Minor) Minor/2*sind(theta)+c(2);
% funx = @(theta,c,Major) Major/2*cosd(theta)+c(1);
funy = @(theta,Minor) Minor/2*sind(theta);
funx = @(theta,Major) Major/2*cosd(theta);

% x = funx(theta,s.Centroid,s.MajorAxisLength);
% y = funy(theta,s.Centroid,s.MinorAxisLength);
x = funx(theta,s.MajorAxisLength);
y = funy(theta,s.MinorAxisLength);

phi = -s.Orientation;
centroid = s.Centroid;
vx = x*cosd(phi) - y*sind(phi) + centroid(1);
vy = x*sind(phi) + y*cosd(phi) + centroid(2);
function linemask = TH_CreateStartMask_v170412(siz,p1,p2)
% center = [x y]  © s,—ñ‚Å‚Í‚È‚¢
% dim.Poiintdata.XYZ = [x y z];  © —ñ, s, [‚³, ‚Ì‡
% dim = str.Pointdata().XYZ


% mfilename('fullpath')

% p1,2 = [y1 x1], [y2 x2];
% siz = size(image);
% linemask = zeros(siz,'logical');
linemask = false(siz);
c = cat(1,p1,p2);
dist = diff(c,1,1);
dist = ceil(sqrt(sum(dist.^2,2)));
xdata = round(linspace(p1(1),p2(1),dist));
ydata = round(linspace(p1(2),p2(2),dist));
Ind = sub2ind(siz,ydata,xdata);
linemask(Ind) = true;
return

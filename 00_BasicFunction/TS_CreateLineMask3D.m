function linemask = TS_CreateLineMask3D(siz,p1,p2)
% 
% input ;
%     siz : output size
%     p1  : point1 ([x y (z)])
%     p2  ; point2 ([x y (z)]
% 
% see also TH_CreateStartMask
if numel(siz) == 2
    siz(3) = 1;
    p1(3) = 1;
    p2(3) = 1;
end


linemask = false(siz);
c = cat(1,p1,p2);
dist = diff(c,1,1);
dist = ceil(sqrt(sum(dist.^2,2)));
xdata = round(linspace(p1(1),p2(1),dist));
ydata = round(linspace(p1(2),p2(2),dist));
zdata = round(linspace(p1(3),p2(3),dist));

Ind = sub2ind(siz,ydata,xdata,zdata);
linemask(Ind) = true;
linemask = TS_checkDeletabelPoint(linemask,xdata,ydata,zdata);
return

function A = TS_checkDeletabelPoint(bw,x,y,z)
% [y,x,z] = ind2sub(size(bw),find(bw(:)));
xdata = 1:size(bw,2);
ydata = 1:size(bw,1);
zdata = 1:size(bw,3);


for n = 1:length(y)
    ix = and(xdata>=x(n) -1, xdata<=x(n)+1);
    iy = and(ydata>=y(n) -1, ydata<=y(n)+1);
    iz = and(zdata>=z(n) -1, zdata<=z(n)+1);
    ROI = bw(iy,ix,iz);
    bw(y(n),x(n),z(n)) = ~checkROI(ROI);
end
A = bw;

function tf = checkROI(ROI)
if sum(ROI(:)) <=2
    tf = false;
    return
end
[~,NUMpre] = bwlabeln(ROI);
ROI(2,2,2) = false;
[~,NUMaft] = bwlabeln(ROI);
tf = NUMpre == NUMaft;





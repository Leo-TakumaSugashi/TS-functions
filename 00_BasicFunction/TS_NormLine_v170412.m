function [LineMask,NewMask] = TS_NormLine_v170412(StartPosition,dim,skel,Reso)

% load('dist_Temp')
% keyboard
% whos NewSeg Reso Seg dim thnmask vesselmask
% TS_SEGview(NewSeg)

% n = 1;

% StartPosition = NewSeg.Pointdata(n).Start;
% StartPosition = [93 111];
Diam = dim(StartPosition(1),StartPosition(2));

% xyz = NewSeg.Pointdata(n).PointXYZ;
% siz = size(NewSeg.Original);
siz = size(dim);
% Ind = sub2ind(siz(1:2),xyz(:,2),xyz(:,1));
% skel = false(siz);
% skel(Ind) = true;
% Reso = NewSeg.ResolutionXYZ(1);
StartBW = false(siz);
StartBW(StartPosition(1),StartPosition(2)) = true;
Original_skel_dist = TS_ErosionImage(StartBW,skel,Diam/Reso(1)*2);
skel_dist = Original_skel_dist * Reso(1);
Range_skel = skel_dist < Diam/2;
if sum(Range_skel(:)) < 2
    Range_skel = Original_skel_dist <= 5;
end
% figure,imagesc(Range_skel)
[y,x] = find(Range_skel);
pasu = mean(diff(y)) / mean(diff(x));
theta = atan(pasu);
pasu = tan(theta + pi/2); %% rot pi/2
if abs(pasu) > siz(1)/2
    pasu = sign(pasu) * Inf;
end
if abs(pasu) < 2 / siz(2) 
    pasu = 0;
end
if isnan(pasu)
    whos 
    error('check')
end

Bb = StartPosition(1) - pasu*StartPosition(2);
Fun = @(pasu,Bb,x) pasu.*x + Bb;
xdata = 1:siz(2);
ydata = 1:siz(1);
LineMask = [];
if abs(pasu) < 1/siz(2)
    Yp = repmat(StartPosition(1),[1 siz(2)]);
    Xp = xdata;
elseif abs(pasu) > siz(1) %% Num/ 0 == nan, %isinf(abs(pasu))    
    Yp = ydata;
    Xp = repmat(StartPosition(2),[1 siz(1)]);
else
%     px = round([1 (1-Bb)/pasu (siz(1)-Bb)/pasu siz(2)]);
    if pasu<0
        if and(pasu + Bb >=1,pasu+Bb <=siz(1))
            sx = 1;
        else
            sx = ( (siz(1) - Bb)/pasu );
        end
        ex = (min([( ( 1 - Bb)/pasu ) siz(2)]));
    else
        if and(pasu + Bb >=1,pasu+Bb <=siz(1))
            sx = 1;
        else
            sx = ( ( 1 - Bb)/pasu );
        end
        ex = (min([( ( siz(1) - Bb)/pasu ) siz(2)]));
    end
    
    
    sy = round(Fun(pasu,Bb,sx));
    sx = floor(sx);
    ey = round(Fun(pasu,Bb,ex));
    ex = ceil(ex);
    fgh = figure('visible','on');
    axh = axes;
    imagesc(dim)
    h = imline(axh,[sx sy;ex ey]);
    LineMask = createMask(h);
    close(fgh)
%     
%     Dist = sqrt((sx - ex).^2 + (sy - ey).^2);    
%     xdata = linspace(sx,ex,ceil(Dist));
%     Yp = (Fun(pasu,Bb,xdata));
%     Yp = max(Yp,1);
%     Yp = min(Yp,siz(1));
%     Xp = (xdata);
end

if isempty(LineMask)
LineMask = false(siz);
Ind = sub2ind(siz,round(Yp),round(Xp));
LineMask(Ind) = true;
end

M = dim(Range_skel)/Reso(1);
MeanDiam = nanmean(M(M>0));
NewMask = bwdist(Range_skel) <= MeanDiam/2;

% for n = 1:length(Xp)
%     LineMask(round(Yp(n)),round(Xp(n))) =1;
% end


% figure,imagesc(cat(3,skel,LineMask,false(siz)))
% figure,imagesc(LineMask)

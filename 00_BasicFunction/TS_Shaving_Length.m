function A = TS_Shaving_Length(skel,LenVal)

narginchk(2,2)
if nargin==3
    LenVal = DistVal;
end
skel = padarray(skel,ones(1,3));
BPold = imfilter(uint8(skel),ones(3,3,3)).*uint8(skel) >3;
End = TS_bwmorph3d_parfor(skel,'Endpoint');
L = bwlabeln(and(skel,~BPold),26);
End2nd = TS_bwmorph3d_parfor(L>0,'Endpoint');
End2nd = and(End2nd,~End);
Ind = L(End);
LenInd = length(Ind);
wh = waitbar(0,'wait');
%% Finding Deletable point
for n = 1:LenInd
    PW = L == Ind(n);
    bp2end = and(End2nd,PW);    
    if ~max(bp2end(:))==0
        bp = and(BPold,imdilate(bp2end,ones(3,3,3)));
        if max(bp(:)) == 1
        [x,y,z] = FindNearest(bp2end,bp);
        ROI = and(~PW,skel);
        ROI = ROI(y-1:y+1,x-1:x+1,z-1:z+1);
        [~,NUM1] = bwlabeln(ROI);
        ROI(2,2,2) = false;
        [~,NUM2] = bwlabeln(ROI);
        if NUM1==NUM2
            PW(y,x,z) = true;
        end
        end
    end
    LenDistance = TS_SkelLine2Dist(PW);    
    if LenDistance<=LenVal
        skel(PW) = false;
    end
    waitbar(n/LenInd,wh,['Wait... ' num2str(n) '/' num2str(LenInd)])
end
%% finish
close(wh)
A = skel(2:end-1,2:end-1,2:end-1);
end

function [x,y,z] = FindNearest(a,b)
    [y1,x1,z1] = ind2sub(size(a),find(a(:)));
    [y2,x2,z2] = ind2sub(size(a),find(b(:)));
    xyz1 = repmat([x1 y1 z1],[length(y2) 1]);
    xyz2 = cat(2,x2,y2,z2);
    try
    Len =  sum((xyz1 - xyz2).^2,2);
    catch
        whos
        error('nonnnn')
    end
    [~,MinInd] = min(Len);
    y = y2(MinInd);
    x = x2(MinInd);
    z = z2(MinInd);
%     A = false(size(a));
%     A(y,x,z) = 1;
end
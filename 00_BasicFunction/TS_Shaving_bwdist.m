function A = TS_Shaving_bwdist(skel,bw)

narginchk(2,2)
skel = padarray(skel,ones(1,3));
bw = padarray(bw,ones(1,3));
BWD = bwdist(~bw);
BPold = imfilter(uint8(skel),ones(3,3,3)).*uint8(skel) >3;
End = TS_bwmorph3d(skel,'Endpoint');
[L,NUM] = bwlabeln(and(skel,~BPold),26);
if NUM<2^8
    L = uint8(L);
elseif NUM<2^16
    L = uint16(L);
elseif NUM<2^32
    L = uint32(L);
end
End2nd = TS_bwmorph3d(L>0,'Endpoint');
End2nd = and(End2nd,~End);
Ind = L(End);
LenInd = length(Ind);
wh = waitbar(0,'Wait... Now, Analysis Deletable Point...');
%% Finding Deletable point
data(1:LenInd) = struct('Index',[]);
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
    pl = BWD(PW);
    DIFF = max(pl) - min(pl);
    if DIFF ==0
        continue
    end    
    PW = DistArea(PW,DIFF,and(PW,End));
    data(n).Index = find(PW(:));
    waitbar(n/LenInd,wh,['Wait...  Now, Analysis Deletable Point...' ...
        num2str(n) '/' num2str(LenInd)])
end
%% finish
waitbar(0,wh,['Wait... 0/' num2str(LenInd)])
for n = 1:LenInd
    skel(data(n).Index) = false;
    waitbar(n/LenInd,wh,['Wait... ' num2str(n) '/' num2str(LenInd)])
end
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

function A = DistArea(PW,DIFF,Endp)
x =squeeze( max(max(PW,[],1),[],3));
y =squeeze( max(max(PW,[],2),[],3));
z =squeeze( max(max(PW,[],1),[],2));
pw = PW(y,x,z);
endp = Endp(y,x,z);
d = bwdist(endp) <=DIFF;
pw = and(pw,d);
L = bwlabeln(pw);
Ind = L(endp);
pw = false(size(pw));
for n = 1:length(Ind)
    pw = or(pw,L==Ind(n));
end
A = false(size(PW));
A(y,x,z) = pw;
end
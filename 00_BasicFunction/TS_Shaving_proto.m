function A = TS_Shaving_proto(skel,bw,DistVal,LenVal)

narginchk(3,4)
if nargin==3
    LenVal = DistVal;
end
% BWD = padarray(bw,ones(1,3));
skel = padarray(skel,ones(1,3));
% BWD = bwdist(~BWD);
% BWD = BWD.*single(skel);
% BWD = imfilter(BWD,ones(3,3,3)/27);
% BWD = BWD(2:end-1,2:end-1,2:end-1);
BPold = imfilter(uint8(skel),ones(3,3,3)).*uint8(skel) >3;
End = TS_bwmorph3d_parfor(skel,'Endpoint');
L = bwlabeln(and(skel,~BPold),26);
End2nd = TS_bwmorph3d_parfor(L>0,'Endpoint');
End2nd = and(End2nd,~End);
% DeletabelP = zeros(size(skel));
Ind = L(End);
LenInd = length(Ind);
wh = waitbar(0,'wait');
% figure,
%% Finding Deletable point
LEN = zeros(size(Ind));
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
%     pL = BWD(PW);    
%     pL = pL - min(pL);
%     plot(n,max(pL),'s')
%     pL = sort(BWD(PW));
%     plot(linspace(0,1,length(pL)),pL);
%     if n == 1
%        hold on 
%     end
tic
    LenDistance = TS_SkelLine2Dist(PW);    
    toc
    LEN(n) = LenDistance;
%     if and(max(pL) <=DistVal,LenDistance<=LenVal)
    if LenDistance<=LenVal
        skel(PW) = false;
%         DeletabelP(PW) = n;
    end
    waitbar(n/LenInd,wh,['Wait... ' num2str(n) '/' num2str(LenInd)])
end
% %% DeletePoint
% waitbar(0,wh,'2nd Step');
% % if 2 more DeletabelP is Nearest 26, and, Minior Length is Delete
% [L2,NUM] = bwlabeln(DeletabelP>0);
% 
% figure,
% for n = 1:NUM
%     PW = L2 == n;
%     checkNUM = DeletabelP(PW);
%     plot(linspace(0,1,length(checkNUM)),checkNUM);
%     if n==1
%         hold on
%     end
%     [h,x] = hist(checkNUM,0:max(checkNUM));
%     ind = x(h>0);
%     if length(ind)<2
%         disp([num2str(n) '  continue'])
%         continue
%     else
%         [~,Res] = max(LEN(ind));
%         ind(Res) = [];
%         for dn = 1:length(ind)
%             skel(DeletabelP==ind(dn)) = fales;
%         end        
%     end
%     waitbar(n/NUM,wh,['Wait... ' num2str(n) '/' num2str(NUM)])
% end
% skel(DeletabelP>0) = false;
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
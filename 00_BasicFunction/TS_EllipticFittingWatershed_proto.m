function outbw = TS_EllipticFittingWatershed_proto(bw,Objsiz,Reso)
% outbw = TS_EllipticFittingWatershed_proto(bw,Objsiz,Reso)
% bw  elliptic fitting image(logical)
% Objsiz : um
% Reso :resolution um/pix
% *** Reso = Reso(1);
% *** Objsiz = Objsiz(1);

if ~islogical(bw)
    error('input is not Logical data')
end

Reso = Reso(1);
Objsiz = Objsiz(1);
open_se = strel('disk',round(Objsiz/Reso/2),0);
open_bw = imopen(bw,open_se);
if sum(open_bw(:))==0
    outbw = bw;
    return
end
D = bwdist(~open_bw);
D = -D;
D(~open_bw) = -Inf;
if  min(D(open_bw))<-Objsiz/Reso/2
    D(open_bw) = max(D(open_bw),-Objsiz/Reso/2);
end
L = watershed(D) - 1;

s = regionprops(L,'Area');
s = cat(1,s.Area);
[~,Ind] = max(s);
% if isempty(Ind)
%     outbw = L;
% else
try
outbw = L == Ind;
catch err
%     disp([' warrning... '  mfilename])
%     disp(err.message)
    outbw = bw;
    return
end
% se = logical([0 1 0; 1 1 1; 0 1 0]);
se = true(3);
outbw = imdilate(outbw,se);
end
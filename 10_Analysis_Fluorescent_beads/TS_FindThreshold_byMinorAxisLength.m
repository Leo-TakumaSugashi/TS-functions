function [CorrectedTh,Th,Diameters] = ...
    TS_FindThreshold_byMinorAxisLength(...
    Nim,ResoXY,ActualSize)

Th = 0.3:0.001:0.8;
Th = Th';
Diameters = nan(length(Th),1);
parfor n = 1:length(Th)
    bw = Nim >= Th(n);
    if max(bw(:)) ==false
        continue
    end
    s = regionprops(bw,'Area','MinorAxisLength');    
    Area = cat(1,s.Area);
    [~,Ind] = max(Area);    
    Diameters(n) = s(Ind(1)).MinorAxisLength;
end
Diameters = Diameters*ResoXY;
CheckDiam = abs(Diameters - ActualSize);
[~,MiniInd] = min(CheckDiam);
CorrectedTh = Th(MiniInd(1));

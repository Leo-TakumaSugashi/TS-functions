function data = TS_SegmentLength(BW,PA,PV)
% Original Function 
% data = TS_SegmentWithVideo(BW,PA,PV)
% at \\TS-QVHL1D2\usbdisk3\Sugashi\00_OldHDD_Backup\0005tudy\2012MI\MeetingFile20121116

PA = and(BW,PA);
PV = and(BW,PV);
BW = CheckVessel(or(PA,PV),BW);
PAbw = CheckVessel(PA,(BW-PV)>0);
PVbw = CheckVessel(PV,(BW-PA)>0);
dataPA = PA;
dataPV = PV;
TF = true;
c = 0;
while TF
    newPA = and(imdilate(PA,ones(3,3,3)),PAbw);
    k = dataPA > 0;
    dataPA = dataPA + k + newPA;
    PA = (newPA - PA)~=0;
    PAbw = (PAbw - newPA) > 0;
    clear newPA
    c = c + 1;
    TF = max(PAbw(:));
    if c > 255
        TF = false;
    end
end
data.PA = dataPA;
c = 0;
TF = true;
while TF
    newPV = and(imdilate(PV,ones(3,3,3)),PVbw);
    k = dataPV > 0;
    dataPV = dataPV + k + newPV;
    PV = (newPV - PV)~=0;
    PVbw = (PVbw - newPV) > 0;
    clear newPV
    c = c + 1;
    TF = max(PVbw(:));
    if c > 255
        TF = false;
    end
end
data.PV = dataPV;


% % % % data = double(BW);
% % % OriginalBW = BW;
% % % TF = true;
% % % PA = and(PA,BW);
% % % PV = and(PV,BW);
% % % data = -PV + PA;  %% ‰Šú’l
% % % BW = (BW - PA - PV)>0;
% % % BW = CheckVessel(or(PA,PV),BW);
% % % 
% % % BW = (BW - PV)>0;
% % % % data = BW;return
% % % c = 0;
% % % while TF
% % %     DistPA = bwdist(logical(PA));    
% % %     DistPV = bwdist(logical(PV));
% % %     PAnew = and(DistPA<=SSize,BW);
% % %     PAnew = CheckVessel(PA,PAnew);
% % %     data = data + PAnew;    
% % %     BW = (BW - PAnew)>0;
% % %     PA = (PAnew-PA)>0;
% % %     if c == 0
% % %         BW = (BW + PV)>0;
% % %     end
% % % %     PVnew = and(DistPV<=SSize,BW);
% % % %     PV = CheckVessel(PV,PVnew);clear PVnew
% % % %     data = data - PV;
% % % %     BW = (BW - PV)>0;
% % % %     TF = max(BW(:));
% % %     c = c + 1;
% % %     if c > 10
% % %         TF = false;
% % %     end
% % % end
% % % bw = and(OriginalBW,data>=0);
% % % data(bw) = data(bw) +1;

function A = CheckVessel(Bef,Aft)
L = uint16(bwlabeln(or(Bef,Aft),26));
h = L(Bef);
A = false(size(L));
if isempty(h)
    return
end
h = [h(1); (find(diff(h)>0)+1)];
for n = 1:length(h)
    A = or(A,L==h(n));
end



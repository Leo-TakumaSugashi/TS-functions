function [SEG,loopNum] = TS_SEGloop(skel,NewReso,BP,Cutlen,Fname)
narginchk(5,5)
tic
disp(TS_ClockDisp)
TIMEstr = num2str(clock);
TIMEstr(TIMEstr==' ') = '';
dp = find(TIMEstr=='.');
TIMEstr(dp:end) = [];
if isstruct(skel)
    SEG = TS_AutoSegment2nd_New20161022(skel,Cutlen);
else
    SEG = TS_AutoSegment1st_New20161021(skel,NewReso,BP);    
    try
    saveas(gcf,['SEG1_' Fname '_' TIMEstr '.fig'])
    catch err
        disp(err)
    end
    SEG = TS_AutoSegment2nd_New20161022(SEG,Cutlen);
end
Num = length(SEG.Pointdata);
loopNum = 2;
while Num~=0
    try
    saveas(gcf,['SEG_'  Fname '_' num2str(loopNum)  '_' TIMEstr '.fig'])
    close(gcf)
    catch err
        disp(err)
    end
    loopNum = loopNum + 1;
    Numpre = length(SEG.Pointdata);
    SEG = TS_AutoSegment2nd_New20161022(SEG,Cutlen);
    save(['SEG_'  Fname '_' num2str(loopNum) '_' TIMEstr '.mat'],'SEG')
    Num = Numpre - length(SEG.Pointdata);
    toc
     disp(TS_ClockDisp)
end
loopNum = loopNum -1;
toc
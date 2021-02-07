function SEG = TS_AutoSegment_loop(skel,NewReso,AddBP,cutlen)
% SEG = TS_AutoSegment_loop(skel,NewReso,AddBP,cutlen)


skel1 = skel;
if isempty(AddBP)
    AddBP = false(size(skel));
end
lnum = 1;
if cutlen > 0
    SEG = TS_AutoSegment_Pre(skel1,NewReso,AddBP);
    skel2 = AtSEG_shaving(SEG,cutlen);
    
    while sum(skel1(:)) ~= sum(skel2(:))
        disp(['  Now Shaving... loop No. ' num2str(lnum)])
        skel1 = SEG.Input;
        SEG = TS_AutoSegment_Pre(skel2,NewReso,AddBP);
        skel2 = AtSEG_shaving(SEG,cutlen);
        lnum = lnum + 1;
    end
    clear skel2
    % AddBP = false(size(skel));
    % SEG = TS_AutoSegment1st_New20161021(skel1,NewReso,AddBP);
end
SEG = TS_AutoSegment(skel1,NewReso,AddBP);
SEG.loopNum = lnum;
SEG.cutlen = cutlen;
SEG.Original = skel;


    
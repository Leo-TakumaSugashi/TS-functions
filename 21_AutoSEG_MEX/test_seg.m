
load TESTSEG.mat skel NewReso
AddBP = false(size(skel));
SEG = AutoSegment(skel,NewReso,AddBP,20);
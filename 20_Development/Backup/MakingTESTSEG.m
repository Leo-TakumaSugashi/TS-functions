load('TESTIMAGE.mat')
[RImage,NewReso] = TS_EqualReso3d_parfor(Image,Reso,2.5);
Th = 30;
bw = RImage > Th;
skel = Skeleton3D(bw);
SEG = TS_AutoSegment_loop(skel,NewReso,[],20);

save TESTSEG.mat RImage NewReso Th bw skel SEG
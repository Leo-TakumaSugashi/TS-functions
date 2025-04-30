a = false(100,100,100);
a(25,25,25) = true;
a(end-54,end-54,end-54) = true;
bw = bwdist(a)<25;
tic
skel= TS_Skeleton3D_mex(bw);
toc
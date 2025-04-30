function A = TS_Skeleton2D_proto(bw)

bw = padarray(bw,[1 1],0);

D = bwdist(~bw);

pks = TS_findpeaks2(D);

bw_mask = false(size(bw));
bw_mask(2:end-1,2:end-1) = true;

D45 = imrotate(D,45);
mask45 = imrotate(bw_mask,45);
pks45 = TS_findpeaks2(D45);
pks45 = imrotate(pks45,-45);
mask45 = imrotate(mask45,-45);
xdata = max(mask45,[],1);
ydata = max(mask45,[],2);
pks45 = pks45(ydata,xdata);

A.pks = pks;
A.pks45 = pks45;
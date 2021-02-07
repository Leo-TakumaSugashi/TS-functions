function skel = TS_Skeleton_mex(bw)
if ~islogical(bw)
    error('input data is not logical')
end
tt = tic;
skel = TS_Skeleton3D_mex(bw);
toc(tt);
xdata = (0:202)*NewReso(1);
ydata = (0:202)*NewReso(2);
zdata = (0:size(SKEL,3)+1)*NewReso(3) -30;

se = false(3,3,3);
se(2,2,2) = true;
se = bwdist(se)<=1;
fv = isosurface(xdata,ydata,zdata,...
    padarray(imdilate(flip(SKEL,3),se),ones(1,3)),0,...
    padarray(imdilate(flip(SNRImage,3),ones(3,3,3)),ones(1,3)));
figure,
pah = patch(fv,'EdgeColor','none');
 pah.FaceColor = 'interp'; 
 view(3),daspect(ones(1,3))
 xlim([0 204]),ylim([0 204]),zlim([-30 490]),
 set(gca,'Ydir','reverse','zdir','reverse')
 reducepatch(pah,0.2)
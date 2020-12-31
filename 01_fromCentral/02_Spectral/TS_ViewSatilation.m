function TS_ViewSatilation(Fname)
figure('Position',[100 30 1200 900]),
axh(1) = axes('Position',[0.01 .51 .45 .45]);
axh(2) = axes('Position',[0.01 .01 .45 .45]);
axh(3) = axes('Position',[0.51 .51 .45 .45]);
axh(4) = axes('Position',[0.51 .01 .45 .45]);
v = VideoReader(Fname);
% while hasFrame(v)
Frame1 = readFrame(v);
HSV = rgb2hsv(Frame1);
% figure,imagesc(HSV(:,:,1)),colormap(gray(256)),axis image
% title('Hue')
% colormap(interp2([1 0 0;0 1 0; 0 0 1;1 0 0],1:3,linspace(1,4,255)'))

imagesc(axh(1),Frame1),
axis(axh(1),'image')
axis(axh(1),'off')
title(axh(1),['Original / ' Fname],'FontName','MS UI Gothic')

S = HSV(:,:,2);
% nnn = TS_GetBackgroundValue(S);
% S = max(S- nnn,0);
% S = S ./max(S(:));
imagesc(axh(2),S),
axis(axh(2),'image')
axis(axh(2),'off')
title(axh(2),'Satilation')


V = HSV(:,:,3);
V = abs(V -1);
V = zscore(V);
nnn = TS_GetBackgroundValue(V);
V = max(V- nnn,0);
% V = V - min(V(:));
V = V ./max(V(:));
imagesc(axh(3),V),axis image off
title(axh(3),'(Zscore - Invers(Value) - Back Ground')
axis(axh(3),'image')
axis(axh(3),'off')


Red = max(V,S);
% Red = HSV(:,:,2).* ( abs(HSV(:,:,3)*-1) + 0);
% Red = HSV(:,:,1);
% Red = HSV(:,:,1) -0.1;
% Red(Red<0) = Red(Red<0) + 1;
imagesc(axh(4),Red), axis image off
title(axh(4),'max(Satilation, Value)')
axis(axh(4),'image')
axis(axh(4),'off')

colormap(gray(256)),
drawnow
end

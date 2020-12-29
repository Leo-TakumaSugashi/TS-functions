close all
gim = TS_GaussianFilt3D(WholeImage_MG30,Reso,[3 3 5]);
fgh = figure(...
    'Toolbar','none','Menubar','none');
fgh.Position = [5 5 1068 1048];
axes('Position',[0 0 1 1]);
imh = imagesc(gim(:,:,end));
axis image off
colormap(gray(256))
n = size(gim,3);
while true
    imh.CData = gim(:,:,n);
    drawnow
    pause(.05)
    n = n -1;
    if n ==0
        n = size(gim,3);
    end
end
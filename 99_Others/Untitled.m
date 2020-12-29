clc
load('TESTSEG.mat','Image');
fgh = uifigure('Position',[10 10 1024 1024]);
axh = axes(fgh,'Position',[0 0 1 1]);
daspect(axh,[1 1 1])
axis(axh,'off')
imh = imagesc(axh,max(Image,[],3));
centerfig(fgh);
for n = 1:100
    fprintf(['\n\n   loop Num. : ' num2str(n) '\n'])
    TS_WaiteProgress(0)
    for k = 1:size(Image,3)
        imh.CData = Image(:,:,k);
        drawnow
        TS_WaiteProgress(k/size(Image,3))    
    end
end
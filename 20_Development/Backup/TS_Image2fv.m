
function varargout = TS_Image2fv(fImage,Reso)

% reset(gpuDevice);
Image = single(fImage);
Image = Image - min(Image(:));
Image = Image / max(Image(:));
Th = graythresh(Image(:));
% Image = gpuArray(Image);
xdata = 1:size(Image,2);
ydata = 1:size(Image,1);
zdata = 1:size(Image,3);

xdata = (xdata -1) * Reso(1);
ydata = (ydata -1 ) * Reso(2);
zdata = (zdata -1 ) * Reso(3);
fv = isosurface(xdata,ydata,zdata,Image,Th);

if nargout == 1;
    varargout{1} = fv;
    return
end

p = patch(fv);
p.EdgeColor = 'none';
p.FaceColor = [1 .5 0];
p.FaceAlpha = 0.2;

view(3)
daspect(ones(1,3))
set(gca,'ydir','reverse')
cmh = camlight;
box on
axis tight
grid on

varargout{1} = p;
varargout{2} = cmh;
varargout{3} = fv;
function outdata = TS_InterpDepth_AftDepthAdjGUI(data,Meth)


Image2 = data.Image2;

vy = data.vy;

%% Inerpolation Axis depth 
Image2 = permute(Image2,[1 3 2 4 5]);
siz2 = size(Image2);
Image2 = reshape(Image2,size(Image2,1),size(Image2,2),[]);
[interp_X,interp_Y] = meshgrid(vy,1:siz2(1));
outImage = zeros(size(Image2,1),...
    length(vy),...
    size(Image2,3),...
    'like',Image2);
for n = 1:size(Image2,3)
    im = Image2(:,:,n);
    vim = interp2(double(im),interp_X,interp_Y,Meth);
    outImage(:,:,n) = feval(class(Image2),vim);
end
siz2(2) = length(vy);
outImage = reshape(outImage,siz2);
outImage = ipermute(outImage,[1 3 2 4 5]);
data.Interp_Depth_Image2 = outImage;
data.Interp_Method = Meth;

outdata = data;
function TS_TiffWrite(im,Name)
% if you got error with "imwrite(im,Name.tif)"
% try use this function...
% 
% edit by Sugashi, 2019.11.26

t = Tiff(Name,'w');

T.ImageLength = size(im,1);
T.ImageWidth = size(im,2);
T.Photometric = Tiff.Photometric.RGB;
T.BitsPerSample = 8;
T.SamplesPerPixel = 3;
Tiff.PlanarConfiguration.Chunky;
T.PlanarConfiguration = 1;
T.Software = 'MATLAB';
setTag(t,T);
write(t,im);
close(t);
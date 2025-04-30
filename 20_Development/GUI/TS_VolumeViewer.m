function TS_VolumeViewer(data,Reso)
% TS_VolumeViewer(data,Reso)
fgh = figure;
ph = uipanel('parent',fgh);
vh = volshow(data,'Parent',ph);
vh.ScaleFactors = Reso;
vh.BackgroundColor = [0 0 0];
Alpha = atan(linspace(-pi,pi,256));
Alpha = Alpha - min(Alpha);
Alpha = Alpha ./max(Alpha);
vh.Alphamap = (Alpha.^0.8)';







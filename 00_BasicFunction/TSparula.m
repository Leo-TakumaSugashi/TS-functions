function A = TSparula(varargin)

hsvmap = rgb2hsv(parula(varargin{:}));
siz = size(hsvmap,1);
% hsvmap(:,3) = log10(linspace(0,1,siz)*9+1);
hsvmap(:,3) = linspace(0,1,siz);
A = hsv2rgb(hsvmap);
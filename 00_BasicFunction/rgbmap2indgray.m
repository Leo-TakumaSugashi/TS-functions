function A = rgbmap2indgray(map,varargin)
if nargin ==1
    IndexValue = gray(size(map,1));
    IndexValue = IndexValue(:,1);
else
    IndexValue = varargin{1};
end
if size(map,1)~=length(IndexValue)
    error('input colormap and index value is not equal length')
end

HSV = rgb2hsv(map);
% HSV(:,2) = 1;
% HSV(:,3) = 1;
A = map;
for n = 1:size(HSV,1)
    SMap = Makemap2019(hsv2rgb(HSV(n,:)),2^12);
    Intensitys = rgb2gray(SMap);
    Intensity = Intensitys(:,1);
    [~,ind] = min(abs(Intensity - IndexValue(n)));
    A(n,:) = SMap(ind,:);
end





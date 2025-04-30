function varargout = Colormap_Gamma(map,varargin)
% Colormap_Gamma(map,r)


narginchk(1,2)
if nargin==1
    r = 0.5;
else
    r = varargin{1};
end
hsvmap = rgb2hsv(map);
% hsvmap(:,3) = hsvmap(:,3).^r;
hsvmap(:,3) = linspace(0,1,size(map,1)).^r;
output = hsv2rgb(hsvmap);
if nargout>0
    varargout{1} = output;
else
    colormap(output)
end
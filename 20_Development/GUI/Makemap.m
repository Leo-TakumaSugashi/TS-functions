function map = Makemap(mapmax,varargin)
% map = Makemap(RGB)
% map = Makemap(RGB,Gamma)
% map = Makemap(RGB,Gamma,num)

if nargin==1
    G = 1;
    num = 256;
elseif nargin ==2
    G = varargin{1};
    num = 256;
else
    G = varargin{1};
    num = varargin{2};
end
hsvmax = rgb2hsv(mapmax);
hsvmatrix = repmat(hsvmax,[num,1]);
hsvmatrix(:,3) = linspace(0,hsvmax(3),num);
hsvmatrix(:,3) = hsvmatrix(:,3) .^G;
map = hsv2rgb(hsvmatrix);
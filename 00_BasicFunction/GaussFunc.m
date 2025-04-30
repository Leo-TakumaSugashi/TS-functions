function y = GaussFunc(x,varargin)
% y = GaussFunc(x,...)
%     x : Index
%     sigma = 0.5
%     GaussFunc(x,sigma)
%     input sigma

narginchk(1,2)
if nargin==1
    sigma_x = 0.5;
else
    sigma_x = varargin{1};
end
y = exp(- (x.^2 / (2* (sigma_x.^2))));
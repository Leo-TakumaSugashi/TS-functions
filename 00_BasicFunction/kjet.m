function A = kjet(varargin)
if nargin==0
    siz = 256;
elseif nargin == 1
    siz = varargin{1};
else
    error('Too macth nargin')
end

A = cat(1,[0 0 0],jet(siz-1));
function Maps = kjetgray(varargin)

if nargin ==1
    num = varargin{1};
else
    num = 256;
end
Maps = cat(1,[0 0 0],jet(num-2),[.5 .5 .5]);
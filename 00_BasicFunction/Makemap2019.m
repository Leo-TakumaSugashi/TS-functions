function Nmap = Makemap2019(nC,varargin)

if nargin==1
    val = 256;
else
    val = varargin{1};
end

map = cat(1,[0 0 0],nC,[1 1 1]);
Nmap = interp2(map,1:3,linspace(1,3,val)');
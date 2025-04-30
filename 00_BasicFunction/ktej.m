function map = ktej(varargin)

narginchk(0,1)
if nargin == 0
    num = 265;
else
    num = varargin{1};
end
if num == 1
    map = [0 0 0 ];
else
    num = num -1;
    map =cat(1,zeros(1,3),flip( jet(num), 1));
end
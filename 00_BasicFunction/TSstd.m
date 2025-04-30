function A = TSstd(v,varargin)

if isvector(v)
    dim = 1;
    v = v(:);
else
    dim = varargin{:};
    disp(['  '  mfilename])
    warning('Input is Matrix...')
end

A = std(v(~isnan(v)),dim);
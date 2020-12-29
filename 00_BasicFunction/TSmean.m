function A = TSmean(Vec,varargin)
%% Avoidance of Nan!!

if isvector(Vec)
    Vec = Vec(:);
    dim = 1;
else
    dim = varargin{1};
end

ind = isnan(Vec);
B = Vec;
B(ind) = 0;
B = sum(B,dim);
D = sum(double(~ind),dim);
A = B./D;
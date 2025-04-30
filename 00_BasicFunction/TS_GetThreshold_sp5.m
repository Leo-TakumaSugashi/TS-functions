function TH = TS_GetThreshold_sp5(S,N)

if ~and(isscalar(S),isscalar(N))
    warning('Input S or N is NOT Scalar')
end

S = double(S);
N = double(N);

if N < 1
    warning('Input N is less than 1')
    N = 1;
end


TH = 0.00111415 * (S./N) + 0.484547; 
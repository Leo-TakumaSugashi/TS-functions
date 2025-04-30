function TH = TS_GetThreshold_sp5_v2019(S,N)

if ~and(isscalar(S),isscalar(N))
    warning('Input S or N is NOT Scalar')
end

S = double(S);
N = double(N);

if N < 1
    warning('Input N is less than 1')
    N = 1;
end

TH = 0.0011141 * (S./N) + 0.48455; %% unit [ % ]

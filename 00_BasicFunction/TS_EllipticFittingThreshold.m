function TH = TS_EllipticFittingThreshold(S,N)

% S = TS_SliceSignal5per(im);
% N = mode(double(im(and(im>0,im<S))));
if S/N>1
    THcoef = 0.0019165*S/N + 0.46874;
else
    THcoef =  0.46874;
end
TH = (S-N) * THcoef + N;
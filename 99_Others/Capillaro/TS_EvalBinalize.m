function Ev = TS_EvalBinalize(T,R)

a1 = sum(and(R(:),T(:)))./sum(T(:));
a2 = sum(and(~R(:),~T(:)))./sum(~T(:));
b1 = sum(and(~R(:),T(:)))./sum(T(:));
b2 = sum(and(R(:),~T(:)))./sum(~T(:));
Ev = [a1, a2; b1, b2];
function S = TS_SliceSignal5per(im)

if ~ismatrix(im)
    error('input is not matrix')
end

SignalTH = 0.05;
S = sort(im(:));
S = mean(S(end-round(length(S)*SignalTH):end));
function [X,Y] = TS_bar2patch(H,x)
% [X,Y] = TS_bar2patch(H,x)
% example.
%     dummy = load('mri');
%     dummy.D = squeeze(dummy.D);
%     dummy.MeanIP = mean(dummy.D,3);
%     [dummy.H, dummy.x] = hist(dummy.MeanIP(dummy.MeanIP>0),100);
%     [X,Y] = TS_bar2patch(dummy.H,dummy.x);
%     figure,patch(X,Y,[0 0 .7])
bitval = abs(diff(x(1:2)));
xmini = min(x)-bitval;
X = [xmini xmini];
Y = [0 H(1)];
for n= 1:length(x)-1
    X = [X x(n) x(n)];
    Y = [Y H(n) H(n+1)]; 
end
X = [X x(end) x(end) xmini];
Y = [Y H(end) 0 0];
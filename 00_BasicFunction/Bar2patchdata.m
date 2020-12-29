function [xout,yout] = Bar2patchdata(xdata,ydata)
% This func. change a data made at [h,x] = hist(histdata,Bin);
%    to a patch-data

Width = diff(xdata(1:2));
xout = zeros(1,length(xdata)*2+3); 
yout = xout;
for n = 1:length(xdata)
    xout((n-1)*2 + 1) = xdata(n)-Width/2;
    yout((n-1)*2 + 1) = ydata(n)-Width/2;
    xout(n*2) = xdata(n)+Width/2;
    yout(n*2) = ydata(n)+Width/2;
end

xout(end-2) = xdata(end) + Width/2;
yout(end-2) = 0;

xout(end-1) = xdata(1) - Width/2;
yout(end-1) = 0;

xout(end) =  xdata(1) - Width/2;
yout(end) = ydata(1);


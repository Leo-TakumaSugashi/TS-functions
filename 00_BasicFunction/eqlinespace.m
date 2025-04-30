function vx = eqlinespace(x,val,varargin)

vx = zeros((length(x)-1)*(val-1),1);


for n = 1:length(x)-1
    eqx = linspace(x(n),x(n+1),val);
    vx((n-1)*(val-1)+1:n*(val-1)) = eqx(1:end-1);
end

%% Check figure
if nargin>2
xdata = (0:length(vx)-1) / (length(vx)-1) * (length(x)-1) +1; 
figure,plot(1:length(x),x,'o')
hold on
plot(xdata,vx,'r.:')
end
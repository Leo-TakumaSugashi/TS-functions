function [xq,yq,actualreso] = ...
    ts_ReSamplingWithMovingAverage_CHS(x,y,newreso)
% x       : 1xN , numel(N)>=2double
% y       : 1xN double
% newreso : 1x1 double
% w       : 1x1 double
Numel = length(x);
len = x(end);
% w = w/2;
new_num = ceil(len/newreso+1);
new_num = max(new_num,2);
yq = zeros(1,new_num);
xq = linspace(0,len,new_num);
if new_num ==2
    yq(1) = y(1);
    yq(2) = y(Numel);
    actualreso = len;
    return
elseif new_num ==3
    yq(1) = y(1);
    yq(2) = nanmean(y);
    yq(3) = y(Numel);
    actualreso = len/2;
    return
else
    actualreso = len/(new_num-1);
end
keyboard
%% out put numel >=3 

p0 = yq;
p1 = yq;
m0 = yq;
m1 = yq;
tv = yq;

%% set up lookup table(vectors)
yq(1) = y(1);
yq(end) = y(Numel);
c = 2;
for n = 1:length(yq)
    if xq(n)<x(2)
        m0(n) = (y(2)-y(1))/(x(2)-x(1));
        m1(n) = mean(diff(y(1:3)))/mean(diff(x(1:3)));
        p0(n) = x(1);
        p1(n) = x(2);
        tv(n) = 0;
    elseif xq(n)>x(Numel-1)
        m0(n) = mean(diff(y(Numel-2:Numel)))/mean(diff(x(Numel-2:Numel)));
        m1(n) = (y(Numel)-y(Numel-1))/(x(Numel)-x(Numel-1));
        p0(n) = x(Numel-1);
        p1(n) = x(Numel);
        tv(n) = 0;
    else
        p0(n) = x(c);
        p1(n) = x(c+1);
        m0(n) = mean(diff(y(c-1:c+1)))/mean(diff(x(c-1:c+1)));
        m1(n) = mean(diff(y(c-1:c+1)))/mean(diff(x(c-1:c+1)));
        tv(n) = xq(n)-x(c);
        if xq(n+1)>=x(c+1)
            c = c + 1;
        end
    end
end

%% main

for n = 2:length(xq)-1
    t = tv(n);
    yq(n) = (2*t^3 - 3*t^2 +1)*p0(n) + ...
        (t^3 -2*t^2 + t)*m0(n) + ...
        (-2*t^3 + 3*t^2)*p1(n) + ...
        (t^3 - t^2)*m1(n);
end


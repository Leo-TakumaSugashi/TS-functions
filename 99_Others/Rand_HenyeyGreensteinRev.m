function x = Rand_HenyeyGreensteinRev(g,y)

% HeneyGreenstein
% 
% y = (1-g^2)/(1+g^2 - (2*g*cos(x))^(3/2));

theta = linspace(0,pi,y);
p = HenyeyGreenstein(g,theta);
rx = rand(1,y);
[~,ind] = sort(rx);
x = p(ind);



function x = Rand_HenyeyGreenstein(g,y)

% HeneyGreenstein
% 
% y = (1-g^2)/(1+g^2 - (2*g*cos(x))^(3/2));
% 
% x = acos( 1/(2*g) * ((1+g^2-(1-g^2)/y)^(3/2) )  );
% 
% f(y) = ( (1+g^2 - (1-g^2)/y)^(2/3) ) /(2*g);
% 
% dx/dy = f(y)/dy * (-1 / sqrt(1-f(y)^2))

% 
% fy = ( (1+g^2 - (1-g^2)./y).^(2/3) ) /(2*g);
% fy_dy = 1/(2*g)*2/3*(1+g^2-(1-g^2)./y).^(-1/3).*(1-g^2)./(y.^2);
% x= fy_dy .* (-1./sqrt(1-fy.^2));


theta = rand(y,1)*pi;
x1 = (1-g^2)/(4*pi);
x2 = -2*(1+g^2-2*g.*sin(theta)).^(-1/2);
x = x1.*(x2);

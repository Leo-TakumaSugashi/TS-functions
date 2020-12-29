function p = HenyeyGreenstein(g,theta)
if ~isscalar(g)
    error('Input "g" must be scalar ')
end
if ~isvector(theta)
    error('Input "theta" must be vector')
end
p = (1-g^2) ./ ...
    (1 + g^2 - 2*g.*cos(theta)).^(3/2);
function Fwide = TS_BrennerGradient(im)
% Brenner, J.F.   1976......
%     prototype

if ~ismatrix(im)
    error('input image is NOT 2D')
end

n = 2; %[2 3 5 10]
Fwide = zeros(size(n,1));
for k = 1:n
    edit_im = im(:,1:end-k);
    C = double(edit_im) - double(im(:,k+1:end));
    C = C.^2;
    Fwide(k) =  sum(C(:));
    
end
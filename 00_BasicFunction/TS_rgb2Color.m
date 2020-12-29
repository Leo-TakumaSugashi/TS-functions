function A = TS_rgb2Color(rgb)
if ~strcmpi(class(rgb),'uint8')
    error('input Need uint8')
end

r = rgb(:,:,1);
g = rgb(:,:,2);
b = rgb(:,:,3);

A = repmat(r,[1 1 3]);
% % ywb
% A(:,:,3) =  A(:,:,3) - g + b +(uint8(b>0).*r)*0.3;
% A(:,:,2) =  A(:,:,2) - b*.7 - g*.1;
% A(:,:,1) =  A(:,:,1) - b*.6 + g*0.2;

% % ywm
% A(:,:,3) =  A(:,:,3) - g     + b*0.7;
% A(:,:,2) =  A(:,:,2) - g*.1  - b*.9;
% A(:,:,1) =  A(:,:,1) + g*0.0 + b*.3;

% % r->w, g ->g
A(:,:,1) = A(:,:,1) - g*0.8 ;
A(:,:,2) = A(:,:,1) - g*0.5;
A(:,:,3) = A(:,:,3) - g*0.01;

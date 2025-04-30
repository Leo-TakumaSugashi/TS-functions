
%% GURUGURU   
[x,y] = meshgrid(-2^11+1:2^11);
z = sqrt(x.^2 + y.^2);
s = atan(y./x);
s(x<0) = s(x<0) + pi;
s = s - min(s(:));

y0 = ceil(size(x,1)/2);
x0 = ceil(size(x,2)/2);
R = min(y0,x0)-2^6;

%%
fgh = figure('Color',[0 0 0 ]);
axh = axes('Position',[0.01 0.01 0.98 0.98]);

rval =9;
im = s*rval;
for n = 2:rval
    im(and(im>(n-1)*2*pi,im<=n*2*pi)) =...
        im(and(im>(n-1)*2*pi,im<=n*2*pi))-(n-1)*2*pi;
end

im = im./(max(im(:)));
im = ind2rgb8(uint8(im*255),hsv(256));


H = rgb2hsv(im);
GammS = 1.9;
GammV = 0.5;
Margin = 10;

S = min(z/(R/2),1);
S = S.^GammS;
H(:,:,2) = S;
V = z;
V(z>R) = nan;
V = min(abs(V - R),(R/2-Margin))./(R/2-Margin);
V = V.^GammV;
H(:,:,3) = V;
im = hsv2rgb(H);
im(repmat(z,[1 1 3])>R ) = nan;

imh = imagesc(im);
axis(axh,'image')
axis(axh,'off')

%%
for n = 1:256
    im = s;
    im = im./(max(im(:)));
    im = ind2rgb8(uint8(im*(n-1)),hsv(n));
    im(repmat(z,[1 1 3])>512) = nan;
    
    imh.CData = im;
    drawnow
    pause(0.02)
end

%% rotation
% Rot = linspace(1,0,256).^0.5;

F = @(X0,R) X0 * (1-(R/max(R(:))).^2.5);  

nCol = 256;
% tsmap = tsmaps;
% tsmap.num = nCol;
c = 0;

for n = 3*pi %linspace(-4*pi,4*pi,16)

    an = F(-n,z) * 180/pi -60;

    X_rot = x .* cosd(an) - y .* sind(an);
    Y_rot = x .* sind(an) + y .* cosd(an);
    
    im_rot = interp2(x,y, H(:,:,1) , X_rot, Y_rot,'makima',0);

    im_rot = im_rot./(max(im_rot(:)));
    im = H;
    im(:,:,1) = im_rot;
    im = hsv2rgb(im);
%     map = hsv(nCol);
%     im = ind2rgb8(uint8(im*(nCol-1)),map);
    im(repmat(z,[1 1 3])>R) = nan;
    imh.CData = im;
    drawnow
%     imwrite(TSmedfilt2(im,[3 3]),['Guru_' TS_num2strNUMEL(c,4) '.jpg'])
    c = c + 1;
%     pause(0.0002)
end
%%
Step = 2;
for n = 0:360/Step
    an = an - Step;

    X_rot = x .* cosd(an) - y .* sind(an);
    Y_rot = x .* sind(an) + y .* cosd(an);
    
    im = interp2(x,y, s , X_rot, Y_rot,'makima',0);

    im = im./(max(im(:)));
    map = hsv(nCol);
    im = ind2rgb8(uint8(im*(nCol-1)),map);
    im(repmat(z,[1 1 3])>512) = nan;
    imh.CData = im;
    drawnow
%     imwrite(TSmedfilt2(im,[3 3]),['Guru_' TS_num2strNUMEL(c,4) '.jpg'])
    c = c + 1;
%     pause(0.0002)
end














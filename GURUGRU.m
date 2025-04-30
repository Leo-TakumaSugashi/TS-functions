






%% GURUGURU   
[x,y] = meshgrid(-512:512);
z = sqrt(x.^2 + y.^2);
s = atan(y./x);
s(x<0) = s(x<0) + pi;
s = s - min(s(:));

y0 = 512;
x0 = 512;

%%
fgh = figure('Color',[0 0 0 ]);
axh = axes('Position',[0.01 0.01 0.98 0.98]);

im = s;

im = im./(max(im(:)));
im = ind2rgb8(uint8(im*255),hsv(256));


H = rgb2hsv(im);
Gamm = 4.01;

S = min(z/256,1);
S = S.^Gamm;
H(:,:,2) = S;
V = z;
V(z>512) = nan;
V = min(abs(V -512),256)./256;
V = V.^Gamm;
H(:,:,3) = V;
im = hsv2rgb(H);
im(repmat(z,[1 1 3])>512) = nan;

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
tsmap = tsmaps;
tsmap.num = nCol;
c = 0;

for n = linspace(-12*pi,12*pi,481)

    an = F(-n,z) * 180/pi -60;

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














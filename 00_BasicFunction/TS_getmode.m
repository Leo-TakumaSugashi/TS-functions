function M = TS_getmode(im)

im = double(im);
[h,x] = hist(im(:),0:ceil(max(im(:))));

figure,bar(x,h)
hold on
findpeaks(h)
M = [];


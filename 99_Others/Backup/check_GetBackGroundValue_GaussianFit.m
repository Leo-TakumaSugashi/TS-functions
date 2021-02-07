im = imread('cameraman.tif');
[N,S] = TS_GetBackgroundValue_GaussianFit(double(im(:)));
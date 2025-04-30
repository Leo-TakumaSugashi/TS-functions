function A = ColormapRed(num)
B = gray(num);
B(:,2:3) = 0;
A = B;
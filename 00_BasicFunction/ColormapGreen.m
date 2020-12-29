function A = ColormapGreen(num)
B = gray(num);
B(:,[1 3]) = 0;
A = B;
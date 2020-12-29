function [x,y,z] = TS_DefStartP(siz,P)

if P > 1
    error('Input P [%] is over 1.00')
end
Num = round(prod(siz) * P );
siz = siz -1;
x = rand(Num,1) * siz(2) + 1;
y = rand(Num,1) * siz(1) + 1;
z = rand(Num,1) * siz(3) + 1;

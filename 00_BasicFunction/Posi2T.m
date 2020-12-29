function T = Posi2T(siz,Posi)

siz1 = siz(1);
siz2 = siz(2);

for n = 1:4
    STR = ['x' num2str(n) '=Posi(' num2str(n) ',1);'];
    eval(STR)
    STR = ['y' num2str(n) '=Posi(' num2str(n) ',2);'];
    eval(STR)
end
% 
% % Position‚ÌŠm”F
% fgh = figure('toolbar','none','Menubar','none');
% for n = 1:4
%     text(Posi(n,1),Posi(n,2),num2str(n))
% end
% set(gca,'Xlim',[1 siz2],'Ylim',[1 siz1],...
%     'ydir','reverse')
% waitfor(fgh)

A = siz2/(x2-x1);
B = (y1-y2)/(x2-x1);
C = (x3-x2)/(y2-y3);
a = A / (1 - B*C);
b = a * (x3-x2)/(y2-y3);
c = -(a*x1 + b*y1);

d = ((y4-y3)/(x3-x4)*siz1/(y2-y3))/...
    (1-(y4-y3)/(x3-x4)*(x3-x2)/(y2-y3));
e = d * (x3-x4)/(y4-y3);
f = -(d*x3 + e*y3);


T = eye(3,3);
T(1,1:3) = [a b c];
T(2,1:3) = [d e f];

for n = 1:4
    X = [Posi(n,1:2) 1];X=X(:);
    x = T*X;x(3) = [];x = [x(1) x(2)];
    disp(x)
end


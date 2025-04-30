function [X,Y] = Posi2makeD(siz,Posi)

siz1 = siz(1);
siz2 = siz(2);


for n = 1:4
    STR = ['x' num2str(n) '=Posi(' num2str(n) ',1);'];
    eval(STR)
    STR = ['y' num2str(n) '=Posi(' num2str(n) ',2);'];
    eval(STR)
end

% % Position‚ÌŠm”F
% fgh = figure('toolbar','none','Menubar','none');
% for n = 1:4
%     text(Posi(n,1),Posi(n,2),num2str(n))
% end
% set(gca,'Xlim',[1 siz2],'Ylim',[1 siz1],...
%     'ydir','reverse')
% waitfor(fgh)

Xdata = 0:1/siz2:1;
len_x14 = x4-x1;
X1 = (Xdata*len_x14) + x1;
len_x23 = x3-x2;
X2 = (Xdata*len_x23) + x2;
X = imresize(cat(1,X1,X2),siz,'bilinear');

Ydata = 0:1/siz1:1;
Ydata = Ydata(:);
len_y12 = y2-y1;
Y1 = (Ydata*len_y12) + y1;
len_y34 = y3 - y4;
Y2 = (Ydata*len_y34) + y4;
Y = imresize(cat(2,Y1,Y2),siz,'bilinear');




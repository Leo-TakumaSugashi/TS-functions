function varargout = MN_DivideArea(Num,Center,siz)
% [output, Theta_Matrix] = MN_DivArea(Num,Center,siz)
% Input 
%   Num : Segment Number
%   Center : Position of Center [X,Y]
%   siz : Size of Data [Xsize,Ysize]
% Output ;
%     if nargout == 0,
%         run test program 
%     else,
%         output : Divide Area (Label image)
%         Theta_Matrix : see matrix..
%     end
%         
% e.x
%  MN_DivideArea(9,[200 200],[512 512])
% 
% edit by M. Nitta, 2017 03 14
 
 


[X,Y] = meshgrid(1:siz(2),1:siz(1));
Xp = X - Center(1);
Yp = Y - Center(2);

Theta_Matrix = atan(Yp./Xp);
Theta_Matrix = Theta_Matrix +abs(min(Theta_Matrix(:))); 
Theta_Matrix(Xp<0) = Theta_Matrix(Xp<0) + pi;

Theta = linspace(min(Theta_Matrix(:)),max(Theta_Matrix(:)),Num+1);
Theta = Theta - diff(Theta(1:2))/2;
% Theta = Theta - pi / Num;

output = zeros(siz,'like',single(1));
for n = 1:length(Theta)-1
    bw = and(Theta_Matrix>=Theta(n), Theta_Matrix < Theta(n+1));
    output(bw) = n;
end   
output(output==0) = 1;

if nargout == 0
    figure('Posi',[0 0 700 400]),
    centerfig(gcf)
    axes('Posi',[.01 .01 .48 .98])
    imagesc(ind2rgb(uint8(output),rand(Num+1,3)))
    axis image off
    hold on
    s = regionprops(double(output),'Centroid');
    s = cat(1,s.Centroid);
    for n = 1:length(s)
        text(s(n,1),s(n,2),num2str(n))
    end
    plot(Center(1),Center(2),'o','Markersize',12)
    title('Diveded Label Image')
    
    axes('Posi',[.51 .01 .48 .98])
    imagesc(Theta_Matrix)
    axis image off   
    title('Theta Matrix')
    colorbar    
else
    varargout{1} = output;
    varargout{2} = Theta_Matrix;
end
    




% % %
% % % R1 = abs(Xp)>0;
% % % R2 = abs(Xp + Yp)>0;
% % % R3 = abs(Yp)>0;
% % % R4 = abs(Xp - Yp)>0;
% % % 
% % % b = R1 .* R2 .* R3 .* R4;
% % % c = bwlabel(b,4);
% % % 
% % % 
% % % Output = zeros(size(X));
% % % Output(and(tan(3/8*pi) * Xp - Yp > 0,tan(5/8 * pi) * Xp  - Yp > 0)) = 1;
% % % Output(and(tan(9/8*pi) * Xp - Yp >= 0,tan(11/8 * pi) * Xp  - Yp > 0)) = 2;
% % % Output(and(tan(5/8*pi) * Xp - Yp >= 0,tan(7/8 * pi) * Xp  - Yp < 0)) = 8;
% % % 
% % % Output(and(Xp>0,(Xp + Yp)<=0)) = 8;
% % % 
% % % Output((tan(3/8*pi)*Xp <= Yp)&&(y1>tan(5/8*pi)*x1 < ))
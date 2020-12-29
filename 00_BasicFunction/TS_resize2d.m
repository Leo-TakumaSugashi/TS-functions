function [output,ActualReso] = TS_resize2d(Image,Reso,Newsiz)
% [output,ActualReso] = TS_resize2d(Image,Reso,Newsiz)
% Reso = [ X Y ]
% New size = [Xp Yp]


% if ~ismatrix(Image)
%     error('Input Dim. is NOT 2.')
% end

siz  = size(Image);

if length(siz)>2
    Image = reshape(Image,siz(1),siz(2),prod(siz(3:end)));
end
    
%% interp. val
Type = 'linear';

Input_xdata = (0:size(Image,2)-1) * Reso(1);
Input_ydata = (0:size(Image,1)-1) * Reso(2);
% Input_zdata = (0:size(Image,3)-1) * Reso(3);

xp = linspace(0,Input_xdata(end),Newsiz(1));
yp = linspace(0,Input_ydata(end),Newsiz(2));

if length(Reso)>2
ActualReso = [diff(xp(1:2))  diff(yp(1:2)) Reso(3)];
end
%% % 1st XY
[Xp,Yp] = meshgrid(xp,yp);
InterpXY = zeros(length(yp),length(xp),size(Image,3));
for n = 1:size(Image,3)
    InterpXY(:,:,n) = interp2(Input_xdata,Input_ydata,double(Image(:,:,n)),Xp,Yp,Type);    
end
siz(1:2) = Newsiz(1:2);
output = reshape(InterpXY,siz);

% output = interp2(Input_xdata,Input_ydata,double(Image),Xp,Yp,Type);
end

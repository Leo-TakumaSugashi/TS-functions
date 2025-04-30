function [output,ActualReso] = TS_resize2d_Reso(Image,Reso,NewReso)
% [output,ActualReso] = TS_resize2d_Reso(Image,Reso,NewReso)
% Input
%   Reso = [ X Y ] um/pix.
%   NewReso = [Xp Yp] um/pix.
% Output
%     output    : double class
%     ActualReso : [Xp Yp] um/pix.

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

xp = linspace(0,Input_xdata(end),ceil(Input_xdata(end)/NewReso(1)));
yp = linspace(0,Input_ydata(end),ceil(Input_ydata(end)/NewReso(2)));
ActualReso = [diff(xp(1:2))  diff(yp(1:2)) Reso(3)];

%% % 1st XY
[Xp,Yp] = meshgrid(xp,yp);
InterpXY = zeros(length(yp),length(xp),size(Image,3));
for n = 1:size(Image,3)
    InterpXY(:,:,n) = interp2(Input_xdata,Input_ydata,single(Image(:,:,n)),Xp,Yp,Type);    
end

siz(1:2) = [size(InterpXY,1) size(InterpXY,2)];
output = reshape(InterpXY,siz);
end


    

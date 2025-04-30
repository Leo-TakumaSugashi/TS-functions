function [output,ActualReso] = TS_EqualReso3d(Image,Reso,NewReso)
% [output,ActualReso] = TS_EqualReso3d(Image,Reso(X Y Z),NewReso(scalar))


if or(ndims(Image)>3,isvector(Image))
    error('Input Dim. is NOT 3 or 2.')
end
    
%% interp. val
Type = 'linear';

Input_xdata = (0:size(Image,2)-1) * Reso(1);
Input_ydata = (0:size(Image,1)-1) * Reso(2);
Input_zdata = (0:size(Image,3)-1) * Reso(3);

xp = linspace(0,Input_xdata(end),ceil(Input_xdata(end)/NewReso+1));
yp = linspace(0,Input_ydata(end),ceil(Input_ydata(end)/NewReso+1));
zp = linspace(0,Input_zdata(end),ceil(Input_zdata(end)/NewReso+1));

NUMEL = length(xp) * length(yp) * length(zp);
% if NUMEL > numel(Image)
    disp([' output/input[numels] ' num2str(NUMEL/numel(Image))])
%     error('Toooo OuutputÇ™ëÂÇ´Ç∑Ç¨Ç‹Ç∑ÅB')
% end

ActualReso = [diff(xp(1:2))  diff(yp(1:2))  diff(zp(1:2))];

%% % 1st XY
[Xp,Yp] = meshgrid(xp,yp);
InterpXY = zeros(length(yp),length(xp),size(Image,3));
for n = 1:size(Image,3)
    InterpXY(:,:,n) = interp2(Input_xdata,Input_ydata,double(Image(:,:,n)),Xp,Yp,Type);    
end

%% % 2nd Z
output = zeros(length(yp),length(xp),length(zp),'like',Image);
[siz_y,siz_x,siz_z] = size(output);
output = reshape(output,siz_y*siz_x,siz_z);
InterpXY = reshape(InterpXY,size(InterpXY,1)*size(InterpXY,2) , size(InterpXY,3));
CLASS = class(Image);
wh = waitbar(0,['Wait...' mfilename]);
for n = 1:size(output,1)
    Li = interp1(Input_zdata,InterpXY(n,:),zp,Type);
    output(n,:) = feval(CLASS,Li);clear Li
    waitbar(n/size(output,1),wh)
end
close(wh)
output = permute(output,[1 3 2]);
output = reshape(output,siz_y,siz_x,siz_z);

% % 
% % [siz_y,siz_x,siz_z] = size(output);
% % % output = reshape(output,siz_y*siz_x,siz_z);
% % % InterpXY = reshape(InterpXY,size(InterpXY,1)*size(InterpXY,2) , size(InterpXY,3));
% % CLASS = class(Image);
% % [Xp,Yp] = meshgrid(yp,zp);
% % wh = waitbar(0,['Wait...' mfilename]);
% % for n = 1:size(output,2)
% %     Li = interp2(yp,Input_zdata,squeeze(InterpXY(:,n,:)),Xp,Yp,Type);
% %     Li = permute(Li,[1 3 2]);
% %     output(:,n,:) = feval(CLASS,Li);clear Li
% %     waitbar(n/size(output,2),wh)
% % end
% % close(wh)



    

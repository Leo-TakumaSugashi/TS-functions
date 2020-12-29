function [EmphaImage,fImage] = TS_EmphasizeMicroglia_RemSmog(Image,Reso)
% [EmphaImage,fImage] = TS_EmphasizeMicroglia_RemSmog(Image,Reso)
% output:
%  [ 1 Emphasized Image (TS_HistgramLogScaler(fImage,'std');
%    2  Filtered Image by special kernel filter for MicroGlia]
% ********* ObjSize(1) == ObjSize(2) && Reso(1) == Reso(2) **********
% 
% GaussFil_sigma_coef = 0.5; Defolt
%    ... se = 10.^se;Å@For Micro-Glia
%                                                  
% Process For Micro-Glia.
% Threshold_afopen = 0.15;  Defolt
% 
% Input 
%     Image : 
%     ObjSize : X Y Z  unit mum
%     Reso    : X Y Z Resolution unit mum/pixels

ObjSize = [1 1 1]; %% um
GaussFil_sigma_coef = 0.5;

%% gaussian filter
se = fspecial('gaussian',floor(ObjSize(1)/Reso(1)/2*GaussFil_sigma_coef)*6+1,...
    ObjSize(1)/Reso(1)/(2*sqrt(2*log(2)))*GaussFil_sigma_coef);

se2 = se - min(se(:));
se2 = se2 ./max(se2(:));
se2 = 10.^se2 - 1;
se2 = se2./sum(se2(:));
fgh = figure;
axes('Posi',[0 0 .5 1]),imagesc(se),axis image
axes('Posi',[.5 0 .5 1]),imagesc(se2),axis image
drawnow
% figure,imagesc(se)
fImage = imfilter(single(Image),se2,'symmetric');
close(fgh)
drawnow




%% Emphasize
EmphaImage = TS_HistgramLogScaler(fImage,'std');

%% Remove Smog





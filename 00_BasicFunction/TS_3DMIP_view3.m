
function A = TS_3DMIP_view3(Image,Reso,theta,fai)
Image = imrotate(Image,theta);

% siz = size(Image);
% Asiz = siz .* Reso;
resiz_val = Reso(3) / Reso(1);
Image = flip(Image,1);
Image = flip(Image,3);
Image = permute(Image,[3 2 1 4 5]);
Image = imresize(Image,[ceil(size(Image,1)*resiz_val) size(Image,2)]);


%% fai add 2016/11/10
% % check gpu memory
if strcmpi(class(Image),'gpuArray')
    Image = gather(Image);
end
Image = permute(Image,[1 3 2 4 5]);
Image = imrotate(Image,fai);
Image = permute(Image,[1 3 2 4 5]);
A = max(Image,[],3);
return

% % %% For logical data
% % 
% % 
% % Shiftsiz = round(siz(2)*sind(theta));
% % siz = size(Image);
% % 
% % out = zeros(siz(1)+Shiftsiz,siz(2),siz(3),'like',Image);
% % y = 1:siz(1);
% % n_shift = round(linspace(0,Shiftsiz,size(Image,3)));
% % y = y + n_shift(end);
% % for n = 1:size(Image,3)
% %     ydata = y - n_shift(n);
% %     out(ydata,:,n) = Image(:,:,n);
% % end
% % 
% % A = max(out,[],3);
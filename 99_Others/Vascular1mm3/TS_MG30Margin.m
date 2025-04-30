function output = TS_MG30Margin(im1,im2,im3,im4)

%% rotate Check and Do
theta = atand(-28/500);
% im1 = permute(Image1,[3 2 1]);
% im1 = imrotate(im1,theta,'nearest');
% im1 = ipermute(im1,[3 2 1]);
for n = 1:4
    eval(['im' num2str(n) ' = permute(im' num2str(n) ',[3 2 1]);'])
    eval(['im' num2str(n) ' = imrotate(im' num2str(n) ',theta,''nearest'');'])
    eval(['im' num2str(n) ' = ipermute(im' num2str(n) ',[3 2 1]);'])
end
im1 = padarray(im1,[0 1 1200-1175],'pre');
im2 = padarray(im2,[0 0 1200-1197],'pre');
im3 = padarray(im3,[0 1 1200-1182],'pre');

%% Loc 1 and 2
im1 = padarray(im1,[500 500],'post');
im2 = padarray(im2,[500-5     18],'post');
im2 = padarray(im2,[5     500-18],'pre');
ImageAll_12 = max(cat(4,im1,im2),[],4);
clear im1 im2

%% loc 4 and 3
im3 = padarray(im3,[500 500],'pre');
im4 = padarray(im4,[500 28],'pre');
im4 = padarray(im4,[0 500-28],'post');
ImageAll_43 = max(cat(4,im4,im3),[],4);
clear m3 m4 im3 im4
%% margin 12 and 43
  %% XY [25 -11]
ImageAll_12 = padarray(ImageAll_12,[0 11],'pre');
ImageAll_43 = padarray(ImageAll_43,[0 11],'post');
ImageAll_43(1:25,:,:) = [];
ImageAll_43 = padarray(ImageAll_43,[25 0],'post');
output = max(cat(4,ImageAll_12,ImageAll_43),[],4);
clear ImageAll_12 ImageAll_43
load('MarginResoEqualdata.mat','x','y')
output(~y,:,:) = [];
output(:,~x,:) = [];
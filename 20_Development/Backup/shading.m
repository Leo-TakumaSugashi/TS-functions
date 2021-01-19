
% Shading
% f = fspecial('gaussian',[80 80],40);                                        %‘‹‚Íxysize‚Ì1/4
% for n = 1:size(Image,3)
% a(:,:,n) = imfilter(double(Image(:,:,n)),f,'replicate');
% end
% for n = 1:size(Image,3)
% a2 = mean(mean(a(:,:,n)));
% a3(:,:,n) = a(:,:,n)/a2;
% Image2(:,:,n) = double(Image(:,:,n))./a3(:,:,n);
% end
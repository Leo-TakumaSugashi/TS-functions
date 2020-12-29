
function A = TS_3DMIP(Image,Reso)


siz = size(Image);
% Asiz = siz .* Reso;
resiz_val = Reso(3) / Reso(1);
Image = flip(Image,1);
Image = flip(Image,3);
Image = permute(Image,[3 2 1]);
Image = imresize(Image,[ceil(size(Image,1)*resiz_val) size(Image,2)]);

%% For logical data


Shiftsiz = round(siz(2)/3);
siz = size(Image);
%   ____
%  /___/|
% |   | |
% |   | |
% |___|/  
out = zeros(siz(1)+Shiftsiz,siz(2)+Shiftsiz,siz(3),'like',Image);
x = 1:size(Image,2);
y = 1:size(Image,1);
n_shift = round(linspace(0,Shiftsiz,size(Image,3)));
y = y + n_shift(end);
for n = 1:size(Image,3)
    xdata = x + n_shift(n);
    ydata = y - n_shift(n);
    out(ydata,xdata,n) = Image(:,:,n);
end

A = max(out,[],3);
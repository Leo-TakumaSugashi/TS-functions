function A = TS_imgrav2_proto(im)

if ~ismatrix(im)
    error('Input is not matrix')
end
im = double(im);
%% distance == 1
Grad_near8 = zeros([size(im) 8]);
for n= 1:4
    se = MakeKernel(n);
    Grad_near8(:,:,n) = sqrt(imfilter(im,se,'symmetric').^2 + 1);
end

%% distance == sqrt(2);
for n= 5:8
    se = MakeKernel(n);
    Grad_near8(:,:,n) = sqrt(imfilter(im,se,'symmetric').^2 + 2);
end

A = sum(Grad_near8,3)/8;


end


function se = MakeKernel(num)
se =[ 5     1     6
     2     0     3
     7     4     8];
se = - double(se == num);
se(2,2) = 1;
end



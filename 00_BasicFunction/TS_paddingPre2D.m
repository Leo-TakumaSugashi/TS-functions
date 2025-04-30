function [A,B] = TS_paddingPre2D(im1,im2)
% [A,B] = TS_paddingPre2D(im1,im2)
%  output is size(A,end) == size(B,end)

if or(ne(ndims(im1),ndims(im2)),~ismatrix(im1))
    error('input Dim''s not equal')
end

siz1 = size(im1);
siz2 = size(im2);
PadSiz = zeros(size(siz1));
PadSiz(end) = abs(siz1(end) - siz2(end));
if siz1(end) > siz2(end)
    B = padarray(im2,PadSiz,'pre');
    A = im1;
elseif siz1(end) < siz2(end)
    B = im2;
    A = padarray(im1,PadSiz,'pre');
else
    A = im1;
    B = im2;
end
function [A,NewSiz] = TS_padding0(siz,B)
% [A,NewSiz] = TS_padding0(siz,B)
%  input 
%       siz : output size of B
%       B   : padding image
%  output  :
%      A    : output image(B's padding image)
%      NewSiz : = max(cat(1,siz,sizB))


if ~or(ismatrix(B),ndims(B)==3)
    error('Input data is not correct')
end

sizB = size(B);
sizB = sizB(1:2);
siz = max(cat(1,siz,sizB));

Prex = floor((siz(2) - sizB(2))/2);
Prey = floor((siz(1) - sizB(1))/2);

Presiz = [Prey Prex];
if max(Presiz)~=0
    A = padarray(B,Presiz,0,'pre');
else
    A = B;
end

Postx = siz(2) - size(A,2);
Posty = siz(1) - size(A,1);

Postsiz = [Posty Postx];

if max(Postsiz) ~=0
    A = padarray(A,Postsiz,0,'post');
end
NewSiz = siz(1:2);

function [shift_siz,val] = TS_SliceReposition(A,B)
% [shift_siz,(val),(Corr_max)] = TS_SliceReposition(A,B)
% Output is shift of B that has moved relation to the reference A. 
% shift_siz = [y x]
% see also TS_Shift2pad_vEachSlice
%% edit 2016. 11 11

if ~ismatrix(A)
    error('Input data is not Matrix.')
end

if min(size(A) == size(B)) == false
    error('Input size is A =~ B...')
end

siz = (size(A)-1)/2;

nA = single(A);
nA = (nA - min(nA(:))) / (max(nA(:)) - min(nA(:)));
nB = single(B);
nB = (nB - min(nB(:))) / (max(nB(:)) - min(nB(:)));

D = ifftshift(ifft2(fft2(nA).*conj(fft2(nB))));
[val1,Ind1] = max(D(:));
% [y1,x1] = ind2sub(size(D),Ind1);
Ind = Ind1;
val = val1;
%% add value NUM --> corr2
%  valNUM = 9;
% pks = TS_findpeaks2(D);
% [Y,X] = find(pks);
% sD = D(pks);
% [VAL,Ind] = sort(sD,'descend');
% Y = Y(Ind);
% X = X(Ind);
% cutdata = (1:length(Ind)) <=valNUM;
% Ind = [Ind1; Ind(cutdata)];
% Y = [y1; Y(cutdata)];
% X = [x1; X(cutdata)];
% VAL = [val1; VAL(cutdata)];
% CorrR = zeros(size(Ind));
% for n = 1:length(Ind)    
%     y = Y(n); x = X(n);
%     shift_siz = round([y x] - siz -1.1);
%     [IM1,IM2] = TS_Shift2pad_vEachSlice(A,B,shift_siz);
%     CorrR(n) = corr2(IM1,IM2);
% end
% [Cmax,Cmax_ind] = max(CorrR);
% val = VAL(Cmax_ind);
% Ind = Ind(Cmax_ind);
%% add value NUM --> corr2

[y,x] = ind2sub(size(D),Ind);

shift_siz = round([y x] - siz -1.1);




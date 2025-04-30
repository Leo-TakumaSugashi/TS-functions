function A = TS_GetSameValueSort(B)
% A = TS_GetSameValueSort(B)
%     S = sort(B(:));
%     D = cat(1,diff(S,[],1) > 0, true);
%     A = S(D);
if isempty(B)
    A = B;
    return
end
S = sort(B(:));
D = cat(1,diff(S,[],1) > 0, true);
A = S(D);

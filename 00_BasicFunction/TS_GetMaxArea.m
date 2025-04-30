function A = TS_GetMaxArea(bw,varargin)

if max(bw(:)) == 0
    A = bw;
    return
end


if nargin==2
    Center = varargin{1};
else
    Center = (size(bw)-1) / 2 + 1;
end
L = bwlabeln(bw);
s = regionprops(L,'Area','Centroid');
[~,Ind] = max(cat(1,s.Area));


if numel(Ind)>1
    xy = cat(1,s(Ind).Centroid);
    Len = xy - repmat(Center,[size(xy,1) 1]);
    Len = sum(Len.^2,2);
    [~,ind] = min(Len);
    A = L == Ind(ind);
else
    A = L == Ind;
end
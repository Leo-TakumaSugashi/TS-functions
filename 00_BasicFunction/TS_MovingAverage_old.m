function A = TS_MovingAverage_old(data,val)

if ~isvector(data)
    error('Input is not vector....TS_MovingAverage');
end
[y,x] = size(data);
if y>x
    data = data';
end
data = double(data);
len = length(data);
% f2s = floor(val/2);
A = padarray(zeros(size(data)),[val 0],nan,'pre');
B = padarray(data,[0 floor(val/2)],nan);
for i= 1:val
    A(i,:) = B(1,(i-1)*2+1:(i-1)*2+len);
end
figure,imagesc(A)
A = TSmean(A(1:val,:),1);
A = A';
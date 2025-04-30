function Output = MN_mode(data,BinN)

sample = double(data(:));
BinW = (max(sample)/BinN);
resul = double(zeros([BinN,2])); 
for n = 1:BinN
k = find(sample<=BinW*n);
resul(n,1) = BinW*(2*n-1)/2;
resul(n,2) = length(k);
sample(sample<=BinW*n) = [];
end
[v,p] = max(resul(:,2));
Output = resul(p,1);



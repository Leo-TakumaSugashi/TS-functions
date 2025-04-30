function output = TS_rand_HenyeyGreenstein(g,siz,str)
% output = TS_rand_HenyeyGreenstein(siz,str)
% 
%       g  : see also HenyeyGreenstein function.
%     siz  : [Y,X,Z,...] size of matrix
%     str  : "double" or "single"

ResolutionPow = 3600;

theta = feval(str, linspace(-pi,pi,ResolutionPow +1) );
StepVal = theta(2) - theta(1);
theta(end) = []; %% -pi == pi 
p = HenyeyGreenstein(g,theta);
p = p./sum(p);
% figure,plot(theta,p)

N = prod(siz);
data(1:ResolutionPow) = struct('value',[]);
% pm = feval(str,0);
% TS_WaiteProgress(0)
for n = 1:ResolutionPow
    Ratio = p(n) * N;
%     pm = feval(str,sign(Ratio-round(Ratio))) + pm;
%     data(n).value = rand(round(Ratio)+pm,1) * p(n);
%     value = randn(ceil(Ratio),1,str) * StepVal;
    value = rand(ceil(Ratio),1,str) * StepVal;
    data(n).value = value + theta(n);
%     TS_WaiteProgress(n/ResolutionPow)
end
Value = cat(1,data.value);

x = rand(length(Value),1,str);
[~,ind] = sort(x);
Value = Value(ind);
Value = Value(1:N);
if ~isscalar(siz)
    output = reshape( Value,siz);
else
    output = Value;
end

function varargout = TS_errorbar(x,y,SD,varargin)
% varargout = TS_errorbar(x,y,SD,varargin)

X = [];
Y = [];
Step = min(diff(x));
w = Step * 0.3;


for n = 1:length(x)
X = [X x(n)-w     x(n)+w      nan...
    x(n)+w     x(n)-w     nan x(n)       x(n)       nan];
Y = [Y y(n)+SD(n) y(n)+SD(n)  nan...
    y(n)-SD(n) y(n)-SD(n) nan y(n)-SD(n) y(n)+SD(n) nan];
end
p = plot(X,Y,varargin{:});
if nargout==1
    varargout{1} = p;
end

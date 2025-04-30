function [S] = HS_B_Spline_ver19Alpha(ControlPoint,p,v,varargin) 
%%
% [S] = HS_B_Spline(ControlPoint,p,v,varargin)
% make B-Spline plot (2D or 3D)
% 
%
% input: ControlPoint, n(Degree of B-Spline)
%        v(The number of plot point)
% varargin{1}: no input:KnotVector is OpenUniform
%           'NonUni':KnotVector is NonUniform
% varargin{2}:'Bezier':Adapt Bezier Curve
%
% output: S
%
%
% ControlPoint :Array (yx or yxz) like skelton point data
% p: degree of B-spline
% c: Number of Control point
% m: number of kont
% v: S vertical size (time)
% t: time (S_ind)
%
% edit by SuzukiHiroki 2018/12/06
%
%---log---------------------------------
% 2018/12/07 add enable adjust number of plot point by HS
% 2019/10/12 add Bezier Curve
%
%------------
% memo 
% I would like to make NURBS
% NURBS is Non Uniform Rational B Spline
% Rational mean Difference of weight of each point like Brightness value
% NonUniform is difficult, because it need each knot vector data
% and teh knot vector data define by hand

%% set up
c = size(ControlPoint,1); 

if nargin == 5
if isequal(varargin{2},'Bezier')
    p = c - 1;
else
    p = p;
end
end

m = c + p + 1;

%% check
if c <= p
    msg = 'Degree exceed ControlPoints';
    error(msg);
end
    
if nargin >= 4
    if isequal(varargin{1},'NonUni')
        kind = 1;
    elseif isequal(varargin{1},'Uni')
        kind = 2;
    elseif isequal(varargin{1},[])
        kind = 0;
    else
        msg = 'Argument disable';
        error(msg);
    end
else
        kind = 0;
end



%% Define knot

if kind == 1
u = NonUniformKnotVector(m,p);
elseif kind == 2
u = UniformKnotVector(m);
else
u = OpenUniformKnotVector(m,p);
end

t = 0:1/v:u(end);
v2 = size(t,2);
t = 0:1/v2:u(end);

%% Calculate B-Spline
S = zeros(size(t,2),size(ControlPoint,2));
S(1,:) = ControlPoint(1,:);
for i = 2:size(t,2)
   for j = 1:c 
   b = BasisFunction(u,j,p,t(i));
   S(i,:) = S(i,:) + ControlPoint(j,:)*b;
   end
end


end

function [u] = OpenUniformKnotVector(m,n)
u = zeros(1,m);
for i = 1:m
   if i < n+1
    u(i) = 0;
   elseif i > m-n-1
    u(i) = m - 2 * n;
   else
    u(i) = i - n - 1;   
   end
end
u = u/u(end);
end

function [u] = UniformKnotVector(m)
u = 0:1/(m-1):1;
end

function [u] = NonUniformKnotVector(m,n)
% NonUniform need each knot inout
% GUI? or target on branch point?
msg = 'This function is Unimplemented';
error(msg);

end


function [b] = BasisFunction(u,j,k,t)
w1 = 0.0;
w2 = 0.0;

if k == 0
    if and(u(j)<t,t<=u(j+1))
        b = 1.0;
    else
        b = 0.0;
    end
else
    if (u(j+k+1)-u(j+1)) ~= 0
    w1 = BasisFunction(u,j+1,k-1,t) * (u(j+k+1) - t)/(u(j+k+1)-u(j+1));
    end
    if (u(j+k)-u(j)) ~= 0  
    w2 = BasisFunction(u,j,k-1,t) * (t - u(j))/(u(j+k) - u(j));
    end
        b = w1 + w2;
end

end
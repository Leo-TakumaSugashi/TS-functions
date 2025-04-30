function varargout = xyz2plot(xyz,varargin)
% varargout = xyz2plot(xyz,Reso,varargin)

x = xyz(:,1);
y = xyz(:,2);
z = xyz(:,3);
if nargin>1
    Reso = varargin{1};
    if nargin>2
        p = plot3((x-1)*Reso(1),(y-1)*Reso(2),(z-1)*Reso(3),varargin{2:end});
    else
        p = plot3((x-1)*Reso(1),(y-1)*Reso(2),(z-1)*Reso(3));
    end
else
    p = plot3(x,y,z);
end



if nargout==1
    varargout{1} = p;
end
function varargout = xyz2quiver3(xyz,varargin)
% varargout = xyz2quiver3(xyz,Reso,varargin)
Grad = 1;
x = xyz(:,1);
y = xyz(:,2);
z = xyz(:,3);
if size(xyz,1)==1
    u = 0;
    v = 0;
    w = 0;
else
    De = diff(xyz,1,1);
    De(end+1,:) = De(end,:);
    u = De(:,1)/Grad;
    v = De(:,2)/Grad;
    w = De(:,3)/Grad;
end

if nargin>1
    Reso = varargin{1};
    if nargin>2
        p = quiver3((x-1)*Reso(1),(y-1)*Reso(2),(z-1)*Reso(3),...
            u*Reso(1),v*Reso(2),w*Reso(3),varargin{2:end});
    else
        p = quiver3((x-1)*Reso(1),(y-1)*Reso(2),(z-1)*Reso(3),...
            u*Reso(1),v*Reso(2),w*Reso(3));
    end
else
    p = quiver3(x,y,z,u,v,w);
end



if nargout==1
    varargout{1} = p;
end
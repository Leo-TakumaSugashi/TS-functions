function varargout  = pointview(thindata,Reso,varargin)
% varargout  = pointview(thindata,Reso,varargin)

narginchk(1,3)
if nargin <2
    Reso = ones(1,3);
elseif nargin>2
    figure('Name','Point View',...
        'InvertHardcopy','off',...
        'PaperPosition',[.6 .6 12 18],...
        'Position',[50 30 600 900],...
        'Color','w')
    axes('Position',[.08 .08 .85 .9])
end
if islogical(thindata)
    [y,x,z] = ind2sub(size(thindata),find(thindata(:)));
else
    % case xyz = thindata
    y = thindata(:,2);
    x = thindata(:,1);
    z = thindata(:,3);
end
plh = plot3((x-1)*Reso(1),(y-1)*Reso(2),(z-1)*Reso(3),'.');
daspect(ones(1,3))
grid on
set(gca,'Ydir','reverse')
box on
axis tight
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
hold on

if nargout>0
    varargout{1} = plh;
end
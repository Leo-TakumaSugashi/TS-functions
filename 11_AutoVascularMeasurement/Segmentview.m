function varargout  = Segmentview(SEG,varargin)

if nargin>2
    figure('Name','Point View',...
        'InvertHardcopy','off',...
        'PaperPosition',[.6 .6 12 18],...
        'Position',[50 30 600 900],...
        'Color','w')
    axes('Position',[.08 .08 .85 .9])
end
LineWidth = 1.5;
Reso = SEG.ResolutionXYZ;
plh = zeros(length(SEG.Pointdata),1);
txh = plh;
LEN = cat(1,SEG.Pointdata.Length);
 disp(['if you need...   set(gca,''Clim'',[0 ' num2str(max(LEN)) '])'])

map = jet(round(max(LEN)));
for n = 1:length(plh)
    xyz = SEG.Pointdata(n).PointXYZ;
    x = xyz(:,1);
    y = xyz(:,2);
    z = xyz(:,3);
    LEN = round(SEG.Pointdata(n).Length);
    if LEN<1
        LEN = 1;
    end
    plh(n) = plot3((x-1)*Reso(1),(y-1)*Reso(2),(z-1)*Reso(3),...
        'Color',map(LEN,:),'LineWidth',LineWidth);
    if n == 1
        hold on
    end
    ind = round(length(x)/2);
    txh(n) = text((x(ind)-1)*Reso(1),(y(ind)-1)*Reso(2),(z(ind)-1)*Reso(3),...
        num2str(n),'Fontsize',12);
    
    
end
colormap(map)
% set(txh,'BackgroundColor',ones(1,3))
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
    output.plh = plh;
    output.txh = txh;
    varargout{1} = output;
end
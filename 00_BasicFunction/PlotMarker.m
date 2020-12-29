function PlotMarker

figure('Posi',[50 50 500 400]),centerfig(gcf)
Marker = ['o';'+';'*';'.';'x';'s';'d';'^';'v';'>';'<';'p';'h'];
E = eye(length(Marker));
[y,x] = ind2sub(size(E),find(E(:)));
for n = 1:length(x)
    ph(n) = plot([x(n) 0],[y(n) (y(n))],[Marker(n) '--']);
    hold on
end
ph(end+1) = plot([-1 14 14 -1 -1],[-1 -1 14 14 -1]);
set(ph,'Markersize',12,'Linewidth',1.5);
set(gca,'Ydir','reverse')
grid
hold off,axis tight
legend('o','+','*','.','x','square','diamond','top triangle',...
    'under v','left >','right <','pentagram','hexagram','none',...
    'Location','BestOutside')

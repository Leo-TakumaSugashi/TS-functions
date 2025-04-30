
function varargout = TS_VolumeView(Image,Th,Reso)
%% input is bw data and Resolution(3Dimention)
% varargout = TS_VolumeView(Image,Th,Reso)
fgh = figure('Name','Volume View',...
        'InvertHardcopy','off',...
        'PaperPosition',[.6 .6 12 18],...
        'Position',[50 30 800 700],...
        'Color','w');
axes('Position',[.08 .08 .85 .9]);
xlabel('X')
ylabel('Y')
zlabel('Z')

X = ([1:size(Image,2)]-1) * Reso(1);
Y = ([1:size(Image,1)]-1) * Reso(2);
Z = ([1:size(Image,3)]-1) * Reso(3);
fv = isosurface(X,Y,Z,uint8(Image),Th);

p = patch(fv);
set(p,'EdgeColor','None',...
    'FaceColor',[.5 .5 .5]);
set(gca,'Ydir','reverse')
alpha(.5)
camh = camlight(2,134);
% camlight(camh,[2 -34]);
setappdata(fgh,'Userdata',p);
view(3)
daspect(ones(1,3))
axis tight
grid on
box on

if nargout>0
    varargout{1} = p;
end


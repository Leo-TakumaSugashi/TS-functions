%% line and marker colormap
x = linspace(0,10,30);
y = sin(x);
z = cos(x);
z(end) = nan;
y(end) = nan;
c = y;
figure
p = patch(x,y,z,c,'EdgeColor','interp','Marker','o','MarkerFaceColor','flat');
colorbar


%% face data and colormap
v = [2 4; 2 8; 8 4; 5 0; 5 2; 8 0; 8 8 ;8 2];
f = [1 2 7 3; 4 5 6 8];
col = [0; 0; 4; 2; 4; 4; 4; 2];
figure
patch('Faces',f,'Vertices',v,'FaceVertexCData',col,'FaceColor','interp',...
    'EdgeColor','none');
colorbar



h= Sugashi_ReconstructGroup;
xyz = [0 0 0; 1 1 0; 1 2 1; -1 3 5 ; 2 3 5]
D = [3, 3.4, 3.2, 2, 4]';
Reso = ones(1,3);
uvw = h.xyz2vectoraverage(xyz);
[Theta,Phi] = h.Rectangular2Spherical(xyz,Reso);
figure,
q = quiver3(xyz(:,1)-1,xyz(:,2)-1,xyz(:,3)-1,uvw(:,1),uvw(:,2),uvw(:,3));
hold on
p = xyz2plot(xyz,Reso);
p.LineWidth = 3;
q.LineWidth = 3;
hold on
axh = gca;
daspect(ones(1,3))

%% only XYplane polygon
for n = 1:size(xyz,1)
    [X,Y,Z] = h.makeCircle(xyz(n,:)-1,D(n),8);    
    PA(n) = patch(axh,'XData',X,'YData',Y,'ZData',Z);
end
%% rotation
for n = 1:size(xyz,1)
    [X,Y,Z] = h.makeCircle(xyz(n,:)-1,D(n),8);
    [X,Y,Z] = h.xyzRotate2Spherical(X,Y,Z,Theta(n),Phi(n));
    PB(n) = patch(axh,'XData',X,'YData',Y,'ZData',Z);
    for k = 1:3
        PB(n).EdgeColor = 'none';
        pause(.3),
        PB(n).EdgeColor = [1 0 0 ];
    end
end
%% test data
xyz = [0 0 0; 1 1 0; 1 1 1]
D = [2 ; 2.4; 2.2];
Reso = ones(1,3);
%%
len = cat(1,SEG.Pointdata.Length);
[~,ind] = max(len);
xyz = SEG.Pointdata(ind).PointXYZ;
D = rand(size(xyz,1),1)*2 + 2;

%% test xyzD2reconstruct
figure,
axh = axes;
Reso = ones(1,3);
p0 = h.xyzD2patch(axh,xyz,D,Reso);
xlabel('X'),ylabel('Y'),zlabel('Z'),
daspect(ones(1,3)),grid on, box on,view(3) 
[X,Y,Z,C] = h.xyzDiam2reconstruct(xyz,D);
pp = patch(axh,'XData',X,'YData',Y,'ZData',Z,'CData',C);
pp.EdgeColor = 'interp';
%% testing Rho and Yaw
Theta = 1.1530;
Phi = 0;
[x,y,z] = h.makeCircle([0 0 0],1,12);

figure,axh = axes;
p0 = patch(axh,x,y,z);
daspect(ones(1,3))
grid on
view(3)

% Rho
XYZ = zeros(3,length(x));
Rho = h.Rho(Theta)
for n = 1:length(x)
    A = cat(1,x(n),y(n),z(n));
    XYZ(:,n) = Rho * A;
end
p1 = patch(axh,XYZ(1,:),XYZ(2,:),XYZ(3,:));
p1.EdgeColor = [1 0 0 ];

% Yaw
XYZ = zeros(3,length(x));
Yaw = h.Yaw(pi/4)
for n = 1:length(x)
    A = cat(1,x(n),y(n),z(n));
    XYZ(:,n) = Yaw * A;
end
p2 = patch(axh,'XData',XYZ(1,:),'YData',XYZ(2,:),'ZData',XYZ(3,:));
p2.EdgeColor = [0 0 0.8 ];


% Rho* Yaw
T = Rho * Yaw
XYZ = zeros(3,length(x));
for n = 1:length(x)
    A = cat(1,x(n),y(n),z(n));
    XYZ(:,n) = T * A;
end
p3 = patch(axh,'XData',XYZ(1,:),'YData',XYZ(2,:),'ZData',XYZ(3,:));
p3.EdgeColor = [0 1 0.3];










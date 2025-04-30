function [vpmatrix,Fai,Theata,Label] = TS_GetMapVolume_proto(Vol,Center,R,varargin)
%  [vpmatrix,Fai,Theata,Label] = TS_GetMapVolume(Vol,Center,R,{VolumeReso})
%  VolumeReso is default [1 1 1]

global Reso
tic
if nargin > 3
    Reso = varargin{1};
else
    Reso = ones(1,3);
end

Step = pi/(18*5);

Fai = -pi/4:Step:(2*pi+pi/4);
Theata = ( -pi/4:Step:(5*pi/4) ) ;
vpmatrix = zeros(length(Theata),length(Fai));

fx  = @(thea,fai) sin(thea).*cos(fai);
fy = @(thea,fai) sin(thea).*sin(fai);
theata = cos(Theata) * (R/Reso(3) +1) + Center(3)/Reso(3)+1;
% figure,plot3(Center(1),Center(2),Center(3),'*r')
% hold on
% cmap = jet(length(Fai));
figure,imh = imagesc(max(rand(round(R*2+1),round(R*2+1)),[],3));
siz = size(Vol);

Yind = round(Center(2)-R:Center(2)+R);
Xind = round(Center(1)-R:Center(1)+R);
Zind = round(Center(3)-R:Center(3)+R);
Yind(Yind<1) = [];Yind(Yind>siz(1)) = [];
Xind(Xind<1) = [];Xind(Xind>siz(2)) = [];
Zind(Zind<1) = [];Zind(Zind>siz(3)) = [];
set(gca,'Clim',[min(Vol(:)) max(Vol(:))])
for  n= 1:length(theata)
    im = Vol(Yind,Xind,round(theata(n)));
    set(imh,'Cdata',im)
    axis image
    drawnow
end
close(gcf)

X = zeros(length(Theata),length(Fai));
Y = X;
Z = X;
for n = 1:length(Fai)
    xp = fx(Theata,Fai(n))*R + Center(1);
    yp = fy(Theata,Fai(n))*R + Center(2);
    X(:,n) = xp(:);
    Y(:,n) = yp(:);
    Z(:,n) = theata(:);
end
vpmatrix = interp3(single(Vol),X,Y,Z,'linear');
     


Label(1).name = 'Xdata';
Label(1).Tick = (Fai(1):pi/4:Fai(end))*(R );
Label(1).Label = {'-π/4';'0';'π/4';'π/2';'3π/4';'π';
            '5π/4';'3π/2';'7π/4';'2π[0]';'π/4'};
Label(2).name = 'Ydata';
Label(2).Tick = (Theata(1):pi/4:Theata(end)) *(R );
Label(2).Label = {'-π/4';'0';'π/4';'π/2';'3π/4';'π';'5π/4'};
toc
if nargin>3
    figure,imagesc(vpmatrix,'Xdata',Fai*R,'Ydata',Theata*R)
    set(gca,'XTick',Label(1).Tick,'XTickLabel',Label(1).Label)
    set(gca,'YTick',Label(2).Tick,'YTickLabel',Label(2).Label)
    grid on
    
    %% Valume Tex
    N = mode(Vol(:));
    S = max(Vol(:));
    im = Vol(Yind,Xind,Zind);
    fv = isosurface(im>(S-N)*0.3+N,0.5,im);
    [x,y,z] = sphere(length(im));
    x = x * R + R +1;
    y = y * R + R +1;
    z = z * R + R +1;
    figure,
    s = surface(x,y,z);
    hold on
    p = patch(fv,'Edgecolor','none','FaceColor','interp');
    plot3(R,R,R,'r*')
    alpha(p,.8)
    alpha(s,.5)
    ind_Fai_1 = and(Fai>=pi,Fai<=2*pi);
    ind_Fai_2 = and(Fai>0,Fai<pi);
    CData1 = vpmatrix(and(Theata>=0,Theata<=pi),ind_Fai_1);
    CData2 = vpmatrix(and(Theata>=0,Theata<=pi),ind_Fai_2);
    CData  = cat(2,CData1,CData2);
    sd.CData = flip(CData,1);                % set color data to topographic data
    sd.FaceColor = 'texturemap';    % use texture mapping
    sd.EdgeColor = 'none';          % remove edges
    sd.FaceLighting = 'gouraud';    % preferred lighting for curved surfaces
    sd.SpecularStrength = 0.4;      % change the strength of the reflected light
    set(s,sd)
    daspect([1 1 1])
    view(3)
end
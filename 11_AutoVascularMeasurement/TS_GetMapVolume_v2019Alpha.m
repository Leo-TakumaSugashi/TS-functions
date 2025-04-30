function [vpmatrix,Fai,Theata,Label] = TS_GetMapVolume_v2019Alpha(Vol,Center,R,varargin)
%  [vpmatrix,Fai,Theata,Label] = TS_GetMapVolume_v....(Vol,Center,R,{VolumeReso})
%  VolumeReso is default [1 1 1]
% ++++ input ++++
% vol        : input volume image,
% Center,    : index of Center, unit pix.(vox.)
% R          : Radius, unit [um],(dependence on Resolution)
% VolumeReso : Volume Resolution [X,Y,Z]
% 
%   if nargin > 4, output figure,
% ==================================================
% edit  2019, Oct. 20th, by Sugashi,
% 

%% initialize
global Reso
if nargin > 3
    Reso = varargin{1};
else
    Reso = ones(1,3);
end
siz = size(Vol);
Step = pi/(18*5);

Fai = -pi/4:Step:(2*pi+pi/4);
Theata = ( -pi/4:Step:(5*pi/4) ) ;
Label(1).name = 'Xdata';
Label(1).Tick = (Fai(1):pi/4:Fai(end))*(R );
Label(1).Label = {'-π/4';'0';'π/4';'π/2';'3π/4';'π';
            '5π/4';'3π/2';'7π/4';'2π[0]';'π/4'};
Label(2).name = 'Ydata';
Label(2).Tick = (Theata(1):pi/4:Theata(end)) *(R );
Label(2).Label = {'-π/4';'0';'π/4';'π/2';'3π/4';'π';'5π/4'};

%% main
fx  = @(thea,fai) sin(thea).*cos(fai);
fy = @(thea,fai) sin(thea).*sin(fai);
theata = cos(Theata)*R./Reso(3) + Center(3);

X = zeros(length(Theata),length(Fai));
Y = X;
Z = X;
for n = 1:length(Fai)
    xp = fx(Theata,Fai(n))*R./Reso(1) + Center(1);
    yp = fy(Theata,Fai(n))*R./Reso(2) + Center(2);
    X(:,n) = xp(:);
    Y(:,n) = yp(:);
    Z(:,n) = theata(:);
end
vpmatrix = interp3(single(Vol),X,Y,Z,'linear');

%% output figures
if nargin>4
    figure,imagesc(vpmatrix,'Xdata',Fai*R,'Ydata',Theata*R)
    set(gca,'XTick',Label(1).Tick,'XTickLabel',Label(1).Label)
    set(gca,'YTick',Label(2).Tick,'YTickLabel',Label(2).Label)
    grid on
    
    %% Valume Tex
    
    xdata = 1:siz(2);
    ydata = 1:siz(1);
    zdata = 1:siz(3);
    Xind = and(xdata<Center(1)+R/Reso(1),...
        xdata>Center(1)-R/Reso(1));
    Yind = and(ydata<Center(2)+R/Reso(2),...
        ydata>Center(2)-R/Reso(2));
    Zind = and(zdata<Center(3)+R/Reso(3),...
        zdata>Center(3)-R/Reso(3));
    
    im = single(Vol(Yind,Xind,Zind));
    
    N = mode(im(:));    
    im  = im - N;
    S = max(im(:));
    im = im ./ S;
    
    fv = isosurface(find(Xind),find(Yind),find(Zind),im>0.3,0.3,im);
    [x,y,z] = sphere(length(im));
    x = x*R/Reso(1) +Center(1);
    y = y*R/Reso(2) +Center(2);
    z = z*R/Reso(3) +Center(3);
%     z = z * R + R/Reso(1) +1;
    figure,
    s = surface(x,y,z);
    hold on
    p = patch(fv,'Edgecolor','none','FaceColor','interp');
%     plot3(R,R,R,'r*')
    plot3(Center(1),Center(2),Center(3),'r*')
    
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
%     daspect([1 1 1])
    daspect(1./[Reso(1) Reso(2) Reso(3)])
    view(3)
end
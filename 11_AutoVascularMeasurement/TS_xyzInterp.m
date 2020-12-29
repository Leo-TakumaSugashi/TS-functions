function [ix,iy,iz,iL,varargout] = TS_xyzInterp(xyz,Reso,Step,varargin)
% output NewXYZ,L is[ X  Y  Z] , Length
% [NewXYZ,PeiceLength,ActualStep] = ...
%     TS_xyzIntep(xyz,Reso,Step,{'{pchip}','spline','linear'})

LineWidth = 2;

if nargin==4
    Type = varargin{1};
    Fig = 'none';
elseif nargin == 5
    Type = varargin{1};
    Fig = varargin{2};
else
    Type = 'pchip';
    Fig = 'none';
end

x = xyz(:,1);
y = xyz(:,2);
z = xyz(:,3);

% x = TS_MovingAverage(x,3);
% y = TS_MovingAverage(y,3);
% z = TS_MovingAverage(z,3);

PieceLength = xyz2plen(xyz,Reso);
PLen_xdata = cumsum(PieceLength);
PLen_ixdata = linspace(0,sum(PieceLength),sum(PieceLength)/Step);
Actual_Step = diff(PLen_ixdata(1:2));
% IPLength = interp1(PLen_xdata,PieceLength,PLen_ixdata,Type);

% output 
iL = PLen_ixdata;
ix = interp1(PLen_xdata(:),x(:),PLen_ixdata(:),Type);
iy = interp1(PLen_xdata(:),y(:),PLen_ixdata(:),Type);
iz = interp1(PLen_xdata(:),z(:),PLen_ixdata(:),Type);
NewLength = sum(xyz2plen(cat(2,ix,iy,iz),Reso));
% disp(['New Length :' num2str(NewLength) ' um'])
% disp(['( Input Length :' num2str(sum(PieceLength)) ' um )'])

if nargout==5
    varargout{1} = Actual_Step;
elseif nargout == 6
    varargout{1} = Actual_Step;
    varargout{2} = NewLength;
end

%% figure for check
x = xyz(:,1) ;
y = xyz(:,2) ;
z = xyz(:,3) ;

switch Fig
    case 'none'
    otherwise
        figure('posi',[50 40 1200 900],...
            'PaperPosition',[.6 .6 20 18],...
            'Color','w')
        Limadd = .5;
        axh(1) = axes('posi',[.05 .7 .35 .25]);
         px(1) = plot(PLen_xdata,x,'o');hold on
         px(2) = plot(PLen_ixdata,ix,'r-','LineWidth',LineWidth);
         set(px,'parent',axh(1))
         set(axh(1),'Ylim',[min(ix)-Limadd max(ix)+Limadd],'Xlim',[0 PLen_xdata(end)])
         ylabel('Axis X [pixels]'),grid on,
        axh(2) = axes('posi',[.05 .4 .35 .25]);
         py(1) = plot(PLen_xdata,y,'o');hold on
         py(2) = plot(PLen_ixdata,iy,'r-','LineWidth',LineWidth);
         set(py,'parent',axh(2))
         set(axh(2),'Ylim',[min(iy)-Limadd max(iy)+Limadd],'Xlim',[0 PLen_xdata(end)])
         ylabel('Axis Y [pixels]'),grid on,
        axh(3) = axes('posi',[.05 .1 .35 .25]);
         pz(1) = plot(PLen_xdata,z,'o');hold on
         pz(2) = plot(PLen_ixdata,iz,'r-','LineWidth',LineWidth);
         set(pz,'parent',axh(3))
         set(axh(3),'Ylim',[min(iz)-Limadd max(iz)+Limadd],'Xlim',[0 PLen_xdata(end)])
         ylabel('Axis Z [pixels]'),grid on,
         xlabel('Length [\mum]')
        axh(4) = axes('posi',[.5 .1 .48 .8]);
         p(1) = plot3((x-1)*Reso(1),(y-1)*Reso(2),(z-1)*Reso(3),'o'); hold on
         p(2) = plot3((ix-1)*Reso(1),(iy-1)*Reso(2),(iz-1)*Reso(3),'r-','LineWidth',LineWidth);
         set(p,'Parent',axh(4)),axis tight
         grid on, box on 
         title('Actual size [\mum]')
         xlabel('X [\mum]')
         ylabel('Y [\mum]')
         zlabel('Z [\mum]')
         daspect([1 1 1])
end
end
        
        
        
        
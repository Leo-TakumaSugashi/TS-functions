function varargout = TS_SNplot(S,Smax,N,Nmax,zdata)
% TS_SNplot(S,Smax,N,Nmax,zdata)

nN = N/Nmax * Smax;

Ncolor = [0 0 1];
Scolor = [1 0 0];
figure('Name',mfilename)
 axes('posi',[.125 .15 .75 .8],...
     'YAxisLocation','right',...
     'YColor',Ncolor,...
     'Ylim',[0 Nmax],...
     'XTickLabel','')
 ylabel('Noise [a.u.]')
 axes('posi',[.125 .15 .75 .8],...
     'YColor',Scolor,...
     'Ylim',[0 Smax])
 sph = plot(zdata,S,'o','Color',Scolor);hold on
 nph = plot(zdata,nN,'^','Color',Ncolor);

legend('Signal (Axis left)','Noise (Axis right)')

xlabel('Depth [\mum]')
ylabel('Signal [a.u.]')
set(gca,'YLim',[0 Smax],'Xlim',[min(zdata) max(zdata)])

if nargout==1
    varargout{1} = [sph nph];
end
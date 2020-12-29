function [V,fgh,BH] = TS_Reco2CellVolume(D,Dist,AnalysisLim,Sind,zReso)
% varargin = TS_Reco2CellVolume(Reconst_data,Cell_Dist,AnalysisLim,Surface_ind,zReso)
% Surface_ind is from Last(slice)




%% Main Func.
D = flip(D,3);
Dist = flip(Dist,3);
AnalysisLim = flip(AnalysisLim,3);
zdata = (1:size(Dist,3) ) - Sind;

zstep = 0:50:zdata(end);
if zstep(end) ~= zdata(end)
    zstep = [zstep zdata(end)];
end
Vall_lim = zeros(1,length(zstep));
Vves_lim = Vall_lim;
Vves_lim_ori = Vall_lim;
Vcell_lim10 = zeros(1,length(zstep));
Vcell_lim20 = Vcell_lim10;
Vcell_lim30 = Vcell_lim10;
Vcell_limLast = Vcell_lim10;
Zdata = Vall_lim;
for n = 1:length(zstep)
    if n == 1
        z = zdata<=0;
    else
        z = and(zdata>zstep(n-1),zdata<=zstep(n));
    end
    Zdata(n) = mean(zdata(z));
    V_lim = AnalysisLim(:,:,z);
    ves = D(:,:,z);
    
    Numel = sum(V_lim(:));
    Vall_lim(n) = Numel/numel(V_lim) * 100;
    Vves_lim_ori(n) = sum(ves(:)) / numel(ves) * 100;
    Vves_lim(n) = sum(ves(:))/Numel * 100;
    
    V_Dist = Dist(:,:,z) .* single(V_lim);
    V10 = and(V_Dist>0,V_Dist<=10);
    V20 = and(V_Dist>10,V_Dist<=20);
    V30 = and(V_Dist>20,V_Dist<=30);
    Vall = V_Dist>30;
    Vcell_lim10(n) = sum(V10(:)) / Numel * 100;
    Vcell_lim20(n) = sum(V20(:)) / Numel * 100;    
    Vcell_lim30(n) = sum(V30(:)) / Numel * 100;
    Vcell_limLast(n) = sum(Vall(:)) / Numel * 100;
end
Zdata = Zdata *zReso;

%% figure
fgh = figure;
% Zdata = zstep * zReso;
map = jet(6);
map = rgb2hsv(map);
map(:,3) = linspace(0.2,1,size(map,1));
map = hsv2rgb(map);
axes('posi',[0.15 .58 .8 .37])
    bh(1) = bar(Zdata,Vall_lim,'FaceColor',map(1,:));
    hold on
    bh(2) = bar(Zdata,Vves_lim_ori,'FaceColor',map(6,:));
    legend('Analysis Volume','Vasucular Volume','location','best')
    ylabel('Volume [%]')
axes('posi',[0.15 .15 .8 .37])
    ydata = Vves_lim;
    bh1(1) = bar(Zdata,ydata,'FaceColor',map(6,:));
    hold on
    ydata = Vcell_lim10 + ydata;
      bh1(2) = bar(Zdata,ydata,'FaceColor',map(5,:));
    ydata = Vcell_lim20 + ydata;
      bh1(3) = bar(Zdata,ydata,'FaceColor',map(4,:));
    ydata = Vcell_lim30 + ydata;
      bh1(4) = bar(Zdata,ydata,'FaceColor',map(3,:));
    ydata = Vcell_limLast + ydata;
      bh1(5) = bar(Zdata,ydata,'FaceColor',map(2,:));
      set(gca,'Children',bh1)
      legend('>30\mum','>20\mum','>10\mum','>0\mum','Vascular','location','best')
      ylabel('Normalized Volume [%]')
      xlabel('Depth [\mum]')
% if nargout>0
    V = cat(1,Zdata,...
        Vall_lim,Vves_lim_ori,Vves_lim,...
        Vcell_lim10,Vcell_lim20,Vcell_lim30,Vcell_limLast);
%     varargout{1} = V;
% elseif nargout > 1
%     varargout{2} = fgh;
% elseif nargout > 2
%     varargout{3} = [bh bh1];
% end
BH = [bh bh1];





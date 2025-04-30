function TS_BeadsAnalysis_OutputFigure(Surf,data,Cropdata,checkON)

Reso = Cropdata(1).Resolution;
%% Figure

f = figure('Posi',[10 100 1500 800],'Name','Result of Beads Analysis');    
axh = TS_subplot(f,[4 2],0.03);
for n =1:length(axh)
    axh(n).Position(4) = 0.38;
end

%% Depth vs FWHM
Depth = cat(1,Cropdata.centroidXYZ);
Depth = abs( Surf - Depth(:,3) ) * Reso(3) ;
map = [1 .3 0; 0 1 0; .3 0 1]*0.8;

% fwhm = CatStruct(data,'FWHM','X');
fwhmx = cat(1,data.FWHM_X);

    plot(axh(1),Depth,fwhmx,'o','Color',map(1,:))
    hold(axh(1),'on');
    if checkON
        for n = 1:length(Depth)
            text(axh(1),Depth(n),fwhmx(n),num2str(n),'Color',map(1,:))
        end
    end
fwhmy = cat(1,data.FWHM_Y);
% fwhm = CatStruct(data,'FWHM','Y');
    plot(axh(1),Depth,fwhmy,'^','Color',map(2,:))
    if checkON
        for n = 1:length(Depth)
            text(axh(1),Depth(n),fwhmy(n),num2str(n),'Color',map(2,:))
        end
    end
% fwhm = CatStruct(data,'FWHM','Z');
fwhmz = cat(1,data.FWHM_Z);
    plot(axh(1),Depth,fwhmz,'x','Color',map(3,:))
    if checkON
        for n = 1:length(Depth)
            text(axh(1),Depth(n),fwhmz(n),num2str(n),'Color',map(3,:))
        end
    end
title(axh(1),'Depth VS FWHM'),
xlabel(axh(1),'Depth [\mum]')
ylabel(axh(1),'FWHM [\mum]')
legend(axh(1),'Line-X','Line-Y','Line-Z')

%% Depth VS Signal
S = cat(1,data.Signal);

    plot(axh(2),Depth,S,'o','Color',map(1,:))
    hold(axh(2),'on');
    if checkON
        for n = 1:length(Depth)
            text(Depth(n),double(S(n)),num2str(n),'Color',map(1,:))
        end
    end
title(axh(2),'Depth vs Signal'),
xlabel(axh(2),'Depth [\mum]')
ylabel(axh(2),'Signal [a.u.]')

%% Depth VS Noise
N = cat(1,data.Noise);

    plot(axh(3),Depth,N,'^','Color',map(3,:))
    hold(axh(3),'on');
    if checkON
        for n = 1:length(Depth)
            text(Depth(n),N(n),num2str(n),'Color',map(3,:))
        end
    end
title(axh(3),'Depth vs Noise'),
xlabel(axh(3),'Depth [\mum]')
ylabel(axh(3),'Noise [a.u.]')

%% Depth VS SNR

    plot(axh(4),Depth,S./N,'s','Color',map(2,:))
    hold(axh(4),'on');
    if checkON
        for n = 1:length(Depth)
            text(axh(4),Depth(n),double(S(n)/N(n)),num2str(n),'Color',map(2,:))
        end
    end
title(axh(4),'Depth vs SNR'),    
xlabel(axh(4),'Depth [\mum]')
ylabel(axh(4),'SNR')



%% fwhm vs snr

    plot(axh(5),S./N,fwhmx,'o','Color',map(1,:))
    SNR = double(S./N);
    hold(axh(5),'on');
    if checkON
        for n = 1:length(SNR)
            text(axh(5),SNR(n),fwhmx(n),num2str(n),'Color',map(1,:))
        end
    end
    plot(axh(5),S./N,fwhmy,'^','Color',map(2,:))
    if checkON
        for n = 1:length(SNR)
            text(axh(5),SNR(n),fwhmy(n),num2str(n),'Color',map(2,:))
        end
    end
    plot(axh(5),S./N,fwhmz,'x','Color',map(3,:))
    if checkON
        for n = 1:length(SNR)
            text(axh(5),SNR(n),fwhmz(n),num2str(n),'Color',map(3,:))
        end
    end
title(axh(5),'snr VS FWHM')    
xlabel(axh(5),'SNR')
ylabel(axh(5),'FWHM [\mum]')
legend(axh(5),'Line-X','Line-Y','Line-Z')


%% fwhm vs snr

    plot(axh(6),S,fwhmx,'o','Color',map(1,:))
    hold(axh(6),'on');
    plot(axh(6),S,fwhmy,'^','Color',map(2,:))
    plot(axh(6),S,fwhmz,'x','Color',map(3,:))
    if checkON
        S = double(S);fwhmx = double(fwhmx);fwhmy = double(fwhmy);fwhmz = double(fwhmz);
        for n = 1:length(S)
            text(axh(6),S(n),fwhmx(n),num2str(n),'Color',map(1,:))
            text(axh(6),S(n),fwhmy(n),num2str(n),'Color',map(2,:))
            text(axh(6),S(n),fwhmz(n),num2str(n),'Color',map(3,:))    
        end
    end

title(axh(6),'Signal VS FWHM')
xlabel(axh(6),'Signal ')
ylabel(axh(6),'FWHM [\mum]')
legend(axh(6),'Line-X','Line-Y','Line-Z')




%% snr vs Threshold

Ax = cat(1,data.Actual_ThresholdX);
    plot(axh(7),S./N,Ax,'o','Color',map(1,:));
    hold(axh(7),'on');
Ay = cat(1,data.Actual_ThresholdY);
    plot(axh(7),S./N,Ay,'^','Color',map(2,:));
Az = cat(1,data.Actual_ThresholdZ);
    plot(axh(7),S./N,Az,'x','Color',map(3,:));
title(axh(7),'snr VS threshold'),
xlabel(axh(7),'SNR')
ylabel(axh(7),'Threshold ')
legend(axh(7),'Line-X','Line-Y','Line-Z')


%% fwhm vs signal

plot(axh(8),S,Ax,'o','Color',map(1,:))
hold(axh(8),'on');
plot(axh(8),S,Ay,'^','Color',map(2,:))
plot(axh(8),S,Az,'x','Color',map(3,:))
title(axh(8),'Signal VS Threshold')


xlabel(axh(8),'Signal ')
ylabel(axh(8),'Threshold')
legend(axh(8),'Line-X','Line-Y','Line-Z')












    

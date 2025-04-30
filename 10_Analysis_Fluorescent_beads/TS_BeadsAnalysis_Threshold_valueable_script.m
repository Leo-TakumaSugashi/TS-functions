DIR = dir('*edit*');
% ans =
%     'serch_mot15_z700_100_edit.mat'
% ans =
%     'serch_mot25_z700_100_edit.mat'
% ans =
%     'serch_mot35_z700_100_edit.mat'
% ans =
%     'serch_mot55_z700_100_edit.mat'
% ans =
%     'serch_mot5_z700_100_edit.mat'

TH = [0.3 0.4 0.5 0.6];
Marker = {'s','o','^','x'}
Len = 5;

for n = 1:length(DIR)
load(DIR(n).name,'Cropdata')
load(DIR(n).name,'Result')
Diameter = zeros(1,length(Cropdata));
ThVal(1:3) = struct('Diameter',[],'Threshold',[]);
Signal = cat(2,Result.Signal);

fgh = figure('Name','Diameter_vs_Signal');

for th = 1:length(TH)
parfor k = 1:length(Cropdata)
Reso = Cropdata(k).Resolution;
fImage = Cropdata(k).fImage;
c = round(Cropdata(1).CenterOfImage);
skel = false(size(fImage));
skel(c(2),c(1),c(3)) = true;
output = TS_AutoAnalysisDiam_AddAdjPreFWHM_perSlice_th(fImage,skel,Reso,Len,TH(th));
Diameter(k) = output.Pointdata.Diameter;
end
clear output skel c fImage Reso c
ThVal(th).Diameter = Diameter; 
ThVal(th).Threshold = TH(th);
plot(Signal,Diameter,Marker{th})
hold on
end

xlabel('Signal')
ylabel('Diamter [\mum]')
legend('30%','40%','50%','60%')

save(DIR(n).name,'ThVal','-append')

cd(['Fig_' DIR(n).name(1:end-9)])
saveas(fgh,'Signal_vs_Diameter.fig')
saveas(fgh,'Signal_vs_Diameter.tif')
close(fgh)
cd ..
clear Cropdata Result Diameter ThVal
end


%%
val = [60 50 40 30]
% title('mot 5')
ch = findobj('Type','line');
D = [];
for n = 1:length(ch)
    y = ch(n).YData;
    D = [D y(:)];
    Ave(n) = nanmean(y) - 1.1;
    V(n) = nansum((y - 1.1).^2) / (sum(~isnan(y)));
    SD(n) = nanstd(y);
    disp([num2str(nanstd(y)) num2str(V(n))])
    ch(n).DisplayName = [num2str(val(n)) ...
                '% (' num2str(round(Ave(n)*100)/100) ' Å} ' ...
                    num2str(round(SD(n)*100)/100) ' )'];
end
% title('(val.) =  sqrt(sum( Diameter - 1.1 [um]).^2))')
title('')
xlim([0 100])
ylim([0 5])
figure('Name','Threshold_vs_Uncertainty')
 errorbar(val,Ave,SD,'lineWidth',2);
 xlabel('threshold [%]'), ylabel('Uncertainty and Accuracy [\mum]')
 xlim([20 70]), ylim([-1 1])
    saveas(gcf,'Threshold_Uncertainty.fig')
    saveas(gcf,'Threshold_Uncertainty.tif')
R = num2cell(cat(1,val,Ave,SD));
R = cat(2,{'threshld';'Average';'SD'},R);
D = cat(2,cell(size(D,1),1),num2cell(D));
R = cat(1,R,D);clear D
% xlswrite('Thresold_const.xlsx',R)
clear R y D Ave V SD ch 







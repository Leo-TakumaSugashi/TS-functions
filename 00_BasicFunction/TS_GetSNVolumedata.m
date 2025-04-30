function Output = TS_GetSNVolumedata(Image,varargin)
%% This Function calculate SN about varable value
% OutPut = TS_GetSNVolumedata(Image,ResoZ,bw)

bwSignalON = false;
Reso_Z = 5;
bw = [];
if nargin > 1, Reso_Z = varargin{1}; end
if  nargin > 2, 
    bwSignalON = true;
    bw = varargin{2};
    if ~islogical(bw)
        bwSignalON = false;
        bw = [];
    end
end

%% SET
MSE = zeros(1,size(Image,3)); %% Mean Square Error
NMSE = MSE;
S = MSE;
S_th = 0.05;
S5per = S;
Sf = S;
if bwSignalON, SbwAve = S; NbwAve = S;
else SbwAve = []; NbwAve = [];
end
N = MSE;
Min = N;
STD = MSE;
h = fspecial('gaussian',11,1.8);

%% Main
wh = waitbar(0,mfilename);
for n = 1:size(Image,3)
im = double(Image(:,:,n));
N(n) = mode(im(and(im>0,im<max(im(:))))); %% 今までの最頻値計算用
Min(n) = min(im(:));
S(n) = max(im(:)); %% Signlaは最大値を適用
% % % 5 percent of Average(Maximum to 5% Volume==image)
sort_im = sort(double(im(:)),'descend');
S5per(n) = mean(sort_im(1:round(length(sort_im)*S_th)));
fim = imfilter(im,h,'symmetric');
Sf(n) = max(fim(:));
Matrix_mse = im - fim;
MSE(n) = mean(Matrix_mse(:).^2);
NMSE(n) = MSE(n)/mean(fim(:).^2);
STD(n) = std(Matrix_mse(:));
if bwSignalON
   IND = bw(:,:,n);
   SbwAve(n) = mean(im(IND));
   NbwAve(n) = mean(im(~IND));
end
waitbar(n/size(Image,3),wh)
end
close(wh)
Output.SignalMax = S;
Output.SignalMax_f = Sf;
Output.Signal5per = S5per;
Output.SignalInBWofAverage = SbwAve;
Output.Mode = N;
Output.NoiseMin = Min;
Output.NoiseInNotBWofAverage = NbwAve;
Output.MSE = MSE;
Output.NMSE = NMSE;
Output.STDmse = STD;

% TMaximum = max([max(S) max(Sf) max(S5per) max(SbwAve)]);
TMaximum = max([max(S) max(S5per) max(SbwAve)]);
TMaximum = TMaximum + max(TMaximum)*0.01;
% TMaximum = ceil(TMaximum / (10^ceil(log10(TMaximum)-2))) * (10^ceil(log10(TMaximum)-2)); % / 10^ceil(log10(TMaximum)) ) * 10
% BMaximum = max([max(N) max(MSE) max(NMSE) max(STD) max(NbwAve) max(Min)]);
BMaximum = max([max(N) max(NbwAve) max(Min)]);
BMaximum = BMaximum + max(BMaximum)*0.1;
% BMaximum = ceil(BMaximum / (10^ceil(log10(BMaximum)-2))) * (10^ceil(log10(BMaximum)-2));
Rati = TMaximum / BMaximum;
if nargin >1
    if strcmpi(varargin{end},'figure')
        fgh = figure;
        axh(1) = axes('Posi',[.1 .1 .8 .85]);
        
        axh(2) = axes('Posi',[.1 .1 .8 .85]);
        set(axh,'Fontsize',12);
        plot(S,'pentagram-r')
        hold on
%         plot(Sf,'diamond-.r')
        plot(S5per,'^-r')
%         if bwSignalON
            plot(SbwAve,'square--r')
%         end
        
        plot(N*Rati,'pentagram-k')
        plot(Min*Rati,'diamond-.k')
        plot(NbwAve*Rati,'o-.k')
%         plot(10*log10(MSE) * Rati,'diamond--k')
%         plot(NMSE*Rati,'square-k')
%         plot(STD*Rati,'^--k')
        
        ch = get(axh(2),'Children');        
        xdata = flip(get(ch(1),'Xdata'),2);
        xdata = xdata * Reso_Z;
        set(ch,'Xdata',xdata,'Markersize',7)
        
        set(axh(1),'YaxisLocation','right','XTickLabel',[],'Ylim',[0 BMaximum])
        set(axh(2),'Ylim',[0 TMaximum],'Xlim',[0 max(xdata)],'YColor','r')
%         legend('Signal(Max.)','Signal(filtered Max.)',['Signal(' num2str(S_th*100) '%)'],'Ave. in bw',...
%             'mode','Noise(Min.)','Ave. in Not bw','Mean Square Error[dB]','Normalized MSE','STD')
        legend('Signal(Max.)',['Signal(' num2str(S_th*100) '%)'],'Ave. in bw',...
            'mode','Noise(Min.)','Ave. in Not bw')
        grid on
        xlabel(axh(2),'Depth [\mum]')
        ylabel(axh(2),'Pixels value(Signal) [a.u.]')
        ylabel(axh(1),'Pixels value(Noise) [a.u.]')
        setappdata(fgh,'SNR',Output)
        
    end
end

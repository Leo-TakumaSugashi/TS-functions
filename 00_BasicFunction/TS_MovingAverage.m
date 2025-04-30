function A = TS_MovingAverage(data,val)
% Input is Vector data and windwsize si nessesary integer number

if ~isvector(data)
    error('Input is not vector....TS_MovingAverage');
end
if or(isempty(data),val<=1)
    A = data;
    return    
end
siz = size(data);

data = double(data(:));

%% odd number
if ceil(val/2)~=floor(val/2)
    % pdata = padarray(data,[val 0],'replicate');
    pdata = padarray(data,[(val+1)/2 0],'symmetric');
     % reverse value 
    pdata(1:(val-1)/2) =  data(1) - (pdata(1:(val-1)/2)-data(1));
    pdata(end-(val-1)/2+1:end) = data(end) - (pdata(end-(val-1)/2+1:end) - data(end));
     % erase endpoint of input data
    pdata([(val-1)/2+1 length(pdata)-(val-1)/2]) = [];
    Filter_data = filter(ones(val,1),val,pdata,[],1);
    ind = 1:length(Filter_data);
    Index = and(ind>=val, ind<length(ind)+val-1);
    
    A = Filter_data(Index);
    A = reshape(A,siz);    
    
%     figure,plot(data,'o:'),
%     hold on
%     plot(pdata,'ro:')
%     plot(Filter_data(Index),'go:')
%     
    %% check figure
%     figure('PaperPosition',[.6 .6 24 15])
%     plot(0:length(data)-1,data,'o-','linewidth',3)
%     xlabel('Time [sec/unit]')
%     hold on
%     % plot(0:length(data)-1,filter(ones(val,1),val,data),'rx:','linewidth',2),return
%     plot((0:length(pdata)-1)-val, pdata,'o:','linewidth',2,'Markersize',12,'Color',[0 .7 0])
%     plot((0:length(Filter_data)-1)-val - floor((val-1)/2), Filter_data,...
%         '+r--','LineWidth',2.5,'Markersize',12)
% %     plot(0:length(data)-1,A,'r-')
%     grid on    

%% even number
elseif ceil(val/2)==floor(val/2)
    vali = (val-1)*2 + 1;
    x = (1:length(data))';
    xi = (1:0.5:length(data))';
    datai = interp1(x,data,xi,'linear');
    
    datai = TS_MovingAverage(datai,vali);
    datai(2:2:end-1) = [];
    A = datai;
else
    error('Input is not correct ')
end






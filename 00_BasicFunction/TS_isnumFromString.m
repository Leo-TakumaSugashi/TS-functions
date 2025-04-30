function ISLabel = TS_isnumFromString(STR)
%  ISLabel = TS_isnumFromString('string')
%  
%  % example 1
%  STRING = '[ String_check002.jpg]';
%  index_numeric = TS_isnumFromString(STRING)
%  str2double(STRING(~isnan(index_numeric)))
%  clear STRING index_numeric 
%  
%  % example 2
%  STRING = '[ 50String082check002.jpg]';
%  index_numeric = TS_isnumFromString(STRING)
%  [label_numeric,Num] = bwlabel(~isnan(index_numeric));
%  OutputNum = zeros(1,Num);
%  for nn = 1:Num
%      OutputNum(nn) = str2double(STRING(label_numeric==nn));
%  end
%  display(OutputNum)
%  clear STRING inde_numeric label_numeric Num OutputNum nn



if ~isvector(STR)
    error('input String must be vector data')
end
ISLabel = nan(size(STR));
for n = 1:length(STR)
    ISLabel(n) = str2double(STR(n));
end
ISLabel(imag(ISLabel)==1) = nan;
ISLabel = real(ISLabel);
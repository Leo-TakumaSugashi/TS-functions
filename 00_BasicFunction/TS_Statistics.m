function varargout = TS_Statistics(data,varargin)
% A = TS_Statistics(data,{type})
% Input 
%     data : Matrix
% output
%     A ; Structure or vector
% 
% main func.
% A.Maximum = nanmax(data(:));
% A.Minimum = nanmin(data(:));
% A.Median = nanmedian(data(:));
% A.Average = nanmean(data(:));
% A.StandardDeviation = nanstd(data(:));
% A.NumberOfElements = numel(data);
% A.NumberOfIsNaN = sum(isnan(data(:)));
% A.MatrixSize = size(data);

%         edit by Sugashi 2017 04 12

if nargin == 2
    type = varargin{1};
else
    type = 'struct';
end
if and(nargin==1,nargout==0)
    type = 'figure';
end

data = double(data);
A.Maximum = nanmax(data(:));
A.Minimum = nanmin(data(:));
A.Median = nanmedian(data(:));
A.Average = nanmean(data(:));
A.StandardDeviation = nanstd(data(:));
A.NumberOfElements = numel(data);
A.NumberOfIsNaN = sum(isnan(data(:)));
A.MatrixSize = size(data);

switch lower(type)
    case 'struct'
        output = A;
    case {'matrix','[]','vector'}
        output = [...
            double(A.Maximum);
            double(A.Minimum);
            double(A.Median);
            double(A.Average);
            double(A.StandardDeviation);
            double(A.NumberOfElements);
            double(A.NumberOfIsNaN)];
    case 'figure'
        output = A;
        figure
        BIN = round(A.Maximum - A.Minimum + 1);
        BIN = max(BIN,10);
        BIN = min(BIN,256);
        [h,x] = hist(data(:),BIN);
        bar(x,h,'hist')
        axis tight
        YLIM = ylim(gca);
        XLIM = xlim(gca);
%         text(XLIM(1),0,num2str(Min))
        text(XLIM(2)-diff(XLIM)*0.3,YLIM(2)-diff(YLIM)*0.2,...
            {['Max. ' num2str(A.Maximum) ];['Min. ' num2str(A.Minimum)]})
        text(double(A.Median),mean(YLIM),{'Med. '; num2str(A.Median)})
        text(mean(XLIM),mean(YLIM),...
            {'Ave . Å} SD.';...
            [num2str(A.Average) ' Å} ' num2str(A.StandardDeviation)]})
        title(['Number of Elements ' ...
            num2str(A.NumberOfElements) ' (NaN ' num2str(A.NumberOfIsNaN) ')'])
        xlabel('Value')
        ylabel('Number of value (Frequency)')        
    otherwise
        disp(['  Error Message ...'  mfilename('fullpath')])
        error('  ...  Input is NOT Correct')
end


if nargout == 1
    varargout = output;
end



function varargout = Figure(varargin)
fgh = figure(varargin{:});
WinOnTop(fgh,true);
if nargout ==1
    varargout{1} = fgh;
end
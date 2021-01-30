function varargout = SEGview(varargin)
% varargout = SEGview(varargin)
% SEGview(SEG)
% SEGview(SEG,{structure_name})
% SEGview(axh,SEG,...)
% handle = SEGview(...)
% 
% see also Sugashi_ReconstructGroup
V = Sugashi_ReconstructGroup;
[axh,SEG,Type] = input_param(varargin{:});
p = V.SEGview_Limit(axh,SEG,Type);
if nargout >0
    varargout{1} = p;
end
end

function [axh,SEG,Type] = input_param(varargin)
p1 = varargin{1};
if ishandle(p1)
    axh = p1;
    SEG = varargin{2};
    if nargin==3
        Type = varargin{3};
    else
        Type = 'same';
    end
elseif isstruct(p1)
    axh = [];
    SEG = p1;
    if nargin==2
        Type = varargin{2};
    else
        Type = 'same';
    end
end
end

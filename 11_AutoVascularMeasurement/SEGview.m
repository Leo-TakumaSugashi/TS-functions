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

xmax = (SEG.Size(1)-1)*SEG.ResolutionXYZ(1);
ymax = (SEG.Size(2)-1)*SEG.ResolutionXYZ(2);
zmax = (SEG.Size(3)-1)*SEG.ResolutionXYZ(3);

axh = p.Parent;
xlim(axh,[0 xmax])
ylim(axh,[0 ymax])
if SEG.Size(3)>1
    zlim(axh,[0 zmax]);
end
daspect(axh,ones(1,3))
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

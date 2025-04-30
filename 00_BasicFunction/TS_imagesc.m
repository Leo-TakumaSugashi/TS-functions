function h = TS_imagesc(varargin)
%this func is bag....
h = imagesc(varargin{:});
return
axh = h.Parent;
uimenu(axh,'Label','south-Colorbar','Callback',@Callback_Colorbaradd)
end

function Callback_Colorbaradd(oh,~)
oh
end

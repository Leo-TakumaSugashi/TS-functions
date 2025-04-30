function varargout = SEGview_tmp(axh,SEG,Type,Slice)
% see also Sugashi_ReconstructGroup
V = Sugashi_ReconstructGroup;

Pdata = SEG.Pointdata;
for n = 1:length(Pdata)
    Pdata(n).Signal = Pdata(n).Signal(:,Slice);
    Pdata(n).Diameter = Pdata(n).Diameter(:,Slice);
    Pdata(n).Noise = Pdata(n).Noise(:,Slice);
    Pdata(n).Theta = Pdata(n).Theta(:,Slice);
    try
        Pdata(n).StayTimeSkel = Pdata(n).StayTimeSkel(:,Slice);
    catch err
        Pdata(n).StayTimeSkel = nan(size(Pdata(n).Signal,1),1);
    end
end
SEG.Pointdata = Pdata;

p = V.SEGview_Limit(axh,SEG,Type);
hold(axh,'on')
txh = V.SEGview_Limit_text(axh,SEG,Type,[0 inf],[0 inf],[0 inf]);
% txh = V.SEGview_Limit_text(axh,SEG);

if nargout >0
    varargout{1} = p;
end
end

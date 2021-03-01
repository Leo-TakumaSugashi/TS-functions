function TS_ResetAxis_for1mm3(axh)

axis(axh,'tight')
box(axh,'off')
grid(axh,'off')
axh.YTickLabel = [];
axh.ZTickLabel = [];
axh.XTickLabel = [];
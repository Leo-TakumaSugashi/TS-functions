function map = TS_Colormap(type)

a = jet(255*2 );

switch lower(type)
    case 'vein'
        map = cat(1,zeros(1,3),a(1:255,:));
    case 'artery'
        map = cat(1,zeros(1,3),a(256:end,:));
end
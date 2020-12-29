function newmap = TS_map2LinInt(map)


map = rgb2hsv(map);
map(:,3) = linspace(0,1,size(map,1)).^0.5;
map(:,2) = linspace(0,1,size(map,1)).^0.5;
newmap = hsv2rgb(map);
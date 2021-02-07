function im = TS_HumanFingerRGB2gray_proto(RGB)

map = [1 1 1;0 0 0;0.5 0 0 ;1 0 0];
map = interp2(map,1:3,linspace(1,size(map,1),256)');
im = rgb2ind(RGB,map);
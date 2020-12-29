function map = GetColorChannels(num)
% this function is For N channels data.
%  Referens, help  makemap.m
switch num
    case 1
        map = [1 0 0];
    case 2
        map = [1 0 0;0 1 0];
    case 3
%         map = eye(3);
        map = [1 0 0;0 1 0;.4 .5 1];
    case {4, 5, 6} 
        %% Old hsv ver
        h = (0:1/(num-1):1)' *6/7;
        map  = hsv2rgb([h ones(num,2)]);
    otherwise
         %% new Colormap
         MAP = TS_GetColorMAP;
         y = 1:size(MAP,1);
         yp = linspace(1,size(MAP,1),num);
         x = 1:3;
         X = repmat(x,[num,1]);
         Y = repmat(yp(:),[1 3]);
         map = interp2(x,y,MAP,X,Y,'linear');
end
    
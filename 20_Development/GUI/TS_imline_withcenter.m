function TS_imline_withcenter
%% default setting
fgh = figure;
axh = axes;
imh = imagesc;

Center = [20 30];
Length = 30;
theta = 20*(pi/180);
%% main

h = images.roi.Line(axh);
y1 = sin(theta)*Length/2 + Center(2);
y2 = -sin(theta)*Length/2 + Center(2);
x1 = cos(theta)*Length/2 + Center(1);
x2 = -cos(theta)*Length/2 + Center(1);
h.Position = [x1 y1; x2 y2];
data.Center = Center;
data.MoveTF = true;
h.UserData = data;
% h.EdgeAlpha = 0.5;

%% add Listner
addlistener(h,'MovingROI',@allevents);
addlistener(h,'ROIMoved',@allevents);

    function allevents(src,evt)
        data = src.UserData;
        C = data.Center;
        if ~data.MoveTF
            return
        end
        Pre = evt.PreviousPosition;
        Cur = evt.CurrentPosition;
        DIFF = max((Pre - Cur)~=0,[],1);
        
        if and(DIFF(1),~DIFF(2))
            Theta = atan((C(2) - Cur(1,2))/(C(1) - Cur(1,1)));
            Len1 = sqrt(sum((Cur(2,:) - C).^2));
            Len2 = sqrt(sum((Cur(1,:) - C).^2));
            y1 = sin(Theta)*Len1 + C(2);
            x1 = cos(Theta)*Len1 + C(1);
            y2 = -sin(Theta)*Len2 + C(2);            
            x2 = -cos(Theta)*Len2 + C(1);
        else
            Theta = atan((C(2) - Cur(2,2))/(C(1) - Cur(2,1)));
            Len1 = sqrt(sum((Cur(2,:) - C).^2));
            Len2 = sqrt(sum((Cur(1,:) - C).^2));
            y2 = sin(Theta)*Len1 + C(2);
            x2 = cos(Theta)*Len1 + C(1);
            y1 = -sin(Theta)*Len2 + C(2);            
            x1 = -cos(Theta)*Len2 + C(1);
        end
        src.Position = [x1 y1;x2,y2];
    end
end
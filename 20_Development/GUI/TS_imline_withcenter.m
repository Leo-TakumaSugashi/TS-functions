function TS_imline_withcenter
%% default setting
fgh = figure;
MouseData = struct('Position',[0 0]);
MouseData.Number = 0;
MouseData.ROIIndicator = 0;
setappdata(fgh,'MouseData',MouseData)
set(fgh,"WindowButtonDownFcn",@WindowButtonDown)
% set(fgh,"WindowButtonMotionFcn",@WindowButtonDown)
% set(fgh,"WindowButtonUpFcn",@WindowButtonDown)
% set(fgh,"WindowKeyPressFcn",@WindowButtonDown)
% set(fgh,"WindowKeyReleaseFcn",@WindowButtonDown)
% set(fgh,"WindowScrollWheelFcn",@WindowButtonDown)
    
axh = axes;
imh = imagesc;
hold(axh,"on")
colormap(gray(84))

Center = [20 30];
Length = 30;
theta = 20*(pi/180);
%% main
cph = plot(Center(1),Center(2),'Marker','o');
cph.LineStyle = 'none';
cph.MarkerSize = 5;
cph.MarkerFaceColor = [0 0 0];
cph.MarkerEdgeColor = [1 1 1];
h = Add_imroiline(axh,Center,Length,theta);
end
function WindowButtonDown(fgh,evt)
    MData = getappdata(fgh,'MouseData');
    NowP = get(gca,'CurrentPoint');
    MData.Position = NowP(1,[1 2]);
%     MData.Number = MData.Number + 1;
    setappdata(fgh,'MouseData',MData)
%     if ~strcmpi('WindowMouseMotion',evt.EventName)
%     disp(['    ', evt.EventName(7:end),' ', num2str(MData.Number)])
%     end
end
function h = Add_imroiline(axh,Center,Length,theta)
    h = images.roi.Line(axh);
    h.Color = [.1 0 .6];
    h.MarkerSize = 10;
    
    y1 = sin(theta)*Length/2 + Center(2);
    y2 = -sin(theta)*Length/2 + Center(2);
    x1 = cos(theta)*Length/2 + Center(1);
    x2 = -cos(theta)*Length/2 + Center(1);
    Len = sqrt((y1-y2)^2 + (x1-x2)^2);
    h.Label = num2str(Len,'%.2f');
    h.Position = [x1 y1; x2 y2];
    data.Center = Center;
    data.MoveTF = true;
    data.Indicator = 0;
    h.UserData = data;
    % h.EdgeAlpha = 0.5;
    
    %% add Listner
    addlistener(h,'MovingROI',@allevents);
    addlistener(h,'ROIMoved',@allevents);
    
end
function allevents(src,evt)
    data = src.UserData;
    C = data.Center;
    if ~data.MoveTF
        return
    end
    Pre = evt.PreviousPosition;
    Cur = evt.CurrentPosition;
    DIFF = max((Pre - Cur)~=0,[],1);
    MData = getappdata(gcf,"MouseData");
    FirstPosi = MData.Position;
    
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
    if strcmpi("ROIMoved",evt.EventName)
        if C(1) < FirstPosi(1)
            if data.Indicator == 0
                data.Indicator = 1;
            elseif data.Indicator < 0
                data.Indicator = 0;
            end
        elseif C(1) > FirstPosi(1)
            if data.Indicator == 0
                data.Indicator = -1;
            elseif data.Indicator > 0
                data.Indicator = 0;
            end
        end
        src.UserData = data;
    end
%     disp(num2str(data.Indicator))
end
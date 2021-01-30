clear data
data(1:1000) = struct('X',[],'Y',[],'Theta',[],'MinLen',[]);
Size = 2^10;
g = 0.95;
step_mm = 1;
Theta = zeros(Size,1,'single');

X = cos(Theta)  + randn(Size,1,'single')*2 - 25;
Y = sin(Theta)  + randn(Size,1,'single')*20;

Focus = [15 0];
Theta = atan((Y-Focus(2))./(X-Focus(1)));


data(1).X = X;
data(1).Y = Y;
data(1).Theta = Theta;
tic
% % % % % % % % % % % % % % % % % % % % % % % % 
% data(1).MinLen = TS_GetMinimumLength(X,Y);
% % % % % % % % % % % % % % % % % % % % % % % % 
TissueX = 0;
TS_WaiteProgress(0)
for n = 2:length(data)
    R = TS_rand_HenyeyGreenstein(g,Size,'single');
%     R = zeros(size(X));
    Theta = Theta + R;
    OutTissue = (data(n-1).X <= TissueX);
    Theta(OutTissue) = data(n-1).Theta(OutTissue);
    X = cos(Theta) * step_mm;
    Y = sin(Theta) * step_mm;
    data(n).X = data(n-1).X + X;
    data(n).Y = data(n-1).Y + Y;
    data(n).Theta = Theta;
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%     data(n).MinLen = TS_GetMinimumLength(data(n).X,data(n).Y);
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    TS_WaiteProgress(n/length(data))
end
toc
%%
save ScatterWithMinLength20210116.mat data Focus g Size TissueX
toc
%%
data(1:120) = struct('X',[],'Y',[],'Theta',[]);
Size = 2^16;
g = 0.7;
Theta = zeros(Size,1,'single');

X = cos(Theta)  + randn(Size,1,'single')*2 - 35;
Y = sin(Theta)  + randn(Size,1,'single');
data(1).X = X;
data(1).Y = Y;
data(1).Theta = Theta;
TissueX = [0 1];
TS_WaiteProgress(0)
for n = 2:length(data)
    R = TS_rand_HenyeyGreenstein(g,Size,'single');
    Theta = Theta + R;
    OutTissue = or(data(n-1).X <= TissueX(1),TissueX(2)<=data(n-1).X);
    Theta(OutTissue) = data(n-1).Theta(OutTissue);
    X = cos(Theta);
    Y = sin(Theta);
    data(n).X = data(n-1).X + X;
    data(n).Y = data(n-1).Y + Y;
    data(n).Theta = Theta;
    TS_WaiteProgress(n/length(data))
end



%%
fgh = figure('Position',[100 500 1920 1080]);
axh = axes('Position',[0 0 1 1],'visible','off');
patchH = patch([0 1000 1000 0 0],[-1000 -1000 1000 1000 -1000],[1 .5 0]);
% patchH = patch([0 1 1 0 0],[-1000 -1000 1000 1000 -1000],[1 .5 0]);
patchH.EdgeColor = 'none';
patchH.FaceAlpha = 0.5;
hold on
X = data(1).X;
Y = data(1).Y;
p = plot(X,Y,'.');
YLim = [-108 108]*2;
XLim = [-192 192]*2;
xlim(XLim)
ylim(YLim)
axh.Visible = 'off';
daspect(ones(1,3))
clear Mov
Mov(1) = getframe(fgh);
for n = 2:length(data)
    p.XData = data(n).X;
    p.YData = data(n).Y;
    
    xlim(XLim)
    ylim(YLim)
    axh.Visible = 'off';
    daspect(ones(1,3))
    drawnow
    Mov(n) = getframe(fgh);
end


%% minmum Length

% min(lenMap)
% ans =
%    1.8733e-04

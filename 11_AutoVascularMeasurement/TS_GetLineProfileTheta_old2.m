function [vpmatrix,theta,Ydata,CropImage,New_Min_theta] = TS_GetLineProfileTheta_old2(im,Center,Length,Start_theta,Reso,varargin)
% Center = [X Y]
% Length =  [um];
% Reso = XY; %% Resolution[X==Y] um/Pixels
View = [];
if nargin <6
    View = 'off';
elseif nargin == 6
    View = varargin{1};
end

%% Check Input image
im = squeeze(im);
if ~ismatrix(im)
    error('Input is NOR matrix image')
end

%% Rotation size
Step_rotation = 0.1;
PulasMinusTheta = 30 ;
theta = Start_theta-PulasMinusTheta:Step_rotation:Start_theta+PulasMinusTheta;

%% Method of interp2 
Method = 'spline';

%% Add CropImage
xind = 1:size(im,2);
yind = 1:size(im,1);
xind = and(xind>=Center(1)-Length/2,xind<=Center(1)+Length/2);
yind = and(yind>=Center(2)-Length/2,yind<=Center(2)+Length/2);
cim = double(im);
bwim = false(size(im));
bwim(Center(2),Center(1)) = true;
bwim = bwdist(bwim)<=(Length/Reso)/2;
cim(~bwim) = nan;
CropImage = cim(yind,xind);


switch View
    case {'on','view'}
        fgh = figure('Position',[100 100 900 750],...
            'PaperPosition',[.6 .6 27 20],...
            'Color','w',...
            'Resize','off');
        % % Input Image Axes
        axes('position',[.05 .55 .4 .4])
        Xdata = ((1:size(im,2)) - Center(1)) * Reso;
        Ydata = ((1:size(im,1)) - Center(2)) * Reso;
        imagesc(im,'Xdata',Xdata,'Ydata',Ydata)
%         set(gca,'Ydir','normal')
        colormap(gray)
        axis image
        title('Input Image')
        % % Caluculate Line plot
        hold on
        ph = plot(0,0,'.-');
        cph = plot(0,0,'*r');
        set(ph,'MarkerSize',8)
        set(cph,'MarkerSize',12)
        
        % % Line Profile Axes
        axes('position',[.55 .55 .4 .4]),
        pll = plot([-Length Length]/2,[0 0]);
        title('Line Profile')
        xlabel('Length [\mum]')
        ylabel('Intensity')
        grid on
    case 'off'
    otherwise
        disp('Setting ''View'' = ''off''')
        View = 'off';
end
        
%% Main Function
vpmatrix = zeros(Length+1,length(theta));
for n = 1:length(theta)
    [xp,yp] = GetIndex(Center,theta(n),ceil(Length*Reso));
    vp = interp2(double(im),xp,yp,Method);
    vpmatrix(:,n) = vp;
    switch View
        case {'on','view'}
            set(ph,'Xdata',xp,'Ydata',yp)
            len = length(yp);%disp(['theta ' num2str(theta(n)) ' :'  num2str(len)])
            if ceil(len/2) == floor(len/2)
                Xdata = (1:len) -1-len/2;                
            else
                Xdata = (1:len) -.5-len/2;
            end
            Xdata = Xdata * Reso(1);
            set(pll,'Xdata',Xdata,'Ydata',vp);
%             disp(num2str(length(1:len) == length(vp)))
            drawnow
%             pause(.01)
    end
end

%% View on
switch View
    case {'on','view'}
        output_axh = axes('position',[.1 .05 .8 .4]);
        imagesc(vpmatrix,'Xdata',theta)
        title('Output Image')
        ylabel('Geted Line Profile''s Length')
        xlabel('Theta [\theta]')
        impixelinfo
        Xtick = 0:pi/4:Max_rotation * length(theta);
        Xlabel = {'0';
            'ÉŒ/4';
            'ÉŒ/2';
            '3ÉŒ/4';
            'ÉŒ';
            '5ÉŒ/4';
            '3ÉŒ/2';
            '7ÉŒ/4';
            '2ÉŒ'};
        if size(Xlabel,1)>length(Xtick)
            Xlabel{length(Xtick)+1:end} = [];
        end
        
        set(output_axh,'Xtick',Xtick,...
            'XTickLabel',Xlabel)
        [fgh2,New_Min_theta] =  Viewdata;
        
end

% 
switch View
    case {'off'}
        New_Min_theta = [];
%         delete(fgh2)
end

%% GetIndex
function [xp,yp] = GetIndex(Center,theta,Length) %% unit pixels
fx1 = @(x,theta,Length) cosd(180+theta)*Length/2+x;
fx2 = @(x,theta,Length) cosd(theta)*Length/2+x;
fy1 = @(x,theta,Length) sind(180+theta)*Length/2+x;
fy2 = @(x,theta,Length) sind(theta)*Length/2+x;

x1 = fx1(Center(1),theta,Length);
x2 = fx2(Center(1),theta,Length);
y1 = fy1(Center(2),theta,Length);
y2 = fy2(Center(2),theta,Length);


if (x2-x1) == 0
    xp = ones(1,Length) * x1;
else
%     xp = x1:(x2-x1)/Length:x2;
    xp1 = flip(Center(1) : -(x2-x1)/Length : x1 ,2);
    xp2 =      Center(1) : (x2-x1)/Length : x2 ;
    xp = cat(2,xp1,xp2(2:end));
end

if (y2-y1) == 0
    yp = ones(1,Length) * y1;
else
%     yp = y1:(y2-y1)/Length:y2;
    yp1 = flip(Center(2) : -(y2-y1)/Length : y1 ,2);
    yp2 =      Center(2) :  (y2-y1)/Length : y2 ;
    yp = cat(2,yp1,yp2(2:end));
end
end

function [fgh2,New_Min_theta] =  Viewdata
%% Add hist to S and N
% Bin = max(vpmatrix(~isnan(vpmatrix))) - min(vpmatrix(~isnan(vpmatrix)));
% disp(['Output Image Bin Num. ' num2str(Bin)]);
% Bin = round(Bin) + 1;
% [his,x] = hist(vpmatrix(~isnan(vpmatrix)),Bin);
% figure,plot(x,his)
Subplot_num = 3;
im = double(im);
Bin = max(im(:)) - min(im(:));
disp(['Input Image of Bin Num. ' num2str(Bin)]);
Bin = round(Bin) + 1;
[his,x] = hist(im(:),Bin);
fgh2 = figure('Posi',...
    [1000     101      850     822]);
subplot(Subplot_num,1,1)
plot(x,his)
hold on
se = ones(1,round(Bin*0.1));
se = se / numel(se);
his2 = imfilter(his,se,'symmetric');
plot(x,his2,'r')
legend('Input Image Hist',['MovingAve. (kernel=' num2str(numel(se)) ')'])

%% Binalize
[~,b] = max(his2);
Noise = x(b);
Threshold = mean([max(im(:)) Noise]);
bw = (vpmatrix>Threshold);
% % Maximum Area
[L,Num] = bwlabeln(bw,26);
Morophorogy = regionprops(L,'Area');
Morophorogy = cat(1,Morophorogy.Area);
[~,b] = max(Morophorogy);
MaxArea_bw = L == b;
clear L 

% % Minimum Diameter Index
Diameter = sum(MaxArea_bw,1);
Min_Diameter = Diameter == min(Diameter);
% [L,Num] = bwlabeln(Min_Diameter,26);
% Morophorogy = regionprops(L,'Area');
% Morophorogy = cat(1,Morophorogy.Area);
% [~,b] = max(Morophorogy);
% Min_Diameter = L == b;
% clear L
Min_Diameter_Ind = find(Min_Diameter);
ORBW = false(size(MaxArea_bw));
ORBW(:,Min_Diameter_Ind) = true;
Min_Diameter_bw = and(MaxArea_bw,ORBW);
%% Create MinDiameter
bw_output = cat(3,bw,MaxArea_bw,Min_Diameter_bw);

% subplot 
subplot(Subplot_num,2,3)
imagesc(bw_output,'Xdata',theta)
set(gca,'Xtick',Xtick,...
    'XTickLabel',Xlabel)
hold on
Min_theta = interp1(theta,mean(Min_Diameter_Ind));
plot([0 theta(end)],ceil([size(vpmatrix,1) size(vpmatrix,1)]/2))
plot([Min_theta Min_theta],[0 size(vpmatrix,1)+1])
title('Red:BW, Yellow:Maximum Area, White:Minimum Diameter')

%% Calculate Minimum theta
subplot(Subplot_num,2,5)
imagesc(im),axis image
hold on
[xp,yp] = GetIndex(Center,Min_theta,Length) ;
vp = interp2(double(im),xp,yp);
plot(Center(1),Center(2),'r*')
plot(xp,yp,'b.-')
colormap(gray)
title(['Theta = ' num2str(Min_theta) ' (' num2str(Min_theta*180/pi) 'Åã)'])


%% Theta VS. Diameter
subplot(Subplot_num,2,4)
plot(theta,Diameter,'.');
set(gca,'Xtick',Xtick,...
    'XTickLabel',Xlabel)
axis tight
grid on
hold on

%% Min_ThetaÇ©ÇÁÅ}30Åã(pi/6,rad)ÇÃì_Ç©ÇÁ2éüå≥Fitting
Fitting_siz = pi/6;
if Min_theta<Fitting_siz
    Fitting_Ind = or(theta<Min_theta+Fitting_siz,...
        theta>(theta(end) - (Fitting_siz-Min_theta)));
elseif Min_theta+Fitting_siz>theta(end)
    Fitting_Ind = or(theta>Min_theta-Fitting_siz,...
        theta<(theta(1) + (Min_theta+Fitting_siz)));
else
    Fitting_Ind = and(theta>Min_theta-Fitting_siz,...
        theta<Min_theta+Fitting_siz);
end
plot(theta(Fitting_Ind),Diameter(Fitting_Ind),'r.')
Poly_p = polyfit(theta(Fitting_Ind),Diameter(Fitting_Ind),2);

Fitting_Xdata = theta(Fitting_Ind);
Fitting_Xdata = Fitting_Xdata(1):Step_rotation/10:Fitting_Xdata(end);
Fitting_Ydata = Poly_p(1)*Fitting_Xdata.^2 ...
    + Poly_p(2)*Fitting_Xdata + Poly_p(3);
plot(Fitting_Xdata,Fitting_Ydata,'r')
[~,b] = min(Fitting_Ydata);
New_Min_theta = Fitting_Xdata(b);

%% Output New Min Theta
subplot(Subplot_num,2,6)
imagesc(im),axis image
hold on
[xp,yp] = GetIndex(Center,New_Min_theta,Length) ;
vp = interp2(double(im),xp,yp);
plot(xp,yp)
title(['New Theta = ' num2str(New_Min_theta) ' (' num2str(New_Min_theta*180/pi) 'Åã)'])



impixelinfo
end


end

function vpmatrix = TS_GetLineProfileTheta180(im,Center,varargin)

Length = length(im);
Reso = [.497 1]; %% Resolution(XY,Z]
Max_rotation = pi;
Step_rotation = pi/180;

fx1 = @(x,theta,Length) cos(pi+theta)*Length/2+x;
fx2 = @(x,theta,Length) cos(theta)*Length/2+x;
fy1 = @(x,theta,Length) sin(pi+theta)*Length/2+x;
fy2 = @(x,theta,Length) sin(theta)*Length/2+x;

View = [];
if nargin <3
    View = 'off';
elseif nargin == 3
    View = varargin{1};
end

switch View
    case {'on','view'}
        fgh = figure('Position',[100 100 900 750],...
            'PaperPosition',[.6 .6 27 15],...
            'Color','w',...
            'Resize','off');
        % % Input Image Axes
        axes('position',[.05 .55 .4 .4])
        imagesc(im)
        colormap(gray)
        axis image
        title('Input Image')
        impix_h = impixelinfo;
        set(impix_h,'Unit','Normalized',...
            'Position',[.001 .505 .2 .025])
        
        
        % % Caluculate Line plot
        hold on
        ph = plot(Center(1),Center(2),'.-');
        cph = plot(Center(1),Center(2),'*r');
        set(ph,'MarkerSize',8)
        set(cph,'MarkerSize',12)
        
        % % Line Profile Axes
        axes('position',[.55 .55 .4 .4]),
        pll = plot([1:Length]-1-Length/2,ones(1,Length));
        title('Line Profile')
        xlabel('Length [\mum]')
        ylabel('Intensity')
        grid on
    case 'off'
    otherwise
        disp('Setting ''View'' = ''off''')
        View = 'off';
end
        
% Counter = 1;
theta = flip(0:Step_rotation:Max_rotation,2);
vpmatrix = zeros(Length+1,length(theta));
for n = 1:length(theta)
    x1 = fx1(Center(1),theta(n),Length);
    x2 = fx2(Center(1),theta(n),Length);
    y1 = fy1(Center(2),theta(n),Length);
    y2 = fy2(Center(2),theta(n),Length);
    if (x2-x1) == 0
        xp = ones(1,Length) * x1;
    else
        xp = x1:(x2-x1)/Length:x2;
    end

    if (y2-y1) == 0
        yp = ones(1,Length) * y1;
    else
        yp = y1:(y2-y1)/Length:y2;
    end

    vp = interp2(double(im),xp,yp);
    vpmatrix(:,n) = vp;
%     Counter = Counter + 1:
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
            'ƒÎ/4';
            'ƒÎ/2';
            '3ƒÎ/4';
            'ƒÎ';
            '5ƒÎ/4';
            '3ƒÎ/2';
            '7ƒÎ/4';
            '2ƒÎ'};
        if size(Xlabel,1)>length(Xtick)
            Xlabel{length(Xtick)+1:end} = [];
        end
        
        set(output_axh,'Xtick',Xtick,...
            'XTickLabel',Xlabel)            
end




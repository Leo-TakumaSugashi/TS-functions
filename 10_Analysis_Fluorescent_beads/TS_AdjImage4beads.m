function [output,varargout] = TS_AdjImage4beads(Image,varargin)
% [output,NewSignal,Signal,Noise] = TS_AdjustSNR4beads(Image)
% input:Image 3Dimage
% output:Adjusted Image by Signal and Noise Ratio (class : uint8)
%        NewSignal ... Adjusted each slice maximum pixels value
%        Signal Maximum value of Each slice
%        Noise ... mode value of Each slice except minimum and maximum in whole slice

%% nargin check
if nargin>1 ,  Reso = varargin{1};
else     Reso = ones(1,3);
end
if nargin>2 
    if strcmpi(varargin{2},'figure'), FigureON = true;
    end
else FigureON = false;
end



siz_z = size(Image,3);

S = zeros(siz_z,1);
N = zeros(siz_z,1);

%% 1st Analysis S and N
% wh = waitbar(0,'wait...Analysis S and N');
fprintf(    mfilename)
TS_WaiteProgress(0)
for n = 1:siz_z
    im = double(Image(:,:,n));
%     N(n) = mode(im(and(im>0,im<max(im(:)))));
    N(n) = TS_GetBackgroundValue(im(and(im>min(im,[],'all'),im<max(im,[],'all'))));
    S(n) = max(im(:));
    TS_WaiteProgress(n/siz_z)
end
N(isnan(N)) = 0;



%% 2nd Analysis for S
NewS = S;
for n = 2:siz_z
    NewS(n) = max(NewS(n-1:n));
end


%% Adjust Image for NewS
output = zeros(size(Image),'Like',uint8(1));
% wh = waitbar(0,'wait..Adjust Image for Beads');
% set(wh,'name',mfilename)
fprintf('Adjust Image for Beads')
TS_WaiteProgress(0)
for n = 1:siz_z
    im = double(Image(:,:,n));
    im = uint8((im-N(n))/(NewS(n) - N(n)) * 255);
    output(:,:,n) = im;
    clear im
%     waitbar(n/siz_z,wh)
    TS_WaiteProgress(n/siz_z)
end


if nargout>1,  varargout{1} = NewS; end
if nargout>2,  varargout{2} = S; end
if nargout>3,  varargout{3} = N; end


%% Check figure
if FigureON
fgh = figure('Posi',[10 10 900 900]);
 centerfig(fgh)

axes('posi',[.1 .69 .85 .3])
    plot(S,'r.:')
    hold on
    plot(N,'k.:')
    plot(NewS,'.--')
    legend('Signla:maximum','Noise:mode value(min, max,)',...
        'Adjusted Signal','location','Best')    
    grid on 
    axis tight
    xlabel('each slice')
    ylabel('pixels value [a.u.]')
    
ydata = (0:size(Image,2)-1) * Reso(2);
zdata = (0:size(Image,3)-1) * Reso(3);
axes('posi',[0.05 .33 .9 .3])
    vim = (squeeze(max(Image,[],2)));
    if ~max(strcmpi(class(vim),{'uint8','uint16','uint16','logical'}))
        vim = double(vim);
        vim = vim - min(vim(:));
        vim = vim ./max(vim(:));
    end
    
    imagesc(vim,'Xdata',zdata,'Ydata',ydata),
    axis('image')
    colormap(gray)
    colorbar
axes('posi',[0.05 .01 .9 .3])
    vim = (squeeze(max(output,[],2)));
    if ~max(strcmpi(class(vim),{'uint8','uint16','uint16','logical'}))
        vim = double(vim);
        vim = vim - min(vim(:));
        vim = vim ./max(vim(:));
    end
    imagesc(vim,'Xdata',zdata,'Ydata',ydata),
    axis('image')
    colorbar
end

    

function varargout = TS_EachDepthVolumeHist(bw,Step,Reso)
% varargout = TS_EachDepthVolumeHist(bw,Step(um),Reso(only Z))

%% input check
if ~islogical(bw)
    error('Input is NOT logical')
end
Fontsize = 12;


%% flip dim Axis Z 
bw = flip(bw,3);
%% Step size(pix.) and Xdata
step_pixels = round(Step/Reso);
xdata = 1:step_pixels:size(bw,3);
if xdata(end) ~= size(bw,3)
    xdata = [xdata size(bw,3)];
end

%% Analysis 
for n = 1:length(xdata)-1
    if xdata(n+1)>size(bw,3)
        eachVol = bw(:,:,xdata(n):end);
    else
        eachVol = bw(:,:,xdata(n):xdata(n+1));
    end
    H(n) = sum(eachVol(:)) / numel(eachVol);
end
H = H * 100; %% persentage
x = cumsum(diff((xdata-1)*Reso)/2)*2;

%% for patch
 [X,Y] = TS_bar2patch(H,x);
% X = [0 0];
% Y = [0 H(1)];
% for n= 1:length(x)-1
%     X = [X x(n) x(n)];
%     Y = [Y H(n) H(n+1)]; 
% end
% X = [X x(end) x(end) 0];
% Y = [Y H(end) 0 0];

fgh = figure('PaperPosition',[.5 .5 20 15]);
 p = patch(X,Y,[0 0 .7]);
 alpha(p,0.6)
 grid on
 box on
 axis tight
 set(gca,'Fontsize',Fontsize)
 xlabel('Depth [\mum]')
 ylabel('Volume [%]')
 
 %% output
 if nargout>0
     output.xdata = flip(xdata);
     output.x = x;
     output.Hist = H;
     output.patch_X = X;
     output.patch_Y = Y;
     varargout{1} = output;
 end
 if nargout==2
     varargout{2} = fgh;
 end

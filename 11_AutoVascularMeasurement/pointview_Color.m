function varargout  = pointview_Color(thindata,Diam_skel,Reso,varargin)
% varargout  = pointview(thindata,Reso,{Maximum},{'figure'})
% BIN = 32;
% [h,x] = hist(Diam_skel(thindata),BIN);
narginchk(3,4)
if max(strcmpi(varargin,'figure'))
    figure('Name','Point View',...
        'InvertHardcopy','off',...
        'PaperPosition',[.6 .6 12 18],...
        'Position',[50 30 600 800],...
        'Color','w')
    axes('Position',[.08 .08 .85 .9])
    hold on
else
    warning('None figure ????')
end
Maximum = max(Diam_skel(:));
if ~isempty(varargin)
   if isscalar( varargin{1} )
       Maximum = varargin{1};
   else
       Maximum = max(Diam_skel(:));
   end   
end
BIN = 32;
mini = min(Diam_skel(thindata));
maxi = max(Diam_skel(thindata));
[h,x] = hist(Diam_skel(thindata),linspace(mini,maxi,BIN));
map = jet(length(x));
step = x + diff(x(1:2));



for n = 1:length(step)
plot_skel = and(Diam_skel < step(n) , Diam_skel>0);
% disp(num2str(sum(plot_skel(:))))
    Diam_skel(plot_skel) = 0;
[y,x,z] = ind2sub(size(thindata),find(plot_skel(:)));
if ~isempty(y)    
    plh(n) = plot3((x-1)*Reso(1),(y-1)*Reso(2),(z-1)*Reso(3),'.');
    plh(n).Color = map(n,:);
end
% plh(n).MarkerSize = n; %% Markersize
hold on
end
% [y,x,z] = ind2sub(size(thindata),find(thindata(:)));
% plh(n+1) = plot3((x-1)*Reso(1),(y-1)*Reso(2),(z-1)*Reso(3),'.','Color',map(n+1,:));
% plh(n+1).Color = map(n+1,:);

axh = gca;
axh.CLim = [mini Maximum];
axh.Position = [.1 .15 .8 .8];
colormap(map)
ch = colorbar('Location','southoutside');
ch.Position = [.1 .06 .8 .03];
uih = uimenu(ch.UIContextMenu,'Label','PointClim','Callback',@Callback_pointCLim);
set(uih,'Userdata',plh)
set(uih.Parent,'Userdata',step)
uih(2) = uimenu(ch.UIContextMenu,'Label','StringEdit','Callback',@Callback_StringEdit);

% [y,x,z] = ind2sub(size(thindata),find(thindata(:)));
% plh = plot3((x-1)*Reso(1),(y-1)*Reso(2),(z-1)*Reso(3),'.');
% daspect([Reso(1) Reso(2) Reso(3)\mean(Reso(1:2))])
daspect(ones(1,3))
grid on
set(gca,'Ydir','reverse')
box on
axis tight
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
view(3)


if nargout>0
    varargout{1} = plh;
end

function Callback_pointCLim(oh,~)
p = get(oh,'Userdata');
prompt = {'Enter Color Limit(min.):','Enter Color Limit(max.):'};
dlg_title = 'Input';
clim = caxis;

num_lines = 1;
defaultans = {num2str(clim(1)),num2str(clim(2))};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
if isempty(answer)
    return
end
CLIM = [eval(answer{1}) eval(answer{2})];
caxis(CLIM)
map = colormap;
[X,Y] = meshgrid(1:3,linspace(1,size(map,1),32));
map = interp2(1:3,1:size(map,1),map,X,Y);
step = get(oh.Parent,'Userdata');
vp = linspace(eval(answer{1}),eval(answer{2}),32);
try
for n = 1:32
    fp = find(vp<step(n));
    if ~isempty(fp);
        ind = fp(end);
    else
        ind = 1;
    end    
    if and(~isempty(p(n)),ishandle(p(n)))
        p(n).Color = map(ind,:);
    end
end
catch
end


function Callback_StringEdit(oh,~)
fgh = gcf;
ch = findobj('Parent',fgh,'Type','Colorbar');
prompt = {'Input String'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {''};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
if isempty(answer)
    return
end
ch.Label.String = answer{1};






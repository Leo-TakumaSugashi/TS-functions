function varargin = TS_rotation3Dview(varargin)
timeaz = 7/2;
timeel = 3/2;
az = 0;el = 0;
diraz = 1;
direl = 1;
pause_dur = 1/(24*3);
% axh = gca;
if nargin==0
    load TESTSEG.mat MSEG
    V = Sugashi_ReconstructGroup;
    p = V.ReconstructSEG([],MSEG);
    axh = p.Parent;
    axh.Visible = 'off';
    axh.Parent.MenuBar = 'none';
    axh.Parent.Color = [0 0 0 ];
    colormap(axh.Parent,GetColorChannels(128))
    caxis(axh,[2 8])
    axh.Projection = 'perspective';
    axh.ZLim = [200 450];
    axh.Parent.Position = [0 0 1920 1080];
    cmh = camlight;    
else
    axh = varargin{1};
    cmh = camlight(axh);    
end
set(axh,'CameraViewAngleMode','manual')
% if nargout >0
%     Mov(1:1000) = struct('cdata',[],'colormap',[]);
%     c = 1;
% end
try
while ishandle(axh)
    if and(az<=0,diraz==-1)
        diraz = 1;
    end
    if and(az>=360,diraz==1)
        az = az-360;
%         diraz = -1;
    end
    az = az + diraz*timeaz;
    if and(el+direl*timeel<=-90,direl==-1)
        direl= 1;
    end
    if and(el+direl*timeel>=90, direl ==1)
        direl=  -1;
    end    
    el = el+direl*timeel;
    view(axh,az,el);
    camlight(cmh,45,30)
    drawnow;    
%     if nargout >0
%         Mov(c) = getframe(axh.Parent);
%         c = c + 1;
%     end
    pause(pause_dur);    
end
catch err
%     if nargout >0
%         while isempty(Mov(end).cdata)
%             Mov(end) = [];
%         end
%         varargout{1} = Mov;
%     end
end
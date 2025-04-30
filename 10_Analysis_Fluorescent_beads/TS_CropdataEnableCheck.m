function [NewCropdata,Output] = TS_CropdataEnableCheck(Cropdata)
% [NewCropdata,Output] = TS_CropdataEnableCheck(Cropdata)
% help TS_centroid2Crop
% NewCropdata : By hand, Checked Enabel ON or OFF
% Output      : Only Enable ON data

%% add Edit New centroid Position
for n = 1:length(Cropdata)
    Cropdata(n).NewCenterOfImage = Cropdata(n).CenterOfImage;    
end

% % two figure make
Pfgh = figure('visible','off');

% children figure
fgh = figure('Posi',[45 80 950 800],...
    'Color','w',...
    'DockControls','off');
setappdata(fgh,'Pfgh',Pfgh)
 n = 1;
 xyz = Cropdata(n).CenterOfImage;
axh(1) = axes('posi',[0.1 0.58 0.4 0.4]);
     im = squeeze(Cropdata(n).fImage(:,:,round(xyz(3))));
 imh(1) = imagesc(im);
     colormap(gray)
     hold on
 plh(1) = plot(xyz(1),xyz(2),'r*');
     xlabel('--> Axis X ==>')
     ylabel('<== Axis Y <--')
    
axh(2) = axes('posi',[0.1 0.1 0.4 0.4])     ;
     im = imrotate(squeeze(Cropdata(n).fImage(round(xyz(2)),:,:)),90);
 imh(2) = imagesc(im);set(gca,'Ydir','normal')     
     hold on
 plh(2) = plot(xyz(1),xyz(3),'r*');
     ylabel('--> Axis Z ==>')
    
axh(3) = axes('posi',[0.55 0.58 0.4 0.4]);
     im = squeeze(Cropdata(n).fImage(:,round(xyz(1)),:));
 imh(3) = imagesc(im);
     hold on
plh(3) =  plot(xyz(3),xyz(2),'r*');
     xlabel('--> Axis Z ==>')
     
    % % Histogram
    [h,x] = hist(double(Cropdata(n).fImage(:)),100);
    axh(4) = axes('posi',[0.6 0.15 0.38 0.3]);
     BarH = bar(x,h);
     axis tight
     xlabel('Pixels value')
     ylabel('Frequency')
     title('Volume Image of Histogram')
     grid on

for n = 1:length(Cropdata)
    [h,x] = hist(double(Cropdata(n).fImage(:)),100);
    Cropdata(n).Hist.Freq = h;
    Cropdata(n).Hist.xdata = x;
end
setappdata(Pfgh,'data',Cropdata)
    
    clear im xyz 

%% Slider
slh = uicontrol('Posi',[0 0 500 15],'style','slider',...
    'sliderstep',[1/(length(Cropdata)-1) 10/(length(Cropdata)-1)],...
    'Userdata',length(Cropdata)-1,...
    'Callback',@Calback_slider);
txh = uicontrol('Posi',[505 0 20 15],'style','text',...
    'String',num2str(n));

%% Enable
enh = uicontrol('Posi',[550 20 200 50],...
    'Style','togglebutton',...
    'FontSize',12,...
    'Callback',@Callback_Enable);
if Cropdata(n).Enable
    set(enh,'String','Enable ON','value',1,'BackGroundColor','w')
else
    set(enh,'String','Enable OFF','value',0,'BackGroundColor',ones(1,3)*0.2)
end

%% Edit New Centroid of Object
encbh = uicontrol('Posi',[760 20 150 50],...
    'String','Edit Centroid',...
    'FontSize',12,...
    'Callback',@Callback_EditNewCentroidOfObject);



%% Call back
    function Calback_slider(oh,~)
        N = uint32(round(get(oh,'Userdata')*get(oh,'Value') + 1));
         set(txh,'String',num2str(N))
        Cdata = getappdata(Pfgh,'data');
        XYZ = Cdata(N).NewCenterOfImage;
         IM = squeeze(Cdata(N).fImage(:,:,round(XYZ(3))));
         set(imh(1),'Cdata',IM)
         IM = imrotate(squeeze(Cdata(N).fImage(round(XYZ(2)),:,:)),90);
         set(imh(2),'Cdata',IM)
         IM = squeeze(Cdata(N).fImage(:,round(XYZ(1)),:));
         set(imh(3),'Cdata',IM),clear IM
         
         % Plot
         set(plh(1),'Xdata',XYZ(1),'Ydata',XYZ(2))
         set(plh(2),'Xdata',XYZ(1),'Ydata',XYZ(3))
         set(plh(3),'Xdata',XYZ(3),'Ydata',XYZ(2))
                  
         % Hist
         set(BarH,'Xdata',Cdata(N).Hist.xdata,...
             'Ydata',Cdata(N).Hist.Freq)
        axis(axh,'tight')    
        
        % % Enable
        val = Cdata(N).Enable;
        if val
            set(enh,'String','Enable ON','value',1,'BackGroundColor',ones(1,3))
        else
            set(enh,'String','Enable OFF','value',0,'BackGroundColor',ones(1,3)*0.2)
        end
    end

    function Callback_Enable(oh,~)
        val = get(oh,'Value');
        N = uint32(round(get(slh,'Userdata')*get(slh,'Value') + 1));
        Cdata = getappdata(Pfgh,'data');
        if val == get(oh,'Max')
            Cdata(N).Enable = true;
            set(enh,'String','Enable ON','BackGroundColor','w')
        else
            Cdata(N).Enable = false;
            set(enh,'String','Enable OFF','BackGroundColor',ones(1,3)*0.2)
        end
        setappdata(Pfgh,'data',Cdata)
    end

    function Callback_EditNewCentroidOfObject(oh,~)
        N = uint32(round(get(slh,'Userdata')*get(oh,'Value') + 1));
        Cdata = getappdata(Pfgh,'data');
        Image = Cdata(N).fImage;
        SBFgh = SliceBrowser(Image);centerfig(SBFgh)
        sbPosi = get(SBFgh,'Posi');
         %% add Callback Of SliceBrowser 
         uicontrol('Parent',SBFgh,...
             'Position',[sbPosi(3)-150 0 150 25],...
             'String','Output Centroid Position',...
             'Callback',@Callback_OutputCP)
        function Callback_OutputCP(oh,~)
%             error('This function is not correct')
            GUIdata = guidata(get(oh,'Parent'));
            yxzt = GUIdata.pointer3dt;
            eCdata = getappdata(Pfgh,'data');
            eN = uint32(round(get(slh,'Userdata')*get(slh,'Value') + 1))
            eCdata(eN).NewCenterOfImage
            eCdata(eN).NewCenterOfImage = [yxzt(2) yxzt(1) yxzt(3)];
            eCdata(eN).NewCenterOfImage
            setappdata(Pfgh,'data',eCdata);
            Calback_slider(slh)
            close(get(oh,'Parent'))            
        end
        waitfor(SBFgh)
    end


waitfor(fgh)
NewCropdata = getappdata(Pfgh,'data');
c = 1;
for n = 1:length(NewCropdata)
    if NewCropdata(n).Enable
        Output(c) = NewCropdata(n);
        c = c + 1;
    end
end
        
    

close(Pfgh)
end
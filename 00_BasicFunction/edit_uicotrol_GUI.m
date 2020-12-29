function fgh = edit_uicotrol_GUI(axh)
im = getimage(axh);
fgh = figure('Color','w');
setappdata(fgh,'im',im)
CLIM = double([min(im(:)) max(im(:))]);
setappdata(fgh,'CLim',CLIM)

GammaData(1:size(im,5)) = struct('Channels',[],'Gamma',[],'map',[]);
ChMap = GetColorChannels(size(im,5));
for n = 1:size(im,5)
    GammaData(n).Channels = n;
    GammaData(n).Gamma = 1;
    GammaData(n).map = makemap(ChMap);
end
setappdata(fgh,'gamma',GammaData);
Bit = 2^8 -1;
Slider_step = [1/Bit .1];
clim_slider_max = uicontrol('Style','slider',...
    'Position',[150 350 150 13],...
    'value',1,...
    'Tag','CLim_Max',...
    'sliderStep',Slider_step,...
    'Callback',@Callback_ClimSlider);
clim_text_max = uicontrol('Style','text',...
    'position',[300 350 30 15],...
    'String',num2str(CLIM(2)));

clim_slider_min = uicontrol('Style','slider',...
    'Position',[150 335 150 13],...
    'value',0,...
    'Tag','CLim_Min',...
    'sliderStep',Slider_step,...
    'Callback',@Callback_ClimSlider);
clim_text_min = uicontrol('Style','text',...
    'position',[300 335 30 15],...
    'String',num2str(CLIM(1)));


axh_add = axes('Units','pixels','posi',[20 20 380 300]);

imh = imagesc(im);
colorbar
setappdata(fgh,'imh',imh)
step_data.axh = axh;
step_data.Bit = Bit;
step_data.CLim = CLIM;
step_data.MaxH = clim_slider_max;
step_data.MinH = clim_slider_min;
step_data.MaxTextH = clim_text_max;
step_data.MinTextH = clim_text_min;
set(clim_slider_max,'Userdata',step_data)
set(clim_slider_min,'Userdata',step_data)


gamma_Line = [0.01:0.01:2];
gnum = length(gamma_Line)-1 ;
gamma_slider = uicontrol('Style','slider',...
    'Position',[150 370 150 13],...
    'value',0.5,...
    'Tag','Gamma',...
    'sliderStep',[1/gnum 10/gnum],...
    'Callback',@Callback_GammaSlider,...
    'Userdata',gamma_Line);

end

function Callback_GammaSlider(oh,~)
fgh = oh.Parent;
NowChannels = 1; %% need edit...
gamma_Line = get(oh,'userdata');
val = uint32(round(get(oh,'Value') * length((gamma_Line) - 1)) + 1);
val = min(val,length(gamma_Line));
val = max(val,1);
% disp([num2str(val) '/' num2str(length(gamma_Line)) '   ' num2str(gamma_Line(val))])
GammaData = getappdata(fgh,'gamma');
GammaData(NowChannels).gamma = gamma_Line(val);
setappdata(fgh,'gamma',GammaData);

UpdataView(fgh)    
end

function Callback_ClimSlider(oh,dummy)
fgh = oh.Parent;
if ~exist('dummy','var')
    dummy = 0;
end
NowTag = oh.Tag;
step_data = get(oh,'Userdata');
CLim = step_data.CLim;
max_step = get(step_data.MaxH,'SliderStep');
max_value = get(step_data.MaxH,'Value');
min_step = get(step_data.MinH,'SliderStep');
min_value = get(step_data.MinH,'Value');
Diffe = abs(diff(CLim));
Maximum = CLim(1) + max_value*Diffe;
Minimum = CLim(1) + min_value*Diffe;
roop_TF = false;
if min_value < 0
    Maximum = CLim(1) + max_step(1)*Diffe;
    max_value = max_step(1);
    set(step_data.MaxH,'Value',max_value);
    Minimum = CLim(1);
    min_value = 0;
    set(step_data.MinH,'Value',min_value);
    roop_TF  = true;
end
if max_value >1
    Maximum = CLim(2);
    max_value = 1;
    set(step_data.MaxH,'Value',max_value);

    Minimum = CLim(2) - min_step(1)*Diffe;
    min_value = 1 - min_step(1);
    set(step_data.MinH,'Value',min_value);
    roop_TF = true;
end
if Maximum <= Minimum
    switch NowTag
        case 'CLim_Max'
            Minimum = max(Maximum - max_step(1)*Diffe,CLim(1));
            min_value = max(( Minimum - CLim(1) ) / Diffe,0);
            set(step_data.MinH,'Value',min_value);
        case 'CLim_Min'
            Maximum = min(Minimum + min_step(1)*Diffe,CLim(2));
            max_value = min(( Maximum - CLim(1) ) / Diffe,1);
            set(step_data.MaxH,'Value',max_value);
    end
    roop_TF = true;
else
    caxis(step_data.axh,[Minimum Maximum])
    step_data.MaxTextH.String = num2str(Maximum);
    step_data.MinTextH.String = num2str(Minimum);
    setappdata(fgh,'CLim',[Minimum Maximum])
    
%     UpdataView(fgh)    
end
if and(roop_TF,dummy<10)
    dummy = dummy + 1;
    Callback_ClimSlider(oh,dummy)
end
end

function UpdataView(fgh)
im = getappdata(fgh,'im');
imh = getappdata(fgh,'imh');
CLim = getappdata(fgh,'CLim');
GammaData = getappdata(fgh,'gamma');
NowChannels = 1;
g = GammaData(NowChannels).gamma;

%% normalize type
% im = double(im);
% im = (im - CLim(1) ) / (CLim(2) - CLim(1));
% im = max(im,0);
% im = min(im,1);
% im = TS_GammaFilt(im,g);

axh = imh.Parent;
% map = colormap(axh);
map = GammaData(NowChannels).map;
% imh.CData = ind2rgb(im,map);
%% colormap Chenge type
colormap(axh,Colormap_Gamma(map,g))
caxis(axh,CLim)
end






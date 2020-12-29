function varargout = TS_3dmipviewer(data,varargin)
%% TS_3dmipviewer(data,Reso)
% This function is basic GUI for creating new program.
%    Edit by Sugashi. 2016 July.
% 
% <For example...>
% load mri
% TS_3dslider(squeeze(D))
MaximumSiz = 512;
MinimumSiz = 64;
data = squeeze(data);
if or(ndims(squeeze(data))>4,ismatrix(data))
    error('Dim is NOT Correct')
end
narginchk(1,2)
if nargin==1
    Reso = ones(1,3);
else
    Reso = varargin{1};
end
ISlogical = false;

if ~strcmpi(class(data),'uint8')
    if islogical(data)
        ISlogical = true;
        data = uint8(data);
    else
        if ~strcmpi(class(data),'gpuArray')
            disp('Image 2 uint8....')
            data = TS_Image2uint8(data,'all');
        end
    end
end


fgh = figure('Posi',[50 324 500 500],...
    'toolbar','figure',...
    'Color','k');
if nargout ==1
    varargout{1} = fgh;
end
axh = axes('Unit','Normalized',...
    'Position',[0.05 0.05 0.9 0.85]);
apph = uicontrol('Unit','Normalized',...
    'BackgroundColor',[0.5 0.5 0.5],...
    'Position',[0 0.95 .15 0.04],...
    'String','Apply',...
    'Callback',@Callback_Apply);
txh = uicontrol('Style','text',...
    'unit','Normalized',...
    'Position',[0.16 0.95 0.15 0.03],...
    'String','Theta: 0 ');
txh(2) = uicontrol('Style','text',...
    'unit','Normalized',...
    'Position',[0.32 0.95 0.15 0.03],...
    'String','Fai: 0' );
setappdata(fgh,'axh',axh);
setappdata(fgh,'txh',txh);

%% Resize for slider
% im64 = TS_imresize3d(gather(data),[64 64 min([64 size(data,3)])]);
im64 = zeros([64 64 min([64 size(data,3)]) size(data,4)]);
for t = 1:size(data,4)
im64(:,:,:,t) = imresize3(gather(data(:,:,:,t)),[64 64 min([64 size(data,3)])]);
end
fov = (size(data)-1);
fov = fov(1:3) .*Reso;
siz64 = size(im64)-1;
Reso64 = fov./siz64(1:3);
setappdata(fgh,'im64',im64)
setappdata(fgh,'Reso64',Reso64)
setappdata(fgh,'islogical',ISlogical)

siz = size(data);
if max(siz(1:3))>MaximumSiz
    D = data;clear data
    for n = 1:size(D,4)
    data(:,:,:,n) = imresize3(D(:,:,:,n),MaximumSiz/max(siz(1:2)));
    end
end
siz = size(data)-1;
Reso = fov(1:3)./siz(1:3);





%% imagesc
if ISlogical
    A = TS_3DMIP_view3_bw(data,Reso,0,0);
else
    A = TS_3DMIP_view3(data,Reso,0,0);
end
imh = imagesc(rgbproj(squeeze(A)));
axis image off
colormap(gray(256))
drawnow
setappdata(fgh,'imh',imh);
setappdata(fgh,'data',data);
setappdata(fgh,'Reso',Reso);

%% add padding0
% fov2 = siz.^2;
% MaxTheta = real(asind(fov(1)/sqrt(sum(fov2(1:2)))))
% MaxFai = real(acosd(sqrt(sum(fov2(1:2)))/sqrt(sum(fov2(1:3)))))
% if islogical(data)
%     A = TS_3DMIP_view3_bw(data,Reso,MaxTheta,MaxFai);
% else
%     A = TS_3DMIP_view3(data,Reso,MaxTheta,MaxFai);
% end
MaxSizA = size(A);
setappdata(fgh,'MaximumSize',MaxSizA);
setappdata(fgh,'MaximumSize64',[]);


%%
% znum = size(data,3);
Theta = 360;
Fai = 180;
slh = uicontrol('Style','slider',...
    'Unit','Normalized',...
    'BackgroundColor',[0.5 0.5 0.5],...
    'Position',[0 0 .96 0.04],...
    'Value',0,...
    'SliderStep',[1/(Theta) 10/(Theta)],...
    'Callback',@Callback_slider,...
    'Userdata',Theta);
slh(2) = uicontrol('Style','slider',...
    'Unit','Normalized',...
    'BackgroundColor',[0.5 0.5 0.5],...
    'Position',[0.96 0.04 0.04 .96],...
    'Value',1,...
    'SliderStep',[1/(Fai) 10/(Fai)],...
    'Callback',@Callback_slider,...
    'Userdata',Fai);
setappdata(fgh,'slh',slh)

apph = uicontrol('Unit','Normalized',...
    'BackgroundColor',[0.5 0.5 0.5],...
    'Position',[0.65 0.95 .1 0.04],...
    'String','Save Pic.',...
    'Callback',@Callback_SavePic);


apph = uicontrol('Unit','Normalized',...
    'BackgroundColor',[0.5 0.5 0.5],...
    'Position',[0.8 0.95 .15 0.04],...
    'String','Make Movie',...
    'Callback',@Callback_MakeMovie);


end

%% slider
function Callback_slider(oh,~)
fgh = oh.Parent;
im64 = getappdata(fgh,'im64');
Reso64 = getappdata(fgh,'Reso64');
imh = getappdata(fgh,'imh');
MaxSiz = getappdata(fgh,'MaximumSize64');
txh = getappdata(fgh,'txh');
[Theta,Fai] = GetTheFai(fgh);
ISlogical = getappdata(fgh,'islogical');

if ISlogical
    A = rgbproj(squeeze( TS_3DMIP_view3_bw(im64>0,Reso64,Theta,Fai)));
else
    A =rgbproj(squeeze( TS_3DMIP_view3(im64,Reso64,Theta,Fai)));
end
if ~isempty(MaxSiz)
    [A,NewSiz] = TS_padding0(MaxSiz(1:2),A);
else
    NewSiz = size(A);
end
imh.CData = A;
setappdata(fgh,'MaximumSize64',NewSiz)
txh(1).String = ['Theta:'   num2str(Theta)];
txh(2).String = ['Fai:'   num2str(Fai)];
end

 % % Get rad.
function [Theta,Fai] = GetTheFai(fgh)
slh = getappdata(fgh,'slh');
Theta = uint16(round(get(slh(1),'Value')*get(slh(1),'Userdata')));
Fai = uint16(get(slh(2),'Userdata') - ...
    round(get(slh(2),'Value')*get(slh(2),'Userdata')));
end

%% Rendering High Resolution Image
function Callback_Apply(oh,~)
fgh = oh.Parent;
data = getappdata(fgh,'data');
Reso = getappdata(fgh,'Reso');
[Theta,Fai] = GetTheFai(fgh);
imh = getappdata(fgh,'imh');
MaxSiz = getappdata(fgh,'MaximumSize');
ISlogical = getappdata(fgh,'islogical');

if ISlogical
    A = squeeze( TS_3DMIP_view3_bw(data>0,Reso,Theta,Fai));
else
    A = squeeze( TS_3DMIP_view3(data,Reso,Theta,Fai));
end
if ndims(A) ==3
    A = rgbproj(A);
end


[A,NewSiz] = TS_padding0(MaxSiz(1:2),A);
imh.CData = A;
setappdata(fgh,'MaximumSize',NewSiz)
end

%% Save Picture
function Callback_SavePic(oh,~)
fgh = oh.Parent;
imh = getappdata(fgh,'imh');
prompt = {'File Name:','File Type:'};
defaltans = {'MyPicture','.tif'};
A = inputdlg(prompt,'Inpput Oputions',1,defaltans);
if isempty(A)
    return
end
if ismatrix(imh.CData)
    map = colormap(fgh);
    imwrite(imh.CData,map,[A{1} A{2}])
else
    imwrite(imh.CData,[A{1} A{2}])
end
end

%% Making Movierdata
function Callback_MakeMovie(oh,~)
fgh = oh.Parent;
Mov = getframe(fgh);
imh = getappdata(fgh,'imh');
data = getappdata(fgh,'data');
Reso = getappdata(fgh,'Reso');
[Theta,Fai] = GetTheFai(fgh);
%%% 
ind = 0:10:360;
Ind = [0 0 0 0 0 0 0 0 0 0  ind 0 0 ind 0 0 0 0 0 0 0];
FaiInd = [90:-10:0 repmat(0,[1 length(ind)]),...
    10 20 repmat(30,[1 length(ind)]) 40:10:90 90];
if length(Ind) ~= length(FaiInd)
    disp('erroroooooooo...')
    return
end
%%%
wh = waitbar(0,'wait ... ');
Siz = zeros(length(Ind),2);

for n = 1:length(Ind)
    if islogical(data)
        Mov(n).cdata= rgbproj(squeeze( TS_3DMIP_view3_bw(data,Reso,Ind(n),FaiInd(n))));
    else
        Mov(n).cdata = rgbproj(squeeze( TS_3DMIP_view3(data,Reso,Ind(n),FaiInd(n))));
    end
    if ismatrix(Mov(n).cdata)
        Mov(n).cdata = ind2rgb8(TS_Image2uint8(Mov(n).cdata),colormap(fgh));
    end

    [y,x,~] = size(Mov(n).cdata);
    imh.CData = Mov(n).cdata;
    drawnow
    Siz(n,:) = [y x];
    waitbar(n/length(Ind),wh,['wait ... ' num2str(n) '/' num2str(length(Ind))])
end

MaxSiz = max(Siz,1);
for n = 1:length(Ind)
    Mov(n).cdata = TS_padding0(MaxSiz,Mov(n).cdata);
    waitbar(n/length(Ind),wh,['Padding ... ' num2str(n) '/' num2str(length(Ind))])
end
Mov = [Mov(1) Mov(1) Mov(1) Mov(1) Mov(1) Mov];
close(wh)
checkLabels = {'Save Mov(struct) to variable named:'}; 
varNames = {'Mov'}; 
items = {Mov};
export2wsdlg(checkLabels,varNames,items,...
             'Save Movie data to Workspace');

%% last...         
slh = getappdata(fgh,'slh');
Callback_Apply(slh(1))
end


function Mov = TS_MovieMaker4dim(Image,varargin)
if ndims(Image)==3
    Image = reshape(Image,size(Image,1),size(Image,2),1,size(Image,3));
end

TFrgb = false;
if size(Image,3) == 3
    disp('input Image, rgb')
    TFrgb = true;
elseif or(size(Image,3)==2,size(Image,3) > 3)
    error('Input data Dim(3) is Not ''1'' !!')
end
MovTF = true;
if ~isstruct(Image)
if ismatrix(Image)
    error('Input is Matrix')
end
else
    Mov = Image;
    MovTF = false;
end

if nargin>1
    map = varargin{1};
else
    map = gray(256);
end

if MovTF
Image = TS_Image2uint8(Image,'all');
end
%% User Inter Face
%% input Type
STR = {'MPEG-4','Uncompressed AVI',...
    'Archival','Motion JPEG AVI',...
    'Motion JPEG 20000',...
    'Indexed AVI','Grayscale AVI'};
[s,v] = listdlg('PromptString','Select a file Type:',...
    'SelectionMode','single',...
    'ListString',STR);
if ~v
    return
end
STR = STR{s};
clear v s

%% Input Option
prompt = {'File Name:','Frame Rate:','Quality:'};
defaltans = {'MyMovie','30','75'};
A = inputdlg(prompt,'Inpput Oputions',1,defaltans);
if isempty(A)
    return
end
% keyboard
v = VideoWriter(A{1},STR);
v.FrameRate = eval(A{2});
% v. Quality = eval(A{3});

%% Normalize
if MovTF
Nchoice = questdlg('Automatic Normalize??','Normalize or Not');
switch lower(Nchoice)
    case 'yes'
        Type = 'auto';
        Image = TS_Image2uint8(single(Image));
    case 'no'
        prompt = {'Minimum','Maximum'};
        defaltans = {num2str(min(Image(:))),num2str(max(Image(:)))};
        A = inputdlg(prompt,'Inpput Color Limit',1,defaltans);
        Image = single(Image);
        Image = uint8((Image-eval(A{1}))/(eval(A{2}) - eval(A{1}))*255);
        Type = 'normal';
    case 'cancel'
        return
end

        

%% Make Video Struct
Mov(1:size(Image,4)) = struct('cdata',[],'colormap',[]);
if TFrgb
for n = 1:size(Image,4)
    Mov(n).cdata = Image(:,:,:,n);
end
else
for n = 1:size(Image,4)
    im = Image(:,:,:,n,:);
    if ismatrix(im)        
        Mov(n).cdata = im;
        Mov(n).colormap = map;
    else
        Mov(n).cdata = rgbproj(im,Type);        
    end    
end
end
end
%% open and write
open(v)
try
writeVideo(v,Mov)
catch err
    disp(err)
end
close(v)




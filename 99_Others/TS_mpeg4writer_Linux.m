function varargout = TS_mpeg4writer_Linux(Image,FPS,Fname)


tmpDir = '/mnt/NAS/SSD/ffmpegTMP/';
%% check IP address
[~,IP] = system('ip addr show | grep 192.168.2');
p = find(IP=='/');
IP = IP(p(1)-3:p(1)-1);
if nargout ==1
    varargout{1} = [tmpDir 'ffmpg' IP '_%4d.tif'];
    return
end

%% main


if or(ispc,ismac)
    error('This Function for Linux in NVU-Servers.')
end

if size(Image,4)==1
    error('Input Image has no FRAME data(size(Image,4)==1).')
end

if isempty(find(Fname==filesep))
    Fname = [pwd filesep Fname];
end
p = find(Fname =='.');
if ~strcmpi(Fname(p(end)+1:end),'mp4')
    error('input name is not correct....')
end
TF = dir(Fname);
if ~isempty(TF)
    error('Input File name already existed.')
end


%% Save all image to tiff
try
    fprintf('Tmp file write...')
    TS_WaiteProgress(0)
    for n = 1:size(Image,4)
        im = squeeze(Image(:,:,:,n,:));
        if ~and(strcmpi('uint8',class(im)),size(im,3))
            im = rgbproj(im);
        elseif size(im,3)==1
            im = rgbproj(im(:,:,[1 1 1]));
        end
        
        FullName = [tmpDir 'ffmpg' IP '_' TS_num2strNUMEL(n,4) '.tif'];
        imwrite(im,FullName)        
        TS_WaiteProgress(n/size(Image,4))
    end
    fprintf('Write to MP4...')
    system([...
        'ffmpeg ' ...
        ' -f image2'...
        ' -r ' num2str(FPS) ...
        ' -i ' tmpDir 'ffmpg' IP '_%4d.tif' ...
        ' -vcodec mpeg4 ' ...
        ' ' Fname])    
    %         ' -crf 30 '
catch err
    fprintf('\n')
    keyboard
    disp(err.message)    
end
try
    system(['rm ' tmpDir 'ffmpg' IP '*'])
catch err
end
end
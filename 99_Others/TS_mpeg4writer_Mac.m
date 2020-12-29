function varargout = TS_mpeg4writer_Mac(Image,FPS,Fname)


tmpDir = '/Users/leo/LeosMBP/';
%% check IP address
IP = '131';
if nargout ==1
    varargout{1} = [tmpDir 'ffmpg' IP '_%4d.tif'];
    return
end

%% main


if ~ismac
    error('This Function for Leo Macbook Pro.')
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
        '/usr/local/bin/ffmpeg ' ...
        ' -f image2'...
        ' -r ' num2str(FPS) ...
        ' -i ' tmpDir 'ffmpg' IP '_%4d.tif' ...
        ' -vcodec mpeg4 ' ...
%         ' -crf 30 '
        ' ' Fname])    
catch err
    fprintf('\n')
%     keyboard
    disp(err.message)    
end
try
    system(['rm ' tmpDir 'ffmpg' IP '*'])
catch err
end
end
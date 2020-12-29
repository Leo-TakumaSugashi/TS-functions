function TS_movie_comp
if ~ispc
    error('This function for Windows OS.')
end
[file,PATH] = uigetfile('.mp4');
v = VideoReader([PATH file]);
n = 1;
while exist([PATH file(1:end-4) '_' num2str(n) '.mp4'],'file')
    n = n + 1;
end
w = VideoWriter([PATH file(1:end-4) '_' num2str(n) '.mp4'],'MPEG-4');
% keyboard
% DataSiz = dir([PATH file]);
% Ratio = (DataSiz.bytes/2^20)/5;
% w.CompressionRatio = ceil(Ratio);
w.Quality = 0;

w.FrameRate = v.FrameRate;
Num = v.NumFrames;
open(w)
pause(1)

s = struct('cdata',[],'colormap',[]);

k = 1;
TS_WaiteProgress(0)
while hasFrame(v)
    s.cdata = readFrame(v);
    writeVideo(w,s)
    TS_WaiteProgress(k/Num)
    k = k+1;
end
fprintf('\n')
close(w)
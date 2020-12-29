function [Mov,vdata] = TS_VideoReader_proto(varargin)
[fn,Path] = uigetfile([pwd filesep '*.avi']);
CapFun = Capillaro_Functions;
[Mov,vdata] = CapFun.LoadVideo([Path fn],varargin{:});
% 
% v = VideoReader();
% Duration = v.Duration; % sec.
% FrameRate = v.FrameRate; %% Hz
% 
% num = ceil(Duration*FrameRate);
% Mov(1:num) = struct('cdata',[],'CurrentTime',[]);
% Mem = TS_checkmem('double') / 2^30;
% 
% n = 1;
% while and(hasFrame(v),Mem>MemLim)
%     if n > NumLimit
%         break
%     end
%     Mov(n).CurrentTime = v.CurrentTime;
%     Mov(n).cdata = readFrame(v);    
%     Mem = TS_checkmem('double') / 2^30;
%     n = n+1;
% end
% 
% while isempty(Mov(end).cdata)
%     Mov(end) = [];
% end
% 
% vdata = TS_classdef2structure(v);


    
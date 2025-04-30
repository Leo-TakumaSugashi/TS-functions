function FullPath = UIgetfile(varargin)
% FullPath = UIgetfile(varargin)
% [File,Path] = uigetfile(varargin{:});
% FullPath=fullfile(Path,File);
%
% Edit by Leo Sugashi.T.
[File,Path] = uigetfile(varargin{:});
FullPath=fullfile(Path,File);
function varargout = TS_LoadStackImgFiles(FullDir,ImType)
% varargout = TS_LoadStackImgFiles(FullDir,ImType)
% 
% This is an function of load stacking image files, from full path
% directory, and tyep of image files.
% 
%  example,...
%  FullDir = TS_ConvertOurNAS(...
%      '/mnt/NAS/Share4/00_Sugashi/10_Since2016/VOXX/Okawa_MRI');
%  ImType = '.tif';
%  TS_LoadStackImgFiles(FullDir,ImType)
% 
% see also, TS_ConvertOurNAS
% 
%  Edity LTS 2019 Sep. 21st

FindImg = dir([FullDir, filesep, '*', ImType]);
ImType(ImType=='.') = [];
if isempty(FindImg)
    return
end

%% sort Number of name
Numbers = zeros(1,length(FindImg));
for n = 1:length(FindImg)
    [L,Ma] = Isnumlabel(FindImg(n).name);
    Numbers(n) = str2double(FindImg(n).name(L==Ma));
end
[~,SortInd] = sort(Numbers);
FindImg = FindImg(SortInd);
%% stacking image


Mov(1:length(FindImg)) = struct('Image',[]);
Siz = zeros(length(FindImg),2);
for n = 1:length(FindImg)
    Mov(n).Image = imread(...
        [FindImg(n).folder filesep FindImg(n).name],ImType);
    
    [y,x,~] = size(Mov(n).Image);
    Siz(n,:) = [y x];
end


MaxSiz = max(Siz,1);
for n = 1:length(FindImg)
    Mov(n).Image = TS_padding0(MaxSiz,Mov(n).Image);    
end

if nargout == 0
    LastPosi = find(FullDir == filesep);
    Name = FullDir(LastPosi(end)+1:end);
    DimFive(cat(4,Mov.Image),Name)
elseif nargout >=1
    varargout{1} = cat(4,Mov(n).Image);
end
end

function [L,Ma] = Isnumlabel(STR)
X = nan(1,length(STR));
for n = 1:length(STR)
    X(n) = str2double(STR(n));
    if max(strcmpi(STR(n),{'i','j'}))
        X(n) = nan;
    end
end
[L,Ma] = bwlabel(~isnan(X));
end
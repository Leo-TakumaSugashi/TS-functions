function TS_addpath(name)
% TS_addpath(name)
% ディレクトリnameと
% その内部のフォルダー（直下階層すべて）のaddpath
%    Edition 2016 July 20th by Sugashi

DIR = dir(name);
addpath(name)
%% フォルダー内に何もなかったら返す
if length(DIR)<3
    return
end

%% フォルダーの参照とaddpathの繰り返し
for n = 3:length(DIR)
    if DIR(n).isdir
        Nowcd = cd;
        Name = [name '\' DIR(n).name];
        addpath(Name)
        disp(Name)
        cd(Name)
        TS_addpath(Name)
        cd(Nowcd)
    end
end


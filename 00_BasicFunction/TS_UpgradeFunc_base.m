function TS_UpgradeFunc_base(varargin)
%  This Program just function and fun my function... by Sugashi..2019 09 11
UrName = 'Sugashi Takuma';
if nargin ==1 
    UrName = varargin{1};
end
Sugashi_Function_Folder_CoreName = 'TSfun';
Sugashi_Old_Function_Folder = 'TS_Fun';
switch UrName
    case 'Sugashi Takuma'

        %% get New Sugashi Functions
        if ispc
            Parent = [filesep filesep '192.168.2.120' filesep 'ssd'];        
        elseif isunix
            if ismac
                Parent = '/Users/leo/Documents';
            else
                Parent = '/mnt/NAS/SSD';
            end
        end
        ExtraData = [Parent filesep 'TSmatdata'];
        Velocity_Capillaro = [Parent(1:end-3) filesep,...
            'Share2',filesep,'Capillaliy_Of_fingertip',filesep,'niizawa',filesep,'Function'];
    case 'tshome'
        Parent = '/mnt/RAIDs0/MatFunction';
end

%% common 
DIR = dir([Parent filesep Sugashi_Function_Folder_CoreName '*']);
if isempty(DIR)
    error('Need setting NAS. or Have some error about Network...')
else
    fprintf('\n\n\nFound below path.\n')    
end
%% get last days path
MyPathName = [];
for n = 1:length(DIR)
    if DIR(n).isdir
        MyPathName = genpath([Parent filesep DIR(n).name]);
    end
end

P = MyPathName;
if ispc
     p = find(P==';');
else
    p = find(P==':');
end
p = [0 p];
for n = 1:length(p)-1
    if contains(P(p(n)+1:p(n+1)-1),Sugashi_Function_Folder_CoreName)
        disp(['    ' P(p(n)+1:p(n+1)-1)])
    end
end
%% Remove Old Path
P = path;
if ispc
     p = find(P==';');
else
    p = find(P==':');
end
p = [0 p];
fprintf('Removing below path...\n')
for n = 1:length(p)-1
    if or(contains(P(p(n)+1:p(n+1)-1),Sugashi_Function_Folder_CoreName),...
            contains(P(p(n)+1:p(n+1)-1),Sugashi_Old_Function_Folder))        
        disp(['    ' P(p(n)+1:p(n+1)-1)])
        rmpath(P(p(n)+1:p(n+1)-1))
    end
end


%% Update
fprintf('\n\n Add New Path....\n')
addpath(MyPathName)

%% add Extra
addpath(ExtraData)
try
    addpath(Velocity_Capillaro)
catch err
    warning(err.message)
end

%% add ISOTT 2019 path
% x = TS_ISOTT2019_Fig_Script;
% rmpath(x)
% disp(['add path ISOTT2019 : ' x ])
% addpath(x)

%% add Python Tools
PyFun = TS_ConvertOurNAS('/mnt/NAS/SSD/Python');
if contains(path,PyFun)
    rmpath(PyFun)
end
disp(['add path Python functions : ' PyFun ])
addpath(PyFun)

%% Remove Backup
P = path;
if ispc
     p = find(P==';');
else
    p = find(P==':');
end
p = [0 p];
fprintf('Removing below Back up path...\n')
for n = 1:length(p)-1
    if contains(P(p(n)+1:p(n+1)-1),['20_Development' filesep 'Backup'])
        disp(['    ' P(p(n)+1:p(n+1)-1)])
        rmpath(P(p(n)+1:p(n+1)-1))
    end
end


%% Done
fprintf([mfilename '    ...Done.\n'])

%% Current Development Function, Script... add your memo.
fprintf('%% Current Development Function, Script...\n')
disp('TS_Shaving_Model_SEGID_v2019Alpha')
disp('TS_Deconv3D_GPU')
disp('TS_AutoAnalysisDiam_SEG_v2020Beta')
disp('Segment_Functions')
disp('See also TS_DeveloperMemo')
fprintf('\n\n')

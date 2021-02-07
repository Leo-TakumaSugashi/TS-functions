function TS_AnalysisMG_fromFindObjectList()
%  Script : TS_CreateHTML_script_sample.m
% global cData ObjListImage


%% initialize
SkipNum = 49;
SavePath = TS_ConvertNAS('\\192.168.2.120\share6\00_Sugashi\10_Since2016\13_MicroGlia');
[filename,Path] = uigetfile([TS_ConvertNAS('/mnt/NAS/SSD/TSmatdata')  '/*.mat']);
matData = [Path filesep filename];
% p = find(filename=='.');
Fname = filename(6:9); %% Name is "List_MG??_v?.mat"
checkName = input(['Input Dir. Name  [' Fname '?]   ' ],'s');
if ~isempty(checkName)
    Fname = checkName;
end
    
SaveDir = [SavePath filesep Fname];
if ~isempty(dir(SaveDir))
    warning('Input Dir Name is sleardigy Exisiting.')
    yn = input('Proceed ?? Yes or No ; ','s');
    if ~strcmpi(yn(1),'y')
        return
    end
end
load(matData)
if and(~exist('cData','var'),~exist('ObjListImage','var'))
    error('Loading File is failes')
end
mkdir(SaveDir)
%% day Fill
Days = cData{1,5};
for n = 1:size(cData,1)    
    Fullname = cData{n,2};
    if isempty(Fullname)
        continue
    end
    checkDays = cData{n,5};
    if ~isempty(checkDays)
        Days = checkDays;
    else
        cData{n,5} = Days;
    end
end

%% Save Image & Output Raw data to html
% % load Resolution of Microglia Ex.
load(TS_ConvertNAS('\\192.168.2.120\share6\00_Sugashi\10_Since2016\13_MicroGlia\MGReso.mat'))
% % Reso = [0.198 0.198 1];

cData =cat(2, cData,cell(size(cData,1),3));

for n = 1:size(ObjListImage,1)
    Fullname = cData{n,2};
    if isempty(Fullname)
        continue
    end
    try
        p = find(Fullname=='.');
        ex = Fullname(p(end)+1:end);
        %% load .lif , .oif, .mat files
        if n >= SkipNum
            switch ex
                case 'lif'
                    if n ~=1
                        if ~strcmp(Fullname,cData{n-1,2})
                            child = HKloadLif_vTS(TS_ConvertNAS(Fullname));
                        end
                    else
                        child = HKloadLif_vTS(TS_ConvertNAS(Fullname));
                    end
                    for k = 1:length(child)
                        if strcmp(child(k).Name,cData{n,3})
                            Image = child(k).Image;
                            Reso = child(k).Resolution(1:3);
                            break
                        end
                    end
                case 'oif'
                    child = TSloadOifv0(Fullname);
                    Image = child.Image(:,:,:,:,[2 1]);
                    Reso = child.Resolution(1:3);
                case 'mat'
                    child = TSLoadMat(Fullname);
                    for k = 1:length(child)
                        if strcmp(child(k).Name,cData{n,3})
                            Image = child(k).Image;
                            Reso = MGReso; %%  [0.198 0.198 1];
                            break
                        end
                    end

            end
        end

        %% make directory
        DirName = ['Ex' cData{n,5} '_Loc' cData{n,6}];
        DirName(DirName=='/') = '';
        addNum = 2;
        while ~isempty(dir([SaveDir filesep DirName]))
            if addNum ==2
                DirName = [DirName '_v2'];
            else                
                p = find(DirName=='v');
                DirName = [DirName(1:p(end)) num2str(addNum)];
            end
            addNum = addNum +1;
        end
%         mkdir([SaveDir filesep DirName])
        
        cData{n,end-2} =TS_ConvertNAS( [SaveDir filesep DirName],'Linux');
        vessDir = [SaveDir filesep DirName filesep 'Vessels'];
        cData{n,end-1} =TS_ConvertNAS(vessDir,'Linux');        
        
        gliaDir = [SaveDir filesep DirName filesep 'Glia'];
        cData{n,end} =TS_ConvertNAS(gliaDir,'Linux');
        
        mkdir([SaveDir filesep DirName])
        mkdir(vessDir)        
        mkdir(gliaDir)
    
        
        %% vessel analysis
        if n >= SkipNum
            Type = 'sp8';
            Info.FullPath = Fullname;
            Info.child = cData{n,3};
            STR = date;


            try 
                err = [];
                AutoVascularMeasurement_v2020A(Image(:,:,:,1,1),Reso,Type,vessDir,STR,Info)
            catch err
                save([vessDir filesep 'VesselsAnalysisError.mat'],'err')
            end

            %% Glia analysis        

        end
    catch Parent_err
        disp(Parent_err)
        save([SaveDir filesep 'cData_tmp.mat'],'cData')
        keyboard
    end
    
    fprintf(['\n ========================================' ...
        '\n      '  num2str(n) '/' num2str(size(cData,1)) ...
        '\n ========================================\n\n'])
end
save([SaveDir filesep 'cData.mat'],'cData')
end

function NewName = ReNameSTR(filename)
point = strfind(filename,'.lif');
if ~isempty(point),filename = filename(1:point-1);end
point = strfind(filename,'.oif');
if ~isempty(point),filename = filename(1:point-1);end

filename(filename=='-') = '_';
filename(filename=='.') = '_';
filename(filename=='%') = '';
filename(filename=='/') = '_';
filename(filename=='\') = '';
filename(filename=='"') = '';
filename(filename=='?') = '';
NewName = filename;
end

function NewSTR = AddBackSlash(STR)
p = find(STR=='\');
if isempty(p)
    NewSTR = STR;
    return
end
p = [p, length(STR)];
NewSTR = STR(1:p(1));
for n = 1:length(p)-1
    NewSTR = [ NewSTR '\' STR(p(n)+1:p(n+1))];
end
end











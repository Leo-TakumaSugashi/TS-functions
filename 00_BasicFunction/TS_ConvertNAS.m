function A = TS_ConvertNAS(FullDirName,varargin)
% A = TS_ConvertNAS(DirName,outputOS)
% \\192.168.2.120\...<==> /mnt/NAS/
% %% ==== example ====
% TS_ConvertNAS('\\192.168.2.120\SSD\DataSet\trained3DUNet\brainTumor3DUNetValid.mat','Linux')
% ans =
%     '/mnt/NAS/SSD/DataSet/trained3DUNet/brainTumor3DUNetValid.mat'
% 
% TS_ConvertNAS('/mnt/NAS/SSD/DataSet/trained3DUNet/brainTumor3DUNetValid.mat','Windows')
% ans =
%     '\\192.168.2.120\ssd\DataSet\trained3DUNet\brainTumor3DUNetValid.mat'
%
% 
%  * My Mac mounting on /Users/leo/NAS
% TS_ConvertNAS('\\192.168.2.120\ssd\DataSet\trained3DUNet\brainTumor3DUNetValid.mat','Mac')
% ans = 
%     '/Users/leo/NAS/SSD/DataSet/trained3DUNet/brainTumor3DUNetValid.mat'
%% itnitialize
global IP ParentList OldNameList DeleteList ConvertList
IP = '192.168.2.120';
ParentList ={'Share1','Share2','Share3','Share4','Share5','Share6','SSD','M2SSD'};
OldNameList = {'NewShare1','NewShare2'};
ConvertList = {'SSD','ssd';'M2SSD','m2ssd'};
DeleteList = {'Share12','ShareX',IP};
if nargin==1
    if ispc
        OutputOS = 'Windows';
    elseif ~ismac && isunix
        OutputOS = 'Linux';
    elseif ismac
        OutputOS = 'Mac';
    end
else
    OutputOS = varargin{1};
end
%% main
[celldata,InputOS] = Input2Cell(FullDirName);
celldata = DeletePreNAS(celldata,InputOS);
celldata = DeleteCellFromList(celldata);
A = ConvertOS(celldata,OutputOS);
%% functions (Input 2 cell ~ output for OS)
    function [CC,InputOS] = Input2Cell(str)
        fs = '/';
        ind = find(str==fs);
        if isempty(ind)
            fs = '\';
            ind = find(str==fs);
        end
        if str(ind(2))=='\' % \\192.168.?.?\..... Windows
            InputOS = 'Windows';
            str(1:2) = '';
        else
            FirstDir = str(ind(1)+1:ind(2)-1);
            if strcmp(FirstDir,'mnt')
                InputOS = 'Linux';
            elseif strcmp(FirstDir,'Users')
                InputOS = 'Mac';
            else
                error('InputOS is Unknow or Unknown Full Path file')
            end
            str(1) = '';
        end
        CC = cell(1,1);
        c = 1;
        while ~isempty(str)
            p = find(str==fs);
            if isempty(p)
                CC{c,1} = STR_UpperConvert( str(1:end) );
                str = [];
            else
                CC{c,1} = STR_UpperConvert( str(1:p(1)-1 ));
                str(1:p(1)) = '';
            end
            c = c + 1;
        end
    end
    function A = STR_UpperConvert(str)
        if max(strcmp(ConvertList(:,2),str))
            A = upper(str);
        elseif max(strcmpi(ParentList,str))
            str(1) = upper(str(1));
            A = str;
        else
            A = str;
        end
    end
    function A = STR_lowerConvert(str)
        if max(strcmp(ConvertList(:,1),str))
            A = lower(str);
        else
            A = str;
        end
    end
    function celldata = DeletePreNAS(CC,InputOS)
        DelInd = [];
        for n = 1:size(CC,1)
            if strcmp(InputOS,'Windows')
                if strcmp(CC{n,1},IP)
                    break
                else
                    DelInd = [DelInd n];
                end
            else
                if max(strcmpi(CC{n,1},[ParentList OldNameList]))
                    if max(strcmpi(CC{n,1},OldNameList))
                        CC{n,1}(1:3) = '';
                    end
                    break
                else
                    DelInd = [DelInd n];
                end
            end
        end
        CC(DelInd,:) = [];
        celldata = CC;
    end
    function celldata = DeleteCellFromList(CC)
        Ind = false(size(CC));
        for n = 1:size(CC,1)
            if max(strcmp(CC{n,1},DeleteList))
                Ind(n) = true;
            end
        end
        celldata = CC(~Ind,:);
    end
    function str = ConvertOS(CC,OS)        
        switch OS
            case 'Windows'
                str = ['\\' IP ];
                fs = '\';
            case 'Linux'
                str = '/mnt/NAS';
                fs = '/';
            case 'Mac'
                str = '/Users/leo/NAS'; %%%<--- if you have mac. checnage here.
                fs ='/';
            otherwise
                error('Output OS is not Correct.')
        end
        switch OS
            case 'Windows'
                for n = 1:size(CC,1)
                    str = [str fs STR_lowerConvert(CC{n,1}) ];
                end
            case {'Linux','Mac'}
                for n = 1:size(CC,1)
                    str = [str fs STR_UpperConvert(CC{n,1}) ];
                end
        end
    end
end
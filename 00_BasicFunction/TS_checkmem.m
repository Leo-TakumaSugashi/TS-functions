function varargout =  TS_checkmem(varargin)


if nargin==1
    Th = varargin{1};
else
    Th = 1.0;
end

if ispc
    [~,a] = memory;
    Usable = round(a.PhysicalMemory.Available/2^30*10)/10 ;
    Total = a.PhysicalMemory.Total/2^30;
elseif isunix
    if ismac
%         [dummy,a] = system('vm_stat -c 1'); % for OS X
        
        if nargout==0
            [~, top]=system('top -l 1');
            cc = cell(1,1);
            ind = 1;
            c = 1;
            checktf = true;
            while checktf
                if strcmp(top(c),newline)
                    strings = top(1:c-1);
                    STR= [];
                    for n = 1:length(strings)
                        if strcmp(strings(n),'%')
                            STR = [STR strings(n) '%'];
                        else
                            STR = [STR strings(n)];
                        end
                    end
                    cc{ind,1} = STR;
                    top(1:c) = '';
                    ind = ind + 1;
                    c = 1;
                else
                    c = c + 1;
                end
                if ind ==10
                    checktf = false;
                end
            end
            str = [];
            for n = 1:size(cc,1)
                str = [str cc{n,1} '\n'];
            end
            fprintf(str)
            return
        else
            [~, cmdout]=system('top -l 1 |grep Phys');
        end
        Numbers = TS_isnumFromString(cmdout);
        
        [L,MaxN] = bwlabel(~isnan(Numbers));
        p = find(L==MaxN);
        FreeSpace = str2double(cmdout(p));
        Units = cmdout(p(end)+1);
        Usable = ConvertUnits(Units,FreeSpace)/2^30;
        
        p = find(L==1);
        UsedSpace = str2double(cmdout(p));
        Units = cmdout(p(end)+1);
        U = ConvertUnits(Units,UsedSpace)/2^30;
        Total = U + Usable;
        
%         warning('This func is not correct working on OS X.')
%         Total = 16;
%         Usable = 0;
    else
        
        [dummy,a] = system('free -b| grep Mem'); % for linux
        if nargout==0
            fprintf(a)
            return
        end
        p = a == ' ';
        label_p = bwlabel(~p);
    %     Used = str2double(a(label_p == 3)) / 2^20;
        Total = str2double(a(label_p == 2))/ 2^30;
        Usable = str2double(a(label_p == 7)) / 2^30;
    end
end

if strcmp(Th,'double')
    varargout{1} = Usable * 2^30;
    return
end
if nargout == 1
    varargout{1} = [num2str(Usable) 'GB'];    
elseif nargout ==2 %% For xyztviewer
    varargout{1} = Usable / Total * 100;
    varargout{2} = [num2str(Usable) '/' num2str(round(Total*10)/10) ' [Gibi Byte]'];
else
    disp(['Now usavle memory:  ' num2str(Usable) ' Gibi Byte.'])
end

if ischar(Th)
    return
end
if (Usable < Th)
    STR = {['Now usavle memory:  ' num2str(Usable) ' Gibi byte.'];
        'Continue...'};
    fgh = msgbox(STR);
%     waitfor(fgh)   
end
end

function output = ConvertUnits(Units,FreeSpace)
    switch lower(Units)
        case 'k'
            FreeSpace = FreeSpace * 2^10;
        case 'm'
            FreeSpace = FreeSpace * 2^20;
        case 'g'
            FreeSpace = FreeSpace * 2^30;
        case 't'
            FreeSpace = FreeSpace * 2^40;
    end
    output = FreeSpace;
end
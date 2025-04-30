function CC = TSreadCSV(FullPath)

fid = fopen(FullPath);
[filename, permission, machineformat, encoding] = fopen(fid);
% disp(filename)
% disp(['permission : ' permission ])
% disp(['encoding   : ' encoding ])
 if strcmp(encoding,'UTF-16LE') && ~ismac
     skip = 1;
 else
     skip = 0;
 end
[str,count] = fread(fid,inf,'*char',skip,machineformat);
fclose(fid);
[CC,pnum] = String2Celldata(str,count);
end

function [CC,paramcount]=String2Celldata(str,count)
CC = cell(1,1);
c = 1;
paramcount = 0;
stringline = [];

for n = 1:count
    if strcmp(str(n),newline)
        if stringline(end)==','
            stringline(end)='';
        end
        CC{c,1} = stringline;
        stringline = [];
        c = c + 1;
    else
        stringline = [stringline, str(n)];
    end
end
end

function imginfo = TSreadOlympusImageFormat(FullPath)

[fid,msg] = fopen(FullPath,'r','n','UTF-8');
skip = 1;
disp(msg)

    
[filename, permission, machineformat, encoding] = fopen(fid);
% disp(filename)
% disp(['permission : ' permission ])
% disp(['encoding   : ' encoding ])
%  if strcmp(encoding,'UTF-16LE') && ~ismac
%      skip = 1;
%  else
%      skip = 0;
%  end
 
[str,count] = fread(fid,inf,'*char',skip,machineformat);
% [str,count] = fread(fid,inf,'*char',skip);
fclose(fid);
[CC,pnum] = String2Celldata(str,count);
imginfo = Celldata2imginfo(CC,pnum);
end

function imginfo = Celldata2imginfo(CC,pnum)
imginfo = cell(pnum,2);
p = 1;
childcc = [];
for n = 1:size(CC,1)
    if contains(CC{n,1},'[')
        imginfo{p,1} = CC{n,1}(1:end-1);
        childcc = [];
    elseif contains(CC{n,1},'=')
        Char = CC{n,1};
        ind = find(Char=='=');
        cc = cell(1,2);
        cc{1,1} = Char(1:ind-1);
        cc{1,2} = Char(ind+1:end-1);
        childcc = cat(1,childcc,cc);
    end
    if n < size(CC,1)
        if contains(CC{n+1},'[')
            imginfo{p,2} = childcc;
            p = p + 1;
        end
    else
        imginfo{p,2} = childcc;
    end
end
% % sort Sequential Group
ind = nan(size(imginfo,1),1);
for n = 1:size(imginfo,1)
    if contains(imginfo{n,1},'Sequential Group')
        strings = imginfo{n,1};
        numericind = ~isnan(Isnumfromstring(strings));
        ind(n) = str2double(strings(numericind));
    end
end

if min(isnan(ind))
    return
end
OriginalInd = find(~isnan(ind));
[~,sortind] = sort(ind(~isnan(ind)));
Copy = imginfo(OriginalInd,:);
for n = 1:length(sortind)
    imginfo(OriginalInd(n),:) = Copy(sortind(n),:);
end
end

function [CC,paramcount]=String2Celldata(str,count)
CC = cell(1,1);
c = 1;
paramcount = 0;
stringline = [];

for n = 1:count
    if strcmp(str(n),'[')
        paramcount = paramcount + 1;
    end
    if strcmp(str(n),newline)
        if isempty( stringline )
            continue
        else
            CC{c,1} = stringline;
            stringline = [];
            c = c + 1;
        end
    else
        stringline = [stringline, str(n)];
    end
end
end

% ======= ======== ===========
function ISLabel = Isnumfromstring(STR)
ISLabel = nan(size(STR));
for n = 1:length(STR)
    ISLabel(n) = str2double(STR(n));
end
ISLabel(imag(ISLabel)==1) = nan;
ISLabel = real(ISLabel);
end
function printlist(data)
% printlist(data)
% display ([ index  : data.Name  : size(data.Image)]_
% 
%  just look up data quick. by Sugashi


if ~isstruct(data)
    return
end

CC = cell(length(data),3);
for n = 1:length(data)
    CC{n,1} = n;
    CC{n,2} = data(n).Name;
    CC{n,3} = size(data(n).Image,1:5);
end
ind1 = length(num2str(length(data)));
ind2 = 1;
for n = 1:length(data)
    ind2 = max(ind2,length(CC{n,2}));
end
for n = 1:length(data)
    fprintf(NumAdd(num2str(CC{n,1}),ind1+1,'pre'))
    fprintf(' : ')
    fprintf(NumAdd(CC{n,2},ind2,'post'))
    fprintf(' = ')
    fprintf([num2str(CC{n,3},'[%.0f, %.0f, %.0f, %.0f, %.0f]') '\n'])
end
end
function STR = NumAdd(str,ind,dir)
STR= str;
if strcmpi(dir,'pre')
    for n = 1:(ind-length(str))
        STR = [' ' STR];
    end
else
    for n = 1:(ind-length(str))
        STR = [STR ' '];
    end
end
end
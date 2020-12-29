function Whos_byte(varargin)
% CUI function  "Whos_byte"
% 
%  ==== usage ====
%  Whos_byte
%  Whos_byte(whos)
%  Whos_byte(whos,'sort')
%  Whos_byte(whos('variable workspace values',...),...)

 
if nargin == 0
    a = evalin('base','whos');
else
    a = varargin{1};
end
fprintf('================================================================================\n')
MaximumName = 0;
for n = 1:length(a)
    MaximumName = max(MaximumName,length(a(n).name));
end
MaximumName = MaximumName +1;
Type = 'sort';
if nargin==2
    Type = varargin{2};
end
switch lower(Type)
    case {'bytes','sort'}
        Byte = cat(1,a.bytes);
        [~,ind] = sort(Byte,'descend');
        a = a(ind);
    otherwise

end

for n = 1:length(a)
    fprintf('    ')
    fprintf(a(n).name)
    if length(a(n).name)<MaximumName
        for k = 1:MaximumName - length(a(n).name)
            if IsOdd(n)
                fprintf(' ')
            else
                fprintf('-')
            end
        end        
    else
        fprintf(' ')        
    end
    if a(n).bytes < 2^10
        STR = num2str(a(n).bytes,'%.1f');
        UNITS = ' Bytes';        
    elseif a(n).bytes < 2^20
        STR = num2str(a(n).bytes/2^10,'%.1f');
        UNITS = ' KiB  ';
    elseif a(n).bytes < 2^30
        STR = num2str(a(n).bytes/2^20,'%.1f');
        UNITS = ' MiB  ';        
    else
        STR = num2str(a(n).bytes/2^30,'%.1f');
        UNITS = ' GiB  ';        
    end
    for k =1 :8-length(STR)
        if IsOdd(n)
            fprintf(' ')
        else
            fprintf('-')
        end
    end
    SizeString = num2str(a(n).size,'x%d');
    SizeString(SizeString==' ') = '';
    fprintf([STR UNITS ' ...' SizeString(2:end) ' '  a(n).class '\n'])
end
All = sum(cat(1,a.bytes))/2^30;
fprintf('    ')
for n = 1:MaximumName
    fprintf('-')
end
fprintf('--------------\n')
% for n = 1:MaximumName
%     fprintf(' ')
% end
fprintf(['    Total : ' num2str(All,'%.2f') ' Gibi Bytes \n'])
fprintf('================================================================================\n')

function [Sumation,STR] = TS_GetDirByte(varargin)
% Edition 2016 Augast 29th by Sugashi
%  Exist BAG .........
% Edit , modify 2019 9 12, by Sugashi
if nargin ~= 0 
    dirname = varargin{1};
    if isempty(dirname)
        dirname = pwd;
    end        
else
    dirname = pwd;
end
DIR = dir(dirname);
%% Initialize
Sumation = 0;
ChildNum = 0;
STR = '';
Type = 'dir';
MaximumLength = 50;

%% check Dir.
if length(DIR)<3
    return
end
DIR(1:2) = [];
DIR = flip(DIR,1);
isDirInd = cat(1,DIR.isdir);
DIR = cat(1,DIR(isDirInd),DIR(~isDirInd));
%% main func.
DataByteG = sum(cat(1,DIR.bytes));

if nargin>=2
    Type = varargin{2};
    if ~max(strcmpi(Type,{'folder','dir','file','all'}))
        error('Input type is no correct')
    end
end
if nargin>=3
    Sumation = varargin{3};    
end
if nargin >=4    
    ChildNum = varargin{4};    
end
if nargin >=5
    STR = varargin{5};
end
Sumation = Sumation + DataByteG;
 % % % % loop inside % % % %
Sumation_cat = zeros(1,length(DIR));
for n = length(DIR):-1:1    
    if and(DIR(n).isdir,max(strcmpi(Type,{'folder','dir','all'})))
        Name = [dirname filesep DIR(n).name];
        try
            [S,STR] = TS_GetDirByte(Name,Type,0,ChildNum+1,STR);            
        catch err
            disp(err.message)
            S = 0;
            STR = '';
            warning(Name)
        end
        Sumation_cat(n) = S;
    end
    if max(strcmpi(Type,{'file','all'}))        
        FrontSTR = [' ' repmat('|   ',[1 ChildNum+1]) '|---'   filesep DIR(n).name ' : '];       
        [I,A,B] = byte2KMG(Sumation,MaximumLength - length(FrontSTR));
        STR = [FrontSTR I num2str(A,'%.1f') ' ' B '\n' STR];
    end
end
%% output
Sumation = sum(Sumation_cat) + Sumation;
FrontSTR = [' ' repmat('|   ',[1 ChildNum]) '|+--'];
p = find(dirname==filesep);
STRrep = dirname(p(end):end);
Front = [FrontSTR  STRrep ' : '];
[I,A,B] = byte2KMG(Sumation,MaximumLength - length(Front));
STR = [Front I num2str(A,'%.1f') ' ' B '\n' STR];
if ChildNum == 0    
    fprintf(STR)
    fprintf(['\n' dirname '\n    '...
        num2str(Sumation) ' Bytes.\n    '...
        num2str(Sumation/2^10) ' KiBytes.\n    '...
        num2str(Sumation/2^20) ' MiBytes.\n    '...
        num2str(Sumation/2^30) ' GiBytes.\n    '...
        num2str(Sumation/2^40) ' TiBytes.\n    ..\n'])
end
% if nargout>0
%     varargout{1} = Sumation;
% end
% if nargout>1
%     varargout{2} = STR;
% end

end

function [I,A,B] = byte2KMG(S,len)
    I = repmat('-',[1,len]);
    if S > 2^30
        A = S/2^30;
        B = 'GiB ***';
    elseif S > 2^20
        A = S/2^20;
        B = 'MiB';
    elseif S > 2^10
        A = S/2^10;
        B = 'KiB';
    else
        A = S;
        B = ' B';    
    end
end
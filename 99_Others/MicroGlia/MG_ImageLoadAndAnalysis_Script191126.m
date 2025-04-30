List = [];
Promoter = [];
Loc = [];
c = 1;
%% Saline %
for n = 52:60
    List{c} = ['MG' num2str(n)];
    c = c + 1;    
end
%% PLX
for n = 63:66
    List{c} = ['MG' num2str(n)];
end
Parent = '\\192.168.2.120\share4\soga\Experimentdata\MAT';    
N = dir([Parent filesep 'MG*'])
ISDIR = cat(1,N.isdir);
N = N(ISDIR);
for n = 1:length(N)
    disp([num2str(n) '  ' N(n).name])
end
%% create List
List = [];
c = 1;

for n = 1:length(N);
    p = find(N(n).name =='(');
    if isempty(p)
        continue
    end
    Type = N(n).name(p+1);
    List(c).FULLPATH = [Parent filesep N(n).name];
    List(c).Name = N(n).name(1:p-1);
    switch lower(Type)
        case 's'
            List(c).Type = 'Saline';
        case 'm'            
            List(c).Type = 'Minocyclyne';
        case 'p'
            List(c).Type = 'PLX';
    end
    c = c + 1;
end
for n = 1:length(List)
%     disp([List(n).Name '_' List(n).Type])
    disp(List(n).FULLPATH)
end
%% TIME check
clc
for n = 1:length(List)
    N = dir(List(n).FULLPATH);
    N = N(cat(1,N.isdir));
    disp('  ')
    disp([List(n).Name '_' List(n).Type])
    for k = 3:length(N)
        disp([ num2str(k) '  ' N(k).name])
    end
end
%%
List(1).Number = [3 6 7 9];
List(1).Day = [0 7 14 21];

List(2).Number = [3 5 6 9];
List(2).Day = [0 7 14 21];

List(3).Number = [4 5 7 10];
List(3).Day = [0 7 14 21];
%MG54
List(4).Number = [5 6 7];
List(4).Day = [0 7 14];
%MG55
List(5).Number = [5 6 7 9];
List(5).Day = [0 7 14 21];
%MG56
List(6).Number = [4 5 6 8];
List(6).Day = [0 7 14 21];
%MG57
List(7).Number = [14 13 7 12];
List(7).Day = [0 7 14 21];
%MG58
List(8).Number = [14 13 9 12];
List(8).Day = [0 7 14 21];
%MG59
List(9).Number = [7 5];
List(9).Day = [0 14 ];
%MG60
List(10).Number = [5 4 3];
List(10).Day = [0 7 14];
%MG63
List(11).Number = [5 7 4];
List(11).Day = [0 7 14];
%MG64
List(12).Number = [5 6 4];
List(12).Day = [0 7 14];
%MG65
List(13).Number = [3 6 4 ];
List(13).Day = [0 7 14];
%MG66
List(14).Number = [4 3 5];
List(14).Day = [0 7 14];

%% roi check
for n = 13 %9:length(List)
    N = dir(List(n).FULLPATH);
    N = N(cat(1,N.isdir));
    if length(List(n).Number) ~= length(List(n).Day)
        n
        k
        keyboard
    end
    % % TIME
    for k = 3:length(List(n).Number)
        List(n).TIME(k).Path = N(List(n).Number(k)).name;
        List(n).TIME(k).CurrentDay = List(n).Day(k);
        Nroi = dir([List(n).FULLPATH filesep List(n).TIME(k).Path ...
            filesep 'roi_loc*.mat']);
        clear Num
        for x = 1:length(Nroi)
            Num(x) = eval(Nroi(x).name(8));
        end
        
        
        
        clear Nloc NC
%         for loc = 1:length(Num)
%             Nloc = dir([List(n).FULLPATH filesep List(n).TIME(k).Path ...
%             filesep 'loc' num2str(Num(loc))  '*.mat']);            
%             if isempty(Nloc)
%                 Nloc = dir([List(n).FULLPATH filesep List(n).TIME(k).Path ...
%                     filesep 'Loc' num2str(loc)  '*.mat']);
%                 if isempty(Nloc)
%                     continue
%                 end
%             end
%             for checklen = 1:length(Nloc)
%                 Len(checklen) = length(Nloc(checklen).name);
%             end
%             [~,ind] = min(Len);
%             clear Len
%             NC(loc).name = Nloc(ind).name;
%         end        
        NC = dir([List(n).FULLPATH filesep List(n).TIME(k).Path filesep 'loc*.mat']);
        if isempty(NC)
            disp(List(n).TIME(k).Path)
            keyboard
        end
        
        if and(n == 13 ,k==3)
             NC = NC([1 5 end-3]);
        end
        if and(n == 14 ,k==1)
             NC = NC([1 4 end-2]);
        end
%         if and(n == 14 ,k==3)
%              NC = NC([1 4 end-2]);
%         end
        if length(NC)>length(Nroi)
            for x = 1:length(NC)
                TF(x) = length(NC(x).name) ==8;
            end
            NC = NC(TF);
            clear TF
        end
       if or(length(NC) ~= length(Nroi),isempty(NC))
           n
           k
           disp(List(n).TIME(k).Path)
           keyboard
       end 
       % % location
       for lc = 1:length(Nroi)
           List(n).TIME(k).Location(lc).ImagePath = NC(lc).name;
           List(n).TIME(k).Location(lc).roiPath = Nroi(lc).name;
           List(n).TIME(k).Location(lc).LocNumber = Num(lc);
       end
    end
end
       
%% check
c = 1;
for n = 1:length(List)
    % % TIME
    Path = List(n).FULLPATH;
    for k = 1:length(List(n).TIME)
       % % location
       PPath = List(n).TIME(k).Path;       
       for lc = 1:length(List(n).TIME(k).Location)
           PPPath = List(n).TIME(k).Location(lc).ImagePath;
           disp([num2str(n) ' ' Path '\' PPath '\' PPPath])
           c = c + 1;
       end
    end
end
disp(num2str(c))


















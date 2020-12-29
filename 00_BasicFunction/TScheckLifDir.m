function STR = TScheckLifDir(DIR,varargin)

%% main 

Original = cd;
if nargin==1
    STR = {TS_ClockDisp};
else
    STR = varargin{1};
end
cd(DIR)
Lif = dir('*.lif');
str0 = [' Directory : ' cd];
disp(str0)
STR = cat(1,STR,str0);
for n = 1:length(Lif)
    disp(['   ' Lif(n).name ])
    try        
        data = TSloadLifverXYZTViewerROI(Lif(n).name);
        data = TSresetdata(data);
        for k = 1:length(data)
            str1 = ['No.' num2str(k) ' Name:' data(k).Name ];
            str2 = ['   FOV:  ' num2str(abs(data(k).FOV*10^6)) ];
            str3 = ['   pix:  ' num2str(data(k).Size)];
            
            disp(str1)
            disp(str2)
            disp(str3)
            STR = cat(1,STR,str1,str2,str3);
            
        end
    catch err
        str_e1 = '**** Error ****';
        str_e2 = err.message;
        disp(str_e1)
        disp(str_e2)
        
        STR = cat(1,STR,str_e1,str_e2);
    end
    clear data
end


%% loop 
Dir = dir;
Dir(1:2) = [];
Pdir = cd;
for n = 1:length(Dir)
    cd(Pdir)
    if Dir(n).isdir
        STR = TScheckLifDir(Dir(n).name,STR);
    end
end
cd(Original)
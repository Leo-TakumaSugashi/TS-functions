function STR = TS_CreateHTML_fromFindObjectList(SavePath)
%  Script : TS_CreateHTML_script_sample.m
% global cData ObjListImage

%% initialize
[filename,Path] = uigetfile([TS_ConvertNAS('/mnt/NAS/SSD/TSmatdata')  '/*.mat']);
matData = [Path filesep filename];
p = find(filename=='.');
Fname = filename(1:p(end)-1);
% Fname = input('Input Dir. Name ' ,'s');
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
mkdir([SaveDir filesep 'img'])
%% Save Image & Output Raw data to html
STR = ['<!DOCTYPE HTML> \n'...
    '<HTML>\n',...
    '<head>\n',...
	'    <title> Raw data output : "'   Fname   '"...</title>\n',...
	'	     <meta http-equiv="Content-Type" content="text/html; charset=utf-8">\n',...
    '</head>\n',...
    '<body>\n\n',...
    '	<p><font size="+5">  Raw data output : "' Fname '"... </font></p>\n'];
STR = [STR '    <font size="+0">\n'];
TS_WaiteProgress(0)
for n =1:size(ObjListImage,1)
    Image = ObjListImage{n,1};
    if isempty(Image)
        Image = zeros(128,128,3,'like',uint8(1));
    else
        v = TS_Circmedfilt(Image(:,:,:,:,1),2);
        g = TS_Circmedfilt(Image(:,:,:,:,2),1);
        Image = cat(5,v,g);
        Image = nanmean(Image,4);
        Image = squeeze(max(Image,[],3));
        try
            Image = rgbproj(Image);
        catch err
            disp(err.message)
            
            Image = zeros(128,128,3,'like',uint8(1));
            keyboard
        end
    end
    Name = [cData{n,2} ,'_', cData{n,3} ,'_',cData{n,6} ,'_',cData{n,7} ,'_',cData{n,8} ,'_',cData{n,9} ,'_',cData{n,10}];
    Name = ReNameSTR(Name);
    Name = [TS_num2strNUMEL(n,3) '_' Name];
    imgName = [SaveDir filesep 'img' filesep Name '.jpg'];
    try
    imwrite(Image,imgName)
    catch err
        keyboard
    end
     
    STR = [STR ,...
        '    <br><p> Path : ' AddBackSlash( cData{n,2} ) '\n',...
        '    <br><b> child : '  AddBackSlash( cData{n,3} ) '</b>\n',...
        '    <br>  Loc.  : ' cData{n,6} '\n',...
        '    <br>  Memo: '  cat(2,cData{n,7:end}) '\n',...
        '    <br><img src="./img/' Name '.jpg" width="800"></img><br></p>\n\n\n'];
    clear Name imgName Image v g
    TS_WaiteProgress(n/size(ObjListImage,1))
    
end
  
STR = [STR '    </font>\n\n<body>\n\n</HTML>'];
% fprintf(STR)
%% Write 
fid = fopen([SaveDir filesep 'RawDataHTML.html'],'w');
fprintf(fid,STR);
fclose(fid)

%% memo
T = cell2table(cData');
writetable(T,[SaveDir filesep 'memo.csv'])

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










